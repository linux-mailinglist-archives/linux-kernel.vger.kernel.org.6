Return-Path: <linux-kernel+bounces-263359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE05F93D4DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF41A1C23206
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C230DDBB;
	Fri, 26 Jul 2024 14:11:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7BDBA53;
	Fri, 26 Jul 2024 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003079; cv=none; b=pyZ9p7EPe35u2koAfZu+agd7sKLtRMAqWcJuPPKusBzDY2dEHfFjYO2msp1th9vnFcFqK/yC3S1G7z2NG2nfZSyufjpQj6AWW9ca2OhVqCOhqk+cgZpm6w+RTh8wQQf35iVUDQQR6lMdM2+AYOj+b39Xchip9HWy76QNczGTTcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003079; c=relaxed/simple;
	bh=zEr9H7Wa1FABRd3qLNtLWStAv6BKpQSiyLtESCv1J/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlL1hacpAulBt++/lPKC8vCDWMYMRsbKy4hZ2qEsb2DxmaHf8q/6eJDud2tNJVFGL8jvoV3/AdqWjwcNPN6n4NNT9+m8drlXWzC1wxG8jldDnfj6g0fojRMzvJyeOikYz6TUuzXpwvdlWElSSEuV/TG3zKcRzVCkbIUWV8xt/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 579471007;
	Fri, 26 Jul 2024 07:11:42 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 311973F5A1;
	Fri, 26 Jul 2024 07:11:15 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:11:08 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, sudeep.holla@arm.com,
	cristian.marussi@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] clk: scmi: add is_prepared hook
Message-ID: <ZqOuWbgCORuk9Qu5@pluto>
References: <20240726131007.1651996-1-peng.fan@oss.nxp.com>
 <20240726134414.2ctbtt53sd3lyfjl@dhruva>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726134414.2ctbtt53sd3lyfjl@dhruva>

On Fri, Jul 26, 2024 at 07:14:14PM +0530, Dhruva Gole wrote:
> On Jul 26, 2024 at 21:10:07 +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > Some clks maybe default enabled by hardware, so add is_prepared hook
> > for non-atomic clk_ops to get the status of the clk. Then when disabling
> > unused clks, those unused clks but default hardware on clks could be
> > in off state to save power.
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > 
> > V2:
> >  Provider helper __scmi_clk_is_enabled for atomic and non-atomic usage
> >  Move is_prepared hook out of SCMI_CLK_STATE_CTRL_SUPPORTED
> > 
> >  drivers/clk/clk-scmi.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> > index d86a02563f6c..15510c2ff21c 100644
> > --- a/drivers/clk/clk-scmi.c
> > +++ b/drivers/clk/clk-scmi.c
> > @@ -156,13 +156,13 @@ static void scmi_clk_atomic_disable(struct clk_hw *hw)
> >  	scmi_proto_clk_ops->disable(clk->ph, clk->id, ATOMIC);
> >  }
> >  
> > -static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
> > +static int __scmi_clk_is_enabled(struct clk_hw *hw, bool atomic)
> 
> I think we can combine other atomic/non atomic in the same way no?
> Let me know if I should send a follow up patch based on this to make
> __scmi_clk_enable(hw,atomic) and __scmi_clk_disable(hw,atomic)

I dont think that it is worth unifying also the disable/enable atomic and
non_atomic versions because if you look at their implementations they are
indeed already wrappers around the state_get()....this new is_prepared/is_enabled
were more 'thick' and so there was  a lot of duplicated code.

Thanks
Cristian

