Return-Path: <linux-kernel+bounces-390034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04DF9B74B9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8432818D1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D96146D6E;
	Thu, 31 Oct 2024 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f1CHPdMq"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99E13D516
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730357544; cv=none; b=dJpdi34PiaOHO6ItgdUwmZ21hFkYxeDKw4ZqukrXnTX3v/jNPsIyjcaL14W/h1kmmlRH3LWoYPu3VWIAfw7+TTDSWPt6lvVoUT3WEUO9/KIGUcqfBONOwpindh2LcELXLiXzaL8iZpIuSnR3bknukf0gL6utRvR+MCflzymDLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730357544; c=relaxed/simple;
	bh=Hpc19UvuOAgM7DLU7J0IV7Im2WpnYRLz2nMo8Iaf7pI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=een4KO4VYUyRoTHhQa02rTFfU6vRIQvUrtbkhUHqRifQM2aq8TBmIA/TCpGMAJLN/gPMQYwxyjfTmylZY0+s9+6trUlYynXcGoL1KgVVppnwSmA7ryOXRlKF8sPup2saEQ8cyHuqB2t0hHGTQNBITyIY/skKjl6R7jDgfN6lHnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f1CHPdMq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43169902057so4768325e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 23:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730357538; x=1730962338; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IizVsT/GHCokG6ch8Vz2KAn7z8iSbuR7G4okx8PJozc=;
        b=f1CHPdMqdedRkgfRiFs5PZwIDlbKdOz+VnU9AIDdB/d5V3r9zKYDA7lnNuNFx2qLd5
         xfgpkJGzskm6/1ldTd5stlvPHBjWRHdCT0WXdgMGr4vheT/vQJvWF1sCqAspHzkarV/r
         OFgYlo+S/HVe0ziclA3D5yCXWPJWVppegbUxe7lN0GcjpuwqoXz9wW8c+bmGZDUwAsY8
         GbscZ49Rm7YadC8fOJpY8TVkaen2qCqZNFyZ8xDVu4ys4Qmg18KK3W0o2QjjybVtZ+I4
         g/C3KndYSP4+ZSSNvWfrF6foLaopoP3Wi/lelGFwKVK8zyH/CMu0OIcOQJBlbffvfSOS
         0WxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730357538; x=1730962338;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IizVsT/GHCokG6ch8Vz2KAn7z8iSbuR7G4okx8PJozc=;
        b=Dr23MW6hnMJ/FjNE7GoVaw1Zum0vXuKIpX3mv0v5KhWtjd/WDBfXx8F3+FjQFLB/CG
         leZDAeG8gG8d0W3VFC+leNOLS6GOOuEoDJqn4RiQlRAXTHyfhi+RI0UXvS9JBmNTjpn3
         2WdvASPek6CAl5uofP1ZrjiAORwopAxGBNZcnUn09jcYTibj19996srZOEqJcJs0rzNM
         470g4zrN9SCsKjWtSsQu15nWRRUxdzSAtdF+LGx6lJ187yw/DBTlyQyrzQ+eKJfSJBlP
         eC6qbpxm3sGvF7z8Vhf0Uh6jtDITdR+AZaKa5tKS0fNn/BeY528jd/xLQHve9Y/Z0o4l
         07Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVYIXNDh54r8OI0CqAUU2ljQAfT32Qf3bmVR3x6jcdyIE8Z5BgUmJpywwtoG0iieKxeXp9UXMDq7gaqa1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9lQHb1e9K6NLnDhdTwmeedkUgdtxrJsp6vvQPUKnMkgU9XBtz
	HDs3mNlF7qwHRaQ6M5ifjlzT1uDYBPg+kp9ztkwKwJSzsA7ypTX8Z/hTJd/CYKM=
X-Google-Smtp-Source: AGHT+IH4qddoN1+U0MbhWmJDa+VnavcPzI2xaGtcVbjz7mSSqTDKJfqNz6qwKOPhNncZR4OKRDuBwA==
X-Received: by 2002:a05:600c:1c29:b0:431:588a:4498 with SMTP id 5b1f17b1804b1-431bb985df9mr48408435e9.14.1730357538111;
        Wed, 30 Oct 2024 23:52:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7d15sm1117170f8f.8.2024.10.30.23.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:52:17 -0700 (PDT)
Date: Thu, 31 Oct 2024 09:52:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Anup Patel <apatel@ventanamicro.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: drivers/irqchip/irq-riscv-imsic-state.c:854 imsic_setup_state()
 error: we previously assumed 'mmios_va' could be null (see line 745)
