Return-Path: <linux-kernel+bounces-396614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BEB9BCF8D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3181E1F230C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4CB1D90CD;
	Tue,  5 Nov 2024 14:36:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1581CEEAA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817386; cv=none; b=n3WbrErenIAhNJdGfc7v8EPl+Jv/WpH57IJjzF9ym1SGgT11Z6sJf1vVIe/BcG1aINgAZ5885v5OYGFj6vIBUl5Qd/sLc7gl3X2KzQdRIEo7AQW9ML7yWipaQjIWpvf1SCsW9tfGljn55bVSY4WcDrJDjq4U6uTzZECFgUPKDZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817386; c=relaxed/simple;
	bh=gvda3/xY9bP1mILtrzwnkgGAhrN4G2kluGqpKX2yQnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=to/dUv6DiaC33bvguUGArZRvzQZf4+9R6StpvapTbCKngzbyoDGMmyIt4WOUc+o34gPAKhdB8mWpFLrIv2sPP1hyTbb0SOnuKpjhI5QFUItMFsqCaUwBl8ZnrnJYAB18oCgVmR/RUnv9LQhTfC6fpGsPJCL+P53dkZk26+3Rw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t8KfD-0008Lz-Ix; Tue, 05 Nov 2024 15:36:11 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t8KfD-0029sp-0B;
	Tue, 05 Nov 2024 15:36:11 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t8KfC-00FPJz-31;
	Tue, 05 Nov 2024 15:36:10 +0100
Date: Tue, 5 Nov 2024 15:36:10 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 15/18] net: pse-pd: Add support for
 getting and setting port priority
Message-ID: <ZyotWqt09diq-MqX@pengutronix.de>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
 <20241030-feature_poe_port_prio-v2-15-9559622ee47a@bootlin.com>
 <ZyMpkJRHZWYsszh2@pengutronix.de>
 <20241031121104.6f7d669c@kmaincent-XPS-13-7390>
 <ZyO_N1EOTZCprgMJ@pengutronix.de>
 <20241105144913.3c25b476@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105144913.3c25b476@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2024 at 02:49:13PM +0100, Kory Maincent wrote:
> On Thu, 31 Oct 2024 18:32:39 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> >  * @PSE_DISCON_STATIC_CLASS_BUDGET_MATCH: Disconnect based on static
> > allocation
> >  *   class, targeting devices that release enough allocated power to meet the
> >  *   current power requirement.
> >  *   - Relevant for: ETHTOOL_PSE_PORT_PRIO_STATIC
> >  *   - Behavior: Searches for the lowest-priority device that can release
> >  *     sufficient allocated power to meet the current budget requirement.
> >  *     Ensures that disconnection occurs only when enough power is freed.
> >  *   - Rationale: This strategy is useful when the goal is to balance power
> >  *     budget requirements while minimizing the number of disconnected
> > devices.
> >  *     It ensures that the system does not needlessly disconnect multiple
> >  *     devices if a single disconnection is sufficient to meet the power
> > needs.
> >  *   - Use Case: Ideal for systems where precise power budget management is
> >  *     necessary, and disconnections must be efficient in terms of freeing
> >  *     enough power with minimal impact on the system.
> 
> Not sure about this one. PSE_DISCON_STATIC_CLASS_HIGHEST_FIRST would be
> sufficient for that case.

ack

> >  * @PSE_DISCON_LOWEST_AVG_POWER: Disconnect device with the lowest average
> >  *   power draw, minimizing impact on dynamic power allocation.
> >  *   - Relevant for: ETHTOOL_PSE_PORT_PRIO_DYNAMIC
> >  *   - Behavior: Among devices with the same priority level, the system
> >  *     disconnects the device with the lowest average power draw.
> >  *   - If multiple devices have the same average power draw and priority,
> >  *     further tie-breaking mechanisms can be applied, such as disconnecting
> >  *     the least recently connected device.
> >  *   - Rationale: Minimizes disruption across dynamic devices, keeping as many
> >  *     active as possible by removing the lowest-power ones.
> >  *   - Use Case: Suitable for dynamic-priority systems where maximizing the
> >  *     number of connected devices is more important than individual device
> >  *     power requirements.
> > 
> >  * @PSE_DISCON_LONGEST_IDLE: Disconnect device with the longest idle time
> >  *   (low or no recent active power usage).
> >  *   - Relevant for: ETHTOOL_PSE_PORT_PRIO_DYNAMIC
> >  *   - Behavior: Disconnects the device with the longest period of inactivity,
> >  *     where "idle" is defined as low current draw or absence of recent data
> >  *     transmission.
> >  *   - If multiple devices have the same idle time and priority, a
> > tie-breaking
> >  *     mechanism, such as round-robin based on port index, can be used.
> >  *   - Rationale: Optimizes resource allocation in dynamic-priority setups by
> >  *     maintaining active devices while deprioritizing those with minimal
> >  *     recent usage.
> >  *   - Use Case: Ideal for dynamic environments, like sensor networks, where
> >  *     devices may be intermittently active and can be deprioritized during
> >  *     idle periods.
> >  *
> >  * These disconnection policies provide flexibility in handling cases where
> >  * multiple devices with the same priority exceed the PSE budget, aligning
> >  * with either static or dynamic port priority modes:
> >  *   - `ETHTOOL_PSE_PORT_PRIO_STATIC` benefits from policies that maintain
> >  *     stable power allocation, favoring longer-standing or higher-class
> >  *     devices (e.g., `PSE_DISCON_LRC`, `PSE_DISCON_ROUND_ROBIN_IDX`,
> >  *     `PSE_DISCON_STATIC_CLASS_HIGHEST_FIRST`,
> > `PSE_DISCON_STATIC_CLASS_LOWEST_FIRST`,
> >  *     `PSE_DISCON_STATIC_CLASS_BUDGET_MATCH`).
> >  *   - `ETHTOOL_PSE_PORT_PRIO_DYNAMIC` supports policies that dynamically
> >  *     adjust based on real-time metrics (e.g., `PSE_DISCON_LOWEST_AVG_POWER`,
> >  *     `PSE_DISCON_LONGEST_IDLE`), ideal for setups where usage fluctuates
> >  *     frequently.
> >  *   - Users can define an ordered array of disconnection policies, allowing
> >  *     the system to apply each policy in sequence, providing nuanced control
> >  *     over how power disconnections are handled.
> >  */
> 
> I think I can add support for one or two of these modes in this patch series.
> Modes relevant for dynamic port priority can't be used for now as nothing
> support them.

ack

> Do you think I should add this full enumeration in ethtool UAPI even if not all
> of them are supported yet? 

No, do not worry, it was just my brain dump. Care only about actually
used variants. If some one will need something different, we will
already know how to address it.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

