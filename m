Return-Path: <linux-kernel+bounces-381892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11569B05EE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7076FB23BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2489D1FF7B6;
	Fri, 25 Oct 2024 14:36:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E471F80DC;
	Fri, 25 Oct 2024 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866965; cv=none; b=N6P4QP7pN8njj1OXmRm4J9lKcGifyuXCn0KX65CSyry/G2SAVBJO3Z0bligamgVqTfENE2bJCvhEEBaM+i5byxZfi1AntqQyOBZ9APYtsMrvokcXtxULsEOplGnwKzDNX84oo52Q/V06S2aiCQXsgGN7Pz3sJjMm9UaZhy8gVHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866965; c=relaxed/simple;
	bh=5FVdvt9rSkyZezJ0FrEiLOyX/LB9EgrsfJvzyaqY3Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htMvlpA4jb8awdelikKYQsCgs4rFhlU7I6OvupGOctc7U+FtwOj65nQjD2C6Pqpk/h7Pbu0MxdXwXzc8Om79fFOgDGifJADuWI7WZYJ/BECtXF4HD+bBlY3EShJGvjeWmR4xyAkmWenPfBPXoi7Clb1SmqfcFqqJpUXh4ColaQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E628F339;
	Fri, 25 Oct 2024 07:36:31 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6288E3F73B;
	Fri, 25 Oct 2024 07:36:00 -0700 (PDT)
Date: Fri, 25 Oct 2024 15:35:57 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com
Subject: Re: [PATCH 5/5] firmware: arm_scmi: Relocate atomic_threshold to
 scmi_desc
Message-ID: <ZxuszZFKdJoHwiSe@pluto>
References: <20241018080602.3952869-1-cristian.marussi@arm.com>
 <20241018080602.3952869-6-cristian.marussi@arm.com>
 <842a9844-ac89-4972-9024-72ed0e08c2d3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <842a9844-ac89-4972-9024-72ed0e08c2d3@stanley.mountain>

On Wed, Oct 23, 2024 at 04:20:53PM +0300, Dan Carpenter wrote:
> On Fri, Oct 18, 2024 at 09:06:02AM +0100, Cristian Marussi wrote:

Hi Dan,

thanks for having a look.

> > @@ -2959,7 +2952,7 @@ static struct scmi_debug_info *scmi_debugfs_common_setup(struct scmi_info *info)
> >  			   (char **)&dbg->name);
> >  
> >  	debugfs_create_u32("atomic_threshold_us", 0400, top_dentry,
> > -			   &info->atomic_threshold);
> > +			   (u32 *)&info->desc->atomic_threshold);
> 
> This cast is unnecessary.

I was indeed wondering why I added that....then I remember something
about debugfs_create....without that (u32 *):

drivers/firmware/arm_scmi/driver.c: In function ‘scmi_debugfs_common_setup’:
drivers/firmware/arm_scmi/driver.c:2988:28: warning: passing argument 4 of ‘debugfs_create_u32’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
                             &info->desc->atomic_threshold);
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

since the enclosing struct ->desc is const AND debugfs_create_u32 is NOT
smart enough to expect a const when the property is R_ONLY...unless I am
missing something.

> 
> >  
> >  	debugfs_create_str("type", 0400, trans, (char **)&dbg->type);
> >  
> > @@ -3071,6 +3064,13 @@ static const struct scmi_desc *scmi_transport_setup(struct device *dev)
> >  		 trans->desc->max_rx_timeout_ms, trans->desc->max_msg_size,
> >  		 trans->desc->max_msg);
> >  
> > +	/* System wide atomic threshold for atomic ops .. if any */
> > +	if (!of_property_read_u32(dev->of_node, "atomic-threshold-us",
> > +				  &trans->desc->atomic_threshold))
> > +		dev_info(dev,
> > +			 "SCMI System wide atomic threshold set to %d us\n",
>                                                                    ^^
> %u for unsigned int.
>

I will fix.

Thanks,
Cristian

