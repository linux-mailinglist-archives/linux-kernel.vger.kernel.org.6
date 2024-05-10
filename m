Return-Path: <linux-kernel+bounces-175431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E904A8C1F93
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9421F21BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BE615FA66;
	Fri, 10 May 2024 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AxmllSwk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A7620309
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329028; cv=none; b=t+gLOz97/1PX9pr9M3dmms4a/XPzCSx6CHRTfsM0FBuMm+ywxg/txaKb4PLn3g+eafVbQB1ZHU3FErHXNa4kDJiR7CaxYyZA9JiC/1i/0uhS9g3bvgHmqKbQg/zy2ru4RdpbNV6lDJ8NaxD7kcnIdSjrqjzbEO6vtAfuH3mwQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329028; c=relaxed/simple;
	bh=3ZDwHzsfGWUbx3aEP4Hd/f3NEWbuvIEMGcIBveCseHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuuHL0ZRyi6qUfMmAJ4VcOM6rWOQUw/Lg0SrF0GoqoqFEDmPKLkU4F+XEe4TSPNbpXrzH7oRxEf4QwZ4y+AuFKD6IyEnTBbpw8yukWBeAmkgQYS26MdssmV1rdA219zo8RGBnnHVAGgmuckbUCGXlYOyLXhSj3bpfOiBAkjyesg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AxmllSwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BE0C113CC;
	Fri, 10 May 2024 08:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715329027;
	bh=3ZDwHzsfGWUbx3aEP4Hd/f3NEWbuvIEMGcIBveCseHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxmllSwk1PKimxkjWGI+xVbv2XdXeALb32vl6iCT8ro/0zNi7eAu575eXmDq15uf3
	 FB/F1ZYzWhJxFUSkxMdlbK+4aGftv22e+1ynyu6fr3bTfI6/LwrQ3nGL12fVdxubaa
	 a0xZ+cLyNchKaiZJISJsDlJOpTWCAEfBSzDlFaTY=
Date: Fri, 10 May 2024 09:17:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Cc: michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] drivers: soc: xilinx: check return status of
 get_api_version()
Message-ID: <2024051034-surfacing-length-eae9@gregkh>
References: <20240509043629.21506-1-jay.buddhabhatti@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509043629.21506-1-jay.buddhabhatti@amd.com>



On Wed, May 08, 2024 at 09:36:29PM -0700, Jay Buddhabhatti wrote:
> Currently return status is not getting checked for get_api_version
> and because of that for x86 arch we are getting below smatch error.
> 
>     CC      drivers/soc/xilinx/zynqmp_power.o
> drivers/soc/xilinx/zynqmp_power.c: In function 'zynqmp_pm_probe':
> drivers/soc/xilinx/zynqmp_power.c:295:12: warning: 'pm_api_version' is
> used uninitialized [-Wuninitialized]
>     295 |         if (pm_api_version < ZYNQMP_PM_VERSION)
>         |            ^
>     CHECK   drivers/soc/xilinx/zynqmp_power.c
> drivers/soc/xilinx/zynqmp_power.c:295 zynqmp_pm_probe() error:
> uninitialized symbol 'pm_api_version'.
> 
> So, check return status of pm_get_api_version and return error in case
> of failure to avoid checking uninitialized pm_api_version variable.
> 
> Fixes: b9b3a8be28b3 ("firmware: xilinx: Remove eemi ops for get_api_version")
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> ---
> V1: https://lore.kernel.org/lkml/20240424063118.23200-1-jay.buddhabhatti@amd.com/
> V1->V2: Removed AMD copyright
> ---

Why is this a RESEND?

Also my bot had issues:

--------

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

