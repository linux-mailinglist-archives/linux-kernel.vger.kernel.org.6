Return-Path: <linux-kernel+bounces-321082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F74971437
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 882B6B2600A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD0B1B5EB1;
	Mon,  9 Sep 2024 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGeFRhVq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA171B5835;
	Mon,  9 Sep 2024 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875117; cv=none; b=E2xz625LCzgKL94zHC3BUSjA4HOursQww5RS4HVg+4Ax41u4T44l+aXuk0Es70toBW4rhjHKz2xSk3hYXtewN6p7drM/JAyg74Uv970BtM3/lR72Q6P+xTNRL3CHCYk5L1+7I2zqc+iUq2wQEuaYyMadWwYY0PGRhpOIIowN88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875117; c=relaxed/simple;
	bh=Sy8tIjBNmM1TRUzcJXCUhh1mqs86wxvQSZ1p+66Dj58=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=K6SZy9/3xu9cpfT1cInj/14A70MNL3iszDoAoGV7KpOD/stNVLtRLYxk2w41V3FkQ0JHIsom61NmBoezyITSWJOIO98zhZ5GPpoRfcs205JHN0YNfHMBIm7DPTGsgvWECWF7ZUwdM4U6+IFYOANgRGWVucVphN/4+Mlg6ZSMMYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGeFRhVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750F6C4CEC6;
	Mon,  9 Sep 2024 09:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725875116;
	bh=Sy8tIjBNmM1TRUzcJXCUhh1mqs86wxvQSZ1p+66Dj58=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=AGeFRhVqLwym8HdlUvvjj0gDJJL50PImaY3QPhp06zyo/IPR75uHOfQTLOlpTuf5a
	 7Kt5eN799iwHpzOOS8rgfkp+v40b6/l3Sg6H/0yY4K6GNWouZo0C3p8UZuolhOJp7F
	 GMxJ2xa0IvNYWgQfRyvxMXYwamVynPR5AZdPsA3Qx13vGJtO0uLnePrt94E6GfSxJ/
	 0jnOO8k6BWwp1MS9yeK/JD2MF+G5cglqB4D7nTCVz/v8kljpNfh3AJKNZ8itkj4Jxq
	 iWXLkY+ll2URldPk+u90VMAy/CCpocFXw5Tv3UBxbjqbrhytAzQSUByJJ8N+09wgRq
	 3Y/Xeb51wdz0g==
Date: Mon, 09 Sep 2024 04:45:15 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, 
 devicetree@vger.kernel.org, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240909-ep93xx-v12-26-e86ab2423d4b@maquefel.me>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
 <20240909-ep93xx-v12-26-e86ab2423d4b@maquefel.me>
Message-Id: <172587510574.3289347.13428229502945946923.robh@kernel.org>
Subject: Re: [PATCH v12 26/38] ASoC: dt-bindings: ep93xx: Document DMA
 support


On Mon, 09 Sep 2024 11:10:51 +0300, Nikita Shubin wrote:
> Document DMA support in binding document.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> ---
>  .../devicetree/bindings/sound/cirrus,ep9301-i2s.yaml         | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240909-ep93xx-v12-26-e86ab2423d4b@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


