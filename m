Return-Path: <linux-kernel+bounces-557604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6F3A5DB77
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C682A3B92BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7012E2405FD;
	Wed, 12 Mar 2025 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcwtAeGv"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B6C245031
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778730; cv=none; b=ACyTmBmKujz31i3j7ncLy9UUNOzF1HdZhFTsqhap4R8E/jk7wh6I1p2qlXKuJT9lO43kUcYi6taLQb2Pk4fUBXou8iT+b0BGSlkvHiTLWkj2JLaR91SaUtV9KR/k3xO7U6J3VZOX3yN2X08YSAF91xp0Sstupsx8oNn+QX/SWaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778730; c=relaxed/simple;
	bh=1wvMq+p0b0LHsuXs2t0D9kgHbJ0JEDZN1CXO+LT+A8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9UgpRgN01o0fdeqrFZ9t88QggUsg2jdTTra/I88/uJIQg+FfHV5H4/A5RHM/mjlD7FHbvHTgPCGgdMqYpHqYQf0hPdb3SVnSuzxCD+IVCzLDBqpoGV1B4JjhXpVbMnqzooZSzA2axnKj127EfNBbjrcMNdDCqPsTRcNZBj9yMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xcwtAeGv; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6efe4e3d698so61917947b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778728; x=1742383528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dadpUZC9V5c7MYnunblVKwFOdnOlHudqlcLRPnjOYeA=;
        b=xcwtAeGvbeg29VdHPHF52EjNcGWPoR5CC9+YRm18s3q7zZx05h0nuhdSDn4PXwNQ36
         5AnU1v+RXDRuvZkw/Xie1Vqmug+Rml08kdNbIZMj6wn3cdZ+1loJQX17nIOr9rpuyFfi
         XNDuAPYl+b5bWJpTQJSlVhTTd2gV91T1WdxY7yy5vaIiePk5G56uIXnp/traCZSElQqi
         G5xFeCKjYIeynp1l7fqes58uKFQiDmxkoTTb8zOxTFk71+WPqmza8wTAl2BidF3nbVY+
         e38nuRQq7GEW3wX32WF8RYyaSvLLRvrigdRy7JbQeIEZlrrwq09gL7KvFYT0/3929tZp
         N6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778728; x=1742383528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dadpUZC9V5c7MYnunblVKwFOdnOlHudqlcLRPnjOYeA=;
        b=ugJp+QDzua3c0H2ylLRivZbNp1SCEEsWe/3sH2C1TFtjC4MEs1ORJMTA8aR0yYlPdE
         HhXRzqTtXPlSJu4JK3vih0J9Ju0aaCV/VpvWE830fL1qfDRO4g79JmdtcWy2pRL57RHT
         r/YEEY/7Y5ZpA/603cl06Oi1UN3WpjtCep+2vaNOYnJehA44YCiTNCn/eDdT5cZP1DL4
         8Zz5soigWPnrUAdG0WUdlXTCEgsPjWjSo1y7QeBeepX15LttkpRW4N74PpQZs1+lNSBL
         g0njjNXFd8MLx+sooiaJ91LmDfV/u5CUDDqRNMBPw8ZRNtI4ZtEbmdD6NgD5VRFtsDRS
         CYVA==
X-Forwarded-Encrypted: i=1; AJvYcCVElcdZueYiAT0Uc6yr9mgm8+CMOVb2skvDSMTcEdg/uFpe3JRS169mvzwxEICluGOg0C1MLxbam1szres=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW2LTR4jA31DgKJVPjKzc+b2fZdNx7LsVXwyP8sLQwTdcJ7rX7
	scNgKrAFMYOG5Gv+RWX40N7iBMZYNiHFClREBf6AQ4FYIH0UcYyv4Grs/MFBn4U6hozHB4upsSJ
	fOWWUa0mWB7nDmlDPBSA4TWxfKboTQt1B9Qz9og==
X-Gm-Gg: ASbGncvEeW02xiChafbucyrzj3vOi5tzD3xPUiBC0IaICrsKGLgWRyLCyc1aLHgQJZu
	6yY/PL5lUhfp00Rt1vSM7UE9SuvUXx0Zez/kFg2ROIsJyOMOCD+ts9oPTRVvmhWkqSZAcxi0TY/
	bvVNPULvdPufVCk3SDIdj8eQbf4FQ=
X-Google-Smtp-Source: AGHT+IEkegzJ/XAYlghTUeG+wVwA3ds93Wxe6yvoeV0jHqydpXmTqXQvt4bDvlouPz1OikUEEzcCwOPsAA9n/cL6aTA=
X-Received: by 2002:a05:690c:3802:b0:6fb:4c11:61cf with SMTP id
 00721157ae682-6febf2e67e6mr312924957b3.19.1741778728184; Wed, 12 Mar 2025
 04:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309055348.9299-1-ziyao@disroot.org> <20250309055348.9299-2-ziyao@disroot.org>
In-Reply-To: <20250309055348.9299-2-ziyao@disroot.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:52 +0100
X-Gm-Features: AQ5f1JoG4yNR3eqoseTNZhzIg7tVbmXvgNO4DfacKMnpZftoLIoMXOX2r6zD6_U
Message-ID: <CAPDyKFp2UzcxfFz=8sREkj3x4DvfkfxU3utc0+e+uPS78Tn-+g@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: mmc: rockchip-dw-mshc: Add compatible
 string for RK3528
To: Yao Zi <ziyao@disroot.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Shresth Prasad <shresthprasad7@gmail.com>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Detlev Casanova <detlev.casanova@collabora.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Chukun Pan <amadeus@jmu.edu.cn>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Mar 2025 at 06:54, Yao Zi <ziyao@disroot.org> wrote:
>
> Add RK3528 compatible string for SD/SDIO interface.
>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index 06df1269f247..ea0feb733e32 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -38,6 +38,7 @@ properties:
>                - rockchip,rk3328-dw-mshc
>                - rockchip,rk3368-dw-mshc
>                - rockchip,rk3399-dw-mshc
> +              - rockchip,rk3528-dw-mshc
>                - rockchip,rk3568-dw-mshc
>                - rockchip,rk3588-dw-mshc
>                - rockchip,rv1108-dw-mshc
> --
> 2.48.1
>

