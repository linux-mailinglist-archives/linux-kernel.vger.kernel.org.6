Return-Path: <linux-kernel+bounces-544610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC09A4E319
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E131B422616
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2340924C08C;
	Tue,  4 Mar 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NA+8gknZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F292424C081
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101063; cv=none; b=pwsQyepT5lYrze2bKNDclm2Z+ssNok7SRyrQPbaiIf8TN1LCZ1068bk5K4SyOleIKd8nQz4YTOQcE6mkbWljlbgxX+t02feGQI5JsO9+d8QLA7w/eBfbllNMYHXwvmq8cry69sk8bSq7y8pcFfrCFaTN55Ho7RzJFC91vhUWA70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101063; c=relaxed/simple;
	bh=t4HzfKpGGFlBoc1Etl+XJPQBVdf5gNOWugu+47JC6ps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iqgxMd3IQ77mqhK/EFCx0Nas4RDLyfU9lMDvevxVXkJ5doX/u3F7glmJCDw7doyKwr96OMMsQPkA+6WEFy5JSwuWF7KCuxVgjbFJUD2pYeNl5hJSEwxJjLEHFqTIb/kMP25su9kkAgoccnOIuZ4U+0tX3qW0eJloLDyeT9yn9lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NA+8gknZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741101062; x=1772637062;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=t4HzfKpGGFlBoc1Etl+XJPQBVdf5gNOWugu+47JC6ps=;
  b=NA+8gknZtbkbgENAk3NdH5G55Ac4lTQhrrHEy4TKSa1kkd21lGRdITZr
   RltbrMCHRIwaUI6DhPnE3Ikr2X2cdF3U/QFefm9DubcTddkCVbG5CW0K/
   EVzJOeJn590H/eHAj3bfTgeYRxUy7Iq110Yz0rELG16r6Vi6CojxNDpvY
   JbCq5CqI9KBkmBRTmPWCNmj0h0oN2WHqBlFkD+oErgS3uy3Ay+9k16VKZ
   260etIN0SqS1O+pfTxQ+gAZh4ftpaP+EWeq9/eIPeHNKxBrK2VZSWwTB3
   cq+UZ1tC3f3UKXtZLspdTwh6bPKCzp6hEn5xppINH8KVwc40aJm6dZApJ
   A==;
X-CSE-ConnectionGUID: uX24ZAYbT8SzC6/p+PXv9w==
X-CSE-MsgGUID: h84ZunJPQYCOYhHV71AoSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41931901"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="41931901"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:11:01 -0800
X-CSE-ConnectionGUID: 6VMaghNlR+GiLz6Ur7XksA==
X-CSE-MsgGUID: 2BOmcNboQNCQyeNL4RJSHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="149187083"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.192])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:10:56 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Aditya Garg <gargaditya08@live.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Aun-Ali Zaidi <admin@kodeit.net>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Atharva Tiwari <evepolonium@gmail.com>,
 Kerem Karabay <kekrby@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nathan
 Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] drm/tiny: fix printk format string for 32-bit
In-Reply-To: <05EAF4F2-7DFB-4C80-8D2A-054BCD7A126D@live.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250304142711.621330-1-arnd@kernel.org>
 <05EAF4F2-7DFB-4C80-8D2A-054BCD7A126D@live.com>
Date: Tue, 04 Mar 2025 17:10:52 +0200
Message-ID: <87bjugzv9f.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 04 Mar 2025, Aditya Garg <gargaditya08@live.com> wrote:
> Hi
>
>> On 4 Mar 2025, at 7:57=E2=80=AFPM, Arnd Bergmann <arnd@kernel.org> wrote:
>>=20
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> A size_t must be printed with the %z modifier instead of %l:
>>=20
>> In file included from include/linux/device.h:15,
>>                 from include/linux/usb.h:19,
>>                 from drivers/gpu/drm/tiny/appletbdrm.c:19:
>> drivers/gpu/drm/tiny/appletbdrm.c: In function 'appletbdrm_send_request':
>> include/drm/drm_print.h:589:54: error: format '%lu' expects argument of =
type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned i=
nt'} [-Werror=3Dformat=3D]
>> drivers/gpu/drm/tiny/appletbdrm.c:170:17: note: in expansion of macro 'd=
rm_err'
>>  170 |                 drm_err(drm, "Actual size (%d) doesn't match expe=
cted size (%lu)\n",
>>      |                 ^~~~~~~
>> drivers/gpu/drm/tiny/appletbdrm.c: In function 'appletbdrm_read_response=
':
>> include/drm/drm_print.h:589:54: error: format '%lu' expects argument of =
type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned i=
nt'} [-Werror=3Dformat=3D]
>> drivers/gpu/drm/tiny/appletbdrm.c:211:17: note: in expansion of macro 'd=
rm_err'
>>  211 |                 drm_err(drm, "Actual size (%d) doesn't match expe=
cted size (%lu)\n",
>>      |                 ^~~~~~~
>>=20
>> Fixes: 0670c2f56e45 ("drm/tiny: add driver for Apple Touch Bars in x86 M=
acs")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> =E2=80=94
>
> Its the duplicate of:
>
> https://lore.kernel.org/dri-devel/20250304-appletbdrm-fix-size_t-specifie=
r-v1-1-94fe1d2c91f8@kernel.org/

Pushed this one to drm-misc-next.

BR,
Jani.

>
> as well as
>
> https://lore.kernel.org/dri-devel/20250304135456.429407-1-jani.nikula@int=
el.com/
>
>

--=20
Jani Nikula, Intel

