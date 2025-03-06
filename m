Return-Path: <linux-kernel+bounces-549479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FF5A55309
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BBD17446B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6698255E54;
	Thu,  6 Mar 2025 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AV8bi6hJ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFCA1922ED
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282129; cv=none; b=B46FJb9qBfj65At9rxrx/v7sEbiMqf8gxzpp9svwJbrxGaVvamIYkEHv5V+Acanms0XeoZssSu+xxxslDXbjUoVwEwFMYLa8D3bb/8JolsaASXgCgVSd3wPaaafj/Cr9s/oWCiZabkVta13MRur6mgpOZk1AhDOBp1oFe2v1cyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282129; c=relaxed/simple;
	bh=xygdfeupJfVyjFwN4N8xNlmYR1NMqdgcSYKpGrzY8l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cb6os2qqRPQP1bYkk9I87ByIK+m+MA15Gt1T6VQya/mdRdun7Ccn4Qs4Y/JrwZQI04dPCkI/Nr0hiKxFBHTuSVu7VvZBP3UNqr7eTossi+z6Uaas6lHtpEjDFkjhUGURy4tfJY87IfCKwdFVjSFoSCiMHTiIvVo03jrhzdraS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AV8bi6hJ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54954fa61c8so1074346e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741282122; x=1741886922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcYLtQtFcJVERSEpil+pumE+zKeboAooomdKuemFYqs=;
        b=AV8bi6hJLjuVlyydDzB/rHasKuVnM7fQrX4d67yFMmsrReEp62Y/V82R7L+6r8Htrd
         SYchCHJu11tLQ+SaKakUWZPXWSEstN4gPNY1nvsR9IVsNeGVqiU2M7erY0NqHrsr3/EO
         KwgrVzWBYYcrgjr7l8xrGm1X3mnK5fgHAUj2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741282122; x=1741886922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcYLtQtFcJVERSEpil+pumE+zKeboAooomdKuemFYqs=;
        b=OIEIRsBapDv7Zt5zLTvfXBRkwm3EBXN8knT1cv6yPWvm9/I0B8YFkzdtr4EWI00NLr
         N0+1VxuBdHr3FPXjK3NH1DB8pZDIr8TYw0WHWkJ+hjTA0Jj53GXLJhplbUHliYjzU7xr
         vOBJND4JfnVEDGnYg/QH/LK6MJsn6G15wi856QWrRFWsm9mQwjIkwd+ARx5oVLU3F+7h
         ZYHmrfo8RrII5OPNueTSLdQaT1g4oyPlOQQ489BeloQ5vg5klr1yhdb9Gi2DrzhRnmCu
         837WDtgtjW+nbBf20RU+An/rdxL7CL8twYLgJkr17DHwHxTuHFae2L6BxBF9YR25nv4h
         LURg==
X-Forwarded-Encrypted: i=1; AJvYcCUahzyFDycLcGW5FsQs+5BDY4Ip52d6xF3pNoZjn1leM31KuOOZVool3G46ltVJpn9HK5QNBemC/CsVrMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Aia1I6y8YZA53mBQJo9BTGh5z3LRgrbKtR1EjJr93AUbtRFE
	/fPLLMdI3ykHW25vnENIxd4lUAh3vYMCyfVHYUbaAwGMG3YMf5b7glLBSJu+9+irYs6igIo18Y5
	EpQ==
X-Gm-Gg: ASbGncsySQ+j/YIiFXwrW4xX7GZzAV4Vvg3HoGY7ly3tWfb/ZGeW0fblmwykE5WVtJz
	v/kghyD5wBSV5kLTXcPfUEgS64A2FNspd2W4RmP36qDZy2sXQzrz+LhEs8SA31bmG9c4FX0hrN3
	IucEDfb4deS1pDcG6B+GipUDtScIJSbFzw9tVn3QeYFWWbc36b+V0bzGpzx8HCUSh13MAv2QuxP
	vfzfnRafy4VD8XgF8jWLNpejDWYcfR7YSCXwbofmRLCmfsQMgi3FKtpyQ8PYgx4tXtBssv/md8Z
	Jcc8V9L/2ZjRzV2jASZdWDTJhVBqvAgYMr0c0mJFZgpUsOpYz58yupjdbnUzYBdxG/Q34yXxPz2
	8kSD1VoukyvnG
