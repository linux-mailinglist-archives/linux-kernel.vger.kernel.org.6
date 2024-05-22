Return-Path: <linux-kernel+bounces-186032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422D38CBF00
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D439A284E81
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE55823CB;
	Wed, 22 May 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmbARhV3"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5DA81AC9
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372470; cv=none; b=D2WYHXE9Zd43fUSAtwyJFP4c4ZoMIMvaRnTtKpg4zu4yrrBzL1cx7FkizG4jQxvRwSvbrFvKpVszuH+YgxLapasEijKQwA+fehtDQslSLAzmzlbW2GLNyXoY29hjzz+j+XW3ZFKHf+nwTZKEk9fqE2/tLT56BSkOV+N/ycKFqHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372470; c=relaxed/simple;
	bh=2xQGrIJl8ucc90zmBMPS7OMS6ws/ES8DgrgvhddFQjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZ61LWv9xttFM4Cc9AhUL+Ku1OdltQjf0wDmoKDCb0X1LY5Iu1qRw7tq0g8OU+NlWiodnFsGxnA1koPp8GTDk89Q70Dbh589YxjqZpGMpTiyANtdAfn2Fx2TnWAMCX4/V7AvJQlWOcb//Cj07CLlwXDyBeXG0oKtSHdUTqT+M+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmbARhV3; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-df4da0579b6so53910276.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716372467; x=1716977267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYAIfZw1pkV8spolfI/p1xvCTUqzpLywcb68T4prkxU=;
        b=RmbARhV3j08tZ2WmJcjqoE/C1igaXs9JsL//egJIdm2KjAy6CasCbNpelUdOtEUZGL
         QAHoE419+zzk+5k0L5+yUXTrrwRd8fQJuuZ4cXN1gbfOxr3FZ64yg6NxoBkEWD4BGhHr
         ZRzmt2XS8+pvwcQk6KGRS0hZogD8C9SoXqecG3C1c09xdOHFVptZRE0yTeMQ5D86dZIr
         iBU3ezxY5uFJPR+lqBA834YC0g+hDlwV6ZzxnEPJQccrWa5C4NL38fiBsXjMx/7BoA90
         gYggsQ2xP3xV3518tH8n3jYDEbS/Wo9uBovBoD9yJMHn9fsFiPc7Af2t6I5yrw/SqqOa
         zkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716372467; x=1716977267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYAIfZw1pkV8spolfI/p1xvCTUqzpLywcb68T4prkxU=;
        b=Lk/wxY62J+SGNc+D83f1DGnauJr7lCAnJHvKgnyUmYArqtjFXSsWVPOuC3I/9dCyJP
         6eTEM/kcxqTqxPMg9Ji7zo6QbDUGy1mdrGpHQEuLcttdkGVborwFLiVFBBVZNsI6k1Tf
         9n6OmVBCYyhfl37w6wsQGWeI/TmF8N/GReq8mLM2pMIh0cslJBx/hsWryaK1Y0fmKNYg
         NRZe0cD2ZWHIP7Y/MQC3xdB0X4ETh3GCN7s8q+fbz9LP5x8waKb625XVsWl9b22RI/e6
         Jro6ycmB+4IIMEOs62+Pe/ZcK+bgU44EqbFI2R8m5ZYjJ+QoWsKZMoy89PbwvHPiKmrd
         My/g==
X-Forwarded-Encrypted: i=1; AJvYcCXng+IXSnuKCbU4V0ZCgZBcrSq0RrOvlmcYPgoW1wXDVdNb5ZfhTTtq5vWj6/KYPZgh/tkLCYX2IPh5vxeLnHI6nIbIlUiNzgLrap/5
X-Gm-Message-State: AOJu0YzY7NlxHuaDUTAh1DQkfln+BB8qWPFI/BJ54is70Y/yGI4TOJIe
	vOEdr8KoSeaAIvfvOmteelr4Vu924CupzI3PKNOs9wEpsYTp2yyksT/ywnNQq9aIg/C9xbMevon
	tbnCT3uaP5lOF/KmNYOBSvoyTMz8=
X-Google-Smtp-Source: AGHT+IFel+c4KStAAY5NfiWIEWgcD+1V1XSEK0JgYjZA0oyC4mhxOzw8ugHhfEf2pZ74D22tA6V11fBr2krncREDYeQ=
X-Received: by 2002:a05:6902:2411:b0:df4:4724:8755 with SMTP id
 3f1490d57ef6-df4e0a80fedmr1699384276.1.1716372467286; Wed, 22 May 2024
 03:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fa885eca-d7e6-415a-8a08-9103b002c6bb@amd.com> <20240521051140.30509-1-rinoandrejohnsen@gmail.com>
 <17782a6e-db84-4c20-874a-342b9655ffc5@amd.com> <CAACkh=-B-jH6g7KY7Nn_7Y_+gHPQ7G5Z5AZ0=a=_ifjcmsorcw@mail.gmail.com>
 <86410711-9b88-448c-9148-109f81b1ca55@amd.com>
In-Reply-To: <86410711-9b88-448c-9148-109f81b1ca55@amd.com>
From: =?UTF-8?Q?Rino_Andr=C3=A9_Johnsen?= <rinoandrejohnsen@gmail.com>
Date: Wed, 22 May 2024 12:07:36 +0200
Message-ID: <CAACkh=9hY7eg_uuH7Psm=XJfSzwQTvzs8bvOXQ=wwkMPrC44SA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Add pixel encoding info to debugfs
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	alexander.deucher@amd.com, Harry Wentland <harry.wentland@amd.com>, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Hersen Wu <hersenxs.wu@amd.com>, 
	Hamza Mahfooz <hamza.mahfooz@amd.com>, Wayne Lin <wayne.lin@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, 
	Tom Chung <chiahsuan.chung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To be perfectly honest with you, I haven't given that much though. I
