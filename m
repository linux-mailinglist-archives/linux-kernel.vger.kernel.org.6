Return-Path: <linux-kernel+bounces-314247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AF496B084
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C692861B3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 05:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD6F84047;
	Wed,  4 Sep 2024 05:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elrest.cz header.i=@elrest.cz header.b="jyz/vs//"
Received: from smtp.cesky-hosting.cz (smtp.cesky-hosting.cz [91.239.200.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630301EC00B;
	Wed,  4 Sep 2024 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.239.200.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725427894; cv=none; b=Na3Lk5NEwDJ/r82Au2IP0r2gBAhXuihaj+1Dvk7X6PP9cT5T4UCTEWvJmO6zVpTCb32iohh973tCLfohj56IffuLrF+KjRDD8Zek4+qPWP7mcc8sTvoRrRm5kXkDMQ0kGe/4gZ3FzQcioIn/cnbU753nheDOoV/UwUqIWC40hvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725427894; c=relaxed/simple;
	bh=VG1kmKAti+Ow7R45ux9a8XtBf5InNjSs75jykWkNvpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPqaZpRBz/IR00nJDP+1wlf9B0sNVKTWy2NBXVsd/wK/FW+NmpWb+3pPPbH+XkZDEa83E6D1g5lnVtHxRDZufqEoeyFT1YzYAgF3Z2rPxyRqLU7u8iosGfLdU9w2XR7Cm8OVtUTeWO8jyq9wvifxvgcyEMKNrLUYDd9r1HOSB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=elrest.cz; spf=pass smtp.mailfrom=elrest.cz; dkim=pass (2048-bit key) header.d=elrest.cz header.i=@elrest.cz header.b=jyz/vs//; arc=none smtp.client-ip=91.239.200.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=elrest.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elrest.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=elrest.cz;
	s=rampa2-202408; t=1725427885;
	bh=VG1kmKAti+Ow7R45ux9a8XtBf5InNjSs75jykWkNvpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyz/vs//N11Tu2e2Z84Oh9cSGr3/TZRJ0p2T54zcG6ww/dZ4mAQPOM0ILXbsH4eay
	 LL43XnlO2OtyhNeRa82AR+F6HV4ArppSKY0IdLOSYRfgY4YOyuZPaPFBSyfwy+i4rY
	 7anT/upHB1/NJMpHdpRQvrectCX3wok3NG+MrYeuilfnDvbfclpT0XAFMQVxCrxTW1
	 ZKkxkKg8FcgWnHWVYRFjFltcoNv7uB7armDymM4R/BjltLuXRW6PXTcY2DjupiIAyb
	 s+hzTCt/3Cui1ZamSoZgODGgw8JyyKXEQNbe+X21fU4Z+SDTElAj3VEc9Ia+4cd1Mz
	 YcFAT9Ty5Hhhw==
X-Virus-Scanned: Debian amavis at smtp.cesky-hosting.cz
X-Thin-Conversation: conversation
Received: from f902c60e4871 (unknown [185.63.98.16])
	(Authenticated sender: tomas.marek@elrest.cz)
	by smtp.cesky-hosting.cz (Postfix) with ESMTPSA id 4WzB1T0GrnzM2;
	Wed,  4 Sep 2024 07:31:24 +0200 (CEST)
Date: Wed, 4 Sep 2024 07:30:52 +0200
From: Tomas Marek <tomas.marek@elrest.cz>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: hminas@synopsys.com, gregkh@linuxfoundation.org,
	Arthur.Petrosyan@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, oleg.karfich@wago.com
Subject: Re: [PATCH] usb: dwc2: drd: fix clock gating on USB role switch
Message-ID: <20240904053052.GA8@f902c60e4871>
References: <20240903094156.6516-1-tomas.marek@elrest.cz>
 <a2ea1fa0-645d-2a16-f396-797e5b96fd45@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2ea1fa0-645d-2a16-f396-797e5b96fd45@omp.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)

Hi Sergey,

thank you for your review.

On Tue, Sep 03, 2024 at 04:20:26PM +0300, Sergey Shtylyov wrote:
> On 9/3/24 12:41 PM, Tomas Marek wrote:
> 
> > The dwc2_handle_usb_suspend_intr() function disables gadget clocks in USB
> > peripheral mode when no other power-down mode is available (introduced by
> > commit 0112b7ce68ea ("usb: dwc2: Update dwc2_handle_usb_suspend_intr function.")).
> > However, the dwc2_drd_role_sw_set() USB role update handler attempts to
> > read DWC2 registers if the USB role has changed while the USB is in suspend
> > mode (when the clocks are gated). This causes the system to hang.
> > 
> > Release gadget clocks before handling the USB role update.
> > 
> > Fixes: 0112b7ce68ea ("usb: dwc2: Update dwc2_handle_usb_suspend_intr function.")
> > 
> > Signed-off-by: Tomas Marek <tomas.marek@elrest.cz>
> > ---
> >  drivers/usb/dwc2/drd.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c
> > index a8605b02115b..ccb33cd1f04b 100644
> > --- a/drivers/usb/dwc2/drd.c
> > +++ b/drivers/usb/dwc2/drd.c
> > @@ -127,6 +127,18 @@ static int dwc2_drd_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
> >  			role = USB_ROLE_DEVICE;
> >  	}
> >  
> > +#if IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) || \
> > +	IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
> > +	if (dwc2_is_device_mode(hsotg)) {
> 
>    Why not avoid #ifdef by doing e.g.:
> 
> 	if ((IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) || \
> 	     IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE) &&
> 	     dwc2_is_device_mode(hsotg)) {
> 
> > +		if (hsotg->lx_state == DWC2_L2) {
> > +			if (hsotg->params.power_down ==
> > +			    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended &&
> > +			    !hsotg->params.no_clock_gating)
> 
>    Well, these *if*s are mergeable too... :-)
> 

OK, why not. In the end all conditions could be merged into one if statement like:

	if ((IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) ||
	     IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)) &&
	     dwc2_is_device_mode(hsotg) &&
	     hsotg->lx_state == DWC2_L2 &&
	     hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_NONE &&
	     hsotg->bus_suspended &&
	     !hsotg->params.no_clock_gating)
		dwc2_gadget_exit_clock_gating(hsotg, 0);

I’ll submit a new patch version with this modification.

Best regards

Tomas

> > +				dwc2_gadget_exit_clock_gating(hsotg, 0);
> > +		}
> > +	}
> > +#endif
> > +
> [...]
> 
> MBR, Sergey

