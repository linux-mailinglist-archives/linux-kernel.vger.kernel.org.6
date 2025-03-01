Return-Path: <linux-kernel+bounces-539833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49108A4A988
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 08:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DCE3BC537
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 07:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF881CAA6E;
	Sat,  1 Mar 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wJNwQGSF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EC61C3BF1
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740814530; cv=none; b=cqQuTShgc7zDmC/dwCLrjWLSUrNb5u6m2TSHA3PydUaFOZBARSuHclkpmYG4Xb4T6pdiAanGyUXa8PvLrnS395BfmjqpwSETnQKUJ7V20VXk/OD5njqMHUi6bT1DUEZjYGEUcFSyaUVgsKGr6dwQ6YzBabtT+W5oK6DxmryYLEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740814530; c=relaxed/simple;
	bh=9hpsEQ7G4PRVP1gknqhPbi2HNgsf+ElUy1LMJ4F0Xnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSGpnWP2C2beOFPSAxQu4aoKSBvmZZOJ/Zj4Omnib6KaaE9/K2F0D+Kl1MeIOnzVq2Pgqw7aPewfnUeoYWkgbbBcuow27jRBFx3DuMKco0Mesxj+X1hDCeszXGH//tfqaukfm41FlxXZAVxODFJ7bfr5G7WQD12GmxFrab0FBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wJNwQGSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7B5C4CEDD;
	Sat,  1 Mar 2025 07:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740814529;
	bh=9hpsEQ7G4PRVP1gknqhPbi2HNgsf+ElUy1LMJ4F0Xnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wJNwQGSFopo2AMSXcM83b7X9gbVX2k5kthIt8mz1n1WpQJdLmbqLYj0ucltmzjuZu
	 ydEHEMtmBdJYaCUxHXMDDAS7ll4IeGqLinCgaDRGe1rJ6SOuAUe1a4kdUbajb3522n
	 ohDZfFO5QPewhAKh6N4GQDap7qbgUdGvMNzW1hmc=
Date: Fri, 28 Feb 2025 23:34:16 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Cc: ayaanmirza85@gmail.com, dakr@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers/base: fix iterator cleanup in
 attribute_container_find_class_device (v2)
Message-ID: <2025022819-pushing-virtual-9b85@gregkh>
References: <2025022606-carrousel-unstable-f2f3@gregkh>
 <20250227124417.132020-4-ayaanmirzabaig85@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227124417.132020-4-ayaanmirzabaig85@gmail.com>

On Thu, Feb 27, 2025 at 06:11:29PM +0530, Ayaan Mirza Baig wrote:
> This patch fixes a long-standing FIXME by refactoring
> the function to ensure klist_iter_exit() is always
> invoked once via a unified cleanup path
> 
> The patch has been tested thoroughly with a minimal
> Debain System and scsi devices and GDB.
> 
> Tested-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
> Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>

No need to duplicate this here, if you sign-off it's implicit that you
tested it :)

> ---
>  drivers/base/attribute_container.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/attribute_container.c b/drivers/base/attribute_container.c
> index 69637b2ec3bc..fbf7fd45651e 100644
> --- a/drivers/base/attribute_container.c
> +++ b/drivers/base/attribute_container.c
> @@ -492,12 +492,11 @@ attribute_container_find_class_device(struct attribute_container *cont,
>  	klist_for_each_entry(ic, &cont->containers, node, &iter) {
>  		if (ic->classdev.parent == dev) {
>  			cdev = &ic->classdev;
> -			/* FIXME: must exit iterator then break */
> -			klist_iter_exit(&iter);
> -			break;
> +			goto out;
>  		}
>  	}
> -
> +out:
> +	klist_iter_exit(&iter);

Are you sure this actually does something different?  Why is the FIXME
there and why does this "simple" change solve the issue?  I don't
understand how this change resolves the problem.

In other words, you're going to have to document this a lot better in
the changelog message please.

thanks,

greg k-h