used the 'bpc' and 'colorspace' property in debugfs, since I could not
find that information anywhere else. And since I also needed to verify
the pixel encoding being used, I added it where those other values
were. That made for a simple and easy addition for this property.

If you want me to do this differently, let me know. And please point
me to the standardized DRM property where I should expose the values.

Rino

On Tue, May 21, 2024 at 10:55=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 5/21/2024 15:06, Rino Andr=C3=A9 Johnsen wrote:
> > What is already there in debugfs is 'bpc' and 'colorspace', but not
> > the pixel encoding/format.
> > I have searched high and low for that to be able to verify that my
> > monitor and computer are using my preferred combination of all those
> > three values.
> >
> > I do think it should be available as a standard DRM CRTC property, but
> > for the time being, I figured that a simple debugfs property would be
> > sufficient for time being.
> >
>
> It's just about as much work either way to populate it though, why do it
> twice instead of just doing it right the first time?
>
> > Rino
> >
> >
> > On Tue, May 21, 2024 at 9:04=E2=80=AFPM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> Am 21.05.24 um 07:11 schrieb Rino Andre Johnsen:
> >>> [Why]
> >>> For debugging and testing purposes.
> >>>
> >>> [How]
> >>> Create amdgpu_current_pixelencoding debugfs entry.
> >>> Usage: cat /sys/kernel/debug/dri/1/crtc-0/amdgpu_current_pixelencodin=
g
> >>
> >> Why isn't that available as standard DRM CRTC property in either sysfs
> >> or debugfs?
> >>
> >> I think the format specifiers should already be available somewhere th=
ere.
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Signed-off-by: Rino Andre Johnsen <rinoandrejohnsen@gmail.com>
> >>> ---
> >>>
> >>> Changes in v2:
> >>> 1. Do not initialize dm_crtc_state to NULL.
> >>> ---
> >>>    .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 47 +++++++++++++++=
++++
> >>>    1 file changed, 47 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.=
c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> >>> index 27d5c6077630..4254d4a4b56b 100644
> >>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> >>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> >>> @@ -1160,6 +1160,51 @@ static int amdgpu_current_colorspace_show(stru=
ct seq_file *m, void *data)
> >>>    }
> >>>    DEFINE_SHOW_ATTRIBUTE(amdgpu_current_colorspace);
> >>>
> >>> +/*
> >>> + * Returns the current pixelencoding for the crtc.
> >>> + * Example usage: cat /sys/kernel/debug/dri/0/crtc-0/amdgpu_current_=
pixelencoding
> >>> + */
> >>> +static int amdgpu_current_pixelencoding_show(struct seq_file *m, voi=
d *data)
> >>> +{
> >>> +     struct drm_crtc *crtc =3D m->private;
> >>> +     struct drm_device *dev =3D crtc->dev;
> >>> +     struct dm_crtc_state *dm_crtc_state;
> >>> +     int res =3D -ENODEV;
> >>> +
> >>> +     mutex_lock(&dev->mode_config.mutex);
> >>> +     drm_modeset_lock(&crtc->mutex, NULL);
> >>> +     if (crtc->state =3D=3D NULL)
> >>> +             goto unlock;
> >>> +
> >>> +     dm_crtc_state =3D to_dm_crtc_state(crtc->state);
> >>> +     if (dm_crtc_state->stream =3D=3D NULL)
> >>> +             goto unlock;
> >>> +
> >>> +     switch (dm_crtc_state->stream->timing.pixel_encoding) {
> >>> +     case PIXEL_ENCODING_RGB:
> >>> +             seq_puts(m, "RGB");
> >>> +             break;
> >>> +     case PIXEL_ENCODING_YCBCR422:
> >>> +             seq_puts(m, "YCBCR422");
> >>> +             break;
> >>> +     case PIXEL_ENCODING_YCBCR444:
> >>> +             seq_puts(m, "YCBCR444");
> >>> +             break;
> >>> +     case PIXEL_ENCODING_YCBCR420:
> >>> +             seq_puts(m, "YCBCR420");
> >>> +             break;
> >>> +     default:
> >>> +             goto unlock;
> >>> +     }
> >>> +     res =3D 0;
> >>> +
> >>> +unlock:
> >>> +     drm_modeset_unlock(&crtc->mutex);
> >>> +     mutex_unlock(&dev->mode_config.mutex);
> >>> +
> >>> +     return res;
> >>> +}
> >>> +DEFINE_SHOW_ATTRIBUTE(amdgpu_current_pixelencoding);
> >>>
> >>>    /*
> >>>     * Example usage:
> >>> @@ -3688,6 +3733,8 @@ void crtc_debugfs_init(struct drm_crtc *crtc)
> >>>                            crtc, &amdgpu_current_bpc_fops);
> >>>        debugfs_create_file("amdgpu_current_colorspace", 0644, crtc->d=
ebugfs_entry,
> >>>                            crtc, &amdgpu_current_colorspace_fops);
> >>> +     debugfs_create_file("amdgpu_current_pixelencoding", 0644, crtc-=
>debugfs_entry,
> >>> +                         crtc, &amdgpu_current_pixelencoding_fops);
> >>>    }
> >>>
> >>>    /*
> >>
>

