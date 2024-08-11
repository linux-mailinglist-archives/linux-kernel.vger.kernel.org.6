Return-Path: <linux-kernel+bounces-282269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE1F94E17B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA58A28160D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848AD1494C3;
	Sun, 11 Aug 2024 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWHLV/V4"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE34148FFC
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723383417; cv=none; b=TOJ/vbb4YKyapsOKwZuzL45p86TDSYxYOJxf7jQldX4RfbBLXtWCB0Hsb6Lk9hz8RbzRSj6+rctZtKtbyAfOHBwqdWDXPZsSBlULei0XoFDrcOWZDE+b5fxvuthAyXUUhGsKIDuPRkj9BbEz159rtmEk7rbBYsdwJzHdretrFSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723383417; c=relaxed/simple;
	bh=AjhSzCCRpwX2SIA54WBYVm8ImmaPiSzWx0ZqwEodCVw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YrN9gsdvEdX3ca1421xPXGsXZNoqs9BosYq7KBq/7EG07TfDh0Q/Es+5uC+A0qB0eruZOssbh5xcr/tbFysigeqH4eeYgxte/LfsszlqbDpeiYwfq6Bm8CMrKXyZA0luV2lECT8q2mHAW/+V554gnN8RqyCVohXMzZAjN/HNxXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MWHLV/V4; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso36210611fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 06:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723383414; x=1723988214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cig1+J77dIPekmdgbTlikcW8VVCG5pt4tWITgQBHG4I=;
        b=MWHLV/V4Ko/tPy2RNhZiC7zsMdKbGOrSQVCNx9VARFMaI7G+ytEEhP1UmjnQcufeYL
         aMY5mfs8jb7P+IRJ6PuUn0daTpxoTZN3G/s2UpRKFKw9NIFYO9VddypowVAHZBlyOqWc
         daPTZztD+0wQVkgmJyUNuqgFqHqIrtOu+0Y1elN+Zf+oyCQ4oZYzSTWAHT745SOfaSt8
         kaAPqMC0jF/5HOgON4trby6JI+dhT0+MQjm87zeQxjjHqvUMzya8ySPkhKGmR7XvElsL
         SrKWYMAXYOE6Pn7hI+Ut4vXQI1NMdw5qEsD7UMRi4sTSAFO+WzWu6CRsZeeW+dKl571D
         132Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723383414; x=1723988214;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cig1+J77dIPekmdgbTlikcW8VVCG5pt4tWITgQBHG4I=;
        b=pWsnDJnbO8kpGUemM7O3KgJAEHgAD6Dlku3XRD3krePs8HAr0OlxG/F099S3iv4VMG
         NdBfQJkE32hBpIsZqBztUashfnIZ8W0BmntqMszEpd6ezFnhuw00uersVpQ+lgD88SvB
         Nwd8eSZqMEyw45jeqFWob9zIQiA8neHCiGWyrx/STFYx3AS/ohMiix9a6y/Yz2zs1R5C
         ZuoyBvk3waligH57vABTleU3va/PcxHT49zTVspZ4UOlPQBAObPBcyqCELRlBsnCtIE4
         EP45IGkB8RR5o9JpasMmO4oDqBt2qizRdaUKlSxcyet7ScfoD9ZIMVmvKhlp7loOfZCt
         JmAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmaMeWI2VBovJbWSleVw4H7UiHjZlGCvgW18JOgZUBH7CXpRW32UsLKrWMSy31eJYtQdjC1V+WRnASBn+V4aocrVr6UXEXK8wM5Xnh
X-Gm-Message-State: AOJu0YxJcmWBcfko1IIk8Cub/KfkhGGDRyzt2wbZSmc/iJJGKnTL7dbA
	wOI+8JaPkWfD1WClbQKGHELGeWptEc6oiTatuszCBUYG0PsHObSoIQJTI6/C138=
X-Google-Smtp-Source: AGHT+IHt33AuHPjxUd4uOwuYX+OCWuwzGXpabOgvFL5h/RJY7EsClSLXTXMTL71IPhLvH3UFICIxFw==
X-Received: by 2002:a05:6512:3b08:b0:52f:c24b:1767 with SMTP id 2adb3069b0e04-530ee9742f8mr4787738e87.19.1723383413675;
        Sun, 11 Aug 2024 06:36:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb0e1288sm147807766b.80.2024.08.11.06.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 06:36:53 -0700 (PDT)
Date: Sun, 11 Aug 2024 16:36:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] phy: starfive: jh7110-usb: Fix link configuration to
 controller
Message-ID: <053d3e9f-ba32-406c-a799-91ea577a0cb9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd7b125c8c797f9d63440944df7121f9db0a49ad.1722457123.git.jan.kiszka@siemens.com>

