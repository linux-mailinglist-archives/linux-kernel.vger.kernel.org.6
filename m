Return-Path: <linux-kernel+bounces-224025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E464C911C19
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676491F24634
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9A4167DA0;
	Fri, 21 Jun 2024 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9Lftrd6"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30587130ADA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718952331; cv=none; b=u+dkK6lTeFVDYITdzmYa/7VCNK+P95JtmBviVJRMnn2LTB5WYLCpNT50ymwnob5igzRccWRAtqjgN85FCZw2rZ1k35/qIh+TMn8A5HBt9c1tlmY/BaPJZljQnLl1IKdSifMrs4l4ywYOW1U2fwRcecwI4DDfvRNtxjU2vXBx5q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718952331; c=relaxed/simple;
	bh=CpakMGBjVArJKEohlvyKPx8MWVCmNQuSsutsRiluHbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bwCt97xupfbJ5eJUUTaUkwfxieDgjH1vawCp4YYv5qgjvjVEbEDAOzMO0DHtSyxrs1+X9HvFfSONGvmUatvehTdjKkpT5d9Dj8cwDlyPRowrZ3iaUCW9Xl909S+3Ic2whhTWjFV4FIC8+WJDI8ULHKiinBHY46vjbOGEiL87Qnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S9Lftrd6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6f1da33826so204275266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718952328; x=1719557128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LOYpscBQcVLtcb6ya8dy1caHHgeSBmzhIDNmZBhcMlI=;
        b=S9Lftrd6vgpGT/m0fe0CbDJQtmbXknP8+PpIn4zkrxJT5k/S5pi2R8EdxOqfpqQ/NV
         jpMJAMGzOGZd5l57lLBYvV9ANBfswoyXCqXJGCafUNX9QiKE00mIQ9Dv3b7k/yhJiXWm
         RZFKjdRjNXT3Y/kGbXHXtnic+xfW9NccZVoDmYyQ6rcuQfxNyPUpVYOz5jPqgZeOMPNh
         tLz7B8ubIZkyNfJ7SD7KV0uPvSE0mrC5rfVCZn41x8W7NhjpL287CWrlKxLRUaP98Xth
         /aIGWbOo5AA06IeRTEZBLzkN3pk7wzH/ejGdFjPHutMnSSREFpgQaDNEEWsaWsPlFZaU
         tkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718952328; x=1719557128;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOYpscBQcVLtcb6ya8dy1caHHgeSBmzhIDNmZBhcMlI=;
        b=c2c+N4kF/ULpPcWV51IzbEjJSLGfyeZ63dSYM7It4jLOqg5awS10x+vyiZCU6v/A33
         DfRCoFrlNVrpmvwPJrT98OUDC57t4p0pBYXUQqxMy1O2CYjYH2p6AWAAxzhd8eUnsO9a
         yzWWDi7t7Xzp63DbkmHx5zw+5NRtyapnIZgpe98y3vIVDy72DxQkTd8/2iQDf4WPJjRc
         FdGDkbllY/nY7WRa7Kv4J1FJqXTyPbZS0Qpxg/Kedx2N0qDKj4E+HKtdnf3PnDuMLodl
         gKKhrc2kNrKVhtyV6iQgAc4kL7khawO8CXWNPcmP/53tHumIjfsgnUQBQdfT02S0Yb56
         DnoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDHH/V2b6jqD+sEa5BgGqaLb5UkIZCoM1HVvmAcbbA3fSvKI7IS112RswnV2pUKvN+1kfFf+jYVUzd/i4LY0aRjA63ttDirFMWC1+O
X-Gm-Message-State: AOJu0YylEH9yYaszkUxPcjpomG9i8vzlexcBCSc6mLJ7FFdkBieYpWBp
	3iz5YrDy+rq0bOuY888rIVqbHP2n+BU5XmXsYNHI0qK4WJ2IOx/2br7EZIR81FM=
X-Google-Smtp-Source: AGHT+IE/RW1qpDBHJvcW0UivXwa6iqk3KIN1A0ymm7K1Pe8/Mtu6FQAOmwoZl7dSUg6M4QXhNlB/5A==
X-Received: by 2002:a17:907:874e:b0:a6f:ab9c:7779 with SMTP id a640c23a62f3a-a6fab9c7942mr627533266b.9.1718952328231;
        Thu, 20 Jun 2024 23:45:28 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf560908sm48090766b.184.2024.06.20.23.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:45:27 -0700 (PDT)
