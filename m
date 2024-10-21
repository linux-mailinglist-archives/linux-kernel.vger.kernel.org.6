Return-Path: <linux-kernel+bounces-374962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BFE9A7283
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B6F28246A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B401FAC20;
	Mon, 21 Oct 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bz+TPUGh"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B35194132
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535971; cv=none; b=B0r9cTFvJW9dC9br8tisIMylqEr5DG5vq1A926TGzt8DGWR2F/0QOV8Cc6rjwYXpE6mM7cuWC+FzIROk8ZF6EGln8OyUqxjHBjyNk3zmMh5uOXqxyhi/iLXLh32opq9skpAKo57UryOE7ZogihUowO6P/RO6to85+AgBor7Dmw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535971; c=relaxed/simple;
	bh=X8h4KDqqw//cc7Uyo/3eMQk1cMMoEm6B+3xQ7BF34uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YR35h2As69nwO791LanAdB8xaPVKEloP/8AYBCIyXiNB12jANJLGjiEznLZwlQkp/zIJmc5hxPKB13WclQYNfKGgTgdOKDk6IKVxkbOxLGYwrCSeeksiqADTxwmJfGVw71exHHCnscg7yeN3qFnl3weA9FKNcP830AC8twbAhlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bz+TPUGh; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e38fa1f82fso45127667b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729535967; x=1730140767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=34R/dNE8HXN8cXfAhV6Xc5PQ3mIsbC84k66fTKDzlwI=;
        b=bz+TPUGh3Gx58s8lL6L+pD7mvQZVcllXrN+HfavNmVlfmD1CzsbOrfb0jKf24L5dJD
         E69DKOAsVmumtwVXNwaTbZOswjrzVpth8z8pTlfebuAqJOQcuQLltUXJInW2iGhTZX+h
         9ncARc5jEipv6k0VSeAT/gcQ3zRUT/VHNp+rH1lua9iGHgsKeRUQzjTrtpN5U0z1zYST
         FF0EJArftJSijU+eoHxrGRx5vnULenWGKuT9MDr9LiI1jtt41cPXDR5oRMqYZMGAYhZR
         xcePlpMtfBtlRWvV0QCQ1yAtw+KFxz4iuURU0YDhYnF5//pP+gfzsKEmHSYhH4w2oe65
         gGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729535967; x=1730140767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34R/dNE8HXN8cXfAhV6Xc5PQ3mIsbC84k66fTKDzlwI=;
        b=cC/63EpsS5zHk6L+yBrp9ZZ5ZzAFFfIiRdv903TINgt0Po5bj5txXH1Yzq92B4I14+
         aW3j+d7svS156krRWWd5wjDawrjIGJE4Vwr++pF1rA7bK72ktx5VEVn4grD9rq1YOoJo
         zRHPTjgInDj1p0NNeaqb+RLgrjM819STgn2LUTDnNyeDNZrQLMLqO42+mUich30ROdKI
         YFBA1nvZ9qnUT3jnzlAwaoBwazv84fH7BtlPXFeiQTe6OwxWO2aDzGctT9/2BMhIINcs
         8xad/dWjnVcmDYimj7JN8XfmZt2a820GoPD1+muLEpj8J1TKgaPeuhWFHHC03uAL5ljv
         +flQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDpO5dgM5HhWoVU6mQw6bSV0LGFhiGFhmd28JLyVoY2naUXUMH+lSI9fk/2SSwq0TvCbhUJM+kV0BoJvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxis6ECQ5HqVuxdqMHrOVcaOVKFmBhJD5Eo8srXH6L8cKwbW1rP
	QFqthIWaf7Z0rn7amuPoUvN61xABv+Q4B856/I8gs3zl2yBnQGOfj9gly32eUTArU1CaJ+dWg0n
	ByhWXlc6Bx7bONXUYI12dyXH+xjsIE9SVasf+BA==
X-Google-Smtp-Source: AGHT+IFUtzy4nEfmeAZLA6OqFoY+qkzKSiEJKjCbr+Uwochx0DFN9spMl20epPP5wKuksfjY9jpL3cFJaHJiFCPwPnM=
X-Received: by 2002:a05:690c:46c7:b0:6e3:2c80:5413 with SMTP id
 00721157ae682-6e5bfc8e733mr126862177b3.23.1729535967399; Mon, 21 Oct 2024
 11:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019195411.266860-1-aradhya.bhatia@linux.dev>
 <20241019200530.270738-1-aradhya.bhatia@linux.dev> <20241019200530.270738-6-aradhya.bhatia@linux.dev>
 <m7t4hsa3lcszjbipxlypf655uspoxw3xfyy5jo3n3bnmqaiqcf@6wti5f477gve> <c8a42d96-c02e-4ce0-acd8-3fdc5eecd208@linux.dev>
In-Reply-To: <c8a42d96-c02e-4ce0-acd8-3fdc5eecd208@linux.dev>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 21 Oct 2024 21:39:17 +0300
Message-ID: <CAA8EJprWwKyyh5JvsmXnJC7QbybxEmwnAceMBgUr96uGzEJMtQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] drm/bridge: cdns-dsi: Use pre_enable/post_disable
 to enable/disable
To: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Dominik Haller <d.haller@phytec.de>, Sam Ravnborg <sam@ravnborg.org>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Devarsh Thakkar <devarsht@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, 
	Udit Kumar <u-kumar1@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
	DRI Development List <dri-devel@lists.freedesktop.org>, 
	Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 20:07, Aradhya Bhatia <aradhya.bhatia@linux.dev> wrote:
>
> Hi Dmitry,
>
> Thank you for reviewing the patches!
>
> On 10/20/24 17:27, Dmitry Baryshkov wrote:
> > On Sun, Oct 20, 2024 at 01:35:30AM +0530, Aradhya Bhatia wrote:
> >> From: Aradhya Bhatia <a-bhatia1@ti.com>
> >>
> >> The cdns-dsi controller requires that it be turned on completely before
> >> the input DPI's source has begun streaming[0]. Not having that, allows
> >> for a small window before cdns-dsi enable and after cdns-dsi disable
> >> where the previous entity (in this case tidss's videoport) to continue
> >> streaming DPI video signals. This small window where cdns-dsi is
> >> disabled but is still receiving signals causes the input FIFO of
> >> cdns-dsi to get corrupted. This causes the colors to shift on the output
> >> display. The colors can either shift by one color component (R->G, G->B,
> >> B->R), or by two color components (R->B, G->R, B->G).
> >>
> >> Since tidss's videoport starts streaming via crtc enable hooks, we need
> >> cdns-dsi to be up and running before that. Now that the bridges are
> >> pre_enabled before crtc is enabled, and post_disabled after crtc is
> >> disabled, use the pre_enable and post_disable hooks to get cdns-dsi
> >> ready and running before the tidss videoport to get pass the color shift
> >> issues.
> >>
> >
> > Not being an expert in the TI DSS driver, would it be more proper to
> > handle that in the TI driver instead? I mean, sending out DPI signals
> > isn't a part of the CRTC setup, it's a job of the encoder.
>
> I haven't done a feasibility analysis of moving the CRTC bits of TIDSS
> into the encoder, but even if it were possible, it wouldn't solve the
> issue.
>
> The bridge_enable() sequence gets called _after_ the encoder has been
> enabled - causing the TIDSS's DPI (enabled from encoder) to still be
> up and running before the DSI has had a chance to be ready.

But then you can move CDSI setup to pre_enable, so that all setup
happens before encoder's (= DPI) being enabled.


-- 
With best wishes
Dmitry

