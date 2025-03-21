Return-Path: <linux-kernel+bounces-570711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E60FA6B3CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29C23ADD30
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4691DFD95;
	Fri, 21 Mar 2025 04:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZYjfxA19"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D94B29CE6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742532374; cv=none; b=gBBdd++L3TokZ9eUufVplzE+HCI1CzTUGGT3JiVz7ieW1a5oQMD+Ns0vh9B83rkQsjPD/YSJpEajA+LZ1nPIZ2WEG9Ailmza1Qcr6e35SyTcc0+OoIbN+exUIneRiBtxRFF1FR0zOzs7vvyxqb4gmRarAVyukGz9brsfPUZeYQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742532374; c=relaxed/simple;
	bh=yvL5kKnUqr+x35yQfVJfg8HpB2muzewzcEsOdC0WCkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bvoshdu/bVVzchEraLY4+AbZNNtXlX4u5I5Uk4Jt7rDgzltz2T1vUB1wrFdajwlgQRn3Hcmzp2XNSfgrbGLGA4UBeCjQDUa2hJJNkm8+UJo+XbljLwcYiCcCOmR8nz9XvYSpLoiJURS/XiioEGjFZJZEaHkWMq6mnQcvGrxuvpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZYjfxA19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B45C4CEE8;
	Fri, 21 Mar 2025 04:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742532374;
	bh=yvL5kKnUqr+x35yQfVJfg8HpB2muzewzcEsOdC0WCkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZYjfxA19JT9SuLKI2+te8ONjvra/EsWsp6z/gfcmo1+joqZKW++ZDM6OMaBrPrlj1
	 s26kc3XWSTNby/uXoZS5q1PHLsqT031BJLa2H8VjLU1PJp9cbXhCgTvJCyra5ijAGD
	 JLV8cK8MWhaAhAc0MlYKBbcKPRw3NuwaXMn+/gDQ=
Date: Thu, 20 Mar 2025 21:44:54 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] char: misc: Use __register_chrdev() to register the
 actual minor counts
Message-ID: <2025032054-stylus-chemist-1cd4@gregkh>
References: <b63b7981191777a6d175cfa98379e987281b9e3a.1742528326.git.houwenlong.hwl@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b63b7981191777a6d175cfa98379e987281b9e3a.1742528326.git.houwenlong.hwl@antgroup.com>

On Fri, Mar 21, 2025 at 11:54:42AM +0800, Hou Wenlong wrote:
> In commit ab760791c0cf ("char: misc: Increase the maximum number of
> dynamic misc devices to 1048448"), the minor number of misc char device
> is increased to MINORMASK + 1. However, it still uses register_chrdev(),
> which defaults to registering the misc char device with only 256 minor
> numbers.  Therefore, when a misc device is given a minor number greater
> than 255, the device file fails to open in kobj_lookup(). As a solution,
> use __register_chrdev() to register the actual minor counts to
> accommodate this increase.
> 
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> ---
> In our environment, the per-cpu coresight_tmc driver occupies too many
> minor numbers, which ultimately allocates minor number 256 for our misc
> device, resulting in a failure to open the device file in /dev. I'm not
> sure if this is a bug or if userspace can only use fewer than 256 minor
> numbers. Therefore, I didn't add a fix tag here.
> ---
>  drivers/char/misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index f7dd455dd0dd..dda466f9181a 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -315,7 +315,7 @@ static int __init misc_init(void)
>  		goto fail_remove;
>  
>  	err = -EIO;
> -	if (register_chrdev(MISC_MAJOR, "misc", &misc_fops))
> +	if (__register_chrdev(MISC_MAJOR, 0, MINORMASK + 1, "misc", &misc_fops))
>  		goto fail_printk;
>  	return 0;
>  
> -- 
> 2.31.1
> 

I think this is the same change as this one:
	https://lore.kernel.org/r/20250317-misc-chrdev-v1-1-6cd05da11aef@igalia.com

right?

If so, can you provide a reviewed-by or tested-by on that one?  I
haven't picked it up yet, sorry.

greg k-h

