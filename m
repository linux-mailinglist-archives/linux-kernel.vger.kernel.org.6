Return-Path: <linux-kernel+bounces-194105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 722EB8D36AA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB191C21EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2E65235;
	Wed, 29 May 2024 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j25nFlDM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3FE3FEC
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986841; cv=none; b=MbIAWNixyu3eEJ91Ra+8Cjt2ILwbNyBvCcKWVDXJ6PP/g1T3u8zOnaauHuXijuYBiztntBwXC4s94k7Ubahm2QUTKsdTBlmvhcDQvGIHP613H4oAEeQXz5C1fw3yQQKFGfuCBI7SquFzcDlkzw88Tent8hLvXzOsWU2h4xWXgts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986841; c=relaxed/simple;
	bh=CGsvgngsO6XpqFwvG62HUsZhvb7vNNqlKSMluceXanY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kK+amarqmAgsRXPatloGNaKMEm7ZGh5njohYYluMXs6GLQXoJ2HZr1Vw7gZw6ZcGU8cdeJ7BJc3C4v8DfCsIrIFSCva8xlUCOm/W3a0xB3mJAOAhtuEZOr8rjnEk+66A/I95QB3n/+Bxu2p4Y3XZgbsE01zeEoaplHe34lLOXNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j25nFlDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31897C2BD10;
	Wed, 29 May 2024 12:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716986840;
	bh=CGsvgngsO6XpqFwvG62HUsZhvb7vNNqlKSMluceXanY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j25nFlDMMyGsKJFK0VsonPOJR7N2lc/4KRmtQgdjOyD+DZXgpuwSMk1693qr1FET1
	 6RjT3qGDVw8UFNORjP0zzwiDrVpiNVH/C/gVRf6uh0kBLQyu8MT2Zz7NWqFQCMwHLA
	 0yZt+Nw00ZVKtlTS40HuvxI+Hg0wzNTB2cL0fvrM=
Date: Wed, 29 May 2024 14:47:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Soumya Khasnis <soumya.khasnis@sony.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org, festevam@denx.de, lee@kernel.org,
	benjamin.bara@skidata.com, dmitry.osipenko@collabora.com,
	ldmldm05@gmail.com, srinavasa.nagaraju@sony.com,
	Madhusudan.Bobbili@sony.com, shingo.takeuchi@sony.com,
	keita.aihara@sony.com, masaya.takahashi@sony.com
Subject: Re: [PATCH v2] reboot: Add timeout for device shutdown
Message-ID: <2024052910-feminism-lantern-27f2@gregkh>
References: <20240529110049.GA73111@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529110049.GA73111@sony.com>

On Wed, May 29, 2024 at 11:00:49AM +0000, Soumya Khasnis wrote:
> The device shutdown callbacks invoked during shutdown/reboot
> are prone to errors depending on the device state or mishandling
> by one or more driver. In order to prevent a device hang in such
> scenarios, we bail out after a timeout while dumping a meaningful
> call trace of the shutdown callback which blocks the shutdown or
> reboot process.
> 
> Signed-off-by: Soumya Khasnis <soumya.khasnis@sony.com>
> Signed-off-by: Srinavasa Nagaraju <Srinavasa.Nagaraju@sony.com>
> ---
>  drivers/base/Kconfig | 15 +++++++++++++++
>  kernel/reboot.c      | 46 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 60 insertions(+), 1 deletion(-)
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

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

