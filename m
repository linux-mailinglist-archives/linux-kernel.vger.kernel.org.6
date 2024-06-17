Return-Path: <linux-kernel+bounces-217257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A933390AD7C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D073A1C22DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C958194C6F;
	Mon, 17 Jun 2024 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ppy/eeCV"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF104194C66
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625484; cv=none; b=kokNqvYpI3wUHlU3ov3PP/xVy8OkwZebDf7v5PBsXmRza0PIA7784C4zDVLIPW7sVbmgYV5m4uqLs1K72/8ixAtLV3vZbKnJbAASZMQAtK5Zehi1kt2L3dmmzlBLPDCBsULYXTDqQ88P54pj5ImquMfgBsatJJ6GTpwkgfhj3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625484; c=relaxed/simple;
	bh=9G7oJoqQW0uOiWVesu6FixywHOroo46ApqET0eeMHrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDVLPM+Bu7G8IuhM7EncjbDshDc3Yy5wbhLeealR4kQs+mDHNjPl5LWgJBaJVrOHNCMRsZeDTIXMyYySbnJb9/KPs0wLwHM/aJaRS4c6wDq6itUAaaDxBNfFkuC9I+P2eKpsGnyrpB77zfAn1cQxOzESFQGqfQU2x5ndne4AiGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ppy/eeCV; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ead2c6b50bso47331851fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 04:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718625481; x=1719230281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VFv9S60vB3SZqXilE58DEUCUKeY01efOKoFr8NRr2Jg=;
        b=Ppy/eeCVC+xY57K9Zm/h41M/2bTv3dw/tYh5ladWiN5I1+Rxc/smiWb81+TZYPPybM
         DNWpmse0dParFn2VQbZ2zQnZT62CRAhko5POIraurHFbmPlvrxjwbEy+3vSZMnwCQ+x/
         9CDSaYLH90oZBg2+NcUD0auftJ19NkNVO9ws1zef1AwhGPfEk7d2VQ7JGMTfYkap+sOA
         YR1Bpn+bBlErsVLDlDYRc1Oz2RopPA+VMV01+PfBA3WzVi3cLTZZ0H4eNytrqed/brar
         YrHK3YsYObxuXOTt0ZhmchEon3juGBN0JlXaQDQBCjmqr/aPaOo3t0F4zMyf7plt+Nsm
         MqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718625481; x=1719230281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFv9S60vB3SZqXilE58DEUCUKeY01efOKoFr8NRr2Jg=;
        b=GQo3xkmmeZZzmf0yBXZVxg11Z1W/Gz06d4n866u6mCDZVKroCCR7hqpqJqhSXkCi6q
         PW1tb+B8lGym9hsmsLCzlDpXuThgIMSGlP5VxHTVUuEhVszUBvfOwzwGti98pmEEQB6X
         zjJ67lp76io6JAE5dfzKNsLKiSXlrYrp8fIYYUALfWqimkqpKpbIfpppU6VlcKFjNZYb
         M3svCGbjFmF1BLxdQ61C2C/rr14NNGzEJKmIN9fLNOKmmssJt/7qgsANzcEk+zOpQdm6
         m6U2ufVIZtlozVbuaurZbkY9EH/g4l9ajmtxrHiTZUGsVS92YljKMXURIXe3b/jMpfKS
         dtUA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Wytrh0l4wiSZzx/iaFr1tHXlAq7MDv4gGI8XVHTuyCC5O+tCV45nzF0tqFL4f4zdcPmV7oTGCxrbry13ybhMwZYnQ5hJ/+C+2Jxw
X-Gm-Message-State: AOJu0YxizIY/hwbKU7H94XNg3QeZwRNrYl11H5ZMfjQlGDrT2eRKG9Sn
	t1vfyv7ZnOubUoKqMi3vJIBXfhZSlAeSVkVbqmUPiMZ0mTRM18ObT2TBvqD/7q4=
X-Google-Smtp-Source: AGHT+IFxAHCRf0dql5AD2VczwQjRwaRSdmKEUrnqkoFLWTS2WQFm8qXvw8HzGB9WpVCrsGnELaVabw==
X-Received: by 2002:a2e:9bc7:0:b0:2ea:e57c:a55b with SMTP id 38308e7fff4ca-2ec0e5d0d3emr62982741fa.31.1718625480926;
        Mon, 17 Jun 2024 04:58:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c05fb0sm13619471fa.38.2024.06.17.04.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 04:58:00 -0700 (PDT)
Date: Mon, 17 Jun 2024 14:57:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Jyri Sarha <jyri.sarha@iki.fi>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	DRI Development List <dri-devel@lists.freedesktop.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, 
	Dominik Haller <d.haller@phytec.de>, Sam Ravnborg <sam@ravnborg.org>, 
	Thierry Reding <treding@nvidia.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>, Devarsh Thakkar <devarsht@ti.com>, 
	Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH v3 01/10] drm/bridge: cdns-dsi: Fix OF node pointer
Message-ID: <223c7j4rkz6oh2kvsj7azn5fit2ojbuqmuhux7yafeosj3pch4@abjur6szwgep>
References: <20240617105311.1587489-1-a-bhatia1@ti.com>
 <20240617105311.1587489-2-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617105311.1587489-2-a-bhatia1@ti.com>

On Mon, Jun 17, 2024 at 04:23:02PM GMT, Aradhya Bhatia wrote:
> Fix the OF node pointer passed to the of_drm_find_bridge() call to find
> the next bridge in the display chain.
> 
> To find the next bridge in the pipeline, we need to pass "np" - the OF
> node pointer of the next entity in the devicetree chain. Passing
> "of_node" to of_drm_find_bridge will make the function try to fetch the
> bridge for the cdns-dsi which is not what's required.
> 
> Fix that.
> 
> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Nit: consider switching to devm_drm_of_get_bridge(), which does the
same.

-- 
With best wishes
Dmitry

