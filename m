Return-Path: <linux-kernel+bounces-571250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A492BA6BAEF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9113BF494
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECC822A1FA;
	Fri, 21 Mar 2025 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ec7ew6+t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428A0226D1E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560870; cv=none; b=LN/pMEtcq3w1JSL/WJY7Tx9ch5lJJvWuSeCVqYASWUWE7U0WvW0ZjqRZ0F7d7GAjQZBM/5OGkQIkQ60l9WJqXhoOcGdui85pMdQ52U+YOp3lsV7yTM00zw4ccWOg/yV89sKvT5/P6fimbX1xVeagWJbMbaJh9YadBU9pQUEYGdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560870; c=relaxed/simple;
	bh=Y2846tBuL2mWBVQlc560xA5UiYRZ8PX5caGQUYX3m5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dss1FJEBqVZ88+UNx20h3zJmIwdINO5tIs7EPMMH142qB+zMMtVeGswy+W2M+E4IzO4H5Bl1ZFVfwLIR87CHLoNnwFqjAY0CiV8cWl5tU5SvrMl6VYyE4L9Rpspvym4w81o53rh6M81YwS2pzV52xlHvCKSmWm7WPCWOa2/HjAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ec7ew6+t; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742560869; x=1774096869;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Y2846tBuL2mWBVQlc560xA5UiYRZ8PX5caGQUYX3m5o=;
  b=Ec7ew6+tIevrsYQPXqDnjx+zMHZXHqiLEmkUXpqb0KvfwqCdRgUuFIkX
   lUJCiuKCbt0grkxgyzjVHCFppxvffECa2U5Oiy7CruyzEPPo9WLu8L4xu
   JSa8JjyADZiT8f6HXetnssd6Go7pYBN5IRvIaT2dos0V/kyj0JwdDNnQl
   jIwSn8FZJU9psg3sHxpjjcxta1zzxzqv4SVv9hKN/teQtr6vziQESY93x
   ocVCjjdBnXe/2wAc5ZH/A3d6NL7NMfvomMNxKBTDQRsxuo2Rmcoo+FQEb
   +LvfWvRAQEpJx06dtd6Ybja0MHxya11qMgJVWYCrAKGCFCwt7Wjj621Q6
   A==;
X-CSE-ConnectionGUID: LqHwmDczTx+LWJ7IFhfMbQ==
X-CSE-MsgGUID: JEMrvSLQSkqGmrBP5JAmmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="31416192"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="31416192"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 05:41:08 -0700
X-CSE-ConnectionGUID: xnWMy0feS82fNJIl+FCjBw==
X-CSE-MsgGUID: OaH24dpNSFmCPYM51NjsrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="128502379"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.201])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 05:41:05 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Yue Haibing
 <yuehaibing@huawei.com>, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, dev@lankhorst.se
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/i915/display: Fix build error without
 DRM_FBDEV_EMULATION
In-Reply-To: <12145722-609e-41d0-b02b-059df5b6d17f@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250315120143.2344958-1-yuehaibing@huawei.com>
 <12145722-609e-41d0-b02b-059df5b6d17f@suse.de>
Date: Fri, 21 Mar 2025 14:41:02 +0200
Message-ID: <87y0wyblpd.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Mar 2025, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 15.03.25 um 13:01 schrieb Yue Haibing:
>> In file included from <command-line>:
>> ./drivers/gpu/drm/i915/display/intel_fbdev.h: In function =E2=80=98intel=
_fbdev_framebuffer=E2=80=99:
>> ./drivers/gpu/drm/i915/display/intel_fbdev.h:32:16: error: =E2=80=98NULL=
=E2=80=99 undeclared (first use in this function)
>>     32 |         return NULL;
>>        |                ^~~~
>> ./drivers/gpu/drm/i915/display/intel_fbdev.h:1:1: note: =E2=80=98NULL=E2=
=80=99 is defined in header =E2=80=98<stddef.h>=E2=80=99; did you forget to=
 =E2=80=98#include <stddef.h>=E2=80=99?
>>    +++ |+#include <stddef.h>
>>      1 | /* SPDX-License-Identifier: MIT */
>> ./drivers/gpu/drm/i915/display/intel_fbdev.h:32:16: note: each undeclare=
d identifier is reported only once for each function it appears in
>>     32 |         return NULL;
>>        |                ^~~~
>>
>> Build fails if CONFIG_DRM_FBDEV_EMULATION is n, add missing header file.
>>
>> Fixes: 9fa154f40eb6 ("drm/{i915,xe}: Run DRM default client setup")
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

Merged to drm-intel-next, thanks for the patch and ack.

BR,
Jani.

>
>> ---
>>   drivers/gpu/drm/i915/display/intel_fbdev.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.h b/drivers/gpu/dr=
m/i915/display/intel_fbdev.h
>> index ca2c8c438f02..89bad3a2b01a 100644
>> --- a/drivers/gpu/drm/i915/display/intel_fbdev.h
>> +++ b/drivers/gpu/drm/i915/display/intel_fbdev.h
>> @@ -6,6 +6,8 @@
>>   #ifndef __INTEL_FBDEV_H__
>>   #define __INTEL_FBDEV_H__
>>=20=20=20
>> +#include <linux/types.h>
>> +
>>   struct drm_fb_helper;
>>   struct drm_fb_helper_surface_size;
>>   struct drm_i915_private;

--=20
Jani Nikula, Intel

