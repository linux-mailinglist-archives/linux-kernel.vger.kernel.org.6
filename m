Return-Path: <linux-kernel+bounces-553328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1572AA58783
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 20:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450BF164E20
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83331F4CB9;
	Sun,  9 Mar 2025 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQRPYnG/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38974632;
	Sun,  9 Mar 2025 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741548021; cv=none; b=FBhqlRS4GJEAqCy1IgJxCoGDYx4Q0S5+eOsr39AxYQ+MCylTPHw049q/hEtJmhGrSqFlaQjRIwAUX4Mq2hoKviAri8y1rNtQVZY5fcxr2loKrzjoG1e5ItYYIp7m+loKnYJMe0oN0LpcqXeSBy19Fvb5omJ0EhZuSNotc555qoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741548021; c=relaxed/simple;
	bh=e9jsJPt3rxxt3JCEOy0V44SWUpK7aFmyt5qQ6Jg4yuI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=tTF3JHJmqxNxYFhfNKa5v9KOzpTJtOIrYcVR7m3FoEUqEs1k8D+3LRGvt7Q8OjfOebYYbltAApQB+6R1M76M3PPrPiq2R13SUh+dx+l+xHqLgYuY/5+qCvAoQx8ipsNt3Dw3fx88WhMudoO0MCs1UKa5nho0DtrjSpF8LnWqv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQRPYnG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E888C4CEE3;
	Sun,  9 Mar 2025 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741548020;
	bh=e9jsJPt3rxxt3JCEOy0V44SWUpK7aFmyt5qQ6Jg4yuI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=mQRPYnG/R19rXJOvfwcg1loO2ZcuHcn7/zzqPCFWhG7rbiDSSWuuLoT8EI9MGh32f
	 dKojFFNvmLUoPKXyMwvCdPpKwQOZH/1ciEX8hPyca+jH6mCU+A3h+SyIRQcaip81OY
	 siQEQZkumEopv3WznCepdxrg7W+X8GmzC+9mlQ8lYszvYMqpVqniHQDWWqhoR2eFiM
	 3JD0S2uHfnMKZAeLI5I/Rf44fX9msXD46afS6T2Bk6e6kUCtgbPs0eHEV+glJ84l4z
	 w6x9tXDz20DwqE9K9ef3Ju8yoMown3kyFe9ewRL+mhSX8+etRm17kM4KS24NPyoBUQ
	 iTCL+oH87Jc2g==
Date: Sun, 09 Mar 2025 14:20:18 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Takashi Iwai <tiwai@suse.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Jaroslav Kysela <perex@perex.cz>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-kernel@vger.kernel.org
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <20250309181630.1322745-3-jan.dakinevich@salutedevices.com>
References: <20250309181630.1322745-1-jan.dakinevich@salutedevices.com>
 <20250309181630.1322745-3-jan.dakinevich@salutedevices.com>
Message-Id: <174154801891.2046627.7087067779247838486.robh@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: dt-bindings: meson: t9015: add support
 for A1 SoC family


On Sun, 09 Mar 2025 21:16:29 +0300, Jan Dakinevich wrote:
> Add support for internal audio codec found A1 SoC family. On this SoC
> the component supports capturing from ADC and has specific configuration
> of input/output lines.
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  .../bindings/sound/amlogic,t9015.yaml         | 69 +++++++++++++++++--
>  1 file changed, 65 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml: allOf:1:else: 'anyOf' conditional failed, one must be fixed:
	'lineout-left' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml: allOf:1:else: 'anyOf' conditional failed, one must be fixed:
	'lineout-right' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml: allOf:1:else: 'anyOf' conditional failed, one must be fixed:
	'linein-left' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml: allOf:1:else: 'anyOf' conditional failed, one must be fixed:
	'linein-right' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml: allOf:1:else: 'anyOf' conditional failed, one must be fixed:
	'micbias' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250309181630.1322745-3-jan.dakinevich@salutedevices.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


