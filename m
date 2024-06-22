Return-Path: <linux-kernel+bounces-225695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B919133E2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8301C20B3A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABED616A936;
	Sat, 22 Jun 2024 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GcLodyVd"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCFB15697B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719058796; cv=none; b=ACWFkXnFKKABARU05viTIHt9QHBnJvSH2td70IknP5IaD2efoAu2Rja/LBb5qvD4zLN1KXUuyOPGkXogw00732egQ9NA2ec+AizXG8lQSQKD81VlGCzWZwLxLDP/MYi02VZ9inW3KcZRcoIV9DusvTikN6MikgwUZcIfnpBR9B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719058796; c=relaxed/simple;
	bh=gVXvoVnWKq9b23KJIwpwq2PnXPvHVuOgLADjnKrQOmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJJMTLnRfUlqbMIs3akyvn9uXDJ7wSQFbwzAUR1b47Dvb7Yo/f+a5JtnKwPWxUjhCNIsS6ymjqHuAFhO6ZdJon470v5ZeIfyJtC7zExIPPll3UjFtXX230Mslja3BdwCJvfmhoF7sWW7RFoORjUIKEF9/KQBKEQ8+vt0+DWRuy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GcLodyVd; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec4eefbaf1so14547961fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 05:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719058793; x=1719663593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qGqWQ0KXhW8OxiX+0ZFBPoio2XcyXoe1CvzjPWFjYb0=;
        b=GcLodyVddW1/BFtz0HALQlmU+mKbIOgGp03DXTMbPGIz0M79yKh+sJ8ZrHDTgfru+d
         bWSqYZUCpLk1MJRjcAGfEOwBADLEAaTAtXitDbAp5huHMGN9F7p9pn0hwqhKcoIYKBXj
         BpA9kUG9Wo+tw2F/6qdNIO79Is1gZEQMJqVLYARJAgUbwJKI0dPEihH+fc0yhJx+VqAe
         xIo2nQGBeOZSnAyMwOQ2WOomgRuLAA5iNqPYnlGChfG4G2yZa5HBmO2084Wc+hKaTw3i
         qq/PTN93gupJxnJwXz3Bk3/KqwR1r+bzLAlAMCfTZ2EC0gN8hVIYQD1suO4z5kADC2kA
         f0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719058793; x=1719663593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGqWQ0KXhW8OxiX+0ZFBPoio2XcyXoe1CvzjPWFjYb0=;
        b=ZvmfQ9itwKBPFigSvQ8fILlPRR9+wVyQVi52/x1ugcDPx7SBgqeCAN9SajzfkapL4R
         xIWh+wfYHyGdttxW+rNJPdSdUgXgRxdNsIAV2Hrj4EcdVOgZiCt3XCFKvvi+pLwJqcWf
         YKhSnXWIwA0TBG7VXklj6yZ2v66fZgvP5fKfaagH+TQDGrrOoT0EOzORMgxzjAJVvfkk
         o7ged3IKvPBgDtAww8kkqyeMVN3ot7BjNcQclAFXRc4zNAJtdj/Je/R51ns6pzvYFUUt
         depVDmAt0UGw+lDOZjfkmIyHdyQToby51EjKj1ieetw9XosPzZuJSgepjJbk1LmVCkyH
         HF5g==
X-Forwarded-Encrypted: i=1; AJvYcCXzNMzDjmKZTA1+Lpb8irAFQKv+H5t4+jmCNrL20DUL6SZuw/9PeV79CA7YIpXMz7ZIPmkX80OlTDiv9aTbaBi4oh/VGzrI3EqD8SH+
X-Gm-Message-State: AOJu0YxDcrutwHWCpb6PI8rPfBduBXH1TopG2u8GHradjxiVQk+6X1YX
	wKrD7UKBZtpPgpgEAJVs7bp87+1UzN3HbYJQ22t/rZAZ6RfYu8L5iycmiAkXQaE=
X-Google-Smtp-Source: AGHT+IHD7TVzn6lmksj2n2QOTdKYM7mv+05xXtSaYsPY+qudR+FFoQvVW+IFqzCgNUZ52V+LWCZBaQ==
X-Received: by 2002:a2e:884e:0:b0:2ec:59d8:a7e9 with SMTP id 38308e7fff4ca-2ec59d8aa7emr1428491fa.52.1719058793396;
        Sat, 22 Jun 2024 05:19:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d75823asm4510371fa.90.2024.06.22.05.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 05:19:52 -0700 (PDT)
Date: Sat, 22 Jun 2024 15:19:51 +0300
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
Message-ID: <wqg5nxg6muyoljbmsemipzv74ziwmt55qtzmcbexpqxsqzqpno@o2uhl2jrljft>
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


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

