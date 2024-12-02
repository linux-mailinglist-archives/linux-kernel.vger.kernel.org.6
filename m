Return-Path: <linux-kernel+bounces-428085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222DA9E0C26
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF23B86F6D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E651DC19A;
	Mon,  2 Dec 2024 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn1qsH8V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A61DB37B;
	Mon,  2 Dec 2024 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160752; cv=none; b=FvzUX3EfxxmgaZZBW/eo7qlJKlnaJSygcwXR+A3w1S96mxx4Y818m7ursJfQH86paqMJ+o+vk/54kngm5LkIfbev1Jqb1KUG3ZDoTD7v/SROlMXXZVNysGS0cL/g94cI1/JTnyK2IQCdoCqF8n4iUGJ5eGXTFxH3zh86r8fdF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160752; c=relaxed/simple;
	bh=w6qO0Ed/ublU69cCli1C54Cmd72s6/ejpFNGotr9uzI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Q03l5fuPQqcLrE4CzIgNALXOwsT2sbYVqtVK5bBeA/4B6MPvXR8J8Q/qQrGlKunz3rQQThpjI4O2VgvC4hM1w1nfD6xXNz1P2hhfTb3dQmkw6qbXEHkyeTLzG8GhcieWJR9Brz14y9S5XKAqSMrkNX8qT5oOlGsvFSgyi+9E9rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rn1qsH8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B186C4CED1;
	Mon,  2 Dec 2024 17:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733160751;
	bh=w6qO0Ed/ublU69cCli1C54Cmd72s6/ejpFNGotr9uzI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Rn1qsH8VMjXlRnQHHa9Dv++TvuG6MSvi1tGugzebcjkhjuluwxukyhCupbFV3tNGs
	 HiJXBOa2SA9qR24iA06crMO49iD1hjRj6xOrgv+KM+hAXv5H4KqKCwuQXsek6+ZB5Z
	 5mD8+l/gJywwdqKjA6MlYbOGTaNrnv9UytiEwNGtyBgMFTu9zUz4kHsNs3BJ4/yilz
	 eui4ZFhp27082Kjc4dl1tu+BzDq1HMxknSaa+wXulCEl7FoMhZKX2w9puG2tAJH80/
	 9bKhZL4ih+nN2yEb7em2KP/SjlLMc5WYGWIyZG/+G+B46RzbSvaiG7TTO9YlgPLwOW
	 tuwHh3GKVUGSA==
Date: Mon, 02 Dec 2024 11:32:29 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org, 
 devicetree@vger.kernel.org, David Jander <david@protonic.nl>, 
 Richard Weinberger <richard@nod.at>, kernel@pengutronix.de, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Heiko Schocher <hs@denx.de>, 
 linux-kernel@vger.kernel.org
To: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <20241202-mb85rs128ty-v1-2-a660b6490dc8@pengutronix.de>
References: <20241202-mb85rs128ty-v1-0-a660b6490dc8@pengutronix.de>
 <20241202-mb85rs128ty-v1-2-a660b6490dc8@pengutronix.de>
Message-Id: <173316074958.3037004.1498863519585640694.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: mtd: mchp48l640 add mb85rs128ty
 compatible


On Mon, 02 Dec 2024 17:35:21 +0100, Jonas Rebmann wrote:
> Add a compatible string to support Fujitsu MB85RS128TY.
> 
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.example.dtb: eeram@0: compatible: ['microchip,48l640'] is too short
	from schema $id: http://devicetree.org/schemas/mtd/microchip,mchp48l640.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.example.dtb: eeram@0: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/mtd/microchip,mchp48l640.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241202-mb85rs128ty-v1-2-a660b6490dc8@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


