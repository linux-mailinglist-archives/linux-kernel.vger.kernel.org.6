Return-Path: <linux-kernel+bounces-403804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CC29C3B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83734B224E7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AB1156997;
	Mon, 11 Nov 2024 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SkYMK80u"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CF815687C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318006; cv=none; b=pZd0DJJKJyKFWBskkM6BHWGSeFW8y4Wpt3XZc810HzUY9AkW50cXK4P+x6bubJVRbma789bK5I1ZJBqh+jg/5ilMGTpPgEqwKIfzuyY8n5TKbxLiXnuK/CGSxZDLKKKIgQLTM2Gx3XgZlV1EO4njK6lfL6ZJxsEOZBtSdlzxHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318006; c=relaxed/simple;
	bh=SrePIxSbFYjj2HfNvSNCaCC5bOfkmhdL4/yJT9sPHp8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KIujdiVau8xnlX5he6JF177yREdETOm/iA/Vb57tcsCNoKW4CxcbH+NsI9BCZX2Lv2n2CNWPrFsmozhaArfIDIfqSU9vI8JGIWkEbyckNFgayR2h48ZLyWLlfdvIx8QcdUWx2rSj9zIAy9LTEXx9jTNxVQBG6fWjXx/AatlnFQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SkYMK80u; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ceca7df7f0so5630189a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731318002; x=1731922802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8uq+o2vFZJUqX4/y2uQm9wgc0uDfnPCbnfiej+5FcGg=;
        b=SkYMK80uK+Bnsm2xABboWe/iLl13dzi0kw0gPUKvS8i4MQYsQLRm6o5qL5hVX693CU
         OFa5hDuSbSqjlJvPDtL2MjQ81aXUbMUhFjJ8Aafn0fuBViuuQgEO3JVqAJ5FL91zlkRn
         KT8SlLL10vYqqZr6fDCgG9X+Y3ZfZlVSDIM91mjVpVQ8iy2WO7jMLgGBeAGcsrvVwIN/
         QXmBVMnPooWivJVBenX5qgocK8wZqq0MpGOE6cEpAHoHlC1Xg5hXuhVRhdlLlsDs68WQ
         i2zD552r570+WksEl0XpCmnVeXzac6wFERyQgAyzaGh7x6gNsN+H7CQmFNNBB1knRRti
         371w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318002; x=1731922802;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uq+o2vFZJUqX4/y2uQm9wgc0uDfnPCbnfiej+5FcGg=;
        b=s40Ehusc6L6QycxlbflluNPRFXbY6Mt90STnaQhnXlnNhvZq+d/nhe0nJYllrefrmv
         SMYMtwLjPJDwKLBWAK0edGeztsu61e+tILqk6oPLub77S9H4Mh9nfnXjmT2UKq0EaMo5
         5igF5AUKp/kqIDk6SbZ+vZ77nazigzKpSNpkSkfUijGwKPcCTWuXu4Cj+wNwS53fCid/
         SlRQRkzdXHOVLc5kQqJnt1xlneqJ3kIE59NZAG8ePMTK/fnEOw2ymLKQYxLjOYnkA2bn
         WR3bXzhBUrIUQaaueFA2knz+T5b1AGTYwCuYbgacSC6JeKrv5Cy63HFRFv2HdeaAntQo
         E8AA==
X-Forwarded-Encrypted: i=1; AJvYcCU0FhHHd2SJ38ahMANjdYeOBhTMe4G66LSvtpjKp9YXntyE/JYXAXj2H8SpZhq9bGjFmAM4BwoZkejGm1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdrW8OPjaNAgqSS8Vf3fP/QyU0UbAEo71bo3qGb6kugNEO3GF9
	J9bPyzIULxtUP/BQzg8Ul1MLE+XDvDBSb0mIX6iUhqAOAApC5oj9Pd/v7rZgxkg=
