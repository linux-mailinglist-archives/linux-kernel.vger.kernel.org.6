Return-Path: <linux-kernel+bounces-245702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373D592B69B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690471C22F52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEFB158A06;
	Tue,  9 Jul 2024 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="we/KRAhE"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDFF158869
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523715; cv=none; b=mox2GqzZvDPYciXtgisESA591FfviNJ40lnmQ+vPoBsj+ezttdNsZ5tN/I5HchNXN6M5KuX1L1GxbIwhr9ve8iA1klBA9JcVFWHHlSHS5w1Zaast8CYyzrVC33e+sbQk8ONwxLjcLq0ArBYnsXH2Q2W5Nfjd/VEqEnYfIgFimzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523715; c=relaxed/simple;
	bh=a1z9aXVH0jD/Ns99p9cnjXyxouNm3dQ2gvZ1e148jWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exI1O4H+azRhIQJX9ANLvoRWksi1MgIsRj7mFZlhVnnK6nPDoAD+EwY2gs2B9JDrDC+ICRe/Z5uqn8YG1h9itkZfxanwmJWSzG8zTyr+4/N04RdstzbT8kB0tQsy+yPxgo0E+4uy+HnelYCzEeUmJ2EEwraLnbWM3El9Ld6gXqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=we/KRAhE; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-650b8e0a6ceso50347367b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 04:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720523713; x=1721128513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JRnxn5kBog1S4c87fuPJ8CVw2ogmUFe7KoQqF9HGur4=;
        b=we/KRAhEuF/YgHgY85BnisOG1Vgur+POcRbi7uJp2gSTb357E6r4ZScnZ7UQv0vSNH
         ZvGD6gB8aJr1RbfSFQxCHEUbkksODOTT2LtW9mUGMV3g4BliEr2KwnffFYhya6q9PEje
         7acmZVnvudpRt5YTL3zsuOj8IBIofIPu3mXevczEEDgLozpYqn8eWMZE9S0ucDvXJO3w
         JsRsqcvelD6Nt/oZkzQB/svpQZeMvHFKav+Mxp0HOjzKjIWlTcWFALDBhY8Gyf9pVG5r
         DwYJm5G5ey7ZRfxVpexRxmZacjBUKNJrTiOuhXHLsZzluUtdegiIL3Dg6KLJ+yE4DDC9
         geuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720523713; x=1721128513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRnxn5kBog1S4c87fuPJ8CVw2ogmUFe7KoQqF9HGur4=;
        b=NZDvZZ81ga5JwzIkxHy9fMPPoNG0WJ5oYfQWfQUMHCAVZwGp2J62cNkAqyWDOceo8s
         bOx12myBwudmNPoqp1q3J1Ohmpi92eSXS7pPAkEYluVCgFaLCAnS2GGX5+DV4HLJSsE+
         PfLts3nn3urXVTZu24CejU3JzvHP4Z9j6gpAdDWDpmyTFHkt6slAJ2eSdvGRmdCCf/wY
         ak30k5IOoXFQagOF1OKpIL5CjLqTEWk0Ogsxy9l0k/ymbkBif3d2vj14PDeo4mQ0oUy4
         wWeUdz36ScAe7wHlYE4JVljEeOx8R8PPxXkuJBZ6TD37BtBhvsWW7g5qvXeVyKrqpAEn
         RmAw==
X-Forwarded-Encrypted: i=1; AJvYcCXnKorzib6m8lXWQnjizhkEcqRf8HyP/eqX/xn6m8ka0JyK5DxQqtt7hZsw09xgAIeSSReylji/TPa06G+xvqRmItuqw/SXowlbRbbY
X-Gm-Message-State: AOJu0Ywlvuu0fELfm67I3s0xtsbFSiPBnGl2v4L4vvwsLhtjayehuDnV
	8D5RiNbXC03gBYgb7+4mDMizuBJKuYomcfn9DysNG7XmObyQAubI1NoBvFN8ugYSc3cigMtrle5
	VzCDe903otnYoEw+bo5aeFYPoTio5qJzobExn1w==
X-Google-Smtp-Source: AGHT+IHvO18cEkcdgxI9LdmOavq97SRmsNIECRYT+ECXAWD9UTP9pFQ6ZQOwH4TjXmRjZ21qPReOQ/XXVr1I24f4iJ4=
X-Received: by 2002:a05:690c:4b06:b0:62c:c684:b1e1 with SMTP id
 00721157ae682-658ef249fc6mr31666527b3.29.1720523712710; Tue, 09 Jul 2024
 04:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-a5_secpower-v1-0-1f47dde1270c@amlogic.com>
In-Reply-To: <20240627-a5_secpower-v1-0-1f47dde1270c@amlogic.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 9 Jul 2024 13:14:37 +0200
Message-ID: <CAPDyKFrY6rL-aCo=GtmRBoJNBH=p3DteWWfBmWkFnWhpwHLnLA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Power: A5: add power domain driver
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Jianxin Pan <jianxin.pan@amlogic.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Hongyu Chen <hongyu.chen1@amlogic.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Jun 2024 at 13:47, Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> Add power controller driver support for Amlogic A5 SoC.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> Xianwei Zhao (3):
>       dt-bindings: power: add Amlogic A5 power domains
>       pmdomain: amlogic: Add support for A5 power domains controller
>       arm64: dts: amlogic: a5: add power domain controller node
>
>  .../bindings/power/amlogic,meson-sec-pwrc.yaml     |  1 +
>  arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        | 10 +++++++++
>  drivers/pmdomain/amlogic/meson-secure-pwrc.c       | 26 ++++++++++++++++++++++
>  include/dt-bindings/power/amlogic,a5-pwrc.h        | 21 +++++++++++++++++
>  4 files changed, 58 insertions(+)
> ---

Patch 1 and 2 applied for next (patch 1 is available at the immutable
dt branch too), thanks!

Kind regards
Uffe

