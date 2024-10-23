Return-Path: <linux-kernel+bounces-377554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E4D9AC071
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9521F23720
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F1513DB9F;
	Wed, 23 Oct 2024 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pb23kKqy"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ECF154C0F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669098; cv=none; b=IWCHFWZctTOTbL1cbz7KoNwK3OFpVD3rB6GCtEWpwv0pCLNDUJrsX0IS9rsE3JIm39rq296OWDCcEkq/ikLZuGRvyvi98/5nAJxe2r56MaVWdLqrt08mp56MhkgbUJdUVPt/YbWyPOqBIVcMnxyS7azRLKmuLbj/RL85iBN25ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669098; c=relaxed/simple;
	bh=nXPzMclz3nXaozUblDi+1q2LpZPAFo82Yk8wKHOx4RA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TYHgnVCSmriuT50XuA8BB4s103awq/8cp370/tG6+rUDzlGJWn4gAIByBkMkFtOp9rWTG3n3Ip+NsUwPwZE9vvKZfDOY3tZCvj3EEyU9uuHI9hA685sZNZiJQiynb7wrCYvx/eVQCf0k/+/Mjr+swGqM+KsnzzXna85n6E1xOvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pb23kKqy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314f38d274so88298215e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 00:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729669095; x=1730273895; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Izd4rZebQ7y8hQL9rGqqYb2xqbH/AuKR6LjqM8RIkOU=;
        b=pb23kKqyKXFJ9pw4EnVqDHjFCpWSNsUMkz8A+gj6Y+yHBa37axgJUHQyF3EQqkgMMq
         TAwDDw9qVmqah2OFDaPSjxx71ZWPs7DPkp8elwRpzTY6OODgCxxC0yNkGrpTsL9387L/
         VHls2KTt5RIYN5PMMLhq9pfDcm2lZPnRoZxD/1WxjM9rrlfOKdPtcBAs2f+sChY6w8PV
         Ih2mG9AqXeNzUGmqYLZN++9ryLFfIvg/hUPTTSSNUj7Pq8MK6/DOOeDtElMZ+KlsU3JI
         KESKCQc1nuoL35CR5nZJ67Slg8BXCRXopFrzhhY2MdabJKkFJ8T9/EQhaBmqGD/NH8QC
         7UwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729669095; x=1730273895;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Izd4rZebQ7y8hQL9rGqqYb2xqbH/AuKR6LjqM8RIkOU=;
        b=grsCOr2GuZs3DH33qNmznRh67X0YHKUcBWLC2alwy5KN5W3wWiSiMZ6P9CEvrx3Ded
         Izz/hk9Z/G4vbKYO87xpFHPE+uFbC3q2hv7BAREwb5X7BE+p/p8ilgQ1I1xcYiOdbm4v
         hsAkR7QTCj73YYkrhk3pBshsLOpZZ4ffFBrntonnmuJ+ngrinQu/wy+s1GFN6cBYaQBm
         ABQ1m5rJ+QP+twDqRHraVy0OB/NYEBe39a5NxVA354fPfElCu5CCSS/k8LSfbDbzQ5NO
         aD2pJT3aJWCxpZ7ceXsbfpNkcAUtU8Gl7gr90qDJ6YA796gVJIZ3/9RNlRi/oluJBqbU
         pBUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkud6mBplvgWSAyeF6ZjSGR6O5EwtGQSS24CdM3HBNOtz7H0vPxxbez+y9MEcNfL0uJtZY7RkmSLE8hmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0HzjyNZnRH2R6DxTZ6biYkQos7lH7iOJux8P6mTGxHWPXgIqI
	0lmXxBf05w6LlDyk4fdplCaOxATJppYm+K6YsAWcqakqqWX3ymrF/H1+JDgb++c=
X-Google-Smtp-Source: AGHT+IGVfOx2MFMafq++3ld4fk//SAc9KA8h9Cp96SGBaQB1n47UMGfxDyD9GlwfkRyJYxaS8onAXQ==
X-Received: by 2002:adf:f7c2:0:b0:37d:5318:bf0a with SMTP id ffacd0b85a97d-37efcee59ffmr1250154f8f.1.1729669094492;
        Wed, 23 Oct 2024 00:38:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b943fasm8288253f8f.69.2024.10.23.00.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 00:38:13 -0700 (PDT)
Date: Wed, 23 Oct 2024 10:38:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>
Subject: drivers/gpu/drm/tegra/drm.c:1155 host1x_drm_probe() warn:
 'tegra->domain' is an error pointer or valid
