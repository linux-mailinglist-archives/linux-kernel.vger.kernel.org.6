Return-Path: <linux-kernel+bounces-250405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193AA92F77D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BA11C22E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D72E1487CC;
	Fri, 12 Jul 2024 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMO7EnYl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2B142904;
	Fri, 12 Jul 2024 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775002; cv=none; b=UuUWXZXkzE80HgKUB6EQobmZv0Yx9+2YYixiybexn9nFiCZRRp89GckPu7UPVMAYSq4UX+MlwFF9z7HK29BzT5FNcsJOQlOWRL6Pyff7cwelfNdi9zrh5/GuGcZsSaHxWpJGqxMToVwcxG9wrFB24vn8BaykrIlEj8to82gFyso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775002; c=relaxed/simple;
	bh=3Hsipd0VmP8oXyuyf0778po9QtJb1clkgZOD2L/FF4g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qIrO0jz0hLX4iApQHaZdddoQS9ev9Dr+ndXg2ZKnxYn9QCWCfJypWZBTvAQ5bf7EYhGUx1yUNRlnHR2NJx/kbJWzZfi59OAZVD0QX4s00cKaV67e5FHmbrnH3TmXjwYeb/5TZTffKpSJA7s7dbcphwCf9bEGAmD5tLcJ0s8CDNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMO7EnYl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720775000; x=1752311000;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=3Hsipd0VmP8oXyuyf0778po9QtJb1clkgZOD2L/FF4g=;
  b=dMO7EnYlfjSo82Q3pN2/noFLN00/WDE2Msm+2zISi8kE+E/QzfNXXXng
   uQln/gfGtM6Ckm3PDUyJ1Lk4z/nx9N1koQfBwmTjEWOLrlwMmZeVEPi9H
   rkUN2lBJEB7HEgBti8mr2IIxTy4UpWoq1s8Ay7+bS1YDSNGwdKkO2G2Jp
   4JVthHNoo7qq7JgqIzimhvUFpa+TA8saF4TCvTG7zYDVMqnHLky6BGbdy
   WnrLRL8RqZaPTo1lKk6vniXGBwwG9BXIeQw5lcjc1IAdqizrfpWfS9u0s
   FIBOwDM3QNa795RJyP+wvfd4yuhgZG6Sg95kmSzuvERJzP5xJCSqyYsNJ
   g==;
X-CSE-ConnectionGUID: iaLvSnrvQtqE0JvA1zXCXw==
X-CSE-MsgGUID: VTh14nMAS3O9nZO1npB5qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18022820"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18022820"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 02:03:18 -0700
X-CSE-ConnectionGUID: 2eTqNaolTwGq1hSiKBVoGA==
X-CSE-MsgGUID: 7fKehRgvQxKD8ubV/VxmQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="53154580"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.129])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 02:03:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <0e4c9ffdc8a5caffcda2afb8d5480900f7adebf6.1720707932.git.geert+renesas@glider.be>
References: <80e17dffa8f4c1d3fdedd4d82df3a722aa4044ff.1720707932.git.geert+renesas@glider.be>
 <0e4c9ffdc8a5caffcda2afb8d5480900f7adebf6.1720707932.git.geert+renesas@glider.be>
Subject: Re: [PATCH] platform: arm64: EC_LENOVO_YOGA_C630 should depend on
 ARCH_QCOM
Message-Id: <172077498937.2264.1630580390229940631.b4-ty@linux.intel.com>
Date: Fri, 12 Jul 2024 12:03:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 11 Jul 2024 16:32:35 +0200, Geert Uytterhoeven wrote:

> The Lenovo Yoga C630 Embedded Controller is only present on the Qualcomm
> Snapdragon-based Lenovo Yoga C630 laptop.  Hence add a dependency on
> ARCH_QCOM, to prevent asking the user about this driver when configuring
> a kernel without Qualcomm SoC support.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform: arm64: EC_LENOVO_YOGA_C630 should depend on ARCH_QCOM
      commit: 1e02e317470b1c68d5971e51e8c62967ec1bc828

--
 i.


