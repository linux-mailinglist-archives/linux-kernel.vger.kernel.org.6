Return-Path: <linux-kernel+bounces-263372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D12193D50F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB14B21BCB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594E511CA1;
	Fri, 26 Jul 2024 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrcX0U9e"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA502582
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003898; cv=none; b=DV48Mn3P4MALU7uHtzBehg7/WNrlwKNPfcyirM230iSZE5fci4r94iYHt0/8ouHuVxKj1Po3S1MBYAAKuwaSMuEM4gjoavrAuZf5c9U/ngZaCeKrYtRZo8cqU3b5cyAxFpM/b/ZzzZSU3BhezGDaS+FUS26OpEtdK6RTrocsB9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003898; c=relaxed/simple;
	bh=88VZJbW2zomcUeoCWxMkenrsnIN6/QGX3aGbR1C/skM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrXLr6XgJz670TXn25UrkaaO7xE/tHV1/LbQSpGSm+dBrdzQF6GanOsTY+wKDTgICxt0CsIPdAN/2n0f97Ij9BMdTC6uae2Ct7ttQBDWGt74Dxouhlq6AlUGJdp2vm7R026LPgnLtfKuq7SSvKVDgocvA7boa6eWOS4cqDPE/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrcX0U9e; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cb7cd6f5f2so766260a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722003896; x=1722608696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXgLD0m26HUeKNwihPrfsvZTOawIH1uUPigObJkbBi0=;
        b=ZrcX0U9eNxlXFsPLEwk3Al8a9Hzi8bcjWpPq6on9H4FF408MgCmwN7dxX7T1o6oh7m
         MXSqUrikdZSYL8Apw/A2rKQ3pZQvCMnnoYKDbfLqhtsAO/+wlPG03XmDlYKieph/eEqt
         sh3k9nraS8r3VwqZKt7kby8KWPMC97JT39ZsZOleKenZkfJvSCQOsTmpzjGqhVmUYNDp
         gNtWnuPXMN4e9mGCbp4pGY6EZcDDX19BaQV8jMypjx0Cmq9id9PLiJHLil6cy4bH9HqO
         OQ6ZVv1ujMs1cNBPtSjGWCNlrj3vT8NxS5n+JqUAuuL06BLNc4Ptzk2ERAF3ZnSXXtdU
         HVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722003896; x=1722608696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXgLD0m26HUeKNwihPrfsvZTOawIH1uUPigObJkbBi0=;
        b=mA5+JTv5cYuH0yv5uevLqgN/6hPNgq8RA8wh90SbAF54dq4l7neyCEm0ODSQcd6JL1
         0wyhDdKjkKPWTMQOF45ImCFtDabSBF57NiyUnMsKHAUWVYkmYERXsTzfG7n8RdeHgbzZ
         skH+CNSDaSUoJSroCdy4Vpg2mpZ1dKWELnXIq26jxjbZoU5nuSjh1pwExnIMkrsdYqlX
         exuiGuEb94uvJeC6UYWJip0SF5yvGzs3v+wjt5kieSB544116XT63845JJ0oBOuUu8x7
         XIrh4cm8xsee1a3YB+PFkwbt2QNbFDMqi6xOru5X07z/pVJBe7BfOAf+k49YySz137jh
         n7MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLjr52Ncem4jlZyRE3X+FFKtd1gXluG6A7m039toYSGuVLQrJmX7OyI6ek4EiTKKRv3tvIkxEcylTsnyM87jLDThlplMispFtJpm/5
X-Gm-Message-State: AOJu0YxkuO1mQ2nYaaTD0Dpc8pwCFjphVnUMjUMPiKXuy+jfC9I2V9En
	EWruTQu2Fs98xTxITERD1aPmam0uyPEMXtGF8oz2kamGIo39NcjNaitcKLnfmRKjLCGffuYU4ed
	CrgpvXivm7BUeysqupKO8J7V3VyU=
X-Google-Smtp-Source: AGHT+IFctf80aK3DGwTPMnlRmHGKh/s2j0PYO8TK/gc1CZicgQ4YnsnrfZIjmDDtFAEFkNZUB+suhX2Y6Dy2/0Rhxb0=
X-Received: by 2002:a17:90b:3007:b0:2c4:aa78:b48b with SMTP id
 98e67ed59e1d1-2cf2ec064bbmr6039798a91.38.1722003896184; Fri, 26 Jul 2024
 07:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726-amdgpu-edid-bios-v2-0-8a0326654253@weissschuh.net> <20240726-amdgpu-edid-bios-v2-2-8a0326654253@weissschuh.net>
