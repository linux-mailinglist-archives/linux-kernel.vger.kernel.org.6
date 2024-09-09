Return-Path: <linux-kernel+bounces-321079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9404797142E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5254C284B2A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32CE1B3B16;
	Mon,  9 Sep 2024 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwCz+g3m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4121B4C5A;
	Mon,  9 Sep 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875113; cv=none; b=AcdTIJ72Bd02+3ISxJz9PRWjbF8XL6umkzc1cwuDq0iYgK8USeUC8F9FuDNT3hTCe2jrm8nTRpfdeogGMhSXv+AttSqRHP+L/mxjMe41oWvGva/Cn20MB/vJLXl+rmKiI7ypRjqnl6yAKlCtnPV7Uc//bIJLu47qeOQQQQgXhik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875113; c=relaxed/simple;
	bh=OpoEq4rq2tR/fK1v7ChPxH80mWmyJhcEfy4/a87kMhE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=FoDUSWyMLMN+zm/FUNGJOQ5nQbru+rzfkQG24Tg6Ltnta0LYQ10z8CYuPRU/SLd5D4HliEnWp72ZzhPzjDNXcD/qJK7oXybCi583xgj3aRpDKzPLSWgUdBtz08UP80ak/UtbGcddF8B79fZ77O9wJmhx/nWfOa5LFdz985Tlh/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwCz+g3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4EEC4CEC8;
	Mon,  9 Sep 2024 09:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725875112;
	bh=OpoEq4rq2tR/fK1v7ChPxH80mWmyJhcEfy4/a87kMhE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VwCz+g3mUFf+nc1DPxX053KtYES3DWrH2oz2tPjikFd0evUqUl3ZOjg9NfG+bZras
	 9ZALv+uFcbQHW6jKOuh0mjxQr1b+F8NZsYsN4j8r/Yjjj9+OPm1k0MeM1x9koacCW1
	 8gOd36sELxt06KofkZK6O+clK5jexyGHq8smwUxmWe2mHupGS+FdDOMS+9rnTdLLCD
	 BLhFzALlfmPGlCJxqC5TpfJCC0xShq9lxMewXlzNVahOfRT5YPCRqEiCghuSqVjTX+
	 DusYW3ifJ0v+4ApkTFb0Ct8ymahJQRyesAPBDdca0tG2T8Qfs//ny1wUxbhUEM/XCK
	 4cVcwXJnYbEag==
Date: Mon, 09 Sep 2024 04:45:11 -0500
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240909-ep93xx-v12-18-e86ab2423d4b@maquefel.me>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
 <20240909-ep93xx-v12-18-e86ab2423d4b@maquefel.me>
Message-Id: <172587510150.3289209.1561633350794103525.robh@kernel.org>
Subject: Re: [PATCH v12 18/38] dt-bindings: mtd: Add ts7200 nand-controller


On Mon, 09 Sep 2024 11:10:43 +0300, Nikita Shubin wrote:
> Add YAML bindings for ts7200 NAND Controller.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mtd/technologic,nand.yaml  | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240909-ep93xx-v12-18-e86ab2423d4b@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