Date: Fri, 21 Jun 2024 09:45:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Hironori KIKUCHI <kikuchan98@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Hironori KIKUCHI <kikuchan98@gmail.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/3] drm/panel: st7701: Add support for SPI for
 configuration
Message-ID: <dceac1a6-25bf-4d04-a049-4c67846027f2@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618081515.1215552-3-kikuchan98@gmail.com>

Hi Hironori,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hironori-KIKUCHI/dt-bindings-display-st7701-Add-Anbernic-RG28XX-panel/20240618-161849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240618081515.1215552-3-kikuchan98%40gmail.com
patch subject: [PATCH v1 2/3] drm/panel: st7701: Add support for SPI for configuration
config: i386-randconfig-141-20240621 (https://download.01.org/0day-ci/archive/20240621/202406210841.Q17G5ISz-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202406210841.Q17G5ISz-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/panel/panel-sitronix-st7701.c:1076 st7701_dsi_probe() warn: passing zero to 'dev_err_probe'

vim +/dev_err_probe +1076 drivers/gpu/drm/panel/panel-sitronix-st7701.c

433b7d46874577 Hironori KIKUCHI 2024-06-18  1062  static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
433b7d46874577 Hironori KIKUCHI 2024-06-18  1063  {
433b7d46874577 Hironori KIKUCHI 2024-06-18  1064  	struct st7701 *st7701;
433b7d46874577 Hironori KIKUCHI 2024-06-18  1065  	int err;
433b7d46874577 Hironori KIKUCHI 2024-06-18  1066  
433b7d46874577 Hironori KIKUCHI 2024-06-18  1067  	err = st7701_probe(&dsi->dev, DRM_MODE_CONNECTOR_DSI);
433b7d46874577 Hironori KIKUCHI 2024-06-18  1068  	if (err)
433b7d46874577 Hironori KIKUCHI 2024-06-18  1069  		return err;
433b7d46874577 Hironori KIKUCHI 2024-06-18  1070  
433b7d46874577 Hironori KIKUCHI 2024-06-18  1071  	st7701 = dev_get_drvdata(&dsi->dev);
849b2e3ff96982 Jagan Teki       2019-01-25  1072  	st7701->dsi = dsi;
433b7d46874577 Hironori KIKUCHI 2024-06-18  1073  	st7701->write_command = st7701_dsi_write;
849b2e3ff96982 Jagan Teki       2019-01-25  1074  
433b7d46874577 Hironori KIKUCHI 2024-06-18  1075  	if (!st7701->desc->lanes)
433b7d46874577 Hironori KIKUCHI 2024-06-18 @1076  		return dev_err_probe(&dsi->dev, err, "This panel is not for MIPI DSI\n");
                                                                                                ^^^
-EINVAL?

433b7d46874577 Hironori KIKUCHI 2024-06-18  1077  
433b7d46874577 Hironori KIKUCHI 2024-06-18  1078  	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
433b7d46874577 Hironori KIKUCHI 2024-06-18  1079  			  MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS;
433b7d46874577 Hironori KIKUCHI 2024-06-18  1080  	dsi->format = st7701->desc->format;
433b7d46874577 Hironori KIKUCHI 2024-06-18  1081  	dsi->lanes = st7701->desc->lanes;
433b7d46874577 Hironori KIKUCHI 2024-06-18  1082  
433b7d46874577 Hironori KIKUCHI 2024-06-18  1083  	mipi_dsi_set_drvdata(dsi, st7701);
433b7d46874577 Hironori KIKUCHI 2024-06-18  1084  
433b7d46874577 Hironori KIKUCHI 2024-06-18  1085  	err = mipi_dsi_attach(dsi);
433b7d46874577 Hironori KIKUCHI 2024-06-18  1086  	if (err)
433b7d46874577 Hironori KIKUCHI 2024-06-18  1087  		return dev_err_probe(&dsi->dev, err, "Failed to init MIPI DSI\n");
c62102165dd792 Marek Vasut      2022-10-15  1088  
c62102165dd792 Marek Vasut      2022-10-15  1089  	return 0;
433b7d46874577 Hironori KIKUCHI 2024-06-18  1090  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


