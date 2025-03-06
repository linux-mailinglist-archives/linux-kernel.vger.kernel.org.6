Return-Path: <linux-kernel+bounces-549342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BC0A55170
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79E9175EF7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAE122B586;
	Thu,  6 Mar 2025 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PdM0dzHc"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A4C21ABBF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278839; cv=none; b=Kw8/Pi3J53f+IoFlc7N79V7n27RwQwOmqP2V18vmRQN1UmMLkpclpm/VijFOpADBxGnM2Ls6az74Yg4n+bBgNeI3ghdUVgXMzAr+rZP2jp6M9wYR4/8vCinSpEJly6w+P6HXGF50p8lESvUiK9RkvY2naSBnYzENr2QJ+8Xsr/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278839; c=relaxed/simple;
	bh=y6MdUL9ENTqiQkRJvJAjh9yExqe14NTvQAxWVkRtBBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBWvIEzRCTxX/OahOeqOMS9YDSGc+yNO7WZ8t94bxugpnrNMEoRWkM4yp3c5beNfG9JsZWhG8ccPrRLewBaTGO/Xq+7qJOdCzkC7n+t2//kSWS2BqA5/Ib41lgmD0qc+/KKhGjGC52MQ7te2uj6DJF8JKU388ZZI/FS3xavMFYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PdM0dzHc; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bee1cb370so5110361fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 08:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741278836; x=1741883636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mcYfZGCaAKvP2JNTvUnndgZpH/B+98c6oldv3E5aRaA=;
        b=PdM0dzHclw/77Ea3YhyR09FiDVXVxvuO1PXNEaNLbIp114AD3fSj0VdkcFZAvnu8I5
         icdBp74VfOXKeYuH2yTA+CiveHKH7DNVCcB5az1iSYnpbDot2TWCE8QebLgLT/rFKbbB
         7FrtQwQIfDHyoO2J8rMwDCfawUEc0MOPmskAwcyB8w6Q5VwCtIpxsPDiVpTBotOC5PCm
         WyGXPu7dke7CeI8kjLVlmeSOPaqoLPPoAguVaHqjrpcBKMNYI6VvGVYp3IuckACbiCs1
         fsrGYas4CVCDk7cX66HzmDGt3OU9sGeqH4J9352ZA1N88uk9F8dJIMaQzVOe0oED/HbO
         mNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278836; x=1741883636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcYfZGCaAKvP2JNTvUnndgZpH/B+98c6oldv3E5aRaA=;
        b=dkJWTB7uP3pzrHcHSpLGS++bjzFENamRseWDqpIuhBUCVwVwULwXSXhPK1VfbZ27Sr
         ClccwP2OvpbZfNFJy/FDQe4jyUj4GeGJ4UoRiK50rmEhjrB5wRQQdvUwTUf7uEJEHZzR
         aUd+zL173t51FOs/VHgjLLZq9MeF6yQ0N6WRWPvnistUOhP5cFCaZzQVyhULExXrOd9C
         vmW/5mmvoJqrrLyiDjhkqZkhbAgrAbMr5mxj2nET+j32Zr86BppmmMJvMGiWtyOevqIB
         20blfUTKkbICeQMbWdOgQhyxr7v4RUJuwXmXu7+Te3bF5GBG8vimYyRtn7/aIDGFY2zw
         cmCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvcQyGzHc10Fuo3fSnnIOgj0Ei7YDozOhioS/DsOCfVVNTqE5Zxf+HsP9szQnQVMGEEtJwSIhY4XTaMUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPfBFJIZCveYYGOXzasFRMStIYj9f3Dzg0LJ+kYz/d4HYa9lHg
	dzwIxMn1FlaTyrOkBWsio7GQ1cHRSe5I4WfWSKLKI2OjGoE0rnyzi7YldognqtU=
