Return-Path: <linux-kernel+bounces-560854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99136A60A30
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F25107AB2C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25178188CA9;
	Fri, 14 Mar 2025 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OzIvzIb0"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4718950A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938130; cv=none; b=DQ3hGGd9TcE/uGbN0gcKYupftDJ9ZVC4ElmGNaGuNtjoA8Gq0GwUyyL0qKo7Kr2T3iT87rPcBlkd+YQsKUM5r8SM3zaDu9GliHcPb8odemZ1BGZ4ynTQLZ2Tb4mk/NXolhas7ughpCQ5KjW4o4xoItr3KDdRF/RfDOminMHYJtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938130; c=relaxed/simple;
	bh=TFKMPnY7DyEVxOFjIJ3Z/VwODwE5uOu6Wfsj5MAkP4o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Tf6PwboCJCd/YbVK0sf27HGNCACGnS4wh1asyiZlEQpsYbyEzk64VTyi4RV7vTQHcreLL1iK8MaE5WcxAB6hQkWUNcygSr3DKcPdQvsgqZz1yBIJEgrzNMHUmTAvzXfmEbfCS78aIITrAxXMfKk+mQTePnssReqkVtaabT5Orbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OzIvzIb0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394a823036so16967005e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741938126; x=1742542926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5VICj1mgoxCCVFexS9kMcpPesi2AHSs3Nxw6/os/EPE=;
        b=OzIvzIb0KYFmvWdXuhgW4qaB2KVhEg4YZTTGMebrWrmvLzOYL2OU9/eK4CxZQfeGBJ
         W/sHKrL5ppQuHkxEZPB5mbhggggCqbxu/ze2Zv4LNG7YVylU7AOBBwP0+MvoCB77w/u3
         oPQUB50IL0jwtVXWt8z4nJ5vX84G5+6cPMK2uOubW1RZk0W9Rh4ay97iiloHF+6Citf2
         Xkk95S4iFR21ZyhzlOjUBlcTjjyfezNoRQ41x/eGCIKRbT9J0c9UT1lpeCrJJ+zwrGNc
         Ret2TlTUkMWFrTxtXrBPfBhttPUH159Rar8zAu0KZTbAQwTZBMJdv4SQAI9EnKlWApwf
         nTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741938126; x=1742542926;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VICj1mgoxCCVFexS9kMcpPesi2AHSs3Nxw6/os/EPE=;
        b=TYLGibn8GDiT1rIe7RjORVDXZjNw8y5x41j2YDyuTC/vYDPchrKH+0au+fteprWh1n
         qkh08LBSZ9Sjw4r8WwOR/8/2EFtOnR+aVBGI6BiyjAyW4HQQsAPxwK5T21JZBzQ9ce5w
         OLZeDXh4mU6HRG8YNRoD1n46L8+RHJlv7iP4zsAQA/9P84JpMwbemcW2aE7veDz+z2ro
         D08YE9NlX6+eRf9lt7/bNTu1NSGjhl/hzlN89LCFcUzWLzyfM5D8egGZJupuN3NkuVhR
         eTtMRj8AOZx+qna+0OdbiCc6DMmAlunFix3UseuB7N0hEyyKNxZJq2/M2HLq//nvkIft
         2dIg==
X-Forwarded-Encrypted: i=1; AJvYcCUoEHkV48AaPYnU32tGrFLOz42cW5DyPGlf3Td6gEbyT5zl0aRcntWel0GSAFX9TCfzgGZJ1fbKbqugxQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy41JA9ZujAsBJamlQA2p+s+BWxflmouVMs5YJVKx9UiKVncjrX
	p5+tZIoSILSxOBr2POWWAsTbaOQRN/ZmIke/oKX5UqmaznL/3OKfd5beHWY/GI8=
