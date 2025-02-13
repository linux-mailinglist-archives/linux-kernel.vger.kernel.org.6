Return-Path: <linux-kernel+bounces-513463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65055A34AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01314175614
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9EB241664;
	Thu, 13 Feb 2025 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s48LYZHM"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7482723A9BE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464637; cv=none; b=dYn4AY0nCI6cb4/NTSx5jPaX5wIsS4kfJPd2lySnUcWG6oM7UjesaE9yEVhgTgvoRgr4hZ0RSX6u9l7/JWqfOBKi06JV3UwqcSq4+QJjx/l/3RnBBYS4YUfa3YmBeW5aCAnHv5NP3eqXzcFBiIYlsY9uqQO7Ld4x7+7xoHwX2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464637; c=relaxed/simple;
	bh=GmAGQpoza31CoAWCZS5s5yqCPDGiX4VXEioPVpXUPG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCQTMXpLugnD4B2QXh1TSXF9dOT7WQo430ReNYH88xqnwAS1tgYvYw09FAgHpNAMfoSNOsTOCs3xnMPnaSPnHbby/1Uqi1Kq1LLoUDkKa7iLlyxgmdiuTDdYESH7gx1a0vhaeJ559VCC6oQuxsuEposRG73SVORWClddDJo3ZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s48LYZHM; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5450408455dso1178890e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464633; x=1740069433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5yI9mtbA6TbP9BSYi0Lu15w4ixyZW4/1lyfqxBYhqc=;
        b=s48LYZHMpI/i8Q+prVZR6Bczow/uwoJt3fiF+COzbXvQ8TGPetye+x6AP2wwTtgBEW
         hjOmSLTwfoWbu39nrACLUypwvO+NSW3dZglPGw6YV5JzMjHfmJN5t3SQgvrstPSE9fGU
         A8NM78ZKOXCfcstKtRRi1hv5Bxv+dX9fVAEKX+4k6ZW8nsCUbbRPJIznLKOub9LqA1sB
         kaikKA1/CZONhmO7hEezllhpsEzsA+H8GePoCJQPCuT530RN6cQYhuKq55Rs36VQ2wwP
         R69B90rlU46EMXWLbMUnvKc3dDntHi+i+92waE9mdkJrJzCreD6LFFj5ctUvRCzUoNgo
         KRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464633; x=1740069433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5yI9mtbA6TbP9BSYi0Lu15w4ixyZW4/1lyfqxBYhqc=;
        b=CxqOhWtpUJoQZXV1/feA7nW+IP9M/tvUO4sxYbEnBvY19YjhX5qyCt1NAJo+/RFeh/
         oDyHIlUjH8cVdaiUqrg+Uixn8JRffHyvpe/DbVfV+Xshe6OLedTYqzCtYLBwphgdzDiF
         1T/tKdeWdaKEUxznVNY4JBfckyAonAvM1SfsdsPMSxjlXPBzLWPw9WA1mwlf4/wE2LWe
         CxqSfy1tZ4qepZPs/ODb8YWpNso57qDbkiQoBHwuLyEll+oDIRdKrk0WsJAFOU6Jwui6
         oL8qlbOah/EBmMDY6LW/BP95KlOxSRm0AwvpFS2KwLuldwhyqqvJ6cOxXW3yMo3LVkfC
         OXJA==
X-Forwarded-Encrypted: i=1; AJvYcCUhECVa9mN9Xr/aJv58cformOG1KKWrlbyKAnk1koiRizSWWRXqX/yG15KQ6LHs8TI1AABOTabKCe/nyhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybJUWsRyEUf6KRvyrdi7dX3Sib4JwwVnq/UGUx/ZZIOAM0hZVV
	gCao0YL/Qi0vTBPRlbWFBOVUgrqTVxETB+ScxfBxtu0lmpHxpAo+Kl5yUWBexM8=
X-Gm-Gg: ASbGncslTGHvwWoYn8o9+uNNAg1idMPruBtk88CnkU6PCpLr6C90Hq/bunEkS8Eqg4V
	l452qX3QLsu2m+kPmG5wv28PdQul3wGeVwHOsaD4KKQapy++wBkM1F+9kHBAh2Lit+IBzEsZELm
	2kAEj3pjrOzO/LdwJFJxKY3eIJBdpEQvca1hzwaAb68ceodZlClDjQxemGLL6yp68TzyWv2efs/
	pkHEFzj6UoWmn5cGNVwXsq7boIXbaQ1F45b+Pesics4ShmNPQt3DzhbY3hMZh/zCuJkGB7SinHI
	rORejyyo08uqYW8u6y/HRo3ZhRTIG/HWGp/iY0oN4heV/Au3FMaBemFMwreviH4RC75LUeQ=
X-Google-Smtp-Source: AGHT+IH+q3SO0AlGiFI6AM0BmNsLF/QARW+Zixtb4EjiMyrDyQLHtQ7O4U+e0SrdUEIxNCY9ztY0GQ==
X-Received: by 2002:a05:6512:6c5:b0:545:6a2:e56 with SMTP id 2adb3069b0e04-5451ddd65f0mr1158897e87.37.1739464633491;
        Thu, 13 Feb 2025 08:37:13 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f105ea1sm213021e87.124.2025.02.13.08.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:37:12 -0800 (PST)
Date: Thu, 13 Feb 2025 18:37:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 35/37] drm/bridge: tc358768: Stop disabling when
 failing to enable
Message-ID: <dsccxyorddnhjiff37zxmwh6mwerwtlabxxp6csugomalsgfwv@mfnsky7pacha>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-35-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-35-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:54PM +0100, Maxime Ripard wrote:
> The tc358768 bridge driver, if enabling it fails, tries to disable it.
> This is pretty uncommon in bridge drivers, and also stands in the way
> for further reworks.
> 
> Worse, since pre_enable and enable aren't expected to fail, disable and
> post_disable might be called twice: once to handle the failure, and once
> to actually disable the bridge.
> 
> Since post_disable uses regulators and clocks, this would lead to enable
> count imbalances.
> 
> In order to prevent that imbalance, and to allow further reworks, let's
> drop the calls to disable and post_disable, but keep the warning to let
> users know about what's going on.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

