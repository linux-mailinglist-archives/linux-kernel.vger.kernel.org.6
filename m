Return-Path: <linux-kernel+bounces-510646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CA0A31FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B05577A139B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F76E2045A3;
	Wed, 12 Feb 2025 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBlGN8Xo"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791532040A4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739345218; cv=none; b=Np2TRtV+wU5vYnF7TV3Zj/k3q90+nW6+0DJkDHgInuHsIpVxI/ZM7EVoRGepvMddE1LxnClTM5eAfJx/mVniJuHnekrOksRE8+nr1sNBRZFPcKN2UxYxt0/a7lvckDSWUCVFg5B53zDV7NR0XAe2gVE2XRdj/Mp8GdvrWu0SWCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739345218; c=relaxed/simple;
	bh=Stf0Jb6AOQt3UW45VdcZWRKlmtA1GKvuSfA1nYZiAmo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=j8kpW2AThVwmzINM8Q5AOYCykMwXG/ON8xBkmNJuSUjelSav433I+p7QBcfeCYjmyrolt/iklx4HkINX+vfIZqSqgFxRqJiKoRHrvzQuJENavGOtWjp8xeSUTJt6UBh670uw79PWDFIXol6hyp24Ub5ugBXVVJTiKg9nnkQr+HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XBlGN8Xo; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de6e26d4e4so6911012a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739345214; x=1739950014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJTh/3LX42S4U+/p3ueXWIJVVkrm4MNl6nXiRtJNaS8=;
        b=XBlGN8XoOR7fKimt5pYv1E+aNatzro369+HeMQlqryuCTVlpagNeWfibvVO2N3m1KM
         zE02oJMTCOJY6fiUV4Y3A1/bllMzFFgA7o5CTz3nAu1pJJlQoQz+DgfDPOxbA/hMDtN4
         pXRHpVutdYoUcqE50BLQ75mT8bYZ++k61yXVIshCWjRZz4NF+W84f/o+u7SF1gyQP0wI
         7g4IburJBZNtitVZKbd0k0RofVCPT5nKYugLVT9AAy4e4+R8C8vxlE4bKioDUwFEH/hU
         xAqhs22tLSJez8TvvWraUZ7AjmBZxEWfbzlQPCuLFZo8AiDUNtCDToxGzxNWaY3qD1Zd
         YsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739345214; x=1739950014;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJTh/3LX42S4U+/p3ueXWIJVVkrm4MNl6nXiRtJNaS8=;
        b=M1KIVWC0ZKNI43TuuZcN6KRtO61JmO3CduRSsPhCw74kiwwq1ZkkkbwfXMjt3jI2+l
         09Ek5zlM6om8aK5GnTbiH9wrmIYsWzYxGCJBe2iTBb8EMnfRqDvMU2+jdaL+WMqodpdY
         oOnwemKuWRtfgq3wINcqlQN2aSb6KXpt1L+6OLEmMwoZ8aBy9n8/1Vx1mfB6idpX1ujF
         GPdFLxgR/5yP/Lp2KSyuysqoTLLb8yD9L6TBGg6KtSNsIIUDpHf4ZqfPg/UKrq3XJhaT
         GIdiSeRfcXjCvN/l9qqQHdhkqfDdgmoKG/3dDNslbEdZSHQd/J2sxiWa4Wdl6WcGp61V
         /moQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEf7uJgyUsDpXnM2lbdM5i1Umy5vFUqf5lmZhg6i3pKYk3GqbGHAyrE1BC9Vr/W9ozHLtW7d2cvcmZiJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3/CEsIb1L7T93tcZwa4dLUfQTjIDr1nmvjsY4IcvIh6+msKOu
	sha/0M3Li1qT5VLHC43KgwOkZbRXvvwEhG6EjLfr6rL+x62s3K5WU7gnY2rHglM=
