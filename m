Return-Path: <linux-kernel+bounces-249340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C100892EA4C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B2F1C22898
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD41161328;
	Thu, 11 Jul 2024 14:08:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598C115ECE6;
	Thu, 11 Jul 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706898; cv=none; b=JVg/KrZs7VTEYfWQ1RTjSgq7D3+rw9FWV301iEWZQsaIHt0d9/QXqU3n3YhYqS2ovNnsFFf6f7BRWIn6CxAl5D/dbqWIiOc4fmr0c+UeDptJ5JukskWPmLMbPiwz478T7wtmf4uGF03eoQWGYNivnvdcLD9QBSPEkWKghF91+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706898; c=relaxed/simple;
	bh=d10qq7uUVAs7cNOmMvBwCwSJYYg445wsioh7YmYx0tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvvDlKTCBLpiYhsxHYQesmvfOzfSXgrHMFzjSsMri2RuWMGHc20t/f9WA8GC6b3Zrj+Ann+Ba588XFpir4YbWpGa7H7jZHI2m/TgbuSd6pkOGf2V6b1qqxiUSJVsz3jMvGI8UN0Fsg37WbhBJaHLtYbfd0Evlbo4QkrMNcCR9CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B79D8FEC;
	Thu, 11 Jul 2024 07:08:40 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 429C13F766;
	Thu, 11 Jul 2024 07:08:13 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:08:10 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"etienne.carriere@st.com" <etienne.carriere@st.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	"quic_sibis@quicinc.com" <quic_sibis@quicinc.com>,
	"quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
	"ptosi@google.com" <ptosi@google.com>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
Subject: Re: [PATCH v2 2/8] firmware: arm_scmi: Introduce packet handling
 helpers
Message-ID: <Zo_nStw7NkeAhN0G@pluto>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
 <20240710173153.4060457-3-cristian.marussi@arm.com>
 <PAXPR04MB8459E1ED6375ECE89C8471AE88A52@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459E1ED6375ECE89C8471AE88A52@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Thu, Jul 11, 2024 at 10:43:23AM +0000, Peng Fan wrote:
> > Subject: [PATCH v2 2/8] firmware: arm_scmi: Introduce packet
> > handling helpers
> > 

Hi Peng,

thanks for having a look.

> > Introduce a pair of structures initialized to contain all the existing
> > packet handling helpers, both for transports based on shared memory
> > and messages.
> > 
> > No functional change.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v1 --> v2
> > - fixed commit message
> > ---
> ......
> 
> > d33a704e5814..f4ba38afe0bb 100644
> > --- a/drivers/firmware/arm_scmi/msg.c
> > +++ b/drivers/firmware/arm_scmi/msg.c
> > @@ -4,8 +4,8 @@
> >   *
> >   * Derived from shm.c.
> >   *
> > - * Copyright (C) 2019-2021 ARM Ltd.
> > - * Copyright (C) 2020-2021 OpenSynergy GmbH
> > + * Copyright (C) 2019-2024 ARM Ltd.
> > + * Copyright (C) 2020-2024 OpenSynergy GmbH
> 
> Nitpick: OpenSynergy year should be kept unchanged?
> 
> Otherwise looks good:
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Yeah, I am not sure how to go around years of Copyrights...moreover I
received some auto-responder email from OpenSynergy saying thay have
been acquired by Qualcomm....I suppose I have to stick anyway with the
original autorship/copyright.

Thanks,
Cristian

