Return-Path: <linux-kernel+bounces-372072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C5B9A441F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4146D1C20FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41662036E9;
	Fri, 18 Oct 2024 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTZ2NN3i"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50151202651;
	Fri, 18 Oct 2024 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729270093; cv=none; b=oGxUQOHcJlYBsuJbh6J2/qzN5PmX8R7Tnh8u3B7YoxPtidz7cKh4upZlqV/0UYHZuiF8czju7/WXxIizuMqkTD9NBvy01hrOPN/qw1VOejlzb+nrtb80nOpNSgLzK/ExmKa82oRcVKDe7bRaDshmsDEsXjQKhI5GUy5wCowJpFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729270093; c=relaxed/simple;
	bh=cfG7+wQ41ZDxpQ7jdDKg8LaDeziyv82FxZfg3dp++54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJljUrwMtKYwRcuWjuk2pFzOOXELowNUfV4Nw/ab8GEZMc9fA9fJkAkvCS452ez/sjaMJq0vEY5nrg/6QqkWyAELSl9NhwLcWE+t9F3c+vVX7buBVoGQ+2D8kb/K9UfqmqmzfBjLg7GpcZ/vgKOmCkFsLfssfPW6S7yD6OdMZG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTZ2NN3i; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2d1b7bd57so260743a91.1;
        Fri, 18 Oct 2024 09:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729270090; x=1729874890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KdFMyZilgxNgos2aKAfdGC1JRwrBCcFoee7Jhfl6wo=;
        b=aTZ2NN3i6eVijeFgqrdS8iRd94jEWCKXR73recXiF8wU28tyN9e1+DriWRAmyJC5Ib
         MyPcj3BmPMjUFoGuPMAELPY7CIBuAYDdrnMZIu7IsYM3boCAkzN0tG/ZLeiC9xaGv863
         7aNbz7671+xuNeacBD+6USAZEvkPeSkZ/tFMooeUcl5xVY5ttxwrET4nkfQ2YjPHanhN
         jBk8x2NNPgdpO7/gAONAg/w6oWnDb6oXu5mM82ORbA0xiLIr8R4TeR79WimKqGl6UP3m
         RiDIeZnhrJpqhVQT430wJD3qFBKS/Uj3dQWzLTiePcmotsJAFJIAynzlARLhZDi4RT5Y
         U8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729270090; x=1729874890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KdFMyZilgxNgos2aKAfdGC1JRwrBCcFoee7Jhfl6wo=;
        b=wM6+FTb7oQ+29ZfLEA07+7SIlKa/TRT1qSUFu/oAQ/31LGtLQZbGG449/B8qtidx3a
         NPAp6d1XRDbN5G1BYGtyMmwt637QrcLf/R2NH0KPBUr3u5PCk83NOxM/ipD/Qft0k/7b
         FlH0F+BXEQWEJjPIB+vVKjDYt160zndiNUuRZSQMsVKwfVDBqbNU2vIVEZYqOl8Qumkn
         V/EphTIVPp2rp0IDrDxkaU0TXtzI0JLYCgxbFqstoumyLI164w9wiqHh8kwb0n3YybKb
         BMdEsAFbF6PSxxEnNRmFHSYLEUa3/33BM2fvSc4wesWk5D+bTdYi5wwGjbtl3m0Pa7AJ
         B8EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUigBrQ4beP9zSkA2/lXfZ8N1gtiVf1ePWSWRqESpfw7CmxuvZu/QPoDSsBeN4zXTz6AcgY+QJaVCU=@vger.kernel.org, AJvYcCWqLAeTNU9oOoVWdBUDIuTpF+WXybfqV4+pNVfmXsC2r6Ikpi/5Mtl+PnsIGEv40irQD7UIrxoDAz+YXa3h@vger.kernel.org
X-Gm-Message-State: AOJu0Yy330PWEj4jj79oT/sfcEK3gEc84xq4BFwYpi8CRd3zqqgdjluW
	OAUVEiBVhgdbaxWNZHC3wQnTWd0kLMhdPq9VDlovzSI9VKNyRieEp4gCgNrhFSGaYV6sPCqXpaY
	qKVZKFiLgQ2pzM5LBBb9F0fhthgQcZA==
X-Google-Smtp-Source: AGHT+IEHHpQqFYmBn0xV51TfI+SJmAuytoxVOYISR+ezP4xC8C3OEqfFW8De5N7maRo4MXgcOq1zix+V+Pc+gPWkCFg=
X-Received: by 2002:a17:90a:f189:b0:2e2:a70a:f107 with SMTP id
 98e67ed59e1d1-2e5615d618emr1697930a91.1.1729270090387; Fri, 18 Oct 2024
 09:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824-amdgpu-min-backlight-quirk-v6-0-1ed776a17fb3@weissschuh.net>
 <cfec358a-ff42-49c3-a174-149bee7a461c@t-8ch.de> <5b1c8688-8154-436e-ba8f-f5a9087d2c85@amd.com>
