Return-Path: <linux-kernel+bounces-339923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B299986C34
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAFAEB2165F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3D516B38B;
	Thu, 26 Sep 2024 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIJ+achf"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF4E33C9
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727330462; cv=none; b=brjN+6V7DonSGKUYI3NHixTVHDAeC7dFU9W3TLc4DENELnhORdJLixQlglGA/1VccLglm6yA21QsUmBxvksSRaQW5cwvlDj51VCeKwVKEdCh0Ii8GwnOsTXqGNV1HLlo2p9y+0/mHtuydfD/KlTFJhJa+VHIXBTIGMdHerzrWlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727330462; c=relaxed/simple;
	bh=APHhQS2kfqSesdAbtu8MsR1bPo3wOCnREIf/orjt6bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj4Og0MWeu7C1cInWobqXnVoPlvj5TA6WNqhhCcVP2yCEEA+AgQvNW3BrwHDnuT5ju9ZN8HqFxtrYTeTLEAjTjqUZlGjxxbtTy+skMrucRdXsa/p72i3t8GwBooYCADHndb29XJphlwcnQeIDyyRGed2mqtTe+RD+SArmj7dZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EIJ+achf; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5365c512b00so690352e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727330457; x=1727935257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ILy1gmaChDb8kjYQrj+oZMRoRoxb+hbZeapN9RMmuKk=;
        b=EIJ+achfpyO0cd8wsXocjbtqtJMeNx0DLGE/zpHJYueqPzaakqrd/PDyMAdpsRJyf2
         g76f4MciOg4t01mwLiP57OOfMAqZghF7smFjlNd66KY+R3iVuHy1KoquCjE1FwqhtIlT
         lOqoMTbJn4VC1nrkIE8wJWswfVtYCrUz+OIV9JZAWlE5XEooJdtOv51GpQ4stAGYgJPp
         sVwBwDCmXqztop/g8D8SgWVCO4sU0JCn1+j0/6UF+0KrDIUWLRdDNxm+3y6JttxESTMq
         ui1ex2xGfJ/S9chd14i/bNhXFF+IP/LtMGT7ee8647bWcVkaCy40rFZ08AO12uWGEO/k
         08hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727330457; x=1727935257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILy1gmaChDb8kjYQrj+oZMRoRoxb+hbZeapN9RMmuKk=;
        b=ck7SJcf0OEiTuMywv1sZzbUY7YNjXqxymb80QDlTRX6d3VxHLxh9i0GSYWHyWyrlj3
         kB8CAcEsV+RbIPsJNq+qzUorwdfAcYnoWoTGC6o3U7kt/C8NjlT0vT5Y1g1RN1mmnAYD
         zHmsxqRmdgaLt1gqu7Mq7WWTqUpGyYtgIEa9Jqz85xCbKZefrvb2UGJOGsTi29A1zxJK
         g1AgIXBMf8iJBhfDOKFBvL0zEUe2IiKaJCnJUHVSSUjPEN88YqTzyl8KdBG2cGW6IdbR
         Ey/D2XjQGOX+YTSi7DwGypuqqGWn5sf9n/0PT1ygOof/Cw8zE7bFZR8v9zPY/qvbAQGT
         j9Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUot55wcNbMrTFYWQZ3nQAvFCf91SSZQFhkZzJHnwu/Pmo3EAAnuaMkV2ijMFHuN4wWcBVEw4ledcbAI2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiWVHwghrBKJAkECv0rUJUowLo1Yt+d2Q44dvLgFUukIx4IWuU
	771lbfViSwYGUUl82Q/s9UTZkrnd3+bMOPWoPRsruEpt7UaaFMkQJE2CSdNoj24=
X-Google-Smtp-Source: AGHT+IF3zAWXPj1hxe8OqEL5ya4nM2XcgbVEqmQK5WYyGuJNygjvKW4VKCBqLHmEaR5Sbg+uW3uJLw==
X-Received: by 2002:a05:6512:12c4:b0:536:7c31:cb21 with SMTP id 2adb3069b0e04-53877553493mr3634739e87.35.1727330457366;
        Wed, 25 Sep 2024 23:00:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85e0bbcsm711541e87.46.2024.09.25.23.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:00:56 -0700 (PDT)
Date: Thu, 26 Sep 2024 09:00:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Rob Herring <robh@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Thierry Reding <treding@nvidia.com>, 
	Simona Vetter <simona@ffwll.ch>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Alexey Brodkin <abrodkin@synopsys.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 ] gpu: drm: replace of_graph_get_next_endpoint()
Message-ID: <bsvoitn4ygjm7ftiqex7knppf6ykiqort4wf3rb4vlsw6gnu2c@kze7w2f3plha>
References: <87setn8eju.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87setn8eju.wl-kuninori.morimoto.gx@renesas.com>

On Thu, Sep 26, 2024 at 12:05:42AM GMT, Kuninori Morimoto wrote:
> From DT point of view, in general, drivers should be asking for a
> specific port number because their function is fixed in the binding.
> 
> of_graph_get_next_endpoint() doesn't match to this concept.
> 
> Simply replace
> 
> 	- of_graph_get_next_endpoint(xxx, NULL);
> 	+ of_graph_get_endpoint_by_regs(xxx, 0, -1);
> 
> Link: https://lore.kernel.org/r/20240202174941.GA310089-robh@kernel.org
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> v3 -> v4
> 	- based on latest linus/master branch
> 
> v2 -> v3
> 	- based on latest linux-next/master
> 	- Add someone to "To" who is thought to be Maintainer
> 
>  drivers/gpu/drm/drm_of.c                              | 4 +++-
>  drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 2 +-
>  drivers/gpu/drm/tiny/arcpgu.c                         | 2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)

-- 
With best wishes
Dmitry

