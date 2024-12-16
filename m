Return-Path: <linux-kernel+bounces-448296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 452149F3E41
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C5B47A3E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECDD1D45F2;
	Mon, 16 Dec 2024 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFEFus11"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC7629
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734391944; cv=none; b=YHwRR/f9nUg9lvLQC372jXd2TKH+YHYbyc4mJ5DWE9fV/GgmWa5r+tHuu3ZjIGZZNPwdGhzyTh60shRLKiRB9+72446gFh5graQ3cI6PJuSLL4nXLQ/MUKkWHkwXsFPUzC6JmEKuF9yGRjQL3RpVQHSnvZLkHEeTi9ATKJKQDP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734391944; c=relaxed/simple;
	bh=OFzAWpUBVPG3yhsq+UeZALU9az/W4KdPW+2DupIZCYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmT05IAtUC1NjRkyOmESyzjXqLOCo42bEOdopGcMwG0o7F0ffrwhCYu0YBHdTK1THLcAVgCpEOnagEoV7z7krnYqzw+tPWy5+Oj7tCQAxIeWc9wJp68ja8AS6e2MS6vaCC0+6cnTUt9bk6+Gq75XBDdmui1F5MasKe0aNOquuqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pFEFus11; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30167f4c1e3so51300051fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734391940; x=1734996740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Cfk/7g+t1GRw1goaFtL/LZY8tayLYomKg/dpZTcZpQ=;
        b=pFEFus117mUNyhE7qHbDaUQCa3AV3rDLseJW/hcmotLeNrGiiz+6Wbm6LTzB5lWOZw
         CvLY+GZBjZK05oUL8dK7Fx7uRxyM45gxrVXYATKjQxqANvUilkw7tc5PMm1oGjKrwFb2
         fATy+iOCMhi6o/1Ifg/YvRNpWVtb+DxSZ2AY4RGF/72a0EINNT3/PcihKqSFcXtvz479
         w20Xy8xIK/v5Ti2kjJI222+ab/U0WJ7feIyNb3UesM87g9FmyKvwvVg19RCi7ItGVu9h
         a0aog4k/BgdAZDCgdu2Lnlc7TpCUapvLkUUzbd1ITU31fdmwuVkEymsqNAjtViOUeGgL
         SYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734391940; x=1734996740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Cfk/7g+t1GRw1goaFtL/LZY8tayLYomKg/dpZTcZpQ=;
        b=bikrkM4N0+wYKLlEXwwlVqMIo0cNwc9WEAvK5vF7mI789r/NdhsDOdHAoOriI984Q2
         ia6G9VWzX9U77V9yfAXQ6y3De6Z01GUGrAgaYzuCjYkTvdknueLpjabpMZfqwLKd9MNE
         y9Ado/ZG9k9b1GA6A76AdeHDwwxRDdKP5lyXOnG3YTNlw/UKkr5Ibaoo1nKXcvsha9n4
         gkeCeipiQ2i4HNjwjtmqKnWByOv0l4zlKovLYoXfv60xBB0KPJ/rIkBOCSVuUQSUC6u2
         q5tFNF1wa6IsuB/BmA1J4PWaDF1WVKX2AHpEvoffcd5jcE6CCJNY+EUbi6yAxoPgvTTW
         knoA==
X-Forwarded-Encrypted: i=1; AJvYcCVGu46jyN7Wk6mpuVORLbpFO7Bb1PQYDUlLyDE6msPSlQwampg1bzbntTOJ7EDL9D486d4W55w4KPuDV8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAEcgt/a6YZ7UwgbW7Fg8EvbTIDiJrMKTJyS10AWtJcEIg4UiN
	fME5lz+hovTJ5rUsmxbPMyJlXIGGOKUFybtjsWnOzXlNbhc9Ik6uT0oqq7iUNO0=
X-Gm-Gg: ASbGncuHuvS8jKSlRFaQqTjUCGuOEXnZRxN6xbAfwXFnOfg7y4H/JrEzuy3qBPu52WP
	4r12sgkVab8hHPjFhZAxWf39oPIupHXhB3GJFeeclfBkrDUH5q1GptZlFVuceIz/dWydUelMDln
	0dFr/ZG50CdJ8v29JrdcVi0ntOq4culsFplXQsP/x2zMpJYt/GgeB1cWdZ3T4niYrjr1Dbe9Ad+
	36Y9LdDHuImaUwU3oe6NYWfIjxn0QXtozLWB1sdhkcqoTe6jTmv0tZ6cOS5NOSyBEHS27IZZj30
	iZrZxGvWNzcl9b2GBYqks2fCtRH+la0Me12g
X-Google-Smtp-Source: AGHT+IExbDP4ZD+38wPFlh6U/Y0lAF16Pi2yC5D/nYasWPaCFGvjIV4X6v/981M69tb+UUwL3mWvhg==
X-Received: by 2002:a05:651c:995:b0:300:1947:a28c with SMTP id 38308e7fff4ca-302544b12a7mr59678521fa.26.1734391940315;
        Mon, 16 Dec 2024 15:32:20 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344046c9asm10636321fa.50.2024.12.16.15.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 15:32:19 -0800 (PST)
Date: Tue, 17 Dec 2024 01:32:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge-connector: Prioritize supported_formats
 over ycbcr_420_allowed
Message-ID: <dn625hkcujqlre74wu3hezlcbkxza5urydgcl3kvs3exbr4tl7@rpznp2zefpoe>
References: <20241206-bridge-conn-fmt-prio-v2-1-85c817529b88@collabora.com>
 <uw7uqw6zsmoe2cyxe3mqm3ok43afut47jms37nny6ecl44b5xe@byagwnayplse>
 <d1fe66a7-c495-429d-9908-6f4076a994da@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1fe66a7-c495-429d-9908-6f4076a994da@collabora.com>

On Tue, Dec 17, 2024 at 01:17:48AM +0200, Cristian Ciocaltea wrote:
> Hi Dmitry,
> 
> On 12/10/24 3:12 AM, Dmitry Baryshkov wrote:
> > On Fri, Dec 06, 2024 at 10:00:46PM +0200, Cristian Ciocaltea wrote:
> >> Bridges having the DRM_BRIDGE_OP_HDMI flag set in drm_bridge->ops are
> >> supposed to rely on drm_bridge->supported_formats bitmask to advertise
> >> the supported colorspaces, including HDMI_COLORSPACE_YUV420.  Therefore,
> >> the newly introduced drm_bridge->ycbcr_420_allowed flag becomes
> >> redundant in this particular context.
> >>
> >> Moreover, when drm_bridge_connector gets initialised, only
> >> drm_bridge->ycbcr_420_allowed is considered in the process of adjusting
> >> the equivalent property of the base drm_connector, which effectively
> >> discards the formats advertised by the HDMI bridge.
> > 
> > I think this should be handled in a different way: during HDMI connector
> > init verify that HDMI_COLORSPACE_YUV420 matches the
> > drm_connector->ycbcr_420_allowed value and rejects incompatible
> > connectors.
> 
> I added a 2nd patch in v3 [1] to perform this verification on HDMI
> connector init, but I think we still need a proper handling of the
> inconsistency at bridge[-connector] level. I simplified a bit the initial
> approach, hopefully that would bring us closer to an acceptable solution.

I'm sorry, I first commented on the new patchseries. I think that the
second patch is enough.

> 
> Thanks,
> Cristian
> 
> [1] https://lore.kernel.org/lkml/20241217-bridge-conn-fmt-prio-v3-0-3ecb3c8fc06f@collabora.com/

-- 
With best wishes
Dmitry

