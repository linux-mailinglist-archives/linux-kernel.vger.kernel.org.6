Return-Path: <linux-kernel+bounces-403805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE3C9C3B10
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD651F20F53
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAFD175D54;
	Mon, 11 Nov 2024 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CboJN/wZ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F7F16C6A1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318010; cv=none; b=B7xh9Qr/HeVjxqAyZtajN6NmCazd7Vv8uwJlUFzszG1wvrjNkyyw7yNqGGAFHkArDTZ8p30Ria0AI8TZ4kU417jejTjY9qdBM+KjmXoPqHNVblvI7hCfTODd21p01VXQpKm/B7CNRM2Gjj1K/ksye5ceZBsw/zjjcQvFtdNIVUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318010; c=relaxed/simple;
	bh=eVbFQ8eRmgwQjhyZDrpzmXZtLQtDVQOa42qdW6+BPsA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AbbYaycjUqkrObLEt357W9j4vBMHvrqPB+XpCOs9Dlo74XWsZU49/rgeLeuKsL2RTBx1KYVbssupIG2rlEFO3qTACj+qEe3ET2xx1FMAphhr+Tes9c1SaSe6t2D9+FQ1zvDmId0jCXsPBQzd8YCYaXxnaT+VrmrGT6w38H812ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CboJN/wZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cec7cde922so5958424a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731318006; x=1731922806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RL5ouNz62J4rP7Vb2EwmgbN1hwLbAAvQeLoAfZ/ypHo=;
        b=CboJN/wZx/s0KPqzs5G8KiJdfT0nBRV1sPV3gNT/W+zJdhJrw6Ekl046AJLjx+m36W
         JCFXCqlXKsJhQvvp15uZ3D6sYVZtA+1OKF3CXm7stUxm4Mph/m9SxDFstILaKP39j21y
         kFpxhWlNTS0YlWrN553BD8+1xJChy4fB/5A+N/GvxQXIv6Ylh8MLewPkJ59velzXeoKA
         qV6XpSkBGjwbt38JYE/cjsCJ2gsCNzvBSb+klUeijdN928zdeS2TFDg9Gm03XaKpE/cw
         ZSE9xQ1bBzouj/h6OspbtBm3VzxE12MJwo8hNQlvjoGKxoJgmkx6lilFVOdIjHa2Pc2m
         IJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318006; x=1731922806;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RL5ouNz62J4rP7Vb2EwmgbN1hwLbAAvQeLoAfZ/ypHo=;
        b=wrziYsLKdkGVi4JJ53z5YUCuAPC21snknILZYU3fe8yCoRgx/2RB591JtQrrQXaNfv
         pcX00wBM1NUEEFLmTAb8sk8QFOdr1ehT4piQtg8qNgLj8m/p5sWWxRttzZjFC0mmFJlW
         9ooAwvLiK8AET/eu15pxKq7lrPESsikOPHDQGNJPqUU3GAd78yYhrjYHRo1fNB2L9Oww
         zURN5m+VVx3E8B9v99scEMAFzxoNBxt7Z4gY87ZeaMV3BDhcuhoZooB0k9fia+yGhE8l
         jdlk6g5p+S/NHfHZUOxyMvkcQuPyfCHe5ONF5HW4PlA6bj93pXahrmx1tmcXa2XBnes/
         Rzww==
X-Forwarded-Encrypted: i=1; AJvYcCVAmO9dqOjv6i5jGaUEp/45T9ItFCDza64UHw9/Zr7JOog+SuR7MANHo2M0ulTfRWk9BuCW+mH3c6d/5fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIZxIEd03Or+GyITM91ii6mPHAate9qI0a/fMnhTQssV+CpA9k
	aur6QO1NatfrzXIMioTtZvsGdoy5je3RMGhdJVHTGNyTyu7Uv21E+/qNB2jH8rg=
