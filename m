Return-Path: <linux-kernel+bounces-415318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5949D3445
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FB21F2321A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598FF15ECDF;
	Wed, 20 Nov 2024 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRelD/ug"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41E115533F;
	Wed, 20 Nov 2024 07:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088601; cv=none; b=pmEGVwNYWj65IUiDQQlrEbpOBMs/22O2AtDuSBzN2zxfi2XHopLnBTiLgAyp6cUIhK0wDRGdaXX94X5irakuC4A8RFOQ0CifwgoNceofFMi0gw0Vhhhj6tUEx2QiNQoCZgIjglOYU6Gfs4V8Z1lzCLO8LaXkd35lgMytKaiodvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088601; c=relaxed/simple;
	bh=e/qUlesIoPvZnfcqTn241IZzsmmY5zAWI/3JuDmPcI4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=RTfibMhiWBGAKpV/xSil2Eu0mHZ0KTEJ0I1NIr/ehL8Ngn/zbtRNKcwqWp7uBFy94D3nRCQmx1ZInkra6wcu56UEVuK/+9vy+Iw9iiVrFWuc3+ROz2eK0mz1EFWUbKc5ZtKjcCNHx18UAEgEUWxaaHY10NmF5ec38/vS5+YsdVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRelD/ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E8AC4CECD;
	Wed, 20 Nov 2024 07:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732088600;
	bh=e/qUlesIoPvZnfcqTn241IZzsmmY5zAWI/3JuDmPcI4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=aRelD/ugp1snYM/kKpdtKr6Pccv4S5hAB/A9s1gzKwQBRXVnfQ8quE1f0Z44TZE1u
	 LTqnBiIsXd2yWB//vRsHfL9toCQh9Rh87Hg5nnJmI/zNqUWg585bvcKrv61I3P3LyX
	 Ee0UrHMabol2nP5m92aIZuf4CL3GYZkeTQ8O3NvMcrQ8a5jGQnHIM6/JF+jar7v8CP
	 h5R3U8BP1vrxqlYi/EnhckthUaoxd2/XS9eHEXz5aglZFK0HXBkpXZ8pHjC+6yJ5yA
	 883SIV5DDA+1aFi0DHdwzAKZ8omi4WNLkYHEnO6aHQs5EvmGsM4rDD0BzZMFeGhYdl
	 l1UKaSlMI2m8Q==
Date: Wed, 20 Nov 2024 01:43:18 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Yong Wu <yong.wu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 linux-arm-kernel@lists.infradead.org, 
 Matthias Brugger <matthias.bgg@gmail.com>
To: Friday Yang <friday.yang@mediatek.com>
In-Reply-To: <20241120063701.8194-2-friday.yang@mediatek.com>
References: <20241120063701.8194-1-friday.yang@mediatek.com>
 <20241120063701.8194-2-friday.yang@mediatek.com>
Message-Id: <173208859835.3697069.14880651940019418279.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: memory: mediatek: Add SMI reset
 and clamp related property


On Wed, 20 Nov 2024 14:36:38 +0800, Friday Yang wrote:
> On the MediaTek platform, some SMI LARBs are directly linked to SMI
> Common. While some SMI LARBs are linked to SMI Sub Common, then SMI
> Sub Common is linked to SMI Common. The hardware block diagram could
> be described as below.
> Add 'resets' and 'reset-names' for SMI LARBs to support SMI reset
> and clamp operation. The SMI reset driver could get the reset signal
> through the two properties.
> 
>              SMI-Common(Smart Multimedia Interface Common)
>                           |
>          +----------------+------------------+
>          |                |                  |
>          |                |                  |
>          |                |                  |
>          |                |                  |
>          |                |                  |
>        larb0       SMI-Sub-Common0     SMI-Sub-Common1
>                    |      |     |      |             |
>                   larb1  larb2 larb3  larb7       larb9
> 
> Signed-off-by: Friday Yang <friday.yang@mediatek.com>
> ---
> 
> Although this can pass the dtbs_check, maybe there is a better way
> to describe the requirements for 'resets' and 'reset-names' in bindings.
> But I don't find a better way to describe it that only SMI larbs located
> in camera and image subsys requires the 'resets' and 'reset-names'.
> I would appreciate it if you could give some suggestions.
> 
> .../mediatek,smi-common.yaml                  |  2 +
>  .../memory-controllers/mediatek,smi-larb.yaml | 53 +++++++++++++++----
>  2 files changed, 44 insertions(+), 11 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml:143:13: [warning] wrong indentation: expected 10 but found 12 (indentation)

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.example.dts:29.43-44 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:129: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1442: dt_binding_check] Error 2
make: *** [Makefile:224: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241120063701.8194-2-friday.yang@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


