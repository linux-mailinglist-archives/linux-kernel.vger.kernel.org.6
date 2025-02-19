Return-Path: <linux-kernel+bounces-521778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E887A3C228
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB7C1630DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EFE1F30C0;
	Wed, 19 Feb 2025 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gutt2v/U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851681F2BA7;
	Wed, 19 Feb 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975418; cv=none; b=XGD5WrOAhnhQnWvnH4eVmWkC86XLgA7+OhUHX9rCYa3x91UhuncSMoQxhD1L5+9EP57ukNm7oQ4RTc3I/QQ6g7FODmcyyEgJYXhrX1MkBqxnwMo7Euiu6EGwuzf649wy+AFrNx1cUt/EjWkT8NemR+n5Fxj10RQtgSfNepqf4B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975418; c=relaxed/simple;
	bh=k4kfLM6UULYbT+Hl+/0hs1RZVm2znRy0PpE0Nf0I2eM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=jte89bzonH4e+cP04DquGhQTJPRRqNSIPE2SCs+2DR4zUlmxlVsOZlxbwCCcXHsIP1OR3IRVrMsLrkMpLKTdLIIIsHtn4tfU4/zTdi+PZ6ZTrqwK3bFQM07/Vq1JvENYUCSe70GY8Rt8VvcNny1LJqP7gMwncqxZ0wbNjnWUqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gutt2v/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E47C4CEDD;
	Wed, 19 Feb 2025 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739975415;
	bh=k4kfLM6UULYbT+Hl+/0hs1RZVm2znRy0PpE0Nf0I2eM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Gutt2v/UySArgzAiJKzZJu4KjpWJFaPBR9mE2R1u+cZ6pY1gWcPFS1tqzDqCuRITU
	 zk7n0N/SQBQCiHy7zo8cld8pardfpUrU1WOGKZQJBU/7x5C27T0N6MuMiYdhaSxzFr
	 9Se9ynf1zT7C9Tg+tSNrJa0zw6yW0lotDRiqII14amvsH4tpQnxLBfDUi+NmY69CCx
	 qmYHizwXdokMEEshV2e250pQpd6zGfv6UKPbmjVtTfb7RtsB5u4g0JShNPiLKhLB4b
	 kjeEVgaGvgRYd9GEY1QTn1B4zdpGxqVKfRWmv5l75Vn5y38TrXjWZhgCUKwc32dPCD
	 7C9yn8Fx63VTw==
Date: Wed, 19 Feb 2025 08:30:13 -0600
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, viorel.suman@nxp.com, 
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, 
 Florin Leotescu <florin.leotescu@nxp.com>, 
 Michael Shych <michaelsh@nvidia.com>, carlos.song@nxp.com, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>
To: florin.leotescu@oss.nxp.com
In-Reply-To: <20250219133221.2641041-4-florin.leotescu@oss.nxp.com>
References: <20250219133221.2641041-1-florin.leotescu@oss.nxp.com>
 <20250219133221.2641041-4-florin.leotescu@oss.nxp.com>
Message-Id: <173997541394.2537392.7597733714820078670.robh@kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: hwmon: emc2305: Add YAML binding
 documentation for emc2305 driver


On Wed, 19 Feb 2025 15:32:21 +0200, florin.leotescu@oss.nxp.com wrote:
> From: Florin Leotescu <florin.leotescu@nxp.com>
> 
> Add yaml-based Device Tree bindings documentation for emc2305 driver
> The file provides the necessary structure, configuration
> and other parameters for Device Tree definition.
> 
> Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
> ---
>  .../devicetree/bindings/hwmon/emc2305.yaml    | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/emc2305.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/hwmon/emc2305.yaml:30:18: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/hwmon/emc2305.yaml:34:18: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/hwmon/emc2305.yaml:38:18: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/emc2305.yaml: pwm_output: missing type definition
Error: Documentation/devicetree/bindings/hwmon/emc2305.example.dts:59.9-17 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/hwmon/emc2305.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1511: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250219133221.2641041-4-florin.leotescu@oss.nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


