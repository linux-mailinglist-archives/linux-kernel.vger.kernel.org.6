Return-Path: <linux-kernel+bounces-358121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97176997A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2225EB2310B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EB1170A14;
	Thu, 10 Oct 2024 02:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ti2A+fbV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996D6148300;
	Thu, 10 Oct 2024 02:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728525982; cv=none; b=LAi37G9ECo078h9EgC1oWx1Pfv9VTXwrgK6EQpnceXo0S1eVtAuHwVJP+hjmJ3xd4ztrTV9hPsyG0EA5PRH6Sl65bSXPtAsE4VLIFppSzh0EVULq6u9Q+2HgslyPWLmltUUkZFlyBzTnqbcmTT0siagtTpW6wrvgO+elzaF6QEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728525982; c=relaxed/simple;
	bh=4M/5IXgGXD6Ftk2kiSm9epBvP+MbBjUzWj8trE3/gdo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Vbd4xdsL6IQM+jDIMTvXLmWkSl1HFMfPJJkWZo3HRUEQ9B1gORzJcZ505Nx06SYKTEhfrupopOQCjv7aZOFB+IAK4f8eS2qUzzMCyBH07OEL1pFN4LnUozSKu3tKoaZxwwr7n4cz/T2wx8uzmt9y6kTlNjTSvl4hJm9tUSjKVpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ti2A+fbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEE1C4CECD;
	Thu, 10 Oct 2024 02:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728525981;
	bh=4M/5IXgGXD6Ftk2kiSm9epBvP+MbBjUzWj8trE3/gdo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Ti2A+fbVc5wjoixIDSWPC8cGOd6r4prCpv8nVY3FNG7O1Mw2mIVFBSEpx0Yj+GgQ6
	 9ch5sS3rBH/khjbUD4UI/+QJv2GWbByjk8s66hvZtbTFa6dpYh89P3xETQP2NC4Rw1
	 KM71Wc05OBK5e03JP5GGHl1ExYHPCvm4oU8zJsTNWMYcYMRIYKr4nWQNOigfRG2Ey3
	 zEv60phOxRqraWoknWB0AY1y4ayBVKNHejsslILWdVl+P520htNxl3ycsRYCPM8Ys/
	 ho6Q50SwNH/KUejF458Mj8SZJJwP1WT3R0KZMdVO7xYmFq5HlwrEwd0F5v4YUe8zsX
	 2t2e7IhRbL5qg==
Date: Wed, 09 Oct 2024 21:06:19 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Anand Gore <anand.gore@broadcom.com>, 
 Sam Edwards <CFSworks@gmail.com>
In-Reply-To: <20241009215046.1449389-2-CFSworks@gmail.com>
References: <20241009215046.1449389-1-CFSworks@gmail.com>
 <20241009215046.1449389-2-CFSworks@gmail.com>
Message-Id: <172852597949.940870.12502709428315249090.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: mtd: Relax BCM4908 partition schema


On Wed, 09 Oct 2024 14:50:44 -0700, Sam Edwards wrote:
> The BCM4908 partition "parser" is really just a fixed partitions table,
> with a special partition compatible (`brcm,bcm4908-firmware`) that
> automatically labels the partition as "firmware" or "backup" depending
> on what CFE is communicating as the selected active partition.
> 
> The bcm4908-partitions schema is currently too restrictive, requiring
> that all child nodes use this special compatible or none at all. This
> not only contracits what is allowed by the "parser" but also causes
> warnings for an existing file ("bcm4908-asus-gt-ac5300.dts").
> 
> Modify the schema to be strict only for child partitions that use the
> -firmware compatible. Also update the child name regex to agree with
> fixed-partitions, so that these differences apply consistently.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  .../mtd/partitions/brcm,bcm4908-partitions.yaml | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml: patternProperties:^partition(-.+|@[0-9a-f]+)$: 'if' is not one of ['type', 'description', 'dependencies', 'dependentRequired', 'dependentSchemas', 'properties', 'patternProperties', 'additionalProperties', 'unevaluatedProperties', 'deprecated', 'required', 'not', 'allOf', 'anyOf', 'oneOf', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/nodes.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml: patternProperties:^partition(-.+|@[0-9a-f]+)$: 'then' is not one of ['type', 'description', 'dependencies', 'dependentRequired', 'dependentSchemas', 'properties', 'patternProperties', 'additionalProperties', 'unevaluatedProperties', 'deprecated', 'required', 'not', 'allOf', 'anyOf', 'oneOf', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/nodes.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241009215046.1449389-2-CFSworks@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


