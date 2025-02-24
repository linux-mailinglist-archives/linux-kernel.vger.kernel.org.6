Return-Path: <linux-kernel+bounces-529441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECECA4263B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73ED3B2AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F42A24887A;
	Mon, 24 Feb 2025 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYzOLs3f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35E7248874;
	Mon, 24 Feb 2025 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410260; cv=none; b=dLQsB+o98l0aa1OeibttOsNG89y4S4bGN0okI2GT4bT/iY6McF654V5WnO/8OOySlrZaEu1JX9VLv2o1rR0m4amieOW4mgAt9HYpk4EXUJY9eOCRby6FgOucBuGfuecLfBL+oZfPS2ix2MQuYLm8x8MSVfSQUWllW632ycee0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410260; c=relaxed/simple;
	bh=BJ5QgB9PolTRlqS57db//jJRsdQQGJUFCUWXK4iJuUk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qRaXtT8pJReQ75SLcDKWB7ndaTk3B5ZIqhji0n7N0NTMNt155LpMBX080gO3ql1EfaWGanNRN2r5j9DELKAANbwv/1uEjWdzMGXBgC7IeKcQiB4hDo72o2OuKq/ZFqIWfmZW8/3vriq7szWHpqUaqZ5GRFPU0429h6l6eCcC0UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYzOLs3f; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740410259; x=1771946259;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=BJ5QgB9PolTRlqS57db//jJRsdQQGJUFCUWXK4iJuUk=;
  b=EYzOLs3fLUR+08plh9U7N0QvyXUmURO2BO3PEs5rm6kC2+ZMahHkmTmB
   VHeJ16829J9vO3vCQwZUPrENhnfyRmqwUf8Eqrb9jQcXHGF2JbgNFzb6o
   kTopsDxRf54Or5yq8W2d/KSCyKDmTL7Hvg+SbuL8/5nnX/3moH13onL/6
   pc3/mJzhZJkF98PDgRaEwKOd8k0EJVJxkndgcAnwCUiXDL+s5trF1Z9hh
   3uQtRD/0uzGRGq44abD3KaKMKHlXKZa57qh7vyFnq+yWJIoioDyqJ558B
   vXnN7NmDIlIsZTubzOZ07z8iP8ibeUx53UtkT601T3YwbRjqamR+ZzDNj
   A==;
X-CSE-ConnectionGUID: NyPB+sr0TtiMzSwuLptDbg==
X-CSE-MsgGUID: p0xQT+kfQb+qU++Cha3WSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="52160675"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="52160675"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:17:39 -0800
X-CSE-ConnectionGUID: WJrQmeq5RRewS+c8bTP+Hg==
X-CSE-MsgGUID: u+DLRMQCSLKrENZIAFdvOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="121180783"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.233])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:17:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250218194113.26589-1-kuurtb@gmail.com>
References: <20250218194113.26589-1-kuurtb@gmail.com>
Subject: Re: [PATCH 0/4] platform-x86: Use *-y instead of *-objs in
 Makefiles
Message-Id: <174041025239.15708.5483701145826768041.b4-ty@linux.intel.com>
Date: Mon, 24 Feb 2025 17:17:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 18 Feb 2025 14:41:07 -0500, Kurt Borja wrote:

> According to documentation, the `-objs` suffix is reserved to user-space
> and host programs. The `-y` suffix should be used for composite kernel
> modules and drivers.
> 
> [1] https://elixir.bootlin.com/linux/v6.14-rc3/source/Documentation/kbuild/makefiles.rst#L153
> 
> Based on pdx86/fixes branch.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/4] platform/x86: dell: dell-wmi-sysman: Use *-y instead of *-objs in Makefile
      commit: 363171c96a15f558cd622e10ea100c505132f7b8
[2/4] platform/x86: amd: Use *-y instead of *-objs in Makefiles
      commit: cfba129ad2775b6ed1f209367905ddb8c9964bf5
[3/4] platform/x86: hp: Use *-y instead of *-objs in Makefile
      commit: f0ea699b1816ebed6de9aa013387622b0f73f31b
[4/4] platform/x86: intel: Use *-y instead of *-objs in Makefile
      commit: 677fb7b0699dde2609d93eb57863c8d493e673ee

--
 i.


