Return-Path: <linux-kernel+bounces-263097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4367893D107
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04985280FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A722178CC8;
	Fri, 26 Jul 2024 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DcZeFSwA"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA382B9C4;
	Fri, 26 Jul 2024 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989294; cv=none; b=quSXOEU0H6gxEp1n1TGe9KbYWJPmJjRLqgfththPPD1G3/4YhZFJ+WOboCAC6Sl4agX9AmJhv/hNOD9erK4IN7B7b8yodlt6Vn5O1Q6GOFMQGONVpWzdrUOGVb4qxyqe1qeNWDMIvW4964J98mlw/3CKJ4JcyGRLnJQImEERsZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989294; c=relaxed/simple;
	bh=S/x4OJAKOpbCcalQ3AmuCSpX6cHV4yf/SgFn4iRJr34=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evgth7cYJV6PFEf7WQA9ZWPmAkgBIGtpJi9a2/eEjxFnwrxoznpFMjAqQyT8DmV2ebnwxEZ5mId6AwOz2E2626rSuhjRSDcyqjmvG6YFAX4azwrr8u3WIMtDXsGOt5KFsOS2qsNMLn0jMXwPznWX15tnWzK1LBci6BGwo1QLhQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DcZeFSwA; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46QAL4Wk043121;
	Fri, 26 Jul 2024 05:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721989264;
	bh=DDWXHd+C8mav68s6sbzJJqLpFP/Y42ZVqzrbT7u/foo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=DcZeFSwA0qqtfUyqsNflK8Q/HpG2kzTmKjEuo1CeCePlnYZzgFRQtDFTNW/97zkRd
	 w+xTRjEt0rj4c6fv8WfrXb8TmUpKBsFZ2dvGpmQQfiADbRq6F2i9+v6ZCZhzVx9zl9
	 GhEXwIpNHNqnAiqbpMZZYL8SylY5UBUvUSSWtuCY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46QAL4n3085116
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Jul 2024 05:21:04 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Jul 2024 05:21:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Jul 2024 05:21:04 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46QAL31v067014;
	Fri, 26 Jul 2024 05:21:04 -0500
Date: Fri, 26 Jul 2024 15:51:03 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Peng Fan <peng.fan@nxp.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>,
        "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>,
        "mturquette@baylibre.com"
	<mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>, "kamlesh@ti.com" <kamlesh@ti.com>
Subject: Re: [PATCH] clk: scmi: add is_prepared hook
Message-ID: <20240726102103.dh6upqdeq2tj4hgn@dhruva>
References: <20240725090741.1039642-1-peng.fan@oss.nxp.com>
 <20240726085305.sb57f3i2ezvtwrwz@dhruva>
 <PAXPR04MB8459C5A372FADDD970BCA33088B42@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459C5A372FADDD970BCA33088B42@PAXPR04MB8459.eurprd04.prod.outlook.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Jul 26, 2024 at 09:28:52 +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] clk: scmi: add is_prepared hook
> > 
> > On Jul 25, 2024 at 17:07:41 +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Some clks maybe default enabled by hardware, so add is_prepared
> > hook
> > 
> > Why is_prepared when there is an is_enabled hook?
> 
> This patch is for non-atomic clk ops. The is_enabled hook is
> In atomic clk ops.
> 
> > See in the atomic case we already have something similar:
> > 
> > ops->is_enabled = scmi_clk_atomic_is_enabled;
> > 
> > > to get the status of the clk. Then when disabling unused clks, those
> > > unused clks but default hardware on clks could be in off state to save
> > > power.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/clk/clk-scmi.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c index
> > > d86a02563f6c..d2d370337ba5 100644
> > > --- a/drivers/clk/clk-scmi.c
> > > +++ b/drivers/clk/clk-scmi.c
> > > @@ -142,6 +142,20 @@ static void scmi_clk_disable(struct clk_hw
> > *hw)
> > >  	scmi_proto_clk_ops->disable(clk->ph, clk->id, NOT_ATOMIC);  }
> > >
> > > +static int scmi_clk_is_enabled(struct clk_hw *hw) {
> > > +	int ret;
> > > +	bool enabled = false;
> > > +	struct scmi_clk *clk = to_scmi_clk(hw);
> > > +
> > > +	ret = scmi_proto_clk_ops->state_get(clk->ph, clk->id, &enabled,
> > NOT_ATOMIC);
> > > +	if (ret)
> > > +		dev_warn(clk->dev,
> > > +			 "Failed to get state for clock ID %d\n", clk-
> > >id);
> > > +
> > > +	return !!enabled;
> > > +}
> > > +
> > >  static int scmi_clk_atomic_enable(struct clk_hw *hw)  {
> > >  	struct scmi_clk *clk = to_scmi_clk(hw); @@ -280,6 +294,7
> > @@
> > > scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
> > >  		} else {
> > >  			ops->prepare = scmi_clk_enable;
> > >  			ops->unprepare = scmi_clk_disable;
> > > +			ops->is_prepared = scmi_clk_is_enabled;
> > 
> > IMO from the decription and what the function is doing is_enabled
> > makes
> > more sense here to me, unless there's a better explanation.
> > 
> > Ref: linux/clk-provider.h
> > is_prepared: Queries the hardware to determine if the clock is prepared
> > vs
> > is_enabled: Queries the hardware to determine if the clock is enabled
> 
> SCMI firmware has no knowledge of prepare/unprepared.
> 
> As wrote in the beginning, this patch is for non atomic clk ops.

OK, I got carried away with the wording of is_prepared a bit but it
seems like prepare/unprepare are inter changeably used to enable/disable
in non atomic cases and so it makes sense to follow suit with is_prepared.

Thanks for clarifying,

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva

