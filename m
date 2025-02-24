Return-Path: <linux-kernel+bounces-529438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3662A425FD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA30C7A3572
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE3B18C004;
	Mon, 24 Feb 2025 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0V0zBLG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E6270838;
	Mon, 24 Feb 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410240; cv=none; b=SO2VnHq6WRJxPYndYsiPaW5fN82VIgwV73jzudHvctm0C7I9YDkZZ9KQcpdIT9OHKukuVzU0EIFJug6vALbJLH5HdHTjdhAzWjo4IpXB1FBEqPkvE/Cz5T1r2RA1Njj4uCjhlAvjlNT/iAx9n4Zlhx+B0cVRqQpGr9HxBpkS0jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410240; c=relaxed/simple;
	bh=FctZeHaDqwfyYp6HlxgQeg9Z+pAOxz2hHEUmvjFy4Jg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ux4X9ROgYbpO07Pjgmi8YJkOocx2nhl4AipoaSgaCN/h0Om/+fRCvFUTI7cxfijb7KDzPiCP2pjpp1uPsnK5h+erAncUFoc0LN3SUd74ypx2fSC0SUGUdwQpj7pCA1fZgq2sbuZ6Qq176Q/9i7eaC3F51gWGuP8ww/FNlJV9XCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0V0zBLG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740410239; x=1771946239;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=FctZeHaDqwfyYp6HlxgQeg9Z+pAOxz2hHEUmvjFy4Jg=;
  b=a0V0zBLG+K9YWB+bJ82ZKx1qbISfdv6uEpAkw4tTWtiCPV4GzBiEe2in
   0McBmj5xI4SFTZB+PtBswAi6Rd/mIAQK9f7UibON52ZEWUMrSq4eF/vh0
   vjljcU508HeQ0wGVUECzAxi9HbGAM+d2MlZ1xkH/2xRSPpMOBvth79C2k
   GLj8qMHrtYPrBgp6k/10OZpwbM29Qlt+elHjkaPBnynv9+c3ec2VSHfcA
   Hdb0d1jFOOCSfAqwUeuooK0aKqbvsoWwuQLIhgrP2Hbn47zWdIVH6LAI8
   QOVUiw8ct4uagYaXoDHJE9hPqZhMHxvhgN5v1o1bJZ399Rg/VpGWg+VHg
   w==;
X-CSE-ConnectionGUID: kP4TFIk/TmGPQoodkSW4fA==
X-CSE-MsgGUID: PcThdI/wTP6XGqTZYIPYhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="28764827"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="28764827"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:17:18 -0800
X-CSE-ConnectionGUID: 627BfBPXQWSbvNobQ/+Twg==
X-CSE-MsgGUID: uJmUrKYSRi+JtMZzcK4F1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121350358"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.233])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:17:14 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: james@equiv.tech, markpearson@lenovo.com, jorge.lopez2@hp.com, 
 Armin Wolf <W_Armin@gmx.de>
Cc: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org, 
 linux-kernel@vger.kernel.org, hdegoede@redhat.com, 
 platform-driver-x86@vger.kernel.org, corbet@lwn.net, 
 linux-doc@vger.kernel.org
In-Reply-To: <20250216193251.866125-1-W_Armin@gmx.de>
References: <20250216193251.866125-1-W_Armin@gmx.de>
Subject: Re: [PATCH v2 0/8] platform/x86: wmi: Rework WMI device enabling
Message-Id: <174041022914.15708.15301539977547407490.b4-ty@linux.intel.com>
Date: Mon, 24 Feb 2025 17:17:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sun, 16 Feb 2025 20:32:43 +0100, Armin Wolf wrote:

> This patch series reworks how WMI devices are enabled and disabled
> to improve the compatibility with various firmware implementations.
> 
> The first three patches make sure that no WMI driver using the WMI bus
> infrastructure is using the deprecated GUID-based API to access the
> underlying WMI device.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/8] hwmon: (hp-wmi-sensors) Use the WMI bus API when accessing sensors
      commit: 27cc2914e495d314d19c7c1f74687bb28bc292e8
[2/8] platform/x86: think-lmi: Use ACPI object when extracting strings
      commit: 82d3af6b30ac2c6031428dd506eab9fd416cb825
[3/8] platform/x86: think-lmi: Use WMI bus API when accessing BIOS settings
      commit: 126a53a94a3fb3171d35f3c87820aafbafa08430
[4/8] platform/x86: hp-bioscfg: Use wmi_instance_count()
      commit: 0fcc3162e3fbe4ca9347b2f42313dbf077207bb1
[5/8] platform/x86: wmi: Use devres to disable the WMI device
      commit: b6b566908cd75bd99eb0e4b396c89704588261b3
[6/8] platform/x86: wmi: Rework WCxx/WExx ACPI method handling
      commit: 656f0961d126f5d1f0bcc62fa8bb7598d8f89207
[7/8] platform/x86: wmi: Call WCxx methods when setting data blocks
      commit: 08c9f4029007325e0bbd4fdda05650b03e43f071
[8/8] platform/x86: wmi: Update documentation regarding the GUID-based API
      commit: 8d5316c6c6633c18c4ebeb2dd038933549d404de

--
 i.


