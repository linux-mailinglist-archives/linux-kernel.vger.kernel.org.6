Return-Path: <linux-kernel+bounces-356916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B779968AB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780BD2825DB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51F6198A38;
	Wed,  9 Oct 2024 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQzP9/vA"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36851922FB
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472928; cv=none; b=rjOJ+E8lqV+wp65DXEfwoLt5VwiD9ZFneVAQmAC+/pTg+zaq6eWlsRbt4olQv0t7KcOMKySeXhvx+eWQ+wcPvZ5f0bKFMm8SuM3gJY+VE8RKS+ApEPUoblByCNMXIJkFpr/NMPVy+XTo8jH3i9jf/uyxJjf/Zm3SvYrXEpzK6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472928; c=relaxed/simple;
	bh=ToMkMJEJ8rJjCBH2FI0bPgN3A3AyN0+TDY69ZKIJIQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeqzR25t46LvhlgI8OiXQwfUzC5fA+YoiGhaeQwZcej/mWlmlY6MT/5QJkCN17RU9ORO1YlCqvUV4uONYa1+O92c5GsQ0Ba9CJVZYuc+7VHqo1vmTBjkAPK7E9AJBJiUQAOMrI/ugcRf3+ZiS2jaXIUYLGnxFDeiFWVkEmzOAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YQzP9/vA; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb18f14242so7407671fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 04:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728472925; x=1729077725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToMkMJEJ8rJjCBH2FI0bPgN3A3AyN0+TDY69ZKIJIQM=;
        b=YQzP9/vAoFOUNF13hDBTEzwlMu19jCVGil3pZIvfd4fzNS71UAG6a7f4/2CAVXxEli
         g/DB25sirC18Hv9nI6rR6Biz5ZENEDAaH9+nKHXK72MNSH1MuYlsgqCzRnygaN+p+Rzu
         sKVKXMKmhyYTRKnY2NqjT8H9G2gQlaWK0Cozal9VQH6UZoHlWcaNez7iFrBpljtga4W7
         tAkIGatP8eASU1MxocFvMd1FbXXMHxZr2HAf+80Kbs4EAtSpWLA1BCt0m2pqo3VlwEzn
         QKwxJVLwCEWNxAZl2Qly41Qk4zjYIu2ovu7BFJFuwN5XcGTxaw1ShNx3sGLg6VRWHFSV
         NZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728472925; x=1729077725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToMkMJEJ8rJjCBH2FI0bPgN3A3AyN0+TDY69ZKIJIQM=;
        b=hiHXWpaG/ePSIYK4s36+iFE1fekivJHE+uIEHG4+cCwbN1jei3/r0Jd128Dm2L41Nl
         DGccpEkMJ01BQmjajgeRVJjE/6UejpoWDal6lM8TbIQlXLwMBEh9dFinlGV4C0mE5OV7
         K3FX/Bb2GpZIrBSoYCoNUkLS0xdhZ6OGqtEn+YNYv+yaqHn5NjAr+Zq2lzeBucfV1T+Q
         tw8oHg1Dtrrf8UZXkNaYDz3J+groO9JT06iZB0quwp3zTPqFY96TY/ehsZo9quzIrcWR
         jo3mIYpeVr3DMY9WZlYkHVIRGUQSYh0lkelyhW78GSSrcjr3W5whzsbVtcUx5fhUMigN
         a2sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGBXaKtsDRFidhxomWpC8P1DEfcgpAWiOfHkiDoJElLuJ5wVQaovOjS/2kT28mmNbPE7Ub5ClaJLvOTKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwvl07EfP+in8DB7vnxKtQjoUsj4h/pl/fN/ij03auCD05AcCd
	mG83eEFeWzQoy5jFwcqDzE2bfh2zejnXljEbBhMUviAk3Ewqzr562oXSFrv6ZwrXhPtroE/z27l
	GrG1032R1iO2rRsEBqKvWbw3zVnyTmF9ezvDTrA==
X-Google-Smtp-Source: AGHT+IGQ3Ws6eewLXWXtNZ6Xp4qHWJ76HWt0M0Bzk6+R7EJ9OthHCsQrJfXtS7q4gWbrCHhdM6uWqQ2/WrrmEzIWnwA=
X-Received: by 2002:a2e:bc19:0:b0:2fa:cf73:a2fb with SMTP id
 38308e7fff4ca-2fb1873f1d8mr13097621fa.2.1728472924856; Wed, 09 Oct 2024
 04:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-mbly-i2c-v2-0-ac9230a8dac5@bootlin.com> <20241009-mbly-i2c-v2-3-ac9230a8dac5@bootlin.com>
In-Reply-To: <20241009-mbly-i2c-v2-3-ac9230a8dac5@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Oct 2024 13:21:53 +0200
Message-ID: <CACRpkdYRPSYd0pX_QR6mAa8kjwFLhA=FVqxYQa=9PSpNb1jFHg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] i2c: nomadik: switch from of_device_is_compatible()
 to of_match_device()
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	=?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 12:23=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> Compatible-specific behavior is implemented using a if-condition on the
> return value from of_device_is_compatible(), from probe. It does not
> scale well when compatible number increases. Switch to using a match
> table and a call to of_match_device().
>
> We DO NOT attach a .of_match_table field to our amba driver, as we do
> not use the table to match our driver to devices.
>
> Sort probe variable declarations in reverse christmas tree to try and
> introduce some logic into the ordering.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

