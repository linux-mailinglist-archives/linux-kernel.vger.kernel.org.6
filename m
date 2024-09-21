Return-Path: <linux-kernel+bounces-334945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B3497DEB2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591FE1C20C24
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E16C43AB4;
	Sat, 21 Sep 2024 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FUCiYoPL"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B54179BD
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726948974; cv=none; b=YaI0JQHvvdHKijrP+qUpKCqQwpk6HD2Bd/klJKznW7Hxc9M3aus74Ck5dB7hsbQz57avSHG8dK2oFqDgdxtgqx5NDrlj2v4xWakNwN2IWRDItqnoS/oJA1OQGxLxpGt02HBdA8RTuamStd+Rdr/mUXmp//+6F1cD+1VdT+/pJno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726948974; c=relaxed/simple;
	bh=8xUuIMjEZjGhC1PE7S4SQtGHCM/9vhF7xjxcfesoHeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8umyUADi8Exct2L51ZIg2N94T4X2CmvnriH8jfrYh0mI7ys9iP7Twytcxm0Nyrn5eeetDVjdlnV4pWaGNAFwVql1cPYay1Q66AcRmoR/2TiweSiUHNuJc/nLnH7PoK7/pbI5aLi/MW1mxwMydo3QPjLIUOJMcXtyNvHz4jjdGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FUCiYoPL; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53661ac5ba1so3251683e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 13:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726948970; x=1727553770; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KzTjJLHGO/fZK2ZP3mh0GYV6FdmkG1EHAMPRnxKXquE=;
        b=FUCiYoPLNsNT+e17ByXDAPGS7yqnCKjmmOrqd6X2zkAJDV4jGMe1q2H+dOziTyrZbg
         +hz89chiW1yRcVw/71FGrmDCTZJ7iunrDaaCMegUo/zARN6vrw+fl44N8ttDQMi6zrjz
         462HsnE82batAGHHd98KXzGDjc1QPAvt6LxfWWfcCfeGFuk/xi1JIuzRLwXSfFrteB0+
         ZWg+fKxiPIz4ag2D2CwBPUW6K/U0n5dPEW5jhSEdTJUfX9mOIJpocB+NLan0gc3wMzC2
         4GvD9hhozKSRaMBuVBauMOqY+q/jZaWDZd+EmQVfGZa/jef88Si6wsPGQyDnqEmKGgL/
         od/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726948970; x=1727553770;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzTjJLHGO/fZK2ZP3mh0GYV6FdmkG1EHAMPRnxKXquE=;
        b=LNsqJuYy9d/2gg5ZcfrYFVbchryUxkFKrv54wmliU653IRaFtN+ZTBHR58gSl1dHNs
         b1DMgk3xTGxRa5dHtkC7AVaFJoFrjyoll8VWTsyGWc8/INWZjSbBEuqG+hxJmgM4zE1d
         6g82eVUDh3/9PS4K+tkKu/Au4aqkQ1EGHHDoYS4JE8D/L9VfZ2kvwu5CIXKh38WyNoKt
         OI6kHZ4Ylt9fryb+KhJ7GNvCHqgRzZwYIBumfVH4cpmrVocr02WXM71Nb9OkxtaqcN98
         5Ecg/hfRUTWYR9F8WDZQ67WvXUlU8rMBOdjoQXyzzDfXYO5yAhZJyO8ZksorERHFieBx
         PmYA==
X-Forwarded-Encrypted: i=1; AJvYcCUAgOk+nQnUtEXPhhm0bUBlnB9b8ZQToznjtMW0ckM42284kau1wUtmrXj/KlPI/ll+qCg6j8bearZe61g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbQOT5+GK09KNTZkPqpAGdQ4dNhtZnY+5VGFrbCCesaRNr6yQC
	2Wm2EIZt0L9UMcTcBf97kSX4qnZqj8jLYnCvTSyvGS+GfzO4mRaggD3X0nLWgj4=
X-Google-Smtp-Source: AGHT+IHlkZyIV65BjpKbE85N6c+hDkQ9A1BsLH/UuQReGbYIwftQNbGiizyTppv3FTyi+Isl5pzrzA==
X-Received: by 2002:a05:6512:e94:b0:533:45dc:d2f0 with SMTP id 2adb3069b0e04-536ac320123mr3801447e87.46.1726948969589;
        Sat, 21 Sep 2024 13:02:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53687046795sm2684177e87.24.2024.09.21.13.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 13:02:49 -0700 (PDT)
Date: Sat, 21 Sep 2024 23:02:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: tjakobi@math.uni-bielefeld.de
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	=?utf-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>, "Derek J . Clark" <derekjohn.clark@gmail.com>, 
	Denis Benato <benato.denis96@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm: panel-orientation-quirks: Add quirk for AYA NEO
 Founder edition
Message-ID: <36odkas4clex2azzseubqt5r6mby3ocu55lrwd5hqhvzfeo65h@tnonocnpsgo7>
References: <cover.1726492131.git.tjakobi@math.uni-bielefeld.de>
 <f71889a0b39f13f4b78481bd030377ca15035680.1726492131.git.tjakobi@math.uni-bielefeld.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f71889a0b39f13f4b78481bd030377ca15035680.1726492131.git.tjakobi@math.uni-bielefeld.de>

On Mon, Sep 16, 2024 at 03:18:53PM GMT, tjakobi@math.uni-bielefeld.de wrote:
> From: Joaquín Ignacio Aramendía <samsagax@gmail.com>
> 
> Add quirk orientation for AYA NEO Founder. The name appears with spaces in
> DMI strings as other devices of the brand. The panel is the same as the
> NEXT and 2021 models. Those could not be reused as the former has VENDOR
> name as "AYANEO" without spaces and the latter has "AYADEVICE".
> 
> Tested by the JELOS team that has been patching their own kernel for a
> while now and confirmed by users in the AYA NEO and ChimeraOS discord
> servers.
> 
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

