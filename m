Return-Path: <linux-kernel+bounces-385928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84089B3D34
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0411F230B2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDF61FCF63;
	Mon, 28 Oct 2024 21:50:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734701F4273
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152223; cv=none; b=DwKsAHT/7EB0R7hh6OEOW6MI0iZj0KBGqwuQy+mGtSZcYP506uF2WGmyzT1firNcgqbQAOSji7QmNoXGceGVZsAW+x2gSMhXWlw1dXHZgUzDpA6zFpejAc+8exq88BCsEBHO7QP8lkPO0NSiwr48Cs/wbV/ERhffV5WXXXJmoAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152223; c=relaxed/simple;
	bh=V6Qcj3tOIGcSu35JwGeNx9+xFqxPBD8uIH+zjysOBNk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYLJuhOWY78kEtoTLb2KsYdlXjenAUS+jOR+bq5nF1MKNfIEl21lEIP0xX+rYeRO5emFdbvbpWED7jpAbmGpSSRleQvQLaiHA8EV42FPdFEcTnB51c9BVe8dD5+ZmKvx+HRYOmDSUe/KQdKUXDR96MUis2TWeKyqkt2l22HovrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1t5Xcc-0000Lv-3Y; Mon, 28 Oct 2024 22:49:58 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t5Xca-000vCY-2y;
	Mon, 28 Oct 2024 22:49:56 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t5Xca-000sqw-2d;
	Mon, 28 Oct 2024 22:49:56 +0100
Date: Mon, 28 Oct 2024 22:49:56 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Matthias Kaehlcke <matthias@kaehlcke.net>,
	kernel test robot <lkp@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Kaehlcke <mka@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, oe-kbuild-all@lists.linux.dev,
	kernel@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: hub: add infrastructure to pass onboard_dev
 port features
Message-ID: <20241028214956.gmefpvcvm3zrfout@pengutronix.de>
References: <20240807-b4-v6-10-topic-usb-onboard-dev-v1-1-f33ce21353c9@pengutronix.de>
 <202408081557.FiEe9Tzz-lkp@intel.com>
 <20240809093313.xn3x2p3st2b32g27@pengutronix.de>
 <wtvhsdo2zefehkgfcp2cfdl2uht4lcrytyjyhwjhnpcyvx4kd2@iurrw554aegh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wtvhsdo2zefehkgfcp2cfdl2uht4lcrytyjyhwjhnpcyvx4kd2@iurrw554aegh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

I found two mistakes I made in my v1. I would send a v2 if this series
is interesting for upstream. The remaining open question is how the
driver dependencies should be handled (see idea-1,2,3).

Regards,
  Marco

On 24-09-23, Matthias Kaehlcke wrote:
> El Fri, Aug 09, 2024 at 11:33:13AM GMT Marco Felsch ha dit:
> 
> > Hi all,
> > 
> > On 24-08-08, kernel test robot wrote:
> > > Hi Marco,
> > > 
> > > kernel test robot noticed the following build errors:
> > > 
> > > [auto build test ERROR on 0c3836482481200ead7b416ca80c68a29cfdaabd]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Marco-Felsch/usb-hub-add-infrastructure-to-pass-onboard_dev-port-features/20240807-224100
> > > base:   0c3836482481200ead7b416ca80c68a29cfdaabd
> > > patch link:    https://lore.kernel.org/r/20240807-b4-v6-10-topic-usb-onboard-dev-v1-1-f33ce21353c9%40pengutronix.de
> > > patch subject: [PATCH 1/3] usb: hub: add infrastructure to pass onboard_dev port features
> > > config: i386-randconfig-141-20240808 (https://download.01.org/0day-ci/archive/20240808/202408081557.FiEe9Tzz-lkp@intel.com/config)
> > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408081557.FiEe9Tzz-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202408081557.FiEe9Tzz-lkp@intel.com/
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    ld: drivers/usb/core/hub.o: in function `set_port_feature':
> > > >> drivers/usb/core/hub.c:481: undefined reference to `onboard_dev_port_feature'
> > >    ld: drivers/usb/core/hub.o: in function `usb_clear_port_feature':
> > >    drivers/usb/core/hub.c:462: undefined reference to `onboard_dev_port_feature'
> > 
> > I understood the isse but have a few questions. Before continue the work
> > on this topic I would like to ask if the patchset is okay in general?
> > I'm open for alternatives if the patchset approach is not okay.
> 
> From the perspective of the onboard_usb_dev driver it seems sound to me.
> 
> So far the USB maintainers haven't raised objections, so I would say move
> forward and we'll see if concerns arise and deal with them if needed.
> 
> > I have a few ideas in mind (see below) to fix the 0day build issue which
> > was caused by the Kconfig selection:
> > 
> >  - CONFIG_USB=y
> >  - CONFIG_USB_ONBOARD_DEV=m.
> > 
> > Idea-1:
> > -------
> > 
> > Dropping the module support for CONFIG_USB_ONBOARD_DEV.
> 
> With that CONFIG_USB could not be 'm' when CONFIG_USB_ONBOARD_DEV
> is set, which wouldn't be great.
> 
> > Idea-2:
> > -------
> > 
> > CONFIG_USB_ONBOARD_DEV follows CONFIG_USB:
> > 
> > CONFIG_USB=y -> CONFIG_USB_ONBOARD_DEV=y,
> > CONFIG_USB=m -> CONFIG_USB_ONBOARD_DEV=m.
> > 
> > and exporting usb_clear_port_feature().
> > 
> > I don't know to add such Kconfig dependency and also this idea require
> > that the usbcore have to load the usb_onboard_dev module always,
> > regardless if used.
> > 
> > So this idea is rather suboptimal.
> > 
> > Idea-3:
> > -------
> > 
> > Adding a function to the hub.c usbcore which can be used by the
> > usb-onboard-dev driver to register this function as hook. This removes
> > the dependency from the core and the usb-onboard-dev module is only
> > pulled if really required. Of course this require that the hub.c usbcore
> > driver allows custom hooks.
> 
> This seems like the best approach IMO, if USB maintainers are onboard with
> it.
> 
> Since this is about port features (only applicable to hubs) the function
> should be associated with struct usb_hub, not struct usb_device. And we
> probably want two functions, onboard_hub_set_port_feature() and
> onboard_hub_clear_port_feature(), whose implementations may use shared
> code.
> 
> > Idea-X:
> > -------
> > 
> > I'm open for your input :)
> > 
> > 
> > Regards,
> >   Marco
> > 
> > PS: My favourite is Idea-3 followed by Idea-1.
> > 
> > > vim +481 drivers/usb/core/hub.c
> > > 
> > >    466	
> > >    467	/*
> > >    468	 * USB 2.0 spec Section 11.24.2.13
> > >    469	 */
> > >    470	static int set_port_feature(struct usb_device *hdev, int port1, int feature)
> > >    471	{
> > >    472		int ret;
> > >    473	
> > >    474		ret = usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
> > >    475			USB_REQ_SET_FEATURE, USB_RT_PORT, feature, port1,
> > >    476			NULL, 0, 1000);
> > >    477		if (ret)
> > >    478			return ret;
> > >    479	
> > >    480		if (!is_root_hub(hdev))
> > >  > 481			ret = onboard_dev_port_feature(hdev, true, feature, port1);
> > >    482	
> > >    483		return ret;
> > >    484	}
> > >    485	
> > > 
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> > > 
> 

