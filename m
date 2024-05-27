Return-Path: <linux-kernel+bounces-190299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8CD8CFC94
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E3F1F22672
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88142132492;
	Mon, 27 May 2024 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwLi7YXk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EF48BF0;
	Mon, 27 May 2024 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801361; cv=none; b=ii9hYE9MR33mdhO8Oh6oGVc1LACRgOFT5GScxkv/YUgNDuskRLvTmbHQEfvgBOcQw2ORme0kG0x86ZEGb/fUvPCrLYxINDq5e91DrOpCGTI4eilpBVegQJ/YjGog7PlveIvStvG691AOyInF98TtM94DY0oAhJArh1EkMeC5hHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801361; c=relaxed/simple;
	bh=kHuxnuK7Desk/N+IPyXzbt83uiVcs+xURs8rC8z/8mE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=WwidwlTe1afspgxmncNT9WGdx388QLQ9D4G985SI1uM14M5atKE8JIOm+AnNjlyrC3mwGyB+BROBjN7xWriUadNotpHaONbYhiALCE20v4CxcGS/IcHES8BNCOhZ7c1lAS1nHjgFy/7EmYH4GVlkF/sG24eRDv9INKU6hHY1HKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwLi7YXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1606FC2BBFC;
	Mon, 27 May 2024 09:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716801361;
	bh=kHuxnuK7Desk/N+IPyXzbt83uiVcs+xURs8rC8z/8mE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=cwLi7YXkzWx8/v9pWLl+jtmGUvSB6Z+qbFloVH2yh4K+TaJzoBZioSSv4HPg8ENMA
	 20B3oDLR2Kj+p6dg2G35l3bcu2oDnobqx1tRAI9/RcApjyofE+yIgDZm5iToWZf6+Y
	 LYSzYfUiB7iMR0o/KRfTZET8t/KU8hFBKkAjk7iPcrHQbn5tsZmHSEVVCoZiaSgvAx
	 797MFRDEtNJVYsqtcRCflI12nO8a51ap25z1nbETK51OGtygPXFZ6kNk1Tu3jSake8
	 QVrV144SZJixGWArl0ugeuGIjvKNWMSvCzNYrlVTKoGBVTJB0vWiuNrBGXuHooEQrj
	 Bd1oV6ygyrlkg==
Date: Mon, 27 May 2024 04:16:00 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org, 
 Thomas Gleixner <tglx@linutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Lucas Stach <l.stach@pengutronix.de>
In-Reply-To: <20240527083402.30895-2-alexander.stein@ew.tq-group.com>
References: <20240527083402.30895-1-alexander.stein@ew.tq-group.com>
 <20240527083402.30895-2-alexander.stein@ew.tq-group.com>
Message-Id: <171680135999.3825292.7751628816521294257.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: interrupt-controller:
 fsl,irqsteer: Add imx8mp/imx8qxp support


On Mon, 27 May 2024 10:34:01 +0200, Alexander Stein wrote:
> Some SoC like i.MX8MP or i.MX8QXP use a power-domain for this IP. Add
> SoC-specific compatibles, which also requires a power-domain.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  .../interrupt-controller/fsl,irqsteer.yaml    | 23 ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml:85:17: [warning] wrong indentation: expected 14 but found 16 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240527083402.30895-2-alexander.stein@ew.tq-group.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


