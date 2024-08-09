Return-Path: <linux-kernel+bounces-281218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24F694D472
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064421C21438
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C1C1991AC;
	Fri,  9 Aug 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9p0E7Ee"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4971990C4;
	Fri,  9 Aug 2024 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220290; cv=none; b=Kn06bA5Z4qnxyeydrr0t1NK054LZbZjEV8iU85hAUKURnU5pIDOKx5WeVPVZ7yt3TYkDnA1MkRzHHDCvvr8TUkgfpI8M9g328IbXlLjSWiMHy4Rh7w0hTKEmvz3U0zVmnGg+BYdrbaTaN/3FiQVI2saxtnOM0JYWM7wZdRN13Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220290; c=relaxed/simple;
	bh=ek/Kg6OmXUi6D5cWxC7C10DYiBHbw6OL9TD8XPV7y4Y=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=UFxtZ+KIVft/rHNSA65l1sh1Pc0UXCbZ8nCGhK7IGZ+ClImxMLyXDULhPay81OtNnHg9yiPueuL7A3GZI+NK/uB8eP+fsTy2t/w2PB0q6NXllc7bV0BHow6eHqZ4Ka/p539NHf0m573gOe49SyYBrDGVhkhJCgP5I9z9P9I2z5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9p0E7Ee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA725C32782;
	Fri,  9 Aug 2024 16:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723220290;
	bh=ek/Kg6OmXUi6D5cWxC7C10DYiBHbw6OL9TD8XPV7y4Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=L9p0E7EeQlzvhjRAqoGpPdcihwHW1MjQbllDSkwN06TxsM8qdXsU6oSBQB9tXP/cJ
	 yADOr0bk3A/w5CS4ytEl0pVafURAAnGy6zOvlnWf8hPhBHiuJYleEaHytbChUqrC9B
	 smY3y3ezB64BiTbn8lBcvsjxyjgez2K8ANOqBorTJAS4uoVBXKsNQbje2c176iUbT6
	 wxjvkme+t/94n448CAveKNbDTTIPJ04CYafRy5mU8vc0mD07nhhG+8SZf0IgPHbfpZ
	 Ra2eBlsO5e959W0mhdWJGXYF5ZMTqAC0vktQbwOFxeyiFqIHmmeh9jU9rqdy79t52Y
	 6bOG5kGvno5TA==
Date: Fri, 09 Aug 2024 10:18:08 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yannick Fertre <yannick.fertre@foss.st.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 dri-devel@lists.freedesktop.org, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20240809151314.221746-1-yannick.fertre@foss.st.com>
References: <20240809151314.221746-1-yannick.fertre@foss.st.com>
Message-Id: <172322028851.588157.5328364169708651531.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: display: st,stm32-ltdc: Document
 stm32mp25 compatible


On Fri, 09 Aug 2024 17:13:14 +0200, Yannick Fertre wrote:
> Add "st,stm32mp25-ltdc" compatible for SOC MP25. This new SOC introduce
> new clocks (bus, ref & lvds). Bus clock was separated from lcd clock.
> New sources are possible for lcd clock (lvds / ref).
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> ---
> Changes in v2: Rework clock property.
>  .../bindings/display/st,stm32-ltdc.yaml       | 51 +++++++++++++++----
>  1 file changed, 41 insertions(+), 10 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml: allOf:0:else:properties:clocks: {'maxItems': 1, 'items': [{'description': 'Lcd Clock'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml: allOf:0:then:properties:clocks: {'maxItems': 4, 'items': [{'description': 'Lcd Clock'}, {'description': 'Bus Clock'}, {'description': 'Reference Clock'}, {'description': 'Lvds Clock'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/st,stm32-ltdc.example.dtb: display-controller@40016800: 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/st,stm32-ltdc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240809151314.221746-1-yannick.fertre@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


