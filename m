Return-Path: <linux-kernel+bounces-447330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5429C9F309F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A544165BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EFC204C25;
	Mon, 16 Dec 2024 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TKRzVnza"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3F1FF7BE;
	Mon, 16 Dec 2024 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734352508; cv=none; b=B0ImCdt3x0wkFkkDQDm7nwqO/NBYSgkR0SG92V4bDfv6lajIV7YQpi+bh5r3t48VuoQYknOe34EeVpnCNwTx5m3Vj/jwpuEEJO47vMlHTGjJcUMRgdqt+am1A5WWE3TMZ/lvFKW5brjSrnFdZ33kb9GW8pY1RRE7azCJ60EF8zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734352508; c=relaxed/simple;
	bh=XO4O4e3sFA+nAvJgtst0EJ1I2zVHBibUJKpBWvdyhoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUKIeK0UAF7so3n3HJrNVog1xVo9SND/uWkw80jWuw+hCB5X0e6zsbC8jOiypLx+ozc7QAvf54FnXFznk8/jRgAHEzdITwfJcIgWDHr8rWeheR0GjBWFLNTlvTLgbIlb8WUG8zTYI5o8F5Cgalo98VcGbeofeR+FIh82/3jb/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TKRzVnza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B06C4CED3;
	Mon, 16 Dec 2024 12:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734352507;
	bh=XO4O4e3sFA+nAvJgtst0EJ1I2zVHBibUJKpBWvdyhoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKRzVnzaIhB/eSTQg3OIvZCyTR9nofXecv4tZyEw8SN914njxip/TCeMTZwB+JAZM
	 h2gKPAoV+6DDZwPlEJc+C0i9dVZgEfGjNudexHjpiDQLkw6gYPIZUlcDD318jg28Lg
	 tCkUazw1Ydsh4L3tLH1ap7TxQqHviCzoEx+DqUHY=
Date: Mon, 16 Dec 2024 13:34:28 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: Prashanth K <quic_prashk@quicinc.com>,
	"mwalle@kernel.org" <mwalle@kernel.org>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: [PATCH v2] usb: gadget: u_serial: Disable ep before setting port
 to null to fix the crash caused by port being null
Message-ID: <2024121649-balancing-appliance-80f0@gregkh>
References: <TYUPR06MB6217DAA095A9863D4B58D57CD23B2@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB6217DAA095A9863D4B58D57CD23B2@TYUPR06MB6217.apcprd06.prod.outlook.com>

On Mon, Dec 16, 2024 at 12:31:45PM +0000, 胡连勤 wrote:
> From: Lianqin Hu <hulianqin@vivo.com>
> 
> Considering that in some extreme cases, when performing the
> unbinding operation, gserial_disconnect has cleared gser->ioport,
> which triggers gadget reconfiguration, and then calls gs_read_complete,
> resulting in access to a null pointer. Therefore, ep is disabled before
> gserial_disconnect sets port to null to prevent this from happening.
> 
> Call trace:
>  gs_read_complete+0x58/0x240
>  usb_gadget_giveback_request+0x40/0x160
>  dwc3_remove_requests+0x170/0x484
>  dwc3_ep0_out_start+0xb0/0x1d4
>  __dwc3_gadget_start+0x25c/0x720
>  kretprobe_trampoline.cfi_jt+0x0/0x8
>  kretprobe_trampoline.cfi_jt+0x0/0x8
>  udc_bind_to_driver+0x1d8/0x300
>  usb_gadget_probe_driver+0xa8/0x1dc
>  gadget_dev_desc_UDC_store+0x13c/0x188
>  configfs_write_iter+0x160/0x1f4
>  vfs_write+0x2d0/0x40c
>  ksys_write+0x7c/0xf0
>  __arm64_sys_write+0x20/0x30
>  invoke_syscall+0x60/0x150
>  el0_svc_common+0x8c/0xf8
>  do_el0_svc+0x28/0xa0
>  el0_svc+0x24/0x84
> 
> Fixes: c1dca562be8a ("usb gadget: split out serial core")
> Cc: stable@vger.kernel.org
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
> 
> v2:
>  - Remove some address information from patch descriptions
>  - Link to v1: https://lore.kernel.org/all/TYUPR06MB621763AB815989161F4033AFD2762@TYUPR06MB6217.apcprd06.prod.outlook.com/
>  - Link to suggestions: https://lore.kernel.org/all/TYUPR06MB6217DE28012FFEC5E808DD64D2962@TYUPR06MB6217.apcprd06.prod.outlook.com/

The "v2:" needs to go below the --- line, what happened to that?

And no need to have a blank line after the cc: stable, right?  Did you
run checkpatch.pl on this?

thanks,

greg k-h