X-Google-Smtp-Source: AGHT+IF/p+575+YNR2OJr4WYmzHEumA5ro2KoQ7Lo/HcKAeV1re5jL3XLj3j1AdmsGeHCshinHqVXw==
X-Received: by 2002:a05:6402:13ce:b0:5ce:ddd4:7c2f with SMTP id 4fb4d7f45d1cf-5cf0a30c5dcmr10678581a12.7.1731318006331;
        Mon, 11 Nov 2024 01:40:06 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf0f369037sm3560713a12.12.2024.11.11.01.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:40:06 -0800 (PST)
Date: Mon, 11 Nov 2024 12:38:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Rosen Penev <rosenp@gmail.com>,
	netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	Chris Snook <chris.snook@gmail.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] net: modernize ioremap in probe
Message-ID: <0460e9ea-3d2b-425b-9e97-c69afe138670@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109233641.8313-1-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-modernize-ioremap-in-probe/20241110-073751
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241109233641.8313-1-rosenp%40gmail.com
patch subject: [PATCH] net: modernize ioremap in probe
config: arm-randconfig-r071-20241110 (https://download.01.org/0day-ci/archive/20241111/202411110835.tTxOya6U-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202411110835.tTxOya6U-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/freescale/xgmac_mdio.c:395 xgmac_mdio_probe() error: uninitialized symbol 'res'.

vim +/res +395 drivers/net/ethernet/freescale/xgmac_mdio.c

33897cc869eef8 Bill Pemberton    2012-12-03  371  static int xgmac_mdio_probe(struct platform_device *pdev)
9f35a7342cff0b Timur Tabi        2012-08-20  372  {
ac53c26433b51f Marcin Wojtas     2021-06-25  373  	struct fwnode_handle *fwnode;
73ee5442978b2d Shaohui Xie       2015-03-16  374  	struct mdio_fsl_priv *priv;
15e7064e879335 Calvin Johnson    2021-06-11  375  	struct resource *res;
15e7064e879335 Calvin Johnson    2021-06-11  376  	struct mii_bus *bus;
9f35a7342cff0b Timur Tabi        2012-08-20  377  	int ret;
9f35a7342cff0b Timur Tabi        2012-08-20  378  
229f4bb47512ec Calvin Johnson    2020-06-22  379  	/* In DPAA-1, MDIO is one of the many FMan sub-devices. The FMan
229f4bb47512ec Calvin Johnson    2020-06-22  380  	 * defines a register space that spans a large area, covering all the
229f4bb47512ec Calvin Johnson    2020-06-22  381  	 * subdevice areas. Therefore, MDIO cannot claim exclusive access to
229f4bb47512ec Calvin Johnson    2020-06-22  382  	 * this register area.
229f4bb47512ec Calvin Johnson    2020-06-22  383  	 */
9f35a7342cff0b Timur Tabi        2012-08-20  384  
1d14eb15dc2c39 Tobias Waldekranz 2022-01-26  385  	bus = devm_mdiobus_alloc_size(&pdev->dev, sizeof(struct mdio_fsl_priv));
9f35a7342cff0b Timur Tabi        2012-08-20  386  	if (!bus)
9f35a7342cff0b Timur Tabi        2012-08-20  387  		return -ENOMEM;
9f35a7342cff0b Timur Tabi        2012-08-20  388  
9f35a7342cff0b Timur Tabi        2012-08-20  389  	bus->name = "Freescale XGMAC MDIO Bus";
c0fc8e6dcee40c Andrew Lunn       2023-01-09  390  	bus->read = xgmac_mdio_read_c22;
c0fc8e6dcee40c Andrew Lunn       2023-01-09  391  	bus->write = xgmac_mdio_write_c22;
c0fc8e6dcee40c Andrew Lunn       2023-01-09  392  	bus->read_c45 = xgmac_mdio_read_c45;
c0fc8e6dcee40c Andrew Lunn       2023-01-09  393  	bus->write_c45 = xgmac_mdio_write_c45;
9f35a7342cff0b Timur Tabi        2012-08-20  394  	bus->parent = &pdev->dev;
229f4bb47512ec Calvin Johnson    2020-06-22 @395  	snprintf(bus->id, MII_BUS_ID_SIZE, "%pa", &res->start);
                                                                                                   ^^^
res isn't initialized.

9f35a7342cff0b Timur Tabi        2012-08-20  396  
73ee5442978b2d Shaohui Xie       2015-03-16  397  	priv = bus->priv;
865bbb2945a161 Rosen Penev       2024-11-09  398  	priv->mdio_base = devm_platform_ioremap_resource(pdev, 0);
865bbb2945a161 Rosen Penev       2024-11-09  399  	if (IS_ERR(priv->mdio_base))
865bbb2945a161 Rosen Penev       2024-11-09  400  		return PTR_ERR(priv->mdio_base);
9f35a7342cff0b Timur Tabi        2012-08-20  401  
15e7064e879335 Calvin Johnson    2021-06-11  402  	/* For both ACPI and DT cases, endianness of MDIO controller
15e7064e879335 Calvin Johnson    2021-06-11  403  	 * needs to be specified using "little-endian" property.
15e7064e879335 Calvin Johnson    2021-06-11  404  	 */
229f4bb47512ec Calvin Johnson    2020-06-22  405  	priv->is_little_endian = device_property_read_bool(&pdev->dev,
07bf2e11ad0586 Julia Lawall      2016-08-05  406  							   "little-endian");
73ee5442978b2d Shaohui Xie       2015-03-16  407  
6198c722019774 Tobias Waldekranz 2022-01-18  408  	priv->has_a009885 = device_property_read_bool(&pdev->dev,
6198c722019774 Tobias Waldekranz 2022-01-18  409  						      "fsl,erratum-a009885");
229f4bb47512ec Calvin Johnson    2020-06-22  410  	priv->has_a011043 = device_property_read_bool(&pdev->dev,
1d3ca681b9d957 Madalin Bucur     2020-01-22  411  						      "fsl,erratum-a011043");
1d3ca681b9d957 Madalin Bucur     2020-01-22  412  
909bea73485fab Tobias Waldekranz 2022-01-26  413  	xgmac_mdio_set_suppress_preamble(bus);
909bea73485fab Tobias Waldekranz 2022-01-26  414  
dd8f467eda72cd Tobias Waldekranz 2022-01-26  415  	ret = xgmac_mdio_set_mdc_freq(bus);
dd8f467eda72cd Tobias Waldekranz 2022-01-26  416  	if (ret)
dd8f467eda72cd Tobias Waldekranz 2022-01-26  417  		return ret;
dd8f467eda72cd Tobias Waldekranz 2022-01-26  418  
105b0468d7b2e6 zhaoxiao          2022-08-18  419  	fwnode = dev_fwnode(&pdev->dev);
ac53c26433b51f Marcin Wojtas     2021-06-25  420  	if (is_of_node(fwnode))
ac53c26433b51f Marcin Wojtas     2021-06-25  421  		ret = of_mdiobus_register(bus, to_of_node(fwnode));
ac53c26433b51f Marcin Wojtas     2021-06-25  422  	else if (is_acpi_node(fwnode))
ac53c26433b51f Marcin Wojtas     2021-06-25  423  		ret = acpi_mdiobus_register(bus, fwnode);
ac53c26433b51f Marcin Wojtas     2021-06-25  424  	else
ac53c26433b51f Marcin Wojtas     2021-06-25  425  		ret = -EINVAL;
9f35a7342cff0b Timur Tabi        2012-08-20  426  	if (ret) {
9f35a7342cff0b Timur Tabi        2012-08-20  427  		dev_err(&pdev->dev, "cannot register MDIO bus\n");
9f35a7342cff0b Timur Tabi        2012-08-20  428  		return ret;
9f35a7342cff0b Timur Tabi        2012-08-20  429  	}
9f35a7342cff0b Timur Tabi        2012-08-20  430  
1d14eb15dc2c39 Tobias Waldekranz 2022-01-26  431  	platform_set_drvdata(pdev, bus);
9f35a7342cff0b Timur Tabi        2012-08-20  432  
9f35a7342cff0b Timur Tabi        2012-08-20  433  	return 0;
9f35a7342cff0b Timur Tabi        2012-08-20  434  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


