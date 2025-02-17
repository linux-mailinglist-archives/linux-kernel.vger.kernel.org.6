Return-Path: <linux-kernel+bounces-518313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09483A38D17
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7CAF1894CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FA32376E1;
	Mon, 17 Feb 2025 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tl/jTqBI"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D5C207A06
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823380; cv=none; b=DyJ+9wE9EtrTeALV5H6o3y3+Z6Q7gTBg1U+yaulHUFRgcZgCAn/Mz0QJrINmxUrG/phEn58xmVrZ4tT76zPZQykrlQMNGmf14e6J8tULy0zqFl1eBBEB7kXWk5sMzft0eXKk/jD8CK8N/1iZVaE70W4noQ1jFdz0vyuceojTb8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823380; c=relaxed/simple;
	bh=V0Lqot8JKSyBwYOQU6bb6p1nCeWvLi0macdHeXkvibc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rP1BzkFBCzxv65v9iEOoqVF9Pz1PgrQZ2F+2iAeUSJsgDnZ/Ecurot0gPtZcK8bBV+ht3UR3t05E0f+BTr++cdWe3HarUrELLoE5Z8Pi61ZujAs3Jc+qHsLeekW9MO1uYJXIHxTGPBfjDDtGA7+yA4lc4J4TSVWZ3iQVzdY9v/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tl/jTqBI; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54622829175so1182626e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739823377; x=1740428177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tsTvGlAO2PQ4d2384bE8SL5TPdN0LR6pjGuyQRT05vk=;
        b=tl/jTqBIpQQbBMq4KxCUERRIj+sowJkCnwgFxcKtSdltUfhheNfMcbnZRuqRpVS7PO
         GADyOiC56c/XhO2XbHTD4KgDhz98I1Sg/UmRosRPSeK8lYN+3IH8zuuhp03X2Z0OdnP3
         Tr/CRPWi9jFB95eTdPK0q2d12fy8g7QLcS3bkfl/AgSY50lsoJZNaT8BcwfSBVU5XNHk
         CF7DeNRBGHWU9LI8AcZgkwV05Pm58NqDhw4Pl+nxQv8SXHnyr9LuoL4zzBfQLgSu7KSd
         Cw4PXTD/wdjbL2hDIMxQfKpCqTmagPEF6p9QJZuGEG/ZjSYWp6+afcYRK2vE79NorkZv
         VuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739823377; x=1740428177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsTvGlAO2PQ4d2384bE8SL5TPdN0LR6pjGuyQRT05vk=;
        b=mH7URojHO09Ove9xPH3r45aOn63WlSuz8lx91UkJIVYvaNE1q5vhAI9fRLKcXLYY7f
         QPcheq2FV9+aWTijCuNopdB2XtIn7LASXsdk1FgzCJ23UyglIbV73W666JLdwHbwWzs0
         CHW4MzcqgxPIKqBxKxbtXk18bhHPFVdrb1T6maQrXxceLo+4BaUx/A+Xn0Zp/Ps3fEeA
         utCtHo9r+p8IKybTDHef6QLxSEEkmDo7EJ3wpxgRMlhXwdQ/GmypkxjtupAY2a9Txs7A
         0Zfl3bNjerwsAxs7GqySYa2R9dTRguokvx485rzQxnPelNI2yV/Vvu0hwBMJc/sK3OCL
         YKRg==
X-Forwarded-Encrypted: i=1; AJvYcCUfb8aiEfdMs2o8Ms/QfHB1JhrGSb1IGfTYF47a3cNLJr03h5XMruvL5/KkHrhAUflN8Baes+rYwaLcc5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqHQv9bPB31KkVH1DzaUSh+P1VVDz9zUCkv0hRnyaA9Qz5I+VK
	xrz1+qkRWivh3R/IIVjkNeooMnLuSpaJeQcSPlhpLvcMmfAifelbB2ISb2GBWUw=
X-Gm-Gg: ASbGncu0f3prbKAiQ/v377M+KU2hLFPPH5KpiuiDsu9r/RXSd+Hv6MAiNkd5lVPBSpf
	m2ZJTgyMlbi9D4phg+Q3BHly7+6E1doiJeYZdedmhzuBnnsrloXGx6INlUJkB7sjCpQAegwhGmM
	uVTPS0Be5X4v+/SvciAVA/LtjB7Iy578sdQ6eAa+YtZ3DB3QKG1fwrY/1bYMrD+TYI57fTnjiMu
	9iXWnOscrpB6a283m3zKSd/s59aapdosSr+6+qcugXzA7jZ9aARZCYuyNM/03GDGFNQG7MCEdFR
	bS7PCkKc4h3BdnmZDbcHyaFCzXFe0w7Z8hy9pmOwF9V65zcPUC17UDqbltXeJdCr0ElCGjY=
X-Google-Smtp-Source: AGHT+IHTW2hidZoQgaJh6i18vKP0XNh1dEQr0uYfuvR6oJE5egXcYJYKmvUHeCYrFDjACBLMSRu1eg==
X-Received: by 2002:ac2:44d8:0:b0:545:3032:bc50 with SMTP id 2adb3069b0e04-5453032bc53mr2778480e87.19.1739823376711;
        Mon, 17 Feb 2025 12:16:16 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545d1b9c30fsm876364e87.15.2025.02.17.12.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 12:16:16 -0800 (PST)
Date: Mon, 17 Feb 2025 22:16:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Vishal Sagar <vishal.sagar@amd.com>, 
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Michal Simek <michal.simek@amd.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 05/11] drm/fourcc: Add DRM_FORMAT_X403
Message-ID: <njhratp6oy27walyo7qfvp6oucppqjj4ubr5xsofrz6chx5c4r@c7wrehjfvykn>
References: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
 <20250212-xilinx-formats-v3-5-90d0fe106995@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-xilinx-formats-v3-5-90d0fe106995@ideasonboard.com>

On Wed, Feb 12, 2025 at 04:56:09PM +0200, Tomi Valkeinen wrote:
> Add X403, a 3 plane non-subsampled YCbCr format.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/drm_fourcc.c  | 4 ++++
>  include/uapi/drm/drm_fourcc.h | 8 ++++++++
>  2 files changed, 12 insertions(+)
> 

Same comment: is there any other name for the format?

-- 
With best wishes
Dmitry

