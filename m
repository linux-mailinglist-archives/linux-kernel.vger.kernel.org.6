Return-Path: <linux-kernel+bounces-326590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5DA976A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813F4284139
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D10B1AD24C;
	Thu, 12 Sep 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzfuCz17"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C420F1AC884
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147552; cv=none; b=kpZ5MIV8QHvxMRUxnYwQP5UAXCJtqj1jxkAzo7vFZrK0saUim6Y0qg1uoPB0HB5Gp4/HAtoP68NY5gg/Mg/46f5luzwTCF5ZeEDrSm6KEWE1sAZjQLdTaGRRb5a8K10x7c+uC9LElFvIiKcTXLOXIC2BHZlo3vFjCojT9XpnYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147552; c=relaxed/simple;
	bh=xITUTQRl45ipox7CJz4yV6/g4MnIuHZA5arLXxNw0d4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HcpPydxxh62HCetgBw0Yfl3Jhi61dBDQSTrTrYRmG8q8DGoT0ccq8DnQwo9Kpf8Q4TMwk8e6QW5RuAujgPuKtCDHrXTwXYF6DvEPY7JtcgHAgySioWDw8Uo+p9dp7Ypvjvrf6+h5iFGeNPwWPcAPyJOhc4M/kCpimRKAeOd/u6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzfuCz17; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726147550; x=1757683550;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=xITUTQRl45ipox7CJz4yV6/g4MnIuHZA5arLXxNw0d4=;
  b=gzfuCz17MwCpwzg+VXcsU0f8MCvr/tlSB/QVoHN/BUstPlJI38tswLLN
   Xn7H0qse5lW4oftuPz70RYsj95RMzSnt/MKIJcHjfKEfNcKD76O1HYYS6
   9dlT863NQHjJCVuMB9Ox5WcyiYRxkNdL8XUqhBCYSXV3fJf93gdMhB/BT
   j0684/mpg2RXdWlEz+8DLr95FP+HnaYjhA1FsGQ5L3tsxaFSvk+9/nuWN
   2B970UNHdQMG6F9cSnU1YETSgjbzdZUG2oLIV4TYffp4DrKZZ9Oeg9DHh
   wmshh22YQeHE1oDKv2rxaUwuXuQj+3qTMtzOAMgcVoYpCcZDUkxVg1CDW
   A==;
X-CSE-ConnectionGUID: 9/X1sVcxRAav/EO/+c5v5g==
X-CSE-MsgGUID: VxM9xcCfTpOGgLzMJEYfAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24822061"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24822061"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:25:50 -0700
X-CSE-ConnectionGUID: +CKDuMijSYue4qvW/tYUVg==
X-CSE-MsgGUID: JIG+0YWCTMOhzOyUEBe6+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67328839"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.160])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:25:47 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Tejas Vipin
 <tejasvipin76@gmail.com>, Laurent.pinchart@ideasonboard.com,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/gma500: replace drm_detect_hdmi_monitor() with
 drm_display_info.is_hdmi
In-Reply-To: <1d16c1ae-2e27-4daa-b8a6-5eab179ef551@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240911180650.820598-1-tejasvipin76@gmail.com>
 <b0f77fcc-5d84-4727-9a17-9d1f1e2c5b76@suse.de> <87o74ti7g5.fsf@intel.com>
 <87ldzxi71s.fsf@intel.com> <988bb389-13e6-4465-ab37-3ed94ecee9be@suse.de>
 <87y13xgqj3.fsf@intel.com> <57016d01-4525-4685-b029-41e03b0abbda@suse.de>
 <87bk0tgll7.fsf@intel.com> <1d16c1ae-2e27-4daa-b8a6-5eab179ef551@suse.de>
Date: Thu, 12 Sep 2024 16:25:44 +0300
Message-ID: <87mskdf1gn.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Sep 2024, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Hi
>
> Am 12.09.24 um 13:25 schrieb Jani Nikula:
>> On Thu, 12 Sep 2024, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>> Hi
>>>
>>> Am 12.09.24 um 11:38 schrieb Jani Nikula:
>>>> On Thu, 12 Sep 2024, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>>>> Am 12.09.24 um 10:56 schrieb Jani Nikula:
>>>>>> Moreover, in this case .detect() only detects digital displays as
>>>>>> reported by EDID. If you postpone that to .get_modes(), the probe he=
lper
>>>>>> will still report connected, and invent non-EDID fallback modes. The
>>>>>> behaviour changes.
>>>>> The change in behavior is intentional, because the current test seems
>>>>> arbitrary. Does the driver not work with analog outputs?
>>>> Not on a DVI/HDMI port. Same with i915.
>>>>
>>>> That's possibly the only way to distinguish a DVI-A display connected =
to
>>>> DVI-D source.
>>> That's a detect failure, but IMHO our probe helpers should really handle
>>> this case.
>> How? Allow returning detect failures from .get_modes()?
>
> Something like that, I guess.
>
> For the specific problem it would be enough to read the first 20 bytes=20
> of EDID data on DVI connectors and test the digital-input flag bit=20
> against the exact connector requirements. drm_probe_ddc() could do this.=
=20

Just a quick reply on this particular point:

I'm very strongly against doing partial EDID reads. It's all geared
towards EDID block sized handling. And you can't do checksum checking on
the 20 bytes. It would be a maze of special casing, something the EDID
code could have less, not more.

BR,
Jani.

> Non-DVI connectors would continue to read a single bytes to detect the DD=
C.
>
> For more sophisticated problems, it would be good to introduce an=20
> intermediate callback that updates the connector state. So the probe=20
> logic would look like:
>
>  =C2=A01) call ->detect to read physical connector status
>  =C2=A02) return if physical status did not change
>  =C2=A03) increment epoch counter
>  =C2=A04) call ->update to update connector state and properties (EDID, e=
tc)=20
> get new connector status
>  =C2=A05) call ->get_modes if connected
>
> The initial ->detect would be minimal. The ->update, if implemented,=20
> could do more processing and error checking. It's result would be the=20
> connector's new status.
>
> On a side note, I've recently spend quite a few patches on getting the=20
> BMC output for ast and mgag200 usable. Something like the above logic=20
> would have helped, I think. Because with the current probe logic, I had=20
> to implement steps 1 to 4 in ->detect itself. The result has to maintain=
=20
> physical status and epoch counter by itself. [1]
>
> Best regards
> Thomas
>
> [1]=20
> https://gitlab.freedesktop.org/drm/kernel/-/commit/2a2391f857cdc5cf16f8df=
030944cef8d3d2bc30
>
>>
>> BR,
>> Jani.
>>
>>

--=20
Jani Nikula, Intel

