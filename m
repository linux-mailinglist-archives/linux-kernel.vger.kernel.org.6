Return-Path: <linux-kernel+bounces-549701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3AEA55625
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDAD188D962
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0437926D5A7;
	Thu,  6 Mar 2025 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbNJzt+3"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC3A25CC85
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287817; cv=none; b=NVCKtR3IHqBqgntrGZWYjddXDHLU4kmGVVhoDYvhmnymSJJ0hK61ILAU7+W0qYVTeQ0R7PbymLXcWyCd01A/kapShaB/Vwn8pO0kuo6GLPdPSOy2mRLw3WRjCxZ8SUPeF4AWq6d5e6b0cg3uTwRXA4sZfJvt1i85zt3dIIHR1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287817; c=relaxed/simple;
	bh=zMUicXi2759QqcPw23mYCS2LNYpEZYHlUT5R6CUJYhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElTAOkb8quDT2iPqyilgxiZEc7WpR5x8v7OO5iLJOI2YvAi+X3GWSN8QKyssH4fFfqyhWVUZNfhwBNrZI4pp9O4Q3TMSussHssgQgZ0rCO6/k+vopLy8oKQQ2ixEZAAG1qLL5+cExwbOv/V8O+g8/UP7LsCapeOBrdDaHYcjWik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PbNJzt+3; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so832445276.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 11:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741287814; x=1741892614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwCDdrKQOyctXlG8s2t32dxkWsTqqYWpj8SXJw5MqC4=;
        b=PbNJzt+324nit0//OnPDhpjx1JZte8kaJqLRwh+79+lBO2C1BC9K/mlVB6VzkojSeA
         e33ltXrClI8Z4Cf+e31iJgO9VMNMfjd3jpjMdx7jD+rqLAuc1yexLV4CA07gwgp8QeeG
         33fnKCOQEOBB57UgFwp+pcISaf6EAOBHfYimQu0TgEdxL6W3GcuyACNrj309q2Gpg7+C
         1Rn+2xvzoO4rcBapFU6kYRQc3IgCIWls9ulEFUKklg3dotzQzBqK5vSmDFpO5Y0GZvU6
         OxAQoMuUThYG/zRlbW1xLT98lpckLJAk0tOcNnEI/SL/nyMFhMCAfyq8ci3VTTnTPV04
         xJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741287814; x=1741892614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwCDdrKQOyctXlG8s2t32dxkWsTqqYWpj8SXJw5MqC4=;
        b=tWry0tE3ZFsEAR934KmbCzbqbEpSJO5JwKr7IP78ChuUHJZ4N7zGhSSHoeWiQSLPZ3
         ZrT44OT8bWXbQ63T2Dd5geclqZKydAvOqj7E+UplVZNCv/8HaggCmR5la8BwVYeVUS/5
         lFS0AH37+wr+vzT14EO644m6dCXXbjy2AgToX/A4mgGWF8k0bCMhFOfg8V5vyyprJMx0
         lrpxmKhs0oZp5KKkR0rzXEV0ve5hTMqDDYsnuQnfyH3HscXb3/SuqQmCQO9JlHlY7ZBZ
         YLneDCZALI33s82Mmog54m/5+GL0IDdIoo5YxzH5sIjm7cwJcz1z9LWbVfG96xc7KwXu
         ToaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLiORkF/kHE01W8GJq0C4XaFER3GUrZmJcCvZpPbhKqLF4lf8sQSU81dKVokEuFCDzpaWJHs2FVw9/EgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8+XudMgZv3Z5OV/f/IGlYUOBDDYi9YHmS+4tZkE/uHcPN9xcg
	El69INFx9bsxH+LidHPsWS1KMvDUr9/yoI3E9rl+v3JR8S+k/wFFsL05Sq2cGUueq9+j6sHEUsl
	tu09N7xkytaIvPkhpsFPEpHwiFJ8PwWwpxWYccg==
X-Gm-Gg: ASbGnctCSlDbDGvUz5358mEG6mMPCIhSSP62yO/3rY6IvmGat3R1i1lmIgdizFjDkyk
	A8z26gGqcmdw0aUjwQAhcBP1hjBv7Mjycp3czxFd79dazizKgPDDMAbQWbLwZzrMJG7zOj5uSZM
	2k1dOrIgdayGQBiWFV3UfhQWStN7l+dyQl5Uiv+TWxmDb6wYdAK4KMkr7E
X-Google-Smtp-Source: AGHT+IHwvj0CxkMdhq6vZm8WoZOOXbWTiQ8NAVWXBvLwqYH0y2h7UDiE+hITztg+nqSsiSEQ4EgrLVUkS+uTYKmx4H4=
X-Received: by 2002:a05:6902:1b8f:b0:e5d:bf57:7dc7 with SMTP id
 3f1490d57ef6-e635c16eec8mr606132276.21.1741287814199; Thu, 06 Mar 2025
 11:03:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306134350.139792-1-tejasvipin76@gmail.com>
 <ca5b0825-a485-4bec-bd93-b57a8d7ced99@linaro.org> <p2esqngynwfrshz5rqfnmx6qgwf4dclpkb3mphwg2vavx2jbcg@clqoy5tjh7bb>
 <CAD=FV=XyOwoMmdvFA565AzGRUSNwonQ-5Ke2H6jc2ki9Sz+0Pg@mail.gmail.com>
