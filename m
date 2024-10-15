Return-Path: <linux-kernel+bounces-366816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E35A99FAEA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A07B2288F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C961D63C5;
	Tue, 15 Oct 2024 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3pzaNih"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31AD1C9EDB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030021; cv=none; b=l8udOzeDR8c33tHTUvh5j898V0l+7FbegMhQ6lgZEIny04REWDo40qsAhDgpYZOgyK8CohKD64y2Vh/C1vHH68fuAbxFib0tz4KAH26KtRGkHjmnUPISwHwUciuTl9ofSo2R+n4IOG6uvoHPJTkAzmCBs+/58Mh8seIKqMApSPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030021; c=relaxed/simple;
	bh=8pjgUnj2wUxiv+ZEhs4guDnzJ2SvwMR/Pm0VIaPIRWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DF68lUt+D7G1ESA+RZnaQUqZ5GFigFdZSmcnhNzCpNS/8phXarwTlkhnG0BKy97MDR/kyCmek5PR0Dum7wDJT73BtJ7srSi2RiQ28qPoA57ljF4qpYl+6bUTN/CVaqmQwnq907uiYURbTCyLJa3Bl/BFISOkU0q9u9szaiFA7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F3pzaNih; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso26998681fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729030018; x=1729634818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pjgUnj2wUxiv+ZEhs4guDnzJ2SvwMR/Pm0VIaPIRWc=;
        b=F3pzaNihtDtk7PPx9Ho/xI0GR7GlzhmOfsnAfk5RsOAjjiicurixp40s77Nna1PBz4
         7MdcNZNqXb2unF5Tk/Nc2CXw3IWaeEQd9EUSXhz1aCsUj8WLuWRzyiHVTaEufwQZFYYo
         CuSRgx4Wxs5NPzczp0Tu6GUf5i+CdtkzsMr3DTxnNDbNOe37tWla3VYHp7ki5NZStI9H
         aCaawtrgG9hXtCrRcvy8bxP8FoOsqQEIJJWdheOhtiZXRkZcc6eo2s4Avy+SD3B+j78U
         2oNTzFiFSwdvMwxaL1Uh53aGRuNxXczVrnvkD20LWBZPgRK6VzCuuB1CWsJEDE4yjVLv
         /VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729030018; x=1729634818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pjgUnj2wUxiv+ZEhs4guDnzJ2SvwMR/Pm0VIaPIRWc=;
        b=nfcAh9ABIsIuvpsvtu/YEfdJkvNRKVLYeS+lALSiKSw5CYO2UF3o5UDPUkWCH4pJgv
         grrrtTGsjeQYPtHNnp/37v2ON0wuYTqOIoq6GheiPpgL+ett/eJnTtWL6hj+n+/KFCBl
         MjzlyGVwWK65QIE0AyBsZA+5bV1mNcVtbIpqUFNgj58kpWsSG2QqFwGXhg2a7eH+Ygf6
         RFOBbcaa07LtOT3TWDbY3DILL07wXFGlea0zYwPrFMp/MCDBQHJl8WO+J05hBuqaiiU9
         zNKnY1SDHhLf7PZ8B8jVMv3196eCYLHU6d+kFGaeHP1XDQXLaYeVLjMmXNpy88m/I8WE
         Hmbg==
X-Forwarded-Encrypted: i=1; AJvYcCX9iVTopF9rEZXOHeIAe1hfAS6sseQKmH1S5t6QdHs2JQHr2FNQ1FlWVfhGsa0V3++JHL2ovs7Zfdv9GuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxut7Rp8EfXV5Z2LnTeq/GFe6zFBrbGsuBqgwA4l3X+rGFa25/f
	MzI95GLRDPHEcWfMyav/YhNG14zUVvPz5DYEG/FXb08ybqj9scrKFJ5lBOrOH0ibWFXwn/UrqRh
	5pbU+48/RDTJyTz1E5JeI8+pzCupUmmPszKzrng==
X-Google-Smtp-Source: AGHT+IHrewx2uW2O1wX1aY++a3xqOQG1Pr1rX9mO0IID1XuNhMOh/EDpRoDGq5POidQ1Sfd1Dv+NRfeCn4ylE3MZrOY=
X-Received: by 2002:a2e:d09:0:b0:2fa:f5f1:2539 with SMTP id
 38308e7fff4ca-2fb3f2472a7mr48758161fa.24.1729030017817; Tue, 15 Oct 2024
 15:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015065848.29429-1-krzysztof.kozlowski@linaro.org> <20241015065848.29429-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20241015065848.29429-2-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Oct 2024 00:06:47 +0200
Message-ID: <CACRpkdbLZwLEWBjF7KPX9pDAVseujHF6_ytD9558s1B-p0M1sg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: samsung: Add missing constraint
 for Exynos8895 interrupts
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
	Jaewon Kim <jaewon02.kim@samsung.com>, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Igor Belwon <igor.belwon@mentallysanemainliners.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 8:58=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Expect only one interrupt on Exynos8895 wake-up pin controller.
>
> Fixes: e2d58d1e1c61 ("dt-bindings: pinctrl: samsung: add exynos8895-wakeu=
p-eint compatible")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