In-Reply-To: <20240726-amdgpu-edid-bios-v2-2-8a0326654253@weissschuh.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Jul 2024 10:24:44 -0400
Message-ID: <CADnq5_NwCJV0exdGJ+nCFKdSZ-D85LsLQqCucF54jxtSa=yvSA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/radeon: convert bios_hardcoded_edid to drm_edid
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Xinhui Pan <Xinhui.Pan@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied the series.  Thanks!

Alex

On Fri, Jul 26, 2024 at 9:40=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
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
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  drivers/gpu/drm/radeon/radeon_atombios.c   | 17 ++++++-----------
>  drivers/gpu/drm/radeon/radeon_combios.c    | 26 +++++-------------------=
--
>  drivers/gpu/drm/radeon/radeon_connectors.c |  4 ++--
>  drivers/gpu/drm/radeon/radeon_display.c    |  2 +-
>  drivers/gpu/drm/radeon/radeon_mode.h       |  4 ++--
>  5 files changed, 16 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/r=
adeon/radeon_atombios.c
> index 168f3f94003b..81a0a91921b9 100644
> --- a/drivers/gpu/drm/radeon/radeon_atombios.c
> +++ b/drivers/gpu/drm/radeon/radeon_atombios.c
> @@ -1716,23 +1716,18 @@ struct radeon_encoder_atom_dig *radeon_atombios_g=
et_lvds_info(struct
>                                 case LCD_FAKE_EDID_PATCH_RECORD_TYPE:
>                                         fake_edid_record =3D (ATOM_FAKE_E=
DID_PATCH_RECORD *)record;
>                                         if (fake_edid_record->ucFakeEDIDL=
ength) {
> -                                               struct edid *edid;
> +                                               const struct drm_edid *ed=
id;
>                                                 int edid_size;
>
>                                                 if (fake_edid_record->ucF=
akeEDIDLength =3D=3D 128)
>                                                         edid_size =3D fak=
e_edid_record->ucFakeEDIDLength;
>                                                 else
>                                                         edid_size =3D fak=
e_edid_record->ucFakeEDIDLength * 128;
> -                                               edid =3D kmemdup(&fake_ed=
id_record->ucFakeEDIDString[0],
> -                                                              edid_size,=
 GFP_KERNEL);
> -                                               if (edid) {
> -                                                       if (drm_edid_is_v=
alid(edid)) {
> -                                                               rdev->mod=
e_info.bios_hardcoded_edid =3D edid;
> -                                                               rdev->mod=
e_info.bios_hardcoded_edid_size =3D edid_size;
> -                                                       } else {
> -                                                               kfree(edi=
d);
> -                                                       }
> -                                               }
> +                                               edid =3D drm_edid_alloc(f=
ake_edid_record->ucFakeEDIDString, edid_size);
> +                                               if (drm_edid_valid(edid))
> +                                                       rdev->mode_info.b=
ios_hardcoded_edid =3D edid;
> +                                               else
> +                                                       drm_edid_free(edi=
d);
>                                                 record +=3D struct_size(f=
ake_edid_record,
>                                                                       ucF=
akeEDIDString,
>                                                                       edi=
d_size);
> diff --git a/drivers/gpu/drm/radeon/radeon_combios.c b/drivers/gpu/drm/ra=
deon/radeon_combios.c
> index 41ddc576f8f8..df8d7f56b028 100644
> --- a/drivers/gpu/drm/radeon/radeon_combios.c
> +++ b/drivers/gpu/drm/radeon/radeon_combios.c
> @@ -370,7 +370,7 @@ static uint16_t combios_get_table_offset(struct drm_d=
evice *dev,
>  bool radeon_combios_check_hardcoded_edid(struct radeon_device *rdev)
>  {
>         int edid_info, size;
> -       struct edid *edid;
> +       const struct drm_edid *edid;
>         unsigned char *raw;
>         edid_info =3D combios_get_table_offset(rdev_to_drm(rdev), COMBIOS=
_HARDCODED_EDID_TABLE);
>         if (!edid_info)
> @@ -378,19 +378,14 @@ bool radeon_combios_check_hardcoded_edid(struct rad=
eon_device *rdev)
>
>         raw =3D rdev->bios + edid_info;
>         size =3D EDID_LENGTH * (raw[0x7e] + 1);
> -       edid =3D kmalloc(size, GFP_KERNEL);
> -       if (edid =3D=3D NULL)
> -               return false;
> -
> -       memcpy((unsigned char *)edid, raw, size);
> +       edid =3D drm_edid_alloc(raw, size);
>
> -       if (!drm_edid_is_valid(edid)) {
> -               kfree(edid);
> +       if (!drm_edid_valid(edid)) {
> +               drm_edid_free(edid);
>                 return false;
>         }
>
>         rdev->mode_info.bios_hardcoded_edid =3D edid;
> -       rdev->mode_info.bios_hardcoded_edid_size =3D size;
>         return true;
>  }
>
> @@ -398,18 +393,7 @@ bool radeon_combios_check_hardcoded_edid(struct rade=
on_device *rdev)
>  struct edid *
>  radeon_bios_get_hardcoded_edid(struct radeon_device *rdev)
>  {
> -       struct edid *edid;
> -
> -       if (rdev->mode_info.bios_hardcoded_edid) {
> -               edid =3D kmalloc(rdev->mode_info.bios_hardcoded_edid_size=
, GFP_KERNEL);
> -               if (edid) {
> -                       memcpy((unsigned char *)edid,
> -                              (unsigned char *)rdev->mode_info.bios_hard=
coded_edid,
> -                              rdev->mode_info.bios_hardcoded_edid_size);
> -                       return edid;
> -               }
> -       }
> -       return NULL;
> +       return drm_edid_duplicate(drm_edid_raw(rdev->mode_info.bios_hardc=
oded_edid));
>  }
>
>  static struct radeon_i2c_bus_rec combios_setup_i2c_bus(struct radeon_dev=
ice *rdev,
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm=
/radeon/radeon_connectors.c
> index 880edabfc9e3..528a8f3677c2 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -1059,7 +1059,7 @@ radeon_vga_detect(struct drm_connector *connector, =
bool force)
>          */
>         if ((!rdev->is_atom_bios) &&
>             (ret =3D=3D connector_status_disconnected) &&
> -           rdev->mode_info.bios_hardcoded_edid_size) {
> +           rdev->mode_info.bios_hardcoded_edid) {
>                 ret =3D connector_status_connected;
>         }
>
> @@ -1392,7 +1392,7 @@ radeon_dvi_detect(struct drm_connector *connector, =
bool force)
>  out:
>         if ((!rdev->is_atom_bios) &&
>             (ret =3D=3D connector_status_disconnected) &&
> -           rdev->mode_info.bios_hardcoded_edid_size) {
> +           rdev->mode_info.bios_hardcoded_edid) {
>                 radeon_connector->use_digital =3D true;
>                 ret =3D connector_status_connected;
>         }
> diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/ra=
deon/radeon_display.c
> index 10fd58f400bc..8f5f8abcb1b4 100644
> --- a/drivers/gpu/drm/radeon/radeon_display.c
> +++ b/drivers/gpu/drm/radeon/radeon_display.c
> @@ -1658,7 +1658,7 @@ void radeon_modeset_fini(struct radeon_device *rdev=
)
>                 rdev->mode_info.mode_config_initialized =3D false;
>         }
>
> -       kfree(rdev->mode_info.bios_hardcoded_edid);
> +       drm_edid_free(rdev->mode_info.bios_hardcoded_edid);
>
>         /* free i2c buses */
>         radeon_i2c_fini(rdev);
> diff --git a/drivers/gpu/drm/radeon/radeon_mode.h b/drivers/gpu/drm/radeo=
n/radeon_mode.h
> index e0a5af180801..421c83fc70dc 100644
> --- a/drivers/gpu/drm/radeon/radeon_mode.h
> +++ b/drivers/gpu/drm/radeon/radeon_mode.h
> @@ -39,6 +39,7 @@
>  #include <linux/i2c-algo-bit.h>
>
>  struct edid;
> +struct drm_edid;
>  struct radeon_bo;
>  struct radeon_device;
>
> @@ -262,8 +263,7 @@ struct radeon_mode_info {
>         /* Output CSC */
>         struct drm_property *output_csc_property;
>         /* hardcoded DFP edid from BIOS */
> -       struct edid *bios_hardcoded_edid;
> -       int bios_hardcoded_edid_size;
> +       const struct drm_edid *bios_hardcoded_edid;
>
>         /* firmware flags */
>         u16 firmware_flags;
>
> --
> 2.45.2
>

