Return-Path: <linux-kernel+bounces-275169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6305594815F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5202857A7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7503E15F3F2;
	Mon,  5 Aug 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aQq2BD20"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36681620
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722881004; cv=none; b=du+LVmxB2qPfZu81S817K8J0pdfSbifRTXVIZT9m/Xh8O7S/UcJZqcAlyOHtIHDWa+nayb3rS7Oz7GF11oaVttH7nXIVGHSJIDa9rAkNQmoTskvk9TQJsLtKDzje0wJY/FaDPGEET4PnfWhsTQlnuhrSTVpnirJ0bXznA0Babck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722881004; c=relaxed/simple;
	bh=zQJfkVz+yaJ1725VvmNt2k/gjCOzdGbyVW1dMa6XVg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QE3wbnap3mf3p5tKCEru13bpKNkCUk8x1ZEcaNckGU0Nge1m/hnA2bvwRF5y48vLsXqO5KoQsVJUGftFVEmFOyJn63XMT36c97E3XympqitHNJa9rdECHYDfvhAXusCmvqjJ8nx6R8c2Iikzt5PLz+bTVhaskaWgAoqqu8Ja9z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=aQq2BD20; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a7b7229b8aso4132a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1722881001; x=1723485801; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=88BvRd35V/OzPhdKOSQqndCPusN42hnrznZaISah2qc=;
        b=aQq2BD20ybIp5rPjRKf90yPtWuGAihoBlTr2Ba2Ta7Ro98+nqEghsiaRdVwP0G/+ho
         Sg8WkD9TDG/qa2plTH1HRsVJGUvByicXbsKPp3RB25UgUyRPnOJ/cLXckUp6rng2F+UU
         sD1vcYnavfmzty3l260i5oMvLSy9g2kf7PAdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722881001; x=1723485801;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88BvRd35V/OzPhdKOSQqndCPusN42hnrznZaISah2qc=;
        b=u8q7M77CKsRqZmfaq7g0JMIVZIhyHeODkOdFINKHUaq9RqGEUbaAK2FlsAfItV5EyQ
         dPR0zWHUCmNznc+vySyohWBhX0VO2Qiw3mz/G3O7D/RV5ra9q8qJJ2tr/LmLGGLKIrfN
         GfNlIPls6dlUlleSbhE5ed7VJgldRjgy2Q1KUtBUR7FAd4cead+2p5+me40Zf7FtAKjU
         5jVFf1ByTtci0AxPrzna0H88zWrjBffn0EenTNBVJlzoYSa1rnBBBsi8oam4pVFgaaNb
         DjUv37rvmHg4t3xM8LHvF+eeg0YsKTd1dsH++pEuhIhD3SJ5yK6YDEHHJloX3ktvODUs
         hDxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOFzr9IdysLow5v1NwjhltNm+jAGxa9IWO6bDtAkfR1zk4QLQz3RU5Jn53qCbwymoSkpiboV087IXj0RCUdq4CP7e6JdwjRWxVLCNz
X-Gm-Message-State: AOJu0Yx74Lgnyh2RPV5pIWifawsG7acRj6kjVdunql8M4+T6TnWjbggC
	g+kMmSbarORA7xoOp+DFpPM+ZOL+BUilsqtgJwTg5kebUxTLd17xstNz/ZX2hDc=
X-Google-Smtp-Source: AGHT+IGdpz/yYrmGFTQMOGtgTZn3Z402QM4zK/U6N+5QV3x/wA63dYI2Qhmr9ppi70K8/k0WlBcuaA==
X-Received: by 2002:a50:9308:0:b0:5af:c82a:7f64 with SMTP id 4fb4d7f45d1cf-5b7f61a9c92mr5442785a12.5.1722881001130;
        Mon, 05 Aug 2024 11:03:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ba51da9c41sm3305453a12.36.2024.08.05.11.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:03:20 -0700 (PDT)
Date: Mon, 5 Aug 2024 20:03:18 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/connector: Document destroy hook in drmm init
 functions
Message-ID: <ZrET5jlPptivP6T2@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240804170551.33971-2-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240804170551.33971-2-jose.exposito89@gmail.com>
X-Operating-System: Linux phenom 6.9.10-amd64 

On Sun, Aug 04, 2024 at 07:05:52PM +0200, José Expósito wrote:
> Document that the drm_connector_funcs.destroy hook must be NULL in
> drmm_connector_init() and drmm_connector_hdmi_init().
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Applied to drm-misc-next, thanks for your patch.
-Sima

> ---
>  drivers/gpu/drm/drm_connector.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 7c44e3a1d8e0..292aaffb6aab 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -426,6 +426,8 @@ static void drm_connector_cleanup_action(struct drm_device *dev,
>   *
>   * The connector structure should be allocated with drmm_kzalloc().
>   *
> + * The @drm_connector_funcs.destroy hook must be NULL.
> + *
>   * Returns:
>   * Zero on success, error code on failure.
>   */
> @@ -474,6 +476,8 @@ EXPORT_SYMBOL(drmm_connector_init);
>   *
>   * The connector structure should be allocated with drmm_kzalloc().
>   *
> + * The @drm_connector_funcs.destroy hook must be NULL.
> + *
>   * Returns:
>   * Zero on success, error code on failure.
>   */
> -- 
> 2.45.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