X-Google-Smtp-Source: AGHT+IEtwIpih366270iEmy7zBPiGHFqTs9kQiN6axsaFrcWpMU4sHgBmIXXbVCyVCYkUQP1Knn9+w==
X-Received: by 2002:a05:6402:3198:b0:5ce:c9ae:347e with SMTP id 4fb4d7f45d1cf-5cf0a45d167mr7750194a12.30.1731318002466;
        Mon, 11 Nov 2024 01:40:02 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb85f5sm4646840a12.53.2024.11.11.01.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:40:01 -0800 (PST)
Date: Mon, 11 Nov 2024 12:39:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Vitalii Mordan <mordan@ispras.ru>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Vitalii Mordan <mordan@ispras.ru>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>
Subject: Re: [PATCH net v2]: stmmac: dwmac-intel-plat: fix call balance of
 tx_clk handling routines
Message-ID: <e1b263d8-adc0-455b-adf1-9247fae1b320@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108173334.2973603-1-mordan@ispras.ru>

Hi Vitalii,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Vitalii-Mordan/stmmac-dwmac-intel-plat-fix-call-balance-of-tx_clk-handling-routines/20241109-013647
base:   net/main
patch link:    https://lore.kernel.org/r/20241108173334.2973603-1-mordan%40ispras.ru
patch subject: [PATCH net v2]: stmmac: dwmac-intel-plat: fix call balance of tx_clk handling routines
config: arm-randconfig-r071-20241110 (https://download.01.org/0day-ci/archive/20241111/202411110911.fxtHBKSw-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202411110911.fxtHBKSw-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c:163 intel_eth_plat_probe() error: we previously assumed 'dwmac->data' could be null (see line 101)

vim +163 drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c

9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   75  static int intel_eth_plat_probe(struct platform_device *pdev)
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   76  {
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   77  	struct plat_stmmacenet_data *plat_dat;
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   78  	struct stmmac_resources stmmac_res;
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   79  	struct intel_dwmac *dwmac;
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   80  	unsigned long rate;
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   81  	int ret;
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   82  
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   83  	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   84  	if (ret)
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   85  		return ret;
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   86  
abea8fd5e801a6 Jisheng Zhang        2023-09-16   87  	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   88  	if (IS_ERR(plat_dat)) {
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   89  		dev_err(&pdev->dev, "dt configuration failed\n");
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   90  		return PTR_ERR(plat_dat);
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   91  	}
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   92  
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   93  	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
abea8fd5e801a6 Jisheng Zhang        2023-09-16   94  	if (!dwmac)
abea8fd5e801a6 Jisheng Zhang        2023-09-16   95  		return -ENOMEM;
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   96  
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   97  	dwmac->dev = &pdev->dev;
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   98  	dwmac->tx_clk = NULL;
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26   99  
b0377116decdee Rob Herring          2023-10-09  100  	dwmac->data = device_get_match_data(&pdev->dev);
b0377116decdee Rob Herring          2023-10-09 @101  	if (dwmac->data) {
                                                            ^^^^^^^^^^^
Check for NULL

9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  102  		if (dwmac->data->fix_mac_speed)
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  103  			plat_dat->fix_mac_speed = dwmac->data->fix_mac_speed;
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  104  
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  105  		/* Enable TX clock */
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  106  		if (dwmac->data->tx_clk_en) {
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  107  			dwmac->tx_clk = devm_clk_get(&pdev->dev, "tx_clk");
abea8fd5e801a6 Jisheng Zhang        2023-09-16  108  			if (IS_ERR(dwmac->tx_clk))
abea8fd5e801a6 Jisheng Zhang        2023-09-16  109  				return PTR_ERR(dwmac->tx_clk);
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  110  
bd8cfad17c9530 Vitalii Mordan       2024-11-08  111  			ret = clk_prepare_enable(dwmac->tx_clk);
bd8cfad17c9530 Vitalii Mordan       2024-11-08  112  			if (ret) {
bd8cfad17c9530 Vitalii Mordan       2024-11-08  113  				dev_err(&pdev->dev,
bd8cfad17c9530 Vitalii Mordan       2024-11-08  114  					"Failed to enable tx_clk\n");
bd8cfad17c9530 Vitalii Mordan       2024-11-08  115  				return ret;
bd8cfad17c9530 Vitalii Mordan       2024-11-08  116  			}
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  117  
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  118  			/* Check and configure TX clock rate */
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  119  			rate = clk_get_rate(dwmac->tx_clk);
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  120  			if (dwmac->data->tx_clk_rate &&
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  121  			    rate != dwmac->data->tx_clk_rate) {
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  122  				rate = dwmac->data->tx_clk_rate;
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  123  				ret = clk_set_rate(dwmac->tx_clk, rate);
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  124  				if (ret) {
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  125  					dev_err(&pdev->dev,
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  126  						"Failed to set tx_clk\n");
bd8cfad17c9530 Vitalii Mordan       2024-11-08  127  					goto err_tx_clk_disable;
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  128  				}
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  129  			}
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  130  		}
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  131  
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  132  		/* Check and configure PTP ref clock rate */
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  133  		rate = clk_get_rate(plat_dat->clk_ptp_ref);
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  134  		if (dwmac->data->ptp_ref_clk_rate &&
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  135  		    rate != dwmac->data->ptp_ref_clk_rate) {
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  136  			rate = dwmac->data->ptp_ref_clk_rate;
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  137  			ret = clk_set_rate(plat_dat->clk_ptp_ref, rate);
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  138  			if (ret) {
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  139  				dev_err(&pdev->dev,
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  140  					"Failed to set clk_ptp_ref\n");
bd8cfad17c9530 Vitalii Mordan       2024-11-08  141  				goto err_tx_clk_disable;
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  142  			}
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  143  		}
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  144  	}
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  145  
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  146  	plat_dat->bsp_priv = dwmac;
b4c5f83ae3f3e2 Rusaimi Amira Ruslan 2020-09-28  147  	plat_dat->eee_usecs_rate = plat_dat->clk_ptp_rate;
b4c5f83ae3f3e2 Rusaimi Amira Ruslan 2020-09-28  148  
b4c5f83ae3f3e2 Rusaimi Amira Ruslan 2020-09-28  149  	if (plat_dat->eee_usecs_rate > 0) {
b4c5f83ae3f3e2 Rusaimi Amira Ruslan 2020-09-28  150  		u32 tx_lpi_usec;
b4c5f83ae3f3e2 Rusaimi Amira Ruslan 2020-09-28  151  
b4c5f83ae3f3e2 Rusaimi Amira Ruslan 2020-09-28  152  		tx_lpi_usec = (plat_dat->eee_usecs_rate / 1000000) - 1;
b4c5f83ae3f3e2 Rusaimi Amira Ruslan 2020-09-28  153  		writel(tx_lpi_usec, stmmac_res.addr + GMAC_1US_TIC_COUNTER);
b4c5f83ae3f3e2 Rusaimi Amira Ruslan 2020-09-28  154  	}
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  155  
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  156  	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
bd8cfad17c9530 Vitalii Mordan       2024-11-08  157  	if (ret)
bd8cfad17c9530 Vitalii Mordan       2024-11-08  158  		goto err_tx_clk_disable;
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  159  
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  160  	return 0;
bd8cfad17c9530 Vitalii Mordan       2024-11-08  161  
bd8cfad17c9530 Vitalii Mordan       2024-11-08  162  err_tx_clk_disable:
bd8cfad17c9530 Vitalii Mordan       2024-11-08 @163  	if (dwmac->data->tx_clk_en)
                                                            ^^^^^^^^^^^^^
Unchecked dereference

bd8cfad17c9530 Vitalii Mordan       2024-11-08  164  		clk_disable_unprepare(dwmac->tx_clk);
bd8cfad17c9530 Vitalii Mordan       2024-11-08  165  	return ret;
9efc9b2b04c74e Rusaimi Amira Ruslan 2020-08-26  166  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


