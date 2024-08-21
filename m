Return-Path: <linux-kernel+bounces-295531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4C1959C58
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E355BB27497
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B042D193432;
	Wed, 21 Aug 2024 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWG7ju8K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F63155307;
	Wed, 21 Aug 2024 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244575; cv=none; b=AK2VtgVWhHYshlYf8Kbs6dId2qApYk9i2cYWhuhTaRu/9xnP6PoihDE6er1NKzfwcfW7ioSBW7Jnkdf3iMkvfXvrsesZDAlouxNRp5SgEg73ZiIo6ZmATjx28EIwYDhCEIFpEH3pA6YNDhVW95gMUIG34ViX+n5M4XSOTnwivNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244575; c=relaxed/simple;
	bh=AXxmUU4wdER3ZZjM11AkrS+24GgkSlMY6GankGo8It0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=PzJ5zDAu9xGjXs+f4pSiB5lSmzYhoaCOcCDclshfMK5rAwKxFQvF5Tx3HKmFre0T+GBXndAhNfW/HqYFsbtQEpE2JH5oFLfFE50AsGa6Gkbc+pSoaQJpl+t1s/c0hjYFGXdU0u30uZfWnO900mBXHWZIeCtMeq+HqrnYBXsF4mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWG7ju8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A77EC32782;
	Wed, 21 Aug 2024 12:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724244574;
	bh=AXxmUU4wdER3ZZjM11AkrS+24GgkSlMY6GankGo8It0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=SWG7ju8KMMWojJ6QeXRG0k/6unfDyHUixpMtJbCdG/G6VRdJxRFD7EOqYrGA33Ja7
	 g9N2EF9qklpYK1V4VsWaZTBcaEaBt2qxUFVQKNDCMF9mYgBNJdj01jLPvllZNpPSMl
	 YzWmB1kR6IE38Eb9k9DTXjVsGSHJMzcqliQyDbgm+0+crd1S454A4or0O9FUVJcvb7
	 UMqjjp+i3bxoIFRdSwu/RgvuVRNYg1pJPOLSL8wkmvOJbTGYLFHRU3ERrnhV21gWgl
	 F2wwGwI8tiF9F2Bfr7s4vP1nQgS/ua5Ji3BNHlkorw6cHkK5rskQ/SIUtGrFKGBrKw
	 hAQR+O/q8wjeg==
Date: Wed, 21 Aug 2024 07:49:32 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Alexander Dahl <ada@thorsis.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christian Melki <christian.melki@t2data.com>
In-Reply-To: <20240821105943.230281-4-ada@thorsis.com>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-4-ada@thorsis.com>
Message-Id: <172424457261.3725889.15234571126892278786.robh@kernel.org>
Subject: Re: [PATCH v1 03/12] dt-bindings: nvmem: microchip-otpc: Add
 compatible for SAM9X60


On Wed, 21 Aug 2024 12:59:34 +0200, Alexander Dahl wrote:
> The SAM9X60 SoC family has a similar OTPC to the SAMA7G5 family.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  .../devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.example.dtb: efuse@e8c00000: compatible:0: 'microchip,sam9x60-otpc' was expected
	from schema $id: http://devicetree.org/schemas/nvmem/microchip,sama7g5-otpc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.example.dtb: efuse@e8c00000: compatible:1: 'microchip,sama7g5-otpc' was expected
	from schema $id: http://devicetree.org/schemas/nvmem/microchip,sama7g5-otpc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.example.dtb: efuse@e8c00000: compatible: ['microchip,sama7g5-otpc', 'syscon'] is too short
	from schema $id: http://devicetree.org/schemas/nvmem/microchip,sama7g5-otpc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.example.dtb: efuse@e8c00000: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/nvmem/microchip,sama7g5-otpc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240821105943.230281-4-ada@thorsis.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


