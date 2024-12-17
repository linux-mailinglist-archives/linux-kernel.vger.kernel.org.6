Return-Path: <linux-kernel+bounces-448640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6EC9F4353
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4F0168F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA9D158535;
	Tue, 17 Dec 2024 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UL+KVbTo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E4F18E20;
	Tue, 17 Dec 2024 06:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734415936; cv=none; b=nMw8KKt8nqIKOFwWXaFg6N4hOcCqzbox82CBRhsway7opIGnxA2Nzz5jAs9qFSbr+PKxf6+uD3CdMyaGbEAqxnireWc+fDNg8Xs6ZO0ZCjSWIGwzBKhQW57MkK3UEoYQ6m5XI4jncf07KQd89MUYgTMC9s8W/msFwALE9PUonqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734415936; c=relaxed/simple;
	bh=ybGYbvC+VkAiO1aMzR6ncMIrfMivMFNcdAgJYKuze6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTCgzb54199qFOPbXHfk1kBNatyD8iqnJHacHv1xbtoiltdY64XK3dU4acQGdfeU8v/0gS5Km9d369Pg5TZ3uW2HNErndnBJ/RLMVKu0E/CcE2B/Hx1i/l0hRr33Tu8lKO/vEXzjJUCUL0Voa6XD8KOIF69yKbOugFOQ3bW5czo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UL+KVbTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30C0C4CED3;
	Tue, 17 Dec 2024 06:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734415936;
	bh=ybGYbvC+VkAiO1aMzR6ncMIrfMivMFNcdAgJYKuze6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UL+KVbTo3rm3vmtlJKh0atZd0SC9hS3RvjPZjSllf6+enRZk6IvspWtHsx3DbbVBY
	 qMdhKD4Hmve0NPh5EoPgTRrKSdq5viTP+JWxlasvqjQOb9G1kd9f0KCsiD6eth8CcO
	 zFTYVwtT30Qh4Z2EAgveTdcQQZ8mB7Ey2hSXh/ZljD8KA7kTAfmc62kC1X2bzwS4Ee
	 U5Htj5hI5C99PxSB7ds0V01K90B9iMSNISmstH3DWgxIWTmpKdKunz6dBhJzizKS0r
	 7CGGura4wkzVcHcO2P2cP/QYOYrZY+PE36Yuv/tqMfGxf7a1PBg0BuUPxUS47tUqh3
	 M+lL47MSbX9Lw==
Date: Tue, 17 Dec 2024 14:12:07 +0800
From: Peter Chen <peter.chen@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Pawel Laszczak <pawell@cadence.com>, Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] usb: cdns3-ti: run HW init at resume() if HW was
 reset
Message-ID: <20241217061207.GA13482@nchen-desktop>
References: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
 <20241210-s2r-cdns-v6-2-28a17f9715a2@bootlin.com>
 <20241214084940.GA4102926@nchen-desktop>
 <D6D6IL1RNGA8.3U3GIJQJX2L3J@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D6D6IL1RNGA8.3U3GIJQJX2L3J@bootlin.com>

On 24-12-16 15:02:43, Théo Lebrun wrote:
> On Sat Dec 14, 2024 at 9:49 AM CET, Peter Chen wrote:
> > On 24-12-10 18:13:36, Théo Lebrun wrote:
> > > At runtime_resume(), read the W1 (Wrapper Register 1) register to detect
> > > if an hardware reset occurred. If it did, run the hardware init sequence.
> > > 
> > > This callback will be called at system-wide resume. Previously, if a
> > > reset occurred during suspend, we would crash. The wrapper config had
> > > not been written, leading to invalid register accesses inside cdns3.
> > > 
> > > Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> > > ---
> > >  drivers/usb/cdns3/cdns3-ti.c | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > > 
> > > diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
> > > index d704eb39820ad08a8774be7f00aa473c3ff267c0..d35be7db7616ef5e5bed7dbd53b78a094809f7cc 100644
> > > --- a/drivers/usb/cdns3/cdns3-ti.c
> > > +++ b/drivers/usb/cdns3/cdns3-ti.c
> > > @@ -188,6 +188,12 @@ static int cdns_ti_probe(struct platform_device *pdev)
> > >  	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
> > >  	data->usb2_only = device_property_read_bool(dev, "ti,usb2-only");
> > >  
> > > +	/*
> > > +	 * The call below to pm_runtime_get_sync() MIGHT reset hardware, if it
> > > +	 * detects it as uninitialised. We want to enforce a reset at probe,
> > > +	 * and so do it manually here. This means the first runtime_resume()
> > > +	 * will be a no-op.
> > > +	 */
> > >  	cdns_ti_reset_and_init_hw(data);
> > >  
> > >  	pm_runtime_enable(dev);
> > > @@ -232,6 +238,24 @@ static void cdns_ti_remove(struct platform_device *pdev)
> > >  	platform_set_drvdata(pdev, NULL);
> > >  }
> > >  
> > > +static int cdns_ti_runtime_resume(struct device *dev)
> > > +{
> > > +	const u32 mask = USBSS_W1_PWRUP_RST | USBSS_W1_MODESTRAP_SEL;
> > > +	struct cdns_ti *data = dev_get_drvdata(dev);
> > > +	u32 w1;
> > > +
> > > +	w1 = cdns_ti_readl(data, USBSS_W1);
> > > +	if ((w1 & mask) != mask)
> > > +		cdns_ti_reset_and_init_hw(data);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct dev_pm_ops cdns_ti_pm_ops = {
> > > +	RUNTIME_PM_OPS(NULL, cdns_ti_runtime_resume, NULL)
> >
> > Why only runtime resume, but without runtime suspend?
> 
> I don't see any situation where we would want "runtime suspend" be
> equivalent to "reset the cdns3 wrapper". It implies losing child
> states, triggering rediscovery of all USB devices at resume. Is that a
> desired property of runtime suspend on any discoverable bus?

Usually, if wrapper needs to put controller to lower power state, 
it will do some jobs like close clock, etc. And if there is a option for
wakeup enable at wrapper, you may also need to set it.

Peter

