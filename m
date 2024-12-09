Return-Path: <linux-kernel+bounces-436851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024299E8BAC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5E81885DF0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C591D555;
	Mon,  9 Dec 2024 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jq/yCKZH"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68CC214A66
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733726794; cv=none; b=XNOR0jpdyEcYTEVVrIDR8EB4brCVJrCzeE9KNmyp3bhF+UXNsfg6vIatd4ahIYYTcDfRgiEgfyk2kcP2jbEfXWHEtTBDFlx7yPimrsthtKdEATZguJwnVQj9ocViPWWFdVjSbJg9z/3zMpab1fQ9wZr0pjcE3Z9E2dsfeCrJuNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733726794; c=relaxed/simple;
	bh=eYESRqEX20YdrEN6eVSJ/cbln30rq2T4so8Lf6iFg0c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vh9izw7ZJbBaTup7Ie5vjE0uwy2E982cnvLTuaieDVMI76eimL1AsznoCTBkwHj1yb7r582PJT4xBaYQM/g8aB0PvezJNgVVF2qyMNDu7hvqXDtMVnIhq952qQr69c/RUBlrumNej4zJ2cytFGY2KSQJxY6mEdzNUSICdg4mYOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jq/yCKZH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-386329da1d9so995788f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 22:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733726790; x=1734331590; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IPx4odjlhYjxbYRXDXRscRJAb1NNIdgNbsIotKHiFzs=;
        b=jq/yCKZHN8krXIZauqi9Xqnxu+bH/Fang6cTefDKsFvi51PLjIDiq/TkRWrOaKzRZz
         uawO8Fwm6yAwI9DKA6GU0h4lUSbkqt5wRe3QhhjhdVZDopyrtR7dTfgOJUCQxNsR/oK+
         mdRvfWY2T0mPgT/YQaOQFEwVRcmCFiOp89Wx+aG7PZHrb2aoObAbFay3JhM5bZjdvYem
         /JkxAK7nRFn/brsSFy6Kyz7UbYQhkEvQ+xP1/ukLYf/Jzi/ytNFt2ulsAlryoV0nztkr
         bmFSo6ww2C/IyUYHBCFygu0q717eo68ua78HuuToy2ywEw/b0UvpCOdyGAXw5VQuaEEj
         qNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733726790; x=1734331590;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPx4odjlhYjxbYRXDXRscRJAb1NNIdgNbsIotKHiFzs=;
        b=fYk0dCks9erfGaZ9zuGhsGnJUaVLp/bD/I8RS/OS2azlbjse+M72bEJ55fppoj6w+h
         NLzxVweqD+uECSLVtlUXOMzTVrTWVL0cX8Qy3cb0N7s8DhiNoAVPBB15ecOfxxPhHpwH
         ePssiAoykca/zEO+XJdWMnvxI6c//17fhemAbMJv8IpF8Sfri8Pf0++hJ8V3BKErbmXI
         xm5ulUm2IgwNkuZaT1pY7nJM/152WsUFL9ffbq2htHBMmILQyuaVj7iWHwCE30PqnYox
         DcIDJjrMytyBlh2pY5J4kwZx2W8Ihq/Yh7Sga8OrUSKWwcs4SbFO8/RPaMRSHU9gDbEq
         QR9w==
X-Forwarded-Encrypted: i=1; AJvYcCVvQ3WpLZjDirirDfhLH4IVDGDF6bpqzVH/c9j643IR1tVyK8Ltc5BvEdN/tMhpck746NYRl/xwoJ+vZcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuK7fknLyLlPrmKW9LhSPAkNQtilMrsEEghYo3dEA9ByNypY35
	Uj/koMssRGCXT50Yk3RkEmsE5W1dwavnmjJ3k/QyM7hBqYl5QyKjxxceWKgnvh41vfOMsPUWhtr
	6
X-Gm-Gg: ASbGnctxYNo3TWZGaZJ/w8r7xMfMoWswda0n/JK62Q1qY7p3F4yEQEB8lrHRfFvloZf
	FnKP1zBSoBzRjf/Nm5v5OaU3X2xiwGvfD3kDeXZsC8j13Euy8sguGioMTbuB09XiLQrTBisyh0l
	4Xqh1OuQQ8wProsegmxLMCnGt8syQN13Spmzsczrs/N2/6VegMskJvt0NFTmG/6vOSnXTe15A6K
	K7q2uYoZJajfoxka68UX6Tb1KKnj7L1qi9ccgmaCW9bcV5+/ERApdA=
