Return-Path: <linux-kernel+bounces-292276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BB3956D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51AA71F23F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2791607A7;
	Mon, 19 Aug 2024 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SlQ+EDJ6"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F281D554
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077987; cv=none; b=aDZQqKLh48UFBAjdrLaM21l5CHWZ6H9PFe9q1bBtoSiN4wIwKle4NJ8gmAZDr0aCjYfSu+81uI8BzUXkz03Wn+wGjeFamPR3t6e78cBObB4EkKbShiph3Z9fMtQjGyc+lBWugkF37X2G/f4aW68mXkGUd1Cxk0iRaxkvvGVzwyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077987; c=relaxed/simple;
	bh=oY46spFSB+TR2L32LqUWYq42f01hyWum+P6CJ0QBLPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5qK3i1T/zOHW3yumBihzi7reYDSwRRypXEZ0nQvu//h9ao8pu/JpUc28cQyEC8m1I4ps8ot7bBVMfHUnwNmpmlEYMHBfSkZ6CchsFTtkl+mmhmDo/pFKnoSHLiCWe5vCr8se8fg/GfKrhrYZBgAuMTp8VNdurmILKxDDvKULQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SlQ+EDJ6; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PvbvwyhAJwiLi+2I6K3w9kJ9GX9Qp4KvlfpWMNEkxYo=; b=SlQ+EDJ6/CVgOMb39Ei8hdiJV9
	Fv6k5NalTYvQXtaxYm85pL/hMKMJsNSKV90z3JCfuzDlliT+8u1In/s0yt3G6NzrtGUFZ6MdZTayq
	wDutj4OEBO+IkJPzVS3Ql1al/IbwNYkCOR+JJuJVZHRjrSkqXZqx5f/KZHEC5+I50+U1KVUE/TEYZ
	o3Wbp0rvHgQMIvmVOLGdVSBfcORjpN1ml3PiAfKn8T9+n0ouW3UnDk9oJbWBoKEPkjw5U+sAGwC8E
	W1wzkTHAugvYRBfbX8a9SkimK1BnQdxquZ06WWDhxLB2JaYqUHnjRQk8UdjhOmq3T0ENG1gAUeqUC
	GOZElKtg==;
Received: from [189.6.17.125] (helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sg3R0-002EEW-R0; Mon, 19 Aug 2024 16:32:38 +0200
Date: Mon, 19 Aug 2024 11:31:44 -0300
From: Melissa Wen <mwen@igalia.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, jinzh <jinzh@github.amd.com>, 
	Aric Cyr <Aric.Cyr@amd.com>, Alan Liu <HaoPing.Liu@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, 
	Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] drm/amd: Switch over to struct drm_edid
Message-ID: <3v3yvr6adlnqgbwbnvhfwj3ylpptunqyvosazyebvov3osdprb@znkx32uxku5q>
References: <20240818-amdgpu-drm_edid-v1-0-aea66c1f7cf4@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240818-amdgpu-drm_edid-v1-0-aea66c1f7cf4@weissschuh.net>

On 08/18, Thomas Weiﬂschuh wrote:
> The AMD DRM drivers use 'struct edid', raw pointers and even custom
> structs to represent EDID data.
> Uniformly switch to the safe and recommended "struct drm_edid".
> 
> Some uses of "struct edid" are left because some ad-hoc parsing is still
> being done inside the drivers.

Hi Thomas,

It's great to see more people working on removing raw edid from amd
display driver in favor of drm_edid.

I glanced over your series and I found it similar to my recent proposal
to migrate amdgpu_dm_connector from edid to drm_edid. You can find the
v5 of this work here:
https://lore.kernel.org/amd-gfx/20240807203207.2830-1-mwen@igalia.com/

I believe it's more productive if we can join efforts and improve that
proposal instead of duplicating work. I'll look at your patches more
carefully this week. If you can review my work, I'd be happy to hear
your feedback too.

Thanks,

Melissa

> 
> The patch "drm/amd/display: Switch amdgpu_dm_connector to struct drm_edid"
> will conflict with my backlight quirk series [0].
> The conflict will result in an obvious and easy to fix build failure.
> 
> Patches 1 and 2 delete some dead code.
> Patches 3 to 6 constify some arguments and shuffle around some code.
> The remaining patches perform the actual conversion in steps.
> 
> [0] https://lore.kernel.org/lkml/20240818-amdgpu-min-backlight-quirk-v5-0-b6c0ead0c73d@weissschuh.net/
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Thomas Weiﬂschuh (12):
>       drm/amd/display: remove spurious definition for dm_helpers_get_sbios_edid()
>       drm/amd/display: Remove EDID members of ddc_service
>       drm/edid: constify argument of drm_edid_is_valid()
>       drm/amd/display: Simplify raw_edid handling in dm_helpers_parse_edid_caps()
>       drm/amd/display: Constify raw_edid handling in dm_helpers_parse_edid_caps()
>       drm/amd/display: Constify 'struct edid' in parsing functions
>       drm/amd/display: Use struct edid in dc_link_add_remote_sink()
>       drm/amdgpu: Switch amdgpu_connector to struct drm_edid
>       drm/amd/display: Switch amdgpu_dm_connector to struct drm_edid
>       drm/edid: add a helper to compare two EDIDs
>       drm/amd/display: Switch dc_sink to struct drm_edid
>       drm/amd/display: Switch dc_link_add_remote_sink() to struct drm_edid
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     | 56 ++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |  3 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |  4 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |  4 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |  4 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |  4 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 84 +++++++++++-----------
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  5 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 34 +++++----
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 28 ++++----
>  .../gpu/drm/amd/display/dc/core/dc_link_exports.c  |  5 +-
>  drivers/gpu/drm/amd/display/dc/dc.h                |  8 +--
>  drivers/gpu/drm/amd/display/dc/dc_ddc_types.h      |  7 --
>  drivers/gpu/drm/amd/display/dc/dc_types.h          |  5 --
>  drivers/gpu/drm/amd/display/dc/dm_helpers.h        |  4 +-
>  drivers/gpu/drm/amd/display/dc/inc/link.h          |  3 +-
>  .../gpu/drm/amd/display/dc/link/link_detection.c   | 42 ++++-------
>  .../gpu/drm/amd/display/dc/link/link_detection.h   |  3 +-
>  drivers/gpu/drm/drm_edid.c                         | 20 +++++-
>  include/drm/drm_edid.h                             |  3 +-
>  20 files changed, 155 insertions(+), 171 deletions(-)
> ---
> base-commit: 207565ee2594ac47261cdfc8a5048f4dc322c878
> change-id: 20240615-amdgpu-drm_edid-32d969dfb899
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 

