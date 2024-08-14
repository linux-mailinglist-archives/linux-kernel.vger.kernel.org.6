Return-Path: <linux-kernel+bounces-286391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B23951A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486C01C21684
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC791AC443;
	Wed, 14 Aug 2024 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vpQTEIGe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A990B394;
	Wed, 14 Aug 2024 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723636068; cv=none; b=rA9zwEjkCiEzLX9thMdWUfVXpgJLkiKGcw9e/Y6FGlGQteX84jr39gQ4XUP2QPYN2KD2A41G07i/r2ESRHP4oB9PY2xENrungMI5wgizAwH2/jX/Dcs/eFk7rg2Yik8xY6CxWXvRF9s2lKvhEsEcqH8xlm810bBa8WgVFQV5tQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723636068; c=relaxed/simple;
	bh=ZKlMTyHlfOhq1twls2348nUgT6m2aeTcj59z4D0GIuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmN+bzRaPNBPerJz7Nd0IGWOeP0dKKJuMcvH5TjMq5Fntvzx4e64CXiJg2kt35BrqhutjEbH4SIX9fA7snG06nF4rY/90KqH7ENSw+UClttm6I43BEmDCxiOt1hvnVO0+7G+40ag8SWhqCQb2bUPB36frnWA8jmFISVmVuDZioQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vpQTEIGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A7DC32786;
	Wed, 14 Aug 2024 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723636068;
	bh=ZKlMTyHlfOhq1twls2348nUgT6m2aeTcj59z4D0GIuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vpQTEIGe0HGO7ZAib9CpBTEP/ArIOu7xuSPFkTHV+e2V1f9CikV52sqYd0skXuYRQ
	 +8ZtCuk8f1WBM/XImFsZU6U1S1UNgTrYxUdAD783HtQF/tm+rXkMV+8wt+kT9eXDeG
	 +eWKUWRGOJ6kavrgUfRmzvlboGdXz+UQjfjr/as0=
Date: Wed, 14 Aug 2024 13:47:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Kevin Strasser <kevin.strasser@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] usb: core: sysfs: Unmerge @usb3_hardware_lpm_attr_group
 in remove_power_attributes()
Message-ID: <2024081438-moisture-monthly-c31e@gregkh>
References: <20240814-sysfs_fix-v1-1-2224a29a259b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-sysfs_fix-v1-1-2224a29a259b@quicinc.com>

On Wed, Aug 14, 2024 at 07:07:34PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Device attribute group @usb3_hardware_lpm_attr_group is merged by
> add_power_attributes(), but it is not unmerged explicitly, fixed by
> unmerging it in remove_power_attributes().
> 
> Fixes: 655fe4effe0f ("usbcore: add sysfs support to xHCI usb3 hardware LPM")
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/usb/core/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
> index d83231d6736a..61b6d978892c 100644
> --- a/drivers/usb/core/sysfs.c
> +++ b/drivers/usb/core/sysfs.c
> @@ -670,6 +670,7 @@ static int add_power_attributes(struct device *dev)
>  
>  static void remove_power_attributes(struct device *dev)
>  {
> +	sysfs_unmerge_group(&dev->kobj, &usb3_hardware_lpm_attr_group);
>  	sysfs_unmerge_group(&dev->kobj, &usb2_hardware_lpm_attr_group);
>  	sysfs_unmerge_group(&dev->kobj, &power_attr_group);
>  }
> 
> ---
> base-commit: 82313624b2ae5a943d16475a566b65c873989e9f
> change-id: 20240814-sysfs_fix-2206de9b0179
> 
> Best regards,
> -- 
> Zijun Hu <quic_zijuhu@quicinc.com>
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

