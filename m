Return-Path: <linux-kernel+bounces-543431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57795A4D57B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826E3188D5B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E251F8BAC;
	Tue,  4 Mar 2025 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCSKcBHK"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990581F873A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075044; cv=none; b=RCFKLVUt9l6zd/CuM/lnyKf3jTXgp22w5P81TJ3hVFJ+cAjcxp1R2ot3pxAPvu+KHbwtad9EH8M1z+TgArZLAlsqlpmS6O784gUdbS1q1hrIMQlW9KW9OUh21klgByhScOcuy3oqeFCVmj/t3+Xl7WIieI5M4zbOeN84Q2iVubo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075044; c=relaxed/simple;
	bh=9MJWVNAYbFfN5gmFYspnU7mZ7rSbwhs5+PzxvlEK5oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoEoMXSFymk7aUWX9x8AqBQn1y3idi4LeF7BGMi61hIq5W9e9ULIdK3Bly7CT8K9Lw9o3iyctjZHNDt6rARopXc+2lP4240ugUeFddyVFmh90litPFTNcT4L0e7Hp0lkvDwD3Ogj6Tn8ELq+T4aUiwvHp2i1Kolk7HESmnw+KL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SCSKcBHK; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30761be8fa8so57695341fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 23:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741075041; x=1741679841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MJWVNAYbFfN5gmFYspnU7mZ7rSbwhs5+PzxvlEK5oM=;
        b=SCSKcBHKpd+HiqtH6OBQs5GSaQK/JFJYX4y+yldo4lDLBtUoRAQYafUf2LWkY5BFrW
         otmgMb3OXUD/VN82lbhJOE7ThLxRPlwp1nvUnjWCZNrIgQcx4bUetBLPL47aHr8fvOhz
         kWj5EvnnY/br4vdwOilgz/gMm7WS7MancGWkBcKWBxVazix5v7al5QTqUfiItU1BiPf4
         hoTSvFPdqTTxmlHtoKT+ygPxArUlHpQTa0Ouc6snA3gjfgzOznQDMCrOBXcvYSXcIA3Z
         aRELQPWxnprFY5BXdBu7WgAO+AZsNE8KCfIovtnSMEzUKLhxCRmGYI8M5UxX7X4hoyNd
         YzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075041; x=1741679841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MJWVNAYbFfN5gmFYspnU7mZ7rSbwhs5+PzxvlEK5oM=;
        b=V7PAlc4VoXKjD06nDmqnOVgYDeW7b+u3yR7zA8bupoSucfU2EqHdQEDTUba/G9RyFb
         wLyEao4Ug89Gjss+LBq70ktvx7NMXw9y5h+0GMNcjR6hskjZtj2J7r2+LyTrNFIuL8F0
         1M5bmpQxy8msRJSa7MUOn9SAgjMrnhibJ0/bNYL8iKt4OWQ36+y8Kw9/p7fefBmKNkB2
         WA20BXLyRbF08U08opulfcXDGdB2EK5KTED54063NpurhtYvWknwVzzJSpMxshnVxx4h
         MuIEIMQlZK3+00Gcdc0p1YB8jRN8Xv2SzjmJgbwBhaQhsxtfoWZ4bXy3lQwAMFBOvXuQ
         B3Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWqIJJLnQEgAe7TtB1VJg3CkYqUe8IGZJwDlpwZVXzT/Ylb164DxRNw/epODZ1b14ZGUkBb2Zd1UfazFdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy926zP5qY7OAJoVqTE+Ivb1nl1opP1ia1pCpME/H5mL1uB01MA
	44PTFUzY8nLwFFtIlbyLwi+ksTTXslZoYsbRRvbnC9Z16J5YHJbjL+vEHJJKS6k3fL3p7CwIDUy
	IQObUJ3MODgRP4DVGoPWLi8Dtn4Xz0FqGWz+YcA==
X-Gm-Gg: ASbGncsPcm2wkPGArzEOhbxELjTfixpdcREfcm/vIB5iUgFzQpg8xs2J04zHSXhr6Ea
	hf/leJWW9n3mChC+6Tm9c8U2G+aDOAkWiiQlzAhP/ynyv1ICuVhzmvsEn62zWeikUHt3Fky5VI6
	KqPXKYFM0Rczf524KJEFBmM3Z5dg==
X-Google-Smtp-Source: AGHT+IHSy++EDa8uB5yFe/BN1OzFpcRiPv6q/L0Yb6WEIAoWQ/01QGVa6aOzlJPGbi7YoL8CeVCsSdBYLnA1PRv5TZU=
X-Received: by 2002:a05:6512:1103:b0:546:2ff9:1542 with SMTP id
 2adb3069b0e04-5494c370474mr5181702e87.53.1741075040603; Mon, 03 Mar 2025
 23:57:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740745270.git.mazziesaccount@gmail.com> <fae20f205d4d3c9f0bafb133e51dd115f68de84d.1740745270.git.mazziesaccount@gmail.com>
In-Reply-To: <fae20f205d4d3c9f0bafb133e51dd115f68de84d.1740745270.git.mazziesaccount@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 08:57:09 +0100
X-Gm-Features: AQ5f1JpIi2JxPyYJe78FxstL1PUTrYRkGuGmpoWXbSVW-5ZdXAx2tNfGb4CuOR4
Message-ID: <CACRpkdZJnzd6uu9qO5VRLps17-2+ownFQ7CgHCko0vUdjnhTuA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] gpio: gpio-rcar: Drop direct use of valid_mask
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 1:36=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> The valid_mask member of the struct gpio_chip is unconditionally written
> by the GPIO core at driver registration. It should not be directly
> populated by the drivers. Hiding the valid_mask in struct gpio_device
> makes it clear it is not meant to be directly populated by drivers. This
> means drivers should not access it directly from the struct gpio_chip.
>
> The gpio-rcar checks the valid mask in set/get_multiple() operations.
> This is no longer needed [1]. Drop these checks.
>
> Additionally, the valid_mask is needed for enabling the GPIO inputs at
> probe time. Use the new valid_mask -getter function instead of accessing
> it directly from the struct gpio_chip.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

