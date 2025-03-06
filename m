Return-Path: <linux-kernel+bounces-549790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E85FCA55749
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AD9174930
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF4E2702BD;
	Thu,  6 Mar 2025 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HJ61RuyK"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248E42A8C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741291627; cv=none; b=TLRmqrcAOxteOwLcwTxljFx2iHAM3NblhZNMxqaJeJh8xMWwy7/I9qBrYtpot/cfroaTL/6RtV/4RosodJY7ji/IIh5BXUFkuLKGiUOy/ZfxTtUcm/0/AEZxSpcpE+efxlDTKVRKDOZLBRm+R6b+u/J7RgmOgqju40doD0+KaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741291627; c=relaxed/simple;
	bh=6Ht9y0FtS3pAPN6DrTM4ZFPOZKebMKX1OsxrHCXdk6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUuBtdUxHnriLHiJqr9TQZZ5asg2KfVyLmoKgpk+qzIeVI3kLt/jgTqTy0Ytjm1BsIV0N/gbCwqXjz6hv3jvsIltogXolV8GBqNjRHgJyY6MVOpQW+TIoAMF4EhXAgSo0u5CQh8+4DGGy3OjatWWo+uGuqzXiq9aqVdl6R5UUf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HJ61RuyK; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bae572157so10194641fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 12:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741291620; x=1741896420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFBVTxBK91gOv/J1RwnobV6isevkXmYhVXuftt1K/I8=;
        b=HJ61RuyKsllDStNNbWdzXsz//fAtqXQKOsgp1NriTptGQ0TulDbWWPWOaO6SIMTvRA
         73ejOsywCCjIl2JzMtyBoR4pGqVFtRMG74GvcYiNYZM6EVVEjNHI2XGhseUwjUPzRi/P
         jSZv3PuDdf+YJ/RHuSZJ0jcqOPBJN0GbbNBWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741291620; x=1741896420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFBVTxBK91gOv/J1RwnobV6isevkXmYhVXuftt1K/I8=;
        b=AGuvFnO62UC8e/TKYmEm6qyHWJWsm8Bof3irYThjJkDTUftwwMlHmOfEmlKVSx3sky
         j3MnLjQjVA+VPUxM3NrTqb3CurwVg78RIkNrLsjsak0n788rjNkrhrIEmIbaCMkrFrym
         ScYB9dGaVveANAm/+XDgZpYmTjBl3yFZRV9ERBU2hFaexdU7icy1WeJR2LAulKpQpqhy
         JWA1wcrpTfmui583t8T60Yqgb5j3hjSvk2R2s2SkODQ6Zfec3X3UwcEEwljCpwmaNw/w
         4/cCgOP4A8hygLeL0Z/Z+QZ3p/xfYujAXe1uZ87vxpHGOiaf8EWBEv+ZdBfdFA+5mI7L
         YKjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHrArWw4vv4jnCgluxUyBSTIHHhy30HShGOjHLgB+Gg+d53hILUReYEzhr6tn47vpenTi8uWY4gXODmgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz12HCZXeXaaaQF33V7MtwWjz9y9fpsll01iuqZyQTNMw6BIUO+
	oFh5gqzI0SqOf/4TpMJ9cJQqA0CoT3jNL0jWmzQboss/q378enXNCG7MPkl5CDwYaeOX9+e/4GL
	9MCeG
X-Gm-Gg: ASbGncuVbmrTmDkIzOrPDQ9YSbBp3CBLLHkFTPkYUQgP7KKTGEN2eT17rO3dYyKh4Qu
	32O5Wan2CHQkTvZichL0FR5L0f/vVKnX9THBw5NtpaLvLa+5VPc5KlPkTkI28yKGUtsZSfL4Vq4
	ra76pdFLfNjp/5UwqiTSongUG1ZomvmdE1XUEysjUz0NCP/qzauPwJy77ARuLeQuAIZsCoyrR7s
	zOzSRXe8l+fmSlVjXf1X6ZmWoo/lvGL1vqbyuY0dx0TvvveaO1vS9FwZZaSlxx04kiEt6tFRcBr
	E4GoSdCaq0pGEJIQwuVncriJ1RjBLU0aPjShLlaoNlimpDsZdrN3PNkqlzyUeyXsfsryoTscC6w
	CQOAgkpK+q8BH
X-Google-Smtp-Source: AGHT+IG1PXOi0Tl9HgoTpy2urpvWdIjI2d+hhZUmTqa5KfCQ6X5Xlo8N9d/dKM9ajNV5uStF+BEy7w==
X-Received: by 2002:a05:651c:4ca:b0:30b:ca48:10be with SMTP id 38308e7fff4ca-30bf43b5219mr1909571fa.0.1741291620090;
        Thu, 06 Mar 2025 12:07:00 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be99179fdsm3023981fa.51.2025.03.06.12.06.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 12:06:59 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bf2513a2dso4497781fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 12:06:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXuM80u25q2klBg+al1wzxzZe9Egh/RNbQ/zZ0OdFlsotKJCV6ATbsLDKnHJCc5xGFIF/7w9jznjZVuQ7o=@vger.kernel.org
X-Received: by 2002:a05:6512:2309:b0:549:7d6e:fe84 with SMTP id
 2adb3069b0e04-549910b7650mr139656e87.53.1741291617911; Thu, 06 Mar 2025
 12:06:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306134350.139792-1-tejasvipin76@gmail.com>
 <ca5b0825-a485-4bec-bd93-b57a8d7ced99@linaro.org> <p2esqngynwfrshz5rqfnmx6qgwf4dclpkb3mphwg2vavx2jbcg@clqoy5tjh7bb>
 <CAD=FV=XyOwoMmdvFA565AzGRUSNwonQ-5Ke2H6jc2ki9Sz+0Pg@mail.gmail.com> <CAA8EJpoG-rfaVb0rhbP-6xwzD7=k-95NVeyHUy=X3ESLEwZgYw@mail.gmail.com>
