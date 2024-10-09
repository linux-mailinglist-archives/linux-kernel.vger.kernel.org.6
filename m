Return-Path: <linux-kernel+bounces-357582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7319972EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7102EB25245
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70751DEFCE;
	Wed,  9 Oct 2024 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="spd+cY//"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511761D318A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494383; cv=none; b=jVhSY/fuWdUaHuh1eZs0O0iH4kQ6mjChJD3QqwEZ3z96P8zq/WPnS2FhZPXQcoe8UpjNOa2cPvK4v4yEuiZfvmwIRXm8ymIQZ54V9n4VcwBySrtShjTRrVlSBFQ4D0q9oeQXrOf0Drdz69WO5XD3hN0Z3DJiqmKxYmMKHp2rRns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494383; c=relaxed/simple;
	bh=D1RCBvolVwGk1YmkaU7qNRk2q+gp97D7sSRe7bDMJQU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DLaOJgWGaMbwWPQ/FRgI2bdCPEwvcqBdnHrN5ZgH5y598PAw9uXudDo6fusfDf4skAF0yESCpiKniql7yt51HgrLPZF8S055mVuhe1BX1BmMn77eaiv6ScmPeYjAybz6q5vFzKGXoDfvnqLBABl0EDh1s60wppj2YZfsQNoLvn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=spd+cY//; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37cd8a5aac9so3746627f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728494379; x=1729099179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=afIn8IMjC7kf2X5Y3tpOFzs6699YGBAZhINwB+OZxK4=;
        b=spd+cY//BeIHIZ+Lxo6JM0j0JVpmfB26t9COIf1QfA3gBsYHe/jyNuzxpIgQxLgVPg
         FhcJ2rVI1ZzRqDYgV4ba3hvx2cJAJNTDQbyGd02b7IidS3VYhMDo2jbTk+IZ3wB5JxqO
         /VKZQVFYi0JQFulauMMAeKTh/Z1swiMRm3iCe6ZESMfjrXKiQBKILXbb7+wzUgnEUC3G
         7BDfFZDYOrhbllq970wLrL3T7MhOopURazuJQ/txtERO1g9qQEEdh0qQ622FcPeUjDNa
         S3DFv8ts6oLkoVLvH5+Ikm5gPYB9XAB17gbNLsGCwS+N4bmvCng1vf10o/kKZ61IWfgH
         5Gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728494379; x=1729099179;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afIn8IMjC7kf2X5Y3tpOFzs6699YGBAZhINwB+OZxK4=;
        b=AR9fVazhPnrUWURFNdHIPQBoZmPmRme9biDhnaNkOTWIsKkM+XGQESTmjv8YaOLKgV
         2iIf5SGIN+9cMscpvom7Uzr7g1TbG1br46aBavmJDJXuhUHTjHScoywI2qRLFGEqLYKH
         asp7anMb/NvRQfZ+03v7h0S/xbj1psjJk1FhD9xMlQsRIgA4/Ymzinu+PXfi3SbFoAW+
         RaPfAWVF+kQi52gPEjLmERIk6xuuwXJ1MZNfbBSpg8Gs+UMLOzW3qWOS+x+FgbCDLcIM
         XGHNPsdih3SymAz9QR/PeEqU76kgcrI61ayps4LN+Jn8tWIVsruZzyP6yzjQL7dO5p/k
         d5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwHlKlkSfq9mLrzpwa3epyT+/0jOotes1RJ27QOurY870xCJQj2hK3EOlKCNH9d+KjQgSB3z/+5bjz8KY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7VCmToM1yigtm07Qkr8pZ3vcpflze4wQZtu2DLE8YxyTn34fm
	OnGQ1zjlO9EiiMm1qaSEPk5uVKQvGJVMu8PiP2F3BdBTrv+mlJ9TG74AkB4Sg28=
X-Google-Smtp-Source: AGHT+IESN+5zvgJDcQvJ5AH0Ne9NxWaWaYKKtugic6yzuEwVsthJkTHx5JeUb7jgicH67N+SNJp8CA==
X-Received: by 2002:adf:a2d0:0:b0:374:c977:363 with SMTP id ffacd0b85a97d-37d3a9efa92mr2050350f8f.24.1728494379512;
        Wed, 09 Oct 2024 10:19:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f767sm10882855f8f.20.2024.10.09.10.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:19:39 -0700 (PDT)
Date: Wed, 9 Oct 2024 20:19:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Anand Moon <linux.amoon@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v6 RESET 1/3] PCI: rockchip: Simplify clock handling by
 using clk_bulk*() function
Message-ID: <614d3e0e-10ba-4c13-a309-1e4305b5951a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006182445.3713-2-linux.amoon@gmail.com>

Hi Anand,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Moon/PCI-rockchip-Simplify-clock-handling-by-using-clk_bulk-function/20241007-022714
base:   8f602276d3902642fdc3429b548d73c745446601
patch link:    https://lore.kernel.org/r/20241006182445.3713-2-linux.amoon%40gmail.com
patch subject: [PATCH v6 RESET 1/3] PCI: rockchip: Simplify clock handling by using clk_bulk*() function
config: loongarch-randconfig-r071-20241009 (https://download.01.org/0day-ci/archive/20241010/202410100015.9W01OqrR-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202410100015.9W01OqrR-lkp@intel.com/

smatch warnings:
drivers/pci/controller/pcie-rockchip.c:132 rockchip_pcie_parse_dt() warn: passing zero to 'dev_err_probe'

vim +/dev_err_probe +132 drivers/pci/controller/pcie-rockchip.c

964bac9455bee7 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2018-05-09  122  	if (rockchip->is_rc) {
58adbfb3ebec46 drivers/pci/controller/pcie-rockchip.c Chen-Yu Tsai          2021-01-22  123  		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep",
840b7a5edf88fe drivers/pci/controller/pcie-rockchip.c Manivannan Sadhasivam 2024-04-16  124  							    GPIOD_OUT_LOW);
58adbfb3ebec46 drivers/pci/controller/pcie-rockchip.c Chen-Yu Tsai          2021-01-22  125  		if (IS_ERR(rockchip->ep_gpio))
58adbfb3ebec46 drivers/pci/controller/pcie-rockchip.c Chen-Yu Tsai          2021-01-22  126  			return dev_err_probe(dev, PTR_ERR(rockchip->ep_gpio),
58adbfb3ebec46 drivers/pci/controller/pcie-rockchip.c Chen-Yu Tsai          2021-01-22  127  					     "failed to get ep GPIO\n");
e77f847df54c6b drivers/pci/host/pcie-rockchip.c       Shawn Lin             2016-09-03  128  	}
e77f847df54c6b drivers/pci/host/pcie-rockchip.c       Shawn Lin             2016-09-03  129  
9a8ff91a0ee96b drivers/pci/controller/pcie-rockchip.c Anand Moon            2024-10-06  130  	rockchip->num_clks = devm_clk_bulk_get_all(dev, &rockchip->clks);
9a8ff91a0ee96b drivers/pci/controller/pcie-rockchip.c Anand Moon            2024-10-06  131  	if (rockchip->num_clks < 0)
9a8ff91a0ee96b drivers/pci/controller/pcie-rockchip.c Anand Moon            2024-10-06 @132  		return dev_err_probe(dev, err, "failed to get clocks\n");
                                                                                                                                  ^^^
Was intended to be rockchip->num_clks.

4816c4c7b82b55 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2016-12-07  133  
964bac9455bee7 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2018-05-09  134  	return 0;
4816c4c7b82b55 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2016-12-07  135  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


