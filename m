Return-Path: <linux-kernel+bounces-246698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE8792C542
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36148282D60
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB562187541;
	Tue,  9 Jul 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l70DDpUV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02930152E0E;
	Tue,  9 Jul 2024 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560141; cv=none; b=tgwuJds8kUASEUxF2YRGpnJhnhs0F6JLqlHOWopd3mcx4/kuNDCqs4n8O6eMoeuZS3GR8fD0vW87fKmZ9M6lAo0cA8lw88Su3uzHxsVAj4K6kyUgtQEBs/vgKq/+cOEF/lItKlYrJHA26GdOE9WkRkwRm2M8waIpchnxA4QEzyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560141; c=relaxed/simple;
	bh=y7YDFahM3f+y+ifeu6hRC0FG98NtJwmB+mRGq4qE30k=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=j1TNJsmTmCiisyMhmw1UkYW4f+xEeO3cKdzqEoQH2QQJ2Kj2n4bM/ajfezcqEwaI9F1gR+ENBh+jyB46UgpsJFr3gVH8Ghj5PiEckln9Q4MQfqBj+PTqoniJPsE0MEiugQJpkUgkBemQYVKTksuLCAQwa0QYjpaFGiXT3AWMnCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l70DDpUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC1EC3277B;
	Tue,  9 Jul 2024 21:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720560140;
	bh=y7YDFahM3f+y+ifeu6hRC0FG98NtJwmB+mRGq4qE30k=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=l70DDpUVd4nsyxO9gleOg9pcT7aVCveJwP3rQnuJAq2zIgMSRdhgJLxZl6GMmAFuM
	 l/SSN8D8g/heBxbth5m8A1nW7hyi2HJpvwxFjXxCd00QiiU4gDnuI+D1q2vCLEqHgA
	 heHjQzD6gtj3CC+cgB5OYMLcH2bi6JHl/Ep7L+8+OjUaMT2Eyz7rpgPyx1IRVZSI9U
	 vow7m3Ddvm5+UXGsMuvT3dIqsYRzzgRigzDWFg81DoGzV2dnER8F+waRpQuCqBujPX
	 tBw+ej/vMVXyZ6nvSPpNjJ8Ocx8B0xof1FFAOxaxamgI4jl3/xX6JIWdSgXUEra4UO
	 7o0ry/eZhdXDg==
Date: Tue, 09 Jul 2024 15:22:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
 kernel@salutedevices.com, Jaroslav Kysela <perex@perex.cz>, 
 linux-sound@vger.kernel.org, prusovigor@gmail.com, 
 Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, 
 Philipp Zabel <p.zabel@pengutronix.de>, Mark Brown <broonie@kernel.org>
In-Reply-To: <20240709172834.9785-4-ivprusov@salutedevices.com>
References: <20240709172834.9785-1-ivprusov@salutedevices.com>
 <20240709172834.9785-4-ivprusov@salutedevices.com>
Message-Id: <172056013798.1150861.13690347231414855621.robh@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: dt-bindings: Add bindings for NeoFidelity
 NTP8918


On Tue, 09 Jul 2024 20:28:31 +0300, Igor Prusov wrote:
> Add dt-bindings for NeoFidelity NTP8918 Amplifier
> 
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
>  .../bindings/sound/neofidelity,ntp8918.yaml   | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/neofidelity,ntp8918.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/neofidelity,ntp8918.yaml: properties:reg: 'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/neofidelity,ntp8918.yaml: properties:reg: 'anyOf' conditional failed, one must be fixed:
	'enum' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('enum' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	1 is less than the minimum of 2
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/neofidelity,ntp8918.example.dtb: ntp8918@54: reg:0:0: 84 is not one of [42, 43, 44, 45]
	from schema $id: http://devicetree.org/schemas/sound/neofidelity,ntp8918.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/neofidelity,ntp8918.example.dtb: ntp8918@54: Unevaluated properties are not allowed ('reg' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/neofidelity,ntp8918.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240709172834.9785-4-ivprusov@salutedevices.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


