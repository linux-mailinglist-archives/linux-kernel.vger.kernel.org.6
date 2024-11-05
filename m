Return-Path: <linux-kernel+bounces-396771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C59BD1BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67AF1F2500E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B471D86C0;
	Tue,  5 Nov 2024 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTtJ+xDg"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919F17557C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822851; cv=none; b=kfeOIMW/VGFY8P/EGlpsLt5UtK9GAi15qKFug7GhBW69kC1iT65ldccBkGWdWtVlEi1aKD5y7/bRizJ7YixqDzpp+fQf6mYLcVivThKGHxEHrGyws4EkCiMEt1qcEHdv2lndATZ3g6P9wLPz7QROTWX0JCfKdJ53Z4RtHmqRZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822851; c=relaxed/simple;
	bh=7ZkzkSGmyqQmi15NfDxrzGLhDJf1avX/vxXv3Nof8XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZkzqwndStNq8jEKg3dAPtUWfISzj0N5UP/g1lO8fbpSbGfxeCn/HZO3EpOqeHRurkJNC4KlzK1UVSux0MKzDMSUC6398GvnV7BPUTnpaERSksPp3CA1lo20qZtYBkvfVRZU1l5b+AU4pIMRawympj0DW99fu4kHLi8t63Sk1us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qTtJ+xDg; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539eb97f26aso3555210e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 08:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730822846; x=1731427646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=473DlSot6ue6xbPLLwBdkXEbSfpgFoGTCnq7nesFQaI=;
        b=qTtJ+xDgCngugGJMRd6KV4/cgnTyIJXGU9oSPVjnwamVsYL82kEyWbw+BNivoh1DJ4
         T/w5w3DuIUU4SMVPlAw1zcWpn3spn0svT8PvAWa9n+THSY5CI7sM79glP1qzfPSn+hkA
         X6caccvQUYTK5DDt86eidBdCGch0HEsg60S0B1JeYItoaDSeRsZwMIOeWqICFgQXDEKG
         bVrPu6NFGD2XWEd1qMCy2kd+I6l/YwgileKo4EJKKp+aQ4MYriPIXn4XpPJ3iKH1vyxQ
         4rCR/yIN0aJIoDJdRyQWTglLE5OnjECcElog68LNDDMzm5tO+ACOEjTq6rk+DoiczKaa
         AaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822846; x=1731427646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=473DlSot6ue6xbPLLwBdkXEbSfpgFoGTCnq7nesFQaI=;
        b=gEM2Lz3pIc4Qgx0EHSP3lKvaAVwwbBPin10NN+UxDWHDkM8u0ked9fQb1hjIzTWklf
         CWHsnBPnEOdHnrRkLuUcnv0prhAJLjDuZVZu3XxBTnniZ6weWoeNjPr81PW7vOgZ/T1S
         6AGoofinAVjlluhpWxNk75ee7dxE/8SuXq+hsg9xBjmrtfd3Vxnjj/O4zyQU+kMh45vL
         y4J6ESzwmq9ODV2MocHQheCdSag/UD2zVCDUNzIjiWYFTgoxBKpsDXnhQO8HlkTCdqcA
         NMSc9iIgnMYUel+kJKTrk680XSNb4ex6mcQsbjZu24aEmzK3VhFrEaBchd/Ha2kQ099y
         /Kkw==
X-Forwarded-Encrypted: i=1; AJvYcCW8gRmJZGGCrjd586raPJGIRzf+L/xLkW3v94w6VFX4HseE8MEyc9Q9Q4iP9Vw3rIm5QJlU3ZcTnNdCdbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4jBYfjLFOcXn9T+lDn3m3L09QolbrmmrHdM9vUP59KRL0rgBp
	mggI6O2tvr8P7QUGwCE4eEcBS1gHoRX1peaTokLqmyeIg1F5AuTb4LtxwJGTHQ==
X-Google-Smtp-Source: AGHT+IHQrLAwD8G22UzU+Ve3Dp55NDLGsHlnPaeRYF6+uIfupSs5Q35hB7K725aR+e45CXT07QcH/g==
X-Received: by 2002:a05:6512:3f13:b0:539:9490:7257 with SMTP id 2adb3069b0e04-53b7ecf28ebmr12296414e87.30.1730822845919;
        Tue, 05 Nov 2024 08:07:25 -0800 (PST)
