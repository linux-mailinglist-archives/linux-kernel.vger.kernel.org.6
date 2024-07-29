Return-Path: <linux-kernel+bounces-265453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2765B93F16C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63CA2860CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A78413E032;
	Mon, 29 Jul 2024 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kCFkqE04"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03E801
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246224; cv=none; b=twea9dYSzQpKyzli/bFW0KjTYbuYvm9H7jvH8RueNPcAUxV2ZJJjUjhIcDk0DlZ2v0GDAFDCo18Dx5Hbw3188rmv5UMwHv83PnBzvw8RzocQ1zVdkl/QhZpfMXH56++jkNI5+g+yT3afi1HgphSnuVOStOUCD4AkRh6UMrDxKl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246224; c=relaxed/simple;
	bh=ryEzVnQFvfqOhieYvRA5tK3bFY3Svo+bQH8bqVu3Ffg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrU6WAeDS85isX/K0nhGEgFxWnVJemLje2lUIL+jb9hbI8K3y714nEMITKhSr7u69E9yBkG0oFEwwvzU3JCsuVLwX2C+4ceZMGMTxCJGCHGXpDbz4imOUAAtDJtjp2nblCwMzNt4zsGUNdzY90evT04TpSfAbzwtMm0NZQSL3j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kCFkqE04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0E7C32786;
	Mon, 29 Jul 2024 09:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722246223;
	bh=ryEzVnQFvfqOhieYvRA5tK3bFY3Svo+bQH8bqVu3Ffg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCFkqE04EBjsQef7OLfNUa17XR24S6JeDB56vsB0Lbl8I9lmIVvrnXvv0RWCvSUs3
	 uGdWP0dSNC8eXJUXtqoxGBygf9h7ygj6ubOqWrfB89GXCbol/DDZyMjnEEBmrgYXCB
	 6mlP3051YTHgynn77b00arvHFOooeKVWcyuUJmTE=
Date: Mon, 29 Jul 2024 11:43:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] char: misc: add missing #ifdef CONFIG_PROC_FS and error
 checking
Message-ID: <2024072951-lyrically-running-d1e3@gregkh>
References: <20240729073511.61935-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729073511.61935-1-zhangjiao2@cmss.chinamobile.com>

On Mon, Jul 29, 2024 at 03:35:11PM +0800, zhangjiao2 wrote:
> From: Zhang Jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Add "#ifdef CONFIG_PROC_FS" to control misc proc create 
> and give some error checking.
> 
> Signed-off-by: Zhang Jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  drivers/char/misc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index 541edc26ec89..0370d53f368a 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -286,9 +286,15 @@ EXPORT_SYMBOL(misc_deregister);
>  static int __init misc_init(void)
>  {
>  	int err;
> +#ifdef CONFIG_PROC_FS

We should almost never have #ifdef in .c files, please don't do that
here either.

Also, why is this suddenly a new issue?

And, when you have "and" in a changelog text, that's a huge hint you
need to split things up into multiple patches, please do that here.

thanks,

greg k-h

