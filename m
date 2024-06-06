Return-Path: <linux-kernel+bounces-204626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76FD8FF164
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35AD41F238D6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A39198E71;
	Thu,  6 Jun 2024 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxHxUkDy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A11990B7;
	Thu,  6 Jun 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689379; cv=none; b=Hmwqqc9ouy18lRycd0YmsvW+YNCAbXP5I33h+86ATpU2R9kTNgxMJWjwcQDLfTXASEX/NgpfAt+jmmABbgY/RvvnK9bjI8IcWALfYTNUrwmd7aG0Gk6CZBvn7H2XUQ3490RY5gd/oMhw9jyfRsbOLaK/0MXKFWDgBNTNgp0Gqxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689379; c=relaxed/simple;
	bh=tgSaH7pDA3q488BIGAg9INFjOhEWBEU92Cre1GIHnnA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Y68nrvd21DMLC/FDdqdli3V4k4NxnbXLql+k/ssGaLv3Vswv24Uyjij3QrcciNRihAsLGLJoutFIOud4fEfxF/UowjVF+pCOkJAcoDfIgMRAdaBOVwtgvvGWWGZxZGbFcrc6dLz8OsACXPGzWWQ7Cuneh7jyEwXDPuD6wlWiox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxHxUkDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA4EC32781;
	Thu,  6 Jun 2024 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717689378;
	bh=tgSaH7pDA3q488BIGAg9INFjOhEWBEU92Cre1GIHnnA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nxHxUkDy5SRXgOUC05eRFC9BM0omMZ1mJdaJJ5BTQ8mSdDDepnOjlXjqS/4JUjWoq
	 7EuUUBdiYF7wGJH3Wimq2/EgzENSUqdtPWE/6bSrBUmttExLsHFlxngfNObfFtdEkS
	 BUl1QNfQH5rbO9257a0+EHiJO2aT2Hz88curu3ZWONVInuRcoQSfomCBEbB3UuLIqg
	 rmfR9u6F7TRzdbpoGCkIYv09MJa9fbXWuvBa3DYlw/MvhBBbefYGiO7kE5pBWY3Sfi
	 7OJRysDSPVMqJyolD54U0YUjea88gIXWW/+tboACn8KlCd5VHuxb9yMof763cUZnGz
	 t+FJ+DMqmnP+Q==
Date: Thu, 06 Jun 2024 09:56:17 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240606094513.3949323-1-christianshewitt@gmail.com>
References: <20240606094513.3949323-1-christianshewitt@gmail.com>
Message-Id: <171768925717.3793270.14812356444317886177.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: add dream vendor prefix


On Thu, 06 Jun 2024 09:45:11 +0000, Christian Hewitt wrote:
> Add a vendor prefix for Dream Property GmbH
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
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


New warnings running 'make CHECK_DTBS=y amlogic/meson-g12b-dreambox-one.dtb amlogic/meson-g12b-dreambox-two.dtb' for 20240606094513.3949323-1-christianshewitt@gmail.com:

arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dtb: /soc/bus@ff600000/bus@42000/clock-controller@0: failed to match any schema with compatible: ['amlogic,g12a-audio-clkc']
arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dtb: /soc/bus@ff600000/bus@42000/clock-controller@0: failed to match any schema with compatible: ['amlogic,g12a-audio-clkc']
arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dtb: /soc/bus@ff600000/bus@42000/audio-controller@744: failed to match any schema with compatible: ['amlogic,g12a-tohdmitx']
arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.dtb: sys-ctrl@0: '#address-cells', '#size-cells', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml#
arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dtb: /soc/bus@ff600000/bus@42000/audio-controller@744: failed to match any schema with compatible: ['amlogic,g12a-tohdmitx']
arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.dtb: sys-ctrl@0: '#address-cells', '#size-cells', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml#






