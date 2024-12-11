Return-Path: <linux-kernel+bounces-441199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E14299ECAF8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA4E286930
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7477211A18;
	Wed, 11 Dec 2024 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+kRs9zS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08622187872;
	Wed, 11 Dec 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916098; cv=none; b=LLC+8b5uFi6vKeUt62avxoW3p0pL5cIpwHSTU0F9ZNDZz40iY8kA1nQZy+tHXdC87sBTACmEoXH2y/qNhMZHe0DH8PmcCiLAhOqjFcy3LEkVgxtMVgi0FIw44buMI6ozTitCQmjotGuONzjcn8JFcFrzpaWDIJmuvGnnUV2IG5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916098; c=relaxed/simple;
	bh=DgftItvKwlAqV6VUxDwhJgPamO/iGIKYe2fBSGOS2dQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=QbFOVOMzi1z+1LKb9DmS6xKb/FELMP02uy6jmyT5kRodp26yVenSvmgSEVR4/DSQNRwJjXLKvHdXAJ8C1mIZUTf3Wu5dFXq1Yrv1+GL4LVlw9c7q1+kZ6eGa3zUSQt96j8SJukTT3DzCjd09g9oq/WGcWjNU1Pt5OVEQXBy+4yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+kRs9zS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699FFC4CED2;
	Wed, 11 Dec 2024 11:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733916097;
	bh=DgftItvKwlAqV6VUxDwhJgPamO/iGIKYe2fBSGOS2dQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=S+kRs9zSROEKEbuf6pQXp6LKyYNbAyiEMMZeR6T/IukOtp0WJTxya8pmJRrBkU/hi
	 2lH22ehLWYRh4Rsj3/gsS2NMFEM9yPi1QlYwwYRe+PRP+8L2UOb2Kh9TP7TGKsBtmp
	 NxaDphjfl/zlxLraM34B2C+YcI8T29Pq4ha3IOXKS+NBgyyulYz0TO3LbNbdUpSc5O
	 aQGQPRYru60pQkeCjqkECmgTuvYte+ovXbs43B5/8aJdhqusyPPeuLiIViQNpInzaJ
	 ugJ0e99xDBPASPvYEaj5slqOQ2yBuvJM6EtmKW4uZU6qnNpyJlZdeaY6p7eMAeUSEh
	 nicQ5MB2EUedA==
Date: Wed, 11 Dec 2024 05:21:35 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 linux-sound@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Andrei Simion <andrei.simion@microchip.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>
In-Reply-To: <20241211-sound-atmel-at91sam9g20ek-v2-1-86a0e31e6af9@microchip.com>
References: <20241211-sound-atmel-at91sam9g20ek-v2-1-86a0e31e6af9@microchip.com>
Message-Id: <173391609559.2340929.13321693035546295768.robh@kernel.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: sound: atmel-at91sam9g20ek:
 convert to json-schema


On Wed, 11 Dec 2024 15:16:15 +0530, Balakrishnan Sambath wrote:
> Convert atmel-at91sam9g20ek-wm8731-audio DT binding to yaml
> based json-schema.Change file name to match json-scheme naming.
> 
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---
> Changes in v2:
> - Add missing CODEC pin options to 'atmel,audio-routing' items.
> - Drop 'minItems' from 'atmel,audio-routing' since enum defines valid connections.
> - Add subsystem tag to subject.
> - Add blank line between properties and fix typo.
> - Add audio complex description.
> - Link to v1: https://lore.kernel.org/lkml/20240214-at91sam9g20ek-wm8731-yaml-v1-1-33333e17383b@microchip.com
> ---
>  .../bindings/sound/atmel,at91sam9g20ek-wm8731.yaml | 70 ++++++++++++++++++++++
>  .../sound/atmel-at91sam9g20ek-wm8731-audio.txt     | 26 --------
>  2 files changed, 70 insertions(+), 26 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/atmel,at91sam9g20ek-wm8731.example.dtb: sound: atmel,audio-routing:2: 'Int MIC' is not one of ['Ext Spk', 'Int Mic', 'LOUT', 'ROUT', 'LHPOUT', 'RHPOUT', 'LLINEIN', 'RLINEIN', 'MICIN']
	from schema $id: http://devicetree.org/schemas/sound/atmel,at91sam9g20ek-wm8731.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241211-sound-atmel-at91sam9g20ek-v2-1-86a0e31e6af9@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


