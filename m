Return-Path: <linux-kernel+bounces-381890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F39B9B05EB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82AEE1C20F44
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3391FDF81;
	Fri, 25 Oct 2024 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPKZuaaZ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21121632C0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866884; cv=none; b=TvbZgwi1CBDap9wUpMWZDuFUtai5+SzK2w7T3DyW0mUtiHz47dbiJAoAvucKzk72+6XJEaEM0h7r1ex4AesvQOTf1BHEYTUZ70G8DUgNUIGRGNSGUnlgXptRiGMEYD+2SuLUooykKIKjbxfnMVKonpn/ijROSATH+7yQLe/XvbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866884; c=relaxed/simple;
	bh=ryZ2C43R41J0Yc2L+92/UwFPSUdODY1r2Hxgxi1jWBk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GaazSIPpxuzzNTjtDvip+Jhz19EXHF/NnMvHwCvmCF7jX2Sx7llPfjj/+6BGGH82BwEj6axu2mGuBsyupipQJsoTgP6VZi8jJdNJziMRUoJvHhFIpmXr8QlsH1okgCpKi5AJPXo9Lnswb2OQLNwUojSeUpZ/t3mAt0TMmNVKafU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TPKZuaaZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314c452180so21969125e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729866880; x=1730471680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D2Yr8EEmNPRUroD+TTomt6XCtgwDN7DROHjTn3fuIzE=;
        b=TPKZuaaZLY+hTEJzNJI7Sn1M8svQm+A39s8xpJLzPLgdTWvJ/2U65C2Qswz4VONsuD
         JWFV3nYXbLd9pn5R43Dsu+6ti6hxCgsL2SoQQCntyoIC0rccKAKWgSmXK5o2b00A8PEk
         Zi3bBoR+/z9/e3Hj/ZC60cGBFljJAy6RbRcm0+fxjcsNFixlPkkJE2v4s5ObiXHUAFDG
         +RDzcvcKkim0rEi4ZAft+Gp8V3p//se5FrQATA9Y7+iOvA8xz7Mrzy1tynBcifmN2xuC
         IslZi+ZaxWIQMGF8m5ZjO2ZmD1/U7JwR7+sGQgD2Ruzc5qHCTrxIVB2yCdt4msa04/al
         LWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729866880; x=1730471680;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2Yr8EEmNPRUroD+TTomt6XCtgwDN7DROHjTn3fuIzE=;
        b=wDLJNXwZjhgHi08pHwId94wqiOVGyRZhYT3Oev2YF6ZBN6Gedfnu+o4AANMTj81L3w
         +xEmGrRiSEjovwvj5YcpuYsMMSnVI9U+XRNTHjeU71pLJQ7pYdzRmhzEHqn/7RmEcJSq
         Jq+Y6gbcTKYUmnJHKMzgJ54pqs+4991Hu/H2Oawh8IY0rtfTMJHBIYLbWR01g9Ob99sY
         cdhZ2+WU5BqEswPdpcWk4xQf8oa9e6D7XL7qqagZTpkjgeCh09/cmTlbE9JQmagqap60
         HBHpzqQU19jonTgCyvIFUZgUiFGyhx2dwx8J0YeozqZoBELNLmCIHbjfyTk4zX5CO3Qt
         Mx4A==
X-Forwarded-Encrypted: i=1; AJvYcCWML3b9HzVSZlRByK2Tt5uOApBpEMH3FrXinudlAB5LcNHeD5q7BSxvgBUf+49isy3WQBVVc1rt5llcV+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYPe9GYdYUpLillVHUUmrrlSNJpDBj7NS6euzxLU/YIOOBNdjD
	V1ZTLYHGwu6q8VXogwSS85GEYfXfdWFBwkHDms7uuDYsB8SZU1+HAZlq64yijzg=
