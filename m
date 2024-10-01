Return-Path: <linux-kernel+bounces-345168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C71698B2A3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5889B23EF0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2784446AF;
	Tue,  1 Oct 2024 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p/ID9cEn"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1437CBA37
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 03:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727752250; cv=none; b=YCbCIZ4P0ygUEignIR5vIL+TCcghAPNOomamj0JgTy3BF+rco2iH1K+IksBgl6uCEEPCzLbky8e///nolAwVibe1OafbQ5eyPDC7+GvYwzlq6eSho2GNaV+XT7ysgLnfGvPQboezH0xv4ctxKD+A8pQJ2/Cvb8ffth8LYRxo51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727752250; c=relaxed/simple;
	bh=zDo6LgMEnvzKY4kkqe8wa5LuELf0DSEJkoGGaFTzP7c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+Qw7ZAaJIFUfP2gYOwydTDd6zyeBbcy4a1xHGXgMSKYKoINkr4YDWmIG/oq5Wg5awOWXkdLAKOSnNbt16A20pFJGBUtVgsA4s23AeX65yvZshLf09K4Tyqa2IGH9OxPW9eyZe9AicoCojuh22NiV9nz8AfvTwoKgA35IYThAIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=p/ID9cEn; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4913ATmW103165;
	Mon, 30 Sep 2024 22:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727752229;
	bh=kfwMURVy/yiodMLPMigVXkX4hDEnfqhR+Eng6XlVuaE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=p/ID9cEnKwPGSc2GLSxaMFuzMVU1dlKBLv9NmQ5NNBnJeNCxNfMNyobx8/3LpurOE
	 ss0hO18Vlg1HnvswI6PHwZkCrg38NhgVB7ck4zK3uD8k1Ve/IYX9pyuSMobWXCh8dC
	 25WIs4JvNK8mLiRfFQu+N2Jk4XcjHsQVe3R+5Tzs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4913ATjL104314;
	Mon, 30 Sep 2024 22:10:29 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Sep 2024 22:10:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Sep 2024 22:10:29 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4913ARmS086854;
	Mon, 30 Sep 2024 22:10:28 -0500
Date: Tue, 1 Oct 2024 08:40:27 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <thomas.richard@bootlin.com>,
        <krzysztof.kozlowski@linaro.org>, <nichen@iscas.ac.cn>,
        <c-vankar@ti.com>, <t-patil@ti.com>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH v2] phy: ti: phy-j721e-wiz: fix usxgmii configuration
Message-ID: <c5ef5303-6390-4f2b-b9d2-3d1f3085e15f@ti.com>
References: <20240930095745.3007057-1-s-vadapalli@ti.com>
 <4b42b8e5-3246-4f58-b494-735930d2424a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4b42b8e5-3246-4f58-b494-735930d2424a@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Mon, Sep 30, 2024 at 05:06:35PM +0300, Roger Quadros wrote:

Hello Roger,

> Hi Siddharth,
> 
> On 30/09/2024 12:57, Siddharth Vadapalli wrote:
> > Commit b64a85fb8f53 ("phy: ti: phy-j721e-wiz.c: Add usxgmii support in
> > wiz driver") added support for USXGMII mode. In doing so, P0_REFCLK_SEL
> > was set to "pcs_mac_clk_divx1_ln_0" (0x3) and P0_STANDARD_MODE was set to
> > LANE_MODE_GEN1, which results in a data rate of 5.15625 Gbps. However,
> > since the USXGMII mode can support up to 10.3125 Gbps data rate, the
> > aforementioned fields should be set to "pcs_mac_clk_divx0_ln_0" (0x2) and
> > LANE_MODE_GEN2 respectively. Fix the configuration accordingly to truly
> > support USXGMII up to 10G.
> > 
> > Fixes: b64a85fb8f53 ("phy: ti: phy-j721e-wiz.c: Add usxgmii support in wiz driver")
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

[...]

> > diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
> > index a6c0c5607ffd..c6e846d385d2 100644
> > --- a/drivers/phy/ti/phy-j721e-wiz.c
> > +++ b/drivers/phy/ti/phy-j721e-wiz.c
> > @@ -450,8 +450,8 @@ static int wiz_mode_select(struct wiz *wiz)
> >  		} else if (wiz->lane_phy_type[i] == PHY_TYPE_USXGMII) {
> >  			ret = regmap_field_write(wiz->p0_mac_src_sel[i], 0x3);
> >  			ret = regmap_field_write(wiz->p0_rxfclk_sel[i], 0x3);
> 
> I'm not sure. Don't we have to change rxfclk as well?

This patch was validated on a custom board with the J7200 SR 2.0 SoC.
The signal corresponding to the USXGMII lane of the SERDES was measured
to be 5 Gbps without this patch and 10 Gbps with this patch applied,
with no other changes required. Apart from measuring the signal, ping
was also validated.

Regards,
Siddharth.

