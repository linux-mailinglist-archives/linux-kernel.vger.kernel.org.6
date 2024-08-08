Return-Path: <linux-kernel+bounces-279429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6BC94BD36
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515641C22A7D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD9018C918;
	Thu,  8 Aug 2024 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBtAruPe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87021487C1;
	Thu,  8 Aug 2024 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119382; cv=none; b=YvtK/wHgK7oJ4eVTpep2camwWlNpoFoH+on8xtzhP0IO6R7vfPG6qi/pGbS5NxW27rtGzHc73KqPAG5A0k7YaYMjtDOcYxvFdPPGf0J5/XyexHto/pBTMTjBUPQHyjA9R3G5BUJY7yC1xrC4/HjitUO+CkEARL+JipD5Ra7OaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119382; c=relaxed/simple;
	bh=9gyaJEUMUMSe2uDu+d3QbguiaZOSU0iKh7jcahtV+uU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=FqPPfHd+NnAG77sce+x3SF/Y8DwTLQ4svd67c/qluqiIibc3tV1Ap9Uqji0JPcKbDweDTlO9yYdqWKhITc8w9G2XSfWaGzQcZVLYoBmIxrvIO0lxWhSQiQ1u87iOLmndD/EYwzWhOqseKvj1s1XuujtNPcqDq3xGSmqTLNYMUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBtAruPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BADAC32782;
	Thu,  8 Aug 2024 12:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723119382;
	bh=9gyaJEUMUMSe2uDu+d3QbguiaZOSU0iKh7jcahtV+uU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gBtAruPebUYpBpqupwKxeMEth5wWYn8LnIPQtOqxxmHTS6wWuWBE7QCFTlsCHAl4J
	 515HgoAWOY7jlwF5Ll2iVdnbaNMhFVwgmQhjFl/Kts1fKfe4liC+uvw9FDKmrAJ2DR
	 QICteE7YmxXmEx+GUU67hPkJtCjnB9oSJcrO3hrd7sr3+JmMeqnZe4vM8q3CQ1GYQk
	 FrDa94zs6v48LbCfQCImbK1RqbZwv8lMo8zMZaOZKKa7raJqlURlOTfhpeXtyq/BVX
	 8NyQ5YMwr9dtPLQ878HOZOh88bmycX92LRIvYorOxrgu+wKydmmkVBfHy4t5QWKutN
	 wrzDkLsmUyIiw==
Date: Thu, 08 Aug 2024 06:16:21 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Sen Chu <sen.chu@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chris-qj chen <chris-qj.chen@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Macpaul Lin <macpaul@gmail.com>, 
 MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Alexandre Mergnat <amergnat@baylibre.com>, devicetree@vger.kernel.org, 
 Jason-ch Chen <Jason-ch.Chen@mediatek.com>, 
 Bear Wang <bear.wang@mediatek.com>, Conor Dooley <conor+dt@kernel.org>, 
 Pablo Sun <pablo.sun@mediatek.com>
In-Reply-To: <20240808105722.7222-1-macpaul.lin@mediatek.com>
References: <20240808105722.7222-1-macpaul.lin@mediatek.com>
Message-Id: <172311938097.907347.11999674320636548730.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format


On Thu, 08 Aug 2024 18:57:22 +0800, Macpaul Lin wrote:
> Convert the mfd: mediatek: mt6397 binding to DT schema format.
> 
> New updates in this conversion:
>  - Align generic names of DT schema "audio-codec" and "regulators".
>  - mt6397-regulators: Replace the "txt" reference with newly added DT
>    schema.
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../bindings/mfd/mediatek,mt6397.yaml         | 202 ++++++++++++++++++
>  .../devicetree/bindings/mfd/mt6397.txt        | 110 ----------
>  2 files changed, 202 insertions(+), 110 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/mt6397.txt
> 
> Changes for v1:
>  - This patch depends on conversion of mediatek,mt6397-regulator.yaml
>    [1] https://lore.kernel.org/lkml/20240807091738.18387-1-macpaul.lin@mediatek.com/T/
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6397.example.dtb: pmic: regulators: 'oneOf' conditional failed, one must be fixed:
	'buck_vpca15', 'ldo_vgp4' do not match any of the regexes: '^(buck_)?v(core|dram1|gpu|modem|pa|proc1[12]|s[12])$', '^(ldo_)?v((aux|cn|io|rf)18|camio)$', '^(ldo_)?v(aud|bif|cn|fe|io)28$', '^(ldo_)?v(a|rf)12$', '^(ldo_)?v(cama[12]|camd|cn33|dram2|efuse|emc|ibr|ldo28|m18|mc|mch|mddr|sim[12])$', '^(ldo_)?vsram[_-](core|gpu|others|proc1[12])$', '^(ldo_)?vusb$', '^(ldo_)?vxo22$', 'pinctrl-[0-9]+'
	False schema does not allow {'compatible': ['mediatek,mt6397-regulator'], 'buck_vpca15': {'regulator-name': ['vpca15'], 'regulator-min-microvolt': [[850000]], 'regulator-max-microvolt': [[1400000]], 'regulator-ramp-delay': 12500, 'regulator-always-on': True}, 'ldo_vgp4': {'regulator-name': ['vgp4'], 'regulator-min-microvolt': [[1200000]], 'regulator-max-microvolt': [[3300000]], 'regulator-enable-ramp-delay': 218}}
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6397.example.dtb: pmic: regulators:compatible: 'oneOf' conditional failed, one must be fixed:
		['mediatek,mt6397-regulator'] is too short
		'mediatek,mt6358-regulator' was expected
		'mediatek,mt6366-regulator' was expected
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6397.example.dtb: pmic: regulators: Unevaluated properties are not allowed ('buck_vpca15', 'ldo_vgp4' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#

doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/mt6397.txt
Warning: Documentation/devicetree/bindings/leds/leds-mt6323.txt references a file that doesn't exist: Documentation/devicetree/bindings/mfd/mt6397.txt
Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml: Documentation/devicetree/bindings/mfd/mt6397.txt
Documentation/devicetree/bindings/leds/leds-mt6323.txt: Documentation/devicetree/bindings/mfd/mt6397.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240808105722.7222-1-macpaul.lin@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


