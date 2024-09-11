Return-Path: <linux-kernel+bounces-325549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D951E975B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E839282C83
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E921BAEE7;
	Wed, 11 Sep 2024 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWxHB/r3"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6631B29B9;
	Wed, 11 Sep 2024 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084707; cv=none; b=sDH+LwxeSJWKuWBE2ZLcGhrw8+m19kfRJOEp6HmWk6lse0Wa/GrctpNZcU5Fi1X3uz191mj7VaFtRdCgdmJAMUhpt6M4UfJHTaObvGtlYbc70IyqL/nbiE8TOs9nZ10aV0wqHIIYm1GqI+Lh7pzw/Gn5OeAuJcyQ7dYMSSqzmg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084707; c=relaxed/simple;
	bh=cuo+Ab0F3h/WKKF62cL6hLMg7drrLaB+lr1boXPR4j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubeu9ExiUlY4TN/U8NzfV+dSxmJyE3XPu+bcBYseT2/YCPlo4pz+7zDpN4O4IJY2eEG4M9aUTPtsal83WtAH8siwdRxdIYHdSRGiU0upDMiaGRxQ8FG/jFD/MrcHtieNbridXcXHk5jOcENfmC1kxSW59KK//u/97ky4qJT+M54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWxHB/r3; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5dca9cc71b2so125749eaf.2;
        Wed, 11 Sep 2024 12:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726084705; x=1726689505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6MQd6zL07IoutVU1fDbtyULwQg6ZCsqi+BW9kHA0xKw=;
        b=WWxHB/r3Mw0zxwqO9NuzvGOt6C1AQZp0mOjv02ISAVNUKX3pE9MMl5/I5NoSQfE1Mw
         DOchjNop3W8Xh35/ptw7pl8p/RaBQQQ0k39A6q9gnyDWaemigMIswPcHVtBvvnB1QS0V
         HwxS/1h/FAuVV5An/CzBsPoDO6mQ6D3rEigITBuvoMDHIwmyYLCqfxaaCS6F5nsYhh+0
         j1JrK0A5orvZ+8OwX5YYAzdqt/PgcNmNaab+0R3MMOTOLyBFvzm89zCtZJ0ublTlAJWZ
         UNbcfelFQH3THt1jiyH0keKTbmvytg337j4y9J6n1nd2i/mRGv7O4Ydq7gOk3yWGVeJU
         JX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726084705; x=1726689505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6MQd6zL07IoutVU1fDbtyULwQg6ZCsqi+BW9kHA0xKw=;
        b=hXX8+7fNh6mGzlLSvIjIf9VlT0LfqY2SRyVn0bkEPa1UNGiOnD9ZShELWzf3MJdlnO
         utG+OhC3sCHXzPQIEELXLz6WYbg3Iz1UUedDW4jHF/MzrWu1OWTNWvaltJbyh07qUhg/
         R8J+N41UoKcDxuUitmrj3Vvg0DVd50krrPFJ2zGECjFl1+VqZU9RK0emcFsEIb7PibaL
         pKFUpmVbDzYuI2ZK/v8tBZaJEuhaH8TPTW4PNc4GpkD7XJsaAmIoJjzEVZG5M6E6f9nk
         oN/lQOPegGcptOZ3EivMbn6nUIxEWSj5OchrF1667GxL2VGqAgMxO8cFAORerxde+tN/
         iNJg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ7U9uGBLbL6pXhjLtXONq5Kx9l+VEBuOX1Hzm/KeZ1HZEixrnEiz19jV92KJtRo9JtDfyNgUSWshqLAxc@vger.kernel.org, AJvYcCXUSRYFOkBV9L1Zd4Ep6lGpMfCda1BZYHItzz4+SJANW0XHXyuynYPN6tKrJNl5UhOtVYlOl+stVJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1h/vO23XxtWrPS79U723n+ItYDpWp4C1wdV8WBK6L8nWbMQz3
	FhgCSkdQk4kBT53rWFpo1HVAKbkgNwpf67mr3JC9RRNHs/8LiTi5
X-Google-Smtp-Source: AGHT+IEwmGHz/Hn32YQLgFp/649kiwG88rntRYf3UqVhKCBm6JPP9CC+ky4B0i/pFb+QRSn1ulsjgQ==
X-Received: by 2002:a05:6820:2294:b0:5d5:b49c:b6f7 with SMTP id 006d021491bc7-5e201452599mr308595eaf.7.1726084705088;
        Wed, 11 Sep 2024 12:58:25 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:dff5:4180:2562:4c1e? ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e1bf2f587asm2210819eaf.35.2024.09.11.12.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 12:58:24 -0700 (PDT)
Message-ID: <676af629-af53-4cfe-9362-f844a6e3457d@gmail.com>
Date: Wed, 11 Sep 2024 14:58:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/display: fix kerneldocs references
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20240911-drm-fix-dbc-docs-v1-1-ae5cb82fce1e@linaro.org>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20240911-drm-fix-dbc-docs-v1-1-ae5cb82fce1e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/24 05:16, Dmitry Baryshkov wrote:

> The commit 9da7ec9b19d8 ("drm/bridge-connector: move to
> DRM_DISPLAY_HELPER module") renamed the drm_bridge_connector.c file, but
> didn't update the kerneldocs. Fix that.


It did not rename the file, it change its location, so commit should be
changed slightly. Besides that,
Reviewed-By: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>


>
> Fixes: 9da7ec9b19d8 ("drm/bridge-connector: move to DRM_DISPLAY_HELPER module")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/dri-devel/20240904163018.214efaa7@canb.auug.org.au/
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/gpu/drm-kms-helpers.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
> index 8435e8621cc0..c3e58856f75b 100644
> --- a/Documentation/gpu/drm-kms-helpers.rst
> +++ b/Documentation/gpu/drm-kms-helpers.rst
> @@ -181,7 +181,7 @@ Bridge Operations
>  Bridge Connector Helper
>  -----------------------
>  
> -.. kernel-doc:: drivers/gpu/drm/drm_bridge_connector.c
> +.. kernel-doc:: drivers/gpu/drm/display/drm_bridge_connector.c
>     :doc: overview
>  
>  
> @@ -204,7 +204,7 @@ MIPI-DSI bridge operation
>  Bridge Connector Helper Reference
>  ---------------------------------
>  
> -.. kernel-doc:: drivers/gpu/drm/drm_bridge_connector.c
> +.. kernel-doc:: drivers/gpu/drm/display/drm_bridge_connector.c
>     :export:
>  
>  Panel-Bridge Helper Reference
>
> ---
> base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
> change-id: 20240911-drm-fix-dbc-docs-8ac42d0c2e4f
>
> Best regards,


Thanks, Carlos


