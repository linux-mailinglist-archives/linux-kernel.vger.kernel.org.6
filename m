Return-Path: <linux-kernel+bounces-263390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC6393D540
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC19B1C23198
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339781CD06;
	Fri, 26 Jul 2024 14:42:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85C91CF8A;
	Fri, 26 Jul 2024 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004920; cv=none; b=rCm5qodHUEhdH/bvtl3BhNSLMg5ZW+lOYVicjn3Xx0GbMmjGzCaBnutJhDH/YquBzhOeHTyytsZcGIeDTwZhsdwWkYi6Z9AFB20PXhFpHJrzeRcV9DHtpPyT2TsuCYCtFey62hwsFpKYlCny2FeUd5oe66v8dxu+6IYh6Nj1DZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004920; c=relaxed/simple;
	bh=OVjAR3xpxSrVrspulml4D2ZEroEl46/dn79c/9mOqXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcEfwnUDgnuu0hilu7G0G40Jv201YHoakwx04LpmXGQnmAO4TP+IpXNHnrTIzFEgMEpzIFmDGiaFmbGYFsJyMD7QfNkURcrkgocUUcxUa702pox6E53k4qFPxUGf0/nq6QQYEmrCrsE0UPtCNOp8+xqgguZz3LgDmvLUgw7LzGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 856C71007;
	Fri, 26 Jul 2024 07:42:23 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C5133F5A1;
	Fri, 26 Jul 2024 07:41:56 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:41:53 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Dhruva Gole <d-gole@ti.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	mturquette@baylibre.com, sboyd@kernel.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] clk: scmi: add is_prepared hook
Message-ID: <ZqO1sd2PP525g3U0@bogus>
References: <20240726131007.1651996-1-peng.fan@oss.nxp.com>
 <20240726134414.2ctbtt53sd3lyfjl@dhruva>
 <ZqOuWbgCORuk9Qu5@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqOuWbgCORuk9Qu5@pluto>

On Fri, Jul 26, 2024 at 03:11:08PM +0100, Cristian Marussi wrote:
> On Fri, Jul 26, 2024 at 07:14:14PM +0530, Dhruva Gole wrote:
> > On Jul 26, 2024 at 21:10:07 +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > > 
> > > Some clks maybe default enabled by hardware, so add is_prepared hook
> > > for non-atomic clk_ops to get the status of the clk. Then when disabling
> > > unused clks, those unused clks but default hardware on clks could be
> > > in off state to save power.
> > > 
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > > 
> > > V2:
> > >  Provider helper __scmi_clk_is_enabled for atomic and non-atomic usage
> > >  Move is_prepared hook out of SCMI_CLK_STATE_CTRL_SUPPORTED
> > > 
> > >  drivers/clk/clk-scmi.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> > > index d86a02563f6c..15510c2ff21c 100644
> > > --- a/drivers/clk/clk-scmi.c
> > > +++ b/drivers/clk/clk-scmi.c
> > > @@ -156,13 +156,13 @@ static void scmi_clk_atomic_disable(struct clk_hw *hw)
> > >  	scmi_proto_clk_ops->disable(clk->ph, clk->id, ATOMIC);
> > >  }
> > >  
> > > -static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
> > > +static int __scmi_clk_is_enabled(struct clk_hw *hw, bool atomic)
> > 
> > I think we can combine other atomic/non atomic in the same way no?
> > Let me know if I should send a follow up patch based on this to make
> > __scmi_clk_enable(hw,atomic) and __scmi_clk_disable(hw,atomic)
> 
> I dont think that it is worth unifying also the disable/enable atomic and
> non_atomic versions because if you look at their implementations they are
> indeed already wrappers around the state_get()....this new is_prepared/is_enabled
> were more 'thick' and so there was  a lot of duplicated code.
> 

+1, was planning to respond with similar message. Just jumped now as you
made it easier for me 😁.

-- 
Regards,
Sudeep

