Return-Path: <linux-kernel+bounces-560901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E4FA60ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD3577A9D93
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94770191F66;
	Fri, 14 Mar 2025 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6LlxMuw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F90193436;
	Fri, 14 Mar 2025 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939681; cv=none; b=TZtHVKrepu8C1Wwuqc9aQcYn42PuyHQNmcgDxWu+4vdr8tNG/mlbPel0krH0otVDJj+fWtf1rS6UBzVYm3QbdWUL8kPOGQflNMTyS2Z0qfRiKYnATpzzFWoae8qL+aRFR6ElZNySJjMDEAOps8uRglkkkgChykwNZB7vyxQn2Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939681; c=relaxed/simple;
	bh=oYH/kGhK7YTdEQ7KFvtJxvjiQApYFDp63+DH/kdptis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8bEl7M9zL2JIJXYxelHGhY9mAk41S9VflzOyl8ls4wEtuusjkHT3+KEsvezpEsgjUNBm5FD5l20ZvDTpo98Ur8r59XKlvhO2/EVca8y2MxZx6nKMl32MyVd7XSj32n8PNIe+iinQkFb27pBa2wSYvqm2j5obkAcRLbRTszVuNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6LlxMuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAADC4CEEC;
	Fri, 14 Mar 2025 08:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741939680;
	bh=oYH/kGhK7YTdEQ7KFvtJxvjiQApYFDp63+DH/kdptis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6LlxMuwdTaK9kpaCnkV8YbN2DMfAYsdpkdvGy78D9YUpd7Zv548uPiQAn8/F/eEu
	 YuYLjJ0BRNvKvXTnL34pYJfvTZISlFknAcGLxnJExGUd9h5SlsS0PnvjG8ecJ0FAYC
	 kYftjoHqQR4QQ3rwPA1P4h8o3UtRiiQI3HmqhXaA/xHNhMF0nnFVwIx4L9FzOyGcm+
	 HHjmoki6ogkoVBc01Hi4REcuTMNbUf0J/RtIrlI4XslH2CMaK1eIDcX3k/h9tXD8fi
	 +GBJVJFU2YGUrbaPPui2HhGONh7gofaYkwZFVFGPhreNRu+p3qt0zrrEsXAy9bVAD2
	 FntX+BFI2Cggg==
Date: Fri, 14 Mar 2025 09:07:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: florin.leotescu@oss.nxp.com
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Shych <michaelsh@nvidia.com>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viorel.suman@nxp.com, carlos.song@nxp.com, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, festevam@gmail.com, Florin Leotescu <florin.leotescu@nxp.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: Add Microchip emc2305 support
Message-ID: <20250314-encouraging-fabulous-ant-e1f7b0@krzk-bin>
References: <20250313125746.2901904-1-florin.leotescu@oss.nxp.com>
 <20250313125746.2901904-2-florin.leotescu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313125746.2901904-2-florin.leotescu@oss.nxp.com>

On Thu, Mar 13, 2025 at 02:57:44PM +0200, florin.leotescu@oss.nxp.com wrote:
> +  '#size-cells':
> +    const: 0
> +
> +  '#pwm-cells':
> +    const: 2
> +
> +patternProperties:
> +  "^fan@[0-4]$":

Keep consistent quotes, either ' or "

> +    $ref: fan-common.yaml#
> +    unevaluatedProperties: false
> +    properties:
> +      reg:
> +        description:
> +          The fan number.
> +
> +    required:
> +      - reg
> +      - pwms
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        fan_controller: fan-controller@2f {
> +            compatible = "microchip,emc2305";
> +            reg = <0x2f>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            #pwm-cells = <2>;
> +
> +            fan@0 {
> +                #cooling-cells = <2>;
> +                reg = <0x0>;

Please follow DTS coding style, so reg is here the first property.

> +                pwms = <&fan_controller 1 1>;

It's the same PWM for all fans? So isn't it basically one fan? How do
you exactly control them independently, if the same PWM channel is used?

> +            };
> +
> +            fan@1 {
> +                #cooling-cells = <2>;
> +                reg = <0x1>;
> +                pwms = <&fan_controller 1 1>;


Best regards,
Krzysztof