X-Google-Smtp-Source: AGHT+IHnAJmMRP6QYNzcPZsWpNbhVGss2B/vywFHRiKi88KuTzAR1y2aY4Yw49AUiw7ay5CLzYKxXA==
X-Received: by 2002:a5d:47a5:0:b0:385:e968:f189 with SMTP id ffacd0b85a97d-3862b3e7d5cmr8527452f8f.51.1733726790108;
        Sun, 08 Dec 2024 22:46:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbe15sm12111687f8f.92.2024.12.08.22.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 22:46:29 -0800 (PST)
Date: Mon, 9 Dec 2024 09:46:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Anup Patel <apatel@ventanamicro.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: drivers/irqchip/irq-riscv-imsic-state.c:854 imsic_setup_state()
 error: we previously assumed 'mmios_va' could be null (see line 745)
Message-ID: <7d0f9113-8709-4fe9-a47c-10e17b41dd24@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Anup,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b5f217084ab3ddd4bdd03cd437f8e3b7e2d1f5b6
commit: 0eebc69db358fd2f6fe34cc4db6428df6a540dd7 RISC-V: Select APLIC and IMSIC drivers
config: riscv-randconfig-r073-20241207 (https://download.01.org/0day-ci/archive/20241207/202412071811.QdFBrzA6-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202412071811.QdFBrzA6-lkp@intel.com/

New smatch warnings:
drivers/irqchip/irq-riscv-imsic-state.c:854 imsic_setup_state() error: we previously assumed 'mmios_va' could be null (see line 745)

vim +/mmios_va +854 drivers/irqchip/irq-riscv-imsic-state.c

21a8f8a0eb35ceb Anup Patel 2024-03-07  691  int __init imsic_setup_state(struct fwnode_handle *fwnode)
21a8f8a0eb35ceb Anup Patel 2024-03-07  692  {
21a8f8a0eb35ceb Anup Patel 2024-03-07  693  	u32 i, j, index, nr_parent_irqs, nr_mmios, nr_handlers = 0;
21a8f8a0eb35ceb Anup Patel 2024-03-07  694  	struct imsic_global_config *global;
21a8f8a0eb35ceb Anup Patel 2024-03-07  695  	struct imsic_local_config *local;
21a8f8a0eb35ceb Anup Patel 2024-03-07  696  	void __iomem **mmios_va = NULL;
21a8f8a0eb35ceb Anup Patel 2024-03-07  697  	struct resource *mmios = NULL;
21a8f8a0eb35ceb Anup Patel 2024-03-07  698  	unsigned long reloff, hartid;
21a8f8a0eb35ceb Anup Patel 2024-03-07  699  	phys_addr_t base_addr;
21a8f8a0eb35ceb Anup Patel 2024-03-07  700  	int rc, cpu;
21a8f8a0eb35ceb Anup Patel 2024-03-07  701  
21a8f8a0eb35ceb Anup Patel 2024-03-07  702  	/*
21a8f8a0eb35ceb Anup Patel 2024-03-07  703  	 * Only one IMSIC instance allowed in a platform for clean
21a8f8a0eb35ceb Anup Patel 2024-03-07  704  	 * implementation of SMP IRQ affinity and per-CPU IPIs.
21a8f8a0eb35ceb Anup Patel 2024-03-07  705  	 *
21a8f8a0eb35ceb Anup Patel 2024-03-07  706  	 * This means on a multi-socket (or multi-die) platform we
21a8f8a0eb35ceb Anup Patel 2024-03-07  707  	 * will have multiple MMIO regions for one IMSIC instance.
21a8f8a0eb35ceb Anup Patel 2024-03-07  708  	 */
21a8f8a0eb35ceb Anup Patel 2024-03-07  709  	if (imsic) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  710  		pr_err("%pfwP: already initialized hence ignoring\n", fwnode);
21a8f8a0eb35ceb Anup Patel 2024-03-07  711  		return -EALREADY;
21a8f8a0eb35ceb Anup Patel 2024-03-07  712  	}
21a8f8a0eb35ceb Anup Patel 2024-03-07  713  
21a8f8a0eb35ceb Anup Patel 2024-03-07  714  	if (!riscv_isa_extension_available(NULL, SxAIA)) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  715  		pr_err("%pfwP: AIA support not available\n", fwnode);
21a8f8a0eb35ceb Anup Patel 2024-03-07  716  		return -ENODEV;
21a8f8a0eb35ceb Anup Patel 2024-03-07  717  	}
21a8f8a0eb35ceb Anup Patel 2024-03-07  718  
21a8f8a0eb35ceb Anup Patel 2024-03-07  719  	imsic = kzalloc(sizeof(*imsic), GFP_KERNEL);
21a8f8a0eb35ceb Anup Patel 2024-03-07  720  	if (!imsic)
21a8f8a0eb35ceb Anup Patel 2024-03-07  721  		return -ENOMEM;
21a8f8a0eb35ceb Anup Patel 2024-03-07  722  	imsic->fwnode = fwnode;
21a8f8a0eb35ceb Anup Patel 2024-03-07  723  	global = &imsic->global;
21a8f8a0eb35ceb Anup Patel 2024-03-07  724  
21a8f8a0eb35ceb Anup Patel 2024-03-07  725  	global->local = alloc_percpu(typeof(*global->local));
21a8f8a0eb35ceb Anup Patel 2024-03-07  726  	if (!global->local) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  727  		rc = -ENOMEM;
21a8f8a0eb35ceb Anup Patel 2024-03-07  728  		goto out_free_priv;
21a8f8a0eb35ceb Anup Patel 2024-03-07  729  	}
21a8f8a0eb35ceb Anup Patel 2024-03-07  730  
21a8f8a0eb35ceb Anup Patel 2024-03-07  731  	/* Parse IMSIC fwnode */
21a8f8a0eb35ceb Anup Patel 2024-03-07  732  	rc = imsic_parse_fwnode(fwnode, global, &nr_parent_irqs, &nr_mmios);
21a8f8a0eb35ceb Anup Patel 2024-03-07  733  	if (rc)
21a8f8a0eb35ceb Anup Patel 2024-03-07  734  		goto out_free_local;
21a8f8a0eb35ceb Anup Patel 2024-03-07  735  
21a8f8a0eb35ceb Anup Patel 2024-03-07  736  	/* Allocate MMIO resource array */
21a8f8a0eb35ceb Anup Patel 2024-03-07  737  	mmios = kcalloc(nr_mmios, sizeof(*mmios), GFP_KERNEL);
21a8f8a0eb35ceb Anup Patel 2024-03-07  738  	if (!mmios) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  739  		rc = -ENOMEM;
21a8f8a0eb35ceb Anup Patel 2024-03-07  740  		goto out_free_local;
21a8f8a0eb35ceb Anup Patel 2024-03-07  741  	}
21a8f8a0eb35ceb Anup Patel 2024-03-07  742  
21a8f8a0eb35ceb Anup Patel 2024-03-07  743  	/* Allocate MMIO virtual address array */
21a8f8a0eb35ceb Anup Patel 2024-03-07  744  	mmios_va = kcalloc(nr_mmios, sizeof(*mmios_va), GFP_KERNEL);
21a8f8a0eb35ceb Anup Patel 2024-03-07 @745  	if (!mmios_va) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  746  		rc = -ENOMEM;
21a8f8a0eb35ceb Anup Patel 2024-03-07  747  		goto out_iounmap;

