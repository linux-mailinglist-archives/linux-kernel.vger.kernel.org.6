Return-Path: <linux-kernel+bounces-276457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA8B949406
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92F01F227A9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762411D6187;
	Tue,  6 Aug 2024 14:59:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F086E18D655;
	Tue,  6 Aug 2024 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956354; cv=none; b=m5nvgFVpgYTmcAUFdCM6Ad8Hl2Q8A0SCaoIYDeBJiJg0z3ENE0SEBLAssSLiUcv4cBGnT7bq5jlA2ugEP4p5VOp5lijEAybbj6AU3lVP+dMeTfDV4p+r0E3pgpMfTFqdZpBlEz1116hvi3P2P3ov41BLVxNnr/J0qwg4AauzJN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956354; c=relaxed/simple;
	bh=iqjYJFL2/l8ov0CWQDySesvc675/T6vPfcXzMoIIRls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1mp+4UpNCfHrHJhVeLl399mYHOH3wZnwRwCZAIBrBqPd7dgCC1qqzz90lgmbpD7kdPtot7Z4fevENR7Y2ycOTG7knpwUgC6nbQmxzTZZuyRNxzZ3W9l6ObGD3rg6y2KJIFi1oAvjK7DxmXbbvNsGmXOiaUZggj7iK4kkcid2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EFA9FEC;
	Tue,  6 Aug 2024 07:59:37 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 908963F6A8;
	Tue,  6 Aug 2024 07:59:08 -0700 (PDT)
Date: Tue, 6 Aug 2024 15:59:00 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, quic_nkela@quicinc.com, ptosi@google.com,
	dan.carpenter@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v3 5/9] firmware: arm_scmi: Make MBOX transport a
 standalone driver
Message-ID: <ZrI6NH20rK0-WCuf@pluto>
References: <20240730133318.1573765-1-cristian.marussi@arm.com>
 <20240730133318.1573765-6-cristian.marussi@arm.com>
 <ZrIhR-bpbkwdK3Mx@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrIhR-bpbkwdK3Mx@bogus>

On Tue, Aug 06, 2024 at 02:12:39PM +0100, Sudeep Holla wrote:
> On Tue, Jul 30, 2024 at 02:33:14PM +0100, Cristian Marussi wrote:
> > Make SCMI mailbox transport a standalne driver that can be optionally
> > loaded as a module.
> > 

Hi Sudeep,

thanks for havig a look.

> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v2 --> v3
> > - fixed spacing in Kconfig
> > - updated Copyright
> > - use new params in DEFINE_SCMI_TRANSPORT_DRIVER
> > ---
> >  drivers/firmware/arm_scmi/Kconfig             |  4 +-
> >  drivers/firmware/arm_scmi/Makefile            |  3 +-
> >  drivers/firmware/arm_scmi/common.h            |  3 --
> >  drivers/firmware/arm_scmi/driver.c            |  3 --
> >  .../{mailbox.c => scmi_transport_mailbox.c}   | 47 +++++++++++++------
> >  5 files changed, 38 insertions(+), 22 deletions(-)
> >  rename drivers/firmware/arm_scmi/{mailbox.c => scmi_transport_mailbox.c} (87%)
> 
> I am happy with the changes in the series, they all look good. I wonder if
> it makes sense to move transport drivers into a separate folder
> drivers/firmware/arm_scmi/transport/{mailbox,smc,optee,virtio}.c
> 
> In scmi_transport_*.c, I see scmi is redundant and transport can be eliminated
> by moving all under the folder with that name. Thoughts ?
> 

Yes it is a possigility, not sure if there is any (trivial) drawback to
solve while movinf, but consider that the final name for the .ko LKM has to
have the scmi_transport prefix somehow to be able to live in the tree and distinguish
those LKMs from (vendor) protocols ones...so I would have anyway to craft an
scmi_ naming in the Makefile

Thanks,
Cristian