X-Gm-Gg: ASbGnctJ2DChsPQ1T/NxlO0hqMQOaNXJpTF6S2yS3KbLRgetkt1F6R5m1RoP7XUeabn
	ffOt4qbvZu7Z/HsncsTO0gD55AKEd0gO9PqeVVoh/kOuJ5eulGfC3OWYFuXW1Oih92otgty+gWa
	qHWhFW+QJSouy9sbMqQG5aGzzKrDYv3IIc1sX/cg7NI1ataiTAYsiuou95XXNrRw8/wYs0/NP3p
	HX9RjtifUFq7U0qkzbllNikSUTrbz6VGQJyId/CcUTGx6Fy/Dy7ZoVuvAwZzfHHgUED1STOAFDe
	pgDXQs3izFqsbI7g2feirhZhRKlkEfbj0o8X1v4uo0fx0ho+WvoMG2fDwM4K5WU8Y4gBToyLZgI
	lOY8RXmNu59pHKmZTbPR3Onst
X-Google-Smtp-Source: AGHT+IEhK8WPCNQ2ny4wFVJ0Mn/g931J/pH6k2jlLt44c80Y4amsFqDiQ97ufGuuRZNFOtxZQ3FiJA==
X-Received: by 2002:a2e:be05:0:b0:30b:b852:2f85 with SMTP id 38308e7fff4ca-30bd7a3dbd6mr32951271fa.13.1741278835567;
        Thu, 06 Mar 2025 08:33:55 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be98f2f9bsm2526731fa.35.2025.03.06.08.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:33:54 -0800 (PST)
Date: Thu, 6 Mar 2025 18:33:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: neil.armstrong@linaro.org
Cc: Tejas Vipin <tejasvipin76@gmail.com>, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, lujianhua000@gmail.com, quic_jesszhan@quicinc.com, 
	dianders@chromium.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: novatek-nt36523: transition to mipi_dsi
 wrapped functions
Message-ID: <p2esqngynwfrshz5rqfnmx6qgwf4dclpkb3mphwg2vavx2jbcg@clqoy5tjh7bb>
References: <20250306134350.139792-1-tejasvipin76@gmail.com>
 <ca5b0825-a485-4bec-bd93-b57a8d7ced99@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca5b0825-a485-4bec-bd93-b57a8d7ced99@linaro.org>

On Thu, Mar 06, 2025 at 03:05:10PM +0100, neil.armstrong@linaro.org wrote:
> On 06/03/2025 14:43, Tejas Vipin wrote:
> > Changes the novatek-nt36523 panel to use multi style functions for
> > improved error handling.
> > 
> > Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> > ---
> >   drivers/gpu/drm/panel/panel-novatek-nt36523.c | 1683 ++++++++---------
> >   1 file changed, 823 insertions(+), 860 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> > index 04f1d2676c78..922a225f6258 100644
> > --- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> > +++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> > @@ -23,10 +23,12 @@
> >   #define DSI_NUM_MIN 1
> > -#define mipi_dsi_dual_dcs_write_seq(dsi0, dsi1, cmd, seq...)        \
> > -		do {                                                 \
> > -			mipi_dsi_dcs_write_seq(dsi0, cmd, seq);      \
> > -			mipi_dsi_dcs_write_seq(dsi1, cmd, seq);      \
> > +#define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx0, dsi_ctx1, cmd, seq...)      \
> > +		do {								\
> > +			mipi_dsi_dcs_write_seq_multi(&dsi_ctx0, cmd, seq);	\
> > +			dsi_ctx1.accum_err = dsi_ctx0.accum_err;		\
> > +			mipi_dsi_dcs_write_seq_multi(&dsi_ctx1, cmd, seq);	\
> > +			dsi_ctx0.accum_err = dsi_ctx1.accum_err;		\
> 
> Just thinking out loud, but can't we do :
> 
> struct mipi_dsi_multi_context dsi_ctx = { .dsi = NULL };
> 
> #define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx, dsi0, dsi1, cmd, seq...)      \
> 		do {						
> 			dsi_ctx.dsi = dsi0;					\
> 			mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, seq);	\
> 			dsi_ctx.dsi = dsi1;					\
> 			mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, seq);	\
> 
> ?
> 
> So we have a single accum_err.

I'd say that can be counter-prodactive. If only one of the links falls
apart, then the second link still can be initialized (and by observing a
half of the screen the user / devloper can make several assumptions).
In case of using just one context the driver will fail on the first
error and skip the rest of the init for both halves.

I'd have a different suggestion though: what about passing two contexts
to the init_sequence callback and letting nt36523_prepare() handle each
of the error separately?


-- 
With best wishes
Dmitry

