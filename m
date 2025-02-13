Return-Path: <linux-kernel+bounces-512764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28703A33D81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E33188DB3C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555392144B4;
	Thu, 13 Feb 2025 11:09:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC8620AF66
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444994; cv=none; b=EVJCFWbjTOvRq492Rqh7kMijWYxRBRGLyI2Bz+1eKpSQ0jBoL9JSPLMAOwS53dcPpNnpgnmaMWCIcQBTaziMDuBZcvkirNIi151d+18Uqnsif+c/oOFA9EKzVYmnGXdBYBBB7xP4TI15R5gO2xwV4iYb+1q6xEHCGfO6ndfNAcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444994; c=relaxed/simple;
	bh=VD0c+OPc0seUh3YTRx7sZu7G1wp5gYG+LsPTC74ne3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKvGASYBa0zxP/gwVEvGS8oZ263qfiL2Stk9YlhehOetsRn/XwvAYOi49na+EPzC0MLUt8ezrC1u2JtBr/I9Bxm3raCs8+yKfuGip+SZ/gJBU2hqlQ+qmkrDSTGN+a+f0oJvi6WxHPb1q9YvR+8ry/bbuCJqoWcooSmd6BMdvAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tiX6J-0007jb-K1; Thu, 13 Feb 2025 12:09:47 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tiX6J-000k1B-0L;
	Thu, 13 Feb 2025 12:09:47 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tiX6J-00CqV5-01;
	Thu, 13 Feb 2025 12:09:47 +0100
Date: Thu, 13 Feb 2025 12:09:46 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] mmc: core: Handle undervoltage events and
 register regulator notifiers
Message-ID: <Z63S-nQKwPws2-C3@pengutronix.de>
References: <20250212132403.3978175-1-o.rempel@pengutronix.de>
 <PH7PR16MB619609C650452062D6BC2385E5FF2@PH7PR16MB6196.namprd16.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR16MB619609C650452062D6BC2385E5FF2@PH7PR16MB6196.namprd16.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2025 at 10:14:00AM +0000, Avri Altman wrote:
> > Extend the MMC core to handle undervoltage events by implementing
> > infrastructure to notify the MMC bus about voltage drops.
> > 
> > Background & Decision at LPC24:
> > 
> > This solution was proposed and refined during LPC24 in the talk "Graceful
> > Under Pressure: Prioritizing Shutdown to Protect Your Data in Embedded
> > Systems" which aimed to address how Linux should handle power fluctuations
> > in embedded devices to prevent data corruption or storage damage.
> > 
> > At the time, multiple possible solutions were considered:
> > 
> > 1. Triggering a system-wide suspend or shutdown: when undervoltage is
> >    detected, with device-specific prioritization to ensure critical
> >    components shut down first.
> >    - This approach was disliked by Greg Kroah-Hartman, as it introduced
> >      complexity and was not suitable for all use cases.
> > 
> > 2. Notifying relevant devices through the regulator framework: to allow
> >    graceful per-device handling.
> >    - This approach was agreed upon as the most acceptable: by participants
> >      in the discussion, including Greg Kroah-Hartman, Mark Brown,
> >      and Rafael J. Wysocki.
> >    - This patch implements that decision by integrating undervoltage
> >      handling into the MMC subsystem.
> > 
> > This patch was tested on iMX8MP based system with SDHCI controller.
> Has it been considered, to rely on user-space and not the kernel to handle
> those extreme conditions?
> E.g. a pollable sysfs that would be monitored by select(), poll(), etc.
> As Android might use?

Yes, the advantage of solving this in the kernel is:  

- The regulator framework already provides all the necessary components,
  including event support.  
- The MMC framework already supports regulators, making the implementation
  straightforward.  
- This approach works even if userspace is not ready at boot time.  

On the other hand, you are right that a userspace implementation would offer
more flexibility. However, I believe this can be built as an extension of the
current implementation. The regulator framework supports Netlink notifications
to userspace, eliminating the need for sysfs polling. The MMC framework would
also require a sysfs interface to force a quick shutdown - if such an interface
does not already exist - and a filter for regulator notifications to ignore
undervoltage events when they are handled in userspace.  

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

