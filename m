Return-Path: <linux-kernel+bounces-515641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E17AA36731
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA1F3B2484
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F35C1C8634;
	Fri, 14 Feb 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="myo//h+d"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4161015749C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567137; cv=none; b=JKfspqFPTadOMVstb7Hay+pcJ6lcCRLKynPdNFCUpuOVkDjZUxagODiTx55baSb0mbTLWNtYM3EF/ao6l+hdLO5ejyAtZPI4bagPQL/wTMwb668OLWcVnwjdXXRS80fg2kh36I7NKrf9tCbHTKEonUz+jU54ehc4BFtvAgHINAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567137; c=relaxed/simple;
	bh=tKCB6PhhTEuBgjYMfnJVWvqaKgU6yGKuFU6tK4E2MMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TFpkZD5fWUvJIV08awycShccIlGaZW2Q7UlzgJ0vshmz+1CWrABDREj6hyYewl3G8qh5sSZms3wj1PqaomglmVG4WaR4jH/SrPvXlvXSrkMUSM0AgWp5jWSkw7QOLtrt+u4klgG9GX/9vcnB2S0cljbZ2MZinp1gjYlZsWNOO2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=myo//h+d; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1a4c14d4so4414443a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739567135; x=1740171935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gmR4FRy7XbDg5biZY9aclCxo/UuFSS5rrlSxPeEWEyo=;
        b=myo//h+dIXdzl9kmwR6DTvA8yvJshqjdLb2fli2qInRnSufKz0hLBOwyqgqM0MTQfc
         8PT4UMjhgZACrByV+wuDytLGlq+XdU8XBf4tE6kD1n6f2k7qcoy4IZMF47wmeTENynJl
         yQEksEALU+OHwaoxepYfnFhQRgacj5nRcuusBbeXub9vqZi/m+ZEji8AWn0DzY5CaZbz
         B7LX+e5d9sJw4i/YPqzGrgLqs44ibhw8NRyIQg74Vyz/vVGSMFO+efPBz8prtYZJe+bV
         OgMhTxRoXb/SLEv9LuSCWrV+5lL8sUofDKi6WgI8v81bXkNQcHnI0ocxkK7A831yWXFQ
         zPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739567135; x=1740171935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmR4FRy7XbDg5biZY9aclCxo/UuFSS5rrlSxPeEWEyo=;
        b=Hd2pzZx9I5yTfPNyQvMUalGpV9qLnAZVm1FLf1Nh9W5UmlS2Zn3zDF6t8GwOnuisuy
         E+t4GpqDlSHns+rfAoMvixfdiKS0+/ckNWoGBASJuqvT2qXnIwbpO0Nla53ObLnbJO+0
         1hQ8OhEl67WCY1EzmXWEyY6NeXrnDewnjtasHiIX1qTOF/ZDDGUsXkqdrOeV/EMES0rX
         h+GvIjbB1D7+dpgS+mHOBEzNrobIDVYeYEn0vCXcTcXYHB3tEeLImlF3vQBhv+2wGw+m
         rl/DOoJmXOiHr6HdC3Aenhozc8s1pPMnwFTtQ0QC3BYqX2ld9HbKrVVyV9sTOvEZuI/R
         92fw==
X-Forwarded-Encrypted: i=1; AJvYcCVLRwxF8oHWaou54aZATbFxieVikjVKAg5P0SsSNDIL3JhDCSeygRdU0qMkwTV/edUcEclL9hsB8ErFar0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIuDtzmb2egwrT0mcAT6ZVd60ObUYZk6w+r1bmU6ZeeDzx8zEC
	1jmXquQC2NQBWs/dykN2WFEhUnTf5ebV66iie5x/+OJ3+qVs8DReSy59KFRwh86ssocf+Dxute4
	vJA==
X-Google-Smtp-Source: AGHT+IH7qZrfQaZM4ahlLFkhcnCNgcSosq0FlZs7Wbxv4+1Rfpm6BAjSgohEWpjG1/AvQEBdn8O0ia2dOmY=
X-Received: from pjbhl3.prod.google.com ([2002:a17:90b:1343:b0:2fc:15bf:92f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1848:b0:2ee:8e75:4aeb
 with SMTP id 98e67ed59e1d1-2fc40f22d04mr1016952a91.17.1739567135602; Fri, 14
 Feb 2025 13:05:35 -0800 (PST)
Date: Fri, 14 Feb 2025 13:05:34 -0800
In-Reply-To: <20240914101728.33148-5-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240914101728.33148-1-dapeng1.mi@linux.intel.com> <20240914101728.33148-5-dapeng1.mi@linux.intel.com>
Message-ID: <Z6-wHilax9b59ps8@google.com>
Subject: Re: [kvm-unit-tests patch v6 04/18] x86: pmu: Fix the issue that
 pmu_counter_t.config crosses cache line
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Like Xu <like.xu.linux@gmail.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Sep 14, 2024, Dapeng Mi wrote:
> When running pmu test on SPR, the following #GP fault is reported.
> 
> Unhandled exception 13 #GP at ip 000000000040771f
> error_code=0000      rflags=00010046      cs=00000008
> rax=00000000004031ad rcx=0000000000000186 rdx=0000000000000000 rbx=00000000005142f0
> rbp=0000000000514260 rsi=0000000000000020 rdi=0000000000000340
>  r8=0000000000513a65  r9=00000000000003f8 r10=000000000000000d r11=00000000ffffffff
> r12=000000000043003c r13=0000000000514450 r14=000000000000000b r15=0000000000000001
> cr0=0000000080010011 cr2=0000000000000000 cr3=0000000001007000 cr4=0000000000000020
> cr8=0000000000000000
>         STACK: @40771f 40040e 400976 400aef 40148d 401da9 4001ad
> FAIL pmu
> 
> It looks EVENTSEL0 MSR (0x186) is written a invalid value (0x4031ad) and
> cause a #GP.

Nope.

> Further investigation shows the #GP is caused by below code in
> __start_event().
> 
> rmsr(MSR_GP_EVENT_SELECTx(event_to_global_idx(evt)),
> 		  evt->config | EVNTSEL_EN);

Nope.

> The evt->config is correctly initialized but seems corrupted before
> writing to MSR.

Still nope.

> 
> The original pmu_counter_t layout looks as below.
> 
> typedef struct {
> 	uint32_t ctr;
> 	uint64_t config;
> 	uint64_t count;
> 	int idx;
> } pmu_counter_t;
> 
> Obviously the config filed crosses two cache lines. 

Yeah, no.  Cache lines are 64 bytes on x86, and even with the bad layout, the size
only adds up to 32 bytes on x86-64.  Packing it slightly better drops it to 24
bytes, but that has nothing to do with cache lines.
 
> When the two cache lines are not updated simultaneously, the config value is
> corrupted.

This is simply nonsensical.  Compilers don't generate accesses that split cache
lines unless software is being deliberately stupid, and x86 doesn't corrupt data
on unaligned accesses.

The actual problem is that your next patch increases the size of the array in
check_counters_many() from 10 to 48 entries.  With 32 bytes per entry, it's just
enough to overflow the stack when making function calls (the array itself stays
on the stack page).  And because KUT's percpu and stack management is complete
and utter garbage, overflowing the stack clobbers the percpu area.

Of course, it's way too hard to even see that, because all of the code is beyond
stupid and (a) doesn't align the stacks to 4KiB, and (b) puts the percpu area at
the bottom of the stack "page".

I'll send patches to put band-aids on the per-CPU insanity, along with a refreshed
version of this series.

