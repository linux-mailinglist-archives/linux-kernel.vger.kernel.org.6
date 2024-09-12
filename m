Return-Path: <linux-kernel+bounces-326399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAF79767DF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95728B21CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330211A2876;
	Thu, 12 Sep 2024 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AOAjH/lW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06EC18BBBD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140348; cv=none; b=jPZSeU8DQsm34jWfTsezejCPQ4Dss9fyjG/TicwCT8mEjwlIEPfKZflFliiF7Nn2GRiuxruYvirhLfcg3158NyJ9nJJMsCv0SkR2MX2ksrCEsJchdF7mHgUjraILa950V//u9pnVAx1HjCRUR5F0taDj4IWxs2RCP8OgReiu/II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140348; c=relaxed/simple;
	bh=J1GXTNFncPwjt81U/3BVKaEweFbhgjsaC38ofE+SfYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BLn/cbc44cuEFsB0EIirWzvDXsKOWccCYr1HXMNMTAUDcfDdrSNxP1C4DkMXGmqIVuBP3S7lBtHGLpAHqyBKowcf6UeFA9GpQe/KXFA9as3fTKlBfz/wf9S7eUX4z3ghPB3kBJJQSlBypPRAo7eFo3IY9XgcekKGAiIXn7aNiGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AOAjH/lW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726140347; x=1757676347;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=J1GXTNFncPwjt81U/3BVKaEweFbhgjsaC38ofE+SfYw=;
  b=AOAjH/lWXu36mrYyKMhdawXGxG8MWed84r6vliaFjKCCUWgAPbpFlPKh
   m6LuKbtDE23gBy57IVlANhHLuj5U09HfoSgrLCFnu7yE02CUWv4rKhIRc
   ABPZ77itjMYMD5DTv21o2HsJQVYAFJXuOy0FE1Z52OLdChbHoUHAqh/ML
   SAs0XVEWxwZXT4Ksi+1a0SwmRRDri3mn5n03XYDL0ZKRTo+uTBqHQqpGr
   CtiDu31YnU8HIxtYSfrB3DiwnxazTzaAhjEQpUlQ1YeTogx3daG05bd1A
   e3/WgWy/ujtNcDc5SuO+hBOYSPZhj6UAaIOgha013bS15woWE6E1z5LOr
   g==;
X-CSE-ConnectionGUID: KgJt3iXxTrSNjuzg1It9Ww==
X-CSE-MsgGUID: YnnkBRyWRcy5NZwHZdkBiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="25181101"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="25181101"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 04:25:46 -0700
X-CSE-ConnectionGUID: oRgBbhK6Q3G7veiWxmeMKw==
X-CSE-MsgGUID: bSr1+S1/Rxq9g1WkDqUP8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="71784573"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.160])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 04:25:43 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Tejas Vipin
 <tejasvipin76@gmail.com>, Laurent.pinchart@ideasonboard.com,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/gma500: replace drm_detect_hdmi_monitor() with
 drm_display_info.is_hdmi
In-Reply-To: <57016d01-4525-4685-b029-41e03b0abbda@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240911180650.820598-1-tejasvipin76@gmail.com>
 <b0f77fcc-5d84-4727-9a17-9d1f1e2c5b76@suse.de> <87o74ti7g5.fsf@intel.com>
 <87ldzxi71s.fsf@intel.com> <988bb389-13e6-4465-ab37-3ed94ecee9be@suse.de>
 <87y13xgqj3.fsf@intel.com> <57016d01-4525-4685-b029-41e03b0abbda@suse.de>
Date: Thu, 12 Sep 2024 14:25:40 +0300
Message-ID: <87bk0tgll7.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 12 Sep 2024, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Hi
>
> Am 12.09.24 um 11:38 schrieb Jani Nikula:
>> On Thu, 12 Sep 2024, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>> Am 12.09.24 um 10:56 schrieb Jani Nikula:
>>>> Moreover, in this case .detect() only detects digital displays as
>>>> reported by EDID. If you postpone that to .get_modes(), the probe helper
>>>> will still report connected, and invent non-EDID fallback modes. The
>>>> behaviour changes.
>>> The change in behavior is intentional, because the current test seems
>>> arbitrary. Does the driver not work with analog outputs?
>> Not on a DVI/HDMI port. Same with i915.
>>
>> That's possibly the only way to distinguish a DVI-A display connected to
>> DVI-D source.
>
> That's a detect failure, but IMHO our probe helpers should really handle 
> this case.

How? Allow returning detect failures from .get_modes()?

BR,
Jani.


-- 
Jani Nikula, Intel

