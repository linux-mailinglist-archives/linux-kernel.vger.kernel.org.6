Return-Path: <linux-kernel+bounces-170391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3DB8BD62F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 22:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71523B21999
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A900115B102;
	Mon,  6 May 2024 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5jBP/Oa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA915B136;
	Mon,  6 May 2024 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027192; cv=none; b=BHZdvE+u68Q0kg3lDRNVi1R1m4VEZo52C1kZc3TPBTOANs9KE4fpgt7ACe7QmKeE7S/xA05JfZXc71K7jOL/kozdmfVHloy3U+WbVfXt0QKx4E2PIzjTMnCSD6XOQXFlRkgOg/hUllrF+KslwF7LUkEj2Skr47cB/1C/3YOVNnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027192; c=relaxed/simple;
	bh=5FaFsrCBU94mRwsXyuX1NTdoCg00sIuyi7QCDGgdxuY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=jkVBICuf2k8o5qFX2i2bW7MRnpw6pTwWnaeRu2Tg6PSqpxnt7J9WyQE25rvTyXU8KURJ2gnweJUCOdfulN00sP3yNle9A0leWkBkW4i7A+7j1n9hUpPbNFtNjamQY5OJMcByBJlZ1rHF79cDYJ3+p0BZ1GmiZhV5tjQuuM9PVsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5jBP/Oa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340EDC116B1;
	Mon,  6 May 2024 20:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715027191;
	bh=5FaFsrCBU94mRwsXyuX1NTdoCg00sIuyi7QCDGgdxuY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=X5jBP/Oalm1vimfJv8a8bJ2lC/hwUzE8jRbYArIZW6zWV9/WC17q8O1vfeaq9+Scr
	 DzpOL6XPw6jdh4AxeaDG2/YR49NdXmnvBdNiecxOMt+s0T9A1srdlQdUyeQYuiEbfB
	 3I4cl5KJLwovDDPBjeZ8QXn8/gWssyIv/2WxMocJo++YBkAf760x5PegRrdkbU4hvl
	 S1O00hdRTekYjk/1ChmyTEg0mJ52bYBdMxJt8Q2rSOaU2LGmCKKmyf6MtRtkThhSny
	 fAkJ/nlTXUmBmT+iSh5WSn60lzRDXUhe2/8AFu6YaVd60EGrqdln2SsIoiiAWCYHLZ
	 yW+pAp1qVdwFA==
Date: Mon, 06 May 2024 15:26:29 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, 
 linux-rockchip@lists.infradead.org, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, vkoul@kernel.org, quentin.schulz@cherry.de, 
 linux-arm-kernel@lists.infradead.org, kishon@kernel.org
In-Reply-To: <20240506124836.3621528-2-heiko@sntech.de>
References: <20240506124836.3621528-1-heiko@sntech.de>
 <20240506124836.3621528-2-heiko@sntech.de>
Message-Id: <171502718485.3739.8024239966625128556.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Rockchip MIPI CSI/DSI PHY
 schema


On Mon, 06 May 2024 14:48:35 +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> Add dt-binding schema for the MIPI CSI/DSI PHY found on
> Rockchip RK3588 SoCs.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>  .../phy/rockchip,rk3588-mipi-dcphy.yaml       | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/phy/phy-rockchip-mipidc.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.example.dtb: phy@feda0000: reg: [[0, 4275699712], [0, 65536]] is too long
	from schema $id: http://devicetree.org/schemas/phy/phy-rockchip-mipidc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240506124836.3621528-2-heiko@sntech.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


