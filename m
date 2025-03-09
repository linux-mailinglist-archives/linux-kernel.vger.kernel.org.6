Return-Path: <linux-kernel+bounces-553162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED569A5850C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364A81671B1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB651DE4D7;
	Sun,  9 Mar 2025 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmyRjiHp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCCD1C5D51;
	Sun,  9 Mar 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531750; cv=none; b=c9S8R+l1SpbxGNq+w1qT1ObDb5ZmhPSfPzhZOb+GKtd4KT6yLrv3nTCnGKQaLO0OXAK9dy9uNivXag6fzJlrL1BfriJ6D6ZjvC2aapjYP/kh/IVY/W10G2pRbCO3Fh5cC83/9S/7S6Basqf4kJwRf+zHWtu0CWJfHoWsMm/51/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531750; c=relaxed/simple;
	bh=IGpFddVBBxQL0jWLZ1CuQkeHAw1KzCzTqLo0KMHbMBA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=bT75Sd9KSjNtBMWnQTjnS31U2DpmNo2c+sgNYnHhRQL1oct1wnJNR6Dpfd375dAil7AKriHAK6rIl3c08ekmE3iagusyxXa0aizzde5xRCG91AUOY8Usbwpo0uPvx2QvuiiUHT3+GXBFk+GPamuDdxOyTXi1ISWVQZ/5SNszrbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmyRjiHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369BBC4CEE3;
	Sun,  9 Mar 2025 14:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741531749;
	bh=IGpFddVBBxQL0jWLZ1CuQkeHAw1KzCzTqLo0KMHbMBA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=SmyRjiHp3xzZSlxPwbe8MW5i8XRpkGUyAEQE5dDhP2Bk7q8NR5AElXnuPDcu/rEn0
	 EMW4cxlpj+/lzUAI82rLo6FhliQ/ZXwg2eUl7g5cfZqXzzsR0c6/YCiEeJrUkdqwbk
	 O7xJQGIfgwhMP12Q9RRPRKCK1heZ7EAcA7sOyR5N/uUgLumKkVKbyqnE71rNQaavhE
	 Pp0KYybOnTiAMX1ullZT4Wp8DGpGxjVwQvqbwFHN2L3uX1MQhrA4bSNReVxYAkXd6K
	 ks730h5004TAWkhCeoW1/IL2llxfUVkgs9ircKvqvjZUvJBLdHaCr+I2NppBnB11mR
	 uY0jx6wBL/hMA==
Date: Sun, 09 Mar 2025 09:49:08 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
 Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Daniel Danzberger <dd@embedd.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, devicetree@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-clk@vger.kernel.org, 
 Guo Ren <guoren@kernel.org>, linux-mediatek@lists.infradead.org, 
 Felix Fietkau <nbd@nbd.name>, Vinod Koul <vkoul@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, linux-phy@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 upstream@airoha.com, Michael Turquette <mturquette@baylibre.com>, 
 linux-kernel@vger.kernel.org, Yangyu Chen <cyy@cyyself.name>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250309132959.19045-6-ansuelsmth@gmail.com>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
 <20250309132959.19045-6-ansuelsmth@gmail.com>
Message-Id: <174153174798.1107714.11562627501354617614.robh@kernel.org>
Subject: Re: [PATCH 05/13] dt-bindings: mfd: add Documentation for Airoha
 EN7581 SCU


On Sun, 09 Mar 2025 14:29:36 +0100, Christian Marangi wrote:
> Add Documentation for Airoha EN7581 SCU.
> 
> Airoha EN7581 SoC expose registers to control miscellaneous pheriperals
> via the SCU (System Controller Unit).
> 
> Example of these pheriperals are reset-controller, clock-controller,
> PCIe line speed controller and bits to configure different Serdes ports
> for USB or Ethernet usage.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../mfd/airoha,en7581-scu-sysctl.yaml         | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.example.dtb: system-controller@1fb00000: clock-controller: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/airoha,en7581-scu-sysctl.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.example.dtb: clock-controller: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/clock/airoha,en7523-scu.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250309132959.19045-6-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


