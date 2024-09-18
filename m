Return-Path: <linux-kernel+bounces-332523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF05197BACF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CE81C2140D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC7E17C9FA;
	Wed, 18 Sep 2024 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqFzINYt"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD06176ADA
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726655354; cv=none; b=L3E5yPI9sDD8qkoQYLsqilPebemF3b439J56pG0yQCGtaAuOBsAGwV3ztl6NaV3ZrUVoplvAVzg2WcXrWrXBs5+iSnAJLHBpPlBvi7YNPS0HKwN7BZyCbgGlAewqdkUIJ6le98S53maiDAJhkojB0qpSQPGrta/JYv8I7jIE+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726655354; c=relaxed/simple;
	bh=a39yEU1qDSiQyVMeMKgLFZWZA/fQbvNEV7y3RlMGOEs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=siBEJOner2dkbZ3ntuSGcS6b5WmlANc8R3ZvjRGfM9Y/oBIrHqC9BgkZ5JVLm2GeqMy4ItTGs+2/2aRux9JrXfgGu1dGRGWiekTRkSWAWuD604dBmfRz04fvbOBMKX4jrY2+7RNWrsyPtjPLd/v+1A452Igz21NgM8fPHfOsePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kqFzINYt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374b9761eecso5343403f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 03:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726655350; x=1727260150; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8IGZ+UsOwDU5vfEwL536cwU6b6ARkEcblXO7Gz1AB8=;
        b=kqFzINYtzWheM9vW3R+CL1T0bEv41MCM949d6BTWJ/5CK2mCWtKzseh03xpZlfHx9J
         1saziFhbRJrOnpwCZIHWq6gTfK4Pp8AlcEI41QgIbEsbzmrCZXVNq0pbd6U7vUolA8Jw
         SbUbV5KBg8MVaESEJ1oBuvqmwk3TiOFDC+UMkG5u54LTPyZjYQQRzzCCEzpy27pfV7Jp
         6Y8RNmHadIAtIZCGubfc5bABWt2yhNZoZFmb3eisO3j3abqQnZdVLWVCJTo3r56JtTK0
         X/sYr0AsDUtMP4mbM3RWelfm6pzZxMeAq2BmK8+CzO+8lkuTEU7Hlt2V8TSyiXUllW6u
         FTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726655350; x=1727260150;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8IGZ+UsOwDU5vfEwL536cwU6b6ARkEcblXO7Gz1AB8=;
        b=I6e28zc5PnhBR2CAmGSz+kxzgbXMup23oD+4kYQ7kx6JsTBUhCnnywE5NbWYsXJfEb
         PiE5G9Afrl6daVBfNBh8r0IlPeEHOC7buu3ME7E4lstrbQzWuvjCa0WA9G6GdIGSRsj7
         f8d6GJlPeCo+rK495nIjTt3Tlp+zOMyI1EnXat3QVU/JdKDsA/vJg5eT/hBxpAmfmQYR
         wHs1TRNVyODuvon399nlNG1GKrbJj4hc42Eiz2cZAu9qdd6KBC9wcrJZKqpe9QwaaD1h
         DvjTSwzyHdfwPh2TYtuYl48+2dPc4RxG9YR4Aqi9t6HLwgT8T5LxkqXZaz95eL8mBgGu
         qGLg==
X-Forwarded-Encrypted: i=1; AJvYcCWiScBqPeVXh4teyOnewrnACMrVSkDlmabVTFS9VJkMl6RhAUHiTwC5RzbvaZslcfFGruloP96dnLE4m7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx3pBEH3/NXDXcMjDPc4ja+A8avM9BKp80VKgrZl2lOI/SVrcF
	sTjLS8cS2HiEv4gcduW2+lZIGykgvC7SGbiJPtmoRIz2aCRxiLn0k/LbfBsML1Y=
X-Google-Smtp-Source: AGHT+IGQN8g2sl5By/J4Z6wbJcgvZ3+TfEIn9bnlnNSVQu1J1Ze76BIcCUMXLkt5CXINpC2Ume6xYw==
X-Received: by 2002:a5d:65c9:0:b0:368:3731:1613 with SMTP id ffacd0b85a97d-378c2cf3f1emr12714688f8f.13.1726655350454;
        Wed, 18 Sep 2024 03:29:10 -0700 (PDT)
Received: from localhost ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7805179sm11876344f8f.100.2024.09.18.03.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 03:29:10 -0700 (PDT)
Date: Wed, 18 Sep 2024 13:29:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Abel Vesa <abel.vesa@linaro.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>
Subject: drivers/spmi/spmi-pmic-arb.c:1782 spmi_pmic_arb_register_buses()
 error: uninitialized symbol 'ret'.
Message-ID: <67cf80cf-d96d-4249-ac34-6085d4b32948@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   adfc3ded5c33d67e822525f95404ef0becb099b8
commit: 9799873717398e8fa1727482e578b9d777da645e spmi: pmic-arb: Add multi bus support
config: mips-randconfig-r072-20240916 (https://download.01.org/0day-ci/archive/20240916/202409162313.TnpH4qKB-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202409162313.TnpH4qKB-lkp@intel.com/

smatch warnings:
drivers/spmi/spmi-pmic-arb.c:1782 spmi_pmic_arb_register_buses() error: uninitialized symbol 'ret'.

vim +/ret +1782 drivers/spmi/spmi-pmic-arb.c

9799873717398e8 Abel Vesa 2024-05-07  1762  static int spmi_pmic_arb_register_buses(struct spmi_pmic_arb *pmic_arb,
9799873717398e8 Abel Vesa 2024-05-07  1763  					struct platform_device *pdev)
9799873717398e8 Abel Vesa 2024-05-07  1764  {
9799873717398e8 Abel Vesa 2024-05-07  1765  	struct device *dev = &pdev->dev;
9799873717398e8 Abel Vesa 2024-05-07  1766  	struct device_node *node = dev->of_node;
9799873717398e8 Abel Vesa 2024-05-07  1767  	struct device_node *child;
9799873717398e8 Abel Vesa 2024-05-07  1768  	int ret;
9799873717398e8 Abel Vesa 2024-05-07  1769  
9799873717398e8 Abel Vesa 2024-05-07  1770  	/* legacy mode doesn't provide child node for the bus */
9799873717398e8 Abel Vesa 2024-05-07  1771  	if (of_device_is_compatible(node, "qcom,spmi-pmic-arb"))
9799873717398e8 Abel Vesa 2024-05-07  1772  		return spmi_pmic_arb_bus_init(pdev, node, pmic_arb);
9799873717398e8 Abel Vesa 2024-05-07  1773  
9799873717398e8 Abel Vesa 2024-05-07  1774  	for_each_available_child_of_node(node, child) {
9799873717398e8 Abel Vesa 2024-05-07  1775  		if (of_node_name_eq(child, "spmi")) {
9799873717398e8 Abel Vesa 2024-05-07  1776  			ret = spmi_pmic_arb_bus_init(pdev, child, pmic_arb);
9799873717398e8 Abel Vesa 2024-05-07  1777  			if (ret)
9799873717398e8 Abel Vesa 2024-05-07  1778  				return ret;
9799873717398e8 Abel Vesa 2024-05-07  1779  		}
9799873717398e8 Abel Vesa 2024-05-07  1780  	}
9799873717398e8 Abel Vesa 2024-05-07  1781  
9799873717398e8 Abel Vesa 2024-05-07 @1782  	return ret;

Is it possible to not have an spmi node?

9799873717398e8 Abel Vesa 2024-05-07  1783  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


