Return-Path: <linux-kernel+bounces-519462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ED6A39D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E350165E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE52D265CCE;
	Tue, 18 Feb 2025 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dtqxb1+r"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC425EFA6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884209; cv=none; b=c42Xkh8KAVlzVvmFi5NV0tEh/YkuR2in1DXh7EGbYRe3+ZS3Kt3lHcfSJRjUgx+1AMsIrvJ+7+7YIYIFRB5d73dbo+4vT4x0GzebkYntXOH7tQAuLCWYcPwS/EOy8SxKDnVkuoqV6t0UNxSmqHSf5Z9HDjYcQNULu37VwJUq7TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884209; c=relaxed/simple;
	bh=wChb/6g3sce1C+2S6hz0f4MqiwvzQlvCTwkos7PCRgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/5qb752SRR9E21LG/wZMGNfbjIxq4m3/2Nkv/di9m1INnCF33L1UzEdfzIqhCJ3z6bRd8JWWj3TVxcVnc8XpN3B5vnfvkdi5x2mbtwBs/Ga9N+4QKtqk/mzXjw+uObZAW046SA14++/1nKjodQ73/Q/oeHl9xglx1jvOoLgDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dtqxb1+r; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-546237cd3cbso2130736e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739884205; x=1740489005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2H4CFTIInDOtT3tOm3edOpwQRv60P1DUgV4VG+RFkE=;
        b=dtqxb1+rSM2DZ963SU9zTaHeOR3KsHJWnXi2IOv/fZFsl2tCgDBJsZLDZTWiomZ5gc
         OdFRSA5aucfV7WEBNL5digHsP5itroS+yfuxrcaf/4memPvtzgN2r33bh7fN1Il9dQXX
         6OU2oG2DojBUAbqR/xm//lOqJNlVG5nyQwZd31MRXVmlhP7It4aJ46uVRYr7+lshW+P1
         HVyjwMUGTkK9wx90aFiSqyXOC1DWZL/ewgZ7Yw6l4LygiPjHWAnhZmil2ZKYqv5MiFd3
         C+vfydEkwR1cTkVR7D9Pdi+X5Xe+sKd6xOiZJXEi73x+igMvsa5/LWEa00Bp5tAFTvrG
         1ulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739884205; x=1740489005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2H4CFTIInDOtT3tOm3edOpwQRv60P1DUgV4VG+RFkE=;
        b=a8MgclgEoDFzBLRCmXfBVchBnBbJ4eVlDTYO5ls2KLJ9kN1NqDKilo/ld67po0TUus
         SoQM0ck010g/gqu9umxx3jyVjqA7xliTLkLjUR3LM3Am9cy+5FMyOVH+SsT09i4hsHXD
         Ovj0kOsiStCDlYhd6wDuwg4v6mEhfraLfhOnOHmCmfE9fA63/zx1szgmKtdsBvDvJDxX
         aQjqHW029yEATVpc4yjZ6GQkneuvf8fIQTQUqSuHsC+v1QytQP4LkTW9Cfm6K70yWl1D
         3vxuBamUd/0mE2+nW/gsXwHLvg60m8YzVnVOxwQx/MDXbLy5PUyXya6jicyoOe+8SEaM
         a9EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLlqKwwGgrE/cltIlAMdQw+RVXElkQHoTnt87EgZEGbunQbF6hFap8eRFEg0CWaeSipv7fb/vuKeJegok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhDhQha1lBat7YjWfO+IZQxFqlE/hfr6UAGJZaY24VPeDqpcyN
	N6Gr2VZ/JjOJ5v9XG4Y8fNH2y6oR8gsvZF/5jrZmiIjnhZ+r6c3dI1RBg3dOthT7JEd5SElVZUj
	YgTlRP9QkxcZen7Gh8hcLFToSpbNwmZHaxbjYww==
X-Gm-Gg: ASbGncu8yCU8uqMp6ttJRBaFbesWU1cSmMRWe6x/miHEkYysA6/teOKGIE/u2m8w05B
	4Ii1jacey4IkhlC9mGGnKZemobwscIWENXylEs1pYzX4W1nFlII5UYEJGz9SWcv3nqguxV0Be
X-Google-Smtp-Source: AGHT+IHdB6MXsIp6ZqlQsI40sZGvOLeSKe+AB5abn2fY1o/Am7w1jOVveK3QMy7dhDaAVzYZIDd9lE1wi3yAkqHGnxI=
X-Received: by 2002:a05:6512:3992:b0:545:2d27:5ae1 with SMTP id
 2adb3069b0e04-5452feae86fmr3466160e87.53.1739884205513; Tue, 18 Feb 2025
 05:10:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-03-k1-gpio-v5-0-2863ec3e7b67@gentoo.org> <20250217-03-k1-gpio-v5-2-2863ec3e7b67@gentoo.org>
In-Reply-To: <20250217-03-k1-gpio-v5-2-2863ec3e7b67@gentoo.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 18 Feb 2025 14:09:54 +0100
X-Gm-Features: AWEUYZlVwAj_YWqJ9Lyi5dg687EoTYyaneVjRfcETc4JasvXfyarUzHN15z58MI
Message-ID: <CACRpkdbxatfvPnOY_gNVAWdtoJ+xj3DbKNUqFU=9AC_UKM88sw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] dt-bindings: gpio: spacemit: add support for K1 SoC
To: Yixun Lan <dlan@gentoo.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Conor Dooley <conor@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Yangyu Chen <cyy@cyyself.name>, 
	Jisheng Zhang <jszhang@kernel.org>, Jesse Taube <mr.bossman075@gmail.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Icenowy Zheng <uwu@icenowy.me>, 
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yixun,

On Mon, Feb 17, 2025 at 1:58=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:

> The GPIO controller of K1 support basic functions as input/output,
> all pins can be used as interrupt which route to one IRQ line,
> trigger type can be select between rising edge, failing edge, or both.
> There are four GPIO banks, each consisting of 32 pins.
>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
(...)

> +      gpio-ranges =3D <&pinctrl 0 0 32>,
> +                    <&pinctrl 0 32 32>,
> +                    <&pinctrl 0 64 32>,
> +                    <&pinctrl 0 96 32>;

In my core patch I assume that we encode the gpiochip instance number
also into the ranges:
<&pinctrl 0 0 0 32>, <&pinctrl 1 0 64 32> etc.

Yours,
Linus Walleij