Message-ID: <d954517a-ec1d-43b6-beef-b15f9f289612@stanley.mountain>
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
head:   4236f913808cebef1b9e078726a4e5d56064f7ad
commit: 0eebc69db358fd2f6fe34cc4db6428df6a540dd7 RISC-V: Select APLIC and IMSIC drivers
date:   7 months ago
config: riscv-randconfig-r071-20241030 (https://download.01.org/0day-ci/archive/20241031/202410310641.Nrmy8Sr0-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202410310641.Nrmy8Sr0-lkp@intel.com/

New smatch warnings:
drivers/irqchip/irq-riscv-imsic-state.c:854 imsic_setup_state() error: we previously assumed 'mmios_va' could be null (see line 745)

vim +/mmios_va +854 drivers/irqchip/irq-riscv-imsic-state.c

21a8f8a0eb35ce Anup Patel 2024-03-07  691  int __init imsic_setup_state(struct fwnode_handle *fwnode)
21a8f8a0eb35ce Anup Patel 2024-03-07  692  {
21a8f8a0eb35ce Anup Patel 2024-03-07  693  	u32 i, j, index, nr_parent_irqs, nr_mmios, nr_handlers = 0;
21a8f8a0eb35ce Anup Patel 2024-03-07  694  	struct imsic_global_config *global;
21a8f8a0eb35ce Anup Patel 2024-03-07  695  	struct imsic_local_config *local;
21a8f8a0eb35ce Anup Patel 2024-03-07  696  	void __iomem **mmios_va = NULL;
21a8f8a0eb35ce Anup Patel 2024-03-07  697  	struct resource *mmios = NULL;
21a8f8a0eb35ce Anup Patel 2024-03-07  698  	unsigned long reloff, hartid;
21a8f8a0eb35ce Anup Patel 2024-03-07  699  	phys_addr_t base_addr;
21a8f8a0eb35ce Anup Patel 2024-03-07  700  	int rc, cpu;
21a8f8a0eb35ce Anup Patel 2024-03-07  701  
21a8f8a0eb35ce Anup Patel 2024-03-07  702  	/*
21a8f8a0eb35ce Anup Patel 2024-03-07  703  	 * Only one IMSIC instance allowed in a platform for clean
21a8f8a0eb35ce Anup Patel 2024-03-07  704  	 * implementation of SMP IRQ affinity and per-CPU IPIs.
21a8f8a0eb35ce Anup Patel 2024-03-07  705  	 *
21a8f8a0eb35ce Anup Patel 2024-03-07  706  	 * This means on a multi-socket (or multi-die) platform we
21a8f8a0eb35ce Anup Patel 2024-03-07  707  	 * will have multiple MMIO regions for one IMSIC instance.
21a8f8a0eb35ce Anup Patel 2024-03-07  708  	 */
21a8f8a0eb35ce Anup Patel 2024-03-07  709  	if (imsic) {
21a8f8a0eb35ce Anup Patel 2024-03-07  710  		pr_err("%pfwP: already initialized hence ignoring\n", fwnode);
21a8f8a0eb35ce Anup Patel 2024-03-07  711  		return -EALREADY;
21a8f8a0eb35ce Anup Patel 2024-03-07  712  	}
21a8f8a0eb35ce Anup Patel 2024-03-07  713  
21a8f8a0eb35ce Anup Patel 2024-03-07  714  	if (!riscv_isa_extension_available(NULL, SxAIA)) {
21a8f8a0eb35ce Anup Patel 2024-03-07  715  		pr_err("%pfwP: AIA support not available\n", fwnode);
21a8f8a0eb35ce Anup Patel 2024-03-07  716  		return -ENODEV;
21a8f8a0eb35ce Anup Patel 2024-03-07  717  	}
21a8f8a0eb35ce Anup Patel 2024-03-07  718  
21a8f8a0eb35ce Anup Patel 2024-03-07  719  	imsic = kzalloc(sizeof(*imsic), GFP_KERNEL);
21a8f8a0eb35ce Anup Patel 2024-03-07  720  	if (!imsic)
21a8f8a0eb35ce Anup Patel 2024-03-07  721  		return -ENOMEM;
21a8f8a0eb35ce Anup Patel 2024-03-07  722  	imsic->fwnode = fwnode;
21a8f8a0eb35ce Anup Patel 2024-03-07  723  	global = &imsic->global;
21a8f8a0eb35ce Anup Patel 2024-03-07  724  
21a8f8a0eb35ce Anup Patel 2024-03-07  725  	global->local = alloc_percpu(typeof(*global->local));
21a8f8a0eb35ce Anup Patel 2024-03-07  726  	if (!global->local) {
21a8f8a0eb35ce Anup Patel 2024-03-07  727  		rc = -ENOMEM;
21a8f8a0eb35ce Anup Patel 2024-03-07  728  		goto out_free_priv;
21a8f8a0eb35ce Anup Patel 2024-03-07  729  	}
21a8f8a0eb35ce Anup Patel 2024-03-07  730  
21a8f8a0eb35ce Anup Patel 2024-03-07  731  	/* Parse IMSIC fwnode */
21a8f8a0eb35ce Anup Patel 2024-03-07  732  	rc = imsic_parse_fwnode(fwnode, global, &nr_parent_irqs, &nr_mmios);
21a8f8a0eb35ce Anup Patel 2024-03-07  733  	if (rc)
21a8f8a0eb35ce Anup Patel 2024-03-07  734  		goto out_free_local;
21a8f8a0eb35ce Anup Patel 2024-03-07  735  
21a8f8a0eb35ce Anup Patel 2024-03-07  736  	/* Allocate MMIO resource array */
21a8f8a0eb35ce Anup Patel 2024-03-07  737  	mmios = kcalloc(nr_mmios, sizeof(*mmios), GFP_KERNEL);
21a8f8a0eb35ce Anup Patel 2024-03-07  738  	if (!mmios) {
21a8f8a0eb35ce Anup Patel 2024-03-07  739  		rc = -ENOMEM;
21a8f8a0eb35ce Anup Patel 2024-03-07  740  		goto out_free_local;
21a8f8a0eb35ce Anup Patel 2024-03-07  741  	}
21a8f8a0eb35ce Anup Patel 2024-03-07  742  
21a8f8a0eb35ce Anup Patel 2024-03-07  743  	/* Allocate MMIO virtual address array */
21a8f8a0eb35ce Anup Patel 2024-03-07  744  	mmios_va = kcalloc(nr_mmios, sizeof(*mmios_va), GFP_KERNEL);
21a8f8a0eb35ce Anup Patel 2024-03-07 @745  	if (!mmios_va) {
21a8f8a0eb35ce Anup Patel 2024-03-07  746  		rc = -ENOMEM;
21a8f8a0eb35ce Anup Patel 2024-03-07  747  		goto out_iounmap;

mmios_va is NULL here.

21a8f8a0eb35ce Anup Patel 2024-03-07  748  	}
21a8f8a0eb35ce Anup Patel 2024-03-07  749  
21a8f8a0eb35ce Anup Patel 2024-03-07  750  	/* Parse and map MMIO register sets */
21a8f8a0eb35ce Anup Patel 2024-03-07  751  	for (i = 0; i < nr_mmios; i++) {
21a8f8a0eb35ce Anup Patel 2024-03-07  752  		rc = imsic_get_mmio_resource(fwnode, i, &mmios[i]);
21a8f8a0eb35ce Anup Patel 2024-03-07  753  		if (rc) {
21a8f8a0eb35ce Anup Patel 2024-03-07  754  			pr_err("%pfwP: unable to parse MMIO regset %d\n", fwnode, i);
21a8f8a0eb35ce Anup Patel 2024-03-07  755  			goto out_iounmap;
21a8f8a0eb35ce Anup Patel 2024-03-07  756  		}
21a8f8a0eb35ce Anup Patel 2024-03-07  757  
21a8f8a0eb35ce Anup Patel 2024-03-07  758  		base_addr = mmios[i].start;
21a8f8a0eb35ce Anup Patel 2024-03-07  759  		base_addr &= ~(BIT(global->guest_index_bits +
21a8f8a0eb35ce Anup Patel 2024-03-07  760  				   global->hart_index_bits +
21a8f8a0eb35ce Anup Patel 2024-03-07  761  				   IMSIC_MMIO_PAGE_SHIFT) - 1);
21a8f8a0eb35ce Anup Patel 2024-03-07  762  		base_addr &= ~((BIT(global->group_index_bits) - 1) <<
21a8f8a0eb35ce Anup Patel 2024-03-07  763  			       global->group_index_shift);
21a8f8a0eb35ce Anup Patel 2024-03-07  764  		if (base_addr != global->base_addr) {
21a8f8a0eb35ce Anup Patel 2024-03-07  765  			rc = -EINVAL;
21a8f8a0eb35ce Anup Patel 2024-03-07  766  			pr_err("%pfwP: address mismatch for regset %d\n", fwnode, i);
21a8f8a0eb35ce Anup Patel 2024-03-07  767  			goto out_iounmap;
21a8f8a0eb35ce Anup Patel 2024-03-07  768  		}
21a8f8a0eb35ce Anup Patel 2024-03-07  769  
21a8f8a0eb35ce Anup Patel 2024-03-07  770  		mmios_va[i] = ioremap(mmios[i].start, resource_size(&mmios[i]));
21a8f8a0eb35ce Anup Patel 2024-03-07  771  		if (!mmios_va[i]) {
21a8f8a0eb35ce Anup Patel 2024-03-07  772  			rc = -EIO;
21a8f8a0eb35ce Anup Patel 2024-03-07  773  			pr_err("%pfwP: unable to map MMIO regset %d\n", fwnode, i);
21a8f8a0eb35ce Anup Patel 2024-03-07  774  			goto out_iounmap;
21a8f8a0eb35ce Anup Patel 2024-03-07  775  		}
21a8f8a0eb35ce Anup Patel 2024-03-07  776  	}
21a8f8a0eb35ce Anup Patel 2024-03-07  777  
21a8f8a0eb35ce Anup Patel 2024-03-07  778  	/* Initialize local (or per-CPU )state */
21a8f8a0eb35ce Anup Patel 2024-03-07  779  	rc = imsic_local_init();
21a8f8a0eb35ce Anup Patel 2024-03-07  780  	if (rc) {
21a8f8a0eb35ce Anup Patel 2024-03-07  781  		pr_err("%pfwP: failed to initialize local state\n",
21a8f8a0eb35ce Anup Patel 2024-03-07  782  		       fwnode);
21a8f8a0eb35ce Anup Patel 2024-03-07  783  		goto out_iounmap;
21a8f8a0eb35ce Anup Patel 2024-03-07  784  	}
21a8f8a0eb35ce Anup Patel 2024-03-07  785  
21a8f8a0eb35ce Anup Patel 2024-03-07  786  	/* Configure handlers for target CPUs */
21a8f8a0eb35ce Anup Patel 2024-03-07  787  	for (i = 0; i < nr_parent_irqs; i++) {
21a8f8a0eb35ce Anup Patel 2024-03-07  788  		rc = imsic_get_parent_hartid(fwnode, i, &hartid);
21a8f8a0eb35ce Anup Patel 2024-03-07  789  		if (rc) {
21a8f8a0eb35ce Anup Patel 2024-03-07  790  			pr_warn("%pfwP: hart ID for parent irq%d not found\n", fwnode, i);
21a8f8a0eb35ce Anup Patel 2024-03-07  791  			continue;
21a8f8a0eb35ce Anup Patel 2024-03-07  792  		}
21a8f8a0eb35ce Anup Patel 2024-03-07  793  
21a8f8a0eb35ce Anup Patel 2024-03-07  794  		cpu = riscv_hartid_to_cpuid(hartid);
21a8f8a0eb35ce Anup Patel 2024-03-07  795  		if (cpu < 0) {
21a8f8a0eb35ce Anup Patel 2024-03-07  796  			pr_warn("%pfwP: invalid cpuid for parent irq%d\n", fwnode, i);
21a8f8a0eb35ce Anup Patel 2024-03-07  797  			continue;
21a8f8a0eb35ce Anup Patel 2024-03-07  798  		}
21a8f8a0eb35ce Anup Patel 2024-03-07  799  
21a8f8a0eb35ce Anup Patel 2024-03-07  800  		/* Find MMIO location of MSI page */
21a8f8a0eb35ce Anup Patel 2024-03-07  801  		index = nr_mmios;
21a8f8a0eb35ce Anup Patel 2024-03-07  802  		reloff = i * BIT(global->guest_index_bits) *
21a8f8a0eb35ce Anup Patel 2024-03-07  803  			 IMSIC_MMIO_PAGE_SZ;
21a8f8a0eb35ce Anup Patel 2024-03-07  804  		for (j = 0; nr_mmios; j++) {
21a8f8a0eb35ce Anup Patel 2024-03-07  805  			if (reloff < resource_size(&mmios[j])) {
21a8f8a0eb35ce Anup Patel 2024-03-07  806  				index = j;
21a8f8a0eb35ce Anup Patel 2024-03-07  807  				break;
21a8f8a0eb35ce Anup Patel 2024-03-07  808  			}
21a8f8a0eb35ce Anup Patel 2024-03-07  809  
21a8f8a0eb35ce Anup Patel 2024-03-07  810  			/*
21a8f8a0eb35ce Anup Patel 2024-03-07  811  			 * MMIO region size may not be aligned to
21a8f8a0eb35ce Anup Patel 2024-03-07  812  			 * BIT(global->guest_index_bits) * IMSIC_MMIO_PAGE_SZ
21a8f8a0eb35ce Anup Patel 2024-03-07  813  			 * if holes are present.
21a8f8a0eb35ce Anup Patel 2024-03-07  814  			 */
21a8f8a0eb35ce Anup Patel 2024-03-07  815  			reloff -= ALIGN(resource_size(&mmios[j]),
21a8f8a0eb35ce Anup Patel 2024-03-07  816  			BIT(global->guest_index_bits) * IMSIC_MMIO_PAGE_SZ);
21a8f8a0eb35ce Anup Patel 2024-03-07  817  		}
21a8f8a0eb35ce Anup Patel 2024-03-07  818  		if (index >= nr_mmios) {
21a8f8a0eb35ce Anup Patel 2024-03-07  819  			pr_warn("%pfwP: MMIO not found for parent irq%d\n", fwnode, i);
21a8f8a0eb35ce Anup Patel 2024-03-07  820  			continue;
21a8f8a0eb35ce Anup Patel 2024-03-07  821  		}
21a8f8a0eb35ce Anup Patel 2024-03-07  822  
21a8f8a0eb35ce Anup Patel 2024-03-07  823  		local = per_cpu_ptr(global->local, cpu);
21a8f8a0eb35ce Anup Patel 2024-03-07  824  		local->msi_pa = mmios[index].start + reloff;
21a8f8a0eb35ce Anup Patel 2024-03-07  825  		local->msi_va = mmios_va[index] + reloff;
21a8f8a0eb35ce Anup Patel 2024-03-07  826  
21a8f8a0eb35ce Anup Patel 2024-03-07  827  		nr_handlers++;
21a8f8a0eb35ce Anup Patel 2024-03-07  828  	}
21a8f8a0eb35ce Anup Patel 2024-03-07  829  
21a8f8a0eb35ce Anup Patel 2024-03-07  830  	/* If no CPU handlers found then can't take interrupts */
21a8f8a0eb35ce Anup Patel 2024-03-07  831  	if (!nr_handlers) {
21a8f8a0eb35ce Anup Patel 2024-03-07  832  		pr_err("%pfwP: No CPU handlers found\n", fwnode);
21a8f8a0eb35ce Anup Patel 2024-03-07  833  		rc = -ENODEV;
21a8f8a0eb35ce Anup Patel 2024-03-07  834  		goto out_local_cleanup;
21a8f8a0eb35ce Anup Patel 2024-03-07  835  	}
21a8f8a0eb35ce Anup Patel 2024-03-07  836  
21a8f8a0eb35ce Anup Patel 2024-03-07  837  	/* Initialize matrix allocator */
21a8f8a0eb35ce Anup Patel 2024-03-07  838  	rc = imsic_matrix_init();
21a8f8a0eb35ce Anup Patel 2024-03-07  839  	if (rc) {
21a8f8a0eb35ce Anup Patel 2024-03-07  840  		pr_err("%pfwP: failed to create matrix allocator\n", fwnode);
21a8f8a0eb35ce Anup Patel 2024-03-07  841  		goto out_local_cleanup;
21a8f8a0eb35ce Anup Patel 2024-03-07  842  	}
21a8f8a0eb35ce Anup Patel 2024-03-07  843  
21a8f8a0eb35ce Anup Patel 2024-03-07  844  	/* We don't need MMIO arrays anymore so let's free-up */
21a8f8a0eb35ce Anup Patel 2024-03-07  845  	kfree(mmios_va);
21a8f8a0eb35ce Anup Patel 2024-03-07  846  	kfree(mmios);
21a8f8a0eb35ce Anup Patel 2024-03-07  847  
21a8f8a0eb35ce Anup Patel 2024-03-07  848  	return 0;
21a8f8a0eb35ce Anup Patel 2024-03-07  849  
21a8f8a0eb35ce Anup Patel 2024-03-07  850  out_local_cleanup:
21a8f8a0eb35ce Anup Patel 2024-03-07  851  	imsic_local_cleanup();
21a8f8a0eb35ce Anup Patel 2024-03-07  852  out_iounmap:
21a8f8a0eb35ce Anup Patel 2024-03-07  853  	for (i = 0; i < nr_mmios; i++) {
21a8f8a0eb35ce Anup Patel 2024-03-07 @854  		if (mmios_va[i])
                                                            ^^^^^^^^^^^
NULL dereference.  It's unfortunate that the zero day bot doesn't include the
next lines in the email...

   881                          iounmap(mmios_va[i]);
   882          }

Add a new label here.

   883          kfree(mmios_va);
   884          kfree(mmios);
   885  out_free_local:
   886          free_percpu(imsic->global.local);
   887  out_free_priv:
   888          kfree(imsic);
   889          imsic = NULL;
   890          return rc;
   891  }



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


