Return-Path: <linux-kernel+bounces-542126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654C9A4C5EF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7493A505D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B96213E66;
	Mon,  3 Mar 2025 16:00:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4FF7080D;
	Mon,  3 Mar 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017643; cv=none; b=kWkv0EaBu2EQ+YnE5xmRBWTzjeaQcMqerC+xDjsJpkFysU9DpEOBVj+XoLjlcYFjGjW+9otNb9NOHCin3wtCCtvnAh/a2JoNYcw7I43qUNWqyIUznL8oGN1iEQLOKOn9SgbXSyHK92OqTQR5/0LG2q39DdwBPRGfoMbMDkAJU4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017643; c=relaxed/simple;
	bh=qHzQi4+c8kTN8tsNEe9XE1Dq3CCg4miQvbd30I6E+RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGmCbcXEHzUmlN0z1cj+RC4lFLb6fJJ5BZpPn8ZYBvHbtFZIlsNlKi/fDezXBSFsKAW260sNA8qAGd1VyaxeUiLe8j8OwYQmz+JWerr42TElSQECCsP2dOwZN1D5KcKDhbim9uGqml6krlLGSeFo+e3ojVWkIcNdNRxwuK+LoLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35789106F;
	Mon,  3 Mar 2025 08:00:54 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CF9B3F673;
	Mon,  3 Mar 2025 08:00:38 -0800 (PST)
Date: Mon, 3 Mar 2025 16:00:35 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>
Cc: <liviu.dudau@arm.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: corstone1000: Add definitions for secondary
 CPU cores
Message-ID: <Z8XSIx75B4mtcV48@bogus>
References: <20250303153744.376419-1-hugues.kambampiana@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303153744.376419-1-hugues.kambampiana@arm.com>

On Mon, Mar 03, 2025 at 03:37:44PM +0000, Hugues KAMBA MPIANA wrote:
> Add `cpu1`, `cpu2` and `cpu3` nodes to the Corstone1000 device tree to
> enable support for secondary CPU cores.
> 
> This update facilitates symmetric multiprocessing (SMP) support on
> the Corstone1000 Fixed Virtual Platform (FVP), allowing the
> secondary cores to be properly initialised and utilised.
> 
> Signed-off-by: Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>
> ---
>  arch/arm64/boot/dts/arm/corstone1000-fvp.dts | 24 ++++++++++++++++++++
>  arch/arm64/boot/dts/arm/corstone1000.dtsi    |  2 +-
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/corstone1000-fvp.dts b/arch/arm64/boot/dts/arm/corstone1000-fvp.dts
> index abd013562995..df9700302b8d 100644
> --- a/arch/arm64/boot/dts/arm/corstone1000-fvp.dts
> +++ b/arch/arm64/boot/dts/arm/corstone1000-fvp.dts
> @@ -49,3 +49,27 @@ sdmmc1: mmc@50000000 {
>  		clock-names = "smclk", "apb_pclk";
>  	};
>  };
> +
> +&cpus {
> +	cpu1: cpu@1 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a35";
> +		reg = <0x1>;
> +		enable-method = "psci";
> +		next-level-cache = <&L2_0>;
> +	};
> +	cpu2: cpu@2 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a35";
> +		reg = <0x2>;
> +		enable-method = "psci";
> +		next-level-cache = <&L2_0>;
> +	};
> +	cpu3: cpu@3 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a35";
> +		reg = <0x3>;
> +		enable-method = "psci";
> +		next-level-cache = <&L2_0>;
> +	};

Why are these not part of /cpus node in corstone1000.dtsi ?
Also I see the original cpu@0 node doesn't have enable-method set to
"psci" while these secondary cpus have. Please add the same and move all
these changes in corstone1000.dtsi unless you have strong reasons not to.

In that case, please clearly state the reason in the commit message.

P.S: I was about to send PR soon for v6.15. If you want this change for
v6.15, you need to be quicker.

-- 
Regards,
Sudeep

