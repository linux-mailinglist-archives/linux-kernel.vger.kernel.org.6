Return-Path: <linux-kernel+bounces-269228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1675942F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EAAE1F2D988
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE23B1B5805;
	Wed, 31 Jul 2024 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vjaTU0fW"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D6D1AC43E;
	Wed, 31 Jul 2024 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430509; cv=none; b=PV4Zjb/fzcHMGrgI95X9Vmr5GWmbfpqVF/Fe0R/adq9SL4cDaWWPTDm5TYfFakw1Ms739/VJTbW+7qqpy/4vw5wRPYkyYILBl4+rWT31CMAfb/n559JvbxEiCPig5O/Zqkx6Ww5tWCuM3AiwqA4KAB5nDniw9H5i25bTXVlTotc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430509; c=relaxed/simple;
	bh=lTq7S21kjmzc4xVHxfjpvVAF+NSW7/VHXNsHCO59Kgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIYKbsGdVL8VGYSQEhVQtZKBugSov13rE1e6JVIdsZ/BVQ2z+E+3MwjmFlZFIQlPOCP7PQE7iIO3EaIULG7QRVuJtErJ7hy4zA3fg+Md8fCjsurm9dApEpvwUK2Oyl1LXjcJDVsjaJb5tKlzRnqLF1xY/8LKvpn1fOCZXkuZKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vjaTU0fW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 93DB9268;
	Wed, 31 Jul 2024 14:54:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722430457;
	bh=lTq7S21kjmzc4xVHxfjpvVAF+NSW7/VHXNsHCO59Kgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vjaTU0fWRpOtDnaS28JyH8m7hqg3wnahs+Iap3znqY/IwAbRqlNrF9TzfoUElmC3F
	 5dnsJurORTIIjbNtM7hWz+buP+bfwIFQHyyrGWtLPzsErp/33G1L7z+KPt3tThfP1H
	 cgH4quPhaZmlEBp7jIrpB3z7VRAro1YHGSlcofv4=
Date: Wed, 31 Jul 2024 15:54:44 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: gregkh@linuxfoundation.org, dan.scally@ideasonboard.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2] usb: gadget: uvc: Fixes the abnormal enumeration
 problem of mobile phone as UVC camera.
Message-ID: <20240731125444.GX8146@pendragon.ideasonboard.com>
References: <TYUPR06MB62175899DECC7A9B0DA0DF01D2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <20240731122351.GU8146@pendragon.ideasonboard.com>
 <TYUPR06MB6217EF08BA3F758EB20C833DD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB6217EF08BA3F758EB20C833DD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>

Hello 胡,

When replying, please don't drop the CC list unless you need to discuss
confidential topics. Your question, and the answers you will get, can
help other people facing the same problem, so it's important to keep
them on public mailing lists.

On Wed, Jul 31, 2024 at 12:46:27PM +0000, 胡连勤 wrote:
> Hello linux community expert:
> 
> Which kernel interface does the user space program call to modify bind_deactivated to false?
> I traced the kernel code and have not found where to modify this value.

In this very specific case, the function is activated by a call to
usb_function_activate() in uvc_function_connect(), itself called from
uvc_v4l2_subscribe_event() in response to the application calling the
VIDIOC_SUBSCRIBE_EVENT ioctl on the video device to subscribe to the
UVC_EVENT_SETUP event.

You can find a sample userspace application meant to work with this
driver at https://gitlab.freedesktop.org/camera/uvc-gadget. Note that I
haven't used it personally for a few years, so I may not be able to
easily provide detailed technical support.

> -----邮件原件-----
> 发件人: Laurent Pinchart <laurent.pinchart@ideasonboard.com> 
> 发送时间: 2024年7月31日 20:24
> 收件人: 胡连勤 <hulianqin@vivo.com>
> 抄送: gregkh@linuxfoundation.org; dan.scally@ideasonboard.com; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; akpm@linux-foundation.org; opensource.kernel <opensource.kernel@vivo.com>
> 主题: Re: 答复: [PATCH v2] usb: gadget: uvc: Fixes the abnormal enumeration problem of mobile phone as UVC camera.
> 
> On Wed, Jul 31, 2024 at 11:49:11AM +0000, 胡连勤 wrote:
> > When the phone is connected to the computer to use the webcam 
> > function, the phone needs to be enumerated as a uvc camera function.
> > 
> > Because uvc->func.bind_deactivated is configured as true in the f_uvc 
> > driver uvc_alloc function, the usb_gadget_deactivate function is 
> > called during the execution of the configfs_composite_bind function to 
> > set gadget->deactivated to true, which in turn causes the 
> > usb_gadget_connect_locked function to fail to call the corresponding 
> > controller pullup operation (such as: dwc3_gadget_pullup, 
> > mtu3_gadget_pullup), and the USB cannot be enumerated normally under 
> > the uvc function combination.
> > 
> > After applying this patch, we measured that under the uvc function, 
> > the dwc3 controller and the mtu3 controller can be enumerated 
> > normally, and the webcam function is normal.
> > 
> > Fixes this by removing the setting of uvc->func.bind_deactivated to true.
> > 
> > Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
> > ---
> > v2:
> >   - Add "Fixes:" tag on the commit
> >   - Modify description information.
> > ---
> >  drivers/usb/gadget/function/f_uvc.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/usb/gadget/function/f_uvc.c 
> > b/drivers/usb/gadget/function/f_uvc.c
> > index 40187b7112e7..6d63bea14211 100644
> > --- a/drivers/usb/gadget/function/f_uvc.c
> > +++ b/drivers/usb/gadget/function/f_uvc.c
> > @@ -1107,7 +1107,6 @@ static struct usb_function *uvc_alloc(struct usb_function_instance *fi)
> >  	uvc->func.disable = uvc_function_disable;
> >  	uvc->func.setup = uvc_function_setup;
> >  	uvc->func.free_func = uvc_free;
> > -	uvc->func.bind_deactivated = true;
> 
> This is done on purpose. The UVC function requires a userspace control
> application, so the function is deactivated by default at bind time,
> and gets activated when the application is ready.
> 
> This patch isn't right.
> 
> >  	return &uvc->func;
> >  
> > -----邮件原件-----
> > 发件人: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > 发送时间: 2024年7月31日 19:13
> > 收件人: 胡连勤 <hulianqin@vivo.com>
> > 抄送: akpm@linux-foundation.org; linux-kernel@vger.kernel.org; 
> > opensource.kernel <opensource.kernel@vivo.com>
> > 主题: Re: [PATCH v1] usb: gadget: uvc: Fixed the abnormal enumeration problem of mobile phone as UVC camera.
> > 
> > On Wed, Jul 31, 2024 at 08:45:31AM +0000, 胡连勤 wrote:
> > > When the phone is connected to the computer to use the webcam 
> > > function, the phone needs to be enumerated as a uvc camera function.
> > 
> > <snip>
> > 
> > Note, why aren't you using scripts/get_maintainer.pl to find the
> > proper mailing list and developers for this change?  Please do so.
> > 
> > thanks,
> > 
> > greg k-h

-- 
Regards,

Laurent Pinchart

