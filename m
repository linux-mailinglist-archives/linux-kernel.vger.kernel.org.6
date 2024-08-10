Return-Path: <linux-kernel+bounces-281768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC0F94DB14
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 08:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B05E1F21D85
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 06:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16AD14A4ED;
	Sat, 10 Aug 2024 06:24:27 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877AF4409;
	Sat, 10 Aug 2024 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723271067; cv=none; b=Am5LC/triYhshkQaGnLd92kRNPiunKwDtPCWWi5w/uAxzNx5IgLPyn23a5gaxm7GlMsVfAVM7n1UDc4QSR9Eu259EsqwDxwXT47OsGkvig9+o9pB6FBOitZd7aSsMbJhygPVH4zIGYeUR3wPm5b7SVAoDgk5CwsR8lyPayL0l9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723271067; c=relaxed/simple;
	bh=cw6ZAZQQlMmTzNFrIznEgkTkm0vYvIxq03+GxpTodU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObSVWNNkyv00FINgdUweFwdpvlJLRKFLD1xDb2xccj6FpKDQxuK15AEX2d+3XgsuQWVk3gMJxyathV9ahOFu6rXzQyjz4dW+ba39jsqSqxYhL/9dAarqDXxT5OcNpZaIdSBBn2i5vhFrOAoUTk3LUFRPQovgoW/zSBzBnFmjlwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1scfN4-003ir2-1f;
	Sat, 10 Aug 2024 14:23:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 10 Aug 2024 14:23:19 +0800
Date: Sat, 10 Aug 2024 14:23:19 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	Olivia Mackall <olivia@selenic.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/3] hwrng: add hwrng support for Rockchip RK3568
Message-ID: <ZrcHV1RRwj2pkCLB@gondor.apana.org.au>
References: <cover.1722355365.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722355365.git.daniel@makrotopia.org>

On Tue, Jul 30, 2024 at 05:08:04PM +0100, Daniel Golle wrote:
> Rockchip SoCs used to have a random number generator as part of their
> crypto device.
> 
> However newer Rockchip SoCs like the RK3568 have an independent True
> Random Number Generator device. This patchset adds a driver for it and
> enables it in the device tree for RK3568.
> 
> It turns out the HW RNG returns very low quality on RK3566, so while
> it is theoretically also present on that SoC, only enable it on RK3568
> for now on which the quality expectations are met.
> 
> Tested on FriendlyARM NanoPi R5C.
> 
> v8 -> v9:
>  * Patch 1: revert to v7
> 
>  * Patch 2: revert to v7, use 922 as quality
> 
>  * Patch 3: drop new properties, but enable only in rk3568.dtsi
> 
> v7 -> v8:
>  * Patch 1: document new properties
>    - introduce 'rockchip,sample-count'
>    - require to specify 'quality' (0~1024)
> 
>  * Patch 2:
>    - read sample-count and quality from DT
> 
>  * Patch 3:
>    - disable hwrng in rk356x.dtsi, enable only in rk3568.dtsi
>    - set sample-count 1000 and quality 900 (87.9%) as before
> 
> v6 -> v7:
>  * Patch 1: unchanged
> 
>  * Patch 2: bring back rk_rng_write_ctl()
>    - bring back rk_rng_write_ctl() with improved comment to describe
>      the hardware.
> 
>  * Patch 3: unchaned
> 
> v5 -> v6:
>  * Patch 1: unchanged
> 
>  * Patch 2: get rid of #ifdef
>    - use if (IS_ENABLED(...)) { ... }instead of #ifdef inside functions
>    - use __maybe_unused for functions previously enclosed by #ifdef'ery
> 
>  * Patch 3: unchanged
> 
> v4 -> v5:
>  * Patch 1: always use RK3568 name
>    - use full RK3568 name in patch description
>    - add RK3568 to title in binding
> 
>  * Patch 2: full name and cosmetics
>    - also always mention RK3568 as there may be other RNG in other
>      (future) Rockchip SoCs
>    - remove debug output on successful probe
>    - use MODULE_AUTHOR several times instead of single comma-separated
> 
>  * Patch 3: unchanged
> 
> v3 -> v4:
>  * Patch 1: minor corrections
>    - fix Rokchip -> Rockchip typo
>    - change commit title as requested
> 
>  * Patch 2: improved error handling and resource management
>    - Always use writel() instead of writel_relaxed()
>    - Use pm_runtime_resume_and_get
>    - Correctly return error code in rk_rng_read()
>    - Make use of devm_reset_control_array_get_exclusive
>    - Use devm_pm_runtime_enable and there by get rid of rk_rng_remove()
> 
>  * Patch 3:
>    - Move node to conform with ordering by address
> 
> v2 -> v3: patch adopted by Daniel Golle
>  * Patch 1: address comments of Krzysztof Kozlowski, add MAINTAINERS
>    - improved description
>    - meaningful clock-names
>    - add entry in MAINTAINERS files
> 
>  * Patch 2: numerous code-style improvements
>    - drop misleading rk_rng_write_ctl(), simplify I/O writes
>    - drop unused TRNG_RNG_DOUT_[1-7] macros
>    - handle error handling for pm_runtime_get_sync()
>    - use memcpy_fromio() instead of open coding for-loop
>    - some minor white-spaces fixes
> 
>  * Patch 3:
>    - use clock-names as defined in dt-bindings
> 
> v1 -> v2:
>  * Patch 1: fix issues reported by Rob Herring and Krzysztof Kozlowski:
>    - Rename rockchip-rng.yaml into rockchip,rk3568-rng.yaml
>    - Fix binding title and description
>    - Fix compatible property
>    - Rename clocks and add the corresponding descriptions
>    - Drop reset-names
>    - Add a bus definition with #address-cells and #size-cells to the
>      example.
> 
>  * Patch 2: fix issue reported by kernel test robot <lkp@intel.com>
>    - Do not read the random registers as big endian, looking at the
>      RK3568 TRM this is actually not needed. This fixes a sparse
>      warning.
> 
>  * Patch 3: unchanged
> 
> 
> Aurelien Jarno (3):
>   dt-bindings: rng: Add Rockchip RK3568 TRNG
>   hwrng: add hwrng driver for Rockchip RK3568 SoC
>   arm64: dts: rockchip: add DT entry for RNG to RK356x
> 
>  .../bindings/rng/rockchip,rk3568-rng.yaml     |  61 +++++
>  MAINTAINERS                                   |   7 +
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi      |   4 +
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  10 +
>  drivers/char/hw_random/Kconfig                |  14 ++
>  drivers/char/hw_random/Makefile               |   1 +
>  drivers/char/hw_random/rockchip-rng.c         | 227 ++++++++++++++++++
>  7 files changed, 324 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/rockchip,rk3568-rng.yaml
>  create mode 100644 drivers/char/hw_random/rockchip-rng.c
> 
> -- 
> 2.45.2

Patches 1-2 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

