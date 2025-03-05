Return-Path: <linux-kernel+bounces-546431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D0EA4FA9E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2CE3A739F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F3C2054FB;
	Wed,  5 Mar 2025 09:51:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643622AF19
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168278; cv=none; b=jiQ3JkdnCxniXyZLGSpkfgzPAidALppCaEF1ijv7wdDLK6nexQDPyFo/Gxm/kelGyjgdFcmU9x4SIcqeCPZTQnGk0q9MPI2GZYWubQZdm0GbiinwFfyZYFmXNEdmU8/1WnXNL5JUitikb+qKwtYihZ990D1p4F/A2JOfdWGW1bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168278; c=relaxed/simple;
	bh=rvj0a+vHA+NZlGBw9NSx/eWYj1OESCfRgSHcNayQehw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nePiVolsuqcrx7ykCSozyCf+5LzzHUAEwY/aYQ2kKJJu4bke2MiihRNSc2u8tVKI2peyLmsWCt1mykUi6muciDLF+4FTCSzId5oJ50yuoNhovtfLGA0t95Fv1wTowE0QXiN0r4+0VMj4p8OhMS0DJRUDOS8mUUJvqG1HWbUJmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tplP3-0005JY-Sw; Wed, 05 Mar 2025 10:51:01 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tplP2-0047c0-2t;
	Wed, 05 Mar 2025 10:51:00 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tplP2-00EP5R-2W;
	Wed, 05 Mar 2025 10:51:00 +0100
Date: Wed, 5 Mar 2025 10:51:00 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH v3 2/7] power: reset: Introduce PSCR Recording Framework
 for Non-Volatile Storage
Message-ID: <Z8gehLMlc1qiA2HE@pengutronix.de>
References: <20250304132433.210355-1-o.rempel@pengutronix.de>
 <20250304132433.210355-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304132433.210355-3-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2025 at 02:24:28PM +0100, Oleksij Rempel wrote:
> +/**
> + * set_power_state_change_reason - Record reason for next reboot/shutdown
> + * @reason: The enumerated reason code to record
> + *
> + * Other drivers (e.g. regulator, thermal) call this whenever they detect
> + * a condition that may lead to or cause a reboot.
> + */
> +void set_power_state_change_reason(enum pscr_reason reason);

this declaration should be removed, otherwise it fails on disabled
CONFIG_PSCRR.
...

> +#if IS_ENABLED(CONFIG_PSCRR)
> +
> +void set_power_state_change_reason(enum pscr_reason pscr);
> +
> +#else
> +
> +static inline void set_power_state_change_reason(enum pscr_reason pscr)
> +{
> +}
> +#endif
 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

