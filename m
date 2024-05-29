Return-Path: <linux-kernel+bounces-194213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411558D3877
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9283B28243
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0BB1BF2B;
	Wed, 29 May 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHaHFGy9"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5249A1C290
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990915; cv=none; b=cE8fa5OEpV+rcrytUdMTHXG5iuTgW2hTVJ9caSAPVVF+GBAWYYZW1lVwEulrFx5sS7wwi9QLcrt2U3FH0tSGHnyXh9mj4zSkmcTFe1xcGNgb3RXgMHXixrxGOuXxZJbHMevyUEjgJR4CMPyJlo18wSzDFT5RNyultwIt6x7zSmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990915; c=relaxed/simple;
	bh=7pwxJwgIqNkEt9XQ+aY/jS7KUidtBt2N/WzmYBUYsp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+FVcCkuvZfGeUP+o6pUbQ8K9FhUo4y9wdcZR7hyB3gZZTRZ9WU666DDZXQT7K2dOuittxmsqXZFOl1EI2iGFBFZXuCwKWJuaTkJZa6v8MYF3YGpAzzQkkpYrfjusmPV3bkMLAJMAoL0EUxgDdfSi/3X+AF3op+/Ksxrn+fn9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHaHFGy9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f44b5b9de6so16480285ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716990913; x=1717595713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGlIeA8hMcr9Fm/VlCdK2KdthFpKjfRPf//jK9Gb9e8=;
        b=IHaHFGy9c5OqE4xNKb4XCL3vP4xhHCM7G6aGNkV/CWW3yi4C3fqzcoa3ZgSJblFI9a
         Y8yHj7j3AhxAhnTaATBvfgr1y7t3qr5yrtEiemuiylAUauUUiXW92wTF3JRmwMwMWrLt
         nF0tWLjnCjeT4HuwewA7hanV8zblX21LVEExt/eivxV804+VcLwh9roN0CZQ45eSNECv
         EEPhW0MK5Dn9GmeGioLVF4YJ2sUDzPC4d2ECqNty394999/8Tl1tU6x3wprT+a0mSL3J
         o1JnpPDo3XWRVXgDKJztNfGnYoXOmfgGxw4IYtNKbBi/VcmOGCkB0NNJE20oc+7+7L1j
         baLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716990913; x=1717595713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGlIeA8hMcr9Fm/VlCdK2KdthFpKjfRPf//jK9Gb9e8=;
        b=Muro07e4PZrt4LzQrm4a+NWOPgAExese5eRJTpBsD/0xVYiw/QflGgbXyUh/XsNkfT
         IgJ2KCgXQMPbgKYoKGOqtBG274FAO4QeZNC5JCNUhwHJNn77/Ox+fKBOe+/ITKoSoINZ
         5O8uaX+Zg/oD2TZ6ruHTKGLWr31Igadbs/RlHdf6sfmGWmSzvwLkZrgsN7LI9C6rTktP
         4bB6iktV0afRGGE6t+QpvZE8zh+xmMQEQIyqNRWhBdwQc/I9RVu1lHAtgA1mciBY/E1M
         9CC7QwFLbUwd1dQiK2A9s4aCslM9u8uN+vMUrkGQ+g3WRHID2z/ssU+9pZbGQ9LDv4bH
         80Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWUUuvz7DVQ4j/HxuOcVm/++saf5H9shO+tivxi/K29BGQ6cY4GNz+QuHnWxhmcO3IRMwDFl/O8tvXVPL1WFXJwF5cVz/jzAs2DmtSK
X-Gm-Message-State: AOJu0YyM7vSeyJ6zN03MLLoOGda/HEzn6SLv4cMIoUyR3OdX2AmMRax7
	QfNRwqh+EyJM/5Y9k87wUSVc++hNg78O8sRyQIUIw9kc9YadyhR5rqY+esf+c3VoJEqo2m6TDAz
	L1HbS2zLAatHm3usT128O8gpKZmg=
X-Google-Smtp-Source: AGHT+IHm0zRTpU3i/A0JVmM25LoggLAhFbg2a1hrsXcUm7MHJr4WHud5PBcWgghHM0zxa3+8cHQc/tmkKlFrhHf/w18=
X-Received: by 2002:a17:903:188:b0:1f4:ee68:3bc5 with SMTP id
 d9443c01a7336-1f4ee683c53mr18900995ad.57.1716990913482; Wed, 29 May 2024
 06:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528210319.1242-1-mario.limonciello@amd.com>
 <CADnq5_OzPT1MVnsqXs2vjr1L2_6jeM6x7jgs4ZtYpNzdDHM6uA@mail.gmail.com> <87r0dkiv4o.fsf@intel.com>
