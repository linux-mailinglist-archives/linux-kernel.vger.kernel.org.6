Return-Path: <linux-kernel+bounces-215460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76600909306
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 21:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3981C211AA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A336D1A38CD;
	Fri, 14 Jun 2024 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="T/LCp9jL"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD7015B562
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718393887; cv=none; b=hCjYFoGNoHXsd8M7/5qMqW8YQJasLZseFUpZsmC9IAzwF6ROA+ZDGAvHfuXHF2IQ2gnq7ilJ5EtHXGHVdB4g21z6/i0Ha1R5SOX8MfHlT7UALDUJhxale/4VgKVOBEuSFA87rv+58CVBSTt32Tnoo58/LT+qusVT0+qzIu/6rFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718393887; c=relaxed/simple;
	bh=LH7oYnjhXEDLBGjKZQFYGvvVxeK0Fc2BRHOXDVHtmAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgWFyJesFsJlKDS28uR1n8BOFFukNLPZSR/Xzig2YBCBooHfkW15sl3DV/1DVwgORiiTckM4IDzGcnIpQVXBeFuoVkcDkxxoPXhtZzxgpVrZ2OTGTCrxxfQfJJ0Zy6+GSKDZQMvUlqwHMZzMryMUSjYZYb9/7+DujNkDjt2c7hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=T/LCp9jL; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G3US0s9AhbQW+KZXBzdRBe9+d9S85YJD8W6IE7z1fBA=; b=T/LCp9jLHrYdd3c+tDD2hJZ6vE
	hfmV5L7VdybRhnWv6XcvT+GC8YYy4q/0+rQWpuQ/z51tGuJSD9DtRNGqjt6mIVvfJwnMuODuJIapp
	gWrqE13N35HevWJjGE/HVyUsVG9CbCzja2IGECPK97e8ALWcYgUPW2oMA/DfOwmkjV9WJmddgG94f
	zVLgg1CgBvBxZ7e8ysRRRtsraMkbUH8Q/yciScnbHh0nsMMT6ohFD5+6JiFc86fPlVz4pZ3VpK77F
	ZPi2CyyzlLCs/J+PgG9oc/WdgbWCPvvlbbXdgfYHomdOJFU+vnSxupySJFyd/x+NbT68J4Vz2OAWY
	a9k66X+Q==;
Received: from [179.118.191.115] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sICkD-003Fy9-IJ; Fri, 14 Jun 2024 21:37:53 +0200
Message-ID: <ea501920-7319-46f4-98ca-cea412abf8a9@igalia.com>
Date: Fri, 14 Jun 2024 16:37:41 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] drm: Support per-plane async flip configuration
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Melissa Wen <mwen@igalia.com>,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 Simon Ser <contact@emersion.fr>, Pekka Paalanen <ppaalanen@gmail.com>,
 daniel@ffwll.ch, Daniel Stone <daniel@fooishbar.org>,
 =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
 Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com,
 Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <bbrezillon@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>
References: <20240614153535.351689-1-andrealmeid@igalia.com>
 <lxfxqbax6azdpeamwm2qqv2tulgxrb7y3qzb4ir4myt6x5sqez@imd3yd5mbk7u>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <lxfxqbax6azdpeamwm2qqv2tulgxrb7y3qzb4ir4myt6x5sqez@imd3yd5mbk7u>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dmitry,

Em 14/06/2024 14:32, Dmitry Baryshkov escreveu:
> On Fri, Jun 14, 2024 at 12:35:27PM GMT, André Almeida wrote:
>> AMD hardware can do async flips with overlay planes, but currently there's no
>> easy way to enable that in DRM. To solve that, this patchset creates a new
>> drm_plane field, bool async_flip, that allows drivers to choose which plane can
>> or cannot do async flips. This is latter used on drm_atomic_set_property when
>> users want to do async flips.
>>
>> Patch 1 allows async commits with IN_FENCE_ID in any driver.
>>
>> Patches 2 to 7 have no function change. As per current code, every driver that
>> allows async page flips using the atomic API, allows doing it only in the
>> primary plane. Those patches then enable it for every driver.
>>
>> Patch 8 finally enables async flip on overlay planes for amdgpu.
>>
>> Changes from v5:
>> - Instead of enabling plane->async_flip in the common code, move it to driver
>> code.
>> - Enable primary plane async flip on every driver
>> https://lore.kernel.org/dri-devel/20240612193713.167448-1-andrealmeid@igalia.com/
>>
>> André Almeida (8):
>>    drm/atomic: Allow userspace to use explicit sync with atomic async
>>      flips
>>    drm: Support per-plane async flip configuration
>>    drm/amdgpu: Enable async flips on the primary plane
>>    drm: atmel-hlcdc: Enable async flips on the primary plane
>>    drm/i915: Enable async flips on the primary plane
>>    drm/nouveau: Enable async flips on the primary plane
>>    drm/vc4: Enable async flips on the primary plane
>>    drm/amdgpu: Make it possible to async flip overlay planes
>>
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 2 ++
>>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c         | 3 +++
>>   drivers/gpu/drm/drm_atomic_uapi.c                       | 8 +++++---
>>   drivers/gpu/drm/i915/display/i9xx_plane.c               | 3 +++
>>   drivers/gpu/drm/nouveau/dispnv04/crtc.c                 | 4 ++++
>>   drivers/gpu/drm/nouveau/dispnv50/wndw.c                 | 4 ++++
>>   drivers/gpu/drm/vc4/vc4_plane.c                         | 4 +++-
> 
> The main question is why only these drivers were updated.
> 

According to `git grep async_page_flip`, only those drivers supports 
async page flip. The only corner case is radeon, that does supports 
async but doesn't support planes.

Do you know any other driver that should be updated to?

>>   include/drm/drm_plane.h                                 | 5 +++++
>>   8 files changed, 29 insertions(+), 4 deletions(-)
>>
>> -- 
>> 2.45.2
>>
> 

