Return-Path: <linux-kernel+bounces-538318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C7BA49719
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4446D18830A9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D947725CC9A;
	Fri, 28 Feb 2025 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BwBr/a0c"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838AC2594AA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738154; cv=none; b=RabWXyEl6kI8iXFM2q+LMZeIKxpKkrUfTRC2knobW2i4CLPef6Sdirfazd32cuaoaTzZc9gRgJTQ4k3wNn9VYsxlTMho2DYFnpK3TL8ePzqSquY0MO4zcMMMlOylBSAoDpTGG275AXsC/9g1ToJf04OZqkiqL+auVpfp/kXabbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738154; c=relaxed/simple;
	bh=q9+IlSHTysuLXGwcVeT+yMYlF+AeEVla2PHoUzCEQdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtPvVyQnjeCGivjWHEsbgd4seukpw6Nb/UGMrwrxsBvuDhlpuBuyrrbV1YpA/YPqlnr2GvwrpQnF2edzVTX+15Ns1jOYyYKsr81veXXeJo1Xk8RQF+Imq6evB0na6skgbVp/ZFb1IG53O2C1e63+7hacMRCGYX4stLCr7ObS/kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BwBr/a0c; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30b909f0629so8433631fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740738150; x=1741342950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5R1GwEARUIu4D0vBS31y0VlPu/BaWoEI502D8t7cc8=;
        b=BwBr/a0cG27cv1nK9Vvt6KhjrEZG8voC8islMNiyaO23VpeteXmo++DGUZi8ZRsGjP
         izyMBWg8CKpmYsI5qRajp7ySmI3ByqvBFTA/hNy0drhdhHsuZmF33MynjkOrh8pCYLSJ
         rWcSbOYbJ/cpiD7e/jmULastMJ8Hpxrh5+3DqA9iwklu14tE67ftdG+t8G2LFRgZ/nhZ
         9MzBz12i6CsvB6LaCEbYWN67Q2efD3KJsN2lieUj68jtfXuHhKjxOYIyCGk0LigXK29G
         Myihf9Me9L3eeSAi8N9SBA3Oa96Xcp8awZka7rPe3vgwFD2ZwMxvRFNpy3Aw7xe3MYU9
         zPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740738150; x=1741342950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5R1GwEARUIu4D0vBS31y0VlPu/BaWoEI502D8t7cc8=;
        b=UtQNmUqB19EVFm+aZ/BNVfyhnX0fQ9b+7tu7ZRdiVLYMduzkfNbdufapgvY3wEs1oJ
         +qt6pW8jT9rYls+jBKv3ZH47cVHhu4n4jLxUyx1iF5gW6ZPudpU+BiXeqSmHr+xP6xiN
         +vNpSIY/syWf1+j9gfpEHJ8mJaXilOHDnZqwYgk4Qo7yb4wQ/Im35vIC/dMc4IIEJW3i
         sfZOxByQWV/dagUN2pNBBcaBxXAvlXLOOmzRR8mHdsc5djvo2e+UTwfracJvBEre33Et
         66litNyQskgQfOg+orRTgyLLDtBFi7h62j44fCVCJQy0aOQI7IjbiwTrzjvAANcGPGzM
         VZHw==
X-Forwarded-Encrypted: i=1; AJvYcCXklh5qxioK2NsV+pmplszZjltabnuOsXOMsk6g5rLDzYm/DH/zWiTvuZicRPh1YW+xGBh4sVRvPaLnU7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyTm67qbYBTrosaSgZP9V4FImrMpjs81p0N/TCEeItfaT36FXY
	M+sJDQhv0tSGgBGqDCWaRmC+GeXKReyvEfm6audwmKFvohQfILlNfl8lKuUXcC8CNFvgXHift46
	a3Co=
X-Gm-Gg: ASbGnctOx2jSvOYTyHdEvsriNEUODpy2m+uUbap0Fmmrdrbz834Mi6yM45RGPDinP/u
	8l5TP9OcDaDc7aGZV16veR18a9tKBE991dwdL50BDNm0XlpfO5KKoO7o5HORflHqneToa6DT58W
	2FE6WiA70KRreB9/GAWtNlCCbjo9cRU1O2N+Y3D4uKlmrkwZAIg38mR59wsCZyK7zc4IMuzPAKX
	KeKWuq0LHIdBAjAKZFssA32okJkUZJD/fn6RXr7640AVNirA1ySfmes46/LLN8IIHa4As4/cxOF
	eejDaZSG3Bp5gtwnXAzO5KRW84TJqHeGDiNA5/Y9lpiZPcLfXjyADv9FJdpUG7tLZyZTXXhUxfs
	TDv2Dlg==
X-Google-Smtp-Source: AGHT+IEcFPCTorTFbzvj3XxGZ+gp0Pdf9edgu6c5mZ8c9NQpwr+CURuqlRmoz1kSiZZiiCQv03r7hA==
X-Received: by 2002:a05:6512:3b99:b0:545:c51:4a03 with SMTP id 2adb3069b0e04-5494c125ad5mr998344e87.11.1740738150508;
        Fri, 28 Feb 2025 02:22:30 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494e8399c4sm197441e87.213.2025.02.28.02.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 02:22:29 -0800 (PST)
Date: Fri, 28 Feb 2025 12:22:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/connector: Fix spelling mistake "provded" ->
 "provided"
Message-ID: <57owgwkyiaxw7xckoug6tsrzk3g3z5yb74wp47av42rrvhxqby@tzr5aapdua4k>
References: <20250228085350.678446-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228085350.678446-1-colin.i.king@gmail.com>

On Fri, Feb 28, 2025 at 08:53:50AM +0000, Colin Ian King wrote:
> There are spelling mistakes in drm_err messages. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/drm_connector.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Fixes: c627087cb164 ("drm/connector: Use common colorspace_names array")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

