Return-Path: <linux-kernel+bounces-534298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC521A4652B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716F4189D90B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228CC224AE9;
	Wed, 26 Feb 2025 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWb0Qpvh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F865224B08;
	Wed, 26 Feb 2025 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584215; cv=none; b=LgUVLvfSQXNHX78QObVUF6ip8/VXR9x/0XYvOBQGyYVIwhPoivTK0uK4VIRaSvu6D/DzPGOV+8Ed5PsnvubogfrKGG6SmHAmPPiuYpwRN79lFtqsdd022WVWL+sJEcULDdYLISoamfaxbIskbCUB3KU9DMcT0Ut0w61OFlyCat0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584215; c=relaxed/simple;
	bh=jk2YnpRwdl0zqWfzI0pQtgICnWog+RgigvgaUWzoto8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=TWs68GynExuFHXkjcGv1FCVt75w/UpkFZp6OsRpTwXvVGPzFYRpk17SPRdpFDsAS0yew05qFdwrGaW8xAGboxb5fB8f/npMwx4DX/awWRnYGBbjc7Jit8KvJBpS37Z6BmaQyDJ7b332jnmA3BkfftxfbIiCgpdIptjnxL94b3NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWb0Qpvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D209CC4CED6;
	Wed, 26 Feb 2025 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740584215;
	bh=jk2YnpRwdl0zqWfzI0pQtgICnWog+RgigvgaUWzoto8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=rWb0Qpvhvefui+YIaT1AKdUiuLVmVx72K/GJWZcwQ0tgkfV2HW25qAaUzgb0QK68g
	 lZep904ebvCGINPTPj7MQvFzwdT79Wx97bZQAwteV4jUM+BiOF+dWAYGbgWfUGHGrg
	 SkdhHiMronBVvlQcs4obbw+XadqhVLoCsn3+uXLnuazBAvlU2nHogr62Phmq6aE0nA
	 zPuFj8YqepR5YC6AunhJiFtL0wYeq7U8ISwW34cy7H4P/lRZXI+WK84UfzLwfAPJQ0
	 oH8tj8JKLE12P8U73kIpwKXgny5/kO3zNGBQKNSayX2GABqzy67AEfmUqKMnQV/JwL
	 kz034moZPbM6Q==
Date: Wed, 26 Feb 2025 09:36:53 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, devicetree@vger.kernel.org, 
 Heiner Kallweit <hkallweit1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jerome Brunet <jbrunet@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20250226-irqchip-gpio-a4-a5-v2-0-c55b1050cb55@amlogic.com>
References: <20250226-irqchip-gpio-a4-a5-v2-0-c55b1050cb55@amlogic.com>
Message-Id: <174058387423.2466938.7799013716611230822.robh@kernel.org>
Subject: Re: [PATCH v2 0/4] Add GPIO interrupt support for Amlogic A4 and
 A5 SoCs


On Wed, 26 Feb 2025 13:47:51 +0800, Xianwei Zhao wrote:
> This patch adds GPIO interrupt support for Amlogic A4 and A5 SoCs
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> Changes in v2:
> - Use if/then instead of direct modification minimum value for property 'amlogic,channel-interrupts'.
> - Add register offsets to the parameter structure to reduce definition of a function.
> - Link to v1: https://lore.kernel.org/r/20250219-irqchip-gpio-a4-a5-v1-0-3c8e44ae42df@amlogic.com
> 
> ---
> Xianwei Zhao (4):
>       dt-bindings: interrupt-controller: Add support for Amlogic A4 and A5 SoCs
>       irqchip: Add support for Amlogic A4 and A5 SoCs
>       arm64: dts: Add gpio_intc node for Amlogic A4 SoCs
>       arm64: dts: Add gpio_intc node for Amlogic A5 SoCs
> 
>  .../amlogic,meson-gpio-intc.yaml                   | 13 +++++++
>  arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 21 +++++++++++
>  arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        | 12 +++++++
>  drivers/irqchip/irq-meson-gpio.c                   | 42 +++++++++++++++++++---
>  4 files changed, 83 insertions(+), 5 deletions(-)
> ---
> base-commit: 953913df9c3ab6f496c6facd5aa7fc9f2f847ac2
> change-id: 20241213-irqchip-gpio-a4-a5-80c50a1456c4
> 
> Best regards,
> --
> Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/amlogic/' for 20250226-irqchip-gpio-a4-a5-v2-0-c55b1050cb55@amlogic.com:

arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dtb: interrupt-controller@8e72c: amlogic,channel-interrupts: [140, 141] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/amlogic,meson-gpio-intc.yaml#






