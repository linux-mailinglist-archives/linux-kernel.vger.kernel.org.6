Return-Path: <linux-kernel+bounces-216414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C756909F08
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BAA28482D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F33D3B3;
	Sun, 16 Jun 2024 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="J1NYbAhT"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5F3A1DD
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718561694; cv=none; b=QVtFheHB9oalUtuQZiLODxNV+MoD9qhtAew+c0MKtKvBLpZGVKYDr6TggJPBdlbIeOeLejkBnkPHlI8VtEVxnDSQKpyvzZJxflfhink8QuLHKxO+OVyWPEct1cbD8U5PF/pbQBzo5DgLW0ZpHAHwTj+UkZwdvcetMlDkhIQ6gL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718561694; c=relaxed/simple;
	bh=E+iloMvlYwvEHQwfB3DXSeJGJGUJvC05nN+d51Pkqcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HF0xdhpZMMXbLz7lbte6rc7NGi8CFA8S3B+oJaK6QBog1cIvp710BAKDxWxUzomNmAF4s2WERpQI3799alKCuj8OO9VqZpzG7RmKcpLEGKTqLDdw46vcoDQTp4Xro8S8d9vKpyjQ8N/8O8MBcuIqDu7kgLwJJUzmm9ZNss+Bde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=J1NYbAhT; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718561686;
	bh=E+iloMvlYwvEHQwfB3DXSeJGJGUJvC05nN+d51Pkqcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J1NYbAhTMQfoL5IsH2ikb0aXfry28q/DcfRCNBJ7zve4896a+rzY0PLQcNKpInX/u
	 +gKrEsA21eYJmnqrRSz2y5lzg2sinfSowt2/0tE+T5M1zU4jXpZRC0Bd/kC7VzXkvy
	 QEvO5kndxuWEjS36Tv5Ub3M9LZQOsouaWm2DQt/8=
Date: Sun, 16 Jun 2024 20:14:45 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: convert bios_hardcoded_edid to drm_edid
Message-ID: <ad78ada4-4e31-4994-845b-fe756b52a1ae@t-8ch.de>
References: <20240616-amdgpu-edid-bios-v1-1-2874f212b365@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240616-amdgpu-edid-bios-v1-1-2874f212b365@weissschuh.net>

On 2024-06-16 11:12:03+0000, Thomas Weißschuh wrote:
> Instead of manually passing around 'struct edid *' and its size,
> use 'struct drm_edid', which encapsulates a validated combination of
> both.
> 
> As the drm_edid_ can handle NULL gracefully, the explicit checks can be
> dropped.
> 
> Also save a few characters by transforming '&array[0]' to the equivalent
> 'array' and using 'max_t(int, ...)' instead of manual casts.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> While this patch introduces a new user for drm_edid_raw(),
> if amdgpu proper gets migrated to 'struct drm_edid', that usage will go
> away.
> 
> This is only compile-tested.
> 
> I have some more patches for the rest of amdgpu,
> to move to 'struct drm_edid'.
> This patch is a test-balloon for the general idea.
> 
> The same can also be done for drm/radeon.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c |  6 +-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h       |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c       |  2 +-
>  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 21 +++++++--------------
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c         |  2 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c         |  2 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c          |  2 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c          |  2 +-
>  8 files changed, 15 insertions(+), 26 deletions(-)

<snip>
 
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> index 25feab188dfe..90383094ed1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> @@ -2064,20 +2064,13 @@ amdgpu_atombios_encoder_get_lcd_info(struct amdgpu_encoder *encoder)
>  				case LCD_FAKE_EDID_PATCH_RECORD_TYPE:
>  					fake_edid_record = (ATOM_FAKE_EDID_PATCH_RECORD *)record;
>  					if (fake_edid_record->ucFakeEDIDLength) {
> -						struct edid *edid;
> -						int edid_size =
> -							max((int)EDID_LENGTH, (int)fake_edid_record->ucFakeEDIDLength);
> -						edid = kmalloc(edid_size, GFP_KERNEL);
> -						if (edid) {
> -							memcpy((u8 *)edid, (u8 *)&fake_edid_record->ucFakeEDIDString[0],
> -							       fake_edid_record->ucFakeEDIDLength);
> -
> -							if (drm_edid_is_valid(edid)) {
> -								adev->mode_info.bios_hardcoded_edid = edid;
> -								adev->mode_info.bios_hardcoded_edid_size = edid_size;
> -							} else
> -								kfree(edid);
> -						}
> +						const struct drm_edid *edid;
> +						edid = drm_edid_alloc(fake_edid_record->ucFakeEDIDString,
> +								      max_t(int, EDID_LENGTH, fake_edid_record->ucFakeEDIDLength));
> +						if (drm_edid_valid(edid))
> +							adev->mode_info.bios_hardcoded_edid = edid;
> +						else
> +							drm_edid_free(edid);

The old code here seems broken in general.
In drivers/gpu/drm/amd/include/atombios.h the comment for ucFakeEDIDLength says:
(I expect the same field in the same struct for amdgpu to have the same semantics)

    UCHAR ucFakeEDIDLength;       // = 128 means EDID length is 128 bytes, otherwise the EDID length = ucFakeEDIDLength*128

So as soon as the EDID from the BIOS has extensions, only the first few
bytes will be copied into the allocated memory. drm_edid_is_valid() will
then read the uninitialized memory and if the "extensions" field ends up
non-zero it will happily "validate" past the allocated buffer.

The new code won't work either but at least it won't read uninitialized
memory nor will it read past the buffer bounds.

>  					}
>  					record += fake_edid_record->ucFakeEDIDLength ?
>  						  struct_size(fake_edid_record,

<snip>

