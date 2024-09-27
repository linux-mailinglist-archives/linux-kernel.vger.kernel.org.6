Return-Path: <linux-kernel+bounces-341457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93188988067
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585C8284CED
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2E9189919;
	Fri, 27 Sep 2024 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/kX46gX"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FF1188A13
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426194; cv=none; b=VVye6LzlP6X5EIGKjCBLBvtsBvgvNgCFHOIy55x42Nn8a7chBC8XvHNKs01PoLIVLqDpfZHgQ6E4zThpM9xEDOFQl0a1+/u027ZHsMJKTI4XEkBm6pLIhPRXs4jyeoNpxCxU5If9MKVPGPFW2pyImgB+Q1yVAfvimMP62Z7mCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426194; c=relaxed/simple;
	bh=BB95N8jhxDBIHPioKDDyl+2GZg9SBxN/8k7C+1yp4Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPwcC78ZZut8SDp5Hb3d9xwNZBXM/b7DdwYs5Cc8pb0BiqE+c5MuAt7iZlISBAbrsu68Nw6MSV4lCtZeT9P8bMMTVb48pVVAPdXpzj9fuH9/Xmc8nF1nzqjY+zdG29KuHijw9oKynGBryCEbdX9m+d+DNyoykrAp4NHJIf5CbB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A/kX46gX; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6dde476d3dfso16015117b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 01:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727426192; x=1728030992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NW990c4pKIgSUwRw9627ylvvkk5w5XELih7UcFss2WY=;
        b=A/kX46gXSS33NQ0+o39Jfu7qNP8i/XbsY6T1o+uhThWPDJgailtEugCADTCUHV/cMJ
         iDJgjjxnw9Hqka4ah3xYvfbqM/t7BXguqTXcGS2gLHTFyI2Sk3Ul07gx+Fj6Ie0964dS
         smuA59IN8jeoJ9U5ACXhTBr0kInXfn1pzZk9EgVOMJPFDUrPuT0gcHuDSjq8teIc2W59
         eBmrLJzvggQrw/xMvV1SQl6z89miZX5oEEz+CrjLK5haub3kHnGecIvVKiFrJ+IgL5Cs
         NbCQOFikYskwSc/sDti2saymlL8QhwspAGCVWDpZ3uRJ8DiVO9MORb49t8sL1l89zdEH
         xWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727426192; x=1728030992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NW990c4pKIgSUwRw9627ylvvkk5w5XELih7UcFss2WY=;
        b=gEbo7+CaX7cuQ1W1e04GQOIGJE4130rlfnWGmifpfZ5SPB/ks123WOqWN+X85nLpQs
         HxCGxXb3+H67Eo/SeTKDgEB5o/L66sLSeAdX0Q9nOiAA8lVo0bBV9Px1TK3S2tM5PEau
         IgMi8480DV/MukswWzskqKjavC4u84xmG2nxQk6y7LEv0YtokVWWiSttkxv9qZzN7HuP
         MpSOmNug7t4nBKs+RH+IUW/ntcXfYbcq2+QDmlikzoTGG4G2MZWmpLrYr/25HeMJO43D
         /It854IAQM+6mEKAVcO12jVXzronuhA3Ew6Ah/6YIeU9FE1T2uSknjEGoh+FLCbb8++D
         nwsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMsYOqXMD/bkypUP9gH6Pclm9YzHkcC3c/RXA9w6xvj4Onlgv/1HmykV1FinFst+M28qnKpUyeMyq6XUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCwDvosM6XvuLBXsAugm/3hFkhdsIgnox9wK6J8/RJqAXwF7ny
	Ci8t4rK2KN+DrU25YUav/4kl3+CiiLbvkpIaaHj+wURYnd7Ry1rgFRhhXTePvsftQ1ds6nnCxWZ
	ZifsjQGRo6UbCYpmgtkZ0tgwe05GpOyC3igv9Cw==
