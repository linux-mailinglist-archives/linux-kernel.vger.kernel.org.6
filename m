Return-Path: <linux-kernel+bounces-246673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2551592C50A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B14282814
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A800317B027;
	Tue,  9 Jul 2024 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZoSuk6lv"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85661B86DD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720558672; cv=none; b=KbBNiF+Uv0pECapxYI+iXpanb2JFoJ2MoHv/+3cHCBL+eJWQmsBw+bD/CAOYQIgm7gGVWBILSwv9/CmVGU+w99nbmUrjKF5VdCNK2+5LRTXe5nA35A5yI6jkBPdoaZLilBCqXd6HiTih74GKcoxM4OlLDLCaPIVy7A4joh7GMI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720558672; c=relaxed/simple;
	bh=9HcRm9CCFeUbO+tgsv/WnNg17iWdStnDoYqPky1rEDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSv4Mk7G7f0dFZ7oGzPWftfsWzrgsnoKt2suSl/MPatY+1iKeKAPZo+ybHRCKYiPIltfQh/keUnUTN5F9kErDAf9s4sAIF8L0MaKstMiIhJsQx+IRUidCfpIXbq4wo4cPMt4uqCjujl6PZ3HYV6dSPGcnVS7OL9rCYhHptYna7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZoSuk6lv; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25e076f79d5so2697646fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720558670; x=1721163470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7JFkFgEMwAFqLLgQ8q+9F2STswPj9iSERKoMxl+rv1I=;
        b=ZoSuk6lvI9ogRj2a5Q6tFojnAI61+NTvaSyFkeLqfAVLCiHsUZLs/YE6NBekeFaDL1
         VAyD0nmtjn36lKAxSbw6oZNnJEI8GI58XhSt1CPTxaTUf1NpfobpzAHQQDXa9sDeit0e
         W/5VwP+M6RYk9BkoFVPvDBZMJXNWMgyeogUn9YgqTkfZFIB+u6+18hbcK2LTrGGMVOVQ
         NxmSXniVgBphoMEGp6UOTgwxJUoGByKFOWG6MrKevDOsA7U2CY7T6q3h48D2LFyTCE6P
         oWxeiVtilLzwXLjPFEQrfhubdkh2izoGcqMarzTHo2m8VaosuzAYyVN/dhM3j1TuJ/7G
         PDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720558670; x=1721163470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JFkFgEMwAFqLLgQ8q+9F2STswPj9iSERKoMxl+rv1I=;
        b=bpo08aD9AN+XmI7DFt2b5oC4nMdb2Mxm1H56h18T3OdDlzvov78FEbysPfH/XodtnS
         GDlh4+0EX/OwKeMVAwGL8ZIivrQtaa2nV0CWi2nklAUnVtAGbN7sslz1WPsE1wUD8sg+
         trB7fPnbCO0Tm7IPrIpX7f/2G79gBGTUpU5U9Fj1TVFyMTgEhP8whq/6ZMxS4B5NBpKm
         iGROqSwp7biHUfGbhl0/AumSya/UMD3kopWZIlcTjoySKCilDNofFQ9X99bRjLX8tSNI
         BPZbLNeX0QpcL/bU6F6T+QpKBErH1je/T+PKz3fdWRUSMtvdGUnJkpjs7+CMCJryHG8I
         ZTsg==
X-Forwarded-Encrypted: i=1; AJvYcCUdVdxkW859VZKarst1uc92wb6tdmxAi0yifbltQMqaqbvSLXRVUjuwkpWuSrcRo47jOrSIjtNgSQNJYWi3zj3U+bY+eb80xQ3rkb2W
X-Gm-Message-State: AOJu0Yx6jL4CGMWf6bGtoAbGxOjGhScTmdFTgWoeE9ddKV1EhRgkdR05
	N+S/imSOZaFs8rCMSSam89cZthDfEVnNEwIRrd2yVnUG9H6Nfufu7uTyy0vgrfYR+mUtSF8yrBk
	v
