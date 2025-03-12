Return-Path: <linux-kernel+bounces-558293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BACA5E3F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE987A4714
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102DB2580C0;
	Wed, 12 Mar 2025 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjvPzLXo"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D959C257AE4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741805864; cv=none; b=hX92tHFAPBEmOMDLPgD3su163q4r6epucGP9MGMqlWjBHUXjEvx6k05Y5wnQRGBDdbW1OYrcMa6Cw7xRk2n/jhxmJopFeRoZTPzGnaNoDpGsHfND3n6DRFrJwPCaHl076+aazEqNBpdgC1X1ERgFT9x7RvlNJDLXwDiftpW7Ar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741805864; c=relaxed/simple;
	bh=Rv49Ha/ZvJUbKiu/++T2g80WuU1VQL0NluqmATtqT8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZvVHxVZ4WZr8GgPsEfHMhHv2vI1vs9HZjYs6Y20tI6tptJZumiRb+ulDzJ6opMr60zB1b7ezbbFCmz+LB6MxIb3esPImaE0fTIgAdURX3seXJ1O5aEmsGTERpM5lAbrvyUNedhKXa2diFW9u1+7F1Vx57cYw57j+Zy9gOXdiBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjvPzLXo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso752525e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741805861; x=1742410661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULYqbjLMLkGIT27EXJx34jr7z9q8otSc76SDI5vWuMI=;
        b=ZjvPzLXo0H47Sp0cvYjVmrPwAQO41HDwh5Ns2thsbsDh2bNYjeXdyUoVBDkJob4fab
         xanX1E8CfsxIPFGpf9st2fORrx8dtwTsrRG+HlWS6dnELvsb7EUgo3k0rbhWVF7EE4X2
         DJUR+U06+vc83cxgmPQD/4t1L+2bX4EqrXy9tuOWtdPBbhHaKcF94+61PsXTKh03uTWj
         Pt5PbKabL0nRnVD6rg+zWyniJ7p4Rb+jAYGv0cT0i79atKI+NBtAFXMgfxs1ZjWuoadN
         APk/PBQa1jxMO0qArBTFSxW9iusxriMr6ZsbGbLqDZvacA2XC0KjBWW72rTszyYal/ZP
         T6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741805861; x=1742410661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULYqbjLMLkGIT27EXJx34jr7z9q8otSc76SDI5vWuMI=;
        b=jmD3X9cM+ZPlGolLzuH7Tes5dqu1zSm8UFhlxoNWNiczKZhiPq2T5zTla7MLqNykKv
         RVvKTP5IXr6X/OAnXaWuN3TE8Tc3TSg4KPvxco5xHZGYzjUBvoqp9dxRoTYwhmOjAWVf
         wIh2bUpod4RYY5505xDJ7NrdOwDLx5QUH9wIWOpz1F1wZvxtS7HH184r08uXzzqFuYrM
         oWNSsjcAVeNw21InPPTTuxHW8wB7+5nQ6xqogC6YVPfvSAk2n3eiWPir5lVo4Xmm62qg
         QQbYCcXINno7K0siSvRPzgju8w3nOMMiLajxd0Jb5Ar62cuPQSrXB7EZl6zdbo4IGvKG
         ER5A==
X-Forwarded-Encrypted: i=1; AJvYcCXbe1IfEviYbOxsPGIZ3Kk0Tbn34bNlfKUdsLR0+WFZ/j9fsLGiJK2jDbB4pLenD69r2eYNCCwUVbs12tM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+7trTaYNrxuTopjbOziduMMOdPEKFytNi2bxDj367oo9nKFxy
	bqfFebL63FpaU5dYKTZKPTGjjcYzPa1M2vDCzwhbeOGlD5UgCLmk
