Return-Path: <linux-kernel+bounces-263410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1324D93D574
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443FC1C2326B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061A81EB31;
	Fri, 26 Jul 2024 14:57:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6581CF9B;
	Fri, 26 Jul 2024 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005867; cv=none; b=EcGOcg2+Z/OYHrbgaRIXAYfmR5hgcRXToSLX6XLUryZ7E1okcyS9/rHxXDKDMJLo8EEhCC8q8y3g5I0WWmJ9oPYUICxmnkMnmmddJPnR+hiE7mJMluKosxZb9sueyPtJuVBIuJc7XPbA/DeL4saw8sbc2UfDE827o0PwshjclYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005867; c=relaxed/simple;
	bh=Ije9quJA/JaId1T0emmMsYoqzpKKW6KuyzOpfB856Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OR6TyoSt3raumI9FQLzVbqGbP2DFyvu4Z/igTDZf4cJRPzrepXZqVFckj357QTlUVQVVzJyKYGBLAk4q/Cre1gSh/Z+YdOOrMRo4qpCGkeDCNLNALUUh/MclO3HWdlqKjL2ULzN/7RGSnhmi/NZU/g0OOZaa938RkhdOHoj91Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01A431007;
	Fri, 26 Jul 2024 07:58:11 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34DC93F73F;
	Fri, 26 Jul 2024 07:57:43 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:57:40 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Etienne CARRIERE <etienne.carriere@st.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	"quic_sibis@quicinc.com" <quic_sibis@quicinc.com>,
	"quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
	"ptosi@google.com" <ptosi@google.com>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
Subject: Re: [PATCH v2 2/8] firmware: arm_scmi: Introduce packet handling
 helpers
Message-ID: <ZqO5ZOxruAP1FOEW@pluto>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
 <20240710173153.4060457-3-cristian.marussi@arm.com>
 <PAXPR04MB8459E1ED6375ECE89C8471AE88A52@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <PAXPR10MB4687B2FCCA6E59CAEF769713FDA92@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR10MB4687B2FCCA6E59CAEF769713FDA92@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>

On Tue, Jul 23, 2024 at 01:41:19PM +0000, Etienne CARRIERE wrote:
> Hi,
> 
> On Thursday, July 11, 2024, Peng Fan wrote:
> > > Subject: [PATCH v2 2/8] firmware: arm_scmi: Introduce packet
> > > handling helpers
> > >
> > > Introduce a pair of structures initialized to contain all the existing
> > > packet handling helpers, both for transports based on shared memory
> > > and messages.
> > >
> > > No functional change.
> > >
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > ---
> > > v1 --> v2
> > > - fixed commit message
> > > ---
> > ......
> > 
> > > d33a704e5814..f4ba38afe0bb 100644
> > > --- a/drivers/firmware/arm_scmi/msg.c
> > > +++ b/drivers/firmware/arm_scmi/msg.c
> > > @@ -4,8 +4,8 @@
> > >   *
> > >   * Derived from shm.c.
> > >   *
> > > - * Copyright (C) 2019-2021 ARM Ltd.
> > > - * Copyright (C) 2020-2021 OpenSynergy GmbH
> > > + * Copyright (C) 2019-2024 ARM Ltd.
> > > + * Copyright (C) 2020-2024 OpenSynergy GmbH
> > 
> > Nitpick: OpenSynergy year should be kept unchanged?
> 

Hi Etienne, Peng

> I agree. Copyright dates on original non-Arm contributors should
> not be changed, here and in patch 5/8, 6/8 and 7/8.
> 

Agreed. Thanks for the clarification, I was not sure how to handle such
old copyrigths....I have fixed alreay all of these Copy for V3.

Thanks,
Cristian

