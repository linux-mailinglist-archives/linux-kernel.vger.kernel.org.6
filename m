Return-Path: <linux-kernel+bounces-269671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD67943599
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72B81F244A7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCA045BE3;
	Wed, 31 Jul 2024 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zaxsW9mp"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395A13FB31
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722450353; cv=none; b=ixKYFWc29W33pl9O5PjJEiFjnipQ/QA/kQ5gaK5+9i+vfFy0NKVSUnXfgBzIsaOiqGAGNOp29Yd2RcUqEaLgot/BuYsCPntYMiAMqsSjRkTCuhvzsNs6Q5QJQAhNHU2emGqgdqpWywFNC9RLQClmkmfbH82bm0NKApp/poE4+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722450353; c=relaxed/simple;
	bh=SbypRaxK4y7FOUc04r7g6F2EtP4Xxirop8YZAKga7xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOb1wuYedNx/QEYZ2X+DEAnoZLpioj9adyuiFTne5vGzwCMpUYNfW0Ovi61E+B282sbBMSZ95eVP8FJ3zNmqQvzejyJ/VuWy6zs4R6tMisJxT4S800mww999v9G6jFuSAGnMTyObm0GQjX4QWiEHFHNI2J2+8v6BPpj8N2+0c+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zaxsW9mp; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-65cd720cee2so44256207b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722450349; x=1723055149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdzxLzu2RkJLVHNIZ4Z2FLUcNDJnzadZxmlA7ncYpvs=;
        b=zaxsW9mpK2SKBOsbgkBkWzaWWfsYmcOyKJaN+SS2EiSv/sNmFCIfI76m0/qE0AFb+y
         jEAdWikJrUORrMdYl7eGld3cNgIQA2XU/JPAMcf4hLg7fMxVdGuBby0qIsE6NZD6gN87
         bbNeJcLGhoHdBxAp5vdN9iWSGv/yd1wcBK7VTXhprGT4tT+njSOX1FuuFfitQSd8g5/m
         uQSCDkoh3Ja8UpvUGDMU8og9La9kLGY3lN6Vra1L6Du3R11uzetJfhxPS0DcSGAwfStE
         gzWCGzzDZvFtN3AhLMlw5SSQlS+C9t/+7qtZF7suE72AvEqONgTe08/NRyP1ud7QwHxu
         qiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722450349; x=1723055149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdzxLzu2RkJLVHNIZ4Z2FLUcNDJnzadZxmlA7ncYpvs=;
        b=R7TRKn2RqtY8yG5cZBCRR5vp2U1panmrQuxws/KnAUdkw4hghCWOlZ4EvoOmfxj7QY
         poSlBMeASRop2R6D7DsLdrbSk35Dtf9yXt/E1OtV6suI2p1AY9Z2sfCstEC9X/V0MjN7
         qvSkmOkY5jZNBkzkoLS7rVFZ4Aaa4INBP+S9/Ct+0p07txMj4ob+n72RDFNW8PQbyuP8
         oEgMtQF9PRzcw110HepCJLUwXcy/noi9Tw+gXfa4/ArWynoKV/BfHnih7Z/wP+XQbgSD
         jfNW6Rv9W8ikt+H5/8+4h/2tYcTSZSsLJmwvRmvkl+s54mqVgXdD2fqDGqQRva8X4WYE
         9urQ==
X-Forwarded-Encrypted: i=1; AJvYcCXim6UXWvQK+19kB4Jp0XkN6fLC0C5PYIL9AX7Xt4cSDlrvHf1ECYXhJShdOxcELk4f2bKZ4euEnCtTg59TfskfJOELoCzb8DhjCoti
X-Gm-Message-State: AOJu0YzGvYKZWcFpmsuv5E22A2F0bL4/jj8odYX00nPkHw8rF7OrK0hI
	ARAsZpLBS5t8hegKxHKANsqsWTX08waMT7masPYE71UfiPrYo5w+ZthMZU0vqDrI0awtrzVEyLh
	x4PgqkiyWp2pC/Gy+l9v4iwV3DTyGqMsuZRqn1GWRw/W06WjFPx/jTA==
X-Google-Smtp-Source: AGHT+IF0KfSlWB047Omd2PMOsZLUTxv2++sjbYGOlV9vhnSEfTHz8IYHfgmHBSw8qekBtE8MJoZfDGTkjDqE6mB+3vU=
X-Received: by 2002:a05:690c:d87:b0:64b:ead:3e3f with SMTP id
 00721157ae682-67a07b757bemr205779687b3.22.1722450349254; Wed, 31 Jul 2024
 11:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723163311.28654-1-semen.protsenko@linaro.org>
 <172243565547.42492.1072397968108986657.b4-ty@linaro.org> <ee392e1e-bdb7-4cbd-8b43-00ec0efd5026@kernel.org>
In-Reply-To: <ee392e1e-bdb7-4cbd-8b43-00ec0efd5026@kernel.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 31 Jul 2024 13:25:38 -0500
Message-ID: <CAPLW+4mxtTj5VGi4LYwU-8F9hsSgDe+yxAsON=rXUhxGWHCCXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: exynos850: Add TMU clock
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Mateusz Majewski <m.majewski2@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 9:22=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 31/07/2024 16:20, Krzysztof Kozlowski wrote:
> >
> > On Tue, 23 Jul 2024 11:33:10 -0500, Sam Protsenko wrote:
> >> Add a constant for TMU PCLK clock. It acts simultaneously as an
> >> interface clock (to access TMU registers) and an operating clock which
> >> makes TMU IP-core functional.
> >>
> >>
> >
> > Applied, thanks!
> >
> > [1/2] dt-bindings: clock: exynos850: Add TMU clock
> >       https://git.kernel.org/krzk/linux/c/01ce1bf22adc0d09d906319787091=
ce784cb9914
> > [2/2] clk: samsung: exynos850: Add TMU clock
> >       https://git.kernel.org/krzk/linux/c/79b918aa997acd5066c7962502b1d=
aaae76b6911
>
> Hashes got mixed, but the commits are properly applied:
> https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/log/?h=3Dn=
ext/clk
>

Thanks for handling this!

> Best regards,
> Krzysztof
>

