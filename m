Return-Path: <linux-kernel+bounces-433131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5214B9E5438
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2418A164342
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9127920B80C;
	Thu,  5 Dec 2024 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AdwT1rpn"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D11207E12
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398984; cv=none; b=PaR3OhrMEVy4Ran+peKfGSNedWI7HxtjD1LB2FPBR+K4fFL4DyorYpUboeFjvCIZ51N3HkdI6bvb7hNeTieXaF4R3v56xeOuv5esIq0Om6vS1Q8ev8fyktiHBBmbbAXNY94Wi3Ken44dzoBNk5PIe9MLue+o9sI9CnRv3S3phVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398984; c=relaxed/simple;
	bh=QwW8hEKc2ZOq0UAnDz5EozX5u7ND1JQqpJqyq+GHFPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZPoI3nE0qTWdHg0Qh+wzH4EZ9/VYLOXZsHotQNyt5RuGr4GuIyIhiWN0Vg5cc/NW3acfcPC5fgrm9ifMYpEcJd6J6LehdbKqNRc31mqiqjKzSpctEYMfjBuekGiVAJLO11XUQvviPOrZFEbj9hbTZA8OPGA+bzCH0fFoWi71nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AdwT1rpn; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e382589e8fdso897207276.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733398982; x=1734003782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=foW0/KGDo9eGD4oVVo4WypJSTUBY0HMIRisvLT2/meA=;
        b=AdwT1rpnmzOvoI8HzQP/Eco8TB8kZeNegVFmazVmm2jjdcYGQluNnAzwiYfianUEJj
         WmW/LejubxecCSwifWfW0MIdC2v4X/G9iAlt6TGvfeH1EoFzkx1P0knsu7R3W1U4rjwT
         U9+AZhNHWk9e6UQJemoj62HAqY5VSnOC4P9biA8KFxzcAInIleBY4Gaq5Mwb7BZRyPTg
         2WvRad89Ya4YMLgb2gJI3DxB4PUpUC7RZI9msav/Z7K0FVBZ4aihwQCdaJychVYnrM0H
         br3S+gulj79B9Q/nyFSPO4bQ+TCooztvssexDXJPVb4fjN347FEVuXvfxk0viscMnC8B
         421Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398982; x=1734003782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foW0/KGDo9eGD4oVVo4WypJSTUBY0HMIRisvLT2/meA=;
        b=S+h+AmUpOydq1TQIah/oPmJza9M+TTryP44dmZqB25sAXFiYLgC6pilm7WNkhiswc1
         MsIc2uGxu16YO1qHzwU2RfZxPD7PWh8Izf6O+M933rexw2uQSei7jPnc4KAh014PhsRt
         +LhwMW3oCmVB5lH76iCsV8iG8RfA29T68sFyaRh2Yxje2u3DEFFAGkcB6SGc1sznoRkM
         ceopzqCFyJp+2QuaQ6d7qQgiCsoGf9INgSwzdj67EqPsG6WMEozv7tuKxFJj2HDLkOIR
         Zpi23y7V5de8biCbBncM8bf9vFlOgCLUbYEfBbN55bwU3s7Jv4IQpz0qNn3IHH3vDhZx
         y1Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVnNmpnkAwUSzmzhuQMuMjmH0uZpQvOxqsYJR0+17lW5iO2E/zHxojWzsSwj2ekRUH5MYWkdPCWerhuoD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/K3FhMcGE8gW4++42QJF9FkYloHdEzBF6PcgnLnq7m428d8x2
	XLHaC3HJ9tyS5sCkhuNC6HJ26a5QyBt4zTMs+1aqDYh7MgYyzZHE6baVw5usbToc6aQZ1pa6cab
	BTVchvEk9zkrI7HbGi0kVJUhGqD27fcKPAORCbg==
X-Gm-Gg: ASbGncud/rE5wRTudT7cRgkRRayI0bMJ1++LklSWdyYBG7axZ3WmAGzxZYOKgi71OYI
	o5LDNcYsxOcixOVk3ppakg79keC69OTtaBc9qW9vYFGAyTg==
X-Google-Smtp-Source: AGHT+IEHe0hEqVxHW1W6LA/XnWI/0yeqMuF4kFnDKLb5IX3EJI4UID7Ltgg79MyMh35EoVOtfkZnRY3ZbH01erDTs/A=
X-Received: by 2002:a05:6902:2b07:b0:e39:8d52:e308 with SMTP id
 3f1490d57ef6-e39de228e92mr7181180276.26.1733398982302; Thu, 05 Dec 2024
 03:43:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203172129.778123-1-tommaso.merciai.xr@bp.renesas.com>
 <hd2kom5acz47c3mkjuauxhauahkt7vq2qoilppwn34iidldhos@rb5ydcayhtlj>
 <054a0278-428f-49cb-b0f0-182c5bb3b61b@nxp.com> <TY3PR01MB113469CCF62FCC801F15C6B2286372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <3243b983-2f22-4254-b7e6-0f7ef0ae725c@nxp.com>
In-Reply-To: <3243b983-2f22-4254-b7e6-0f7ef0ae725c@nxp.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 5 Dec 2024 13:42:51 +0200
Message-ID: <CAA8EJpqAjx+K2GdKt=gLxsETa7nvH57f3RVbhhL6EftiN_8EuA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ite-it6263: Support VESA input format
To: Liu Ying <victor.liu@nxp.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	"tomm.merciai@gmail.com" <tomm.merciai@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	"laurent.pinchart" <laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Dec 2024 at 11:01, Liu Ying <victor.liu@nxp.com> wrote:
>
> On 12/04/2024, Biju Das wrote:
> > Hi Liu Ying,
>
> Hi Biju,
>
> >
> >> -----Original Message-----
> >> From: Liu Ying <victor.liu@nxp.com>
> >> Sent: 04 December 2024 03:43
> >> Subject: Re: [PATCH] drm/bridge: ite-it6263: Support VESA input format
> >>
> >> On 12/04/2024, Dmitry Baryshkov wrote:
> >>> On Tue, Dec 03, 2024 at 06:21:29PM +0100, tomm.merciai@gmail.com wrote:
> >>>> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> >>>>
> >>>> Introduce it6263_is_input_bus_fmt_valid() and refactor the
> >>>> it6263_bridge_atomic_get_input_bus_fmts() function to support VESA
> >>>> format by selecting the LVDS input format based on the LVDS data
> >>>> mapping and thereby support both JEIDA and VESA input formats.
> >>>
> >>> For the patch itself,
> >>>
> >>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>
> >>> A more generic question: is the bridge limited to 4 lanes or does it
> >>> support 3-lane or 5-lane configurations?
> >>
> >> According to ite,it6263.yaml, the bridge supports all the data mappings(jeida-{18,24,30} and vesa-
> >> {24,30}) listed in lvds-data-mapping.yaml.  lvds-data-mapping.yaml specifies the data lanes(3/4/5)
> >> used by each of the data mappings.  So, the bridge supports 3, 4 or 5 data lanes.
> >
> > In Renesas SMARC RZ/G3E LVDS add on board, only 4 LVDS Rx lanes connected. The 5th one is unconnected.
> > What is the situation in your board Liu Ying?
>
> The adapter cards I'm using to connect with i.MX8MP EVK have only 4
> LVDS data lanes routed out.

What about the bridge SoC. I don't understand why the driver gets
limited by a particular add-on card.

-- 
With best wishes
Dmitry