X-Gm-Gg: ASbGncs+sBFbkriic3VAuGjPRnjLMhyi2nNUHmMU2fSj0SX86Q+ek9TwYvFLnrg4q/3
	RiECkd8pWrlrCHgupDFc3KxnYq4uL5YndlEoSmExEsDZimekGegfudHczJLGHW081B9+ucri/Ik
	VfrNDH4EuKJPRvbKV0Cylt/qYyxn5KadES0bLcEkfZvoBSdaybaxXYzsigwMs8bvJcMQmbMwZSL
	Vq/aHObXnE9tFU83XrBQ/sod3cXKZRy1SwT0fvOhrmGTuF02GXayYQg63i3gt+BT4jH/t6kCB3b
	ClSkGSgZ+nI/iVVQ72dnywXEGn8IYSY7GzbZWPqQOxbVfv0qVR6g8XDcTcebgxetwDUx7220645
	bt6Pa460=
X-Google-Smtp-Source: AGHT+IEgc0FElY6tpazw9l8jmgQOQo8z3ZbIXxXRv/rhuxcxM/6aaY/UglBp493k0CMb+Z57MxHvIw==
X-Received: by 2002:a05:600c:1c1a:b0:43c:fd72:f028 with SMTP id 5b1f17b1804b1-43cfd72f207mr103770685e9.29.1741805861015;
        Wed, 12 Mar 2025 11:57:41 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a74d4bbsm29140075e9.13.2025.03.12.11.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 11:57:40 -0700 (PDT)
Date: Wed, 12 Mar 2025 18:57:39 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Ard Biesheuvel <ardb+git@google.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, Gerd Hoffmann
 <kraxel@redhat.com>, Juergen Gross <jgross@suse.com>, Jan Beulich
 <jbeulich@suse.com>, Paul Durrant <paul@xen.org>, David Woodhouse
 <dwmw2@infradead.org>
Subject: Re: [RFC PATCH resend] x86/boot: Drop CRC-32 checksum and the build
 tool that generates it
Message-ID: <20250312185739.426a8229@pumpkin>
In-Reply-To: <CAMj1kXGmyssEYer_Su1N+s9svNd3yNm7W4bf9DYHsJszxHoyUg@mail.gmail.com>
References: <20250307164801.885261-2-ardb+git@google.com>
	<87bju7o65f.fsf@redhat.com>
	<3AD32490-F072-4C10-A732-E5BF1E303C43@zytor.com>
	<CAMj1kXHZsk68kVA=dFbCb3yCrLJmHvn7HZ-qqSjjuQkdUf9_2Q@mail.gmail.com>
	<988E1140-BF0F-49CF-AA0B-D05741148836@zytor.com>
	<CAMj1kXGmyssEYer_Su1N+s9svNd3yNm7W4bf9DYHsJszxHoyUg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Mar 2025 18:44:09 +0100
Ard Biesheuvel <ardb@kernel.org> wrote:

> On Tue, 11 Mar 2025 at 18:29, H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > On March 11, 2025 10:25:15 AM PDT, Ard Biesheuvel <ardb@kernel.org> wrote:  
> > >On Tue, 11 Mar 2025 at 18:14, H. Peter Anvin <hpa@zytor.com> wrote:  
> > >>  
> > >> >Ard Biesheuvel <ardb+git@google.com> writes:
> > >> >  
> > >...  
> > >> >> it seems quite unlikely that this checksum is being used, so let's just
> > >> >> drop it, along with the tool that generates it.
> > >> >>
> > >> >> Instead, use simple file concatenation and truncation to combine the two
> > >> >> pieces into bzImage, and replace the checks on the size of the setup
> > >> >> block with a couple of ASSERT()s in the linker script.
> > >> >>  
> > >...  
> > >>
> > >> Please leave the bytes in question as explicit zeroes if possible.  
> > >
> > >Keeping the
> > >
> > >. = ALIGN(. + 4, 0x200);
> > >
> > >in arch/x86/boot/compressed/vmlinux.lds.S should be sufficient to
> > >guarantee that the last 4 bytes of the file are zero, so it is quite
> > >trivial to implement. However, I'm not quite sure what purpose that
> > >would serve: could you elaborate?  
> >
> > It means if someone *does* care it will be easier for them to adjust.  
> 
> I.e., someone can always stick a CRC-32 into the last 4 bytes if they
> wanted to? Yeah that makes sense.

I think you'd need a comment saying the last 4 bytes are reserved in case
anyone wants to add a hash.

	David

> 


