Return-Path: <linux-kernel+bounces-331016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C45D97A749
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 20:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669F82857AE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B375315D5C1;
	Mon, 16 Sep 2024 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ELtUFwHD"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73F15B10C;
	Mon, 16 Sep 2024 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726511040; cv=none; b=UfWFTxgHgAfzUDVUI8vL2ONqOdR1CcgiIndNCIAqtR9FbrDI3TjbTAZ4W5dzoLDky8C6cehMiUs1aS4yE55ZUdbWAfytIVvZ3iBg4CM+YXpg8SqZ39OV8jNDkQbI6gxiSeQ64Nirs+6kDmu90mjp+/y/G4bZAcuzNxv/wwE1a5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726511040; c=relaxed/simple;
	bh=vSu8t8Qbu000oREFKVL1jU2sAeGEYw6cm8ooSW1AZhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRC8WUjTw/rEQGld5/rDIRTXz+pUrE92WZN2wbQGI2p8ydwoYbKa5ldi17J1gA+dQm6MA4laBA9ILR7owVdRIsMwLzEwDnp/lsLKkAzFXFM8zdB1j8dbUjuM3No4ko9oMA+dHAkU1v1GADGh9I2/MiMK+4aRmIbRtzfkH6bTLro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ELtUFwHD; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1726511027;
	bh=vSu8t8Qbu000oREFKVL1jU2sAeGEYw6cm8ooSW1AZhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ELtUFwHDSFx5eeDybuOOUSW5DVL2JFuGivZAJKCNg2PY8iT9wneukXOqoxdxog5rv
	 Rzzlw/nFfvCPKWhuL+gOXOx/oIniHI9Bqk1PvtSStac2w6SQpNaTYTHxm2SY2LGFt5
	 HKdq3dQJMz8y4ePhYYsZA/VtMDnTE8fHPhT0dOTk=
Date: Mon, 16 Sep 2024 20:23:47 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>, 
	Hans de Goede <hdegoede@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, Jonathan Corbet <corbet@lwn.net>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 0/4] drm: Minimum backlight overrides and
 implementation for amdgpu
Message-ID: <cfec358a-ff42-49c3-a174-149bee7a461c@t-8ch.de>
References: <20240824-amdgpu-min-backlight-quirk-v6-0-1ed776a17fb3@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240824-amdgpu-min-backlight-quirk-v6-0-1ed776a17fb3@weissschuh.net>

Hi Harry, Leo and other amdgpu maintainers,

On 2024-08-24 20:33:53+0000, Thomas Weißschuh wrote:
> The value of "min_input_signal" returned from ATIF on a Framework AMD 13
> is "12". This leads to a fairly bright minimum display backlight.
> 
> Introduce a quirk to override "min_input_signal" to "0" which leads to a
> much lower minimum brightness, which is still readable even in daylight.

could you take another look at the series?
The issues around panel power are not specific to the low pwm values,
so shouldn't have an impact on this series.
(And are nearly imperceptible anyways)

> One solution would be a fixed firmware version, which was announced but
> has no timeline.
> 
> ---
> Changes in v6:
> - Clean up cover letter and commit messages
> - Add my S-o-b to patch from Dustin
> - Mention testing in combination with "panel_power_savings"
> - Link to v5: https://lore.kernel.org/r/20240818-amdgpu-min-backlight-quirk-v5-0-b6c0ead0c73d@weissschuh.net
> 
> Changes in v5:
> - Forward-declare struct drm_edid
> - Reorder patches, quirk entries are last
> - Add patch from Dustin for additional quirk entries
> - Link to v4: https://lore.kernel.org/r/20240812-amdgpu-min-backlight-quirk-v4-0-56a63ff897b7@weissschuh.net
> 
> Changes in v4:
> - Switch back to v2 implementation
> - Add MODULE_DESCRIPTION()
> - Simplify quirk infrastructure to only handle min backlight quirks.
>   It can be extended if necessary.
> - Expand documentation.
> - Link to v3: https://lore.kernel.org/r/20240731-amdgpu-min-backlight-quirk-v3-0-46d40bb21a62@weissschuh.net
> 
> Changes in v3:
> - Switch to cmdline override parameter
> - Link to v2: https://lore.kernel.org/r/20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net
> 
> Changes in v2:
> - Introduce proper drm backlight quirk infrastructure
> - Quirk by EDID and DMI instead of only DMI
> - Limit quirk to only single Framework 13 matte panel
> - Link to v1: https://lore.kernel.org/r/20240610-amdgpu-min-backlight-quirk-v1-1-8459895a5b2a@weissschuh.net
> 
> ---
> Dustin L. Howett (1):
>       drm: panel-backlight-quirks: Add Framework 13 glossy and 2.8k panels
> 
> Thomas Weißschuh (3):
>       drm: Add panel backlight quirks
>       drm/amd/display: Add support for minimum backlight quirk
>       drm: panel-backlight-quirks: Add Framework 13 matte panel
> 
>  Documentation/gpu/drm-kms-helpers.rst             |  3 +
>  drivers/gpu/drm/Kconfig                           |  4 +
>  drivers/gpu/drm/Makefile                          |  1 +
>  drivers/gpu/drm/amd/amdgpu/Kconfig                |  1 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++
>  drivers/gpu/drm/drm_panel_backlight_quirks.c      | 94 +++++++++++++++++++++++
>  include/drm/drm_utils.h                           |  4 +
>  7 files changed, 117 insertions(+)
> ---
> base-commit: d2bafcf224f3911b183113b2fcb536c9e90684a3
> change-id: 20240610-amdgpu-min-backlight-quirk-8402fd8e736a
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>
> 

