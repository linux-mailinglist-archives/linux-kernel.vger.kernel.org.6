Return-Path: <linux-kernel+bounces-511202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38178A32791
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74871881A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF2520E009;
	Wed, 12 Feb 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuF7XNqX"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AEF209681
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368324; cv=none; b=QzgZLPJpw8/aFca0tlkXdEzUKD8jSB835UeGRYOJQ13HH1FxTxCJkV/Fs8b/HpW5z0HJFgvmQRaBnm6kCYdietoAMtv3CGiBLbrL5uxEC0NAgGJxAowxTJuLhkU4V3zHpgmW7hGFuhWbIQK9PjQS1EO7kyqPIkcltqFcZNrGoF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368324; c=relaxed/simple;
	bh=GHZGusw86GcLQPIXc/c6S3yuUQ40ZdJGxJQx4H3qfcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdH9SiEISYSSWG0ZIzrJFIPBJzg7m8TqRqz/JOOHydKpRXSubUAW7MSCrgb4nw3AwEfFuYOZMbQ9oysBNn9NRyxhi8bTLbia4/Ijlx0XG0RU+XWCTDOlViZt/CZ0wKg5sZ6gNB+uQavYQlXaORciUfzk8uk1FrOxLRFfqUih5uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuF7XNqX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4395817a7f2so6471985e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739368321; x=1739973121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPDZbF7ITgJN0RxvXXGALLi4n6lUqPGhUHJ+H9bzp+c=;
        b=fuF7XNqXGE2H5PlUpoea1sIJvf+DjzeR3vxbb1Hs3veEVwOKYMJEJEo1aRNxTkMTNm
         fkO1XTz+r8nWk4mONj8dtRYaKcqcfEVps98bKq6wwlh9RM1LEc2K8OzM0PHo2QULPlZ9
         xqFDIofaLpVo3B3efz3uLIGpDxF7gkOvDMmNykU/KZ1CJu7AO40xfSqzsWZlGpiD1X5L
         /nUXBqsTAENjEwFU+3/e4fo7c3vW3TgFsvJZPq4cE4B+Js+qa7tj3MIOUnRJkkRb6WbY
         UtAHzpx3EnQUSEtPSFALM33b2gOYToUUDTqG9Zlr7s27U8Tsf4Koryf9FNfRS1SOhha9
         U1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739368321; x=1739973121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPDZbF7ITgJN0RxvXXGALLi4n6lUqPGhUHJ+H9bzp+c=;
        b=ovAn7/ge/5fm8f0gpAUvAccO98mdr89cehJp2ga85/Ws49hGLp9THR17LEqI9w7fhi
         3ebyKwVonyLTWI7vk2tf/e297SW5MVZZqQN+XIaR57/W7T736cuiD3XEKYxlVviWcWjQ
         W/TJc3Xv3c1xFVTwfWSRHsw4Zbil6QHw462mmJIQJq4ON55pI2YIorsG6AfZPwu5+JU1
         acXp6g3YYIdoXcb/NgqJXiLqcRNT0GJJWOMlHbRXiEQno2cRx7I+G7Dla3QGzhOQaoTf
         gClNn64kKRHrS5p/75ACQ0WZeaash4H721EiNS9bjOfr5vKrXI94et13xm5YZ2Hh4gHA
         cQmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHhbci279lgx6kItncpMs3xLaAVbGIX/PkU/EGc2NOEW7TnWZT7xo2V3Bo9iBBmFtpuuvSMoGT7O8Q81k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr5iw4cNR5vvbfinBZRPsQuu3n0zQ+EN02130JbQ2bH+cGfNSm
	G8C+xBgGOTFUh9yOV+R0UKdXJMwina+ILXaG7lbsj9k12sxdGD6r
X-Gm-Gg: ASbGncsMrR92HMaM9rI7bF/FWWbPfUP6ahKH3m5Cwxcx731hRTEFTKVNPjXpOYMQwcg
	k4iBqtn//iVPy5ogvVoO6SojwE/gSeHcYhoMptsaYlnQBR4Gs7r+8imnuvr/P5mwruYoLlSwifu
	EywTkkvCTh0lS+K4L/G/bP4nXwl6JLOvegaYWF4qOhtu05reOu/aO1j0SlDwDAT3gPlMRNc/Wmw
	oruMCCz25Weyl5VXKtazaDufWGX9t6QuaZhJpADbH8qtwptppQ3KYBMvnSSFEAo5AAzPNvB2zZ7
	fchF96mFafzbNC1h1xC5zaj4dV8hziCw+IhyeVtgh7JuWpRzLwGfiA==
