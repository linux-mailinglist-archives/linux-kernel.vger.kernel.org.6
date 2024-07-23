Return-Path: <linux-kernel+bounces-260036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E1A93A1DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03AF4283E83
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B059F15359A;
	Tue, 23 Jul 2024 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HlXjeGP1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F9D14D6EE;
	Tue, 23 Jul 2024 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742289; cv=none; b=PcQnEf73jYJltZBcUF78JtkIlh5Dt4zicGXA/FAXojaxLcakDHeYq6kkyD2NdOpdzUbDlJrPUShboea2ruJAj1WeEgGscMBtGsJVeev+zQ3Kfwhw4ixiOO18HnX41eTYbRr9YY9TYGgOC4T/CFwu3Z0FVkm8Njc89EwestuYGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742289; c=relaxed/simple;
	bh=1l39LxJ0o9ueMh/5BoWtbV5B1HGV2nlUkhGauphkz5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVG1PnhNFcGCQUnwkCcAMPKnK8u4V24H4TlcQD8rw75mRXJB6HSUTXyIC/2LlhJOGY9JdCDODO6Zns6J2ktvi3M+4Ntg1QVAMQKUvDG8fJtz5dgwHAiI5a4/kncTjbKU9adpbJEQ+6GPMBDipwpJUUQmptEeHMX7S1oK4vs161E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HlXjeGP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145D2C4AF0A;
	Tue, 23 Jul 2024 13:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721742288;
	bh=1l39LxJ0o9ueMh/5BoWtbV5B1HGV2nlUkhGauphkz5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HlXjeGP14hG7imPL1cjrd2654qMBJvuf/slNtB0Q1LQsw3MGftnNYIfAZjdr8wvBo
	 e8zuOiFQjkcZRqiu/Z2t8F8wy8aUYgPx78mkYTzAQ4SspCMaXclhUEhRnG+Ogcel3S
	 nkGJ5jadQq8ZH0DoACqsl5T6mZ1kva6f+Lx6Hwko=
Date: Tue, 23 Jul 2024 15:44:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: heikki.krogerus@linux.intel.com, dmitry.baryshkov@linaro.org,
	bleung@chromium.org, utkarsh.h.patel@intel.com,
	abhishekpandit@chromium.org, kyletso@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix NULL pointer dereference in
 ucsi_displayport_vdm()
Message-ID: <2024072333-popcorn-detached-f399@gregkh>
References: <20240723133230.1325392-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723133230.1325392-1-make24@iscas.ac.cn>

On Tue, Jul 23, 2024 at 09:32:30PM +0800, Ma Ke wrote:
> When dp->con->partner is an error, a NULL pointer dereference may occur.
> Add a check for dp->con->partner to avoid dereferencing a NULL pointer.
> 
> Fixes: 372adf075a43 ("usb: typec: ucsi: Determine common SVDM Version")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/usb/typec/ucsi/displayport.c | 2 ++
>  1 file changed, 2 insertions(+)

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

