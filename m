Return-Path: <linux-kernel+bounces-185403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458C18CB48A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BE41F222F0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EC5148821;
	Tue, 21 May 2024 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAu16S+8"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B612B1EB40
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321995; cv=none; b=RVBthdsF7IrrdciiFS9GMDiGmqOQ9SQidM0qiyTIUasTv7T+bFyYTEBMi/3pVspGDB/fnJg5ycHYLcOwX30q+GGVad7DqJ9/UyM9okMFKnsjcu9HAh12Xfz/Org52UIbcREVkxlg5r0qLfheUojTunqnVvtXHcgQLgpclGQDFfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321995; c=relaxed/simple;
	bh=g0a7jYdSW9M5tWeX6z9IaFT24DgjNiPY8aicptuhv6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSJqScx59TB+9EqdnK1K1DiMWeSn6Zb2YLuetiVqLEzN0++IUWPXMhs7SIsfYY3OPXFYUv+TpStPgCuBGzorqxyiMsGBlPEgHQBvuboIOW2S/PUfvJCM6OUt5atqO1xQPVjpoEz1GKW7hE61g21F/1dLJHmTwV4HumuMFxkqxpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAu16S+8; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-df4d7babf3bso15144276.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716321992; x=1716926792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MR5DjSv8xW5VPd+KWcp/T0DpzQM38Nn27tvEAji7BQ=;
        b=eAu16S+8zfoCltmdX/n5NPWhq5vjoWJKps1I0UV23Un5n89VgcEurGj/w7NsUS7YMj
         AVmBKHMG1IoG/b6mKMcGD7GGW3aKLABZcOWGftrSpUltSHG9Z/+frWjvM2j6gpfili9y
         C0j0x2/jAyHhSBaHFExhCXECCnG4WnEq/UF5cA9WZvDG2O4TUf3StAObfuNAwUP9+PIQ
         BmMOSygCIE4c1hKP/NQVogbzauKvVy338vE+0bQf8/c/sINbJ9t2wYIsKKjpVGQ9zl76
         UEOr9bet/jnYbBwIAVD1292fF9aHOJT2zUn3dOboWTQey3aumgnw1Mj8tAM7EXj4FYOp
         EpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716321992; x=1716926792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MR5DjSv8xW5VPd+KWcp/T0DpzQM38Nn27tvEAji7BQ=;
        b=JOmM65eoWPTAHX2gN7BwjW7daFVhAkeJNkKQph2Ujvd2e+gGOYIehrpx505WJocYKl
         SS215Kr2+ez9PTuJorwApAZDIQReZoiYzYFSGxiafxZYcRimcbP/vSI70r1aZ4pMivAU
         MtyP3IZ7bI9NOuJfpCB033kg0zLWhUFjpEgEixr2T+q6MMz9IObHxTH4520wd/EJvVRZ
         Qld0vmi6ca5DPp2Gewxc9cbzgS8MRRYoYhVRMKgqEBEA9jhIKObTxzEc5GFFC/PDfmlq
         wDZ5wcd2pnDwcTOJ6l27+iTWKw2VOVlBrzPIV1NJ2qamvAYVk4AajaJLc2N7zT8TH808
         TljQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD0qI7qpWmDSmEMXwrE8B98rtbjV1aPHy6HXNZ2XHXt5aAIHm99FcyGr5AX2eazbdjLzhLPWtGED7sz9RZklR1TCdcvAmuapULHsed
X-Gm-Message-State: AOJu0YxkPtY8L2s3kdrWLPSNszDU+FcuNoHX4+to92u8g+Vzotdy8/mm
	pBpmFO97XPBATWghCivReKMDT1vbvU5RnDzxDS5+sJbTOfy1VlRVXZZenTXrMNRDaPv4bfkg84A
	98dM2da/DgpFxgLl/CBt6+36Ru3M=
X-Google-Smtp-Source: AGHT+IH9ydijh7ECa75vs0HHHE6Ew1epoA/bhjnzTRRSWClpr4GNuvnDgBkbRVrKvtoiMy0L/6EgqNr4XwkjbQ2Fz2Q=
X-Received: by 2002:a05:6902:1587:b0:df4:8c19:1da6 with SMTP id
 3f1490d57ef6-df4e0ebdadbmr106482276.6.1716321992557; Tue, 21 May 2024
 13:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fa885eca-d7e6-415a-8a08-9103b002c6bb@amd.com> <20240521051140.30509-1-rinoandrejohnsen@gmail.com>
 <17782a6e-db84-4c20-874a-342b9655ffc5@amd.com>
