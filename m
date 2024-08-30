Return-Path: <linux-kernel+bounces-308667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A729C966008
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB6F1F21249
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5615219341A;
	Fri, 30 Aug 2024 11:05:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093CD192D87
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015903; cv=none; b=uvh+7UikXec3SHcPL5ptkLl52GmSk4Os6d7DHTvGXGwkG1GwJp81F0GwU7W7uuER4/KiOYdP139Ta6RU+/5HHG/n+3RX++o0cjh1GVxXsWXN9GbA3ABcgVmnf92wo3AP0+wtUO1Ww689954HhYX05YrjVBtBU//DBr87/JyutHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015903; c=relaxed/simple;
	bh=NvlbOxagaUp01IxQe/8/RbsnWCG24uO+K/jvP3nHa5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4a7nQSR17rU8CyrgyovnA+O/7kKdL6DM8cgGMbXbK8bI4qn7XG3NLjacx7EFarCYgyHOPLQheZ/ijbDaastQIJngD31C3kFRSnDe5d5ab+y3FhFRqPfKUfUVLLHyQIevlCDsPy5wWMYzrmdUCH8qCV2QXJ8xFOXS21w4SafNHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sjzR2-0003bx-Nj; Fri, 30 Aug 2024 13:04:56 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sjzR2-0048HW-6c; Fri, 30 Aug 2024 13:04:56 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sjzR2-00ETpy-0K;
	Fri, 30 Aug 2024 13:04:56 +0200
Date: Fri, 30 Aug 2024 13:04:56 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Ensure all STA and AP use the same channel
Message-ID: <ZtGnWC7SPHt7Vbbp@pengutronix.de>
References: <20240830-mwifiex-check-channel-v1-1-b04e075c9184@pengutronix.de>
 <8734mmuyq9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734mmuyq9.fsf@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2024 at 12:49:34PM +0300, Kalle Valo wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> > The mwifiex chips support simultaneous Accesspoint and station mode,
> > but this only works when all are using the same channel. The downstream
> > driver uses ECSA which makes the Accesspoint automatically switch to the
> > channel the station is going to use.  Until this is implemented in the
> > mwifiex driver at least catch this situation and bail out with an error.
> > Userspace doesn't have a meaningful way to figure out what went wrong,
> > so print an error message to give the user a clue.
> >
> > Without this patch the driver would timeout on the
> > HostCmd_CMD_802_11_ASSOCIATE command when creating a station with a
> > channel different from the one that an existing accesspoint uses.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: stable@vger.kernel.org
> 
> Does this mean that iface combination definitions are wrong? For example:
> 
> static const struct
> ieee80211_iface_combination mwifiex_iface_comb_ap_sta_drcs = {
> 	.limits = mwifiex_ap_sta_limits,
> 	.num_different_channels = 2,
> 	.n_limits = ARRAY_SIZE(mwifiex_ap_sta_limits),
> 	.max_interfaces = MWIFIEX_MAX_BSS_NUM,
> 	.beacon_int_infra_match = true,
> };

I wasn't aware of DRCS as it's disabled by default in the mwifiex
driver. From a quick test I can say that indeed with DRCS two channels
are supported. It seems we have to relax the same channel enforcement
when DRCS is enabled.

This brings up the question why DRCS is disabled by default. Wouldn't it
make sense to always enable it when available?

Related: num_different_channels is exposed to userspace, but outside the
MAC80211 layer there is nothing in the kernel that enforces this
restriction.  Am I missing something or is this just an open patch
opportunity?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

