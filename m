Return-Path: <linux-kernel+bounces-243954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 745C2929CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF921F219F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C291C69C;
	Mon,  8 Jul 2024 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x6/Mff5k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AC818EAB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720423139; cv=none; b=U/5FaWPEF4scmVHrI/RrZ9jcwEMCc1fJ4qkbBKfh/YK7D/iYJCbUPo30Wkaq3L1XW2KD5S3oPwsJAqn3zQ9fveqBwYgyMYjCDLQzj4PBlokC7npXbsH43KkwsxAnegH+uDPNnpW0UgmIdhZzS8/hGG2N7J0ox1A0cwXz7bKLcRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720423139; c=relaxed/simple;
	bh=hx5T64Sj7xlhECM1HZmMWAV4zDvIOfGL0LNkMgwHf64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XziuwHqW0owM6n+Q/L4fLvMT7u/Hm3d/HL3CF+Lpb/7Jau6q9IM6sKROHcdzeP4dxJJcXHND1h+mAPtpPFEg71Z7NwCwTPBU1Jm4VcW5ATsqW1aKDCNKArnh0N0FaFZXtk3pnfkD6M3sZSfq9Si5n0cxDl8f6/RIsMy8LtZDS5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x6/Mff5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478C0C116B1;
	Mon,  8 Jul 2024 07:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720423138;
	bh=hx5T64Sj7xlhECM1HZmMWAV4zDvIOfGL0LNkMgwHf64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x6/Mff5kg9KH6IhgDurv0EhiYNCxdegeIdLKSLMzjea4rSr4KxW4Jt/FEPO9nzfZk
	 +MNYhA5+y5RoBGXQaSjrw5fcxG9A6hlTT8Su3b4fg/5cOwfuGSw3q2GqNjrxEMpYOA
	 502BZlz25ZZbwPDiiCP7NV54S5M/m/u9NhhkuTwo=
Date: Mon, 8 Jul 2024 09:18:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: tuhaowen <tuhaowen@uniontech.com>
Cc: alexander.deucher@amd.com, huangbibo@uniontech.com,
	linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com,
	wangyuli@uniontech.com
Subject: Re: [PATCH] dev/parport: fix the array out-of-bounds risk
Message-ID: <2024070820-corncob-kelp-f50c@gregkh>
References: <2024070523-singer-dweller-f1bb@gregkh>
 <20240708023330.22775-1-tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708023330.22775-1-tuhaowen@uniontech.com>

On Mon, Jul 08, 2024 at 10:33:30AM +0800, tuhaowen wrote:
> Fixed array out-of-bounds issues caused by sprintf
> by replacing it with snprintf for safer data copying,
> ensuring the destination buffer is not overflowed.
> 
> Below is the stack trace I encountered during the actual issue:
> 
> [ 66.575408s] [pid:5118,cpu4,QThread,4]Kernel panic - not syncing: stack-protector:
> Kernel stack is corrupted in: do_hardware_base_addr+0xcc/0xd0 [parport]
> [ 66.575408s] [pid:5118,cpu4,QThread,5]CPU: 4 PID: 5118 Comm:
> QThread Tainted: G S W O 5.10.97-arm64-desktop #7100.57021.2
> [ 66.575439s] [pid:5118,cpu4,QThread,6]TGID: 5087 Comm: EFileApp
> [ 66.575439s] [pid:5118,cpu4,QThread,7]Hardware name: HUAWEI HUAWEI QingYun
> PGUX-W515x-B081/SP1PANGUXM, BIOS 1.00.07 04/29/2024
> [ 66.575439s] [pid:5118,cpu4,QThread,8]Call trace:
> [ 66.575469s] [pid:5118,cpu4,QThread,9] dump_backtrace+0x0/0x1c0
> [ 66.575469s] [pid:5118,cpu4,QThread,0] show_stack+0x14/0x20
> [ 66.575469s] [pid:5118,cpu4,QThread,1] dump_stack+0xd4/0x10c
> [ 66.575500s] [pid:5118,cpu4,QThread,2] panic+0x1d8/0x3bc
> [ 66.575500s] [pid:5118,cpu4,QThread,3] __stack_chk_fail+0x2c/0x38
> [ 66.575500s] [pid:5118,cpu4,QThread,4] do_hardware_base_addr+0xcc/0xd0 [parport]
> 
> Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
> ---
>  drivers/parport/procfs.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
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

- It looks like you did not use your normal name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

