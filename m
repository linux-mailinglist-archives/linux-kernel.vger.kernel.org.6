Return-Path: <linux-kernel+bounces-542783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACC9A4CDA4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 996FF7A6D77
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44E6235BE4;
	Mon,  3 Mar 2025 21:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un46XJUC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F7578F54;
	Mon,  3 Mar 2025 21:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741038237; cv=none; b=FeqGhDOO5tLmUYSjcFeCgbQETpUDihUCM6rlJEtKyQnEgdnp1/WqL1Y2hqufRu1ph7uVLtAYyKmSRHJDGKYZ90QJo4mBSZHbcRFOyW0eFMq0N+PfTsg7Yk6Mdt5RYua/3Ea/856EPzcoAid4zJnhizx9p5R3pvN4kEF2Y5cIY9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741038237; c=relaxed/simple;
	bh=MAZ3GzDJqwIxbmpGTBoa7Vxr/bQjnRpqhcxx+9kHi58=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=qbFhdyJcwbnUAtGAISItSpHNjsRfFBawhsOOp14cT5iZxc2ZaVVs5QGdkAxIwVD25HFmEFa4dWS3Bo6ZoEbIAxTGQDhYmK+jvESYzv7gkV4SbOkG/xZEXV9rud77QswBR7wz3VLfOp42PfulqlGV56XLGmm4Fy0Yh8ETHcpT5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un46XJUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEE2C4CED6;
	Mon,  3 Mar 2025 21:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741038236;
	bh=MAZ3GzDJqwIxbmpGTBoa7Vxr/bQjnRpqhcxx+9kHi58=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Un46XJUCvFTptINfONNvksNFUZ/F10zNUxc8JhS1/zGtyiodoOnAfOcGeRhc6qHmX
	 N3Guc2ZgzNXg55hNlG0q75Csc5LPOdEYGWDcB/udG/Rv6eEAwB8QvvWRTAlkc8cG2L
	 el05QDEwWJUvZ/w6Kb6BHJqrRpFD+48xpBQDqtr2hM/XKUbQ0QPVvvKCagF1KHqj1m
	 b91GGesEyDEQGNur665uNXCLzOPreG6ulkV+GboI9OiQ/BNZQwHUcHqOlCiHgB0pbX
	 WEza652yAD008j+KBTGcE/Tqq3sp8OA5eDF+BXTCVt4QPf83cg+u1x6PquG+Irrfch
	 BXvtF+6v97jSQ==
Date: Mon, 03 Mar 2025 15:43:54 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Alex Elder <elder@kernel.org>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-clk@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org, 
 Ray Jui <rjui@broadcom.com>, Stephen Boyd <sboyd@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Scott Branden <sbranden@broadcom.com>
To: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20250303-kona-bus-clock-v2-2-a363c6a6b798@gmail.com>
References: <20250303-kona-bus-clock-v2-0-a363c6a6b798@gmail.com>
 <20250303-kona-bus-clock-v2-2-a363c6a6b798@gmail.com>
Message-Id: <174103823477.2582909.2641429106641464271.robh@kernel.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: brcm,kona-ccu: Add BCM281xx
 bus clocks


On Mon, 03 Mar 2025 21:27:50 +0100, Artur Weber wrote:
> Add bus clocks corresponding to peripheral clocks currently supported
> by the BCM281xx clock driver and add the relevant clock IDs to the
> clock/bcm281xx.h dt-bindings header.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v2:
> - Add this commit (BCM281xx bus clocks)
> ---
>  .../devicetree/bindings/clock/brcm,kona-ccu.yaml   | 21 +++++++++++++++++-
>  include/dt-bindings/clock/bcm281xx.h               | 25 +++++++++++++++++++---
>  2 files changed, 42 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/brcm,kona-ccu.example.dtb: clock-controller@3e011000: clock-output-names: ['uartb', 'uartb2', 'uartb3', 'uartb4', 'ssp0', 'ssp2', 'bsc1', 'bsc2', 'bsc3', 'pwm'] is too short
	from schema $id: http://devicetree.org/schemas/clock/brcm,kona-ccu.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250303-kona-bus-clock-v2-2-a363c6a6b798@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


