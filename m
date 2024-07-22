Return-Path: <linux-kernel+bounces-259294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F23C9393A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFDD2810A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543E5170850;
	Mon, 22 Jul 2024 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npuMCOOr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAF1770E6;
	Mon, 22 Jul 2024 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673681; cv=none; b=YPqt71DtHevK+exNrBWG0k8j0jg+lz9lyNumrTljrUGiYe1DuE2sEEngovMEokFepkCnlUQeDzsYsscQVafQmVvzgExrTRa+td1lU/pD7octPXXk2hAWEVhOUOaCrD64Gmd+TbaFMiq00ULg8DweEAmmWoBKfVfSgo+ryUwjjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673681; c=relaxed/simple;
	bh=pjVpDue3MFwWNWnMBUNHk2Q/wswn4BTAbLMZ9AEkuUc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=NkfP/IjBUHce3RviUhravHdVih8NTkmbuq4pca9LJNurgzd8g7TSE0woB79Rk7Glu9YYwG/nZnSYdecuSpUNtK79tq2+Gjxuf/+uozPUppTW0Y29ErivxfWbbsQhGlw0nQ38q8wHEdq3JHvn56pZlKftyta/FE4c01uUZQcxIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npuMCOOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E10C116B1;
	Mon, 22 Jul 2024 18:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721673681;
	bh=pjVpDue3MFwWNWnMBUNHk2Q/wswn4BTAbLMZ9AEkuUc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=npuMCOOrmNSziA9LbQ8Syf4zi3i4oTX300wYJjk6cRfsNYPnGoMS6R5XmtI8KdBmR
	 RpZhzrOlyiY3DNo0h5RhoczpKwIZviPrsQWIZDjZsreMOYzfqWl9b3oz4AHVtvaN1Q
	 WLbb/OlCZRHW+ACVXKyX6k26NHsz+Dd+JTzUIq8fsl53aAyzNxlbsZVUL4BG9mPgB7
	 GXCLxCLKLKWx3h11v8FIS+6m5MArGOYkps2grGmCbmWsafsVq+0u/xabHmIMvRX5SO
	 vX+xvuYQqL9B0Ole7l+IPwcBj9enKBf/S1HzpFSm2xa+NAUbXbH0vpxfyLajbWW4Kq
	 BCGiCJhATEaWQ==
Date: Mon, 22 Jul 2024 12:41:17 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: ysionneau@kalrayinc.com
Cc: Jonathan Borne <jborne@kalrayinc.com>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Julian Vetter <jvetter@kalrayinc.com>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240722094226.21602-3-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-3-ysionneau@kalrayinc.com>
Message-Id: <172167363239.4080.15874423880359295295.robh@kernel.org>
Subject: Re: [RFC PATCH v3 02/37] dt-bindings: soc: kvx: Add binding for
 kalray,coolidge-pwr-ctrl


On Mon, 22 Jul 2024 11:41:13 +0200, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
> 
> Add binding for Kalray Coolidge SoC cluster power controller.
> 
> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
> ---
> 
> Notes:
> 
> V2 -> V3: New patch
> ---
>  .../soc/kvx/kalray,coolidge-pwr-ctrl.yaml     | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/kvx/kalray,coolidge-pwr-ctrl.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/kvx/kalray,coolidge-pwr-ctrl.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/kalray/kalray,coolidge-pwr-ctrl.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/kvx/kalray,coolidge-pwr-ctrl.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/kvx/kalray,coolidge-pwr-ctrl.example.dtb: pwr-ctrl@a40000: reg: [[0, 10747904], [0, 16728]] is too long
	from schema $id: http://devicetree.org/schemas/kalray/kalray,coolidge-pwr-ctrl.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240722094226.21602-3-ysionneau@kalrayinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