In-Reply-To: <5b1c8688-8154-436e-ba8f-f5a9087d2c85@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Oct 2024 12:47:57 -0400
Message-ID: <CADnq5_N9HxF749HviiM-cAcrrEUHJMohzdar4t5RTy_kNNK+Vg@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] drm: Minimum backlight overrides and
 implementation for amdgpu
To: Harry Wentland <harry.wentland@amd.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Matt Hartley <matt.hartley@gmail.com>, 
	Kieran Levin <ktl@framework.net>, Hans de Goede <hdegoede@redhat.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Xinhui Pan <Xinhui.Pan@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dustin Howett <dustin@howett.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 1:47=E2=80=AFPM Harry Wentland <harry.wentland@amd.=
com> wrote:
>
>
>
> On 2024-09-16 14:23, Thomas Wei=C3=9Fschuh wrote:
> > Hi Harry, Leo and other amdgpu maintainers,
> >
> > On 2024-08-24 20:33:53+0000, Thomas Wei=C3=9Fschuh wrote:
> >> The value of "min_input_signal" returned from ATIF on a Framework AMD =
13
> >> is "12". This leads to a fairly bright minimum display backlight.
> >>
> >> Introduce a quirk to override "min_input_signal" to "0" which leads to=
 a
> >> much lower minimum brightness, which is still readable even in dayligh=
t.
> >
> > could you take another look at the series?
> > The issues around panel power are not specific to the low pwm values,
> > so shouldn't have an impact on this series.
> > (And are nearly imperceptible anyways)
> >
>
> I think these patches are good.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Can you pick these up?

Thanks,

Alex

>
> Harry
>
> >> One solution would be a fixed firmware version, which was announced bu=
t
> >> has no timeline.
> >>
> >> ---
> >> Changes in v6:
> >> - Clean up cover letter and commit messages
> >> - Add my S-o-b to patch from Dustin
> >> - Mention testing in combination with "panel_power_savings"
> >> - Link to v5: https://lore.kernel.org/r/20240818-amdgpu-min-backlight-=
quirk-v5-0-b6c0ead0c73d@weissschuh.net
> >>
> >> Changes in v5:
> >> - Forward-declare struct drm_edid
> >> - Reorder patches, quirk entries are last
> >> - Add patch from Dustin for additional quirk entries
> >> - Link to v4: https://lore.kernel.org/r/20240812-amdgpu-min-backlight-=
quirk-v4-0-56a63ff897b7@weissschuh.net
> >>
> >> Changes in v4:
> >> - Switch back to v2 implementation
> >> - Add MODULE_DESCRIPTION()
> >> - Simplify quirk infrastructure to only handle min backlight quirks.
> >>   It can be extended if necessary.
> >> - Expand documentation.
> >> - Link to v3: https://lore.kernel.org/r/20240731-amdgpu-min-backlight-=
quirk-v3-0-46d40bb21a62@weissschuh.net
> >>
> >> Changes in v3:
> >> - Switch to cmdline override parameter
> >> - Link to v2: https://lore.kernel.org/r/20240623-amdgpu-min-backlight-=
quirk-v2-0-cecf7f49da9b@weissschuh.net
> >>
> >> Changes in v2:
> >> - Introduce proper drm backlight quirk infrastructure
> >> - Quirk by EDID and DMI instead of only DMI
> >> - Limit quirk to only single Framework 13 matte panel
> >> - Link to v1: https://lore.kernel.org/r/20240610-amdgpu-min-backlight-=
quirk-v1-1-8459895a5b2a@weissschuh.net
> >>
> >> ---
> >> Dustin L. Howett (1):
> >>       drm: panel-backlight-quirks: Add Framework 13 glossy and 2.8k pa=
nels
> >>
> >> Thomas Wei=C3=9Fschuh (3):
> >>       drm: Add panel backlight quirks
> >>       drm/amd/display: Add support for minimum backlight quirk
> >>       drm: panel-backlight-quirks: Add Framework 13 matte panel
> >>
> >>  Documentation/gpu/drm-kms-helpers.rst             |  3 +
> >>  drivers/gpu/drm/Kconfig                           |  4 +
> >>  drivers/gpu/drm/Makefile                          |  1 +
> >>  drivers/gpu/drm/amd/amdgpu/Kconfig                |  1 +
> >>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++
> >>  drivers/gpu/drm/drm_panel_backlight_quirks.c      | 94 ++++++++++++++=
+++++++++
> >>  include/drm/drm_utils.h                           |  4 +
> >>  7 files changed, 117 insertions(+)
> >> ---
> >> base-commit: d2bafcf224f3911b183113b2fcb536c9e90684a3
> >> change-id: 20240610-amdgpu-min-backlight-quirk-8402fd8e736a
> >>
> >> Best regards,
> >> --
> >> Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> >>
>

