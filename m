Return-Path: <linux-kernel+bounces-557954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B98A5DFC7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B794C3BAA04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695852505DE;
	Wed, 12 Mar 2025 15:08:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21359156F5E;
	Wed, 12 Mar 2025 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792085; cv=none; b=ke51TiIJDEfnS9uQfh0B9URjIYcU3IARkUb57Fstc0LR9uiObNUiKntXm+WMbEBue+H1N2faMlJ5ygDwN6Eqw0m7ENLavLPN70p+b377Xg6CpjKtE189DobedKdJlTWC9yB3IWH3Gyozdul/6bySAYTA9z2NypkrXkvFKw3kncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792085; c=relaxed/simple;
	bh=EQNdua2VLd3U3jzo/wjMCIM4ze/LCO+NyUs4QsHvXao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF65pklj5UULujbmmXCikueLvt3dKAq296nrSF1vNtCQo40EEvegrP5XyOmXuTaCK+vg0nJWYmcqdGnm8C2t/U835zaiMRpX69SDiUx0mX1/vwbDAlElosagIfkx30EQ9rkOJpKUD5Fk5+Pm+ZtMW9NHRmGg8ujhJ/1EGHblO0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D0DF1515;
	Wed, 12 Mar 2025 08:08:14 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7A853F5A1;
	Wed, 12 Mar 2025 08:07:59 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:07:50 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Abel Vesa <abelvesa@kernel.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH NOT APPLY v2 4/4] clk: scmi: Support spread spectrum
Message-ID: <Z9GjRhQmsu0fBoWG@pluto>
References: <20250205-clk-ssc-v2-0-fa73083caa92@nxp.com>
 <20250205-clk-ssc-v2-4-fa73083caa92@nxp.com>
 <Z6SqeNsAqbZM8nr1@pluto>
 <20250303041125.GC13236@nxa18884-linux>
 <Z8iKErarE0lHWxEy@pluto>
 <20250310081635.GA16799@nxa18884-linux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310081635.GA16799@nxa18884-linux>

On Mon, Mar 10, 2025 at 04:16:35PM +0800, Peng Fan wrote:
> On Wed, Mar 05, 2025 at 05:29:54PM +0000, Cristian Marussi wrote:
> >On Mon, Mar 03, 2025 at 12:11:25PM +0800, Peng Fan wrote:
> >> Hi Cristian,
> >> 
> >> On Thu, Feb 06, 2025 at 12:26:32PM +0000, Cristian Marussi wrote:
> >> >On Wed, Feb 05, 2025 at 05:49:54PM +0800, Peng Fan (OSS) wrote:
> >> >> From: Peng Fan <peng.fan@nxp.com>
> >> >> 
> >> >> Support Spread Spectrum with adding scmi_clk_set_spread_spectrum
> >> >> 
> >> >
> >> >Hi,
> >> >
> >> >I forwarded ATG with our latest exchange on the possibility of using a
> >> >standard OEM type instead of Vendor one if it is general enough....
> >> 
> >> Do you have any update?
> >> 
> >
> >Yes I think you can go on with your original plan of using vendor OEM
> >types: as of now we are not gonna standardize a new commmon SCMI type
> >for Clock-SS, given there is really just one SCMI user of such clock
> >features...maybe in the future if more users shows up...
> 
> Thanks for updating me. Back to how to add extensions in clk-scmi.c,
> do you have any suggestions? I am thinking to provide vendor/sub-vendor
> for clk-scmi.c and use vendor "NXP" sub-vedor "IMX" for spread spectrum.
> 

Definitely based on vendors subvendors, not sure about how, I have not
really though about the details: you also shoudl consider that the new
clk ops for spread spectrum should be registered ONLY when you are on a
supported platform (of course) AND the OEM types nnamespace is per-vendor:
like vendor protocols your NXP OEM config type 0x80 must coexist with any
future possible OTHER_VENDOR OEM ConfigType 0x80.

Thanks,
Cristian


