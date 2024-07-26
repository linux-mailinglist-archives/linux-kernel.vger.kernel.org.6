Return-Path: <linux-kernel+bounces-263414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356A993D57E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4981D1C230FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375AB1CD2A;
	Fri, 26 Jul 2024 15:00:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BBE18E1E;
	Fri, 26 Jul 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006057; cv=none; b=JTtaIT6V0K+JfGEXca8Se15NnwrtKLx0QHcJOV5Z7t+ovwwLy8g7u6g95cF1ez7JKNr+5WtBsLf8txTve1GTDw0uAd9UhELPUVn85vXgIIg1asV+FDLU7kqG5QuPSDpc6qdwmj4qTjPNhm6sSrSuWnwAP3KFsMDYUJitUBKVFvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006057; c=relaxed/simple;
	bh=njvtIAKad291UXxaRgGlGZjM7RXaqPijLOQ4QuDdfFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjVyIpKD0pqM32KrEBl18maYIJqytaQg25wOTYTfR3Dt8R0RCsrAHCmjxa9FFfuBvzESQpI7ydk4tNpvo0Bcz+p7VqBiXhfS3rpwRR4b1zAhSf2EHT+f68zMRfqNkYyEIwC/8b89jLuzvmVo5gLtHeBkVPUwdIVyLWV20QxiKwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37ECD1007;
	Fri, 26 Jul 2024 08:01:21 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AE383F73F;
	Fri, 26 Jul 2024 08:00:53 -0700 (PDT)
Date: Fri, 26 Jul 2024 16:00:51 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Etienne CARRIERE <etienne.carriere@st.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	"quic_sibis@quicinc.com" <quic_sibis@quicinc.com>,
	"quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
	"ptosi@google.com" <ptosi@google.com>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
Subject: Re: [PATCH v2 4/8] firmware: arm_scmi: Make MBOX transport a
 standalone driver
Message-ID: <ZqO6IyaOaTbuQBOd@pluto>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
 <20240710173153.4060457-5-cristian.marussi@arm.com>
 <PAXPR10MB46879DC8AB435367E0D3C251FDA92@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR10MB46879DC8AB435367E0D3C251FDA92@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>

On Tue, Jul 23, 2024 at 01:41:04PM +0000, Etienne CARRIERE wrote:
> Hi Cristian,
> 
> On Wednesday, July 10, 2024, Cristian Marussi wrote:
> > Make SCMI mailbox transport a standalne driver that can be optionally
> > loaded as a module.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/Kconfig             |  4 +-
> >  drivers/firmware/arm_scmi/Makefile            |  3 +-
> >  drivers/firmware/arm_scmi/common.h            |  3 --
> >  drivers/firmware/arm_scmi/driver.c            |  3 --
> >  .../{mailbox.c => scmi_transport_mailbox.c}   | 44 +++++++++++++------
> >  5 files changed, 36 insertions(+), 21 deletions(-)
> >  rename drivers/firmware/arm_scmi/{mailbox.c => scmi_transport_mailbox.c} (88%)
> > 
> > diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> > index aa5842be19b2..135e34aefd70 100644
> > --- a/drivers/firmware/arm_scmi/Kconfig
> > +++ b/drivers/firmware/arm_scmi/Kconfig
> > @@ -75,7 +75,7 @@ config ARM_SCMI_HAVE_MSG
> >            available.
> >  
> >  config ARM_SCMI_TRANSPORT_MAILBOX
> > -       bool "SCMI transport based on Mailbox"
> > +       tristate "SCMI transport based on Mailbox"
> >          depends on MAILBOX
> >          select ARM_SCMI_HAVE_TRANSPORT
> >          select ARM_SCMI_HAVE_SHMEM
> > @@ -85,6 +85,8 @@ config ARM_SCMI_TRANSPORT_MAILBOX
> >  
> >            If you want the ARM SCMI PROTOCOL stack to include support for a
> >            transport based on mailboxes, answer Y.
> > +         This driver can also be built as a module.  If so, the module
> 
> Nitpicking: replace the 2 space char before "if so," with a single one?
> Applies also to patch 5/8, 6/8 and 7/8.
> 

Fixed in V3.

> Other wise LGTM , but my comment on patch 3/8 that would affect
> use of DEFINE_SCMI_TRANSPORT_DRIVER() in patch 5 to 7.
> 

Yes I reworked the macros params.

Thanks,
Cristian

