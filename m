Return-Path: <linux-kernel+bounces-516137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2A7A36D4B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 11:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E263AFA35
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9B11A316D;
	Sat, 15 Feb 2025 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJDsM2JS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C6D155CB3;
	Sat, 15 Feb 2025 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739615308; cv=none; b=m8ob6uLf4FvlBpQMB3TovaPg8rePzD/YgYeYqmqMsU9yv112RoaLiOBvWwztsFEk03je9B2UWS9Rf4fgDPCF3gfFAOcwzp/oZuu4jkSVpU4yBXiorLXk/wQCwP2ZWzY0EetvtW1wJJlVkduchqFOHJKAB2wfFu3lJf1dKtwhHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739615308; c=relaxed/simple;
	bh=CEEKh7N14ok4a75LQPAkohKFtemp3HZBXqHD1CvOiWo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=TyKNbJOJRUbtQJt3fPxoLdrMihcT9MOMoIku5Yxw6+XtlGSedixvrfTCG8BY50p5AmomhEI+g1uxDmrvtx5IVONVQKQ+wKDftT2MSixQ+N8p8/okXc+0ySNMtybLbboArhg/XPsEIFShccimT4vzvdeUeHMSWsHxI1P9EevI5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJDsM2JS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EC8C4CEDF;
	Sat, 15 Feb 2025 10:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739615307;
	bh=CEEKh7N14ok4a75LQPAkohKFtemp3HZBXqHD1CvOiWo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=OJDsM2JSsQlZMvIf51jy+TYtyGGWH8/FcywOqLviO/+8+XP551Ma8f0UnzxEI/PU4
	 WtIofqRXNsppbmn1SkPcdmZZIvSlehazilnCQAm9+eMfyn9BPghUSJ81xI+uHZTUrd
	 PsMqRIhIdxpq1AY9YPBwzw44vO+44aw+BzfEHfFvZ8d2rlcjbSpIqeSUUEUO1Vuls/
	 L/kBQXuthXpW8SaeYeQxx/eUbC6J6MFQTs4b0mqWyzTJ4MmXRIkmKm+4N5PHUZqBB3
	 Ogep1s81cq+Yv6tpMirUtcE9+X6sf5dnP/qGa3mNi1iwgzs3F7X9H4rayeh7RQdadb
	 TJSrt3/rSMNdw==
Date: Sat, 15 Feb 2025 04:28:26 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Scott Branden <sbranden@broadcom.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 linux-arm-kernel@lists.infradead.org
To: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20250215-bcm59054-v4-1-dbfb2d76a855@gmail.com>
References: <20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com>
 <20250215-bcm59054-v4-1-dbfb2d76a855@gmail.com>
Message-Id: <173961530505.188543.13359016373130021930.robh@kernel.org>
Subject: Re: [PATCH v4 1/9] dt-bindings: mfd: brcm,bcm59056: Convert to
 YAML


On Sat, 15 Feb 2025 10:39:36 +0100, Artur Weber wrote:
> Convert devicetree bindings for the Broadcom BCM59056 PMU MFD from
> TXT to YAML format. This patch does not change any functionality;
> the bindings remain the same.
> 
> The bindings have been split into two parts: the MFD binding and
> a separate binding for the regulator node, to simplify the addition
> of other models later (which have different regulators).
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v4:
> - Made $ref use full schema path
> - Cleaned up example
> - Dropped regulator name list comment
> - Changed description of regulator binding to mention BCM59056
>   explicitly
> - Changed "Power Management IC" to "Power Management Unit" to match
>   official Broadcom naming
> - Renamed mfd/brcm,bcm59056.yaml to mfd/brcm,bcm590xx.yaml
> 
> Changes in v3:
> - Moved regulator node to separate binding
> - Removed quotes around compatibles/vbus property
> - Style fixes for example
> ---
>  .../devicetree/bindings/mfd/brcm,bcm59056.txt      | 39 ----------------
>  .../devicetree/bindings/mfd/brcm,bcm590xx.yaml     | 54 ++++++++++++++++++++++
>  .../bindings/regulator/brcm,bcm59056.yaml          | 51 ++++++++++++++++++++
>  3 files changed, 105 insertions(+), 39 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/regulator/brcm,bcm59056.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml
Documentation/devicetree/bindings/regulator/brcm,bcm59056.yaml: Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250215-bcm59054-v4-1-dbfb2d76a855@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


