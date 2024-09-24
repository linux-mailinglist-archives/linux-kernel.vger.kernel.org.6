Return-Path: <linux-kernel+bounces-337778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBAB984EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30421F23A93
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0875146A83;
	Tue, 24 Sep 2024 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzz1JR+M"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810271482E7
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727219828; cv=none; b=T3Q5HPeDlRO4QAMaTHcz8Cst8pAV5zLsoLfoXMNDxsUbTylhvaZ7QBou3+ewXNMLNdN6zsH3Eh3fHm7sWPM3Aklt2fJhv9UMJfuzIVBfCeXg2BfFRx53SqeHbbC8Q782hDzwvsNEIhmemBSRHEXda9NFkEF3uAECSdk2xDaMKsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727219828; c=relaxed/simple;
	bh=abFS+qOb693DHKb9vQHqbR04KyCJ37Hu7oSn0DtHcYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hM7exQhB9TYKUIjuP1AQMIC4a7J36bN6wPDQHo6MZnHiOS+Cnzb8F7w6GPRu/W7ojSX1PVxVPc5x3H0mnZUFRB50nbqwl0rjWIlYph3F44pgHwug3aPfsTFzuckv1TfbOl++KxDhwX57t9bcJJNy0ibZRSyhVb+ihg/6Fi12AHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mzz1JR+M; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f75129b3a3so62356811fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727219824; x=1727824624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amf3q/K5YstY5wPuuYpFOTakoTT4hxs6zudXgHWSQJk=;
        b=mzz1JR+MVJdeWIvgFH8QpNWoPx9m4z5VH9ocpanhHhSklGno2lj7fHo7oNlwkUu1lY
         qOBs4OX3DfHBCLiV7cfStGZFBpMbM/eQPW3J2FncY5vqUf5GAk9YvG6qLWN7VSaOfavy
         HA1W6NOsyc5Zr81uYT314UFHQoUSDwPrujSROeV/9p+cx1ge+1CljSMRONeLl21+1N/d
         4ORxvDC2Fp3sSb9Hc0wLQioqdGuGxZy8/+rHcpd7M4WjtkRgNwywpivBk08fcbwWkeO+
         +GBAZ2CfAAgKoZK1tbAW6qwfiDQrfzIbOEzYlY7iAs/Kp0ku0+c8/h2iO9XfEmTR01HP
         g8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727219824; x=1727824624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amf3q/K5YstY5wPuuYpFOTakoTT4hxs6zudXgHWSQJk=;
        b=izvp1VoKkKlmNy7PIlmAGECCbjCRN/62hcTqEhAzVsvs8svJKMUXRSX1DzzGsnDZ05
         q+mwlsadSsFlSy2c4bYmtF2ZiN/ZVLEKn5BeHXUPGFkivHMWbor/jp21z4JdAQOU8ea1
         cq7FZ0he7NM7zM48gnmVGVJSxCUxS0BLycM74B2AumtkH6tLkqDLcnXZ3FGd0eeTrLLG
         rARwYyL4FEqQuDXWv6G+Yt9KWP/B7zmDQh10EL20qd5Qyi4jh9j5FBDeA36GZHHLcWKG
         fZDuBz6hLQ+/rLXR767ZViIvy81L7KmNK5XufGK7o8O9wo2X4vJyOFDYh5S33jrf3Mt5
         UFxg==
X-Forwarded-Encrypted: i=1; AJvYcCWgiBhqvplSusQW3uVGEWXl3O76FJ6cNgrRKaqJh1mMHpKouNVKeQuQPNgbYMgRYIzvRUPzwjD+BapbPwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx56uH2cLoRhMzhSdjw+otGFhDZO3iO4Y/6miuXQKUQkbEeY0ZU
	s4iJ5ljOhbf/QGGXp8uMgD1irxlGDGDjQZwVPydUX0WoHFawAPQtX/2nzE+ofe8=
X-Google-Smtp-Source: AGHT+IHrcqwe5Lj4ifpe/VvN6Ok72x0l12WG1jRQc+gjBjBJs2YI2Wo9HDUJ71yLZDgpMhF1y7Ff7Q==
X-Received: by 2002:a05:651c:50d:b0:2f6:6202:bfd5 with SMTP id 38308e7fff4ca-2f91ca426e9mr4371961fa.34.1727219824482;
        Tue, 24 Sep 2024 16:17:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d282ff00sm3383631fa.25.2024.09.24.16.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 16:17:03 -0700 (PDT)
Date: Wed, 25 Sep 2024 02:17:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2 07/22] drm/msm/dpu: Add CWB entry to catalog for SM8650
Message-ID: <w2af6gh45xiw3p3iruqemftdysmyv47cxftogalvs33nrad5xt@e5jrv7bk4adl>
References: <20240924-concurrent-wb-v2-0-7849f900e863@quicinc.com>
 <20240924-concurrent-wb-v2-7-7849f900e863@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924-concurrent-wb-v2-7-7849f900e863@quicinc.com>

On Tue, Sep 24, 2024 at 03:59:23PM GMT, Jessica Zhang wrote:
> From: Esha Bharadwaj <quic_ebharadw@quicinc.com>
> 
> Add a new block for concurrent writeback mux to the SM8650 HW catalog
> 
> Signed-off-by: Esha Bharadwaj <quic_ebharadw@quicinc.com>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h | 21 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h      | 13 +++++++++++++
>  2 files changed, 34 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