X-Google-Smtp-Source: AGHT+IGl+8O6l/tpJLDnrP1hqZHzdAe8d1uuNodgKIZ1SsfYNlsEQYeZwwdlmgUzciDUtd6QzdNTFBGG8PuX6Au55nM=
X-Received: by 2002:a05:690c:112:b0:6e2:985:f4df with SMTP id
 00721157ae682-6e24dc9c710mr7236477b3.44.1727426192209; Fri, 27 Sep 2024
 01:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926075134.22394-1-Hermes.Wu@ite.com.tw> <20240926075134.22394-2-Hermes.Wu@ite.com.tw>
 <loulf3p74x3p6dinublo6xenwjoyssm2f5rk5g3env54abhath@37i4vlvxjn3f> <4360d5a8c4e54540831eca77ca9156f5@ite.com.tw>
In-Reply-To: <4360d5a8c4e54540831eca77ca9156f5@ite.com.tw>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 27 Sep 2024 10:36:23 +0200
Message-ID: <CAA8EJpq0Q-TRh6MW70sHkWGo3Sz1j1Ep15LFjXCnXK0pdHfhKg@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] drm/bridge: it6505: Add aux i2c functionality
To: Hermes.Wu@ite.com.tw
Cc: Kenneth.Hung@ite.com.tw, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, angelogioacchino.delregno@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Sept 2024 at 04:43, <Hermes.Wu@ite.com.tw> wrote:
>
>
> >-----Original Message-----
> >From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >Sent: Thursday, September 26, 2024 8:58 PM
> >To: Hermes Wu (=E5=90=B3=E4=BD=B3=E5=AE=8F) <Hermes.Wu@ite.com.tw>
> >Cc: Kenneth Hung (=E6=B4=AA=E5=AE=B6=E5=80=AB) <Kenneth.Hung@ite.com.tw>=
; Andrzej Hajda <andrzej.hajda@intel.com>; Neil Armstrong <neil.armstrong@l=
inaro.org>; Robert Foss <rfoss@kernel.org>; Laurent Pinchart <Laurent.pinch=
art@ideasonboard.com>; Jonas Karlman <jonas@kwiboo.se>; Jernej Skrabec <jer=
nej.skrabec@gmail.com>; Maarten Lankhorst <maarten.lankhorst@linux.intel.co=
m>; Maxime Ripard <mripard@kernel.org>; Thomas Zimmermann <tzimmermann@suse=
.de>; David Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>; An=
geloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>; Allen C=
hen <allen.chen@ite.com.tw>; open list:DRM DRIVERS <dri-devel@lists.freedes=
ktop.org>; open list <linux-kernel@vger.kernel.org>
> >Subject: Re: [PATCH v4 11/11] drm/bridge: it6505: Add aux i2c functional=
ity
> >
> >On Thu, Sep 26, 2024 at 03:51:34PM GMT, Hermes Wu wrote:
> >> From: Hermes Wu <Hermes.wu@ite.com.tw>
> >>
> >> Add aux-i2c operaction in order to support the MCCS function.
> >
> >Brevity is the soul of wit. However in the commit message we appreciate =
more details. Is it enough to get monitor control to work? Or is there anyt=
hing left to be implemented?
>
> In drm_dp_helper, drm_dp_i2c_xfer() pack I2C request into sequence of AUX=
 request.
> it6505_aux_i2c_operation() is implement to match drm_dp_i2c_xfer() behavi=
or

Commit message, please.

>
> >>
> >>
> >> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> >
> >This is definitely not a fix.
>
> will remove.
>
> >> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> >> ---
> >>  drivers/gpu/drm/bridge/ite-it6505.c | 177
> >> +++++++++++++++++++++++++++-
> >>  1 file changed, 175 insertions(+), 2 deletions(-)
> >
> >--
> >With best wishes
> >Dmitry
> >
> BR,
> Hermes



--=20
With best wishes
Dmitry