X-Google-Smtp-Source: AGHT+IGa4qId4sA03M2ASNwjFNq47iSt3KDAUDpoI6O66PwiuwEOxG9H9pwMpR1+iBqBvt4blQZATQ==
X-Received: by 2002:a05:6512:138e:b0:545:3032:91fd with SMTP id 2adb3069b0e04-5497d335f77mr3144396e87.16.1741282122090;
        Thu, 06 Mar 2025 09:28:42 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c3532sm233361e87.232.2025.03.06.09.28.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 09:28:41 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30762598511so10726211fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:28:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWgq5UwwZxKQ52DqetGsR6LMqFrp3lF2xmjlejzVxRSPHPXJ5PFTKVlE1i2CH37Pv9fse2JmBU2rrd+y2U=@vger.kernel.org
X-Received: by 2002:a2e:a7ca:0:b0:30b:ec4d:e5df with SMTP id
 38308e7fff4ca-30bec4de914mr11851411fa.34.1741282119425; Thu, 06 Mar 2025
 09:28:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306134350.139792-1-tejasvipin76@gmail.com> <ca5b0825-a485-4bec-bd93-b57a8d7ced99@linaro.org>
In-Reply-To: <ca5b0825-a485-4bec-bd93-b57a8d7ced99@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 6 Mar 2025 09:28:27 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VoW-Zm5wY6Y9sr=GqnvfMP4urGw_zW8NJRHpdC4=rHXQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jr1-LLEB7JrjwWuYQdAGvG4JTZtH7uIFum92liwSSosme4aK6w5V5SVM8Q
Message-ID: <CAD=FV=VoW-Zm5wY6Y9sr=GqnvfMP4urGw_zW8NJRHpdC4=rHXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: novatek-nt36523: transition to mipi_dsi
 wrapped functions
To: neil.armstrong@linaro.org
Cc: Tejas Vipin <tejasvipin76@gmail.com>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	lujianhua000@gmail.com, quic_jesszhan@quicinc.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Anusha Srivatsa <asrivats@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 6, 2025 at 6:05=E2=80=AFAM <neil.armstrong@linaro.org> wrote:
>
> On 06/03/2025 14:43, Tejas Vipin wrote:
> > Changes the novatek-nt36523 panel to use multi style functions for
> > improved error handling.
> >
> > Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> > ---
> >   drivers/gpu/drm/panel/panel-novatek-nt36523.c | 1683 ++++++++--------=
-
> >   1 file changed, 823 insertions(+), 860 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gp=
u/drm/panel/panel-novatek-nt36523.c
> > index 04f1d2676c78..922a225f6258 100644
> > --- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> > +++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> > @@ -23,10 +23,12 @@
> >
> >   #define DSI_NUM_MIN 1
> >
> > -#define mipi_dsi_dual_dcs_write_seq(dsi0, dsi1, cmd, seq...)        \
> > -             do {                                                 \
> > -                     mipi_dsi_dcs_write_seq(dsi0, cmd, seq);      \
> > -                     mipi_dsi_dcs_write_seq(dsi1, cmd, seq);      \
> > +#define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx0, dsi_ctx1, cmd, seq=
...)      \
> > +             do {                                                     =
       \
> > +                     mipi_dsi_dcs_write_seq_multi(&dsi_ctx0, cmd, seq)=
;      \
> > +                     dsi_ctx1.accum_err =3D dsi_ctx0.accum_err;       =
         \
> > +                     mipi_dsi_dcs_write_seq_multi(&dsi_ctx1, cmd, seq)=
;      \
> > +                     dsi_ctx0.accum_err =3D dsi_ctx1.accum_err;       =
         \
>
> Just thinking out loud, but can't we do :
>
> struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D NULL };
>
> #define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx, dsi0, dsi1, cmd, seq..=
.)      \
>                 do {
>                         dsi_ctx.dsi =3D dsi0;                            =
         \
>                         mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, seq);=
       \
>                         dsi_ctx.dsi =3D dsi1;                            =
         \
>                         mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, seq);=
       \
>
> ?
>
> So we have a single accum_err.

Even though the code you used was what I suggested in IRC, I like
Neil's suggestion better here. What do you think?

Other than that, it looks good to me.

-Doug

