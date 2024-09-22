Return-Path: <linux-kernel+bounces-335157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FFB97E202
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 16:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5201C20CC6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2498F6A;
	Sun, 22 Sep 2024 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yy2HFeUd"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6029A2
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727015645; cv=none; b=Jvz4w1X3WNqDzX6N75cH947hR9SjrWpLxrevA/Aw5I3IP7e4UzUZUXKLpF6WW8C6J1cflZDeR+BlV47KsKMZbbQ638mrnLuqOGKDgEGPZKmC6S3ZHBb5N9XofND3kCAzIy9Hi3OA/kvc/jZwLHj+VhAJaR3JzwuJWoI3yKuHo1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727015645; c=relaxed/simple;
	bh=Gnrwbqba2p5hQINy94xbyEn4Z/kd4RkGA9/88qV7pYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzotclIaumw49USsOeJi8o+vd4UgY7qo4+CmgYGX9S3G32T0deH/235yKVw9AT2WrOMdv33E0BZh7/6kzEkRrVgxEBqbWF+F9Yc18BavdF4GAmJiWa492UGTxyzM8nDo8XkPDPKnXKukgFDGZ92LoBQS91WVS2nd6NE2hwYBVyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yy2HFeUd; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6de05b9fd0bso28184737b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 07:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727015640; x=1727620440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHeGraYA3dGaR0TNSrhM0uA2RkFxJIHWUg3p/EO2nAk=;
        b=yy2HFeUd9EUdiSYxm8f6MSxmQGaCq0sUBHJx3qEqpLdDm3NCHvJd2BOotJEbw7eGbS
         AC5djuHtCvFz9SJ7bpZQmJQh35SHcmb2qo9NULcVRUTIcURehk0wKEhsSQCL0lxmKrL5
         gIWj+BGQfk2Kfq5bIUx364AHrGiTbi69b88pb5xX9lxc7Wak18aBlx024w0w3stTZEif
         foNWRZwOuhmgLXf+1tIBb7glvm7lIpIzDG9VGp1ca8hIc/zNLld9o5gtq20romxQOSAK
         LGqibhPKsR7EWKl9WO5Gp0YhQrLrFacaWO7Zs/lmQyJyLTIT93mK/QBCL6ur4K+JmRY9
         69Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727015640; x=1727620440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHeGraYA3dGaR0TNSrhM0uA2RkFxJIHWUg3p/EO2nAk=;
        b=upitEyUHehGPzZBq7CPQeGxUefRvZE4XzSl7LX52FOhvlBYKMDxb9duEi3VSuwo8d6
         iRD/iqTNKmWlHXKWmEWLvEp15r0U+FP7fYBb7ykhod6wTBlviUO3KAXGPfnz8PuVBZlF
         QKQt+OdMIXIuB15PFIbwOWh0B8UpyQQa1GsHXvgOEtKa2nQvHbzWpgfGGlWH88fcFt2j
         8UgVaA6tfw8dSmFlfw1SngM5AJgoll/+mYtRJ/j2W4EAAur2Tok0e3FjdGPN4YrCruI0
         SObUTX4cSVZHB1fHKy6UnWvpOgO7a66zqaY7nlJ4LnE0/coRbIetXCVHxpmLLo7HWBsh
         27EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiY3GSJqucXzDE4jkD9kmXc7Jwo2kfoE9SnxRhAs0edwVQxVBCLn9+cWsi3kMAUExF/BSwz2fYVKSxKIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlt5SWy1cwjwyXkMVhRrqM6cqptqW461H4LNWz3te2uBgW29yN
	LbbDrdUWrTMB0jfsgsQdb3heKHgItRLC5pktpcJ40uKW7USnt6hTjhvqODn+z2RaBA/S3wLEBtU
	eHP7QSftS05LXZ9ZuyHVwM9+XQZPB6MWZs7zuMw==