In-Reply-To: <CAA8EJpoG-rfaVb0rhbP-6xwzD7=k-95NVeyHUy=X3ESLEwZgYw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 6 Mar 2025 12:06:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WvKjTFOubSyDcdn1TKoBL9jeExkKSLydfxpKhqjVPLuA@mail.gmail.com>
X-Gm-Features: AQ5f1Jos7fHq7Zgo3vzyzU6fKV4__HXNnXnaQS-cI3RFMrxWkmNF6UCCasL5LYQ
Message-ID: <CAD=FV=WvKjTFOubSyDcdn1TKoBL9jeExkKSLydfxpKhqjVPLuA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: novatek-nt36523: transition to mipi_dsi
 wrapped functions
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: neil.armstrong@linaro.org, Tejas Vipin <tejasvipin76@gmail.com>, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, lujianhua000@gmail.com, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Anusha Srivatsa <asrivats@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 6, 2025 at 11:03=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 6 Mar 2025 at 18:44, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, Mar 6, 2025 at 8:33=E2=80=AFAM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Thu, Mar 06, 2025 at 03:05:10PM +0100, neil.armstrong@linaro.org w=
rote:
> > > > On 06/03/2025 14:43, Tejas Vipin wrote:
> > > > > Changes the novatek-nt36523 panel to use multi style functions fo=
r
> > > > > improved error handling.
> > > > >
> > > > > Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> > > > > ---
> > > > >   drivers/gpu/drm/panel/panel-novatek-nt36523.c | 1683 ++++++++--=
-------
> > > > >   1 file changed, 823 insertions(+), 860 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/driv=
ers/gpu/drm/panel/panel-novatek-nt36523.c
> > > > > index 04f1d2676c78..922a225f6258 100644
> > > > > --- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> > > > > +++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> > > > > @@ -23,10 +23,12 @@
> > > > >   #define DSI_NUM_MIN 1
> > > > > -#define mipi_dsi_dual_dcs_write_seq(dsi0, dsi1, cmd, seq...)    =
    \
> > > > > -           do {                                                 =
\
> > > > > -                   mipi_dsi_dcs_write_seq(dsi0, cmd, seq);      =
\
> > > > > -                   mipi_dsi_dcs_write_seq(dsi1, cmd, seq);      =
\
> > > > > +#define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx0, dsi_ctx1, cm=
d, seq...)      \
> > > > > +           do {                                                 =
           \
> > > > > +                   mipi_dsi_dcs_write_seq_multi(&dsi_ctx0, cmd, =
seq);      \
> > > > > +                   dsi_ctx1.accum_err =3D dsi_ctx0.accum_err;   =
             \
> > > > > +                   mipi_dsi_dcs_write_seq_multi(&dsi_ctx1, cmd, =
seq);      \
> > > > > +                   dsi_ctx0.accum_err =3D dsi_ctx1.accum_err;   =
             \
> > > >
> > > > Just thinking out loud, but can't we do :
> > > >
> > > > struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D NULL };
> > > >
> > > > #define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx, dsi0, dsi1, cmd,=
 seq...)      \
> > > >               do {
> > > >                       dsi_ctx.dsi =3D dsi0;                        =
             \
> > > >                       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, s=
eq);       \
> > > >                       dsi_ctx.dsi =3D dsi1;                        =
             \
> > > >                       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, s=
eq);       \
> > > >
> > > > ?
> > > >
> > > > So we have a single accum_err.
> > >
> > > I'd say that can be counter-prodactive. If only one of the links fall=
s
> > > apart, then the second link still can be initialized (and by observin=
g a
> > > half of the screen the user / devloper can make several assumptions).
> > > In case of using just one context the driver will fail on the first
> > > error and skip the rest of the init for both halves.
> > >
> > > I'd have a different suggestion though: what about passing two contex=
ts
> > > to the init_sequence callback and letting nt36523_prepare() handle ea=
ch
> > > of the error separately?
> >
> > IMO that's a bit outside the scope of what Tejas is doing since it's a
> > functional change. Unless something is a super obvious bugfix it feels
> > like doing the conversions like we're doing here should not include
> > functionality changes and should be straight conversions.
> >
> > Also: I don't have tons of experience with dual MIPI panels, but I'm
> > not totally sure how your suggestion would work in the end. Would you
> > expect that if one panel succeeded and the other didn't that the
> > prepare/enable calls in the panel should return "success"?
>
> Well, panel bridge ignores return codes.
>
> >  If they
> > don't then higher levels will assume that the single "panel" that
> > they're aware of didn't initialize at all and won't continue to do
> > more. That means the user wouldn't have a chance to observe half the
> > screen working.
> >
> > I could believe that, for all practical purposes, we could keep the
> > errors separate and then just return the if either panel got an error
> > in the end. It probably wouldn't make a huge difference and would
> > shrink the code side. ...but that I think that should probably be the
> > second patch in the series and not squahsed into the conversion.
>
> I think passing two contexts can be considered a part of the
> conversion. In the end, we have been changing some of the function
> arguments already to pass context instead of global data.
> In the end, currently there was no way for either of those double-DSI
> panels to fail the init seq.

OK, fair enough. No objections from me for going this way, then.
Please make sure that the functionality change is mentioned in the
commit message, though.

-Doug

