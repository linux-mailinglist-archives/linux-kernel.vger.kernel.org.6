Return-Path: <linux-kernel+bounces-412731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CB29D0ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F601B2E68B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DA3197A92;
	Mon, 18 Nov 2024 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpEbYIWJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A2DDD2;
	Mon, 18 Nov 2024 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925363; cv=none; b=e9hVF8+149pZd+uRSovNXahh0dxj9neaZh07TacPpjlt74rPjgdOv8RUGgirDh5Swa4NU9Ib7gPSdJ+QgycOW7EpUNoUucT5jJd/dEApAtIdLpkkngArIyV7O2JC1c9q5ZEGAlIKMQV6wGPGOKWCtYhrVr56KeRgrhGmfxgFG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925363; c=relaxed/simple;
	bh=YX1W5j5BkpAPp7zh3L69qMoyJQaJp02a7l+i7abLiEo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=fKhyxCyiG09k5ngcVpcZCyIub08YhknYqp7JkwzjnQRYRQwJ9Sk3X4tdmIlUJNGwPUlf2ltdM/Qz7d/zR+1zCq7uyc7UGOIf1XkaB3CgbnznKiNlKyuw2Gf2Wpi6nSl1uPwBWmQOAxPjl7EIRoXMubcCZkyzwRTtofR6dPYHfzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpEbYIWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338CEC4CECC;
	Mon, 18 Nov 2024 10:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731925362;
	bh=YX1W5j5BkpAPp7zh3L69qMoyJQaJp02a7l+i7abLiEo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=IpEbYIWJRj/pd4xxrg3kA5dYcQRKLXmgUwXKDiJE7aoZ/RTRh1zU7JS2iCcqbZ4T1
	 zV7zjpmXqoAVsKtgnsiw4kyeGZFRa06+txUpJaa/ZzRg2400ofDxJtUtMimcjvZYR8
	 XkJtPnsy2SIZegwaK82Q9N5vh/kPYFcXoqrwY5JKzSPPthPeM0AU6RycRHBNmLqooC
	 eMZ24se65rrmJmScnJcZgD8F7zusa6u4Ec8mel0LSTLPQiUZH9J6sXXiiIx7yRwvtd
	 tznDSFChOe0gTrNcSy6UQ1dbBRw8RtEv89yHjddrHfz5iEo5sAkCrggdisBPuFJkcP
	 AfDr+iLTQa+Ig==
Date: Mon, 18 Nov 2024 04:22:40 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>, devicetree@vger.kernel.org, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, chrome-platform@lists.linux.dev, 
 Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: "Sung-Chi, Li" <lschyi@chromium.org>
In-Reply-To: <20241118-add_charger_state-v1-2-94997079f35a@chromium.org>
References: <20241118-add_charger_state-v1-0-94997079f35a@chromium.org>
 <20241118-add_charger_state-v1-2-94997079f35a@chromium.org>
Message-Id: <173192536035.1517344.13221127899911847834.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: chrome: add new binding
 google,cros-ec-chrage-state


On Mon, 18 Nov 2024 17:33:47 +0800, Sung-Chi, Li wrote:
> Add new dt bindings for charge chip control. The charge chip control
> dt configuration is used by the driver 'cros-ec-charge-state', which is
> added in the commit "platform/chrome: cros_ec_charge_state: add new
> driver to control charge".
> 
> As these charge chip controls are connected under the ChromeOS Embedded
> Controller (EC), also add the patternProperties to the
> mfd/google,cros-ec bindings.
> 
> Signed-off-by: Sung-Chi, Li <lschyi@chromium.org>
> ---
>  .../bindings/chrome/google,cros-charge-state.yaml  | 62 ++++++++++++++++++++++
>  .../devicetree/bindings/mfd/google,cros-ec.yaml    |  4 ++
>  2 files changed, 66 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/chrome/google,cros-charge-state.example.dtb: ec@0: charge-chip-battery:compatible:0: 'google,cros-ec-charge-state' was expected
	from schema $id: http://devicetree.org/schemas/mfd/google,cros-ec.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/chrome/google,cros-charge-state.example.dtb: ec@0: charge-chip-battery: 'man-milliamp' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/google,cros-ec.yaml#
Documentation/devicetree/bindings/chrome/google,cros-charge-state.example.dtb: /example-0/spi/ec@0/charge-chip-battery: failed to match any schema with compatible: ['google,cros-ec-charge']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241118-add_charger_state-v1-2-94997079f35a@chromium.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