In-Reply-To: <17782a6e-db84-4c20-874a-342b9655ffc5@amd.com>
From: =?UTF-8?Q?Rino_Andr=C3=A9_Johnsen?= <rinoandrejohnsen@gmail.com>
Date: Tue, 21 May 2024 22:06:21 +0200
Message-ID: <CAACkh=-B-jH6g7KY7Nn_7Y_+gHPQ7G5Z5AZ0=a=_ifjcmsorcw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Add pixel encoding info to debugfs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: alexander.deucher@amd.com, Harry Wentland <harry.wentland@amd.com>, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Hersen Wu <hersenxs.wu@amd.com>, 
	Hamza Mahfooz <hamza.mahfooz@amd.com>, Wayne Lin <wayne.lin@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, 
	Tom Chung <chiahsuan.chung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

What is already there in debugfs is 'bpc' and 'colorspace', but not
the pixel encoding/format.
I have searched high and low for that to be able to verify that my
monitor and computer are using my preferred combination of all those
three values.

I do think it should be available as a standard DRM CRTC property, but
for the time being, I figured that a simple debugfs property would be
sufficient for time being.

Rino


On Tue, May 21, 2024 at 9:04=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 21.05.24 um 07:11 schrieb Rino Andre Johnsen:
> > [Why]
> > For debugging and testing purposes.
> >
> > [How]
> > Create amdgpu_current_pixelencoding debugfs entry.
> > Usage: cat /sys/kernel/debug/dri/1/crtc-0/amdgpu_current_pixelencoding
>
> Why isn't that available as standard DRM CRTC property in either sysfs
> or debugfs?
>
> I think the format specifiers should already be available somewhere there=
.
>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Rino Andre Johnsen <rinoandrejohnsen@gmail.com>
> > ---
> >
> > Changes in v2:
> > 1. Do not initialize dm_crtc_state to NULL.
> > ---
> >   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 47 ++++++++++++++++++=
+
> >   1 file changed, 47 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > index 27d5c6077630..4254d4a4b56b 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > @@ -1160,6 +1160,51 @@ static int amdgpu_current_colorspace_show(struct=
 seq_file *m, void *data)
> >   }
> >   DEFINE_SHOW_ATTRIBUTE(amdgpu_current_colorspace);
> >
> > +/*
> > + * Returns the current pixelencoding for the crtc.
> > + * Example usage: cat /sys/kernel/debug/dri/0/crtc-0/amdgpu_current_pi=
xelencoding
> > + */
> > +static int amdgpu_current_pixelencoding_show(struct seq_file *m, void =
*data)
> > +{
> > +     struct drm_crtc *crtc =3D m->private;
> > +     struct drm_device *dev =3D crtc->dev;
> > +     struct dm_crtc_state *dm_crtc_state;
> > +     int res =3D -ENODEV;
> > +
> > +     mutex_lock(&dev->mode_config.mutex);
> > +     drm_modeset_lock(&crtc->mutex, NULL);
> > +     if (crtc->state =3D=3D NULL)
> > +             goto unlock;
> > +
> > +     dm_crtc_state =3D to_dm_crtc_state(crtc->state);
> > +     if (dm_crtc_state->stream =3D=3D NULL)
> > +             goto unlock;
> > +
> > +     switch (dm_crtc_state->stream->timing.pixel_encoding) {
> > +     case PIXEL_ENCODING_RGB:
> > +             seq_puts(m, "RGB");
> > +             break;
> > +     case PIXEL_ENCODING_YCBCR422:
> > +             seq_puts(m, "YCBCR422");
> > +             break;
> > +     case PIXEL_ENCODING_YCBCR444:
> > +             seq_puts(m, "YCBCR444");
> > +             break;
> > +     case PIXEL_ENCODING_YCBCR420:
> > +             seq_puts(m, "YCBCR420");
> > +             break;
> > +     default:
> > +             goto unlock;
> > +     }
> > +     res =3D 0;
> > +
> > +unlock:
> > +     drm_modeset_unlock(&crtc->mutex);
> > +     mutex_unlock(&dev->mode_config.mutex);
> > +
> > +     return res;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(amdgpu_current_pixelencoding);
> >
> >   /*
> >    * Example usage:
> > @@ -3688,6 +3733,8 @@ void crtc_debugfs_init(struct drm_crtc *crtc)
> >                           crtc, &amdgpu_current_bpc_fops);
> >       debugfs_create_file("amdgpu_current_colorspace", 0644, crtc->debu=
gfs_entry,
> >                           crtc, &amdgpu_current_colorspace_fops);
> > +     debugfs_create_file("amdgpu_current_pixelencoding", 0644, crtc->d=
ebugfs_entry,
> > +                         crtc, &amdgpu_current_pixelencoding_fops);
> >   }
> >
> >   /*
>