X-Gm-Gg: ASbGncucvZpF/uvQsvurO147J2L9YR4FgM7wnp7S0gVAyudmDkQb10paBd4w/4dzMKL
	v7cMsvU21vg+iBWSueyS96jzPhUiGbHimo7Mbh6bofUewNYtKYc7Xb7CKrLr3J40kdNOOSk+7n8
	HbcFvhtDVFuZSZxPYxGPNvQwkXELhqOkqYcs9p+/Qxyl3VO6cAJxzTozoF4PEjbS3RcJ1vUIzdc
	m/jOaPljNLUCOy7udm9eDoMTcZ31Df0AzmB1wdkP2BSZ7nzNxyb5nIDFecNs3nGufZuqe1BjV5C
	6lhZpc6AMQftN7eoxxID
X-Google-Smtp-Source: AGHT+IFEIukrsfK6bZlW7MrqvUc4H7nNhVSu1KFPTEnyStLzMs/D5F7VfW3cbMd6Iv6A4IGV/jSXWQ==
X-Received: by 2002:a05:6402:3553:b0:5d1:1f1:a283 with SMTP id 4fb4d7f45d1cf-5deadd7bc87mr1609569a12.4.1739345213733;
        Tue, 11 Feb 2025 23:26:53 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5de5a2fc79esm7995187a12.10.2025.02.11.23.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 23:26:53 -0800 (PST)
Date: Wed, 12 Feb 2025 10:26:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Jerome Brunet <jbrunet@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] clk: clk-imx8mp-audiomix: use the auxiliary
 device creation helper
Message-ID: <7bb0b7ea-8ca4-4ea1-a7ec-d56646240e59@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206-aux-device-create-helper-v2-6-fa6a0f326527@baylibre.com>

Hi Jerome,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Jerome-Brunet/driver-core-auxiliary-bus-add-device-creation-helper/20250207-023433
base:   2014c95afecee3e76ca4a56956a936e23283f05b
patch link:    https://lore.kernel.org/r/20250206-aux-device-create-helper-v2-6-fa6a0f326527%40baylibre.com
patch subject: [PATCH v2 6/7] clk: clk-imx8mp-audiomix: use the auxiliary device creation helper
config: xtensa-randconfig-r071-20250208 (https://download.01.org/0day-ci/archive/20250208/202502081655.FlCrxpYN-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202502081655.FlCrxpYN-lkp@intel.com/

smatch warnings:
drivers/clk/imx/clk-imx8mp-audiomix.c:241 clk_imx8mp_audiomix_reset_controller_register() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +241 drivers/clk/imx/clk-imx8mp-audiomix.c

c350f4c434316c Jerome Brunet 2025-02-06  231  static int clk_imx8mp_audiomix_reset_controller_register(struct device *dev)
6f0e817175c5b2 Shengjiu Wang 2024-06-14  232  {
c350f4c434316c Jerome Brunet 2025-02-06  233  	struct auxiliary_device *adev;
6f0e817175c5b2 Shengjiu Wang 2024-06-14  234  
6f0e817175c5b2 Shengjiu Wang 2024-06-14  235  	if (!of_property_present(dev->of_node, "#reset-cells"))
6f0e817175c5b2 Shengjiu Wang 2024-06-14  236  		return 0;
6f0e817175c5b2 Shengjiu Wang 2024-06-14  237  
c350f4c434316c Jerome Brunet 2025-02-06  238  	adev = devm_auxiliary_device_create(dev, KBUILD_MODNAME,
c350f4c434316c Jerome Brunet 2025-02-06  239  					    "reset", NULL, 0);
c350f4c434316c Jerome Brunet 2025-02-06  240  	if (IS_ERR_OR_NULL(adev))
c350f4c434316c Jerome Brunet 2025-02-06 @241  		return PTR_ERR(adev);

If devm_auxiliary_device_create() could return NULL then that would count
as success.  But devm_auxiliary_device_create() can't return NULL.  It
only makes sense to return NULL if the auxiliary device is optional.

https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

6f0e817175c5b2 Shengjiu Wang 2024-06-14  242  
6f0e817175c5b2 Shengjiu Wang 2024-06-14  243  	return 0;
6f0e817175c5b2 Shengjiu Wang 2024-06-14  244  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


