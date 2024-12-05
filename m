Return-Path: <linux-kernel+bounces-433245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBB19E5585
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCAE2823E8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789F5218853;
	Thu,  5 Dec 2024 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2rGECUB6"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F4D218837;
	Thu,  5 Dec 2024 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401806; cv=none; b=hoBNR3O6Yyab8OHPzAiZPEHD1RbnsjFjlDeGV2YXJK75S/fCiTi21aHH83CGY1ec8stKpTlehRdHeSvU6CKKRTNW84JTmES0gA4Dw+TfKLpPspHhEP5SZhHYD60BjRJC/NDa0zEAo7xhv8roFRVC77lIQCuQ2faAuQtpl0jYdoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401806; c=relaxed/simple;
	bh=VGU4w5y/tztTb1UbHL5+s7wqk304mJOk28FqC3cXd/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHFwDLfu6IbZ16sRk85eJqeKNRsXkWbNzsKLKb2oyezl7HEM2XU7nViB/z6v/XDp5ooh843Wljio+tjk6O2xml5HiBsiH9ViwDBsIsjZEPs9vcoHUao0UqZAhRJ1OioCXrrE+2jz7CkpplhMTyXJZoe2rBd1BiZPfbbzyD+wARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2rGECUB6; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FDTpwgkDlbRc1zIFut/KEqYGHdEqAg2rBPP//jqqsak=; b=2rGECUB6il0LywPas6Kn3dUIhN
	NPlpm80YqXB+YXBd7D8OOzYK54IFSl4WsdFh3hpmP4jMzqHn3Beh/ld2frmibcVbI29x2GNe4Fw5L
	ggHGa0ciIkz3oBa954gOM/XEUFaXGUyAxlDcgsKd2xmYHn9wvEucak/oqGjI27IBDTjKP/XQFM4Js
	WtruVkYZq5VmVn/jHFOxX2Vk1lANiYz0QovoCeVk5IeZRWyhkKo2OAyRbG59oD+bj90ho63zwE+qh
	OPQgWTPkrmmrhZJeGecAbvh9TBgCtA0FUx/PFILTdrOzxY9DWDafE+XyXFK5MDoxXrJcCW8dsiaB7
	tfV/BC6Q==;
Received: from i5e86190f.versanet.de ([94.134.25.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tJAzU-00048V-2e; Thu, 05 Dec 2024 13:29:56 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Val Packett <val@packett.cool>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH] clk: rockchip: add clock ID for CIF0/1 on RK3066
Date: Thu, 05 Dec 2024 13:29:55 +0100
Message-ID: <1944322.g5d078U9FE@diego>
In-Reply-To: <5kesytgbhfununu5li4ychaw4newkctx4wuhlshks2ertfkd2t@jauqcntehv2z>
References:
 <20241205055122.11613-1-val@packett.cool>
 <5kesytgbhfununu5li4ychaw4newkctx4wuhlshks2ertfkd2t@jauqcntehv2z>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Krzysztof,

Am Donnerstag, 5. Dezember 2024, 11:25:28 CET schrieb Krzysztof Kozlowski:
> On Thu, Dec 05, 2024 at 02:50:46AM -0300, Val Packett wrote:
> > RK3066 does have two "CIF" video capture interface blocks, add their
> > corresponding clock IDs so that they could be used.
> > 
> > Signed-off-by: Val Packett <val@packett.cool>
> > ---
> >  drivers/clk/rockchip/clk-rk3188.c             | 4 ++--
> >  include/dt-bindings/clock/rk3188-cru-common.h | 2 ++
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> run 'scripts/checkpatch.pl --strict' and (probably) fix more warnings.
> Some warnings can be ignored, especially from --strict run, but the code
> here looks like it needs a fix. Feel free to get in touch if the warning
> is not clear.

I guess you're taking a shot of the indentation?

Though that is an intentional deviation, for the long lists of
clock-declarations, that is more a spreadsheet than actual code.

To give this some context, an excerpt from the rk3188 clock driver:

        COMPOSITE(0, "aclk_lcdc1_pre", mux_pll_src_cpll_gpll_p, 0,
                        RK2928_CLKSEL_CON(31), 15, 1, MFLAGS, 8, 5, DFLAGS,
                        RK2928_CLKGATE_CON(1), 4, GFLAGS),
        GATE(ACLK_PERI, "aclk_peri", "aclk_peri_pre", 0,
                        RK2928_CLKGATE_CON(2), 1, GFLAGS),
        COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_pre", 0,
                        RK2928_CLKSEL_CON(10), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
                        RK2928_CLKGATE_CON(2), 2, GFLAGS),
        MUX(0, "cif_src", mux_pll_src_cpll_gpll_p, 0,
                        RK2928_CLKSEL_CON(29), 0, 1, MFLAGS),

Rockchip clocks most of the time consist of a mux+divider in one register
and a gate-bit in another. Most clocks are of the COMPOSITE-type above.
Surprisingly this is true since before 2013 - and even today :-) .

So the notation is
      TYPE(id, name, parent-name(s), main-clk-flags,
	MUXDIV-reg, muxoffset, muxwidth, muxflags, divoffset, divwidth, divflags,
	GATE-reg, gatebit, gateflags)

Having all these elements keep their relative position makes it way easier
on the eyes, compared to if they followed that opening parenthesis of each
individual line or maybe reflowing of the elements.

The only real change the clock definitions will see are fixes to wrong
register numbers or wrong bits (or missing clock-ids), so being able to
see check those easily is just nice to have.


Heiko