This goto will crash.

21a8f8a0eb35ceb Anup Patel 2024-03-07  748  	}
21a8f8a0eb35ceb Anup Patel 2024-03-07  749  
21a8f8a0eb35ceb Anup Patel 2024-03-07  750  	/* Parse and map MMIO register sets */
21a8f8a0eb35ceb Anup Patel 2024-03-07  751  	for (i = 0; i < nr_mmios; i++) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  752  		rc = imsic_get_mmio_resource(fwnode, i, &mmios[i]);
21a8f8a0eb35ceb Anup Patel 2024-03-07  753  		if (rc) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  754  			pr_err("%pfwP: unable to parse MMIO regset %d\n", fwnode, i);
21a8f8a0eb35ceb Anup Patel 2024-03-07  755  			goto out_iounmap;
21a8f8a0eb35ceb Anup Patel 2024-03-07  756  		}
21a8f8a0eb35ceb Anup Patel 2024-03-07  757  
21a8f8a0eb35ceb Anup Patel 2024-03-07  758  		base_addr = mmios[i].start;
21a8f8a0eb35ceb Anup Patel 2024-03-07  759  		base_addr &= ~(BIT(global->guest_index_bits +
21a8f8a0eb35ceb Anup Patel 2024-03-07  760  				   global->hart_index_bits +
21a8f8a0eb35ceb Anup Patel 2024-03-07  761  				   IMSIC_MMIO_PAGE_SHIFT) - 1);
21a8f8a0eb35ceb Anup Patel 2024-03-07  762  		base_addr &= ~((BIT(global->group_index_bits) - 1) <<
21a8f8a0eb35ceb Anup Patel 2024-03-07  763  			       global->group_index_shift);
21a8f8a0eb35ceb Anup Patel 2024-03-07  764  		if (base_addr != global->base_addr) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  765  			rc = -EINVAL;
21a8f8a0eb35ceb Anup Patel 2024-03-07  766  			pr_err("%pfwP: address mismatch for regset %d\n", fwnode, i);
21a8f8a0eb35ceb Anup Patel 2024-03-07  767  			goto out_iounmap;
21a8f8a0eb35ceb Anup Patel 2024-03-07  768  		}
21a8f8a0eb35ceb Anup Patel 2024-03-07  769  
21a8f8a0eb35ceb Anup Patel 2024-03-07  770  		mmios_va[i] = ioremap(mmios[i].start, resource_size(&mmios[i]));
21a8f8a0eb35ceb Anup Patel 2024-03-07  771  		if (!mmios_va[i]) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  772  			rc = -EIO;
21a8f8a0eb35ceb Anup Patel 2024-03-07  773  			pr_err("%pfwP: unable to map MMIO regset %d\n", fwnode, i);
21a8f8a0eb35ceb Anup Patel 2024-03-07  774  			goto out_iounmap;
21a8f8a0eb35ceb Anup Patel 2024-03-07  775  		}
21a8f8a0eb35ceb Anup Patel 2024-03-07  776  	}
21a8f8a0eb35ceb Anup Patel 2024-03-07  777  
21a8f8a0eb35ceb Anup Patel 2024-03-07  778  	/* Initialize local (or per-CPU )state */
21a8f8a0eb35ceb Anup Patel 2024-03-07  779  	rc = imsic_local_init();
21a8f8a0eb35ceb Anup Patel 2024-03-07  780  	if (rc) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  781  		pr_err("%pfwP: failed to initialize local state\n",
21a8f8a0eb35ceb Anup Patel 2024-03-07  782  		       fwnode);
21a8f8a0eb35ceb Anup Patel 2024-03-07  783  		goto out_iounmap;
21a8f8a0eb35ceb Anup Patel 2024-03-07  784  	}
21a8f8a0eb35ceb Anup Patel 2024-03-07  785  
21a8f8a0eb35ceb Anup Patel 2024-03-07  786  	/* Configure handlers for target CPUs */
21a8f8a0eb35ceb Anup Patel 2024-03-07  787  	for (i = 0; i < nr_parent_irqs; i++) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  788  		rc = imsic_get_parent_hartid(fwnode, i, &hartid);
21a8f8a0eb35ceb Anup Patel 2024-03-07  789  		if (rc) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  790  			pr_warn("%pfwP: hart ID for parent irq%d not found\n", fwnode, i);
21a8f8a0eb35ceb Anup Patel 2024-03-07  791  			continue;
21a8f8a0eb35ceb Anup Patel 2024-03-07  792  		}
21a8f8a0eb35ceb Anup Patel 2024-03-07  793  
21a8f8a0eb35ceb Anup Patel 2024-03-07  794  		cpu = riscv_hartid_to_cpuid(hartid);
21a8f8a0eb35ceb Anup Patel 2024-03-07  795  		if (cpu < 0) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  796  			pr_warn("%pfwP: invalid cpuid for parent irq%d\n", fwnode, i);
21a8f8a0eb35ceb Anup Patel 2024-03-07  797  			continue;
21a8f8a0eb35ceb Anup Patel 2024-03-07  798  		}
21a8f8a0eb35ceb Anup Patel 2024-03-07  799  
21a8f8a0eb35ceb Anup Patel 2024-03-07  800  		/* Find MMIO location of MSI page */
21a8f8a0eb35ceb Anup Patel 2024-03-07  801  		index = nr_mmios;
21a8f8a0eb35ceb Anup Patel 2024-03-07  802  		reloff = i * BIT(global->guest_index_bits) *
21a8f8a0eb35ceb Anup Patel 2024-03-07  803  			 IMSIC_MMIO_PAGE_SZ;
21a8f8a0eb35ceb Anup Patel 2024-03-07  804  		for (j = 0; nr_mmios; j++) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  805  			if (reloff < resource_size(&mmios[j])) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  806  				index = j;
21a8f8a0eb35ceb Anup Patel 2024-03-07  807  				break;
21a8f8a0eb35ceb Anup Patel 2024-03-07  808  			}
21a8f8a0eb35ceb Anup Patel 2024-03-07  809  
21a8f8a0eb35ceb Anup Patel 2024-03-07  810  			/*
21a8f8a0eb35ceb Anup Patel 2024-03-07  811  			 * MMIO region size may not be aligned to
21a8f8a0eb35ceb Anup Patel 2024-03-07  812  			 * BIT(global->guest_index_bits) * IMSIC_MMIO_PAGE_SZ
21a8f8a0eb35ceb Anup Patel 2024-03-07  813  			 * if holes are present.
21a8f8a0eb35ceb Anup Patel 2024-03-07  814  			 */
21a8f8a0eb35ceb Anup Patel 2024-03-07  815  			reloff -= ALIGN(resource_size(&mmios[j]),
21a8f8a0eb35ceb Anup Patel 2024-03-07  816  			BIT(global->guest_index_bits) * IMSIC_MMIO_PAGE_SZ);
21a8f8a0eb35ceb Anup Patel 2024-03-07  817  		}
21a8f8a0eb35ceb Anup Patel 2024-03-07  818  		if (index >= nr_mmios) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  819  			pr_warn("%pfwP: MMIO not found for parent irq%d\n", fwnode, i);
21a8f8a0eb35ceb Anup Patel 2024-03-07  820  			continue;
21a8f8a0eb35ceb Anup Patel 2024-03-07  821  		}
21a8f8a0eb35ceb Anup Patel 2024-03-07  822  
21a8f8a0eb35ceb Anup Patel 2024-03-07  823  		local = per_cpu_ptr(global->local, cpu);
21a8f8a0eb35ceb Anup Patel 2024-03-07  824  		local->msi_pa = mmios[index].start + reloff;
21a8f8a0eb35ceb Anup Patel 2024-03-07  825  		local->msi_va = mmios_va[index] + reloff;
21a8f8a0eb35ceb Anup Patel 2024-03-07  826  
21a8f8a0eb35ceb Anup Patel 2024-03-07  827  		nr_handlers++;
21a8f8a0eb35ceb Anup Patel 2024-03-07  828  	}
21a8f8a0eb35ceb Anup Patel 2024-03-07  829  
21a8f8a0eb35ceb Anup Patel 2024-03-07  830  	/* If no CPU handlers found then can't take interrupts */
21a8f8a0eb35ceb Anup Patel 2024-03-07  831  	if (!nr_handlers) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  832  		pr_err("%pfwP: No CPU handlers found\n", fwnode);
21a8f8a0eb35ceb Anup Patel 2024-03-07  833  		rc = -ENODEV;
21a8f8a0eb35ceb Anup Patel 2024-03-07  834  		goto out_local_cleanup;
21a8f8a0eb35ceb Anup Patel 2024-03-07  835  	}
21a8f8a0eb35ceb Anup Patel 2024-03-07  836  
21a8f8a0eb35ceb Anup Patel 2024-03-07  837  	/* Initialize matrix allocator */
21a8f8a0eb35ceb Anup Patel 2024-03-07  838  	rc = imsic_matrix_init();
21a8f8a0eb35ceb Anup Patel 2024-03-07  839  	if (rc) {
21a8f8a0eb35ceb Anup Patel 2024-03-07  840  		pr_err("%pfwP: failed to create matrix allocator\n", fwnode);
21a8f8a0eb35ceb Anup Patel 2024-03-07  841  		goto out_local_cleanup;
21a8f8a0eb35ceb Anup Patel 2024-03-07  842  	}
21a8f8a0eb35ceb Anup Patel 2024-03-07  843  
21a8f8a0eb35ceb Anup Patel 2024-03-07  844  	/* We don't need MMIO arrays anymore so let's free-up */
21a8f8a0eb35ceb Anup Patel 2024-03-07  845  	kfree(mmios_va);
21a8f8a0eb35ceb Anup Patel 2024-03-07  846  	kfree(mmios);
21a8f8a0eb35ceb Anup Patel 2024-03-07  847  
21a8f8a0eb35ceb Anup Patel 2024-03-07  848  	return 0;
21a8f8a0eb35ceb Anup Patel 2024-03-07  849  
21a8f8a0eb35ceb Anup Patel 2024-03-07  850  out_local_cleanup:
21a8f8a0eb35ceb Anup Patel 2024-03-07  851  	imsic_local_cleanup();
21a8f8a0eb35ceb Anup Patel 2024-03-07  852  out_iounmap:
21a8f8a0eb35ceb Anup Patel 2024-03-07  853  	for (i = 0; i < nr_mmios; i++) {
21a8f8a0eb35ceb Anup Patel 2024-03-07 @854  		if (mmios_va[i])
                                                            ^^^^^^^^^^^

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