In-Reply-To: <CAD=FV=XyOwoMmdvFA565AzGRUSNwonQ-5Ke2H6jc2ki9Sz+0Pg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 6 Mar 2025 20:03:23 +0100
X-Gm-Features: AQ5f1Jq5XTpi2paX4JarjRQ14efVOLE111e7OJDJdnK2KOGvG8rnVmL6vgNVl5c
Message-ID: <CAA8EJpoG-rfaVb0rhbP-6xwzD7=k-95NVeyHUy=X3ESLEwZgYw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: novatek-nt36523: transition to mipi_dsi
 wrapped functions
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, Tejas Vipin <tejasvipin76@gmail.com>, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, lujianhua000@gmail.com, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Anusha Srivatsa <asrivats@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Mar 2025 at 18:44, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Mar 6, 2025 at 8:33=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Thu, Mar 06, 2025 at 03:05:10PM +0100, neil.armstrong@linaro.org wro=
te:
> > > On 06/03/2025 14:43, Tejas Vipin wrote:
> > > > Changes the novatek-nt36523 panel to use multi style functions for
> > > > improved error handling.
> > > >
> > > > Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> > > > ---
> > > >   drivers/gpu/drm/panel/panel-novatek-nt36523.c | 1683 ++++++++----=
-----
> > > >   1 file changed, 823 insertions(+), 860 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/driver=
s/gpu/drm/panel/panel-novatek-nt36523.c
> > > > index 04f1d2676c78..922a225f6258 100644
> > > > --- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> > > > +++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> > > > @@ -23,10 +23,12 @@
> > > >   #define DSI_NUM_MIN 1
> > > > -#define mipi_dsi_dual_dcs_write_seq(dsi0, dsi1, cmd, seq...)      =
  \
> > > > -           do {                                                 \
> > > > -                   mipi_dsi_dcs_write_seq(dsi0, cmd, seq);      \
> > > > -                   mipi_dsi_dcs_write_seq(dsi1, cmd, seq);      \
> > > > +#define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx0, dsi_ctx1, cmd,=
 seq...)      \
> > > > +           do {                                                   =
         \
> > > > +                   mipi_dsi_dcs_write_seq_multi(&dsi_ctx0, cmd, se=
q);      \
> > > > +                   dsi_ctx1.accum_err =3D dsi_ctx0.accum_err;     =
           \
> > > > +                   mipi_dsi_dcs_write_seq_multi(&dsi_ctx1, cmd, se=
q);      \
> > > > +                   dsi_ctx0.accum_err =3D dsi_ctx1.accum_err;     =
           \
> > >
> > > Just thinking out loud, but can't we do :
> > >
> > > struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D NULL };
> > >
> > > #define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx, dsi0, dsi1, cmd, s=
eq...)      \
> > >               do {
> > >                       dsi_ctx.dsi =3D dsi0;                          =
           \
> > >                       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, seq=
);       \
> > >                       dsi_ctx.dsi =3D dsi1;                          =
           \
> > >                       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, seq=
);       \
> > >
> > > ?
> > >
> > > So we have a single accum_err.
> >
> > I'd say that can be counter-prodactive. If only one of the links falls
> > apart, then the second link still can be initialized (and by observing =
a
> > half of the screen the user / devloper can make several assumptions).
> > In case of using just one context the driver will fail on the first
> > error and skip the rest of the init for both halves.
> >
> > I'd have a different suggestion though: what about passing two contexts
> > to the init_sequence callback and letting nt36523_prepare() handle each
> > of the error separately?
>
> IMO that's a bit outside the scope of what Tejas is doing since it's a
> functional change. Unless something is a super obvious bugfix it feels
> like doing the conversions like we're doing here should not include
> functionality changes and should be straight conversions.
>
> Also: I don't have tons of experience with dual MIPI panels, but I'm
> not totally sure how your suggestion would work in the end. Would you
> expect that if one panel succeeded and the other didn't that the
> prepare/enable calls in the panel should return "success"?

Well, panel bridge ignores return codes.

>  If they
> don't then higher levels will assume that the single "panel" that
> they're aware of didn't initialize at all and won't continue to do
> more. That means the user wouldn't have a chance to observe half the
> screen working.
>
> I could believe that, for all practical purposes, we could keep the
> errors separate and then just return the if either panel got an error
> in the end. It probably wouldn't make a huge difference and would
> shrink the code side. ...but that I think that should probably be the
> second patch in the series and not squahsed into the conversion.

I think passing two contexts can be considered a part of the
conversion. In the end, we have been changing some of the function
arguments already to pass context instead of global data.
In the end, currently there was no way for either of those double-DSI
panels to fail the init seq.

>
>
> Oh, also: Tejas, please make sure you CC Anusha on your patches. :-) Adde=
d here.



--=20
With best wishes
Dmitry

