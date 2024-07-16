Return-Path: <linux-kernel+bounces-254527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47716933455
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F197A1F22D67
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFD81428F2;
	Tue, 16 Jul 2024 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWxXG0wO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17BE1B812;
	Tue, 16 Jul 2024 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721169953; cv=none; b=YOUq/5/bwmZ17J3CywgfdoePij364AHFrejGQKI6t21Gg+6ELBvFUZlKva55sOVyRWOl7voszOMI7rxnsxuiYC7OLgrKtPz+3xacDmNToSbmW0ICr2cm2oMn7ZdA3C5GYOnQGmexJhRWd4EARoFfwk3pBCMPGK9faDStnkPRVY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721169953; c=relaxed/simple;
	bh=w276R0jHD8o5myzBdBEzxgmIblQgkaaXfmG48sGgNW8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=eHbgSY9mr1GjA3lO3dyE/rLl88ONvvhVF9Jjcciysk9/JQgrR1jGOj9ivQg/pm7CtsXr0RV9cpS1cWJ5aKF4hjTZTk6NF4eVQWnv51fn8/TpH0MGz3Rhe6C8sMC/scDDmDcIzhvxP/oPuf89K2T5TKHH48eUCqhxsf89bmWIXHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWxXG0wO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CECC116B1;
	Tue, 16 Jul 2024 22:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721169953;
	bh=w276R0jHD8o5myzBdBEzxgmIblQgkaaXfmG48sGgNW8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QWxXG0wOb8j9ivRtn3Gd38fHK50GDlmPJ604zmgSmn2Jw/5RasVl+dNIhkkg9guiW
	 KWySTN8qdHxBEo82oZ+8e9MRbWFPa+mc43ezSvzK7KG++au98L06BY2BBSN6uy1bs4
	 XUMuFwHZF0PB/sNab7TkblnQOuWC0DBYPHCgM4yMs6amDZRtSYxQPPhaN+tlkQfcMm
	 CyyV+XY+Djwx65n2ISep01f+DXgymN/brYCFyFx24iSARIMrRE3/cFEvVNWgJP71Pu
	 VShBu0+QR9fiSVHe2Z6HYGy2l6HDRnmeE0DXLnf3h8JlwxbroRLi976bsVB5vdOV5d
	 nR2NwaYZYxCDQ==
Date: Tue, 16 Jul 2024 16:45:49 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-phy@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, 
 devicetree@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>
In-Reply-To: <20240716-a38x-utmi-phy-v2-1-dae3a9c6ca3e@solid-run.com>
References: <20240716-a38x-utmi-phy-v2-0-dae3a9c6ca3e@solid-run.com>
 <20240716-a38x-utmi-phy-v2-1-dae3a9c6ca3e@solid-run.com>
Message-Id: <172116994973.743769.12500781470975159877.robh@kernel.org>
Subject: Re: [PATCH RFC v2 1/4] dt-bindings: phy: cp110-utmi-phy: add
 compatible string for armada-38x


On Tue, 16 Jul 2024 22:52:37 +0200, Josua Mayer wrote:
> Armada 38x USB-2.0 PHYs are similar to Armada 8K (CP110) and can be
> supported by the same driver with small differences.
> 
> Add new compatible string for armada-38x variant of utmi phy.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  .../bindings/phy/marvell,armada-cp110-utmi-phy.yaml       | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.example.dtb: utmi@580000: reg: [[5767168, 8192]] is too short
	from schema $id: http://devicetree.org/schemas/phy/marvell,armada-cp110-utmi-phy.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240716-a38x-utmi-phy-v2-1-dae3a9c6ca3e@solid-run.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