X-Gm-Gg: ASbGnctuuQqIogkKErOQZn68o5KBFnRZdSbozFlQ90iWyah0YqtP4Ixa+SxTNk6wgFr
	stVa+nZemWtX4BToo83zdmq1J7uAmblBEymcJLp3qSzItUsKngmF+oPGObeSLlS/6jmlIb8gebT
	qYsW+3B1oE1Y18O76XHpbNlTIN//aFv4JjVs1MT1eNbdQwCQU2+bthOeb5O3rU8Xm/Tc2c+OC9d
	dNaCyGHJjXQinv6CmCyyeOqgAwiywZGCSt/0Paf+Qw+pr+WzHHlign/kvhexXrpl16oxJ9Q9699
	ThIk4ZY85pFaWEZgcdobHRALpRvZlBZZOrgbtlL6m/akpTn3qM85EpKYS1wb
X-Google-Smtp-Source: AGHT+IFm7E17nEcoSOxY7Tw6+e0xDZ8rnIFbb6oMH7ZJtR8SbLPv6jsqnXgR/epND77bkL5mfCoWCw==
X-Received: by 2002:a5d:598b:0:b0:38d:badf:9df5 with SMTP id ffacd0b85a97d-3971d2378a8mr1262317f8f.17.1741938125641;
        Fri, 14 Mar 2025 00:42:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb7ebe4bsm4738082f8f.98.2025.03.14.00.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 00:42:05 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:42:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Pratap Nirujogi <pratap.nirujogi@amd.com>,
	mchehab@kernel.org, sakari.ailus@linux.intel.com,
	hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
	dave.stevenson@raspberrypi.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	benjamin.chan@amd.com, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: Re: [PATCH] media: i2c: Add OV05C camera sensor driver
Message-ID: <237cb63f-6cfa-4a66-8bc7-21cf48c8e760@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228165317.3468075-1-pratap.nirujogi@amd.com>

Hi Pratap,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pratap-Nirujogi/media-i2c-Add-OV05C-camera-sensor-driver/20250301-005638
base:   https://git.linuxtv.org/media-ci/media-pending.git master
patch link:    https://lore.kernel.org/r/20250228165317.3468075-1-pratap.nirujogi%40amd.com
patch subject: [PATCH] media: i2c: Add OV05C camera sensor driver
config: arm64-randconfig-r071-20250312 (https://download.01.org/0day-ci/archive/20250314/202503140559.3mp2n2oI-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202503140559.3mp2n2oI-lkp@intel.com/

smatch warnings:
drivers/media/i2c/ov05c.c:936 ov05c_probe() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +936 drivers/media/i2c/ov05c.c

6da03431f4f1e18 Pratap Nirujogi 2025-02-28  922  static int ov05c_probe(struct i2c_client *client)
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  923  {
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  924  	struct ov05c *ov05c;
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  925  	int i, ret;
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  926  
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  927  	ov05c = devm_kzalloc(&client->dev, sizeof(*ov05c), GFP_KERNEL);
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  928  	if (!ov05c)
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  929  		return -ENOMEM;
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  930  
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  931  	client->dev.init_name = DRV_NAME;
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  932  
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  933  	/* create sensor enable gpio control */
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  934  	ov05c->enable_gpio = devm_gpiod_get(&client->dev, "sensor0_enable", GPIOD_OUT_LOW);
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  935  	if (IS_ERR_OR_NULL(ov05c->enable_gpio))
6da03431f4f1e18 Pratap Nirujogi 2025-02-28 @936  		return PTR_ERR(ov05c->enable_gpio);

If devm_gpiod_get() returns NULL then we'd return success, but actually
devm_gpiod_get() can't return NULL.  Only error pointers.

6da03431f4f1e18 Pratap Nirujogi 2025-02-28  937  
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  938  	/* Initialize subdev */
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  939  	v4l2_i2c_subdev_init(&ov05c->sd, client, &ov05c_subdev_ops);
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  940  
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  941  	/* Initialize CCI */
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  942  	ov05c->regmap = devm_cci_regmap_init_i2c(client, 8);
6da03431f4f1e18 Pratap Nirujogi 2025-02-28  943  	if (IS_ERR(ov05c->regmap)) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