Hi Jan,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Kiszka/dt-bindings-phy-jh7110-usb-phy-Add-sys-syscon-property/20240802-101748
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/cd7b125c8c797f9d63440944df7121f9db0a49ad.1722457123.git.jan.kiszka%40siemens.com
patch subject: [PATCH 3/3] phy: starfive: jh7110-usb: Fix link configuration to controller
config: microblaze-randconfig-r072-20240810 (https://download.01.org/0day-ci/archive/20240811/202408110917.hE9xidPH-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202408110917.hE9xidPH-lkp@intel.com/

smatch warnings:
drivers/phy/starfive/phy-jh7110-usb.c:148 jh7110_usb_phy_probe() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +148 drivers/phy/starfive/phy-jh7110-usb.c

16d3a71c20cf2e Minda Chen 2023-06-29  109  static int jh7110_usb_phy_probe(struct platform_device *pdev)
16d3a71c20cf2e Minda Chen 2023-06-29  110  {
16d3a71c20cf2e Minda Chen 2023-06-29  111  	struct jh7110_usb2_phy *phy;
16d3a71c20cf2e Minda Chen 2023-06-29  112  	struct device *dev = &pdev->dev;
16d3a71c20cf2e Minda Chen 2023-06-29  113  	struct phy_provider *phy_provider;
0ed73d833230fd Jan Kiszka 2024-07-31  114  	u32 args[1];
16d3a71c20cf2e Minda Chen 2023-06-29  115  
16d3a71c20cf2e Minda Chen 2023-06-29  116  	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
16d3a71c20cf2e Minda Chen 2023-06-29  117  	if (!phy)
16d3a71c20cf2e Minda Chen 2023-06-29  118  		return -ENOMEM;
16d3a71c20cf2e Minda Chen 2023-06-29  119  
16d3a71c20cf2e Minda Chen 2023-06-29  120  	phy->usb_125m_clk = devm_clk_get(dev, "125m");
16d3a71c20cf2e Minda Chen 2023-06-29  121  	if (IS_ERR(phy->usb_125m_clk))
16d3a71c20cf2e Minda Chen 2023-06-29  122  		return dev_err_probe(dev, PTR_ERR(phy->usb_125m_clk),
16d3a71c20cf2e Minda Chen 2023-06-29  123  			"Failed to get 125m clock\n");
16d3a71c20cf2e Minda Chen 2023-06-29  124  
16d3a71c20cf2e Minda Chen 2023-06-29  125  	phy->app_125m = devm_clk_get(dev, "app_125m");
16d3a71c20cf2e Minda Chen 2023-06-29  126  	if (IS_ERR(phy->app_125m))
16d3a71c20cf2e Minda Chen 2023-06-29  127  		return dev_err_probe(dev, PTR_ERR(phy->app_125m),
16d3a71c20cf2e Minda Chen 2023-06-29  128  			"Failed to get app 125m clock\n");
16d3a71c20cf2e Minda Chen 2023-06-29  129  
16d3a71c20cf2e Minda Chen 2023-06-29  130  	phy->regs = devm_platform_ioremap_resource(pdev, 0);
16d3a71c20cf2e Minda Chen 2023-06-29  131  	if (IS_ERR(phy->regs))
16d3a71c20cf2e Minda Chen 2023-06-29  132  		return dev_err_probe(dev, PTR_ERR(phy->regs),
16d3a71c20cf2e Minda Chen 2023-06-29  133  			"Failed to map phy base\n");
16d3a71c20cf2e Minda Chen 2023-06-29  134  
16d3a71c20cf2e Minda Chen 2023-06-29  135  	phy->phy = devm_phy_create(dev, NULL, &jh7110_usb2_phy_ops);
16d3a71c20cf2e Minda Chen 2023-06-29  136  	if (IS_ERR(phy->phy))
16d3a71c20cf2e Minda Chen 2023-06-29  137  		return dev_err_probe(dev, PTR_ERR(phy->phy),
16d3a71c20cf2e Minda Chen 2023-06-29  138  			"Failed to create phy\n");
16d3a71c20cf2e Minda Chen 2023-06-29  139  
16d3a71c20cf2e Minda Chen 2023-06-29  140  	phy_set_drvdata(phy->phy, phy);
16d3a71c20cf2e Minda Chen 2023-06-29  141  	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
16d3a71c20cf2e Minda Chen 2023-06-29  142  
0ed73d833230fd Jan Kiszka 2024-07-31  143  	phy->sys_syscon =
0ed73d833230fd Jan Kiszka 2024-07-31  144  		syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node,
0ed73d833230fd Jan Kiszka 2024-07-31  145  						     "starfive,sys-syscon",
0ed73d833230fd Jan Kiszka 2024-07-31  146  						     1, args);
0ed73d833230fd Jan Kiszka 2024-07-31  147  	if (IS_ERR(phy->sys_syscon))
0ed73d833230fd Jan Kiszka 2024-07-31 @148  		return dev_err_probe(dev, PTR_ERR(phy->phy),

Passing the wrong variable.  It should be phy->sys_syscon instead of phy->phy.

0ed73d833230fd Jan Kiszka 2024-07-31  149  			"Failed to get sys-syscon\n");
0ed73d833230fd Jan Kiszka 2024-07-31  150  	phy->sys_phy_connect = args[0];
0ed73d833230fd Jan Kiszka 2024-07-31  151  
16d3a71c20cf2e Minda Chen 2023-06-29  152  	return PTR_ERR_OR_ZERO(phy_provider);
16d3a71c20cf2e Minda Chen 2023-06-29  153  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


