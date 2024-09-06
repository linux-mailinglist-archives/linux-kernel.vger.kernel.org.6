Return-Path: <linux-kernel+bounces-318289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6AC96EB2E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E68DB234A6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C14E14A60C;
	Fri,  6 Sep 2024 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWltAxui"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBB3149C7A;
	Fri,  6 Sep 2024 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605899; cv=none; b=ln9dfdWIJ9yfzrySU4iJo6oWY8IlpK86E8DG+YdV9n4ELQax9tZdXAeHtQksKZwaiC6oSzhexJJY4k30F4cf+F+mVm18NyU4EqzQrSPgWi/EpNu80R4849LEUScRwqbbAzNlblJ1mqyM8lXrII/uDI/y9NOyD/pCE1lixiyAZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605899; c=relaxed/simple;
	bh=AVKGfpSb0C6TrdSZvAWlJnBOU/FW79VvE5Q82ig1aS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l32nwoP1bYTxuVOulgKprcAEGJS28QxAa4i25VoxRpQu4DaP/3cc4g3tb9bE9osvTcEEM2iTRcVH+CH0vTpWzFFa5JYpGbzX0xExvlsVmJFuEkRelrB2vHcOSiIoo0MgZ6rsVqQyB+BJiJQlB+HDQJ73DL54yv1nIm6u2jdVbXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWltAxui; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4f2c8e99c0fso473998e0c.1;
        Thu, 05 Sep 2024 23:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725605897; x=1726210697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8N8A0s45H/VLtj9tyWVe0GkyJaEn5PZatiSoHaZgnbA=;
        b=QWltAxuiflrwccNouPeKjofkJmjbttREBURr/r7IU+D5fyKlQNMiRBJ/BNKA+Rq2nZ
         u1JhYre6NmiXjkNi3QuWgu7owX3ybmtb5ZyZ7ESe1Rn5URAsiNSjpkQphLxHMxoCuDnz
         5M3zrK1euRh4HcHKWXkUFOob4pdzKbmN5xiX9kwI/aHa5DD03JncOLHRT9R2g9Z1skYM
         1Zzu3EfQlu0zfOfx4dzEiwAzT2keRAhDSYeLRhGpYnOf9NLcBfsn4HJxwgIKavGvRAyL
         Dyr/6X7ds3foKAHgb1fVy4cQGPYlzKvXvxHiLlro9hQKSx9nTJiULYXYozaPJ/dY32kp
         2GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725605897; x=1726210697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8N8A0s45H/VLtj9tyWVe0GkyJaEn5PZatiSoHaZgnbA=;
        b=AbPU31aggokCSoRnEy8YpAULJi5uRw0PxCxIQVgiMG2q7Wbs4JGWqnFkxw867keKMf
         rJfhYcT+dIgOg6LYUVxxAIz4B1sxqKo5+4JZ2k6azdL88q2diO9/Q6uwiQ/isn+Vye6q
         PaSlRshHktDd2z3FmXr/yHajroYeqtOplp/HsuE/AQWt13hGl0BUgGhy5a79fwq9jrcY
         ZYhW/EJTANGJhPuu3H8/W7NgL29ZqE08Yzip3sqcnMY15qFUQ2/kCb6nBKj62LhqmCrb
         yDJ/661mOLkN3ZbjQ/uwkI4S5e1Frj5MQfaC9WWY9olWo3RvWbAtSnDIqLPe6VJ8XyUu
         6aqw==
X-Forwarded-Encrypted: i=1; AJvYcCU4zNuG3xXEn6EiKPbOzq0IYz45qowBHnkA2SjoJdTKygwnS2GXt7I/rk9EZMLs7aosZBvy7Y5702jG@vger.kernel.org, AJvYcCWtnXwX5Tv7aYTsVL8jpikCOIsqRGfJOp8c621Nl7daDRR0YMGb+5zFkbs76XBOopFyHdqcrDCBofq2nJ6t@vger.kernel.org
X-Gm-Message-State: AOJu0YyI6E7rPm2SZv7HIgw+EuG8sWqTvfTDg4C/gWbVTpZg3eN0b3RB
	ZPiKvC/ruk7Qn7ULaI+cckt03liF2iR51zSv7OasYwPLo0RinKFkW++0u3feqjhFjcFdTuWCVXY
	Z7RkpfmW2UpeIZuad99ZlTbWoAVQ=
X-Google-Smtp-Source: AGHT+IF1Fi/nDHguPritS3NX2mXODBmwKdzEwTEKlD8xdN4sfaoxulLn25xubO3nmPTVcNcapnLXl53HoDgmi4q0JOI=
X-Received: by 2002:a05:6122:915:b0:4fc:d9ef:3be6 with SMTP id
 71dfb90a1353d-50207af281dmr1797058e0c.2.1725605896653; Thu, 05 Sep 2024
 23:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825090052.22135-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240825090052.22135-1-krzysztof.kozlowski@linaro.org>
From: Inki Dae <daeinki@gmail.com>
Date: Fri, 6 Sep 2024 15:57:40 +0900
Message-ID: <CAAQKjZP+1xRPBc+tfJ735AtEtBWwiLThbi_-SA28cQs0G66LOg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: MAINTAINERS: drop stale exynos file pattern
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

2024=EB=85=84 8=EC=9B=94 25=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 6:01, K=
rzysztof Kozlowski
<krzysztof.kozlowski@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> With last TXT binding converted to DT schema, all Samsung Exynos display
> bindings are in "samsung" directory, already present in maintainers
> entry.  Drop old "exynos" directory to fix get_maintainers.pl self-test
> warning:
>
>   ./MAINTAINERS:7539: warning: no file matches  F:      Documentation/dev=
icetree/bindings/display/exynos/
>
> Fixes: ad6d17e10306 ("dt-bindings: display: samsung,exynos5-dp: convert t=
o DT Schema")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied. Seems that RC7 is already late, so I have merged it into the
eynox-drm-next branch.

Thanks,
Inki Dae

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 028186bb4e8d..c75918994a53 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7536,7 +7536,6 @@ M:        Kyungmin Park <kyungmin.park@samsung.com>
>  L:     dri-devel@lists.freedesktop.org
>  S:     Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exy=
nos.git
> -F:     Documentation/devicetree/bindings/display/exynos/
>  F:     Documentation/devicetree/bindings/display/samsung/
>  F:     drivers/gpu/drm/exynos/
>  F:     include/uapi/drm/exynos_drm.h
> --
> 2.43.0
>
>

