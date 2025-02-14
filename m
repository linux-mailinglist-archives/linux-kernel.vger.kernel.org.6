Return-Path: <linux-kernel+bounces-514104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DB5A35275
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 01:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D44B16DB64
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 00:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1AA3211;
	Fri, 14 Feb 2025 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9tDXlms"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14751853
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739491796; cv=none; b=tBHTQb3Vnsa+hkyLhtyHNZlNSCB1EhHVsKlpkjA0g4nnphqFkY07dkyDxjw05eacjARwbK8oeFqQDzXi54GLcexCghpDOrloOZF9U/qkkDzxuG9040cn7yGEZAGlwEt5C+S2D7idbhcSkJVNRAFj2G5Y6p1qWOprn8pVymUPhfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739491796; c=relaxed/simple;
	bh=lEZkR6Mx58pSq0zExuloJ9MtvWHa8LHWfZeVjgG9WZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPJtWXpap9TePvndZCq2Kpeo4SN4QCFRUeMWF/7bPWi3jI9O4W5gq1zGYz0MCaEY1gNiRRKEvKeuA9P2xFzHAx+LUOir8KxsfbeA94eIiiN2w9LZrl+MActh6CbFcqVS/xzg/sAEKXPH44SrzvGhIvX8G37ZOLw7wGVKhwsejvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X9tDXlms; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e5b32f64ffeso1469834276.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739491793; x=1740096593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqP9v9jg7baLiU2+93UgvbM9b74Tce3qrWwn1lgosFQ=;
        b=X9tDXlmsUsIQfkaNZDlkbTZOQ6yJZhTnEba9AZbqdWmtiAnd4eL5TS1OF04JD17+ea
         fOofewEVHOYcK02S5TygPLISQmY/3Uk4kcpGydKsR5TXMmFrvS7IrtDLD4vUFCTPH/F0
         PFOVKzmXj2kyXNCr2zvUlrRCHWY3AVzIos1Wif9ULHw/79JCkiQG+lqakWt9D/FyNM7l
         o+tExlNa0I7ciMuKBWs8Q4mxjQFiULrmRLSn8dKJ/qxM6IDnIzFDxL0mpoEpKtMtyKNl
         cdicpkLsAGQjNrIieya1OdDUovgu0jpQBKYWvOJTDaZ2ulvUuBZAG7hcvSX9e0cA3l05
         cXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739491793; x=1740096593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqP9v9jg7baLiU2+93UgvbM9b74Tce3qrWwn1lgosFQ=;
        b=TZ7tB5JGCpDUI0fV4s9ahZoWozmJusyyLIB/hCoyJX79XE4AaQB72fLBcxdw/yqMAg
         yh7rlB/272uYxBkJcufsiOxc30ww/AGjy4I7jljIgXbKMPS+FRWqbJ2NZDB8C1/A3OxQ
         /jQ7e5FcK+b7e0ZOYNATwUwB0KWR4R9GW3CCJziE16ntPwORVbHtwbFgjEiMm6/UWhHZ
         zsd32hQXwJ25o2qsBJ3CeanAe4eeeeG03TTV+fUX4lJGI9PBfMgHP7mXi8q7ayDOCG6l
         RkQY1SJSRE2tHWyGezlMjPiP917bCsSz7tjSR3uM6veksKl9U9qmyjfJzFrVQtFVSMJb
         WHmA==
X-Forwarded-Encrypted: i=1; AJvYcCUJSa8V5d48495UKWldzzsW2Tsxl95hMykfbNIA+q0qpKEikD9uZP3xYULX3mTJ8bGti13MSeh5tHpz/sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZW/M+L0H1r0H4CTXWFE/XsSWEXF8ZstHerJCV6DBXn46eA64C
	aerwnWCR0zg+HHJ7pyPddu9jfwae0JTiMCYHgMOPnepG/5yLVGwynSaoYWKnIyvBsKJvrqsXqdB
	chOqLl7r+qbfLSP517GUCOa6FCXNWlJ7VHKxMxA==
X-Gm-Gg: ASbGncv1mMgKSbI/mQJfidAkjlYgZq429VXyTI3l7NfOcu8ZBu/OHqu7W80ToHn4f2N
	wxUAvNVjqaPVR4aPu1afIUaS4RP2eGmhWQeakm360JK6tSzl0i1P0+uazv7x+Op16jt46R1W+U+
	H2i5jR8SbgS/c8g2jwPNFepzwm5SS0Vls=
X-Google-Smtp-Source: AGHT+IFd1EJtDVBHgzWdjgXFsf5jdNOMTYWQT9HHkgAZZC7VuvxH9RsRYnYxxoGtNZLN5u0QJ7cWcZkPmK0FyJYTFow=
X-Received: by 2002:a05:6902:13c6:b0:e5b:3f8e:9e65 with SMTP id
 3f1490d57ef6-e5d9f0f9e38mr9401293276.12.1739491792768; Thu, 13 Feb 2025
 16:09:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213204044.660-1-wachiturroxd150@gmail.com> <20250213204044.660-2-wachiturroxd150@gmail.com>
In-Reply-To: <20250213204044.660-2-wachiturroxd150@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 13 Feb 2025 18:09:42 -0600
X-Gm-Features: AWEUYZnCMGwjd-AHWAZ_AQIcjbuE5HV5DBnJ9ZGUM8sZFqDGixnVhaKZX3Cd9ko
Message-ID: <CAPLW+4=STm0=K8s+BTxiHWP9F_waw2H=fQ4W9_NTm7a4JcFy=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: samsung: add samsung,exynos990-spi
 compatible
To: Denzeel Oliva <wachiturroxd150@gmail.com>
Cc: andi.shyti@kernel.org, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 2:41=E2=80=AFPM Denzeel Oliva <wachiturroxd150@gmai=
l.com> wrote:
>
> Add "samsung,exynos990-spi" dedicated compatible for the SPI controller
> on Exynos990 SoC. This ensures proper representation of the hardware
> in the device tree.
>
> Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Doc=
umentation/devicetree/bindings/spi/samsung,spi.yaml
> index 3c206a64d..1d3c95bd2 100644
> --- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> @@ -24,6 +24,7 @@ properties:
>            - samsung,exynos4210-spi
>            - samsung,exynos5433-spi
>            - samsung,exynos850-spi
> +          - samsung,exynos990-spi
>            - samsung,exynosautov9-spi
>            - tesla,fsd-spi
>        - items:
> --
> 2.48.1
>
>

