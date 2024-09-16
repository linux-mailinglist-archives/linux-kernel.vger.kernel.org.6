Return-Path: <linux-kernel+bounces-330460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 496DE979ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018691F23D56
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4E814EC4B;
	Mon, 16 Sep 2024 09:54:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A29714E2E3;
	Mon, 16 Sep 2024 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480494; cv=none; b=JvlyHFYkYKNcAkxnkgtQAVo082Hw1c17mFC315Go0KAmz7sqe0NuwKftIULfF0FmLKU6xmZXH/r+hSAwVFgoyhGDdFAcT83tmpImAieopqIHpBZgckGCWapUlSi5TN6XEk39TB4lUT32AgQ228XKzuliDRfrULDdN00CbRHE74s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480494; c=relaxed/simple;
	bh=3zhFERW+ABv2xBeqqfsJmsFaCIsJm9felNo1s/sH2Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJW9tdvTWLRYqX39/NzSTWY2q8LbzzU9WnRaEfobvyL14y2E0o1NCCmADIWAeSnJb5jt+Ktqc0WlOE3GUWWPGOq/3JwsDFE8M6Zw6y1k5ZHwUpuJbAOlbHqFr8ZHpnMUfB1RNuioQB66QU8/5oWbpUp2ZCgdH3mayy/ihvatX5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C28211FB;
	Mon, 16 Sep 2024 02:55:21 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DA363F64C;
	Mon, 16 Sep 2024 02:54:49 -0700 (PDT)
Date: Mon, 16 Sep 2024 10:54:40 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, devicetree@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com, robh@kernel.org, krzk+dt@kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v1 3/6] firmware: arm_scmi: Use max-rx-timeout-ms from
 devicetree
Message-ID: <Zuf_3D636c3JXypF@pluto>
References: <20240730144707.1647025-1-cristian.marussi@arm.com>
 <20240730144707.1647025-4-cristian.marussi@arm.com>
 <1ea7fff0-149d-408a-b5a7-1b223e8509d0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ea7fff0-149d-408a-b5a7-1b223e8509d0@gmail.com>

On Thu, Sep 12, 2024 at 02:05:53PM -0700, Florian Fainelli wrote:
> On 7/30/24 07:47, Cristian Marussi wrote:
> > Override default maximum RX timeout with the value picked from the
> > devicetree, when provided.
> > 
> > Suggested-by: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >   drivers/firmware/arm_scmi/driver.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 332cd5207bbc..e7dab0eea540 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -2964,6 +2964,7 @@ static int scmi_debugfs_raw_mode_setup(struct scmi_info *info)
> >   static const struct scmi_desc *scmi_transport_setup(struct device *dev)
> >   {
> >   	struct scmi_transport *trans;
> > +	int ret;
> >   	trans = dev_get_platdata(dev);
> >   	if (!trans || !trans->desc || !trans->supplier || !trans->core_ops)
> > @@ -2980,6 +2981,14 @@ static const struct scmi_desc *scmi_transport_setup(struct device *dev)
> >   	dev_info(dev, "Using %s\n", dev_driver_string(trans->supplier));
> > +	ret = of_property_read_u32(dev->of_node, "max-rx-timeout-ms",
> > +				   &trans->desc->max_rx_timeout_ms);
> > +	if (ret && ret != -EINVAL)
> > +		dev_err(dev, "Malformed max-rx-timeout-ms DT property.\n");
> > +
> > +	dev_info(dev, "SCMI max-rx-timeout: %dms\n",
> > +		 trans->desc->max_rx_timeout_ms);
>

Hi Florian,
 
> I am bit on the fence on that change, it is useful, and we have done similar
> things before using a command line parameter.
> 

I think the requirement around this as it came from from NXP/Peng was that,
depending on the design (HW/FW) of the SCMI platform at hand it can be that
the same default transport timeout (that is by itself much larger than
usually needed) could still be not enough for the transport: I think the
example was mentioning a system with many agents, so that your request
could end-up been "bootle-necked" in the execution queue of the server (AFAIU)

In such a case (if you cannot avoid the issue at first by reviewing your
design...) you have the effective need of describing that specific
platform/transport timeout characteristic and override the built-in default....

...it was not meant to be usead as a plain configuration....even though I
suppose this is sort of a matter of interepretation (and that can be
abused downstream...)

> This is definitively useful when bringing up new systems where you might be
> sprinkling enough debugging messages that this pushes your message
> processing logic too close to the default 30ms timeout. For normal use
> cases, we really want the message timeout to be as small as possible for
> most SCMI traffic but if we want the timeout to be configurable, that might
> have have to be on a per-message basis.

A per-message timeout would need a lot of re-design, but how would you tune
then all the possibly different timeouts across different platforms and/or
transports combinations...this seems something that could need a lot of
runtime calibration and re-configuration on a live system....

...have you specifically seen the need for such varying per-message
timeout in some specific case ?

Thanks,
Cristian

