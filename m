Return-Path: <linux-kernel+bounces-316892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FFA96D69D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE44B258E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83B61991DB;
	Thu,  5 Sep 2024 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dAYCwFX+"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590EE19415D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725534098; cv=none; b=fioeg9FSjnEg0CbitUwmNSbOh1yfWpVb+uggvIu1lOUh/UBuNufbHNaZigpKkJm6zFS4NRfDbuMKAoirktrKiojh/RCCYLHgaP8s3u7F3Go0CCDa2ofkWp3E8DJyk9UP8fDwqg9gokExqmLENkS8h0vM990BJ3kkV7xEtza8ums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725534098; c=relaxed/simple;
	bh=JgHWmEdFW5z3HkM4HSGAm74ONvRDhRCNMRmZO+WBYyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTbDEXsyicf7f3GtdH9o2WmreNbqihFsrKo47x/DgYpTr20Ihp7S2+JvIMDkUo7jvS9fqKpKranWF1gkuXqllVhYwixZnBiTl9GX8s74EGCF2MyKCLxjqG72Cfmj6sJYGoMzOMIgupOUp97n0k4EPqM1FdZ2zV2fbnmTRSzg4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dAYCwFX+; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a8ae00f5eso781055276.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 04:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725534094; x=1726138894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C6/VyCawGPR4Tyr2HItJUWfFrk+UdniGuvNz3Sm7eyQ=;
        b=dAYCwFX+/DSUOhAgLhmmySdh9gNU3MvLED0rUqGxLA4Ni3yyPAz3f88KGVfxEWRh3N
         avq/pDcTIqGCSca7zJ41gVRmRgEyIi78B92IWI9lqQTVzmguEMGDdEQtSBBEsekaRsfr
         FGsQ0dj0OT4YADtHKZa2SGQNCncFuiNQr1+PrLuQ3pGqkONsJ+UbUCaZApcdEcVRqag4
         c9iUjuY5gMkRrXhFJchAoANHrS9RZ/ohsl0lXdQP4WHJ3z3jRS+HRfpS7/hYkNrUbKPP
         IYHoo2fthGu7xPL9pDWx2gO0uM7cF03SGhs2rgGdvgDdJjG838zGVlzyv1mZ6rvvBBLD
         MXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725534094; x=1726138894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6/VyCawGPR4Tyr2HItJUWfFrk+UdniGuvNz3Sm7eyQ=;
        b=c+gZAYpsrn+HvzTTXM28mHxH76PgEx6ngWR4QbjS5oO4zF5vxaRC8jlUfH1k26FSyW
         Ex9cUAqAdhCPivDv4eWmChz5X4aMA8++xbsz8J0Bbo2rydWYDv3YIUypWBQf++KxEHgC
         MKbBi0lehbjjM8+NmAWR6RLJXfn8J3MQK5LWWern7079UWM8Xbg2OyHS1RPWXJ/zU2pt
         JFm3a+fUlg5ks/Uf0XelNmXIfT2hty+4BawWGGMDHh/nc73NhJy04NeI2uMoW+FRO1Fj
         l4GPDo96mFrgVoFMQERyPoDvzlCa+CAZ4hvpHs5EHTrltjBfMntLjXv7l6yj1xh2h6y5
         44Ag==
X-Forwarded-Encrypted: i=1; AJvYcCV8yIC1Ebw2nbfvhScpKxdM9vJUGD3J/RwqlDZUylOt4+eWvMhlvp17IL4lXqel3/7lm5qyjCKRno7Nt4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrMdLwYpsafhyqRdX0/qKPHE5N3FCGIyM8dD7JXE90Aqgc27Kf
	CmGQaPMQipuUFDjcvlgWD2UKEIvsuvr8nWAjrD3SDnbww56dnhYezNfk+9IibZASBFLdSHVj6HQ
	Uw/CKOv/yOD/8JbP8ZlE8mkQqAj5Tsty9jIz9kA==
