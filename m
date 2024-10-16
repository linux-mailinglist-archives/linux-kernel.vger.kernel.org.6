Return-Path: <linux-kernel+bounces-367318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685279A00D5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA5728170D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EFA18BC0B;
	Wed, 16 Oct 2024 05:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XWzBMw5A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C058A5221
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729057082; cv=none; b=locgG2XL2s6JpHzuBlxlocRbGDNgGCV4Mr2Sr+2aV8hhNGfOuJvQyHwV+FJJs6wX36j7/It/HH/fMecm9j7GytoLU3deloz4IGLNUNXpgO2j0tf4/CVgF56yIYjB1I5h7fahYn65vogklJYQctTfirSRC61ZcQ9IzPTiKIug7uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729057082; c=relaxed/simple;
	bh=XhomE7uLtzfqoa/UY3qMOT2SZfe6/gT7Ffy1EAEKZvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrWXc018xsSN3k90OruO7abjZDWsp34f32iRrHt11luryyi6VRAU3kIzL773KbIIHfFVRPtW3TCun3C5Qa3+FdJoa+tLwrMyicJ0qHD7pH1ETFgmIaITCnuvoeCjgckYJhkEEDFQx3Qchz8jHjzayEkGORIBp5nHDOhyKHW4xsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XWzBMw5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01A0C4CEC5;
	Wed, 16 Oct 2024 05:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729057082;
	bh=XhomE7uLtzfqoa/UY3qMOT2SZfe6/gT7Ffy1EAEKZvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XWzBMw5A5jc9Ps7KeWl6RMHD8zs1vALDZZI1xPqUMOJD3tn/HItUWdCphQykFvFJv
	 0uSAuSWU8c+UrJaEV/xpNyUh+b2tUJ0mMGvBt7mvAeqJK4xU0U3UfZwrlXXcvrUgBQ
	 HhsnbXdVOX2ctYWwDwlhaAG8Ya/1z9InIY+ilgtQ=
Date: Wed, 16 Oct 2024 07:37:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>, kernel@collabora.com,
	linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 2/2] driver core: Don't log intentional skip of device
 link creation as error
Message-ID: <2024101645-crushed-defection-0782@gregkh>
References: <20241015-fwdevlink-probed-no-err-v2-0-756c5e9cf55c@collabora.com>
 <20241015-fwdevlink-probed-no-err-v2-2-756c5e9cf55c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241015-fwdevlink-probed-no-err-v2-2-756c5e9cf55c@collabora.com>

On Tue, Oct 15, 2024 at 05:27:18PM -0400, Nícolas F. R. A. Prado wrote:
> Commit ac66c5bbb437 ("driver core: Allow only unprobed consumers for
> SYNC_STATE_ONLY device links") introduced an early return in
> device_link_add() to prevent useless links from being created. However
> the calling function fw_devlink_create_devlink() unconditionally prints
> an error if device_link_add() didn't create a link, even in this case
> where it is intentionally skipping the link creation.
> 
> Add a check to detect if the link wasn't created intentionally and in
> that case don't log an error.
> 
> Fixes: ac66c5bbb437 ("driver core: Allow only unprobed consumers for SYNC_STATE_ONLY device links")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/base/core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

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

