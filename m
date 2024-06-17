Return-Path: <linux-kernel+bounces-216892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CBF90A826
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5741C256CB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592D718FDD9;
	Mon, 17 Jun 2024 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ezIjDh/h"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE1918628D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611763; cv=none; b=i5kR8MUJtbrXLtLNpKyOnUf9T+K3VQWEfcTmwopfrdqkOVbaNwpFYQahZYMi+1xJyjN9SPktvJByxMU6fQq69GxaC1J7dGlFS/HioxdpN+166wOKMZ1w28/59ZqgVsobNXhaxSLFD7Ryoo+I1DY2ByqQ/jVI0/eE7kIA+14GDqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611763; c=relaxed/simple;
	bh=sG41EEukMMiVBhltFV4RWYyPfzd2ubrtw4ODUNjoZd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tu9jkk/ophLRhfcTLmig5tYqoaSq0wwbhnT6QSMPCcY9A+6i9ajB6KRyxUbcuU40VcTMkOVZN0di+9jnoEV1Hz5vGg0I5vB2kNw6wMnjIPuuKrXOoZa/Jfstm+yR13M5oqrmmNO/ndIL1YWX/Hfv2mD4wGfSGdylZgMoTlEXBuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ezIjDh/h; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cc129c78fso35887e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718611760; x=1719216560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2zL/OVwfsmsGKut76UeqNrv4709+NhZVNP+gY0GxxQ=;
        b=ezIjDh/hsK2glRucu3j9u5J2tGDofoq/rR0yhpww8L72HCbV1pcBWiTilb40Fvz0Hl
         /PASAlo1iHGbbaQMUPtaoZLqDSgX3B7jqVA7WP0eN4ymNTHZbfdPdgfJyFnnVoYRDC4t
         Z+0nrzaXbEq7TuPS+Jhk/W1MaKzJxB7vteAxSHLFS0+ndmkVvrKTNFNed0k/bi/p5Utt
         gjv9I+Ju22Ye1m82d8QD1H1KIxjhKR9m5LNi7tFvifeD0xLcmg1sgjcmhUAmWCCZrAfF
         Cc9JyYBumRWxcNaB9+TD7ybFv8qzT9mIO6WZLoT9MAXwEMImZlEMyQ5cR2jX1ZtGUBqS
         F42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718611760; x=1719216560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2zL/OVwfsmsGKut76UeqNrv4709+NhZVNP+gY0GxxQ=;
        b=BymxngivEAGeCNsKGvOU7qFhYdvzVoWFgjStqE/SKlE8cXNyku0xe9tWCCrvohyhfJ
         gR7ati+vMNBagWn5VdO+qc8h2HMwTDvWEi/jOJgD/Qet7gMw4z2nMKQkT94NJ+3NPZHZ
         I/m4vJEKMtOYcgrM7pOEdSdzKeH9f06CWN6IDlh+ImeSjWcsP8y+IvgGuIACJTBfu0Qu
         S6Im9EnBxmFJ3ECkeW6i4iVeyG+ZZygv1BTgYLyZtB4O/KNwaq25n1CA6U8kBnVUvovc
         exJl4zcnsSSUeN00lwVlwGKtcnT1G656btyP3fkr8UNzCrqZInMCeWJYFJNql6ByKqnI
         8VXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmHvXYnSKTbqtK7vezw4cVS30JWjV95BrSgLX8tGfmJiFvOTr3yeKh/IvLvhpBoaN9wJ1LgnjEA44TmdDPoeerpjR1lEUjI8ycYNn2
X-Gm-Message-State: AOJu0YwwTBE25vY5H5CYWMyVuwxx0fpH/EJRvOE1qSCEOiwmRXupAZPU
	dO7OU+q2kOuy1v5v2rV8A8KuNixhZAamKTU4PgflLr0+FQcS88DZt0qrZYqZEjw=
X-Google-Smtp-Source: AGHT+IGIN1VZ1dypo5WcnYr1mOVKMSlIuBzxulj3P3h7dJapVZkX5DtowVEXUEm0YvuSq5466IStVA==
X-Received: by 2002:a05:6512:3481:b0:52c:8ddd:7bde with SMTP id 2adb3069b0e04-52ca6e9f522mr5211431e87.69.1718611759946;
        Mon, 17 Jun 2024 01:09:19 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287228bsm1165097e87.163.2024.06.17.01.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 01:09:19 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:09:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Aradhya Bhatia <a-bhatia1@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/bridge: tc358767: Add format negotiation
 hooks for DPI/DSI to (e)DP
Message-ID: <x3modgardta7sj4hxw6akufgpavhvanxyily4mvejmyvsuvesx@fjmlc6oerspi>
References: <20231108-tc358767-v2-0-25c5f70a2159@ideasonboard.com>
 <20231108-tc358767-v2-1-25c5f70a2159@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108-tc358767-v2-1-25c5f70a2159@ideasonboard.com>

On Wed, Nov 08, 2023 at 01:27:22PM GMT, Tomi Valkeinen wrote:
> From: Aradhya Bhatia <a-bhatia1@ti.com>
> 
> With new connector model, tc358767 will not create the connector, when
> DRM_BRIDGE_ATTACH_NO_CONNECTOR is set and display-controller driver will
> rely on format negotiation to setup the encoder format.
> 
> Add the missing bus format negotiation hooks in the
> drm_bridge_funcs to complete DRM_BRIDGE_ATTACH_NO_CONNECTOR support.
> 
> Output format, for DPI/DSI to DP, is selected to
> MEDIA_BUS_FMT_RGB888_1X24 as default, keeping in mind what the older
> model used to support.
> 
> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> Closes: https://lore.kernel.org/all/24282420-b4dd-45b3-bb1c-fc37fe4a8205@siemens.com/
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

If this is a fix, where is the Fixes tag?

-- 
With best wishes
Dmitry