X-Google-Smtp-Source: AGHT+IHQ51cd+qtz6SSuTLjdY9C0RA4c2ssPpUrMmivHkZkhJ9GaBbiBnAO01CUGDbjejVQB64JqHg==
X-Received: by 2002:a05:600c:3b9e:b0:42f:84ec:3e0 with SMTP id 5b1f17b1804b1-4318b5b301bmr49162895e9.9.1729866879999;
        Fri, 25 Oct 2024 07:34:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b56ef06sm49777565e9.30.2024.10.25.07.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:34:39 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:34:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Rouven Czerwinski <r.czerwinski@pengutronix.de>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, kernel@pengutronix.de,
	Rouven Czerwinski <r.czerwinski@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 3/3] drm/panel: add Fitipower EK79007AD3 panel driver
Message-ID: <47f88a3d-52e5-4645-8a29-880123d58b57@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023124411.1153552-3-r.czerwinski@pengutronix.de>

Hi Rouven,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Rouven-Czerwinski/dt-bindings-display-panel-add-YAML-schema-for-LXD-M9189A/20241023-204826
base:   c2ee9f594da826bea183ed14f2cc029c719bf4da
patch link:    https://lore.kernel.org/r/20241023124411.1153552-3-r.czerwinski%40pengutronix.de
patch subject: [PATCH 3/3] drm/panel: add Fitipower EK79007AD3 panel driver
config: nios2-randconfig-r072-20241025 (https://download.01.org/0day-ci/archive/20241025/202410252201.QglvauIC-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202410252201.QglvauIC-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/panel/panel-lxd-m9189a.c:193 ek79007ad3_probe() error: uninitialized symbol 'ret'.

vim +/ret +193 drivers/gpu/drm/panel/panel-lxd-m9189a.c

a69b961abc36b3 Rouven Czerwinski 2024-10-23  181  static int ek79007ad3_probe(struct mipi_dsi_device *dsi)
a69b961abc36b3 Rouven Czerwinski 2024-10-23  182  {
a69b961abc36b3 Rouven Czerwinski 2024-10-23  183  	struct device *dev = &dsi->dev;
a69b961abc36b3 Rouven Czerwinski 2024-10-23  184  	struct ek79007ad3_panel *ctx;
a69b961abc36b3 Rouven Czerwinski 2024-10-23  185  	int ret;
a69b961abc36b3 Rouven Czerwinski 2024-10-23  186  
a69b961abc36b3 Rouven Czerwinski 2024-10-23  187  	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
a69b961abc36b3 Rouven Czerwinski 2024-10-23  188  	if (!ctx)
a69b961abc36b3 Rouven Czerwinski 2024-10-23  189  		return -ENOMEM;
a69b961abc36b3 Rouven Czerwinski 2024-10-23  190  
a69b961abc36b3 Rouven Czerwinski 2024-10-23  191  	ctx->supply = devm_regulator_get(dev, "vdd");
a69b961abc36b3 Rouven Czerwinski 2024-10-23  192  	if (IS_ERR(ctx->supply))
a69b961abc36b3 Rouven Czerwinski 2024-10-23 @193  		return dev_err_probe(dev, ret, "Failed to get regulator\n");

s/ret/PTR_ERR(ctx->supply)/

a69b961abc36b3 Rouven Czerwinski 2024-10-23  194  
a69b961abc36b3 Rouven Czerwinski 2024-10-23  195  	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
a69b961abc36b3 Rouven Czerwinski 2024-10-23  196  	if (IS_ERR(ctx->reset_gpio))
a69b961abc36b3 Rouven Czerwinski 2024-10-23  197  		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
a69b961abc36b3 Rouven Czerwinski 2024-10-23  198  				     "Failed to get reset-gpios\n");
a69b961abc36b3 Rouven Czerwinski 2024-10-23  199  
a69b961abc36b3 Rouven Czerwinski 2024-10-23  200  	ctx->standby_gpio = devm_gpiod_get(dev, "standby", GPIOD_OUT_LOW);
a69b961abc36b3 Rouven Czerwinski 2024-10-23  201  	if (IS_ERR(ctx->standby_gpio))

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


