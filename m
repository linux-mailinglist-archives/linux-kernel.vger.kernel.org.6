Return-Path: <linux-kernel+bounces-331684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CDB97AFFA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8CE5B23350
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C1A16C696;
	Tue, 17 Sep 2024 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hLns+buI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8731514831C;
	Tue, 17 Sep 2024 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726574994; cv=none; b=sc6qc0INuRWDTpseNf0J0spd738XtY3DaQuezJpl2GIUKr6ZKlwAwZO2BEqUhF8K3fIxc0KB+pcjxBQQRg+krdDzjCwiFzMaX/rne4ZrwQGMGRW3C+jVmZzSp6+S3quTofLzvtmW0Cur0VSUxRX71IrguoEtFzSMcc8lx8u9pUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726574994; c=relaxed/simple;
	bh=QV3P/Kc85ci91UAQat3NFkOXriWFY3fMtlpURWGPxdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5oZnTixVU10OJs1R+if0sL8nJTjPCVZeUgwcVAP/dUhfn7KcH0/kyxhKxtAQTgwzY12nAXHhFiRxIYCgETYD4hUtduBSrt12isKzSy7TT54HjQnyFRA/E6RLhJKL1HVawMlGwfx+UFtxNs8hWyk9M42ITc4G7ijz8YzsHRjeBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hLns+buI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D3DC4CEC5;
	Tue, 17 Sep 2024 12:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726574994;
	bh=QV3P/Kc85ci91UAQat3NFkOXriWFY3fMtlpURWGPxdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLns+buIHGTBeTuUl2ZahOi1CLusjFI9D0ICyRBRR/G/ffQd2v5lW6Lm04lMZhOd0
	 NXEaI1O/CFlJitQGuSiqyeCw7KkZyEHf1qAXYRaytX/fLUmuIPpmfXd88Q7ju2t3jv
	 IkSRy8FBi6FYg3a3lQlByVNaUq2UxgRc8RYs6FAA=
Date: Tue, 17 Sep 2024 14:09:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
Cc: Ferry Toth <ftoth@exalondelft.nl>, Kees Cook <kees@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Richard Acayan <mailingradian@gmail.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Hardik Gajjar <hgajjar@de.adit-jv.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: u_ether: Use __netif_rx() in
 rx_callback()
Message-ID: <2024091735-spoiled-apache-6ca1@gregkh>
References: <10019b141275f7fa3e2446e207e7a9afaaa98b3d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10019b141275f7fa3e2446e207e7a9afaaa98b3d.camel@gmail.com>

On Tue, Sep 17, 2024 at 01:19:25PM +0200, Hubert Wiśniewski wrote:
> netif_rx() now disables bottom halves, which causes the USB gadget to be
> unable to receive frames if the interface is not brought up quickly enough
> after being created by the driver (a bug confirmed on AM3352 SoC).
> 
> Replacing netif_rx() with __netif_rx() restores the old behavior and fixes
> the bug. This can be done since rx_callback() is called from the interrupt
> context.
> 
> Fixes: baebdf48c360 ("net: dev: Makes sure netif_rx() can be invoked in any context.")
> Signed-off-by: Hubert Wiśniewski <hubert.wisniewski.25632@gmail.com>
> ---
> v1 -> v2: Added Fixes tag and corrected Signed-off-by tag
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

