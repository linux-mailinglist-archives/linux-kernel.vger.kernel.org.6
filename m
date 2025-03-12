Return-Path: <linux-kernel+bounces-558131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AABA5E209
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D6C189FB0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0905D23C8D8;
	Wed, 12 Mar 2025 16:51:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE391D5CCC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798292; cv=none; b=pDubRRDye+EOxNAwnFQc6qsO+OCO+0X8wuf1Wps6HpDjg5Ws5ipe8t6pGBr9UyFS8AAWmhOhwhZ8w8hINa3nRh9bLiayUqJtdl0drI4qERvqEz51cHIbV5TrKsaPecf/wzpectgNqSPeZ43FLdmmVfNQN6sx35LMoZ0kSCAcfLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798292; c=relaxed/simple;
	bh=ir1E6OfRFFfst/93jxijvA00MYGvJ0qUp7cTZfOcZ3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjoIQTZIu1wHf3DiIhRGiKlMNJ84hLPmRySTMg9g06uj4bMiH4wh0DfZP4//UOenTQ3qkAy72sb3HnKG5cD0czXeHCHzkLkG8dX6nYRVqEaBgfok+h2EWu3GuiFUXkZOAL1xP7+fpfPkT6aqLfE/dylYGAmq/OYY0pGAWevqacc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tsPIb-00010B-Bz; Wed, 12 Mar 2025 17:51:17 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tsPIa-005OKC-0P;
	Wed, 12 Mar 2025 17:51:16 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tsPIa-009a8e-00;
	Wed, 12 Mar 2025 17:51:16 +0100
Date: Wed, 12 Mar 2025 17:51:15 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH v4 7/7] thermal: core: Record PSCR before
 hw_protection_shutdown()
Message-ID: <Z9G7g5fr8DkJtcLI@pengutronix.de>
References: <20250306093900.2199442-1-o.rempel@pengutronix.de>
 <20250306093900.2199442-8-o.rempel@pengutronix.de>
 <726c6ffc-a8d4-4328-a849-2d59f3a0a1c9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <726c6ffc-a8d4-4328-a849-2d59f3a0a1c9@linaro.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Mar 12, 2025 at 04:35:51PM +0100, Daniel Lezcano wrote:
> > @@ -380,6 +381,8 @@ static void thermal_zone_device_halt(struct thermal_zone_device *tz, bool shutdo
> >   	dev_emerg(&tz->device, "%s: critical temperature reached\n", tz->type);
> > +	set_power_state_change_reason(PSCR_OVERTEMPERATURE);
> > +
> >   	if (shutdown)
> >   		hw_protection_shutdown(msg, poweroff_delay_ms);
> >   	else
> 
> In the future could you add me as recipient to the series instead of this
> one ? so I can get more context.

ack.

> Given there are no so much hw_protection_shutdown() users in the kernel, it
> could be more interesting to change the function to receive a enum
> pscr_reason and then in the hw_protection_shutdown() call
> pscrr_reason_to_str().
 
Do you mean, make it work with CONFIG_PSCRR=n?

Beside, the latest version is v5:
https://lore.kernel.org/all/20250310103732.423542-1-o.rempel@pengutronix.de/

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

