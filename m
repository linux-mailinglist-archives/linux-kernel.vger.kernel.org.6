Return-Path: <linux-kernel+bounces-355336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2084C9950C9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01B51F234FE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9D51DF722;
	Tue,  8 Oct 2024 13:57:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008826ADD
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395859; cv=none; b=Bt42+fNsMd+H5I8nODQN93K0N6OTBMxMwP0K4pY/O99JeZA02yn81x6zuIIVg5sGvLsWDRz6K1EOLGlXOI4IcwZXhfpkauNvldgIOfP8eJSu4ruRdsUC6ZErD4JxwAv9u9NUOcGj2oVZ8WXN3X2CArad6xExZwoK0bYj0ShZQ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395859; c=relaxed/simple;
	bh=GCG1XMUAJ27htDvbNOl/slQ3+QUGG+0uIx4+wJfRwGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKpqfZrWmQzygp9xgRt9Pni4M/J6niQa4VNlp0yk9cedg9QgC1RxvlPI+yC1nd/gAYPYXIKColLOC5wtkjhKfTMGkCKCVMci7kiNM6Cx4G0oTgoFifNjJJGssK0yBYJDMYvqFel+akbT7LmKAu4g+p7RZyFjQf7/zx3RlLAbX28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1syAiK-0004mB-0R; Tue, 08 Oct 2024 15:57:24 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1syAiI-000NW2-9T; Tue, 08 Oct 2024 15:57:22 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1syAiI-000Pdx-0b;
	Tue, 08 Oct 2024 15:57:22 +0200
Date: Tue, 8 Oct 2024 15:57:22 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 08/12] net: pse-pd: pd692x0: Add support for PSE
 PI priority feature
Message-ID: <ZwU6QuGSbWF36hhF@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-8-787054f74ed5@bootlin.com>
 <1e9cdab6-f15e-4569-9c71-eb540e94b2fe@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e9cdab6-f15e-4569-9c71-eb540e94b2fe@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2024 at 01:41:02AM +0200, Andrew Lunn wrote:
> > +	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
> > +	msg.sub[2] = id;
> > +	/* Controller priority from 1 to 3 */
> > +	msg.data[4] = prio + 1;
> 
> Does 0 have a meaning? It just seems an odd design if it does not.

0 is not documented. But there are sub-priority which are not directly
configured by user, but affect the system behavior.

Priority#: Critical – 1; high – 2; low – 3
 For ports with the same priority, the PoE Controller sets the
 sub-priority according to the logic port number. (Lower number gets
 higher priority).

Port priority affects:
1. Power-up order: After a reset, the ports are powered up according to
 their priority, highest to lowest, highest priority will power up first.
2. Shutdown order: When exceeding the power budget, lowest priority
 ports will turn off first.

Should we return sub priorities on the prio get request?

If i see it correctly, even if user do not actively configures priorities,
they are always present. For example port 0 will have always a Prio
higher than Port 10.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

