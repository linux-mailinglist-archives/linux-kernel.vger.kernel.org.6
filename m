Return-Path: <linux-kernel+bounces-332392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A6997B92D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5384A1C229A8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B546117C205;
	Wed, 18 Sep 2024 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2TeTkw5"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503EF16EBE6;
	Wed, 18 Sep 2024 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647346; cv=none; b=cKkoT6UDCIEhykxLVEWy6Jx7SJ0EpEDVExTuJIjGwwJsjANpNB+xwPHsOEaHvCB6guCWSXCvjNYAztBgl+ML/2V1GV7rXXo2RMYlekTfAnLQcCyO2MaSJwkZOEQpMLCoY7E/oKSn/w28KYg0MxooZBjODGppzywjWZ3S3z+s0cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647346; c=relaxed/simple;
	bh=Kzo8b+TZLqNDogxgMb68Bo3cCLBcxdlVO4KJ9JC7hQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2awqqWx6Z2fYdeYBJaAcYh4L3KWkyqYd6j7Vf4FswpwKdUjpjwVkyN/TEj7LrHplJsB4UiQKCvzBb2KEkFfrIaBP/253DOMDsC7ydHPSK+4jYS3F3Iwg3B9Q3tMRjgOOW/1I8ynBLEm7qdSF9l75iRwmQOK0lQisZ3wMQyx0I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2TeTkw5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so33572975e9.3;
        Wed, 18 Sep 2024 01:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726647342; x=1727252142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MUqpXgukV+FJuGJlcWmdbDCHxe/zm7v0A0anm8W8rdE=;
        b=N2TeTkw50V5gUGF7yKWeQJ4OSa93kPAmPA0fNrXmlEi7Np7/ZIDjhqK7GHmRpshzGi
         MZJLDDbo/ZzFFZpCCZ1JOE6AMN+S0LGVsOUVXP5f46ftLdEeuFVRDjea9u/wGVtQNLOF
         gmdXGjq2nT5wJweUaNgNOGKRSLgmGX5XpNktoxvmDRUOeAUbU92ltpAlxLTCTQOrDhCd
         se8Qp+7XRLDHeWZhPV1L8zvi2Kjnp+qtf41s30hh3Jqv/AUq9csbJIqVm9aERNSa3XuR
         yeSnhVXomJ/BC2cJbr8m97SuEU8hGXIyd9CfjnHQ+FqbyZd9Mc6eCd2HteMtgT53QvKY
         L8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726647342; x=1727252142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUqpXgukV+FJuGJlcWmdbDCHxe/zm7v0A0anm8W8rdE=;
        b=wl9Qx3MZ58RvRsplY5ez6Ivlb5upUZ4G2vxbH0WM/2YzvArVx1AesYsFIO0hySk7iY
         aSxjBpXjN66LryX273tm36E7QQbPtqWloWq55bmDSRkEKacXT8RFAcdtMrtJicxDGd4F
         8meek2yC7yHizL4wE2HfjmYjNcrqsYhrMCMda8SkzGe06OjCDaJYJHCVvN7a5a8GN0jb
         p84sFK1SlSr/Yl4xBjBaEFCOfqL2Y3hUdbSExDggVg6SVj8rClfvUG9VEILtIxjeWkWC
         KACrzaNLQvr5MHBkg/6/aLPjCP93oPj+hyBxZghxsJ2W/R6SiZAMO2wzCEquA2mZGhl0
         95mA==
X-Forwarded-Encrypted: i=1; AJvYcCVrE3pp+VdpU4mxdxXvJaEplZvRj4B6GTAvKEhjHuN5ByqNlFpTM1AD6grc3bYowXsPRG2dWqjOUAu4c24Vd+I=@vger.kernel.org, AJvYcCWqjSWkGjv7+frPKCl7wCrwu8XY22e0FTy/VAI3oamJ7T0TYC6cabQBX35vRS+r13109Eh0NzmPdQfEf697@vger.kernel.org
X-Gm-Message-State: AOJu0YwqCFli61wFHJP1qH4EpuM36xkUvGI504XbH1jhF2/3adSxMpb7
	I9TQxylZ5pUREJ3RiYU93TZPisrdcBaSZ8gm08h+hrC1WpsYwFVQ
X-Google-Smtp-Source: AGHT+IGZFrkHUV62HWPhcbsvRzlB/ExZe3kGZ7exewjzbxEdqS/NngJrWdTIiDbd+uDCdUVLC0tKqw==
X-Received: by 2002:a05:600c:3b8e:b0:42c:b377:3f76 with SMTP id 5b1f17b1804b1-42cdb54e68fmr171130285e9.17.1726647342105;
        Wed, 18 Sep 2024 01:15:42 -0700 (PDT)
Received: from void.void ([37.46.46.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e72e4c5esm11759450f8f.2.2024.09.18.01.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 01:15:41 -0700 (PDT)
Date: Wed, 18 Sep 2024 11:15:39 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Sami Tolvanen <samitolvanen@google.com>,
	Peter Xu <peterx@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] arm/mm: fix typos
Message-ID: <ZuqMK21Xty1Cj07a@void.void>
References: <20240909102907.9187-1-algonell@gmail.com>
 <ZumsQuGrUkBjZyZq@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZumsQuGrUkBjZyZq@shell.armlinux.org.uk>

On Tue, Sep 17, 2024 at 05:20:18PM +0100, Russell King (Oracle) wrote:
> On Mon, Sep 09, 2024 at 01:28:51PM +0300, Andrew Kreimer wrote:
> > Fix typos in comments.
> > 
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> 
> Not sure who's picking this up, but if the intention is for me, then
> please make sure it finds its way to the patch system. One way to do
> this is:
> 
> $ kvsn=$(git describe --abbrev=0 ...commit...)
> $ git send-email --cc=patches@armlinux.org.uk \
> 	--add-header="KernelVersion: $kvsn" \
> 	...
> 
> Thanks.
> 

Noted.
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