X-Google-Smtp-Source: AGHT+IGjKTK3wpnOajjw2EZiT/LHB7MtbeSOSePCGgXYg1P1DVmGgHJiCauYYaxBabeuh5ndjKAzsRhaaMz4bajl7ps=
X-Received: by 2002:a05:6902:1683:b0:e1d:542:ba8f with SMTP id
 3f1490d57ef6-e1d0542bc31mr8719953276.6.1725534094123; Thu, 05 Sep 2024
 04:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
In-Reply-To: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Sep 2024 13:00:58 +0200
Message-ID: <CAPDyKFpo+nr+jSVZoxVVhLwi_FZfwg3cPTGfQOpjOG5np_cMPQ@mail.gmail.com>
Subject: Re: [PATCH v15 00/10] Add support for Core Power Reduction v3, v4 and Hardened
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Niklas Cassel <nks@flawful.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, 
	Varadarajan Narayanan <quic_varada@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 14:22, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Changes in v15:
> - Rebase (incl. genpd -> pmdomain rename)
> - Change the maintainer to myself
> - Drop tested-bys
> - Rewrite some commit messages
> - Temporarily drop CPR3 support (easy to add back, adds complexity and
>   requires more testing.. unnecessarily slowing down this already 3+
>   years old series)
> - Boring style changes (fix indentation etc.)
> - Sprinkle a lot of dev_err_probe to make failures meaningful at all
> - Fix some misleading comments
> - Rename the "cprh" power domain to "perf"
> - Allow and mark the CPR OPPs as shared
> - Include fixes equivalent to Varadarajan's (over at:
>   https://github.com/quic-varada/cpr/commit/f025f13a2e64b13c8e7866bedc3bfa73f2aaf162)

[...]

> AngeloGioacchino Del Regno (6):
>       dt-bindings: soc: qcom: cpr3: Add bindings for CPR3+ driver
>       soc: qcom: cpr: Move common functions to new file
>       soc: qcom: cpr-common: Add support for flat fuse adjustment
>       soc: qcom: cpr-common: Add threads support
>       soc: qcom: Add a driver for CPR3+
>       arm64: dts: qcom: msm8998: Configure CPRh
>
> Konrad Dybcio (4):
>       MAINTAINERS: Include new Qualcomm CPR drivers in the file list
>       dt-bindings: opp: v2-qcom-level: Document CPR3 open/closed loop volt adjustment
>       dt-bindings: opp: v2-qcom-level: Allow opp-shared
>       soc: qcom: cpr: Use u64 for frequency
>

I have done a quick review of this series and looked a bit more at
patch9. Nothing that I found really stands out, so overall this looks
okay to me. Anyway, allow me to have a closer look, in particular at
patch9 in the next submitted version too.

One nitpick though, please update the prefix to "pmdomain: qcom*", for
those patches that belong to the pmdomain subsystem.

>  .../devicetree/bindings/opp/opp-v2-qcom-level.yaml |   16 +
>  .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    |  286 +++
>  MAINTAINERS                                        |    5 +-
>  arch/arm64/boot/dts/qcom/msm8998.dtsi              |  760 ++++++
>  drivers/pmdomain/qcom/Kconfig                      |   22 +
>  drivers/pmdomain/qcom/Makefile                     |    2 +
>  drivers/pmdomain/qcom/cpr-common.c                 |  362 +++
>  drivers/pmdomain/qcom/cpr-common.h                 |  109 +
>  drivers/pmdomain/qcom/cpr.c                        |  394 +--
>  drivers/pmdomain/qcom/cpr3.c                       | 2711 ++++++++++++++++++++
>  include/soc/qcom/cpr.h                             |   17 +
>  11 files changed, 4314 insertions(+), 370 deletions(-)
> ---
> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
> change-id: 20230217-topic-cpr3h-de232bfb47ec
>
> Best regards,
> --
> Konrad Dybcio <konrad.dybcio@linaro.org>
>

Kind regards
Uffe