Received: from google.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17d0adasm151224366b.111.2024.11.05.08.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 08:07:25 -0800 (PST)
Date: Tue, 5 Nov 2024 16:07:21 +0000
From: Quentin Perret <qperret@google.com>
To: kernel test robot <lkp@intel.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, oe-kbuild-all@lists.linux.dev,
	Fuad Tabba <tabba@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sebastian Ene <sebastianene@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] KVM: arm64: Plumb the pKVM MMU in KVM
Message-ID: <ZypCuSRW9VJEEWnr@google.com>
References: <20241104133204.85208-19-qperret@google.com>
 <202411051325.EBkzE0th-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202411051325.EBkzE0th-lkp@intel.com>

On Tuesday 05 Nov 2024 at 13:53:22 (+0800), kernel test robot wrote:
> Hi Quentin,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on v6.12-rc6]
> [also build test WARNING on linus/master]
> [cannot apply to kvmarm/next next-20241104]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Quentin-Perret/KVM-arm64-Change-the-layout-of-enum-pkvm_page_state/20241104-213817
> base:   v6.12-rc6
> patch link:    https://lore.kernel.org/r/20241104133204.85208-19-qperret%40google.com
> patch subject: [PATCH 18/18] KVM: arm64: Plumb the pKVM MMU in KVM
> config: arm64-randconfig-002-20241105 (https://download.01.org/0day-ci/archive/20241105/202411051325.EBkzE0th-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241105/202411051325.EBkzE0th-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411051325.EBkzE0th-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/arm64/kvm/mmu.c:338: warning: Function parameter or struct member 'pgt' not described in 'kvm_s2_unmap'
> >> arch/arm64/kvm/mmu.c:338: warning: Function parameter or struct member 'addr' not described in 'kvm_s2_unmap'
> >> arch/arm64/kvm/mmu.c:338: warning: expecting prototype for __unmap_stage2_range(). Prototype was for kvm_s2_unmap() instead
> 
> 
> vim +338 arch/arm64/kvm/mmu.c
> 
>    299	
>    300	/*
>    301	 * Unmapping vs dcache management:
>    302	 *
>    303	 * If a guest maps certain memory pages as uncached, all writes will
>    304	 * bypass the data cache and go directly to RAM.  However, the CPUs
>    305	 * can still speculate reads (not writes) and fill cache lines with
>    306	 * data.
>    307	 *
>    308	 * Those cache lines will be *clean* cache lines though, so a
>    309	 * clean+invalidate operation is equivalent to an invalidate
>    310	 * operation, because no cache lines are marked dirty.
>    311	 *
>    312	 * Those clean cache lines could be filled prior to an uncached write
>    313	 * by the guest, and the cache coherent IO subsystem would therefore
>    314	 * end up writing old data to disk.
>    315	 *
>    316	 * This is why right after unmapping a page/section and invalidating
>    317	 * the corresponding TLBs, we flush to make sure the IO subsystem will
>    318	 * never hit in the cache.
>    319	 *
>    320	 * This is all avoided on systems that have ARM64_HAS_STAGE2_FWB, as
>    321	 * we then fully enforce cacheability of RAM, no matter what the guest
>    322	 * does.
>    323	 */
>    324	/**
>    325	 * __unmap_stage2_range -- Clear stage2 page table entries to unmap a range
>    326	 * @mmu:   The KVM stage-2 MMU pointer
>    327	 * @start: The intermediate physical base address of the range to unmap
>    328	 * @size:  The size of the area to unmap
>    329	 * @may_block: Whether or not we are permitted to block
>    330	 *
>    331	 * Clear a range of stage-2 mappings, lowering the various ref-counts.  Must
>    332	 * be called while holding mmu_lock (unless for freeing the stage2 pgd before
>    333	 * destroying the VM), otherwise another faulting VCPU may come in and mess
>    334	 * with things behind our backs.
>    335	 */
>    336	
>    337	static int kvm_s2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size)
>  > 338	{
>    339		return KVM_PGT_S2(unmap, pgt, addr, size);
>    340	}
>    341	

Oops, yes, that broke the kerneldoc comment, I'll fix in v2.

