Return-Path: <linux-kernel+bounces-403111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8589C3124
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 08:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 218A6B21126
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 07:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227CA14B086;
	Sun, 10 Nov 2024 07:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uNvWEnm+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8013718E1F;
	Sun, 10 Nov 2024 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731222453; cv=none; b=Bn1DUvu4b6MQDz602YhWsm7sJbU5Zb/4FEHUgDF1hB7S1h0S//4eBfv6p1x80o8qJeRGfgHha1mQEuZsteOlYN0n5yifl4AWQ0uCTAwiSZ/dkoaeOT/nxEAIcGaMn9P3XAn44wICGZHmnEf/Zq6IN2YdvVoyIQY6t/bc8IzHSFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731222453; c=relaxed/simple;
	bh=AGsQhcIYyn6qFKQgPNuyLutTb3+GyKVynxcZrJxOePw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2zkwhXdx5qsdDAxGq/Xq3uNIu8neA00TfpWR4JdP4DPXU2Sb8RrH++BUlb7mVQKmP8ZklTWrLIRQL/4MZlZpbmag/cJD7vb3piZ8JzsqdlG5yb+turaW3fJdZEol/F6NHyKBAdpP3SJqgxoN8Lq7iMliaeoaBGLo2SU5BO9d6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uNvWEnm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D77C4CECD;
	Sun, 10 Nov 2024 07:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731222453;
	bh=AGsQhcIYyn6qFKQgPNuyLutTb3+GyKVynxcZrJxOePw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNvWEnm+ixID3Nq+dN+6nsnz2UoCtaYWnmOrADJrjIoArCtW/OdM5jUkmjJ6zPrPn
	 /EAnGpM4yQsAKtP6sqGbm4rmd4SAdVlI73MEthj/uupknOkiQ+Sm4nD6Uh7v4pzIxq
	 er18CKABu1e+snjmZ7QMoSlvI+A/myymDR7S62QQ=
Date: Sun, 10 Nov 2024 08:07:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, oneukum@suse.com
Subject: Re: [PATCH] usb/cdc-wdm: fix memory leak of wdm_device
Message-ID: <2024111053-henchman-unsecured-cd6f@gregkh>
References: <000000000000e875fa0620253803@google.com>
 <20241109152821.3476218-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109152821.3476218-1-snovitoll@gmail.com>

On Sat, Nov 09, 2024 at 08:28:21PM +0500, Sabyrzhan Tasbolatov wrote:
> syzbot reported "KMSAN: kernel-infoleak in wdm_read", though there is no
> reproducer and the only report for this issue. This might be
> a false-positive, but while the reading the code, it seems,
> there is the way to leak kernel memory.

Nit, the subject should say "memory info leak" as traditionally "memory
leak" means that we loose memory, not expose random stuff to userspace
:)

> Here what I understand so far from the report happening
> with ubuf in drivers/usb/class/cdc-wdm.c:
> 
> 1. kernel buffer "ubuf" is allocated during cdc-wdm device creation in
>    the "struct wdm_device":
> 
> 	static int wdm_create()
> 	{
> 	   ...
> 	   desc->ubuf = kmalloc(desc->wMaxCommand, GFP_KERNEL);
> 	   ...
> 	   usb_fill_control_urb(
> 	      ...
> 	      wdm_in_callback,
> 	      ...
> 	   );
> 	
> 	}
> 
> 2. during wdm_create() it calls wdm_in_callback() which MAY fill "ubuf"
>    for the first time via memmove if conditions are met.
> 
> 	static void wdm_in_callback()
> 	{
> 	   ...
> 	   if (length + desc->length > desc->wMaxCommand) {
> 	     ...
> 	} else {
> 	   /* we may already be in overflow */
> 	   if (!test_bit(WDM_OVERFLOW, &desc->flags)) {
> 	      memmove(desc->ubuf + desc->length, desc->inbuf, length);
> 	      desc->length += length;
> 	      desc->reslength = length;
> 	   }
> 	}
> 	   ...
> 	}
> 
> 3. if conditions are not fulfilled in step 2., then calling read() syscall
>    which calls wdm_read(), should leak the random kernel memory via
>    copy_to_user() from "ubuf" buffer which is allocated in kmalloc-256.
> 
> 	static ssize_t wdm_read()
> 	{
> 	    ...
> 	    struct wdm_device *desc = file->private_data;
> 	    cntr = READ_ONCE(desc->length);
> 	    ...
> 	    if (cntr > count)
> 	        cntr = count;
> 	    rv = copy_to_user(buffer, desc->ubuf, cntr);
> 	   ...
> 	}
> 	
> 	, where wMaxCommand is 256, AFAIU.
> 
> syzbot report
> =============
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
> BUG: KMSAN: kernel-infoleak in _inline_copy_to_user include/linux/uaccess.h:180 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:26
>  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>  _inline_copy_to_user include/linux/uaccess.h:180 [inline]
>  _copy_to_user+0xbc/0x110 lib/usercopy.c:26
>  copy_to_user include/linux/uaccess.h:209 [inline]
>  wdm_read+0x227/0x1270 drivers/usb/class/cdc-wdm.c:603
>  vfs_read+0x2a1/0xf60 fs/read_write.c:474
>  ksys_read+0x20f/0x4c0 fs/read_write.c:619
>  __do_sys_read fs/read_write.c:629 [inline]
>  __se_sys_read fs/read_write.c:627 [inline]
>  __x64_sys_read+0x93/0xe0 fs/read_write.c:627
>  x64_sys_call+0x3055/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:1
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Reported-by: syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9760fbbd535cee131f81
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>  drivers/usb/class/cdc-wdm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
> index 86ee39db013f..8801e03196de 100644
> --- a/drivers/usb/class/cdc-wdm.c
> +++ b/drivers/usb/class/cdc-wdm.c
> @@ -1063,7 +1063,7 @@ static int wdm_create(struct usb_interface *intf, struct usb_endpoint_descriptor
>  	if (!desc->command)
>  		goto err;
>  
> -	desc->ubuf = kmalloc(desc->wMaxCommand, GFP_KERNEL);
> +	desc->ubuf = kzalloc(desc->wMaxCommand, GFP_KERNEL);

Seems good, but can you put a comment above this saying "need to zero
this out because it could expose data to userspace"

thanks,

greg k-h

