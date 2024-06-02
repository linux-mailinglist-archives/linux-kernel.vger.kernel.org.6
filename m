Return-Path: <linux-kernel+bounces-198402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416278D77CA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8FC280CCC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 20:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0C874E0C;
	Sun,  2 Jun 2024 20:16:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3F36FE16;
	Sun,  2 Jun 2024 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717359388; cv=none; b=o7FoNxxWSDORmqn7PByHmt2RRRfTxJI8R2stYmFAJCO3veZr2qsPg3rglWXfF83vLcbZeIF1j1ieEN3swYi/5Nre8w1I6ncmJ+AY3Q61aRm2HcNq5+S/YVaIIHVCqyktBinh2NU2T6nZQe2wjfFWXR+xVE7SUxTZYemumD3ClK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717359388; c=relaxed/simple;
	bh=Q98W32FFwdI1cAgJFPClVn7dyNiWNwmPQZQrnQtZNLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnP3g1QPstRriMRMUoWMeC4hcRjqCczovC8Hyi4TH+Y6DpIN62QDObLs4Jkk3f96EXHyJgz4D4YlIXs4JLTXm9FscjaShw3Ac/bHHZEvJkoFG6Uxv77+s/glJejupWVzxRoayNcAwCAwMNitGlGuZ2CV3raSuT8dR5HZcO466Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F687113E;
	Sun,  2 Jun 2024 13:16:48 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4BAF3F792;
	Sun,  2 Jun 2024 13:16:22 -0700 (PDT)
Date: Sun, 2 Jun 2024 21:15:09 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: "harry.yu185" <harry.yu185@gmail.com>
Cc: corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, maz@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH] irqchip/gic-v3: Add Allwinner sunxi001 erratum
 workaround
Message-ID: <20240602211509.67df243e@minigeek.lan>
In-Reply-To: <20240602071058.6405-1-harry.yu185@gmail.com>
References: <20240602071058.6405-1-harry.yu185@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Jun 2024 15:10:58 +0800
"harry.yu185" <harry.yu185@gmail.com> wrote:

Hi,

(please make sure to CC: the linux-sunxi mailing list on Allwinner
related patches)

I do hope that this whole patch is unnecessary, as Marc pointed out, but
just for the records some comments for future reference, since this
patch seems either premature or out of place.

> Allwinner A523 GIC600 integration does not support the
> sharability feature. So assigned Erratum ID #sunxi001 for this
> issue.
> 
> That the 0x0201643b ID is not Allwinner specific and thus
> there is an extra of_machine_is_compatible() check.
> 
> Note, because more than one soc may have this problem, the 'sunxi'
> name is used instead of a fixed soc name like A523.
> 
> Signed-off-by: harry.yu185 <harry.yu185@gmail.com>
> ---
>  Documentation/arch/arm64/silicon-errata.rst |  2 ++
>  arch/arm64/Kconfig                          | 10 ++++++++++
>  drivers/irqchip/irq-gic-v3-its.c            | 21 +++++++++++++++++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
> index eb8af8032c31..351dd6094a6c 100644
> --- a/Documentation/arch/arm64/silicon-errata.rst
> +++ b/Documentation/arch/arm64/silicon-errata.rst
> @@ -242,6 +242,8 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | Rockchip       | RK3588          | #3588001        | ROCKCHIP_ERRATUM_3588001    |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| Allwinner      | SUN55IW3        | #sunxi001       | ALLWINNER_ERRATUM_SUNXI001  |

"sun55iw3" is a CPU die identifier only used in Allwinner's BSP
kernels, mainline uses a different naming scheme.

Also the erratum name looks odd, at the very least I'd expect it to
read "ALLWINNER_ERRATUM_00001" or something. But there is already some
Allwinner timer erratum, which we boldly gave ID 1 (short of an
official erratum number from Allwinner), so using the same number again
will surely lead to confusion.

> ++----------------+-----------------+-----------------+-----------------------------+
>  +----------------+-----------------+-----------------+-----------------------------+
>  | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
>  +----------------+-----------------+-----------------+-----------------------------+
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5d91259ee7b5..5a71227d119a 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1279,6 +1279,16 @@ config ROCKCHIP_ERRATUM_3588001
>  
>  	  If unsure, say Y.
>  
> +config ALLWINNER_ERRATUM_SUNXI001
> +	bool "Allwinner sunxi001: GIC600 can not support shareability attributes"
> +	default y

"default ARCH_SUNXI" would be better suited here, I think.

> +	help
> +	  The Allwinner GIC600 SoC integration does not support ACE/ACE-lite.
> +	  This means, that its sharability feature may not be used, even though it
> +	  is supported by the IP itself.
> +
> +	  If unsure, say Y.
> +
>  config SOCIONEXT_SYNQUACER_PREITS
>  	bool "Socionext Synquacer: Workaround for GICv3 pre-ITS"
>  	default y
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 40ebf1726393..d93348947353 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -4775,6 +4775,19 @@ static bool __maybe_unused its_enable_rk3588001(void *data)
>  	return true;
>  }
>  
> +static bool __maybe_unused its_enable_sunxi001(void *data)
> +{
> +	struct its_node *its = data;
> +
> +	if (!of_machine_is_compatible("arm,sun55iw3p1"))

You cannot reference a compatible name here that is not documented in
the bindings. Which brings us to the elephant in the room: there is no
upstream support for this SoC (family) yet. I have some
work-in-progress series [1], but it's far from finished, mostly blocked
by the lack of hackable hardware (hopefully fixed soon).

So what kernel is this patch supposed to be applied against? You would
need at least a pinctrl and clock driver for even basic operation, none
of that I have seen posted.

Cheers,
Andre

[1] https://github.com/apritzel/linux/commits/a523-EARLY/

> +		return false;
> +
> +	its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
> +	gic_rdists->flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
> +
> +	return true;
> +}
> +
>  static bool its_set_non_coherent(void *data)
>  {
>  	struct its_node *its = data;
> @@ -4836,6 +4849,14 @@ static const struct gic_quirk its_quirks[] = {
>  		.mask   = 0xffffffff,
>  		.init   = its_enable_rk3588001,
>  	},
> +#endif
> +#ifdef CONFIG_ALLWINNER_ERRATUM_SUNXI001
> +	{
> +		.desc   = "ITS: Allwinner erratum sunxi001",
> +		.iidr   = 0x0201643b,
> +		.mask   = 0xffffffff,
> +		.init   = its_enable_sunxi001,
> +	},
>  #endif
>  	{
>  		.desc   = "ITS: non-coherent attribute",


