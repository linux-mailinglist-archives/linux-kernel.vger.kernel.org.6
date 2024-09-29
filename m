Return-Path: <linux-kernel+bounces-342809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A49989330
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 08:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B6CB23D42
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F131552F9B;
	Sun, 29 Sep 2024 06:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HjYfikJZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C57933985
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 06:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727589803; cv=none; b=dxhd+Bf+GbMc/ax18DRVg/un9tIblwFI14uC2PQy/wKfvTp1adQIFlMpxze67rGcFwRvUMgdvVVbj6BzjSezntKfxL4T87R17/qBXK9ynto7tno0un3KcWDzICMRXpm+vcQG2qROTzkR9keZCe2Cmmv0zfFAdlbkmr6igNe4pNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727589803; c=relaxed/simple;
	bh=fptU/tf3ymT2YXXOyY8VUkt+TUn1oikY1WV66tiihFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0FQDPQNjpzlIvKfGJWYyB2RJ31rRAOI0AwjhLm+4ZlE+Oi2CgbBew4KrqWmrkKyQl3UIL3X7yyK3ABFxtI850Gw/D9xo4HbMd4iSNuSMbMIP065ZU4b/VDblktYn+AvzYj3nvYoilM5SlC/EKMw+0NUiJM8tNNKReqruGKpBrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HjYfikJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1342DC4CEC5;
	Sun, 29 Sep 2024 06:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727589802;
	bh=fptU/tf3ymT2YXXOyY8VUkt+TUn1oikY1WV66tiihFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HjYfikJZgwpNHTcLhh4TWxtZ9dQMZRBqOpej47zST26rNLK2Al4uCt6rlFCci0pQJ
	 tGawINOTN174qMD0pgUHgQOYMld6IHBUJ3B/1vydH0Y9jdkhUe5l0ypXOhVgdhErvo
	 t2lCPVXgufLTCM2NfmtG+3Z4QRQZXaJmpXyO5NtE=
Date: Sun, 29 Sep 2024 08:03:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Charles Han <hanchunchao@inspur.com>
Cc: rlippert@google.com, joel@jms.id.au, andrew@codeconstruct.com.au,
	u.kleine-koenig@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: aspeed: Add check devm_kasprintf() returned value
Message-ID: <2024092910-mobility-waking-758f@gregkh>
References: <20240929012503.18636-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929012503.18636-1-hanchunchao@inspur.com>

On Sun, Sep 29, 2024 at 09:25:03AM +0800, Charles Han wrote:
> devm_kasprintf() can return a NULL pointer on failure in
> aspeed_lpc_enable_snoop()  but this returned value is not checked.
> 
> Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 3 +++
>  1 file changed, 3 insertions(+)

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

