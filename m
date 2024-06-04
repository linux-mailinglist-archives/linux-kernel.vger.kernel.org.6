Return-Path: <linux-kernel+bounces-200722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCAD8FB403
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70BF1B28806
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D6B14900F;
	Tue,  4 Jun 2024 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kysw50c4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2DB146D79;
	Tue,  4 Jun 2024 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508254; cv=none; b=UrnDg4iXonK6b/gvY5PuE8XTbGUpKVk+53y6u+vk6d07TUGLK1qAjQNLAmisjCRd7/Vdn5uI0Fgj6IxN5EB4k6xrd3e3i3McfCE8Sh4Gie0Xl3envJ9n9k/KRZqexHKuAtEZ1eiBVOVkIRz/EGEWY6EUv3DnGplnK5yMNNSQe2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508254; c=relaxed/simple;
	bh=MtARxcG/H7MP69b0+3dVZv3usHjHBoMxyxik2H2JBvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijQtWmUx2ahscfRWHECtO948Ut+asFks55LOeP3p2TT21iwE237tlVb78AxziYQKMliVDamg1aLJSTC90ZcdVr9Pt1Scq1kuB3WBWkZ5GAyQ24/xc2WjJXMh2JizqSZRKt404i5Fjti2FX4IAyegeV9a5F3HszHuR9ymKLXzRwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kysw50c4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE758C2BBFC;
	Tue,  4 Jun 2024 13:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717508254;
	bh=MtARxcG/H7MP69b0+3dVZv3usHjHBoMxyxik2H2JBvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kysw50c4D7+gLgCn7OJktJVSc1Oz43RA9YzGK0f4lqtdi7w2uzlvFDc4aKa8TFdsb
	 iXAspH4KMzwKjgyJFwcLALNCNF4Sk4zuA9+p/B/bhb+Y/35Mmf0pgFZcvsffOAJQ9J
	 76q9p+8WfkenrmUmqkaVpXQ+7tPqYzjWeDSCPFA8=
Date: Tue, 4 Jun 2024 15:35:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: accessrunner-general@lists.sourceforge.net, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	syzbot+00c18ee8497dd3be6ade@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: atm: cxacru: fix endpoint checking in cxacru_bind()
Message-ID: <2024060415-cloud-calcium-ca2f@gregkh>
References: <20240528183807.3832-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528183807.3832-1-n.zhandarovich@fintech.ru>

On Tue, May 28, 2024 at 11:38:07AM -0700, Nikita Zhandarovich wrote:
> Syzbot is still reporting quite an old issue [1] that occurs due to
> incomplete checking of present usb endpoints. As such, wrong
> endpoints types may be used at urb sumbitting stage which in turn
> triggers a warning in usb_submit_urb().
> 
> Fix the issue by verifying that required endpoint types are present
> for both in and out endpoints, taking into account cmd endpoint type.
> 
> Unfortunately, this patch has not been tested on real hardware.
> 
> [1] Syzbot report:
> usb 1-1: BOGUS urb xfer, pipe 1 != type 3
> WARNING: CPU: 0 PID: 8667 at drivers/usb/core/urb.c:502 usb_submit_urb+0xed2/0x18a0 drivers/usb/core/urb.c:502
> Modules linked in:
> CPU: 0 PID: 8667 Comm: kworker/0:4 Not tainted 5.14.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:usb_submit_urb+0xed2/0x18a0 drivers/usb/core/urb.c:502
> ...
> Call Trace:
>  cxacru_cm+0x3c0/0x8e0 drivers/usb/atm/cxacru.c:649
>  cxacru_card_status+0x22/0xd0 drivers/usb/atm/cxacru.c:760
>  cxacru_bind+0x7ac/0x11a0 drivers/usb/atm/cxacru.c:1209
>  usbatm_usb_probe+0x321/0x1ae0 drivers/usb/atm/usbatm.c:1055
>  cxacru_usb_probe+0xdf/0x1e0 drivers/usb/atm/cxacru.c:1363
>  usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
>  call_driver_probe drivers/base/dd.c:517 [inline]
>  really_probe+0x23c/0xcd0 drivers/base/dd.c:595
>  __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
>  __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:894
>  bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
>  __device_attach+0x228/0x4a0 drivers/base/dd.c:965
>  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
>  device_add+0xc2f/0x2180 drivers/base/core.c:3354
>  usb_set_configuration+0x113a/0x1910 drivers/usb/core/message.c:2170
>  usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
>  usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
> 
> Reported-and-tested-by: syzbot+00c18ee8497dd3be6ade@syzkaller.appspotmail.com
> Fixes: 902ffc3c707c ("USB: cxacru: Use a bulk/int URB to access the command endpoint")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
> P.S. While the driver is orphaned, it might still make sense to
> suppress the syzbot report, seeing how ancient it is.
> P.P.S. checkpatch complains about outdated format of debug printing
> but I decided to keep it in tune with the rest of the driver. 
> 
>  drivers/usb/atm/cxacru.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
> index 4ce7cba2b48a..8a8e94a601c6 100644
> --- a/drivers/usb/atm/cxacru.c
> +++ b/drivers/usb/atm/cxacru.c
> @@ -1131,7 +1131,8 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
>  	struct cxacru_data *instance;
>  	struct usb_device *usb_dev = interface_to_usbdev(intf);
>  	struct usb_host_endpoint *cmd_ep = usb_dev->ep_in[CXACRU_EP_CMD];
> -	int ret;
> +	struct usb_endpoint_descriptor *in, *out;
> +	int ret = -1;

Why initialize this and then write over it?

Also, -1 is not a valid return value, so even if this was needed, it's
not correct :(


>  
>  	/* instance init */
>  	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
> @@ -1177,6 +1178,19 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
>  		goto fail;
>  	}
>  
> +	if (usb_endpoint_xfer_int(&cmd_ep->desc))
> +		ret = usb_find_common_endpoints(intf->cur_altsetting,
> +						NULL, NULL, &in, &out);
> +	else
> +		ret = usb_find_common_endpoints(intf->cur_altsetting,
> +						&in, &out, NULL, NULL);
> +
> +	if (ret) {
> +		usb_dbg(usbatm_instance, "cxacru_bind: interface has incorrect endpoints\n");

Shouldn't this be an error instead?

thanks,

greg k-h

