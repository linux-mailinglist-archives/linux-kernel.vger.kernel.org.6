Return-Path: <linux-kernel+bounces-336640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50385983D64
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0597B233A3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C1481AC6;
	Tue, 24 Sep 2024 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjaKh3mz"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD61E7F7DB
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160807; cv=none; b=uG2DY0fpYqmnaLzVFWMFX3NYPD6wm9y0Q/AUjUA+F9ZPrZ/TA961VMdr0A4drDmJR6eVeiFFV+uBDBpyguesmwsnNUSeIS3E+qNaWTGIlUAZBpLCKMy2z3N3zTAwpBeW30DdSUBkiQFLZpDKUSyJ8j7WFkqlHwi2Ap28VNqsxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160807; c=relaxed/simple;
	bh=j2kgwpLNVoA25PAKsEA9/S1NUtMC4i0jKFJ952FrbJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqbQm6nQKQGm5QpXjFD9l+cS755Hd8ssmgwXF/J0ajKcvNly3Kd05WjRKqUjdgkusPimGMo+76k0E1iS2SAAYm2KUxZtclTvzcwpIVV2Ua4ztrvZq9x7LI+8xU/tfUggmpR4Zflp6zRWqYgx1LsFEyAjgrBgBOyEusm2nTa51LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SjaKh3mz; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5365b6bd901so5965528e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727160804; x=1727765604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HX+NJAuqAMFoOraV+kSUG8Sd9N7pPiQZhihCSJbiCiA=;
        b=SjaKh3mzHRZHfFTL6QjcrGXl1SSuIjojVxDQPNgZwpluJBGzFtGMoHVxsq5OlXF1c0
         mSTnp8O1Ta6hD2b4zgkwZ6d2YZG0RlcLNfcNAYwDz+8Ry8HlE4RBIWTm2jsSNpX2As6+
         EZlgQyICBeOTXFv5oKr55EbJaH/iHpsKfvpu6EyvxB4NdaoylTDPCZEcY0rekzFS7HoP
         w8TFlbBDxRGgxx+ModPHM+aGQ5LE6pXm9U3hV7nujJRstC0W8Wic0WAp3tHBZcEJUoWw
         UUKjgW8wBQn1rGo/WGrJF3twNinHI9OfDQWK0ajgD7jcrsr+rlbbeVywxxeBqAPGdJxF
         2w8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727160804; x=1727765604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HX+NJAuqAMFoOraV+kSUG8Sd9N7pPiQZhihCSJbiCiA=;
        b=mxIDYckftD6Ty6VN1VczZ/n7CiJASYWX+93QPEf87iynmja6ZaHvnlZTSKtAfwZK8G
         gkh0Y2M/EdsLgp1DENK8WjF+TkEq5zinr64ztEAsbyePb8l3B3y5d5JXEgWvEKOse9+s
         yhXwPdc6DeD3qX/nUVw2Lun8IucNsLjnYFFNfttRBEMuKmGDmf1BeviMJjDPRsfvakJR
         RXNmyzQO87P1TAP+p9VtYySSausyXiBaBMUVINLU/hKNza9BsHB9KB0zsIDclPjsnBdo
         KRuH/AhZ1GEmPzxUBBAtwuYfZbMpDOajNNSx2heoBOhEP2PSwxxyxuMXzIymsxX4mlAm
         aiuw==
X-Forwarded-Encrypted: i=1; AJvYcCUN5yAjABjmsJVB8WSbk2yIgp9yV24ACjvbPfUzuOo+1P56v+Dy78+Iz2VDjU/66aaWJvMAYJENAuxGT7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvqsiqoD5DV8BjuASePXntozm3oTVjNVAKiCKFM7sqy2rgHGCo
	MZiuiOSDC4SiLinsaPdgOs+yCtH1QIgOG1RnXrIdlNoDeEXJmDn6zTOfoSgm0yc=
X-Google-Smtp-Source: AGHT+IGvMRTwMjApZK5PP1Mbu/n0xO0DngryCPpD/BLB9Ac8B4U3qg+XAdzsdXwgOiCc732J3oFtpw==
X-Received: by 2002:a05:6512:ba5:b0:533:97b:e272 with SMTP id 2adb3069b0e04-536ad3b7db5mr6774890e87.41.1727160803952;
        Mon, 23 Sep 2024 23:53:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a8640220sm108903e87.142.2024.09.23.23.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:53:22 -0700 (PDT)
Date: Tue, 24 Sep 2024 09:53:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Pin-yen Lin <treapking@chromium.org>
Cc: Xin Ji <xji@analogixsemi.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, 
	dri-devel@lists.freedesktop.org, Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] drm/bridge: it6505: Drop EDID cache on bridge power
 off
Message-ID: <pq3dz7ldjfzs3mu4hkcgrlrugxgkgpzfxg23jccl6bkcky65lq@7mbo3ebjzat6>
References: <20240924035231.1163670-1-treapking@chromium.org>
 <20240924035231.1163670-3-treapking@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924035231.1163670-3-treapking@chromium.org>

On Tue, Sep 24, 2024 at 11:51:47AM GMT, Pin-yen Lin wrote:
> The bridge might miss the display change events when it's powered off.
> This happens when a user changes the external monitor when the system
> is suspended and the embedded controller doesn't not wake AP up.
> 
> It's also observed that one DP-to-HDMI bridge doesn't work correctly
> when there is no EDID read after it is powered on.
> 
> Drop the cache to force an EDID read after system resume to fix this.
> 
> Fixes: 11feaef69d0c ("drm/bridge: it6505: Add caching for EDID")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 
> ---
> 
>  drivers/gpu/drm/bridge/ite-it6505.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

