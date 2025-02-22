Return-Path: <linux-kernel+bounces-527074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DB2A40705
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53273BECC6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE2120766D;
	Sat, 22 Feb 2025 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="MTmNgGFK";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="fsrD8CFh"
Received: from bayard.4d2.org (bayard.4d2.org [5.78.89.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A946434;
	Sat, 22 Feb 2025 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.78.89.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740217283; cv=none; b=d0rsypHhGH5Yl/D3X1/p+1c3F9XBWCQDAoja7noMLYa4V0aDuXgiFLgPM7TxIpvAK3JvUsNn7PVUm0aWFWmowB4kbBTGth6vraMPSnWJe5aRQQkPXiYlm4aEtjE0GWkEFqoL+YhSBFQh2odC1L/j7XPR11E4KEUWwYVfgEgwJ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740217283; c=relaxed/simple;
	bh=DJC8m9RjcUzmFrWWZuFi8uTLafSc+0ybR8NGmMT4ltU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2wB/gXdpF0lLRq/GbpioLQO2q4ViU947hy/cqysCg3xM/juOjN4k3eDEjocV7FyvDVMlREulSuzHmWaHolwMQae+7RozEOmEz3udUXM8AkJfknpm4vkpknceLaMt5yiRPAKJ0SC6uEoiQrQisZo3nxscisesejrMNOAm4J8+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=MTmNgGFK; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=fsrD8CFh; arc=none smtp.client-ip=5.78.89.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id BCC8D122FE22;
	Sat, 22 Feb 2025 01:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1740217272; bh=DJC8m9RjcUzmFrWWZuFi8uTLafSc+0ybR8NGmMT4ltU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTmNgGFKrF0rvg4QXmmV19OqkJVyWfyWDRyZWlpxDA6uFgBDQRsh5EQBzVy3cBc/r
	 LFszsOKShCd6gP4NLii3bpQT0rtipIuw0HvQ1pEA/dVshKV2KARxM7ARIxg6/7YUft
	 0UWP7172G67OqFIf7UGGXJY1EfOQRbRsdHTRlM0hV90WJXhBPp3e4VskBMegQTGJaK
	 8ik2qQYHWXMbmNBpiDgMuvKQs9+w0cDz2RFsPi7N6H8jr4pkL/oENH/w5O8grpRhaN
	 UBxrNKeCcHyTa9NVKdkLjjBWD6WM4kXQqeZZxWhrnORIiW6P+JAs9NQwOJiz5YYOcC
	 EMXwp4zu67WtQ==
X-Virus-Scanned: amavisd-new at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LY7T0GXny8v4; Sat, 22 Feb 2025 01:40:59 -0800 (PST)
Received: from ketchup (unknown [183.217.80.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 5985B122FE21;
	Sat, 22 Feb 2025 01:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1740217259; bh=DJC8m9RjcUzmFrWWZuFi8uTLafSc+0ybR8NGmMT4ltU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fsrD8CFhRg9q1QR3OxrQIQHy3dE0MqTVoVYAvG3TGvs3NnmAxV9kTeBrX41ZVaBtk
	 muxP1MVHiyiU0yciKzLJYVBEOE5Gj7qlSt85kYEf+dLglu0jow5R2YIU2jBMli0Idn
	 7NVEOebBcciUrFG8/dgpB4bXshEJ+w1dd/xFlTrp1CxNsm72OEp7lW7h3ffMD/HRpB
	 lv0EK5fRodtDs+leawlaqoCzkzXgx/o9sZlQngL5GUbTUPqenE5xFLBptADrbt8vRp
	 +5Ek0voMUxAaNt0XZCptEvIcwtT2GEEBWcB4u14Ced7NxYvWHrnq9SvIa5p20iY4S7
	 k4vGgMWkv0VSQ==
Date: Sat, 22 Feb 2025 09:40:47 +0000
From: Haylen Chu <heylenay@4d2.org>
To: Alex Elder <elder@riscstar.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>, Yixun Lan <dlan@gentoo.org>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Guodong Xu <guodong@riscstar.com>
Subject: Re: [PATCH v4 3/4] clk: spacemit: Add clock support for Spacemit K1
 SoC
Message-ID: <Z7mbn_de-KV-yqQP@ketchup>
References: <20250103215636.19967-2-heylenay@4d2.org>
 <20250103215636.19967-5-heylenay@4d2.org>
 <f8b30551-25e7-4626-8c03-6d8807041d8a@riscstar.com>
 <Z7HNLq3DgJj7WKGI@ketchup>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7HNLq3DgJj7WKGI@ketchup>

Hi Alex,

Before answering the reply, I'd like to share some information on these
unconfirmed questions.

On Sun, Feb 16, 2025 at 11:34:06AM +0000, Haylen Chu wrote:
> On Thu, Feb 13, 2025 at 10:04:10PM -0600, Alex Elder wrote:
> > On 1/3/25 3:56 PM, Haylen Chu wrote:
> > > diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> > > new file mode 100644
> > > index 000000000000..6fb0a12ec261
> > > --- /dev/null
> > > +++ b/drivers/clk/spacemit/ccu-k1.c

...

> The next clock is weird, and it's the only one of its kind.  It is not
> > represented in the clock tree diagram. It is a "factor 1" clock (so it
> > just passes the parent's rate through), and has no gate.  Do you know
> > why it's defined?  It is used only as one of the MPMU parent clocks.
> > Why isn't just the pll1_d7 clock used in its place?
> 
> It is represented in the diagram. The photo version of the diagram seems
> hard to search so I will ask the vendor to publish a PDF version if
> possible.
> 
> As the definition involves no hardware bits, I guess it's actually an
> alias listed to keep the tree structure in similar form. Will confirm
> this with the vendor.

Yes, it's confirmed as a placeholder.

> 
> > > +static CCU_FACTOR_DEFINE(pll1_d7_351p08, "pll1_d7_351p08", CCU_PARENT_HW(pll1_d7),
> > > +			 1, 1);
> > > +
> > > +static CCU_GATE_DEFINE(pll1_d6_409p6, "pll1_d6_409p6", CCU_PARENT_HW(pll1_d6),
> > > +		       MPMU_ACGR,
> > > +		       BIT(0), BIT(0), 0, 0);
> > > +static CCU_GATE_FACTOR_DEFINE(pll1_d12_204p8, "pll1_d12_204p8", CCU_PARENT_HW(pll1_d6),
> > > +			      MPMU_ACGR,
> > > +			      BIT(5), BIT(5), 0, 2, 1, 0);
> > > +
> > > +static CCU_GATE_DEFINE(pll1_d5_491p52, "pll1_d5_491p52", CCU_PARENT_HW(pll1_d5),
> > > +		       MPMU_ACGR,
> > > +		       BIT(21), BIT(21), 0, 0);
> > > +static CCU_GATE_FACTOR_DEFINE(pll1_d10_245p76, "pll1_d10_245p76", CCU_PARENT_HW(pll1_d5),
> > > +			      MPMU_ACGR,
> > > +			      BIT(18), BIT(18), 0, 2, 1, 0);
> > > +
> > > +static CCU_GATE_DEFINE(pll1_d4_614p4, "pll1_d4_614p4", CCU_PARENT_HW(pll1_d4),
> > > +		       MPMU_ACGR,
> > > +		       BIT(15), BIT(15), 0, 0);
> > > +static CCU_GATE_FACTOR_DEFINE(pll1_d52_47p26, "pll1_d52_47p26", CCU_PARENT_HW(pll1_d4),
> > > +			      MPMU_ACGR,
> > > +			      BIT(10), BIT(10), 0, 13, 1, 0);
> > > +static CCU_GATE_FACTOR_DEFINE(pll1_d78_31p5, "pll1_d78_31p5", CCU_PARENT_HW(pll1_d4),
> > > +			      MPMU_ACGR,
> > > +			      BIT(6), BIT(6), 0, 39, 2, 0);
> > > +
> > > +static CCU_GATE_DEFINE(pll1_d3_819p2, "pll1_d3_819p2", CCU_PARENT_HW(pll1_d3),
> > > +		       MPMU_ACGR,
> > > +		       BIT(14), BIT(14), 0, 0);
> > > +
> > > +static CCU_GATE_DEFINE(pll1_d2_1228p8, "pll1_d2_1228p8", CCU_PARENT_HW(pll1_d2),
> > > +		       MPMU_ACGR,
> > > +		       BIT(16), BIT(16), 0, 0);

...

> > I couldn't find the "ripc_clk" on the clock tree diagram.  It is
> > never used elsewhere, so I think this definition can go away.
> 
> I'm not sure whether the ripc_clk doesn't exist or it's just missing in
> both datasheet and clock tree diagram. Will confirm with the vendor.

It's just missing in the datasheet and clock tree diagram and now they
have been completed[1].

> > > +static CCU_GATE_DEFINE(ripc_clk, "ripc_clk", CCU_PARENT_NAME(vctcxo_24m),
> > > +		       MPMU_RIPCCR,
> > > +		       0x3, 0x3, 0x0,
> > > +		       0);
> > > +

....

> > > +static const struct clk_parent_data dpubit_parents[] = {
> > > +	CCU_PARENT_HW(pll1_d3_819p2),
> > > +	CCU_PARENT_HW(pll2_d2),
> > > +	CCU_PARENT_HW(pll2_d3),
> > > +	CCU_PARENT_HW(pll1_d2_1228p8),
> > > +	CCU_PARENT_HW(pll2_d4),
> > > +	CCU_PARENT_HW(pll2_d5),
> > 
> > The next two parent clocks are duplicates.  It looks this way on the
> > clock tree diagram as well.  Is this correct? Can you find out from
> > SpacemiT whether one of them is actually a different clock (like
> > pll2_d6 or something)?  It makes no sense to have two multiplexed
> > parent clocks with the same source.
> 
> Yes, will confirm it later. The register description[2] suggests it's
> wrong (there aren't two configuration for MIPI_BIT_CLK_SEL resulting in
> the same frequency).

The clock tree diagram (and the vendor driver) were wrong. The 7th.
parent should be pll2_d7 (427MHz * 7 is roughly 3GHz, which is PLL2's
frequency). The diagram has been corrected.

> > > +	CCU_PARENT_HW(pll2_d8),
> > > +	CCU_PARENT_HW(pll2_d8),
> > > +};
> > > +static CCU_DIV_FC_MUX_GATE_DEFINE(dpu_bit_clk, "dpu_bit_clk", dpubit_parents,
> > > +				  APMU_LCD_CLK_RES_CTRL1,
> > > +				  17, 3, BIT(31),
> > > +				  20, 3, BIT(16), BIT(16), 0x0,
> > > +				  0);
> > > +

...

> > > diff --git a/drivers/clk/spacemit/ccu_ddn.c b/drivers/clk/spacemit/ccu_ddn.c
> > > new file mode 100644
> > > index 000000000000..1df555888ecb
> > > --- /dev/null
> > > +++ b/drivers/clk/spacemit/ccu_ddn.c
> > > @@ -0,0 +1,140 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Spacemit clock type ddn
> > > + *
> > > + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> > > + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> > > + */
> > > +
> > > +#include <linux/clk-provider.h>
> > > +
> > > +#include "ccu_ddn.h"
> > 
> > What does "DDN" stand for?
> 
> I'm not sure, the name is kept from the vendor driver. I could change it
> to a more descriptive name, like "fraction-factor".

It's abbreviated from "Divider Denominator Numerator", confirmed by the
vendor. Quite weird a name. I'll make the abbreviation and corresponding
explanation more clear in the next revision.

Thanks,
Haylen Chu

[1]: https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb#part208

