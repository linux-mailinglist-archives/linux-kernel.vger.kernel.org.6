Return-Path: <linux-kernel+bounces-375994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65A99A9E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA101F21C20
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25B2197A87;
	Tue, 22 Oct 2024 09:18:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EEF193417;
	Tue, 22 Oct 2024 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588730; cv=none; b=QwqImn2O+HVfIR7suHvWMiRK1ufDq7JnkqvwdxMYtyBT7pRcsPPde1PUgBsZvgrhAyMhls0QbL+Y1ottEyyXwEPHttm/g0cinkljDwmvEN9jD/47dQFkXyM5eCXXUoZonXC2OU8s44s6NXnpD+NMB6VZRKKGCCcKrYTdorHvd7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588730; c=relaxed/simple;
	bh=GZ4DZzLfaNYUZzQdV+gdnTQgV9+Vvce8HGSsHjInUDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPZqf1bE+oVyiVrrdnFTpjsCq+8eKAdHEVh8YSSGWPosA9Z63BHlkUG7Efyui2iFX1a/bHQzf8xNAqrlkg5jE1yeUeW4Q0rbQ4PtGKJnO/7Uf/8Aj3czxCcv8tqBSCKKDfZccjBs2FHJ0qn7rutOGqHJlRedZF/F7tSMvnEuryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75A39497;
	Tue, 22 Oct 2024 02:19:13 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B01223F73B;
	Tue, 22 Oct 2024 02:18:41 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:18:34 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, quic_nkela@quicinc.com,
	dan.carpenter@linaro.org
Subject: Re: [PATCH v2 1/5] firmware: arm_scmi: Account for SHMEM memory
 overhead
Message-ID: <Zxdt6vLeExBs744x@pluto>
References: <20241021170726.2564329-1-cristian.marussi@arm.com>
 <20241021170726.2564329-2-cristian.marussi@arm.com>
 <5d6d545d-b6bc-4b37-b324-a664e4685100@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d6d545d-b6bc-4b37-b324-a664e4685100@broadcom.com>

On Mon, Oct 21, 2024 at 10:11:44AM -0700, Florian Fainelli wrote:
> On 10/21/24 10:07, Cristian Marussi wrote:
> > Transports using shared memory have to consider the overhead due to the
> > layout area when determining the area effectively available for messages.
> > 

Hi Florian,

thanks for having a look.

> > Till now, such definitions were ambiguos across the SCMI stack and the
> > overhead layout area was not considered at all.
> > 
> > Add proper checks in the shmem layer to validate the provided max_msg_size
> > against the effectively available memory area, less the layout.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > Note that as a consequence of this fix the default max_msg_size is reduced
> > to 104 bytes for shmem-based transports, in order to fit into the most
> > common implementations where the whole shmem area is sized at 128,
> > including the 24 bytes of standard layout area.
> > 
> > This should have NO bad side effects, since the current maximum payload
> > size of any messages across any protocol (including all the known vendor
> > ones) is 76 bytes.
> 
> This looks good to me, just a small nit/suggestion:
> 
> [snip]
> 
> >   	size = resource_size(res);
> > +	if (cinfo->max_msg_size + SCMI_SHMEM_LAYOUT_OVERHEAD > size) {
> > +		dev_err(dev, "misconfigured SCMI shared memory\n");
> > +		return IOMEM_ERR_PTR(-ENOSPC);
> > +	}
> > +
> >   	addr = devm_ioremap(dev, res->start, size);
> >   	if (!addr) {
> >   		dev_err(dev, "failed to ioremap SCMI %s shared memory\n", desc);
> > diff --git a/drivers/firmware/arm_scmi/transports/mailbox.c b/drivers/firmware/arm_scmi/transports/mailbox.c
> > index e7efa3376aae..4e0396250ad0 100644
> > --- a/drivers/firmware/arm_scmi/transports/mailbox.c
> > +++ b/drivers/firmware/arm_scmi/transports/mailbox.c
> > @@ -16,6 +16,8 @@
> >   #include "../common.h"
> > +#define SCMI_MAILBOX_MAX_MSG_SIZE	104
> 
> This IMHO, could be named SCMI_SHMEM_MAX_PAYLOAD_SIZE and used across all 3
> transports that are loosely SHMEM-based?

Yes indeed, just I was not so sure we want to stick to the same default
across different transports that are based on SHMEM....even though they
are in fact the same as of now, and anyway modifiable via DT if his
series goes in...I'll see what Sudeep prefers in these regards.

Thanks,
Cristian

