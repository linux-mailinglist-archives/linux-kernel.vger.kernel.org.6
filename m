Return-Path: <linux-kernel+bounces-250404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E342E92F77B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29208284358
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902A0143758;
	Fri, 12 Jul 2024 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XIWeaw+5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FC241C77;
	Fri, 12 Jul 2024 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774999; cv=none; b=bw0Ub3bx+KJkMXHaf270RBq0rTDmHAzI3PDMuXW18wt6FXXjFDUMEIjy01zKchGnaCsVbeTMrBzLWpg2Cak7495cS7nwZ9KU/z+8cNPHl4SrEC25pykPN9zpUNzYdOjyXKICaG5gAEboGDVK/8CfTT8lYSbMbIZfNNEPxJSuhXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774999; c=relaxed/simple;
	bh=auc+t9E1+DVn72lREQqABgw4qZaonGbUTWJx9FRqh/8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JqtlcnkOzcKSrWHM8Y7SVfAVC1xLYn8YYgphPiYoZoXGb1GIzQWGDhbX8S6o+iuyRQtaW/KKvKX2vNKbYJIUXvXuciw9i85qFJgxubFHpLUx4JtZ4h23rI3bvTE2LRkpFM/B4Gnr1s7UtjRZL7Luhk8O2I3KHCVn8E7xgsULVfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XIWeaw+5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720774998; x=1752310998;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=auc+t9E1+DVn72lREQqABgw4qZaonGbUTWJx9FRqh/8=;
  b=XIWeaw+5s6h0tMmbGtHeD6Fq8TcUnzcuXcJYjBhIOJnucuiMa/K7Cw9a
   bFNbdgJo0L6V1bgzVZXfcCWub0eg9RiHwZD9/1cFVizuEEtCWKfOeksGB
   Q7cvsCLmXKC840qqKFKK0SWUNGYlSkAELaoGUSjyHvZedJb4sqRg/nBfG
   kN+fRKXZYsEUBs9ICpqc9AJTJ0xqtFdhB12A4ZS3K6KYZqiBzXckfTQ9G
   INnLvaEZZotlMjSm/lrCMjJ8LMtxz/duQiLitSay0k0udlnNglxjT5Ah6
   Y/f3o0L0Nc75kKTc65syqQfojzMkPEuCulI0jAz2r0oVB8YV1N3D2PsNt
   w==;
X-CSE-ConnectionGUID: tGgZLbICQoewFj1iXBWk7Q==
X-CSE-MsgGUID: PeH8ujR2RGiKaHdUNxnyXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18022797"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18022797"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 02:03:10 -0700
X-CSE-ConnectionGUID: XBdQlgdpQZeKV39+2oUjTQ==
X-CSE-MsgGUID: NTwtPDL9Qma+v2ktDuF6kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="53154576"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.129])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 02:03:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Nikita Travkin <nikita@trvn.ru>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <f5f38709c01d369ed9e375ceb2a9a12986457a1a.1720707932.git.geert+renesas@glider.be>
References: <80e17dffa8f4c1d3fdedd4d82df3a722aa4044ff.1720707932.git.geert+renesas@glider.be>
 <f5f38709c01d369ed9e375ceb2a9a12986457a1a.1720707932.git.geert+renesas@glider.be>
Subject: Re: [PATCH] platform: arm64: EC_ACER_ASPIRE1 should depend on
 ARCH_QCOM
Message-Id: <172077498124.2264.15481723237641939443.b4-ty@linux.intel.com>
Date: Fri, 12 Jul 2024 12:03:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 11 Jul 2024 16:30:36 +0200, Geert Uytterhoeven wrote:

> The Acer Aspire 1 Embedded Controller is only present on the Qualcomm
> Snapdragon-based Acer Aspire 1 laptop.  Hence add a dependency on
> ARCH_QCOM, to prevent asking the user about this driver when configuring
> a kernel without Qualcomm SoC support.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform: arm64: EC_ACER_ASPIRE1 should depend on ARCH_QCOM
      commit: 03b927565057dae39da3e4b46e5ab65274b5dcdc

--
 i.


