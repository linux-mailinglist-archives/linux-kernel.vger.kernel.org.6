Return-Path: <linux-kernel+bounces-335666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1427497E8DA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FF31C20F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F674194A67;
	Mon, 23 Sep 2024 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncDwAOyy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED211946D0
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727084192; cv=none; b=VG9pnSlavI8ptlRK+DOilHMRuQDNrBrTzxn5ocL9CiSDMOeEJvxN6N5pzTHdQX0NJCmDEJIhjkG374u/+2rtZYZ8ZxLBdkFsG7G/qjtBuNebmG1AOMx5XwFNnecwFavoQtFPgQHs7uxsf3A76/ecKbvrE16ysWrFvi/ENiy6/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727084192; c=relaxed/simple;
	bh=hxOOIcHxpn1k7+C+uO984/vXp2LIHB/TbDCDWpqrAvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YbJILKwUYhx+/mlp/B20oaz3SdKk2BH5HVkVwcaP3THT22Id19I1MFpp3I/1E7LZtVbyKNX095fh4f1th9FHRXzGQs+OBM3++5BY9HKDd9OT5qqujPyxd2xCNWZUMF1PYA2slv6pjGQge/G7h5++OiGsF1WDdi4mzV70Bmwo3bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ncDwAOyy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727084191; x=1758620191;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=hxOOIcHxpn1k7+C+uO984/vXp2LIHB/TbDCDWpqrAvQ=;
  b=ncDwAOyy8xptj3yhwXyAEhAILcUdEGFMdSJB0sv6Fb/sYvCO06Hzmg3l
   tmZxFmWeM2e5aGW4VD4QCqA5uMh7gVy7aViSyudv6Lb+ZWHFENDXijmf+
   blxyL+gAEjMTqT6UgCn6rkUTtOyVYBmgUG3qfhgLp4d9LoJornp4DJfzL
   3Rr1d7lfYgEn0KQXC/UWS44uVKCjESw6PegwCdARaAJrG24nZCPX1AI7U
   XnwLH5MoIWlPH9oBF6VJtSV+aS3Cx7+lM75BtLco71WjqX2dswuxvQd5M
   p9oy/4Ubcoak6wmk4RXnM8XrfCmvfjYw5V/a3qdcvGcY8yzvdzJrbsyRc
   A==;
X-CSE-ConnectionGUID: 6D0AElIDTkuPI9ZkK2ezYg==
X-CSE-MsgGUID: UAYz3zKNRtOljC5qcqnsLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="37158378"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="37158378"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 02:36:30 -0700
X-CSE-ConnectionGUID: xSqErfLXSPy0NpRFbaE5Xw==
X-CSE-MsgGUID: KAkOJ+AZTX2KjfaFW8d8WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71032232"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.65])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 02:36:25 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Tejas Vipin <tejasvipin76@gmail.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Laurent.pinchart@ideasonboard.com,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/gma500: replace drm_detect_hdmi_monitor() with
 drm_display_info.is_hdmi
In-Reply-To: <4c053d01-2f67-47c3-9f08-e20e8e6ef1dd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240911180650.820598-1-tejasvipin76@gmail.com>
 <b0f77fcc-5d84-4727-9a17-9d1f1e2c5b76@suse.de>
 <4c053d01-2f67-47c3-9f08-e20e8e6ef1dd@gmail.com>
Date: Mon, 23 Sep 2024 12:36:22 +0300
Message-ID: <877cb27lux.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 12 Sep 2024, Tejas Vipin <tejasvipin76@gmail.com> wrote:
> On 9/12/24 12:49 PM, Thomas Zimmermann wrote:
>> Hi
>> 
>> Am 11.09.24 um 20:06 schrieb Tejas Vipin:
>>> Replace drm_detect_hdmi_monitor() with drm_display_info.is_hdmi since
>>> monitor HDMI information is available after EDID is parsed. Additionally
>>> rewrite the code the code to have fewer indentation levels.
>> 
>> The problem is that the entire logic is outdated. The content of cdv_hdmi_detect() should go into cdv_hdmi_get_modes(), the detect_ctx callback should be set to drm_connector_helper_detect_from_ddc() and cdv_hdmi_detect() should be deleted. The result is that ->detect_ctx will detect the presence of a display and ->get_modes will update EDID and other properties.
>> 
>> Do you have  a device for testing such a change?
>> 
>> Best regards
>> Thomas
>
> I do not have a device to test this. Reading the rest of the series and
> given my circumstances, I do not think I will be continuing with this
> patch.

*sad trombone*

I think we could've made concrete incremental positive changes here,
without changing everything about detect and get_modes.

BR,
Jani.



-- 
Jani Nikula, Intel

