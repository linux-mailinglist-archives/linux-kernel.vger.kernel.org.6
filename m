Return-Path: <linux-kernel+bounces-193807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7458B8D3262
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2518B288093
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AB7169360;
	Wed, 29 May 2024 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FqTO43Hh"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A2A16B758
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972977; cv=none; b=NRloLeTqvExX48UlpzkvPJf1P/oXe58guTyPdK2/VhBmIIDhDpkl5f7gorSEx3XgmRVkh6M6vKokrDSaAwE2LW6y0sdIb4zlkRsq2UOg/vecty5exCW5INF3Q5kZg3fimU4QHPwOhTe7ZI8wnjMhHdhXu23N71v/TsKAC5cFHMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972977; c=relaxed/simple;
	bh=DtXP8XIgulfp/10cegI2AvN9bdkVmyBIDSaD2r0yo3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKR3QEaqdjMCHwDF5EUPWgFoQcH3e3SB4GFYJ8Pr/9S1kLheimxFqWbmMb8drKuwNsM+xLcd0vtVoqnm3fiW4hkYWXzqtDMBleUIZEfwhkwfq+YNcCgoNXz/FSQQlAogDm5z+Mnl9WVzaXX8kDYR7FOImh0PvbtWmXA1vfWyjAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FqTO43Hh; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-627f46fbe14so17680527b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716972975; x=1717577775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtXP8XIgulfp/10cegI2AvN9bdkVmyBIDSaD2r0yo3o=;
        b=FqTO43Hhguw11gV4FB+sUgNiaR0ApBGr2andjT60zD+5QuB/dc9tKnxrLiFzccBsRh
         tp3AzIOh7NkQQcl0g5+TU7MHaKUg8AVoihWbaKRdP6LJ8xMIK3GcDyDZDQipzRHzlFSK
         hynRloNwoa2708ez6KM9hvtznZq6G2RZ8ueCIICiWKLRqg8hxS7LZIAmZ0kW5yQCEGzS
         v1ScBFfrFaMf/BkVGm6/IPSRoQxLriV2VxZ7sJ5a/Pdg2L3FcG2nOS7kz5sPyJ/RG1ka
         yNTdnu2/8rnCGHpbo7u+EcdhXq7P96u4Mu7sxJSEijsIdqZ/ikmijyYWGvOIzMK/tG9h
         r5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716972975; x=1717577775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtXP8XIgulfp/10cegI2AvN9bdkVmyBIDSaD2r0yo3o=;
        b=CoTXTfhAQ/CywyREuinv7h9edwh7+cuTEqaxFir94w/VzGYImhUW3B8aD4A5tRli6b
         qsVp94IfSt069oy85m4pb/ZA2IBJAJ1/Q3UABY6OHW1ADKN2NNiHEt1dPNLQUSniDLE1
         BuF7b0stG99ucavyJ2nVLLcx/lte5ZT0mTNZyDciAZFphzMCQM+rYch0efjqDucrZCae
         sUILIjgmp5PnKRDQmwNEtKsEnvoEhEFHQnD+DE6tayB7zbFCXTpqHi4lOz8/MWX9gGcy
         76P4CSnrFlVSSZ/BDTGUXSFuAZuiMFatzvqhJGRSTIkin6+hjMgZ2lnh/QJSkHIQOD35
         83HA==
X-Forwarded-Encrypted: i=1; AJvYcCXUHCipwOgiVtAHXRWsWHY4Nzlsoif0GQO0o2364SkRq7qox0uniWNkn2cMD9h7z9m67KChS6fmUoyJJuqnhQIC4LB7Cwak44qFUTQe
X-Gm-Message-State: AOJu0YweHfeywCxtVsDgxN6Ao3wFc/5TZ0S96CVYkaNsGzVtjeAUf/OT
	/jJGrk36G+B2vxVM1gWVt6CLZexc06Yn3g8AKa+xTjjHo+11YZ1AFYw++JAt4YpUdzrcYGHtLXI
	EB9NWFzbkcXumPq4aOv449w36AZZAJsbk35BfJw==
X-Google-Smtp-Source: AGHT+IH4NQ4depklJARq4QXOQPL6SbQbymroEMtHHxC8aWGwiK8gNUj59IY6hl8YJF+EVgh8d/hNerEfUYlfaT+IpDw=
X-Received: by 2002:a25:241:0:b0:dfa:528d:e8f4 with SMTP id
 3f1490d57ef6-dfa528df61bmr104636276.33.1716972974547; Wed, 29 May 2024
 01:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515121634.23945-1-dmt.yashin@gmail.com> <20240515121634.23945-2-dmt.yashin@gmail.com>
In-Reply-To: <20240515121634.23945-2-dmt.yashin@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 May 2024 10:56:03 +0200
Message-ID: <CACRpkdYbYS4bdzF8oN3JGsfius+_WKJLvZ06m5T-Z+Xb5EEbbQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: rockchip: update rk3308 iomux routes
To: Dmitry Yashin <dmt.yashin@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Jianqun Xu <jay.xu@rock-chips.com>, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 2:17=E2=80=AFPM Dmitry Yashin <dmt.yashin@gmail.com=
> wrote:

> Some of the rk3308 iomux routes in rk3308_mux_route_data belong to
> the rk3308b SoC. Remove them and correct i2c3 routes.
>
> Fixes: 7825aeb7b208 ("pinctrl: rockchip: add rk3308 SoC support")
> Signed-off-by: Dmitry Yashin <dmt.yashin@gmail.com>

This patch applied!

Yours,
Linus Walleij

