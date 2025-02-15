Return-Path: <linux-kernel+bounces-516138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C58E6A36D4D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 11:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8590A1893672
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE991A841C;
	Sat, 15 Feb 2025 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQwX7l6Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A65C1A5BBF;
	Sat, 15 Feb 2025 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739615309; cv=none; b=Pe0pfSGX165eVn1s4wOm7sqy8KX5fJGQvkmbP0wT1Yv5BkjFivxdyNIs2vt/QpFnFDjYuwO2qVUES75s54u8llvtxZROndW7mECXDvbPFNRDGM2m9xiWdk40NS64tVTQMA3vp5QyKMRXZOkIkdyC0Gtu9xANR0IwtMvvoGXa84k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739615309; c=relaxed/simple;
	bh=gNprYAi87qXWXNPsGmU77W5/QOMMYo/jVxd3xT4q5IE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=imVDHPacRIUqA6LlLA53eDFvy5r1zhM5Ds7Zftt8iGBRu+NaQ7AD4jq23SagNWcncq/JeARUzcoo59qck7MhSvAc8VDQ1po7AttBiQpBoSkm9TVk3foUCch5zHDerQdkemTu9oaDfIC7G7x4Wya5/jGskaDOQUJR7VdPLSESK6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQwX7l6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D561DC4CEE8;
	Sat, 15 Feb 2025 10:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739615309;
	bh=gNprYAi87qXWXNPsGmU77W5/QOMMYo/jVxd3xT4q5IE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=oQwX7l6QUrwrSgf9XWJLP2EKJBpj/ccnw4KMliE/W1UQtATb+AgeyLPch2pSBQxrp
	 +1koWenoRzEVpOpn5DafzZYqV4Y+F1aluMEv71LVph0YhEgqV0dwuHd0hedxcmksmD
	 kvm3r5akTZ/DhdZbS7l2rEr91elvx2kdf4wTFe35+m0UIrNiCNnx585yc41bB97TP6
	 0HgRnnbmOl+EfyzawAT9f66idI9TfG/oxQ5j0m3xTolH8HvLIN1/LKcvEY1kptvLq+
	 8AfHDZlpxmXzmKtuvhOTNkqKRxsXDfUjMvR5ZE/FDnlLm+IUEePpY3kBc1OmThtpEG
	 E3f2U79HrpuTA==
Date: Sat, 15 Feb 2025 04:28:27 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 linux-arm-kernel@lists.infradead.org, Scott Branden <sbranden@broadcom.com>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 linux-kernel@vger.kernel.org, Stanislav Jakubek <stano.jakubek@gmail.com>, 
 Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>
To: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20250215-bcm59054-v4-2-dbfb2d76a855@gmail.com>
References: <20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com>
 <20250215-bcm59054-v4-2-dbfb2d76a855@gmail.com>
Message-Id: <173961530619.188590.17123911097531884942.robh@kernel.org>
Subject: Re: [PATCH v4 2/9] dt-bindings: mfd: brcm,bcm59056: Add compatible
 for BCM59054


On Sat, 15 Feb 2025 10:39:37 +0100, Artur Weber wrote:
> The BCM59054 MFD is fairly similar to the BCM59056, and will use
> the same driver. Add compatible and specify the allowed regulator
> nodes.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v4:
> - Fix yamllint errors (missing unevaluatedProperties)
> - Drop comment with regulator name list
> - Use full schema paths for $reg
> - Change description of regulator binding to mention BCM59054
>   explicitly
> - Drop quotes around vbus reg name
> - Change "Power Management IC" to "Power Management Unit" to match
>   official Broadcom naming
> 
> Note that I did not end up moving the regulator refs from
> allOf compatible matches; I explained my reasoning in [1].
> 
> [1] https://lore.kernel.org/lkml/ab853605-859d-44c6-8cbd-44391cd677e6@gmail.com/
> 
> Changes in v3:
> - Split regulator node into separate file
> - Removed quotes around compatible
> ---
>  .../devicetree/bindings/mfd/brcm,bcm590xx.yaml     | 26 +++++++++-
>  .../bindings/regulator/brcm,bcm59054.yaml          | 56 ++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/regulator/brcm,bcm59054.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml
Documentation/devicetree/bindings/regulator/brcm,bcm59054.yaml: Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250215-bcm59054-v4-2-dbfb2d76a855@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


