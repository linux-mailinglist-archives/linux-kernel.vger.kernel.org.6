Return-Path: <linux-kernel+bounces-174529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAD98C1025
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D300D1F22B64
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19BE15250F;
	Thu,  9 May 2024 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VjTlr5tm"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6059213C3FA
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260197; cv=none; b=NiZdueaFdwgXsccKxeMGWTiAQVwtLxB+wBGxu61HYI1hFptEdctYgH21a/QX3FaMRfk2WO30Tyl7f9fRkk9XVu33X1ppOsLZlYpsmX3B0mSn66hwGwMwq2GAie1NoxA3L5Z2Ms22kdAKYjYlRVj386hYhbg7c238rKscJzGjUDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260197; c=relaxed/simple;
	bh=/2fF/U3Z7PezOWTE5bhHrvAmlH2qvb4NRDFXCcVuKn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V40YiT/a82OgZUkT/cKbeszsXZLhXIC6ROWS2rF2zBMgex6anXpRQKtIsxU6mGbUULh9+TBcNq6jku/xOKSPkjYIQ7IKDi8/3k7LKDqYv5yo5tuzLHioXSY/jjou2pkl+KggrIunud+BOQYvn8IbvyBXZf3QHZwmMdRnS0abBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VjTlr5tm; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-520f9d559f6so975266e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 06:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1715260192; x=1715864992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rjcbv/XOMrp8i6C8+I4UYZ+VlFPUeDdAPCf2dJU4itU=;
        b=VjTlr5tmkSJsfKfOjM14wYUy9lOqJxun3hhMfhfZATajFsYHHXPI337+a0PD8Iq1Ku
         3MybsepJeJxsoExRA4NLFP+UIRrYWX7CBvjPPTNq6lLKthgO3N7poafMySUS2oExF+b9
         Nqtn/bbufDLL2NxB2BrRSSU54G5jY8kP8MW/7vqkQGBbd1nlBx4p/8ouIrH3mEm8JC2S
         5fxIusC+V0Adt94jLWgrC2SjEZ3stRs5mWElyWWKmglp2KxiQzJ+5IQlz+QSY7vbAYLI
         T28Qh9LLGMRQg0zUhvcaFLCqJdk0CHyRKmJAuC+WRdStKGYNjK0cC5shjfsxAqJdo5hM
         JUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715260192; x=1715864992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rjcbv/XOMrp8i6C8+I4UYZ+VlFPUeDdAPCf2dJU4itU=;
        b=PSb9iKCMwTeJaSaqIJMCKAGwwIGzjycNT0a/M6cLcsAAYIQpVRm4DuxJYg74rAI6pk
         tkYNUDled324OqKj7374iyS0+F32NUjJOJsnAN1xw532GzvyI1q/uc7RLD8ROGRMkvCT
         UvIpa2g2YKCFVX8zJQHZRShXhmQQ/labnwEJHenLVjmIvuoTqK66Pj9MzjwzNl60fAOZ
         kcBgt33053ToYdD1VVrUwH/Ty0Z/x1inixESmKksDVdHtfjaW1Bb478IdfHk+2/cIRgU
         RKCs85zN31rVEPbnQvWFGJYZUHcZZpwurqK2hIo5kYTvk6ymfNoKJr5PF4/WJd8uJQvn
         PuAA==
X-Forwarded-Encrypted: i=1; AJvYcCU5FDXDh9SHzLkUfaFyaGjaQ7KDgOEwliG3ZWxmuXBK9z99aw8IdcWYPDdJVkb1inw6t4KV1fBs0PAQIfthnd9K6v3Cc/jE8/tgPbU8
X-Gm-Message-State: AOJu0Yy1GM2J0gRd+MrTYLsrAPwHGMeRcgU88QrToHG4DaQuCDGpXPXD
	3ErYq8hTFKNmijGzP9ty2mtNN440Diy95y7Zk80DY36vK0HKo3fdF2SmW3PEoDU8urzGJKJx3SX
	5m7i6/DIxxaF/9vXVIj1xnNkfiChGOgRYTA9oqQ==
X-Google-Smtp-Source: AGHT+IEpJlR5h7UDquPspWdgEA69rWukyGIDC5h1omtSQdQBKa/5ADlI4KFKOrwM0BJ/+Cr5u1yDz91SAFWv1jlBCEM=
X-Received: by 2002:a19:f00b:0:b0:51e:18c5:c3e3 with SMTP id
 2adb3069b0e04-5217c5665ddmr3092600e87.26.1715260192645; Thu, 09 May 2024
 06:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509104813.216655-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240509104813.216655-1-krzysztof.kozlowski@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 9 May 2024 15:09:41 +0200
Message-ID: <CAMRc=MezrXs5MYDnRvbWWskWJv0eCtQ8VsUu2mD=Bq=VxLHqHQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: ti: align panel timings node name with dtschema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, 
	Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 12:48=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> DT schema expects panel timings node to follow certain pattern,
> dtbs_check warnings:
>
>   am335x-pdu001.dtb: display-timings: '240x320p16' does not match any of =
the regexes: '^timing', 'pinctrl-[0-9]+'
>
> Linux drivers do not care about node name, so this should not have
> effect on Linux.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/ti/davinci/da850-evm.dts    | 2 +-
>  arch/arm/boot/dts/ti/omap/am335x-guardian.dts | 2 +-
>  arch/arm/boot/dts/ti/omap/am335x-pdu001.dts   | 2 +-
>  arch/arm/boot/dts/ti/omap/am335x-pepper.dts   | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/ti/davinci/da850-evm.dts b/arch/arm/boot/d=
ts/ti/davinci/da850-evm.dts
> index 6c5936278e75..1f5cd35f8b74 100644
> --- a/arch/arm/boot/dts/ti/davinci/da850-evm.dts
> +++ b/arch/arm/boot/dts/ti/davinci/da850-evm.dts
> @@ -65,7 +65,7 @@ panel-info {
>
>                 display-timings {
>                         native-mode =3D <&timing0>;
> -                       timing0: 480x272 {
> +                       timing0: timing-480x272 {
>                                 clock-frequency =3D <9000000>;
>                                 hactive =3D <480>;
>                                 vactive =3D <272>;

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org> # For DaVinc=
i

