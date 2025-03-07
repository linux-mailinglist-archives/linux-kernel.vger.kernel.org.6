Return-Path: <linux-kernel+bounces-550532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B698AA560E0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F3F77A793C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1388319D89E;
	Fri,  7 Mar 2025 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="Vg/hqRnE";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="2EdwgRk7"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6A33DF;
	Fri,  7 Mar 2025 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741328920; cv=none; b=INg3ERmwkb9LrUHocdgAcecxBWcKVC3V7GjPGkBdjQSMgDejr2vGc7ZftG/uIiX/RJQZlx/c22Yl8eLKgtnlln6Q25dtzZAOboXZHzKOiCV+uH9ZO6vDqEs16sWPPD/EDVCdtDDwgKPizfZ4x0mAO7b5PucpSOkUtENw2elzczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741328920; c=relaxed/simple;
	bh=esOGewcBEitTNMbwJLWV/4Q8Pac0CJGCYz1jkogecso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuTJnXBjYMGZehievwbq8ciJb6F2amExzcdsdQ9LjtmiV+bKCydowDDKbBXNyT+v0HAOwuhdiGFVOT4V5otgskNgSJgzjzjxLlKYqaHRrpd0oPwsNs0ko9AH1Ris3/fsjtIYR0ooDslNfSS8PB2kHSWXz1A+D3bKMCXxq0Ma8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=Vg/hqRnE; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=2EdwgRk7; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 90BE9EC59F6;
	Thu, 06 Mar 2025 22:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1741328916; bh=esOGewcBEitTNMbwJLWV/4Q8Pac0CJGCYz1jkogecso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vg/hqRnEncDV/KzUibAzBjeZk9XwghJN+jrJW/lb7CJPSjhh6VJQlN/hI4vCT2oi0
	 V4ptSKUL6WH8wIA3MNoLyvYKcXkA0c3t565KNPiyCPEhnBH3AZvZemFUiuP/7TE5db
	 bBSMSkC9zbIi8O46gzXVcYbQbdtlrishQFUz4NJ+GazX0NhTjTqk5qtOLsq5dP0S1a
	 t5T2qmwe2D1LryUCWqPkg3uvSFIyKB08XpbfseACNwmwhV86Co3vmiYNG5sS+vT+GL
	 H23ovsFu58lF7xFMqqfKDhvoawoyHp+iKVlnQD5wsqYDqUeU5wkSRkx29NcLMZVur5
	 SJBQS8V2kvdhw==
X-Virus-Scanned: amavisd-new at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bj5LQsPHFXeA; Thu,  6 Mar 2025 22:28:29 -0800 (PST)
Received: from ketchup (unknown [183.217.80.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 6BCCDEC59F2;
	Thu, 06 Mar 2025 22:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1741328909; bh=esOGewcBEitTNMbwJLWV/4Q8Pac0CJGCYz1jkogecso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2EdwgRk755DuMsaIsaUEccn21RzYdgA5s9XF9N19XVppPNhCeQ4MW/3gIGnNlHOWF
	 Lo935i4Yfh7ac2Li6szSZ/SQdtJ2XDJ3fOpUDoMqQQ2Qwxe5CW9bt/89NFtNf8dmWY
	 F+Ybl6IiQwUM0hDEBb2EeAqPFmOsJXu7dDoLgEgrzHFOPZ6d42+QFahTT4TD/h6Pac
	 JYYEWzEsbiGq0ADwiLXMObuzYQTXS2t5tpCghyqLfvIIeEmKx+BzW6bHUlhQDodofg
	 XKaqL/9mrrf9v0VamcuDlyUnsBi/ERqAkzY+Z8vpQyShQTw+BWjb9rR1o7TKM0JSrq
	 evABESf6fyBAg==
Date: Fri, 7 Mar 2025 06:28:16 +0000
From: Haylen Chu <heylenay@4d2.org>
To: Inochi Amaoto <inochiama@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>, Yixun Lan <dlan@gentoo.org>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev, Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>
Subject: Re: [PATCH v5 5/5] riscv: dts: spacemit: Add clock tree for Spacemit
 K1
Message-ID: <Z8qSAKXQEfnyVef6@ketchup>
References: <20250306175750.22480-2-heylenay@4d2.org>
 <20250306175750.22480-7-heylenay@4d2.org>
 <2isaev6ys2fn2u6lnyudvnjam34fggr5tqh7afajwdjbdp5rvr@ajokoevhqq4p>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2isaev6ys2fn2u6lnyudvnjam34fggr5tqh7afajwdjbdp5rvr@ajokoevhqq4p>

On Fri, Mar 07, 2025 at 09:55:15AM +0800, Inochi Amaoto wrote:
> On Thu, Mar 06, 2025 at 05:57:51PM +0000, Haylen Chu wrote:
> > Describe the PLL and system controllers that're capable of generating
> > clock signals in the devicetree.
> > 
> > Signed-off-by: Haylen Chu <heylenay@4d2.org>
> > ---
> >  arch/riscv/boot/dts/spacemit/k1.dtsi | 79 ++++++++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > index c670ebf8fa12..09a9100986b1 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> > +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > @@ -3,6 +3,8 @@
> >   * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> >   */
> >  
> > +#include <dt-bindings/clock/spacemit,k1-ccu.h>
> > +
> >  /dts-v1/;
> >  / {
> >  	#address-cells = <2>;
> > @@ -306,6 +308,40 @@ cluster1_l2_cache: l2-cache1 {
> >  		};
> >  	};
> >  
> > +	clocks {
> 
> > +		#address-cells = <0x2>;
> > +		#size-cells = <0x2>;
> > +		ranges;
> 
> why setting this?

I just noticed these unnecessary properties after sending the series,
will drop them, thanks.

> > +
> > +		vctcxo_1m: clock-1m {
> > +			compatible = "fixed-clock";
> 
> > +			clock-frequency = <1000000>;
> 
> Should the frequency this move to the board file?
> I do not think these clock are in the soc.
> This applys to all clock below.

This should be the special case described in the dts-coding-style
documentation,

> A partial exception is a common external reference SoC input clock,
> which could be coded as a fixed-clock in the SoC DTSI with its
> frequency provided by each board DTS.[1]

These four external clocks are essential for K1 SoC to operate as shown
in the clock tree diagram[2]. I think they fit the exception.

Furthermore, the SoC expects these four clocks in fixed rates, thus I
don't see a reason not to include the clock-frequency property here.
Please correct me if I get something wrong.

> > +			clock-output-names = "vctcxo_1m";
> > +			#clock-cells = <0>;
> > +		};
> > +
> > +		vctcxo_24m: clock-24m {
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <24000000>;
> > +			clock-output-names = "vctcxo_24m";
> > +			#clock-cells = <0>;
> > +		};
> > +
> > +		vctcxo_3m: clock-3m {
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <3000000>;
> > +			clock-output-names = "vctcxo_3m";
> > +			#clock-cells = <0>;
> > +		};
> > +
> > +		osc_32k: clock-32k {
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <32000>;
> > +			clock-output-names = "osc_32k";
> > +			#clock-cells = <0>;
> > +		};
> > +	};
> > +
> >  	soc {
> >  		compatible = "simple-bus";
> >  		interrupt-parent = <&plic>;

Thanks,
Haylen Chu

[1]: https://elixir.bootlin.com/linux/v6.11-rc1/source/Documentation/devicetree/bindings/dts-coding-style.rst#L196
[2]: https://developer.spacemit.com/resource/file/images?fileName=E9VPb63n8o1heox2KXHcgWiVnWh.png