X-Google-Smtp-Source: AGHT+IHPc/LvwNsJIFXOD5PIbVl7gpM1I6CxaRbxiBlmyqirVfQOv3laHJaI4hxzUbB5ta4K6pSOPw==
X-Received: by 2002:a05:600c:19c6:b0:439:574c:bf77 with SMTP id 5b1f17b1804b1-4395816a6e6mr31078515e9.8.1739368321234;
        Wed, 12 Feb 2025 05:52:01 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b824dsm20315305e9.34.2025.02.12.05.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 05:52:00 -0800 (PST)
Date: Wed, 12 Feb 2025 13:52:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: yury.norov@gmail.com, anshuman.khandual@arm.com, arnd@arndb.de,
 linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
 skhan@linuxfoundation.org
Subject: Re: [PATCH 2/2] uapi: Refactor __GENMASK_ULL() for speed-up
Message-ID: <20250212135200.5a1f2dca@pumpkin>
In-Reply-To: <Z6yWbROu5rREhw85@vaxr-BM6660-BM6360>
References: <20250211162412.477655-1-richard120310@gmail.com>
	<20250211162412.477655-3-richard120310@gmail.com>
	<20250211223045.5c2b92a4@pumpkin>
	<Z6yWbROu5rREhw85@vaxr-BM6660-BM6360>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 20:39:09 +0800
I Hsin Cheng <richard120310@gmail.com> wrote:

> On Tue, Feb 11, 2025 at 10:30:45PM +0000, David Laight wrote:
> > On Wed, 12 Feb 2025 00:24:12 +0800
> > I Hsin Cheng <richard120310@gmail.com> wrote:
> >   
> > > The calculation of "((~_ULL(0)) - (_ULL(1) << (l)) + 1)" is to generate
> > > a bitmask with "l" trailing zeroes, which is equivalent to
> > > "(~_ULL(0) << (l))".  
> > 
> > Yes, and if you look through the commit history you'll see it was changed
> > to avoid a compiler warning about the shift losing significant bits.
> > So you are just reverting that change and the compiler warnings will
> > reappear.
> > 
> > For non-constants I suspect that (2ul << hi) - (1ul << lo) is the
> > best answer.
> > But the compiler (clang with some options?) will still complain
> > for constants when trying to set the high bit.
> > 
> > That version also doesn't need BITS_PER_[U]LONG.
> > While that is valid for C, the _ULL() are there for the assembler
> > (when they are no-ops) so there is no way asm copies can be right
> > for both GENMASK() ans GENMASK_ULL().
> > 
> > 	David  
> 
> Hi David,
> 
> Thanks for the review!
> 
> > Yes, and if you look through the commit history you'll see it was changed
> > to avoid a compiler warning about the shift losing significant bits.  
> 
> I've browse through the commits of include/linux/bits.h , where
> GENMASK() was placed under. Though I didn't find specific commit of it,
> would you be so kind to paste the link of the commit?
> 
> I assume you're talking about warnings like the following?
> warning: left shift count >= width of type [-Wshift-count-overflow]

No, there is one about clang 'objecting' to ~0u << count because
significant bits get discarded.
The 'strange' expression was used to avoid that - even though it is
mathematically equivalent.

> 
> If this is the case then it happens for the current version as well, I
> mean from the perspective of operations, "(~_ULL(0) << (l))" and
> "(_ULL(1) << (1))" are basically the same, they all shift a constant
> left with an amount of "l". When "l" is large enough the compiler will
> complain about losing msb.
> 
> > While that is valid for C, the _ULL() are there for the assembler
> > (when they are no-ops) so there is no way asm copies can be right
> > for both GENMASK() ans GENMASK_ULL().  
> 
> I don't understand this part sorry, if asm copies can't be right for
> "~_ULL(0) << (l)" , how can it be right for "(_ULL(1) << (l))" ?
> At least from my pespective these 2 ops only differs at the value of
> constant. Please let me know about it, I'm not familiar with assembler
> and would love to know more about it. Thanks.

It is the >> that go wrong, since they rely on the number of bits in
the integer type being used.
For asm both ~_UL(0) and ~_ULL(0) are just ~0, but the >> uses a
different constant.
I'm not even sure that the _ULL() should even be in a uapi header.

I proposed using:
	((1u << (hi)) - 1) * 2) + 1 - (((1u << (lo)) - 1)
not that long ago.
That avoid any bits being shifted off the top and I'm sure it
that gcc optimised add the +/- away.
It also has the advantage that the type of the result only depends
of the type of the 1u (so can be 1ul, 1ull etc).

	David

> 
> Best regards,
> I Hsin Cheng
> 


