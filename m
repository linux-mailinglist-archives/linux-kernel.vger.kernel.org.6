Return-Path: <linux-kernel+bounces-528536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601EBA418CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E21F3A1F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F0E253B4A;
	Mon, 24 Feb 2025 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="C2Fa0Csg"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82F2505C1;
	Mon, 24 Feb 2025 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388480; cv=none; b=TM4GmCKT3KZ2QPT56uCIV03ETTsfYsPA2vvEx5p7fWgXJIk+Xu252BYB5Nu/zFmK/bEG/2ji28WZ4fXjYs2KIU69OvyTA1HsUvUWIubfCWkWXhkGssjXingVpDFnsLaZ/BFbW0wmIRgiKZoqtWLKtqxVhRNFR6ijKxoSam4TTxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388480; c=relaxed/simple;
	bh=xTzt/V7CzY1hpEI3Om7LRDujb1rhEg9ix3VdzeV16hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrCcI3+CKRNvCElcIuh43QMXsn8J72Q//OXuytAk6WCIAER+GoutSIKEF8SfYJ+LqxMGgNJ5BWbES/JBhUECAPhYA8bNjbZxk54kjFHriiTF/kRJ7nVOGAs2BUD+KoGYbQ+no3lJKQvkD0FcEcDJfOkL+aZbvI1b2ciSYHe0ivw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=C2Fa0Csg; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XWEADniHRGWcnzqbekRTv6/vtyL/MFZqYvazyCcPL/Y=; b=C2Fa0CsgkZ2/azdEMvlOzuYSf7
	k3nUPkbtzi80jhqlddLODTZArqrjOaDbkhu6v27OfN1fu15qYrE1R7QEaDmBLvJTpwOZuImxSCdlv
	PT7OHUIEehio+7EhaWCLkC5l2t1hnzwI3nK3xiD5mN1WzY9Ka+RgqS0uWK29Azt0pT4VxziiuCJYS
	3+2l23UyPbiwiiGCJJ2j0ecmxMejx0hIixnJwUe4ao8qPsil05p4lQCEFfZyV9tyVszURLYogUaFm
	F4EZIRXEQXn/DnoDqOooXtpsFYdHDBnzKB+LhJ2uBs5gGKOt+rhPaMwyRhRKK9AWlvUvhOiODeSmY
	AsSi5PrQ==;
Received: from i53875a0d.versanet.de ([83.135.90.13] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tmUXo-0006wL-ID; Mon, 24 Feb 2025 10:14:32 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org,
 Finley Xiao <finley.xiao@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: clock,
 reset: rockchip: Add support for rk3562
Date: Mon, 24 Feb 2025 10:14:31 +0100
Message-ID: <2920539.yaVYbkx8dN@diego>
In-Reply-To: <28dcac28-9060-4f65-8167-64f6a0e4532d@rock-chips.com>
References:
 <20241224092310.3814460-1-kever.yang@rock-chips.com>
 <z7jb32foci6bamqqddkkp34hazi2itp6uclarsoi5pkrgso2go@bxflagkaciq6>
 <28dcac28-9060-4f65-8167-64f6a0e4532d@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Montag, 24. Februar 2025, 09:47:40 MEZ schrieb Kever Yang:
> Hi Krzysztof,
> 
> On 2024/12/27 16:28, Krzysztof Kozlowski wrote:
> > On Tue, Dec 24, 2024 at 05:23:09PM +0800, Kever Yang wrote:
> >> From: Finley Xiao <finley.xiao@rock-chips.com>
> >>
> >> Add the dt-bindings header for the rk3562, that gets shared between
> >> the clock controller and the clock references in the dts.
> >> Add softreset ID for rk3562.
> >>
> >> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> >> Signed-off-by: Liang Chen <cl@rock-chips.com>
> >> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> >> ---
> >>
> >> Changes in v2:
> >> - rename the file to rockchip,rk3562-cru.h
> >> - remove CLK_NR_CLKS
> >> - add new file for reset ID
> >> - update to use dual license
> >>
> >>   .../dt-bindings/clock/rockchip,rk3562-cru.h   | 377 ++++++++++++++++++
> >>   .../dt-bindings/reset/rockchip,rk3562-cru.h   | 360 +++++++++++++++++
> >
> > No, that's not a separate patch. Headers *ALWAYS* go with the bindings
> > patch.
> Will fix.
> >>   2 files changed, 737 insertions(+)
> >>   create mode 100644 include/dt-bindings/clock/rockchip,rk3562-cru.h
> >>   create mode 100644 include/dt-bindings/reset/rockchip,rk3562-cru.h
> >>
> >> diff --git a/include/dt-bindings/clock/rockchip,rk3562-cru.h b/include/dt-bindings/clock/rockchip,rk3562-cru.h
> >> new file mode 100644
> >> index 000000000000..ad07ad3a12ad
> >> --- /dev/null
> >> +++ b/include/dt-bindings/clock/rockchip,rk3562-cru.h
> >> @@ -0,0 +1,377 @@
> >> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > Why not using license requested by checkpatch?
> 
> The checkpatch does not report error/warning for this license, and this 
> is the same as many other SoCs.
> 
> Which license is recommend in the header file?

I suppose

/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */

According to [0] "GPL-2.0" and "GPL-2.0-only" are equivalent, but I guess
"GPL-2.0-only" simply makes the "only" part more visible.


Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/LICENSES/preferred/GPL-2.0




