Return-Path: <linux-kernel+bounces-176421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB228C2FA5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 07:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5E61F22EA5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 05:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5508147A57;
	Sat, 11 May 2024 05:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U525xzTt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A09802;
	Sat, 11 May 2024 05:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715405074; cv=none; b=Fz34FStUPYnQONpECuGytQz1HLuULhgDXFLZU9pHTN+osQiNA4Rt0cxhclgCoTKiXybWAbwJasBHTHDxiGblkS3N5CaAlXZvCKRccUK5eRkVdIcdrSYOGY+I/uDyUJskgwQ2Ves+ytLnMbbJRjq5HSasBELOcy/P0rz8vLaOkRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715405074; c=relaxed/simple;
	bh=kOQ8x1Fm8V2CQ7D98GqenBmzFJuc+RnMxi15uw73/9s=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=CyG+VElCjKOjkQKPbP1wFMZnsezI3pUoNsP3wBfcOQnnj46usbBXLklB7OXe2AIyB5ZGcMCeh4vZrd/RqXFKfEy4XWwN4DWqbwMl3w7a/IgESW9ipfUsDduy+RQm5Oz5VmFn/B+broY0jYKcnpFNgeAsGbVuMYuGJ1GXxhUN1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U525xzTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7DFC2BD10;
	Sat, 11 May 2024 05:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715405074;
	bh=kOQ8x1Fm8V2CQ7D98GqenBmzFJuc+RnMxi15uw73/9s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=U525xzTt8u2UyOD0Cg5gI4KRm1l4W+PtlN9DouphKqUGShKv9NP8xtititJyUYMzc
	 BhiG/+oFivleq+QTVzpfN4a8wFEua4e0WHOCDJ2JVMl0TUPhKS50R8t3SiOLbXJ3mL
	 Gi9u7eeqdj/WS9tJG5IX16gMVhWIuqfM3ythc9bT23mLRXGHEyFIY+uv8xXNK3dNE1
	 YXGvCyom2zNHxP6ros9oeOi4sppfNA8PvJ1wupywzDTBRytp/JPd207GW2OouXkyH4
	 XjJM5eudgHDKbYJ2k/AOLEWIbo4hgV5YY9CtS4m+jwSnbaXUj+ccmw8+dNOxQ3i9ja
	 n2PJb7j0IWz2Q==
Date: Sat, 11 May 2024 00:24:32 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Aryabhatta Dey <aryabhattadey35@gmail.com>
Cc: skhan@linuxfoundation.org, linux-sound@vger.kernel.org, 
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, javier.carrasco.cruz@gmail.com, 
 krzk+dt@kernel.org, broonie@kernel.org
In-Reply-To: <j2f5m3lydlkipt3vnyikeoq5bx6tsf6z22ljpspcgtnohy65on@htyjjd3ojkde>
References: <j2f5m3lydlkipt3vnyikeoq5bx6tsf6z22ljpspcgtnohy65on@htyjjd3ojkde>
Message-Id: <171540507205.1412542.3948533586469324311.robh@kernel.org>
Subject: Re: [RFC PATCH] ASoC: dt-bindings: alc5623: convert to dt schema


On Sat, 11 May 2024 10:11:24 +0530, Aryabhatta Dey wrote:
> Convert Documentation/bindings/devicetree/alc5623.txt to yaml.
> 
> First attempt at a dt schema conversion patch.
> Checked the yaml file with make dt_binding_check and make CHECK_DTBS=y.
> Only warning being produced is
> Documentation/devicetree/bindings/net/snps,dwmac.yaml: mac-mode: missing type definition
> Not sure how I should handle this.
> 
> Signed-off-by: Aryabhatta Dey <aryabhattadey35@gmail.com>
> ---
>  .../devicetree/bindings/sound/alc5623.txt     | 25 ----------
>  .../bindings/sound/realtek,alc5623.yaml       | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/alc5623.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/realtek,alc5623.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/realtek,alc5623.example.dtb: codec@1a: '#gpio-cells' is a required property
	from schema $id: http://devicetree.org/schemas/sound/realtek,alc5632.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/realtek,alc5623.example.dtb: codec@1a: 'gpio-controller' is a required property
	from schema $id: http://devicetree.org/schemas/sound/realtek,alc5632.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/realtek,alc5623.example.dtb: codec@1a: 'add-ctrl', 'jack-det-ctrl' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/realtek,alc5632.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/j2f5m3lydlkipt3vnyikeoq5bx6tsf6z22ljpspcgtnohy65on@htyjjd3ojkde

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


