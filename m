Return-Path: <linux-kernel+bounces-384774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2F59B2E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64EE21F21E97
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C491DD523;
	Mon, 28 Oct 2024 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BC0BDyHM"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FAF1DC19F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112891; cv=none; b=VVtCqNlAGahcx8T6MLE680XxNICbM0oG7wUQEFHyrYlkoNbEH2WPKYLq+fp2gMIl+hL/cbR8clKNdDPg6a7DhGGbH4mDQQ7EHeMzIZTx6pcBBbN0szirU696QsNSx/vIdQsm2wYIMfA0kqRaSny6kX7u+Stb/nveinhVdVXBnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112891; c=relaxed/simple;
	bh=FRT7cTeBL9rzdgEqPmoGx0xaa7VbGPuT/dkMIqKmKWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8QFB3GXfSX1cKg1hroDpIUw3o1J1ltNUlG/qhwZhqEvhvnu1NMFdA/WQHcnmRY2DHHCGAH4nonfJN+FrXaeVkS5UQMHT7G2V+4rES0dXg/Pu9ARDTavXPvwDyvZbricJXV6pFgSRD/QI7XC5MbL0WkOt6F9zuW8wtP80rZcfMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BC0BDyHM; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e4b7409fso4033196e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730112887; x=1730717687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hIp8p1y9OYLmueWzt8+7yDMvWFfo7oDb41HmupTIZZA=;
        b=BC0BDyHMp0F1W2+Oxad8nS1sZJD/7AYnLvvka7Y5aijQVAIQU4A5fyUnwqtaq9xekF
         mHe98j/0ZilogO+nu/dYnffETmgItXyevdh2RKPnzFPihWdaYip1FWZ+snjYJNLbhDqE
         qgNGVrcb/5lHdrPzfP4yq7xwR4JtO/S9NR3k4BtDlrnFWmcQTUx9ODYJxZZeisdph2ci
         asIeqVu6qxqODjr96Fy9oHXgvJ9VfrI9b/Nel52/8r6N7J5c2pkFzv6X4st/wyvmSBbz
         fxkjhH3ctP5vrUX2BzGARmr54EnTerzdKNd0v8IJGU/IGwyu34TdXFFtGNJxMgbPbjiR
         ml3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730112887; x=1730717687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIp8p1y9OYLmueWzt8+7yDMvWFfo7oDb41HmupTIZZA=;
        b=Q2j0A0vriyKTVSVqZENcnIjgsFyl70qaqhvqfzC/8kdrcAnSTtN+s2t5BFJkaaRT75
         ui2CBjeIBYRXRXvfWq3nscMUDG74EaBh8DDZLF45MhrFFxYeNRJK+ru2nWdzBwTuyhFp
         SRdoxrKaJpYahWuFKEnssMKHDNvxIyWOYt328ZALH7+BFY/3yLb8PoQU54D0r6mnBWVE
         cvaRXsUmuTLtyEb1WwN9hncCUg/xUDsZbs9sG8K6cDPzfnWRBG+yTbgsMaxSzsQJsWig
         moBcWrP2mBrI8ncJP1BtmG2lNOC4ECny40TCoCcCqtSRV6I4bnFIaOkzStWSXW2nlWYq
         EPCg==
X-Forwarded-Encrypted: i=1; AJvYcCXf/Zk1DJtmMZ4PND4A98521qMIu75fSo+h0Bs9nMIm5KDo0JeFtREM5mpcCGK2nuZag4aE2ZaATn0mtYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV3GSDW7My79qLP5IaAftlCow/J/FobxMiQ9ZNiDss92FgYC5p
	ap/+uojnX8RUM3P3hIRC5czLPNQu1exSK+krB1+Iru0fFS0qJ9Gw8eM7WJKGGUE=
X-Google-Smtp-Source: AGHT+IEvzbs7iCzZXXfk6Ann3ZL3OW88AuVYQtULh9f4OSje5nI375zcEnnbchgjpRTSYmWkTUgo6Q==
X-Received: by 2002:a05:6512:1107:b0:539:fbf8:5735 with SMTP id 2adb3069b0e04-53b33df7378mr2053614e87.8.1730112887274;
        Mon, 28 Oct 2024 03:54:47 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a7efsm1043915e87.56.2024.10.28.03.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:54:46 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:54:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: kernel test robot <lkp@intel.com>
Cc: Yongbang Shi <shiyongbang@huawei.com>, xinliang.liu@linaro.org, 
	tiantao6@hisilicon.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	kong.kongxinwei@hisilicon.com, oe-kbuild-all@lists.linux.dev, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 drm-dp 1/4] drm/hisilicon/hibmc: add dp aux in hibmc
Message-ID: <5sb3loc23nf45up3tx3z7nq2s4hvevhxdwhq7t6w5hrwnyw7vi@kjg4vshkuvjm>
References: <20241022124148.1952761-2-shiyongbang@huawei.com>
 <202410250305.UHKDhtxy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410250305.UHKDhtxy-lkp@intel.com>

On Fri, Oct 25, 2024 at 03:52:49AM +0800, kernel test robot wrote:
> Hi Yongbang,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on drm-misc/drm-misc-next]
> [also build test ERROR on linus/master v6.12-rc4 next-20241024]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yongbang-Shi/drm-hisilicon-hibmc-add-dp-aux-in-hibmc/20241022-204925
> base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
> patch link:    https://lore.kernel.org/r/20241022124148.1952761-2-shiyongbang%40huawei.com
> patch subject: [PATCH V2 drm-dp 1/4] drm/hisilicon/hibmc: add dp aux in hibmc
> config: arm64-randconfig-004-20241024 (https://download.01.org/0day-ci/archive/20241025/202410250305.UHKDhtxy-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410250305.UHKDhtxy-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410250305.UHKDhtxy-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    aarch64-linux-ld: drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.o: in function `dp_aux_init':
> >> drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c:154: multiple definition of `dp_aux_init'; drivers/gpu/drm/msm/dp/dp_aux.o:dp_aux.c:(.text+0x8a0): first defined here

I think both of us should switch to a more generic names. I'll send a
patchset for msm/dp, please use some less generic prefix for hibmc
driver.

> 
> 
> vim +154 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
> 
>    152	
>    153	void dp_aux_init(struct dp_dev *dp)
>  > 154	{
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

-- 
With best wishes
Dmitry