X-Google-Smtp-Source: AGHT+IHKzXLaRDGAOOJlN5ccsLLxF4TSLQsyK9kPJHcFIpOzEJDTsH5QrInR8hKs28oj8KV/TnrBU1qVlNXlaSk0TjE=
X-Received: by 2002:a05:690c:1b:b0:6c9:9341:1ce1 with SMTP id
 00721157ae682-6dff2903a2cmr59752777b3.32.1727015640248; Sun, 22 Sep 2024
 07:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726492131.git.tjakobi@math.uni-bielefeld.de>
 <2b35545b77a9fd8c9699b751ca282226dcecb1dd.1726492131.git.tjakobi@math.uni-bielefeld.de>
 <gnllphvuffajfbh3aczda5z7t3ytjexf5a6wuuzsz6pla6e2kz@m564uc2ogn4q> <a90d08d5-265a-4ba2-99f9-68fa18960b27@redhat.com>
In-Reply-To: <a90d08d5-265a-4ba2-99f9-68fa18960b27@redhat.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 22 Sep 2024 16:33:50 +0200
Message-ID: <CAA8EJprMy7H+-z2+OAC_F9m-3GQe28oWKJJ5GYFj61ss7gYBuQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm: panel-orientation-quirks: Add quirk for AYA NEO
 2 model
To: Hans de Goede <hdegoede@redhat.com>
Cc: tjakobi@math.uni-bielefeld.de, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>, 
	"Derek J . Clark" <derekjohn.clark@gmail.com>, Denis Benato <benato.denis96@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 22 Sept 2024 at 13:11, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 21-Sep-24 10:02 PM, Dmitry Baryshkov wrote:
> > On Mon, Sep 16, 2024 at 03:18:51PM GMT, tjakobi@math.uni-bielefeld.de w=
rote:
> >> From: Joaqu=C3=ADn Ignacio Aramend=C3=ADa <samsagax@gmail.com>
> >>
> >> Add quirk orientation for AYA NEO 2. The name appears without spaces i=
n
> >> DMI strings. That made it difficult to reuse the 2021 match. Also the
> >> display is larger in resolution.
> >>
> >> Tested by the JELOS team that has been patching their own kernel for a
> >> while now and confirmed by users in the AYA NEO and ChimeraOS discord
> >> servers.
> >>
> >> Signed-off-by: Joaqu=C3=ADn Ignacio Aramend=C3=ADa <samsagax@gmail.com=
>
> >> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> >> ---
> >>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/=
gpu/drm/drm_panel_orientation_quirks.c
> >> index 2166208a961d..3044927c0c5c 100644
> >> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> >> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> >> @@ -184,6 +184,12 @@ static const struct dmi_system_id orientation_dat=
a[] =3D {
> >>                DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T103HAF"),
> >>              },
> >>              .driver_data =3D (void *)&lcd800x1280_rightside_up,
> >> +    }, {    /* AYA NEO AYANEO 2 */
> >> +            .matches =3D {
> >> +              DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
> >> +              DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
> >> +            },
> >> +            .driver_data =3D (void *)&lcd1200x1920_rightside_up,
> >
> > I thought that AYANEO should come after AYADEVICE, but the array doesn'=
t
> > seem really sorted
>
> It is sorted but it is sorted by the Vendor - Model in the comments,
> not by the DMI strings since sometimes those are e.g. "SYS_VENDOR",
> "Default String" and stuff like that.

Ah, I didn't notice that.  I think it's still not fully sorted (e.g.
KUN comes after NEXT), but that's probably fine.

>
> The entire series looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> for the series.
>
> > Thus:
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > If I hear no objections and if noone beats me, I'll apply the series
> > within few days.
>
> I'm currently travelling so if you can apply this series
> to drm-misc-fixes that would be great.

Done.

>
> Regards,
>
> Hans
>
>
> >
> >
> >>      }, {    /* AYA NEO 2021 */
> >>              .matches =3D {
> >>                DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYADEVICE"),
> >> --
> >> 2.44.2
> >>
> >
>


--=20
With best wishes
Dmitry

