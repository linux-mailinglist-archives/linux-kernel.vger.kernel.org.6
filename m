Return-Path: <linux-kernel+bounces-541919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE8DA4C365
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 951317A2C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2D221324C;
	Mon,  3 Mar 2025 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYLeqD1N"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D85CA5A;
	Mon,  3 Mar 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012355; cv=none; b=H5VXDa+37sGNjmP7FX7ZwxaWdmIMtcz4ZZ7G14bGuZ9HF0i7kW5DbusFNY6HA2ZtUFCirOLkX7otIQ9lLDbpcuKF37fqO0a7i0+PV89Hc+fVvAJZZ2Xpqb6gNQnuxk1g/k7QL5Q1bzXFWL/zXadOiT4H9yRcZwoaAg2FUpIdimE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012355; c=relaxed/simple;
	bh=fDXn2WYrnQ+HOjx/SlkGUKM7s99K8zS0aQ6zFv8U+8o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DN4Hw5nVjbIKGCtZp5GIRifMdIvFeMNmE+X2D2N7ybjBzgENgord54Alit3AhimkO1J2jPLVhHuXlZtIZbmNxbZAEPg8DRTxHxyU9kcjgdYOQ4r4w4siwXR2HLX4hAZAZzxWr1sYAEZ+wcSmAqhMDZIAypbxzVK+SRxYzQfWk5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYLeqD1N; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741012354; x=1772548354;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=fDXn2WYrnQ+HOjx/SlkGUKM7s99K8zS0aQ6zFv8U+8o=;
  b=EYLeqD1Nr/ugdDg9bZ3T2T2tn8g6mWZb9jaU6tYi5MSG7DVUFIeR+Vct
   yjPQ7diRvDOAMa30D4qFZZ7yC9Bk+kolVhIjJ+RTAxs5ekko1hSpgQcDX
   Sivn0suy1GsWj1KjW6+XVXxuMu5mymcwnAEaFjei9hebz26sOzzcLXavO
   Xoe9wzVrqSm43PvdWy0W3356qG0oTSA+eLdw9FJqvfhIBsp/hoL03ud8O
   6Hg8xfnywEwcqkjbKJ0Js3dyykNTPoP20dRQfonNDdrgoD995wTyx9kYW
   OYxAka38DbqnOHwKz/LcsSEPIY+hD/0FVCNCMZCj7saAD2k+gr4A1/3mv
   A==;
X-CSE-ConnectionGUID: qxOgV+U1R0C5rim/9tw7GA==
X-CSE-MsgGUID: 04HQttF7T0GE6NzBfGKtWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="45540640"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="45540640"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 06:32:34 -0800
X-CSE-ConnectionGUID: 7FxClIGRSCqmBe/suGwE+A==
X-CSE-MsgGUID: V9nab/WrRtSpdNuUrFL5Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148926792"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 06:32:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, Jackie Dong <xy-jackie@139.com>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 kuurtb@gmail.com, W_Armin@gmx.de, dongeg1@lenovo.com, 
 Mark Pearson <mpearson-lenovo@squebb.ca>
In-Reply-To: <20250222114532.4105-1-xy-jackie@139.com>
References: <20250222114532.4105-1-xy-jackie@139.com>
Subject: Re: [PATCH v11] platform/x86:lenovo-wmi-hotkey-utilities.c:
 Support for mic and audio mute LEDs
Message-Id: <174101234673.8641.771885577184828253.b4-ty@linux.intel.com>
Date: Mon, 03 Mar 2025 16:32:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sat, 22 Feb 2025 19:45:31 +0800, Jackie Dong wrote:

> Implement Lenovo utility data WMI calls needed to make LEDs
> work on Ideapads that support this GUID.
> This enables the mic and audio LEDs to be updated correctly.
> 
> Tested on below samples.
> ThinkBook 13X Gen4 IMH
> ThinkBook 14 G6 ABP
> ThinkBook 16p Gen4-21J8
> ThinkBook 16 G8 IRL
> ThinkBook 16 G7+ ASP
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86:lenovo-wmi-hotkey-utilities.c: Support for mic and audio mute LEDs
      commit: 61250669eaa9fd480e0f1c3cec107924b6a06b46

--
 i.


