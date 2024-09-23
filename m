Return-Path: <linux-kernel+bounces-335690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C44397E928
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F12C1C21287
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F146A195808;
	Mon, 23 Sep 2024 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaehlcke.net header.i=@kaehlcke.net header.b="TmaOEjYK"
Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B7AEEB5;
	Mon, 23 Sep 2024 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085411; cv=pass; b=GbpsLfszsEhBPd3QpYy/x2it+Huun3AW9jrTqTOxOag7kcikzasaEOr4ZuVil2WFzx83FfZQuXCUhA7qzupdgqcdbtYkFzeng3bBdnP92deFa9ZBXmCQzOPtOVvpOTLeB/FvWFMqjQ1UFdZYyr2B0zasTVt1JLHJuoiVjTqxwPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085411; c=relaxed/simple;
	bh=MBURGwTkZivGAIcQzi0SHqRB8AcGmiYuiPTuDAYatOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdH2M45aF2dQNwxhZjitWM4UMXzImTuAfV9r8UaY3gumdfv2Opvl+tPgL2Zic5qIzNXfKcwyB2dJQIH6ZR9MZXMXtRLDHecdWkcNyV8co/o4GC1YdN6caDgiaqCKnceWE/it8tULYYn91oxqiijTZxgmZ9aAm1Y+zbBODkWLEwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaehlcke.net; spf=pass smtp.mailfrom=kaehlcke.net; dkim=pass (2048-bit key) header.d=kaehlcke.net header.i=@kaehlcke.net header.b=TmaOEjYK; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaehlcke.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaehlcke.net
X-Sender-Id: dreamhost|x-authsender|matthias@kaehlcke.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A940D8A06BE;
	Mon, 23 Sep 2024 09:56:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a267.dreamhost.com (100-99-96-206.trex-nlb.outbound.svc.cluster.local [100.99.96.206])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4272F8A04F8;
	Mon, 23 Sep 2024 09:56:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1727085399; a=rsa-sha256;
	cv=none;
	b=vUaWW3BNfdZ5lZc6wHkE72YdcUH346vJX3xX3RbE3oF9coleoK9T/FVrgBbeCB5WQjMZBr
	yfcoTJ/1PUwCIEOVRjtG3nGDcU7qoDVVq1Mlyy7VFKhQPeLU892ystnMcL55S/5oqsYB/G
	FtPW53L/vjbZr0TrfzZlgCRCRptLHdJQ82Cjm3sYXZoPOpSI459Vy8vgbGWpOJYcCnVQIx
	2jCW3Dae9nb7bH5ct+SKvlwbVcwHoRGeioGK7T2t2wPEKUHX+nOXlfK2BOHbDDBaVrX+Rl
	C1SixgPkXKVtAqy1F/5QNT89F3CGE5xPrG3m8Z2vaTOALK963LXmUQi4ZoBFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1727085399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Ma2+mk6RWxQlsSYkAPohY1aZHptX/zlTiVVO+U88keA=;
	b=pDeEQXBo4SpXEUUhYvbDJqsT+YSGaMQH4KLnfohfq0VVjDb5Tb6k5yS9UgHMDpskvDBbPc
	1R/tKmfK+pEz5CBVLAPsvrrzZTa/8E4MCgXEhe1tBeoj+jApBrKR/WUwhxVaZprQj85065
	B6WNZVscRKaeGDXjXDPVKRHYUjiO/RboyRcTxmnhT1bZc0fEH/c+64EAF6u87dAohIRf0u
	dDwePbAa5IfQeoIarlLnufD8ewSjfF694nLPrdSSZlWN1L0mvVYZbESYesyM7NiAnmS6fH
	Tcm5S0gjR4yhcd2ggRHwPs/6/y2arK15COygZ/XVGZP3xKX2OZvEjpN8DNcnSw==
ARC-Authentication-Results: i=1;
	rspamd-5b46bcd97f-svd8d;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=matthias@kaehlcke.net
X-Sender-Id: dreamhost|x-authsender|matthias@kaehlcke.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|matthias@kaehlcke.net
X-MailChannels-Auth-Id: dreamhost
X-Harmony-Stop: 4b029e854c8189cf_1727085399594_1084799275
X-MC-Loop-Signature: 1727085399594:161383076
X-MC-Ingress-Time: 1727085399594
Received: from pdx1-sub0-mail-a267.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.96.206 (trex/7.0.2);
	Mon, 23 Sep 2024 09:56:39 +0000
