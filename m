Return-Path: <linux-kernel+bounces-240277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B283B926B34
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595401F2203D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D59A13EFE3;
	Wed,  3 Jul 2024 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHcaop3O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D95A3D393;
	Wed,  3 Jul 2024 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720044329; cv=none; b=Ut2v7veYTHBAs5mq3hRGF/EnVbMl5rtYY4/V3vsVJbQ1BP19jV/shFd0kEzrD+JIP3EJXX30i/jnyfIZcl18100ivh3fdWg19SvvBKs6awucotAcMBYxoCoMmQzMEu1kS5aLdm1xvwc3lozs5Agv3yPdCpS47M6mZ4kf7ohUFSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720044329; c=relaxed/simple;
	bh=B61XaGM995N7SJeiHLBLh4ORAhzl9yq4niV8X1ZoSNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNO95m+vCLexPtrSZf5U0Txvr1ByG7fWwI8LGrToGZCD++C1lDPIXNyxQj3G1Sy0rW0ckhR+XScp3VgxOU6Toqzoe1ZSAG4qHZArTKpo6pR0fpn+rXiyrKUXypPHrzr1Al1wIk+pTUYKXmqlyNnYo0IHj6JglovaqmZzbQUlby4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHcaop3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C138C4AF0B;
	Wed,  3 Jul 2024 22:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720044329;
	bh=B61XaGM995N7SJeiHLBLh4ORAhzl9yq4niV8X1ZoSNI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AHcaop3OPQ/ROK670kOFW85pdOwWoLqOZPJouey5b25A9Ru0jtTnlATbKXF7x9Xw9
	 j6SkkPl75eiHPSKr086vCuYOnfvIaQKlyKr71e9PyvFATQ00U+QY7LXsMTFqlTy1f5
	 n8NLnMRuaJb1PjJ2nZ+ci6EwIJYQ4ZG0bE4YtgobGlP3ovdV/2zPXNwaMgy4uRfNlM
	 3I3XkCTFYCK8koLe+ZASgBTNlm4AxQsuScXnEquMoxEpWB5B0ja5DvtGI2V0EJF870
	 JfKXOk6dQqUTkLvzNHxAjXbSFBLOprI/331YV5Wsv0RmoCiwHyolB1IEd0MqvpBxSK
	 H4l+oUtwswAKg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52e9a920e73so1202939e87.2;
        Wed, 03 Jul 2024 15:05:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWWXZTsZydqwcryvj4NTnhKYGpyiX8D/oSyQcFvoC/VC36nfC6B3gk9pUFHzll8N07aULUgTc5v77S7dge8M2iU8sTJ7TP6ggv5wfujGedzIEW3nHkao3ygrwxxwK3BrotIYXeCCfCiw==
X-Gm-Message-State: AOJu0YzTPQcKXGH96avB0dIINj5P3f1r9p7evRmPX+YDAKRjdT4D4sBP
	WIf8K6oe01pbXUyhHMbjrDY53xgr93U59gc5wzT/G9K0wBb4p5CCYR08+FjV9gnpkws79xnWS/r
	WRkjoGnGE+wy+KDDR7m4wntxgEA==
X-Google-Smtp-Source: AGHT+IGlEoNPEhKDkX6VNY4tzzwO//NHXwb7mZ7QnS8r6c1pgcQ157nLAxpPf+F4By3xFDbI9+5kd1ft7j7Fe1MzQjQ=
X-Received: by 2002:a05:6512:33cd:b0:52c:ddce:4fda with SMTP id
 2adb3069b0e04-52e82646d35mr9330064e87.2.1720044327388; Wed, 03 Jul 2024
 15:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703215905.2031038-1-robh@kernel.org>
In-Reply-To: <20240703215905.2031038-1-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 3 Jul 2024 16:05:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLB4Ec2tTpNWCT+Bu9rFDOqsxSmcchKCfg3k6_8P=uhhw@mail.gmail.com>
Message-ID: <CAL_JsqLB4Ec2tTpNWCT+Bu9rFDOqsxSmcchKCfg3k6_8P=uhhw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: phy: hisilicon,hi3798cv200-combphy: Convert
 to DT schema
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 3:59=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
> Convert the hisilicon,hi3798cv200-combphy binding to DT schema format.
>
> Drop the example as arm/hisilicon/controller/hi3798cv200-perictrl.yaml
> already contains an example of this binding.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../phy/hisilicon,hi3798cv200-combphy.yaml    | 57 ++++++++++++++++++
>  .../bindings/phy/phy-hi3798cv200-combphy.txt  | 59 -------------------
>  2 files changed, 57 insertions(+), 59 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,hi379=
8cv200-combphy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-hi3798cv200=
-combphy.txt
>
> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,hi3798cv200-=
combphy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,hi3798cv200-=
combphy.yaml
> new file mode 100644
> index 000000000000..814504492f30
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/hisilicon,hi3798cv200-combphy=
.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/hisilicon,hi3798cv200-combphy.yam=
l#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon STB PCIE/SATA/USB3 PHY
> +
> +maintainers:
> +  - Shawn Guo <shawn.guo@linaro.org>
> +  - Jianguo Sun <sunjianguo1@huawei.com>

And this bounces, so I guess Shawn is stuck with it...

Rob

