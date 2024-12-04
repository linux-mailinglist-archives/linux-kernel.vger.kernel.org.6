Return-Path: <linux-kernel+bounces-431444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16A09E3D6E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8DF160F27
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2957D20B1F5;
	Wed,  4 Dec 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CKYiSa9J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3D51FF7CF;
	Wed,  4 Dec 2024 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324139; cv=none; b=E57Q/WQf55U/GkdMfE97ezKQsowlvNv4L0v4XTvpGaEmzv5BVsMEY5FVmBwpst0jmmJQa4MazGKTMXsW5GeeGUjmtlM0Z4xu+ChMyRglNox3N68XaOWX/zjkef2bjO4uucjgacnCZGJShBKpjG6/5m8QUux0JmFQE2VwUmt5UbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324139; c=relaxed/simple;
	bh=d+EpGkxxw/0qqt8HugknckOZ4epr8foxqtVC2bG1SZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5pkF6jWqV7MYtDxA+2P3zHyp0peA2DvFqt+nc02+VLN0FlTK/8kHGW/XEI7fO/5IhZ45/BGxBKQ/+aG67wqbEooh6gPvL4TEMLtPN4LogIv9PU6Hy5QbCwg1bMCi8S9dMlRBI12bIol1dRBovlz1c90UsjzTRlJXi57Kcwcjms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CKYiSa9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FECFC4CECD;
	Wed,  4 Dec 2024 14:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733324138;
	bh=d+EpGkxxw/0qqt8HugknckOZ4epr8foxqtVC2bG1SZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKYiSa9JfUepnzISw70OSSX2X1dMvFE0YcvVSDcsVBgxSAQMvatZ6UVXaVsOaI47S
	 5A43FX0g1fNeCplBAbZUyO9ev+vadZJcbzchFFIXHTlUthBZRSqJaPY6EcpT26j0tM
	 nIdP5aDdfsdVuWBm0Vfl/4LtIjviidArFpxg35q8=
Date: Wed, 4 Dec 2024 15:55:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: xiehongyu1@kylinos.cn
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mathias.nyman@intel.com
Subject: Re: [PATCH] usb: xhci: Add module param for compliance quirk checking
Message-ID: <2024120406-yelp-immunize-ed98@gregkh>
References: <2024120205-collected-trapezoid-9dde@gregkh>
 <20241203003040.1518504-1-xiehongyu1@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203003040.1518504-1-xiehongyu1@kylinos.cn>

On Tue, Dec 03, 2024 at 08:30:40AM +0800, xiehongyu1@kylinos.cn wrote:
> Hi Greg,
> 
> On 2024/12/2 14:38, Greg KH wrote:
> > On Mon, Dec 02, 2024 at 11:18:55AM +0800, xiehongyu1@kylinos.cn wrote:
> >> From: Hongyu Xie <xiehongyu1@kylinos.cn>
> >>
> >> In the old way, vendor name and product name need to be put in
> >> xhci_compliance_mode_recovery_timer_quirk_check, it's not convenient.
> >>
> >> So add two module param for convenience.
> >
> > Please no.  Module parameters are from the 1990's, they do not scale or
> > work well anymore, please never add them.
> >
> >>
> >> usage: put xhci-hcd.compliance_vendor=[vendor name]
> >> xhci-hcd.compliance_product=[product name] in cmdline.
> >>
> >> In Ubuntu you can use "dmidecode -t system" to get vendor name and
> >> product name.
> >>
> >> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> >> ---
> >>  drivers/usb/host/xhci.c | 18 ++++++++++++++++--
> >>  1 file changed, 16 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> >> index 5ebde8cae4fc..2007c27bfaf4 100644
> >> --- a/drivers/usb/host/xhci.c
> >> +++ b/drivers/usb/host/xhci.c
> >> @@ -39,6 +39,14 @@ static unsigned long long quirks;
> >>  module_param(quirks, ullong, S_IRUGO);
> >>  MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
> >>  
> >> +static char *compliance_product;
> >> +module_param(compliance_product, charp, 0644);
> >> +MODULE_PARM_DESC(compliance_product, "Product name for compliance comparison");
> >> +
> >> +static char *compliance_vendor;
> >> +module_param(compliance_vendor, charp, 0644);
> >> +MODULE_PARM_DESC(compliance_vendor, "Vendor name for compliance comparison");
> >
> > Also, you have provided no documentation as to why these are needed at
> > all, so that's not going to work :(
> Engenieer from RENESA suggested to put vendor name and product name in
> xhci_compliance_mode_recovery_timer_quirk_check for some buggy
> motherboard that using uPD720201.

Why not fix the hardware instead?  And what is this going to "check"?

> For oem(or odm), there might be multiple names for the same
> motherboard(or same design). And put all the names in
> xhci_compliance_mode_recovery_timer_quirk_check might not be a good
> idea.

It should be ok to do that if all of this is broken hardware, right?

> So I figure using module_param can do the job. Anyway, Is there
> better way to do this in kernel?

sysfs attribute?  That way you set it for the specific device you care
about, not for ALL devices in the system which is what this patch does.
Remember, many systems have multiple xhci controllers (I have a laptop
somewhere around here with 4 xhci host controllers.)

thanks,

greg k-h