Message-ID: <0671f92b-915d-4089-acbc-81249f3423fe@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c2ee9f594da826bea183ed14f2cc029c719bf4da
commit: 45c690aea8ee5b7d012cd593bd288540a4bfdbf0 drm/tegra: Use iommu_paging_domain_alloc()
config: arc-randconfig-r073-20241023 (https://download.01.org/0day-ci/archive/20241023/202410231515.U2XBsu6b-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202410231515.U2XBsu6b-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/tegra/drm.c:1155 host1x_drm_probe() warn: 'tegra->domain' is an error pointer or valid

vim +1155 drivers/gpu/drm/tegra/drm.c

2d9384ff91770a drivers/gpu/drm/tegra/drm.c  Thierry Reding    2020-02-04  1136  static int host1x_drm_probe(struct host1x_device *dev)
2d9384ff91770a drivers/gpu/drm/tegra/drm.c  Thierry Reding    2020-02-04  1137  {
45c690aea8ee5b drivers/gpu/drm/tegra/drm.c  Lu Baolu          2024-09-02  1138  	struct device *dma_dev = dev->dev.parent;
2d9384ff91770a drivers/gpu/drm/tegra/drm.c  Thierry Reding    2020-02-04  1139  	struct tegra_drm *tegra;
2d9384ff91770a drivers/gpu/drm/tegra/drm.c  Thierry Reding    2020-02-04  1140  	struct drm_device *drm;
2d9384ff91770a drivers/gpu/drm/tegra/drm.c  Thierry Reding    2020-02-04  1141  	int err;
2d9384ff91770a drivers/gpu/drm/tegra/drm.c  Thierry Reding    2020-02-04  1142  
70a59dd82959f8 drivers/gpu/drm/tegra/drm.c  Daniel Vetter     2020-11-04  1143  	drm = drm_dev_alloc(&tegra_drm_driver, &dev->dev);
2d9384ff91770a drivers/gpu/drm/tegra/drm.c  Thierry Reding    2020-02-04  1144  	if (IS_ERR(drm))
2d9384ff91770a drivers/gpu/drm/tegra/drm.c  Thierry Reding    2020-02-04  1145  		return PTR_ERR(drm);
2d9384ff91770a drivers/gpu/drm/tegra/drm.c  Thierry Reding    2020-02-04  1146  
2d9384ff91770a drivers/gpu/drm/tegra/drm.c  Thierry Reding    2020-02-04  1147  	tegra = kzalloc(sizeof(*tegra), GFP_KERNEL);
2d9384ff91770a drivers/gpu/drm/tegra/drm.c  Thierry Reding    2020-02-04  1148  	if (!tegra) {
2d9384ff91770a drivers/gpu/drm/tegra/drm.c  Thierry Reding    2020-02-04  1149  		err = -ENOMEM;
2d9384ff91770a drivers/gpu/drm/tegra/drm.c  Thierry Reding    2020-02-04  1150  		goto put;
2d9384ff91770a drivers/gpu/drm/tegra/drm.c  Thierry Reding    2020-02-04  1151  	}
fa6661b7aa0b52 drivers/gpu/drm/tegra/drm.c  Thierry Reding    2019-10-28  1152  
45c690aea8ee5b drivers/gpu/drm/tegra/drm.c  Lu Baolu          2024-09-02  1153  	if (host1x_drm_wants_iommu(dev) && device_iommu_mapped(dma_dev)) {
45c690aea8ee5b drivers/gpu/drm/tegra/drm.c  Lu Baolu          2024-09-02  1154  		tegra->domain = iommu_paging_domain_alloc(dma_dev);
a7303f7735717c drivers/gpu/drm/tegra/drm.c  Thierry Reding    2019-10-28 @1155  		if (!tegra->domain) {

I already sent a patch for this a month back:
https://lore.kernel.org/all/ba31cf3a-af3d-4ff1-87a8-f05aaf8c780b@stanley.mountain/

a7303f7735717c drivers/gpu/drm/tegra/drm.c  Thierry Reding    2019-10-28  1156  			err = -ENOMEM;
a7303f7735717c drivers/gpu/drm/tegra/drm.c  Thierry Reding    2019-10-28  1157  			goto free;
a7303f7735717c drivers/gpu/drm/tegra/drm.c  Thierry Reding    2019-10-28  1158  		}
a7303f7735717c drivers/gpu/drm/tegra/drm.c  Thierry Reding    2019-10-28  1159  
a7303f7735717c drivers/gpu/drm/tegra/drm.c  Thierry Reding    2019-10-28  1160  		err = iova_cache_get();
a7303f7735717c drivers/gpu/drm/tegra/drm.c  Thierry Reding    2019-10-28  1161  		if (err < 0)
a7303f7735717c drivers/gpu/drm/tegra/drm.c  Thierry Reding    2019-10-28  1162  			goto domain;
a7303f7735717c drivers/gpu/drm/tegra/drm.c  Thierry Reding    2019-10-28  1163  	}
a7303f7735717c drivers/gpu/drm/tegra/drm.c  Thierry Reding    2019-10-28  1164  
a7303f7735717c drivers/gpu/drm/tegra/drm.c  Thierry Reding    2019-10-28  1165  	mutex_init(&tegra->clients_lock);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