Received: from curie.home (unknown [79.116.59.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: matthias@kaehlcke.net)
	by pdx1-sub0-mail-a267.dreamhost.com (Postfix) with ESMTPSA id 4XBz0k6pvdzMN;
	Mon, 23 Sep 2024 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaehlcke.net;
	s=dreamhost; t=1727085399;
	bh=Ma2+mk6RWxQlsSYkAPohY1aZHptX/zlTiVVO+U88keA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=TmaOEjYKnB/YTZlkiNXyTHXQmqxHu3j2OWBSyJ2jgtFgToLXomfM9va9Nyb7dZTy5
	 017KSqhKUZ81ThP5Wy9l5BEqzLsS8mojyvQsUSaMkYGHVToGP/r2djFMrb9kA0dXWg
	 1PdAfgLxvWlj/IwzypIS1MaONBrG/Npgzz2tkti8IOvtT9PrigH8J5sPAxdTpdFpjo
	 15HbHOumXPkEjxCpm10Q8cOpdZC3Wn5xjyvDT8VEV3T6ri2yUugFcguWjWh22/fC97
	 Msa2RlI2Hi5tAHA+5ySYlX20LnEGxt+Lxif9JkbVGIbLrRBK7E3JsROGU+NQO0KGKR
	 r0zRFiaixS8Xw==
Received: by curie.home (Postfix, from userid 1000)
	id BE4B2103D4A; Mon, 23 Sep 2024 11:56:35 +0200 (CEST)
Date: Mon, 23 Sep 2024 09:56:35 +0000
From: Matthias Kaehlcke <matthias@kaehlcke.net>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: kernel test robot <lkp@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Kaehlcke <mka@chromium.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	kernel@pengutronix.de, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: hub: add infrastructure to pass onboard_dev
 port features
Message-ID: <wtvhsdo2zefehkgfcp2cfdl2uht4lcrytyjyhwjhnpcyvx4kd2@iurrw554aegh>
Mail-Followup-To: Matthias Kaehlcke <matthias@kaehlcke.net>, 
	Marco Felsch <m.felsch@pengutronix.de>, kernel test robot <lkp@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Kaehlcke <mka@chromium.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	kernel@pengutronix.de, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
References: <20240807-b4-v6-10-topic-usb-onboard-dev-v1-1-f33ce21353c9@pengutronix.de>
 <202408081557.FiEe9Tzz-lkp@intel.com>
 <20240809093313.xn3x2p3st2b32g27@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809093313.xn3x2p3st2b32g27@pengutronix.de>

El Fri, Aug 09, 2024 at 11:33:13AM GMT Marco Felsch ha dit:

> Hi all,
> 
> On 24-08-08, kernel test robot wrote:
> > Hi Marco,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on 0c3836482481200ead7b416ca80c68a29cfdaabd]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Marco-Felsch/usb-hub-add-infrastructure-to-pass-onboard_dev-port-features/20240807-224100
> > base:   0c3836482481200ead7b416ca80c68a29cfdaabd
> > patch link:    https://lore.kernel.org/r/20240807-b4-v6-10-topic-usb-onboard-dev-v1-1-f33ce21353c9%40pengutronix.de
> > patch subject: [PATCH 1/3] usb: hub: add infrastructure to pass onboard_dev port features
> > config: i386-randconfig-141-20240808 (https://download.01.org/0day-ci/archive/20240808/202408081557.FiEe9Tzz-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408081557.FiEe9Tzz-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202408081557.FiEe9Tzz-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    ld: drivers/usb/core/hub.o: in function `set_port_feature':
> > >> drivers/usb/core/hub.c:481: undefined reference to `onboard_dev_port_feature'
> >    ld: drivers/usb/core/hub.o: in function `usb_clear_port_feature':
> >    drivers/usb/core/hub.c:462: undefined reference to `onboard_dev_port_feature'
> 
> I understood the isse but have a few questions. Before continue the work
> on this topic I would like to ask if the patchset is okay in general?
> I'm open for alternatives if the patchset approach is not okay.

From the perspective of the onboard_usb_dev driver it seems sound to me.

So far the USB maintainers haven't raised objections, so I would say move
forward and we'll see if concerns arise and deal with them if needed.

> I have a few ideas in mind (see below) to fix the 0day build issue which
> was caused by the Kconfig selection:
> 
>  - CONFIG_USB=y
>  - CONFIG_USB_ONBOARD_DEV=m.
> 
> Idea-1:
> -------
> 
> Dropping the module support for CONFIG_USB_ONBOARD_DEV.

With that CONFIG_USB could not be 'm' when CONFIG_USB_ONBOARD_DEV
is set, which wouldn't be great.

> Idea-2:
> -------
> 
> CONFIG_USB_ONBOARD_DEV follows CONFIG_USB:
> 
> CONFIG_USB=y -> CONFIG_USB_ONBOARD_DEV=y,
> CONFIG_USB=m -> CONFIG_USB_ONBOARD_DEV=m.
> 
> and exporting usb_clear_port_feature().
> 
> I don't know to add such Kconfig dependency and also this idea require
> that the usbcore have to load the usb_onboard_dev module always,
> regardless if used.
> 
> So this idea is rather suboptimal.
> 
> Idea-3:
> -------
> 
> Adding a function to the hub.c usbcore which can be used by the
> usb-onboard-dev driver to register this function as hook. This removes
> the dependency from the core and the usb-onboard-dev module is only
> pulled if really required. Of course this require that the hub.c usbcore
> driver allows custom hooks.

This seems like the best approach IMO, if USB maintainers are onboard with
it.

Since this is about port features (only applicable to hubs) the function
should be associated with struct usb_hub, not struct usb_device. And we
probably want two functions, onboard_hub_set_port_feature() and
onboard_hub_clear_port_feature(), whose implementations may use shared
code.

> Idea-X:
> -------
> 
> I'm open for your input :)
> 
> 
> Regards,
>   Marco
> 
> PS: My favourite is Idea-3 followed by Idea-1.
> 
> > vim +481 drivers/usb/core/hub.c
> > 
> >    466	
> >    467	/*
> >    468	 * USB 2.0 spec Section 11.24.2.13
> >    469	 */
> >    470	static int set_port_feature(struct usb_device *hdev, int port1, int feature)
> >    471	{
> >    472		int ret;
> >    473	
> >    474		ret = usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
> >    475			USB_REQ_SET_FEATURE, USB_RT_PORT, feature, port1,
> >    476			NULL, 0, 1000);
> >    477		if (ret)
> >    478			return ret;
> >    479	
> >    480		if (!is_root_hub(hdev))
> >  > 481			ret = onboard_dev_port_feature(hdev, true, feature, port1);
> >    482	
> >    483		return ret;
> >    484	}
> >    485	
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> > 

