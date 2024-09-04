Return-Path: <linux-kernel+bounces-315239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EADAC96BFB8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A96EB26223
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D4B1DA62E;
	Wed,  4 Sep 2024 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="syPv7Q/2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF2B1CCEFC;
	Wed,  4 Sep 2024 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458959; cv=none; b=Wou6OEj6ro9f4NmxduU+M1mrPNRrB4NLQUmVLbeBSpV2aHV+/AD0ZndyJG7nceMmgfFuqGDrlHm8avW+Va8t4yyx3tB5Ef2rN8ldIwwfIMOsusDClxuKWoIPp3dFzhyJULh7y7V3AYWhWm7RhUB1G8W40fsq2W2rIcFL1LBXI9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458959; c=relaxed/simple;
	bh=7JdnEjqz9jcNffdXfifGqMh2TR+LCih6AVd6xeSLJjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcLFgSBSSKHyHPFg8aGF+1PQdy47GPqRh7Qmp8NTfrYmUDLa5kUs2PeOIZohFPuyO12bZI4Jon5MM1gNpTzX2fEtdWVo7sakbY2FYx7rEMrzcYVmFt7jrWxK9bEvD/Gx7keVSLNSgH00MJycZGmB2dS9QxUG8VAQdK17DDnmWOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=syPv7Q/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905C3C4CEC2;
	Wed,  4 Sep 2024 14:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725458959;
	bh=7JdnEjqz9jcNffdXfifGqMh2TR+LCih6AVd6xeSLJjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=syPv7Q/2L4WttlPYC9pvSqSskeSiWDL60iIiI9qKHllZD+ZFXdc6xtZppGkXdnYph
	 Qu/csyCEGVA67T2LJfuMvEk/glrURZL7PoeM8CIvb6gI++SXNEIqlmkA1C8wL8A4ac
	 rsl2+g0npRSbGYCbVmeVjS1+4SqdfNzTsP5YOfic=
Date: Wed, 4 Sep 2024 16:09:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] USB: usbtmc: prevent kernel-infoleak
Message-ID: <2024090430-revolving-unmindful-75b7@gregkh>
References: <000000000000a338d6062149eb22@google.com>
 <tencent_088B2EF2AEE00C8AE7D706CCD2CBC6484906@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_088B2EF2AEE00C8AE7D706CCD2CBC6484906@qq.com>

On Wed, Sep 04, 2024 at 09:55:43PM +0800, Edward Adam Davis wrote:
> The syzbot reported a kernel-usb-infoleak in usbtmc_write,
> we need to clear the structure before filling fields.

Really?


> 
> Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
> Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  drivers/usb/class/usbtmc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> index 6bd9fe565385..e9ddaa9b580d 100644
> --- a/drivers/usb/class/usbtmc.c
> +++ b/drivers/usb/class/usbtmc.c
> @@ -759,6 +759,7 @@ static struct urb *usbtmc_create_urb(void)
>  		usb_free_urb(urb);
>  		return NULL;
>  	}
> +	memset(dmabuf, 0, bufsize);

To do this simpler, kzmalloc() above this would be nice.

But, this feels odd, where is the data leaking from?  This is used for
both the read and write path, but where is the leak happening?  A short
read?  If so, we need to properly truncate the buffer being sent to
userspace and not send the unread data.  If a short write, that makes no
sense.

So this needs a bit more work, please find the real issue here and don't
paper over the problem with "set it all to 0" like this.

thanks,

greg k-h

