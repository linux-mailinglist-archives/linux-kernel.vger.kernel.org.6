Return-Path: <linux-kernel+bounces-168643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47BB8BBB29
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CB51C21310
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E971622611;
	Sat,  4 May 2024 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i90fqYed"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E669210E6
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714825125; cv=none; b=YlBzXELSnsre674COrcy/y6FnYPmUmCv19jRrI90FS0WVUySNq1uLeAdmaJONVpfijaALOntvTgX9jSF9/C0S6Z8Qw6c+Vps/RDZo+3r/Qa0bJ08IA4e0DDry6x3aWhk3PG3h8zqCQ4vnuynk2J8UNZYoPWZzwAmrctOLPPizJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714825125; c=relaxed/simple;
	bh=KvX+tMQC35r8Zw36jjxi/3yW/6yDNWHuAjrkLFnobVs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LvcDW5sAdCOpdixgsKoceFGiLCh48Y9I6qlrOwG30vxWq0QqxG97dlS2VVk2HHIcHaiFv0NOl3JvAqhWQipZLCSIqWmer7SLuNQ3/BLO4Y4e6mv8dYaQ8pJQAsrJVfO6Z0+d5OWghKO6v4y8VIDTTqxECb215o6CA/83h3uBHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i90fqYed; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2db17e8767cso6198311fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714825121; x=1715429921; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z/7UJGubfMelKvbYDiZ/Mv2wY5bh+9xHKgfJKuvSMK4=;
        b=i90fqYedibpTvviBchDodkq12U2OhNB/W7iLKyRNuxssS/Hq/N129zgAjj/clPE8C7
         QqI4npdwuGmwB4p/ZNLbVNnHw8sLU773OO/B4PSKb2iG9PQPHpsxQEpRw+3QgCHCnmFq
         KzoKAzX3AhjlgEhTv+DdvpQb6EsbXegSaJHxRuoaYWmVWha4MVpidQKmdku++zDx4pdy
         mCEGj1MAgh91XyYVPXUjEmpDa6wHtxGzAuMtSVsARJniqvAxwM94EgbcNfRgqyI12NDd
         61ap8tTw4eBOnF6j+5xiOhPjEKFzwI77Fh6c/vowCzbTZQaX4PLPPwrekhnJ/1tkM3ww
         VGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714825121; x=1715429921;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/7UJGubfMelKvbYDiZ/Mv2wY5bh+9xHKgfJKuvSMK4=;
        b=hoEOWwRW5lLpZfDJU2PKTV76Yo5UGtCUd88ioM6TMo1glfjaI2Ct9sjQQUjRqxzQL+
         BspbpgV4bhI7pT1ZeNGoO9+uN1XpiXUpaCB6f/3mkb84JE4dcx99BqSoBfI2YEVuounm
         i7HepBtgdNvztyJFNn1R0tiHToefvSRbSQh8hWbks9PuHEF8yPCbR78vjClm48arq8Wh
         2f/d5Y6xzfmInVNfNDjodkx49HG6F4NsOAdsNL8L+d8v+UyTSAChBPBLf2XWJOQOOxGa
         HPainaYG94HMHdfA32T4f/tTr+ILCWPpZpO9wbseLK1gwyKEKh2+4uip6/IbDILuuNO8
         bNOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk1MXmyIsbitPCKyX13XJq5+tqWHFj44qqJjeKY/yPr8gRA8TG4rKceGSLEcXysEKdMc0fOuQ9TiQP5P1yr/ay1h63zgoBF51S3YDV
X-Gm-Message-State: AOJu0Yx1nnYvys5+LlFi9YRGdEe6gxmmKqQFZK+WsjgSfSg4lTrd8QR/
	lW486AcB97X/W9T28SgYRqK2LaA7GhjqzRJQSZ1Do5KJVZX/UGA3JSsxqaeB+io=
X-Google-Smtp-Source: AGHT+IEMl3/9+VdMxzxvYyxuTl4RsZq5GUNid+YtiRDPqktYL2gYS0YU1UFZkgLtuk9S3nLdXGTH9w==
X-Received: by 2002:a05:651c:201c:b0:2dd:c9fc:c472 with SMTP id s28-20020a05651c201c00b002ddc9fcc472mr3128640ljo.26.1714825121362;
        Sat, 04 May 2024 05:18:41 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id y12-20020a5d614c000000b0034dd3849eeasm6105031wrt.106.2024.05.04.05.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 05:18:41 -0700 (PDT)
Date: Sat, 4 May 2024 15:18:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, kamilh@axis.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] net: phy: bcm-phy-lib: Implement BroadR-Reach
 link modes
Message-ID: <586a9bc8-aa2a-4312-8936-a10f18e1f9ce@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503083719.899312-4-kamilh@axis.com>

Hi Kamil,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kamil-Hor-k-2N/net-phy-bcm54811-New-link-mode-for-BroadR-Reach/20240503-164308
base:   net/main
patch link:    https://lore.kernel.org/r/20240503083719.899312-4-kamilh%40axis.com
patch subject: [PATCH v2 3/3] net: phy: bcm-phy-lib: Implement BroadR-Reach link modes
config: i386-randconfig-141-20240504 (https://download.01.org/0day-ci/archive/20240504/202405041037.sjZak003-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202405041037.sjZak003-lkp@intel.com/

smatch warnings:
drivers/net/phy/broadcom.c:627 bcm5481x_config_delay_swap() error: uninitialized symbol 'ret'.
drivers/net/phy/broadcom.c:1249 bcm_read_master_slave() error: uninitialized symbol 'cfg'.

vim +/ret +627 drivers/net/phy/broadcom.c

f1e9c8e593d6ea Kamil Horák - 2N 2024-05-03  611  static int bcm5481x_config_delay_swap(struct phy_device *phydev)
57bb7e222804c6 Anton Vorontsov  2008-03-04  612  {
b14995ac2527b4 Jon Mason        2016-11-04  613  	struct device_node *np = phydev->mdio.dev.of_node;
57bb7e222804c6 Anton Vorontsov  2008-03-04  614  	int ret;
57bb7e222804c6 Anton Vorontsov  2008-03-04  615  
f1e9c8e593d6ea Kamil Horák - 2N 2024-05-03  616  	/* Set up the delay. */
042cb56478152b Tao Ren          2018-11-05  617  	bcm54xx_config_clock_delay(phydev);
57bb7e222804c6 Anton Vorontsov  2008-03-04  618  
b14995ac2527b4 Jon Mason        2016-11-04  619  	if (of_property_read_bool(np, "enet-phy-lane-swap")) {
b14995ac2527b4 Jon Mason        2016-11-04  620  		/* Lane Swap - Undocumented register...magic! */
b14995ac2527b4 Jon Mason        2016-11-04  621  		ret = bcm_phy_write_exp(phydev, MII_BCM54XX_EXP_SEL_ER + 0x9,
b14995ac2527b4 Jon Mason        2016-11-04  622  					0x11B);
b14995ac2527b4 Jon Mason        2016-11-04  623  		if (ret < 0)
b14995ac2527b4 Jon Mason        2016-11-04  624  			return ret;
b14995ac2527b4 Jon Mason        2016-11-04  625  	}

"ret" not initialized on else path.

b14995ac2527b4 Jon Mason        2016-11-04  626  
57bb7e222804c6 Anton Vorontsov  2008-03-04 @627  	return ret;

Also "return 0;" is always better.

57bb7e222804c6 Anton Vorontsov  2008-03-04  628  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