X-Google-Smtp-Source: AGHT+IFM6JPO00EDOYIlswbIOR4HoV/jvewcxyTuZsslE/z05OqIkhaPvLWDkjiK4Ps+QOGApj1kFQ==
X-Received: by 2002:a05:6871:2887:b0:25c:b3c9:ecda with SMTP id 586e51a60fabf-25eaebdb520mr2914029fac.38.1720558669887;
        Tue, 09 Jul 2024 13:57:49 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4398039csm2269167b3a.154.2024.07.09.13.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 13:57:49 -0700 (PDT)
Date: Tue, 9 Jul 2024 13:57:47 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Xiao Wang <xiao.w.wang@intel.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, atishp@atishpatra.org,
	anup@brainfault.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: riscv: Remove redundant macro check
Message-ID: <Zo2kSxsJkdkBdBEW@ghost>
References: <20240708121224.1148154-1-xiao.w.wang@intel.com>
 <20240708-wildcard-denim-12de7fae795b@spud>
 <Zo2dtuv0quQ7FwtK@ghost>
 <20240709-unengaged-handgrip-56a5c7b3e1d1@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709-unengaged-handgrip-56a5c7b3e1d1@spud>

On Tue, Jul 09, 2024 at 09:44:17PM +0100, Conor Dooley wrote:
> On Tue, Jul 09, 2024 at 01:29:42PM -0700, Charlie Jenkins wrote:
> > On Mon, Jul 08, 2024 at 01:22:11PM +0100, Conor Dooley wrote:
> > > On Mon, Jul 08, 2024 at 08:12:24PM +0800, Xiao Wang wrote:
> > > > The macro CONFIG_RISCV_PMU must have been defined when riscv_pmu.c gets
> > > > compiled, so this patch removes the redundant check.
> > > 
> > > Did you investigate why this define was added? Why do you think that it
> > > is redundant, rather than checking the incorrect config option?
> > 
> > This file is only compiled with CONFIG_RISCV_PMU:
> 
> I might be ill, but I can still read. I was not disagreeing with Xiao
> that the condition is redundant as written - I want to know whether they
> made sure that this check was intentionally using CONFIG_RISCV_PMU in the
> first place, or if another option should have been here instead.

Makes sense! Looking through the lists I see this RFC from Atish where
he introduced a different config option for this
"CONFIG_RISCV_PMU_COMMON"[1]. I wonder if something got confused in the
development of these two patches.

Link:
https://lore.kernel.org/lkml/20240217005738.3744121-12-atishp@rivosinc.com/
[1]

- Charlie

> 
> > 
> > # drivers/perf/Makefile
> > obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
> > 
> > So having this check does seem redundant. I am copying Alex as it looks
> > like he wrote this.
> > 
> > - Charlie
> > 
> > > 
> > > Cheers,
> > > Conor.
> > > 
> > > > 
> > > > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > > > ---
> > > >  drivers/perf/riscv_pmu.c | 2 --
> > > >  1 file changed, 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> > > > index 0a02e85a8951..7644147d50b4 100644
> > > > --- a/drivers/perf/riscv_pmu.c
> > > > +++ b/drivers/perf/riscv_pmu.c
> > > > @@ -39,7 +39,6 @@ void arch_perf_update_userpage(struct perf_event *event,
> > > >  	userpg->cap_user_time_short = 0;
> > > >  	userpg->cap_user_rdpmc = riscv_perf_user_access(event);
> > > >  
> > > > -#ifdef CONFIG_RISCV_PMU
> > > >  	/*
> > > >  	 * The counters are 64-bit but the priv spec doesn't mandate all the
> > > >  	 * bits to be implemented: that's why, counter width can vary based on
> > > > @@ -47,7 +46,6 @@ void arch_perf_update_userpage(struct perf_event *event,
> > > >  	 */
> > > >  	if (userpg->cap_user_rdpmc)
> > > >  		userpg->pmc_width = to_riscv_pmu(event->pmu)->ctr_get_width(event->hw.idx) + 1;
> > > > -#endif
> > > >  
> > > >  	do {
> > > >  		rd = sched_clock_read_begin(&seq);
> > > > -- 
> > > > 2.25.1
> > > > 
> > > > 
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > 



