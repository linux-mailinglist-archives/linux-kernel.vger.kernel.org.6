Return-Path: <linux-kernel+bounces-233171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1656191B33F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85FA2834E0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B001917CD;
	Fri, 28 Jun 2024 00:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b="DH+T4J35"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABECF37B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719533860; cv=none; b=cK9W1j7bhQN/yKxDgBE3sNiDP85dZCDK9isBwckGJja8Nf6FHXJle/p3xZkoAnCZRWwiGjJBWu95pnIB9Sa4Go4S49BoL4rVQ8P/eq7yjj11aJFB1HhNx8d3KxOME0W+tZKMq2NM64+fP83OYp1ZIbSqAv0Lf3Vp2/Y4jvUTdXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719533860; c=relaxed/simple;
	bh=N9ThLQ+7KgfFZ8cJDzO01kM2N2S6IKcjljMIIL0NUS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtUlSpgi6iAgbnPmlNZzpREB4ryLnNC4p1+S1jtneTeYdXXQGmqH/2XgJh4LogZLiXVEw/izhZ4aOxL5dqgKnrM1gfoBmUaGH2zJG8dIGL46rDsn0uM+zMcvYVpRdtAVOMOepqn62jTeloZOdM+ul4ZyD1nforJdhbmCGbhAcyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu; spf=pass smtp.mailfrom=gwmail.gwu.edu; dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b=DH+T4J35; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gwmail.gwu.edu
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7f4e2703306so32781639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google; t=1719533858; x=1720138658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnM2FwovgrQogO5x3uloG9tQo9wPv4O5SS6GjjUuiVU=;
        b=DH+T4J35yMSU+v9xjathDlXoM291Fhc/qPU+xPzlHWnbBWUGTw/Cb0fWnEGHMG7k35
         vIxhCh5Ksjbx6lDvA70DL77Jq0L3xpEYh+emegJLWfwKPcaUr4olPmPUTxACS0xZoNoy
         vaYfCvi6z0evVvVRQBWZQ3YS/WsIYD2NoUIML73huTYYYzmFwdlq+z/Xq/0z5qlQKOxj
         5d2IhdEBtXSWU8ppA/+kwzn3DWZo1jIe95vFfZPHZ1tyTo/9a4NM4LsgTIXP9Tzf6FO1
         Ef3PsbHY0q/izdHCOerYY8wcOdC2z7y4cKCIjjN/IbvAEd3XSDvk7bPeay+MVBlsfFuK
         4ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719533858; x=1720138658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnM2FwovgrQogO5x3uloG9tQo9wPv4O5SS6GjjUuiVU=;
        b=oNKiWedFEVQOX1s/imzh/cEzHpgT15JNndHDljcTTisTYRZM0ugNDMtl9rF0ySKjqb
         DOPRUp+ZZTs6HxQQcUWjGkDhvzV7qEP53LlHNrYAf2cIGQFYUP/SY7sqFuvN4DnbS4LF
         d9p1l5U6C13LqptnUWmcwXWlfYpiVauS8TI9iFMhXjDeEl0C+F+jGNjRDk+Y9PxDzG3B
         6Ej7xn6rPNfBqJxzzuAkLyEsRmGfWMn1GjklIKfOcLnEzxLll7k4zFrk2IaU7o1T8j9W
         gEtgegZ4F1opwdWBPwfiuiQN4Dph0dXMTPzCZlZXCGWtWzDMwJrZ4zxPb0YyB3ifC8Gu
         TqHw==
X-Forwarded-Encrypted: i=1; AJvYcCX7dho2ZozdaXwdbqtjRBZmdNJcTY9L2rLvbLbmBA4i/ZpWimTOuaZBcsOGYirUKzVJwwFH6Rw2DKUdc6kLK8sEdEuTJ4YbdIZyFC4H
X-Gm-Message-State: AOJu0YyUkfGxohrr8TBZGxpd8xpXRP2DUAv3BSKhvc0m2YcewkKbgYBT
	OzytqiEN9wiBN7ICVL0BFxSQkTixEj37DffVGLR2PMXq0hrVPaGWYePoh57q0uQIrHx3U3m1Dme
	uMUVLp5Yt/4i+t0hxqkDyUsM2AxQIn8eU3owi
X-Google-Smtp-Source: AGHT+IHyRGLJvkEBIGRGo1vbnj9QgLJ7fr7zj3XE934AAsCrW0MPZKLToa3TeWyQKmD6e+YZZIirW5gMIfQOtuRKdx8=
X-Received: by 2002:a92:c265:0:b0:375:dd94:29f with SMTP id
 e9e14a558f8ab-37b26171927mr758175ab.0.1719533857696; Thu, 27 Jun 2024
 17:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627203057.127034-1-mattschwartz@gwu.edu> <20240627203057.127034-2-mattschwartz@gwu.edu>
 <19ca1a46-6a74-4eec-9e84-0092faaee7a1@amd.com>
In-Reply-To: <19ca1a46-6a74-4eec-9e84-0092faaee7a1@amd.com>
From: Matthew Schwartz <mattschwartz@gwmail.gwu.edu>
Date: Thu, 27 Jun 2024 17:17:27 -0700
Message-ID: <CAD9O9Dp89CprZFMn=ysduPmUTkmJ5y6qDw18X9pLr7=ChoD0Uw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm: panel-orientation-quirks: Add quirk for Valve Galileo
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Schoenick <johns@valvesoftware.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Kyle Gospodnetich <me@kylegospodneti.ch>, 
	Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Matthew Schwartz <mattschwartz@gwu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 2:28=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.co=
m> wrote:
>
> On 6/27/24 16:30, Matthew Schwartz wrote:
> > From: John Schoenick <johns@valvesoftware.com>
>
> Since this patch is from John, you would need his S-o-b in here as well
> (assuming you have his permission to add it).

This patch will be pending approval from them in that case. The panel quirk
follows the same structure as the Steam Deck Jupiter revision, but the quir=
k
has only been signed during merges by people who were not the original auth=
or.
Link: https://gitlab.com/evlaV/linux-integration/-/commit/b90ac393

>
> >
> > Valve's Steam Deck Galileo revision has a 800x1280 OLED panel
> >
> > Suggested-by: John Schoenick <johns@valvesoftware.com>
> > Link: https://gitlab.com/evlaV/linux-integration/-/commit/d2522d8bf88b3=
5a8cf6978afbbd55c80d2d53f4f
> > Signed-off-by: Matthew Schwartz <mattschwartz@gwu.edu>
> > ---
> >   drivers/gpu/drm/drm_panel_orientation_quirks.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/g=
pu/drm/drm_panel_orientation_quirks.c
> > index 3d127127e7cb..ac8319d38e37 100644
> > --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> > +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> > @@ -427,6 +427,13 @@ static const struct dmi_system_id orientation_data=
[] =3D {
> >                 DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
> >               },
> >               .driver_data =3D (void *)&lcd800x1280_rightside_up,
> > +     }, {    /* Valve Steam Deck */
> > +             .matches =3D {
> > +               DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
> > +               DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galileo"),
> > +               DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
> > +             },
> > +             .driver_data =3D (void *)&lcd800x1280_rightside_up,

Unless I get a S-o-b, is authoring a different DMI check the only solution
to get a functioning panel quirk upstreamed for the Galileo revision?
Not quite sure how I'd maintain conformity with the existing Jupiter
quirk while also writing something original here.

> >       }, {    /* VIOS LTH17 */
> >               .matches =3D {
> >                 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "VIOS"),
> --
> Hamza
>
--
Matt

