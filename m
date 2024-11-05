Return-Path: <linux-kernel+bounces-396334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64259BCBD0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9042840BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4851D5141;
	Tue,  5 Nov 2024 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E8m6FFCs"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4EA1D4353
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805990; cv=none; b=BjZ+ERMomD/LlKcpNVhGG0qnT2kwabnnnbQvaJuzNFnplfiqoW9Ts7oSPid2qsuJuTtkXB6N6VNjWBz/sNKSSPB/eqr9X8hmnjp20GO+mgw6jfianSj6Zq6cEGfJKS0Sb0h0Bz4fLbTmHAaz3qsUmj/S8qXOdnQ2v4DuzVPrXWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805990; c=relaxed/simple;
	bh=5QQgUw2ALK33YJykVY7tKUEL4qnSJZInxh6RWYviDA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZlA3AtXzKMX08+3xiMykXGS4J8THHYqTMNSp/wuXtpDUS1JG6BuZ9Jl+YSBi2nyKGymr/sYrrAnmj8miC1irdMyc6MLhRaERoV2I6ZtWlLWxnStcPdtn7PWIl/m9SGf9QpZkpIU/sDEQZrS44FHv9VpF5qiCN078fBGWHkHgEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E8m6FFCs; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e34339d41bso45643737b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730805987; x=1731410787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbPFk8wJiQvrTCXjlYgvumUQ0j3KXfVkR1pWzQFIBYw=;
        b=E8m6FFCs+Shrh0CSDyAWDehh/MGhCznW3oNxLJnLnEW+/uLh5Ig8n441HhbIayj0V7
         OhN8KVljL00ESkeG5C9rg3HTkvELnDSI1SZ5eRePfkBj3hAP07073U56foYcQQfuKHCQ
         8Ysp2kde9dnWoPCCfnzzaNptWA/G81N/aRD2GAhbRc+k6MUc11nOPL8nW0dF9tDmJfUj
         4EitIwTY2qq6eD1tizvxK5lo4RgDIYf5r8+fqr1ZZeCojBYrDRJWSOmLRyGO/LJQXulk
         1t4fQ5AZtd6u9uUblt45kv0MZXOksD4PtZ8YVSxLIHjJnvU752Zme5feyiXZrLOn1vKh
         OxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805987; x=1731410787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbPFk8wJiQvrTCXjlYgvumUQ0j3KXfVkR1pWzQFIBYw=;
        b=FFTJrBbTrpMeDwwT+9olZ9zrD2bjpk8DR4tBh0NYO8ahTZ44l6tiZBoLJ/paGZkkdy
         X1SgEhhXE2Yq3HtRXrKjGIujU92WRWUfn474vSKrNSnKGW3uSEAUu3wctolonnn9gFGz
         nfAwca6ixo5Vp3tmdo1V2hHtfEuJ9ay+HtVH65J42iIuEoSZHCop+iPVCJGzOKefDw8q
         bN/5Ms91jGJfP16ekkAOW30UAGt2l+UhR8VdZWjNzz7gjdxhmGjtNsIX9K4F9LaLgbLv
         cmcx1DST4rdPmx5Q7j8Z4kfnSumwyUMHQ6ggkA/5k6YlVypkdlcL3DMmClNsi2tyTWWR
         klJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjmIvp6ROJCTYxHASdqK906yJWhVVMU1MG3Hw5RY5XOaJLOUZKWlA58S0nWMgOEc5r49XglLAnpPpapwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrFjCmlH8PfarqnO14D3B9ce/YqFBmP5jXVuR8jEJfSVHYSw74
	2cw0AVPM8PxRHQludFKrffl8aYjAPCcwuPeiWCZcpl7sADON8Qss+n0vWax+L8kP8ElWtMq82uD
	NiLGlHUKwgTyVa1i1iMBJfmIgLwRK8C4utI7LpQ==
X-Google-Smtp-Source: AGHT+IHwht1pfSwQlaqWWbyXJaYST2v470nqEkV0Y3tMwYWqipVeiUaNoITHKiBik6whym2zw0rsn51UBBneR8aGa1Y=
X-Received: by 2002:a05:690c:fd0:b0:6ea:8d6f:b1bf with SMTP id
 00721157ae682-6ea8d6fb48amr78680707b3.0.1730805987251; Tue, 05 Nov 2024
 03:26:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028023740.19732-1-victor.liu@nxp.com> <20241028023740.19732-5-victor.liu@nxp.com>
 <Zyn5CgZvyg05cgJW@kekkonen.localdomain>
In-Reply-To: <Zyn5CgZvyg05cgJW@kekkonen.localdomain>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 5 Nov 2024 11:26:16 +0000
Message-ID: <CAA8EJpoaLnw46DUaZ+z-YSkbdk-f45-dKMjoQWu16zaC6i-H-w@mail.gmail.com>
Subject: Re: [PATCH v4 04/13] media: uapi: Add MEDIA_BUS_FMT_RGB101010_1X7X5_{SPWG,
 JEIDA}
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, quic_jesszhan@quicinc.com, mchehab@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, 
	hverkuil@xs4all.nl, tomi.valkeinen@ideasonboard.com, 
	quic_bjorande@quicinc.com, geert+renesas@glider.be, arnd@arndb.de, 
	nfraprado@collabora.com, thierry.reding@gmail.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, sam@ravnborg.org, marex@denx.de, 
	biju.das.jz@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Nov 2024 at 10:53, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ying,
>
> On Mon, Oct 28, 2024 at 10:37:31AM +0800, Liu Ying wrote:
> > Add two media bus formats that identify 30-bit RGB pixels transmitted
> > by a LVDS link with five differential data pairs, serialized into 7
> > time slots, using standard SPWG/VESA or JEIDA data mapping.
> >
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> It's fine to merge this via another tree, too.

Thank you!


-- 
With best wishes
Dmitry

