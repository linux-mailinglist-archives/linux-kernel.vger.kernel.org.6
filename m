Return-Path: <linux-kernel+bounces-387165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7F79B4CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905D62845BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B19619341F;
	Tue, 29 Oct 2024 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Au7j5G2c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F34C192B95;
	Tue, 29 Oct 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214278; cv=none; b=TbT0Ib5WL6bMzRDFt4VyuTHi2qPI+yr7D33bQ+tDQ4Xk05PPnVIfUVTUmk963iQaSwNIjkAxhiyBBOJ8B84vRcVhsRnhnS88DLUP6zCYKuQSwNV4nRbQRtu9qx1+5658CEl6XCQ7c6FCBxHH6Jddu+ZHQF55YJAbXi+99K3JWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214278; c=relaxed/simple;
	bh=NfmD68x1xHWzB0oNQ2YFY4K/YnAEEUd4ugxIBTU+hqk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dzqwFnOzfVr9VvNcCWeOiY8aBK41S2dHS65dkQg86Sdvfis/1nd/UEAJVIr4C4ilfWUOGdI+rp78LcL9BiloL/YGPsGLMbh25ic3hQxpHNYTBUjZD9x/ZrH9zhEVNTx1gi8uZChMf8C1WyQOByNDCXYOlk3ynKgulT7oKWYEHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Au7j5G2c; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730214277; x=1761750277;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=NfmD68x1xHWzB0oNQ2YFY4K/YnAEEUd4ugxIBTU+hqk=;
  b=Au7j5G2ctwDOQIcpWRJ+EvTNo59vy4EP7jLzLFOzpd/hc0LRQMmPK/ad
   4G5eTiRIYBbGlrO9iiQ0feLdtwBiILlZFEWiDnP/fmrqIlknOVHwFt/e7
   BoqTwJmn9tsC3vG18yk+5dG78OvvLGxpKn+UnhYnSBRVfjOj1lBGzCtI9
   tBH6zS9Ve5sqQ4bdec+xYJv9JSIOWpEfUd1hZGZaZrYU3quYxHY2HSkT/
   5/Xy8BuVaimJSDGLEy6mTsWpazX5HV+0YgVKkp/gaKbqCsDfXSQxRm2DR
   bEiS2fQN0OctYRE9bEnsL5FnVIR7otc/l0RpV5ImMSekBlh758JAuN8uo
   A==;
X-CSE-ConnectionGUID: h1LYpBr2RYCAXVPBYzi9yg==
X-CSE-MsgGUID: keyZE3cISreabXbq7Y0ehA==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29968451"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29968451"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:02:56 -0700
X-CSE-ConnectionGUID: E2alJhzjQdyNuCNk6/d1dA==
X-CSE-MsgGUID: AoHYHcrSTVipS8akjRd2qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82315544"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:02:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, corbet@lwn.net, Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241026193803.8802-1-W_Armin@gmx.de>
References: <20241026193803.8802-1-W_Armin@gmx.de>
Subject: Re: [PATCH 1/3] platform/x86: wmi: Remove wmi_block_list
Message-Id: <173021416876.2801.15156306724313702863.b4-ty@linux.intel.com>
Date: Tue, 29 Oct 2024 17:02:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sat, 26 Oct 2024 21:38:01 +0200, Armin Wolf wrote:

> The wmi_block_list is only used by guid_count() and without proper
> protection. It also duplicates some of the WMI bus functionality.
> 
> Remove the wmi_block_list and use bus_for_each_dev() instead.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/3] platform/x86: wmi: Remove wmi_block_list
      commit: 049571ce7678221767ec3ee5d522bc3de7d57ed3
[2/3] platform/x86: wmi: Replace dev_to_wdev() with to_wmi_device()
      commit: c382429b587ac49bd179d768f13e7fa5e7ed1787
[3/3] platform/x86: wmi: Introduce to_wmi_driver()
      commit: e001341a984e709e377b275123aecb5a763eaef9

--
 i.


