Return-Path: <linux-kernel+bounces-559587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45566A5F5D4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADFA3AEC2C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F8B267721;
	Thu, 13 Mar 2025 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hs5puAaa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE273265610;
	Thu, 13 Mar 2025 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872103; cv=none; b=Amp0eSoQgiI3c03pEHY6xNX2YQCJlwg7O7RRoEjA/1dnkbO2ZVhOPSNJDsE25tyOlAWsa5m4nkaW7doALiMRDiBEAcc7na6azpIf1qxaagtjKIU2MvxByFo2aXDknRsmRWDcBtLe8hNbKqsrmWKSdP4vIjwOC3zTXUul/Vxwjpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872103; c=relaxed/simple;
	bh=fF2QQTE+2YlxG3sB1lZ42t5C418bXvGhFBRVwKr1Kpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf1z9+H5ZmZ9Kky2hp/aXbvBdoOWt8WdG5U8oqWdi11dX6Ve1gFy7hsKYV00sMmmAes/DBoDd3gFuhLKhgqrWGdQKqXTLYgtdIA/QUZo/kTUd5ycl4yzipVtp5FHibSSZS7ouloyWuRJ7lzNrDBTW5oTDmsft7KFBS1CpyAlcmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hs5puAaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E84C4CEE5;
	Thu, 13 Mar 2025 13:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741872102;
	bh=fF2QQTE+2YlxG3sB1lZ42t5C418bXvGhFBRVwKr1Kpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hs5puAaaFMdqwgfIqkKwLHW6ZeRgfcbUzR8YNU2CaYJ3WLY9ZVVODoiotmphYWUj9
	 zE+qKbmvtmdAUMM1ujxlvrtLaa74rV+r7IoDOvoj9TSZ2bZjLpZc1OSXP8ffRrY68/
	 jlLrLDxKwlL48GKa6lnMvNmZuuJZUTYgLcEiWIzNvbNCyaePBZ8yT5qzQPp4ByZdqq
	 i9Eflcvo1pUQUmOHh5Wtve8cU2BjKVfl1xn4GxNWl1edLCPtyte7lpL1r6Ky9/9A2W
	 qMHSbZ08UEwQOXFptifHfzCQk1aB45s9mj+T5t4n/93/2EXTxFAAUXTxSQR+qQEMeB
	 TDndXATAWJ41g==
Date: Thu, 13 Mar 2025 13:21:36 +0000
From: Lee Jones <lee@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stanislav Jakubek <stano.jakubek@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 00/10] mfd: bcm590xx: Add support for BCM59054
Message-ID: <20250313132136.GC3616286@google.com>
References: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>

On Tue, 04 Mar 2025, Artur Weber wrote:

> Add support for the BCM59054 MFD to the bcm590xx driver and fix a
> couple of small bugs in it that also affected the already supported
> BCM59056.
> 
> While we're at it - convert the devicetree bindings to YAML format
> and drop the bcm59056 DTS in favor of describing the PMU in users'
> DTS files, as is done for most other MFDs.
> 
> The BCM59054 is fairly similar to the BCM59056, with the primary
> difference being the different number and layout of regulators.
> It is primarily used in devices using the BCM21664 and BCM23550
> chipsets.
> 
> This patchset has been tested on a Samsung Galaxy Grand Neo
> (baffinlite rev02; DTS not in mainline yet) with a BCM59054 PMIC.
> Testing on a BCM59056 would be appreciated.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v6:
> - Rename mfd/brcm,bcm590xx.yaml to mfd/brcm,bcm59056.yaml again
> - Use PMU ID value as device type
> - Rename rev_dig and rev_ana to rev_digital and rev_analog
> - Link to v5: https://lore.kernel.org/r/20250221-bcm59054-v5-0-065f516a9042@gmail.com
> 
> Changes in v5:
> - Make regulator binding descriptions reference mfd/brcm,bcm590xx.yaml
>   instead of mfd/brcm,bcm59056.yaml
> - Move regmap type enum to common MFD header
> - Link to v4: https://lore.kernel.org/r/20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com
> 
> Changes in v4:
> - Fix yamllint warnings in DT bindings
> - Address miscelaneous review comments related to DT bindings
>   - Note that I did not end up moving the regulator refs from
>     allOf compatible matches; I explained my reasoning in [1].
>     [1] https://lore.kernel.org/lkml/ab853605-859d-44c6-8cbd-44391cd677e6@gmail.com/
> - Add PMU ID/revision parsing to MFD driver
> - Fix instances of regulator data not matching vendor kernel for
>   BCM59054
> - Use different voltage table for BCM59054 VSR reg based on PMU
>   revision
> - Link to v3: https://lore.kernel.org/r/20250131-bcm59054-v3-0-bbac52a84787@gmail.com
> 
> Changes in v3:
> - Split out regulator DT bindings into separate YAML
> - Use tables of regulator info instead of get_XXX_register, reg_is_XXX
>   functions
> - Drop "regulator: bcm590xx: Add proper handling for PMMODE registers";
>   it adds unnecessary noise to the series and will be submitted separately
> - Link to v2: https://lore.kernel.org/r/20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com
> 
> Changes in v2:
> - Fixed BCM59054 ID being passed to BCM59056 function in the
>   regulator driver
> - Dropped linux-rpi-kernel from the CC list
> - Link to v1: https://lore.kernel.org/r/20231030-bcm59054-v1-0-3517f980c1e3@gmail.com
> 
> ---
> Artur Weber (10):
>       dt-bindings: mfd: brcm,bcm59056: Convert to YAML
>       dt-bindings: mfd: brcm,bcm59056: Add compatible for BCM59054
>       ARM: dts: Drop DTS for BCM59056 PMU
>       mfd: bcm590xx: Drop unused "id" member of bcm590xx MFD struct
>       mfd: bcm590xx: Add support for multiple device types + BCM59054 compatible
>       mfd: bcm590xx: Add PMU ID/revision parsing function
>       regulator: bcm590xx: Use dev_err_probe for regulator register error
>       regulator: bcm590xx: Store regulator descriptions in table
>       regulator: bcm590xx: Rename BCM59056-specific data as such
>       regulator: bcm590xx: Add support for BCM59054 regulators
> 
>  .../devicetree/bindings/mfd/brcm,bcm59056.txt      |   39 -
>  .../devicetree/bindings/mfd/brcm,bcm59056.yaml     |   76 ++
>  .../bindings/regulator/brcm,bcm59054.yaml          |   56 +
>  .../bindings/regulator/brcm,bcm59056.yaml          |   51 +
>  arch/arm/boot/dts/broadcom/bcm28155-ap.dts         |   68 +-
>  arch/arm/boot/dts/broadcom/bcm59056.dtsi           |   91 --
>  drivers/mfd/bcm590xx.c                             |   75 +-
>  drivers/regulator/bcm590xx-regulator.c             | 1289 ++++++++++++++++----
>  include/linux/mfd/bcm590xx.h                       |   28 +-
>  9 files changed, 1366 insertions(+), 407 deletions(-)

Besides my one comment, the MFD side looks okay.

So you still need ACKs from Mark and to rework Rob's suggestion.

-- 
Lee Jones [李琼斯]