In-Reply-To: <87r0dkiv4o.fsf@intel.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 May 2024 09:55:01 -0400
Message-ID: <CADnq5_NiJ9a7uYPGj9iuePTRBFKGhhFA6G982bxO2kHe-_5ASA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/client: Detect when ACPI lid is closed during initialization
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-kernel@vger.kernel.org, Chris Bainbridge <chris.bainbridge@gmail.com>, 
	hughsient@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 9:51=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Wed, 29 May 2024, Alex Deucher <alexdeucher@gmail.com> wrote:
> > On Tue, May 28, 2024 at 5:03=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> If the lid on a laptop is closed when eDP connectors are populated
> >> then it remains enabled when the initial framebuffer configuration
> >> is built.
> >>
> >> When creating the initial framebuffer configuration detect the ACPI
> >> lid status and if it's closed disable any eDP connectors.
> >>
> >> Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3349
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Do you have drm-misc access or do you need someone to apply this for yo=
u?
>
> I've bounced this to intel-gfx and intel-xe lists to get CI testing. I'd
> appreciate holding off on merging until we have results.

Sure.

Alex

>
> Thanks,
> Jani.
>
> >
> > Alex
> >
> >> ---
> >> Cc: hughsient@gmail.com
> >> v1->v2:
> >>  * Match LVDS as well
> >> ---
> >>  drivers/gpu/drm/drm_client_modeset.c | 30 +++++++++++++++++++++++++++=
+
> >>  1 file changed, 30 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/dr=
m_client_modeset.c
> >> index 31af5cf37a09..0b0411086e76 100644
> >> --- a/drivers/gpu/drm/drm_client_modeset.c
> >> +++ b/drivers/gpu/drm/drm_client_modeset.c
> >> @@ -8,6 +8,7 @@
> >>   */
> >>
> >>  #include "drm/drm_modeset_lock.h"
> >> +#include <acpi/button.h>
> >>  #include <linux/module.h>
> >>  #include <linux/mutex.h>
> >>  #include <linux/slab.h>
> >> @@ -257,6 +258,34 @@ static void drm_client_connectors_enabled(struct =
drm_connector **connectors,
> >>                 enabled[i] =3D drm_connector_enabled(connectors[i], fa=
lse);
> >>  }
> >>
> >> +static void drm_client_match_edp_lid(struct drm_device *dev,
> >> +                                    struct drm_connector **connectors=
,
> >> +                                    unsigned int connector_count,
> >> +                                    bool *enabled)
> >> +{
> >> +       int i;
> >> +
> >> +       for (i =3D 0; i < connector_count; i++) {
> >> +               struct drm_connector *connector =3D connectors[i];
> >> +
> >> +               switch (connector->connector_type) {
> >> +               case DRM_MODE_CONNECTOR_LVDS:
> >> +               case DRM_MODE_CONNECTOR_eDP:
> >> +                       if (!enabled[i])
> >> +                               continue;
> >> +                       break;
> >> +               default:
> >> +                       continue;
> >> +               }
> >> +
> >> +               if (!acpi_lid_open()) {
> >> +                       drm_dbg_kms(dev, "[CONNECTOR:%d:%s] lid is clo=
sed, disabling\n",
> >> +                                   connector->base.id, connector->nam=
e);
> >> +                       enabled[i] =3D false;
> >> +               }
> >> +       }
> >> +}
> >> +
> >>  static bool drm_client_target_cloned(struct drm_device *dev,
> >>                                      struct drm_connector **connectors=
,
> >>                                      unsigned int connector_count,
> >> @@ -844,6 +873,7 @@ int drm_client_modeset_probe(struct drm_client_dev=
 *client, unsigned int width,
> >>                 memset(crtcs, 0, connector_count * sizeof(*crtcs));
> >>                 memset(offsets, 0, connector_count * sizeof(*offsets))=
;
> >>
> >> +               drm_client_match_edp_lid(dev, connectors, connector_co=
unt, enabled);
> >>                 if (!drm_client_target_cloned(dev, connectors, connect=
or_count, modes,
> >>                                               offsets, enabled, width,=
 height) &&
> >>                     !drm_client_target_preferred(dev, connectors, conn=
ector_count, modes,
> >> --
> >> 2.43.0
> >>
>
> --
> Jani Nikula, Intel

