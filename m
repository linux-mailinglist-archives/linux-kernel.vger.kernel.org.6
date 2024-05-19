Return-Path: <linux-kernel+bounces-183133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE9B8C950E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 16:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D04D1C21250
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 14:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755A74CE1F;
	Sun, 19 May 2024 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EMmbQOEv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBD44DA04;
	Sun, 19 May 2024 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716129477; cv=none; b=unWMQ/n5zDMLm+KUHvmCkpK2+YvRbvF2hWxwm8exVwRwarDKKipuKTIyk14Do8/sLfgJ+ALdHBUjbj+bVVrX625xPF4t+JtzXLdWIMXAHHMOVYM9indcQHI0/Xykal4wxgDzzym4VtSEJEGZddXVBMvLo3ygoVlhQNFmF09DikI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716129477; c=relaxed/simple;
	bh=AGcBlp/L0UCiDEm9xU4FkF8tyQP1W/SpJauzpAkP8h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKm+gs82nK1/rEM+btusF7JKPlrR9rKr4e1yQ8st/qvif92JXOqFym3YrongC8koCpmj4OXlMH9Vj6Mg39jh/y/Hv0fYafLu7KPrWFZTSKzZ34VNqSmBAECGBkPHnsrVlz4XtTVWlb0VyUcXNhfjeNOKdHY33QZVikvHSyn1LiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EMmbQOEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC45C32781;
	Sun, 19 May 2024 14:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716129477;
	bh=AGcBlp/L0UCiDEm9xU4FkF8tyQP1W/SpJauzpAkP8h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMmbQOEvlvD8tg/XNAUE1vqmVbIV9Ny5B5OYx+XdaR5xCATfXTZIkqBZAqdASNYb8
	 hTxSmORhhPeNQ8i7WAseJZ9KBJujD4lDbFOsV28rkF23navHVpnB5nWivqhTYg7tRg
	 ez6/mNEVq4d3oAeGZ3THqyF/ZfaxfroSq+ZCL288=
Date: Sun, 19 May 2024 16:37:54 +0200
From: gregkh <gregkh@linuxfoundation.org>
To: "nanfengwq@sina.com" <nanfengwq@sina.com>
Cc: balbi <balbi@kernel.org>, linux-usb <linux-usb@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: memory leakage in ncm_wrap_ntb() in USB ncm mode with kernel 5.15
Message-ID: <2024051901-gimmick-cosponsor-f2dd@gregkh>
References: <2024051922230825069112@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024051922230825069112@sina.com>

On Sun, May 19, 2024 at 10:23:10PM +0800, nanfengwq@sina.com wrote:
> Hello：
> I have discovered a risk of memory leakage in ncm_wrap_ntb() under USB ncm mode in kernel 5.15, and I have fixed it. 
> Please help me review it.
> 
> If this modification is effective, it can also be integrated into other kernel versions, such as kernel 4.14, and so on.
> 
> The logic of a memory leak is as follows:
> 
> If the return value skb2 of  package_for_tx() is not NULL, and the return value ncm->skb_tx_data of alloc_skb() is NULL, then the code will go to err, where there is no processing of skb2, resulting in a memory leak in skb2.
> 
> 
> Thank you.
> 
> 
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

- Your patch did not apply to any known trees that Greg is in control
  of.  Possibly this is because you made it against Linus's tree, not
  the linux-next tree, which is where all of the development for the
  next version of the kernel is at.  Please refresh your patch against
  the linux-next tree, or even better yet, the development tree
  specified in the MAINTAINERS file for the subsystem you are submitting
  a patch for, and resend it.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

