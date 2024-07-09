Return-Path: <linux-kernel+bounces-246671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112FA92C508
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424341C218B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C763182A45;
	Tue,  9 Jul 2024 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lEjqlnqc"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACFA1B86DD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720558564; cv=none; b=WtGzhhUxzFuoELDF/sTRXwXoe2HubFUsq1J5900m63PJi+ndsIosc1clHMhLC2GN6x9sfhklZoa0dt3xySgL+JSxTDVntevRUBC598vCNC3l81SVKgyApdfpVw6n+3G1Hp/HSWQeApZ8BQpVoRWT92m2kDm1gLFd6PkI1XnivG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720558564; c=relaxed/simple;
	bh=yQ07NWu3L9gs1HGAsznqrvuxn2QYU1ZDcFMikrA7yco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwYUBtuxeFaA47RoJSnbUInvHNJg1c9Mi6xmy2Vj5oBYUdPWXJiVYlOydEi9TOEOTY6uvAGskJpVh1v5I+yqaBfRRPAoNY2zJYbnJ88TkdFZjWmp4b1aW+cKmX0ww10aCDTLakfgaS0D+qt7kbAQ6MlrC9AYdA7oj1x9Jxur1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lEjqlnqc; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d932f991f6so1515230b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720558559; x=1721163359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVh6W36UPU19XxDEtUe4/W7t7i/b/SampjURjZZcQD8=;
        b=lEjqlnqcGSoVYfrLtH7RrfftTUadkRnuk9RYxiLCY4Xd2Ha/8uraFLlh3afTP/7OUt
         Vb4p13fQvqeZaDuAmegTH57yL8TZGCW3RhpQFqcRKTP4DkrK8WBQ4noNTwNV967i5Pj+
         kCXDEjltv3LvcOHClLmd2pkRz7TF+EIVuHd1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720558559; x=1721163359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVh6W36UPU19XxDEtUe4/W7t7i/b/SampjURjZZcQD8=;
        b=wokETTusFi+y3xN/SOh52iXGniRRBhIIkA00YUxtPWJ+zS2/3b01kQDS+Wr/XhT6k/
         0rUqjVQK5qIavQhuGO40FzN2KKQIdtLyVNX4dphHBFtw2X7qa9v+zp68d1TS+yVlHKOA
         cbz50oXYDrP+Vt8ZGDyRZ7wZ1PPlqEAuGJo1iua2Qt5R8n5zHT+7levYGGO6gj0PBUzK
         FW16CxlWiYrjn3jbJMW+EfmQlDp19cMCmIhPURI3Skno0pYxElGIMUz8qec3qjdoVvJa
         eaIvf8dChe1vkxgyI+JwJDrDh66G1TGr5m0Jez/ZKS/S7zyiwSMlVBWjHK8hWP5nl8pZ
         kexQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVaVZoEjCw8GBHCalkerfLwLRgEaY9I/YBwQbKdnQjWLeLu6+iWz3OPyvvjM1w8x1GvxaEq31eeusauzo9lO9B+M2MBKYXy/cSj2sQ
X-Gm-Message-State: AOJu0YyBIQ1y7qQuNmouksEqD/WpPmT0W84ybsIO2J6DLqb5jnpoIo3B
	3eZZ4SoESkL4HN0iObZsN1yoiZjG22CG0PgF/+RHv9VeRwsmjUKsTxWu8iZVO2Naa0ulelpLkYQ
	7VoVl
X-Google-Smtp-Source: AGHT+IEZSGr0cgXK373fjGEoUpQKkvHdKIdAqcFL8lmQb+V5w0Tl6lPaJ3VfEu+skCw5eEaBnnIMAw==
X-Received: by 2002:a05:6808:1451:b0:3d9:1f4b:558a with SMTP id 5614622812f47-3d93c00f3c1mr4971579b6e.19.1720558558080;
        Tue, 09 Jul 2024 13:55:58 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b2f93sm132072285a.125.2024.07.09.13.55.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 13:55:56 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44664ad946eso20941cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:55:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWbnjTo28g4LMKhVZ96Gk5PmGSv/Wzsmyozhm4ozgqxQnxB9FjLLEjQ341XLvdAVnu9b4PFgDIZn9zJmEWsgdT+oXpP7GLpUJxCoPOK
X-Received: by 2002:a05:622a:7604:b0:447:f5de:bd18 with SMTP id
 d75a77b69052e-44b191f6ac5mr194891cf.9.1720558556064; Tue, 09 Jul 2024
 13:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628182428.171031-1-tejasvipin76@gmail.com>
 <20240628182428.171031-2-tejasvipin76@gmail.com> <CAD=FV=VKiEjDfeK8pCqAk8+YWBD2U4ESLik8kiDbvgrZz7o1NA@mail.gmail.com>
 <36aa6067-fa6b-4957-ae33-58a28e32c8fd@gmail.com>
In-Reply-To: <36aa6067-fa6b-4957-ae33-58a28e32c8fd@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 9 Jul 2024 13:55:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U6WdxD4g-4rA2Kz0nbs3fZUA+NRzivg_tJMup0652MxQ@mail.gmail.com>
Message-ID: <CAD=FV=U6WdxD4g-4rA2Kz0nbs3fZUA+NRzivg_tJMup0652MxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/mipi-dsi: add more multi functions for better
 error handling
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, LinusW <linus.walleij@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 9, 2024 at 4:18=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com>=
 wrote:
>
> On 7/9/24 5:50 AM, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Jun 28, 2024 at 11:25=E2=80=AFAM Tejas Vipin <tejasvipin76@gmai=
l.com> wrote:
> >>
> >> +/**
> >> + * mipi_dsi_dcs_set_page_address_multi() - define the column extent o=
f the
> >> + *     frame memory accessed by the host processor
> >> + * @ctx: Context for multiple DSI transactions
> >> + * @start: first column of frame memory
> >> + * @end: last column of frame memory
> >
> > nit: "start" and "end" comments should say "first page" and "last
> > page", not "first column" and "last column". The previous function was
> > the one about columns.
> >
> >> + *
> >> + * Like mipi_dsi_dcs_set_page_address() but deals with errors in a wa=
y that
> >> + * makes it convenient to make several calls in a row.
> >> + */
> >> +void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_contex=
t *ctx,
> >> +                                          u16 start, u16 end)
> >
> > nit: indentation of the above line isn't _quite_ right.
> >
> >
> > Other than the two nits, this looks fine to me, but I'd prefer if
> > someone else provides an "Ack" in addition to me that they're OK
> > adding these extra "multi" functions. Both Dmitry and Linus W were
> > involved in the original "multi" functions, so maybe they'd be willing
> > to offer their opinions?
>
> I think a better way to go forward with multi style functions is to
> use macros. All the multi style functions are basically exactly the
> same with the only difference being the function called internally
> and the dev_err. This can be represented in the form of a macro, and
> would save on a ton of otherwise redundant code, while also allowing
> us to "convert" any function to multi style as and when we please.
>
> We would ideally have 2 macros, one for the main functions where we
> desire to modify accum_err on an error arising, and another macro that
> just checks accum_err to see if the function should be a no op.
>
> If you guys think this is a good idea, I'll work on the macros and
> do the multi conversions in this new way.

I had a similar thought but I wasn't sure how easy it would be. If you
want to prototype it out and send out patches if they look good then
that'd be nice. We'd want to make sure that we actually generate
functions for the "multi" variants since we don't want all that inline
code on every caller, but generating those functions with a macro does
seem like it would work. I guess you'd also need to include some sort
of string for use in the error messages.

-Doug

