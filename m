Return-Path: <linux-kernel+bounces-246631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B28D92C489
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CCF1F23644
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA54182A6F;
	Tue,  9 Jul 2024 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PAmrwMl/"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5214914F108
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556988; cv=none; b=rLoHMFxXYTLAya0DneeUSbGFq1D/JN9sFh9ShzcMtn6H6ienZucNpuSQzRFCgABIsDK6vUmXfgR4QJQcoHSimoaoCFbaCZHJgTZNo473uv/wzYJGpaH5nS2WFmRQuJWz3zVe192mWn3UORVdU2XRSnBMtNW7pCeSqRO0xUMreOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556988; c=relaxed/simple;
	bh=0s9Z2fRRKW75n0LnOIvEtOopa7KaslL3UmTVtGV69T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZIUVRi5sNJ9nzIIvCoz/zdzZnXVx0z+rZcM7eDz7MYb7ye1PeItOWboRXjUuglxh1+SKGfWmtWw/Rf+40YdI1B+hYE/vKrKpCRgPxX3jj/57EXmj5Ci4nFb1XWgbuIueXiR2UDSYpnClBBoXufhiTAjwn/SNAhXDPtXAuf7TeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PAmrwMl/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70b48dfd6a2so796358b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720556985; x=1721161785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r2+jHxAEG+4VbUC0OZZJU2rWzzQisahg87K71ePTkuY=;
        b=PAmrwMl/sXbkvNJQCqdo/+n6kjZFJgos3LcEF4HyElyeGOQ4yAEfbR70chNsRIuVkG
         hSWwkSH9swfLPeF3NOaWwva0EZCDazAAttSjqK6X10rycRy6sRrRXPwBixRRfmbj4Kut
         R90/eWEpzuXVx/TVOoz3REZ2hzAqYXk6LSFlc9qjF2Q8fDX4qElH81uuDczb1h2sBbwB
         EFxtBiYj3RVTZv0rRj8it0FACMw96TKeFf6/jeg/KbFXqBBJrI032W9QIxLCoxLfj4sU
         GsTtvx9CRNmzY2cckk/O09hcNcTA8lChaK13BS7FUev6zkTXfP0qFnpE2NJk+jzzF9PN
         OizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720556985; x=1721161785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2+jHxAEG+4VbUC0OZZJU2rWzzQisahg87K71ePTkuY=;
        b=oVfiXYwpci4OC5rE0hsVywKP8peXmdWu8vKmzqfpTJff1qtdkb7EbqtX+f3kaGZWZa
         SZmiiQgUX2BMssYf4bLOQVcxs/yRWOvnpxxJjms8OIH6+tzTm+N74E7CRklB/w1y+FiV
         bEcsgOvT1CqrmC8UeVABW+W9UFkv0E4DzDadBEd5wrmNym7+/m5uzM5BoXIW4YABBz/p
         +WvxDfY/cFrPKsQVYbhXu0fwBublLRWKRba5rzlv7qkFRTvp0Nz75Em3A+W4jVKRS4bs
         +QDhdZLFiZQHvQk7zf4/aO9mve8XpmwL+wsyX++ajffEXxbF57YCViMTHei1z/VvdcwV
         I4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUXFFcRyri8Sh5l+lolOPKFOjF0MBsGZ559yzH1rxCsjjy+Mze+feCY4AIwyNFapuyOeHpT/JDJVLUTzYAzHSWkpCQrwxLjTYsv1Ans
X-Gm-Message-State: AOJu0Yw+DpFeJB2DMDNx/n5Eyi/QBhvkIJ+NGkYR+Y05r3mJpaLtg3rS
	z/AN47HxAA+AUcY6S2vynPI/FURTOrCSZYeF4Mzlo2N/8MY6YM9+oTxpGIQHGKg=
X-Google-Smtp-Source: AGHT+IHvyjUH8ArsNII9bJpvyGejtf+ilOTzEpcXtEvBjBrMVFs10pu7Ig8U8REkU9pJd97VpkeKjA==
X-Received: by 2002:a05:6a00:1395:b0:70a:f57c:fa1d with SMTP id d2e1a72fcca58-70b43623b6amr4658217b3a.29.1720556985517;
        Tue, 09 Jul 2024 13:29:45 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d5f0ab0bfsm1810102a12.1.2024.07.09.13.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 13:29:45 -0700 (PDT)
Date: Tue, 9 Jul 2024 13:29:42 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Xiao Wang <xiao.w.wang@intel.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, atishp@atishpatra.org,
	anup@brainfault.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: riscv: Remove redundant macro check
Message-ID: <Zo2dtuv0quQ7FwtK@ghost>
References: <20240708121224.1148154-1-xiao.w.wang@intel.com>
 <20240708-wildcard-denim-12de7fae795b@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708-wildcard-denim-12de7fae795b@spud>

On Mon, Jul 08, 2024 at 01:22:11PM +0100, Conor Dooley wrote:
> On Mon, Jul 08, 2024 at 08:12:24PM +0800, Xiao Wang wrote:
> > The macro CONFIG_RISCV_PMU must have been defined when riscv_pmu.c gets
> > compiled, so this patch removes the redundant check.
> 
> Did you investigate why this define was added? Why do you think that it
> is redundant, rather than checking the incorrect config option?

This file is only compiled with CONFIG_RISCV_PMU:

# drivers/perf/Makefile
obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o

So having this check does seem redundant. I am copying Alex as it looks
like he wrote this.

- Charlie

> 
> Cheers,
> Conor.
> 
> > 
> > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > ---
> >  drivers/perf/riscv_pmu.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> > index 0a02e85a8951..7644147d50b4 100644
> > --- a/drivers/perf/riscv_pmu.c
> > +++ b/drivers/perf/riscv_pmu.c
> > @@ -39,7 +39,6 @@ void arch_perf_update_userpage(struct perf_event *event,
> >  	userpg->cap_user_time_short = 0;
> >  	userpg->cap_user_rdpmc = riscv_perf_user_access(event);
> >  
> > -#ifdef CONFIG_RISCV_PMU
> >  	/*
> >  	 * The counters are 64-bit but the priv spec doesn't mandate all the
> >  	 * bits to be implemented: that's why, counter width can vary based on
> > @@ -47,7 +46,6 @@ void arch_perf_update_userpage(struct perf_event *event,
> >  	 */
> >  	if (userpg->cap_user_rdpmc)
> >  		userpg->pmc_width = to_riscv_pmu(event->pmu)->ctr_get_width(event->hw.idx) + 1;
> > -#endif
> >  
> >  	do {
> >  		rd = sched_clock_read_begin(&seq);
> > -- 
> > 2.25.1
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv


