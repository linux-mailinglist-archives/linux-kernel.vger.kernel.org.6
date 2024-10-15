Return-Path: <linux-kernel+bounces-365272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7F499DFBD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1E81F23A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4281AB525;
	Tue, 15 Oct 2024 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uSicGcjR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0AF18A6D9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978763; cv=none; b=Luz5lx5OQmEbl4wGjIc3NY4R5tqWj2lFl5iOVk/2AbPJh2Tln5RBKsohG43G4H2+MoJr8hb9bN+rbbBvSYjayWCyDIJ5HbMe1c2V2ju/NeEaAIDLdycRdfxt0k9z7pEA35IeDShmjjWMOo6Bu17Fdi7aY4d0hxO0Fh5qecOgv4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978763; c=relaxed/simple;
	bh=f6IfP+O7cjF7cgzm5+yoPGrfpsdmInWbz6qcwnUWuxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxX0LiEDDTqGGsG+bFstLHsYkGN2WZbr/C4uCQZCu84DZ4+iigM471AiAR3iKNv+BgytckVZ8p6aW1ZEjei0faaLATqKhWL30laZXN2TypsTxzB1/dEgIfMC5P4K51cNiGhzMeyrq4quqSKBw0iqqUPhoLHPztCJJ9z9T5769Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uSicGcjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0312AC4CEC7;
	Tue, 15 Oct 2024 07:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728978762;
	bh=f6IfP+O7cjF7cgzm5+yoPGrfpsdmInWbz6qcwnUWuxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSicGcjRdObzSdpiEOY4GorI9w9SJ4sImK860WiUCXAmSwhRC0jO7vPF7+dz1QIe+
	 jdENboj4HzLo4MtDzOK0NIjzXWhbkqoDY+HIFExYjinHTuKbkd3aDRp53lXxYGTg7E
	 tcZxtAGR1EP+8CrwUyYhSGnT/ssgKmO+Wc3qh148=
Date: Tue, 15 Oct 2024 09:52:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vimal Agrawal <avimalin@gmail.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, vimal.agrawal@sophos.com
Subject: Re: [PATCH v2] misc: misc_minor_alloc to use ida for all
 dynamic/misc dynamic minors
Message-ID: <2024101520-banana-agreed-4a83@gregkh>
References: <2024101416-scouring-upbeat-b658@gregkh>
 <20241015070226.15790-1-vimal.agrawal@sophos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015070226.15790-1-vimal.agrawal@sophos.com>

On Tue, Oct 15, 2024 at 07:02:26AM +0000, Vimal Agrawal wrote:
> misc_minor_alloc was allocating id using ida for minor only in case of
> MISC_DYNAMIC_MINOR but misc_minor_free was always freeing ids
> using ida_free causing a mismatch and following warn:
> > > WARNING: CPU: 0 PID: 159 at lib/idr.c:525 ida_free+0x3e0/0x41f
> > > ida_free called for id=127 which is not allocated.
> > > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> ...
> > > [<60941eb4>] ida_free+0x3e0/0x41f
> > > [<605ac993>] misc_minor_free+0x3e/0xbc
> > > [<605acb82>] misc_deregister+0x171/0x1b3
> 
> misc_minor_alloc is changed to allocate id from ida for all minors
> falling in the range of dynamic/ misc dynamic minors
> 
> Fixes: 0ad35fed618c ("char: misc: Increase the maximum number of dynamic misc devices to 1048448")
> Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
> ---
>  drivers/char/misc.c   | 35 +++++++++++++++++-----
>  lib/Kconfig.debug     | 11 +++++++
>  lib/Makefile          |  1 +
>  lib/test_misc_minor.c | 67 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 107 insertions(+), 7 deletions(-)
>  create mode 100644 lib/test_misc_minor.c
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

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

