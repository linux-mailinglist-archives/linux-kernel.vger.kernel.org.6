Return-Path: <linux-kernel+bounces-522970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB54A3D0AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B6A7A7CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9E5135A53;
	Thu, 20 Feb 2025 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dnM1pVUL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6282A926
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740028547; cv=none; b=klIBFlZzGCLd1fb443nZwaxJ5Gr7nN78WY3pjihqmlA7ZyUlgC1U9aHFKozUkJ4FVGXqu14ZeqDGPRQg/VIPsm+1ghc61eINI3/wwVZMroep73r8Wllv1ohAdxX/XsfM7BE1dda69VtZemAjfgGYrRu/0m2Zz5RF8XOAA/mcgv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740028547; c=relaxed/simple;
	bh=z6OQLCwSz74DcqGkO0SWBMx6PfvKVCch9zyW5SEe+54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vB+ImVA0qbKfJttB6sDvbJ+GzVXTSgPyR1HgYgpwFwNhOfCZMVOvVxjsS41I+jJaXpTc25rRlRrTS0Kr5+hRHHbNtnnyg/kgkFPBq1AhMQCj9t62pj4EtfDuL/40UDprnOi3riE8vDujszj51OS2jVHWwOvQQm0Kv/2e6Ry/IDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dnM1pVUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC18C4CED1;
	Thu, 20 Feb 2025 05:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740028547;
	bh=z6OQLCwSz74DcqGkO0SWBMx6PfvKVCch9zyW5SEe+54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnM1pVUL+EJ9FcfVN+ZVd+3u6HE23zfwsRNgQ1KIc3mePvEtAC903ypuC9CBjh1f1
	 2ziOl1sQgAZSYvzQk9w+vH7+fQ/1irljKWh5OrdoOgzUmziQLdvbwJNGr1oqxgSR60
	 7t0kgWRg2BAkId4c1t2RsCiE+SJHDvzl7CuqP4WA=
Date: Thu, 20 Feb 2025 06:15:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Suraj Patil <surajpatil522@gmail.com>
Cc: linux-kernel@vger.kernel.org, jirislaby@kernel.org
Subject: Re: [PATCH] tty: ipwireless: Fix locking in ioctl and write_room
 functions
Message-ID: <2025022013-create-enamel-02c8@gregkh>
References: <20250219192426.164654-1-surajpatil522@gmail.com>
 <20250219192426.164654-3-surajpatil522@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219192426.164654-3-surajpatil522@gmail.com>

On Wed, Feb 19, 2025 at 07:24:26PM +0000, Suraj Patil wrote:
> - Add mutex locks around tty->ipw_tty_mutex in ioctl, tiocmget, and write_room.
> - Resolve FIXME comments related to locking ambiguity.
> 
> Signed-off-by: Suraj Patil <surajpatil522@gmail.com>
> ---
>  drivers/tty/ipwireless/tty.c | 178 ++++++++++++++++++++---------------
>  1 file changed, 100 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
> index b6de40815fb9..c4befc3d09f9 100644
> --- a/drivers/tty/ipwireless/tty.c
> +++ b/drivers/tty/ipwireless/tty.c
> @@ -229,21 +229,21 @@ static ssize_t ipw_write(struct tty_struct *linux_tty, const u8 *buf,
>  
>  static unsigned int ipw_write_room(struct tty_struct *linux_tty)
>  {
> -	struct ipw_tty *tty = linux_tty->driver_data;
> -	int room;
> +    struct ipw_tty *tty = linux_tty->driver_data;
> +    int room = 0;
>  
> -	/* FIXME: Exactly how is the tty object locked here .. */
> -	if (!tty)
> -		return 0;
> +    if (!tty)
> +        return 0;
>  
> -	if (!tty->port.count)
> -		return 0;
> -
> -	room = IPWIRELESS_TX_QUEUE_SIZE - tty->tx_bytes_queued;
> -	if (room < 0)
> -		room = 0;
> +    mutex_lock(&tty->ipw_tty_mutex); // Lock added
> +    if (!tty->port.count) {
> +        mutex_unlock(&tty->ipw_tty_mutex);
> +        return 0;
> +    }
>  
> -	return room;
> +    room = IPWIRELESS_TX_QUEUE_SIZE - tty->tx_bytes_queued;
> +    mutex_unlock(&tty->ipw_tty_mutex); // Unlock added
> +    return room < 0 ? 0 : room;
>  }
>  
>  static int ipwireless_get_serial_info(struct tty_struct *linux_tty,
> @@ -351,85 +351,107 @@ static int set_control_lines(struct ipw_tty *tty, unsigned int set,
>  
>  static int ipw_tiocmget(struct tty_struct *linux_tty)
>  {
> -	struct ipw_tty *tty = linux_tty->driver_data;
> -	/* FIXME: Exactly how is the tty object locked here .. */
> +    struct ipw_tty *tty = linux_tty->driver_data;
> +    int ret;
>  
> -	if (!tty)
> -		return -ENODEV;
> +    if (!tty)
> +        return -ENODEV;
>  
> -	if (!tty->port.count)
> -		return -EINVAL;
> +    mutex_lock(&tty->ipw_tty_mutex); // Lock added
> +    if (!tty->port.count) {
> +        mutex_unlock(&tty->ipw_tty_mutex);
> +        return -EINVAL;
> +    }
>  
> -	return get_control_lines(tty);
> +    ret = get_control_lines(tty);
> +    mutex_unlock(&tty->ipw_tty_mutex); // Unlock added
> +    return ret;
>  }
>  
> -static int
> -ipw_tiocmset(struct tty_struct *linux_tty,
> -	     unsigned int set, unsigned int clear)
> +static int ipw_tiocmset(struct tty_struct *linux_tty,
> +             unsigned int set, unsigned int clear)
>  {
> -	struct ipw_tty *tty = linux_tty->driver_data;
> -	/* FIXME: Exactly how is the tty object locked here .. */
> +    struct ipw_tty *tty = linux_tty->driver_data;
> +    int ret;
>  
> -	if (!tty)
> -		return -ENODEV;
> +    if (!tty)
> +        return -ENODEV;
>  
> -	if (!tty->port.count)
> -		return -EINVAL;
> +    mutex_lock(&tty->ipw_tty_mutex); // Lock added
> +    if (!tty->port.count) {
> +        mutex_unlock(&tty->ipw_tty_mutex);
> +        return -EINVAL;
> +    }
>  
> -	return set_control_lines(tty, set, clear);
> +    ret = set_control_lines(tty, set, clear);
> +    mutex_unlock(&tty->ipw_tty_mutex); // Unlock added
> +    return ret;
>  }
>  
>  static int ipw_ioctl(struct tty_struct *linux_tty,
> -		     unsigned int cmd, unsigned long arg)
> +                     unsigned int cmd, unsigned long arg)
>  {
> -	struct ipw_tty *tty = linux_tty->driver_data;
> -
> -	if (!tty)
> -		return -ENODEV;
> -
> -	if (!tty->port.count)
> -		return -EINVAL;
> -
> -	/* FIXME: Exactly how is the tty object locked here .. */
> -	if (tty->tty_type == TTYTYPE_MODEM) {
> -		switch (cmd) {
> -		case PPPIOCGCHAN:
> -			{
> -				int chan = ipwireless_ppp_channel_index(
> -							tty->network);
> -
> -				if (chan < 0)
> -					return -ENODEV;
> -				if (put_user(chan, (int __user *) arg))
> -					return -EFAULT;
> -			}
> -			return 0;
> -
> -		case PPPIOCGUNIT:
> -			{
> -				int unit = ipwireless_ppp_unit_number(
> -						tty->network);
> -
> -				if (unit < 0)
> -					return -ENODEV;
> -				if (put_user(unit, (int __user *) arg))
> -					return -EFAULT;
> -			}
> -			return 0;
> -
> -		case FIONREAD:
> -			{
> -				int val = 0;
> -
> -				if (put_user(val, (int __user *) arg))
> -					return -EFAULT;
> -			}
> -			return 0;
> -		case TCFLSH:
> -			return tty_perform_flush(linux_tty, arg);
> -		}
> -	}
> -	return -ENOIOCTLCMD;
> +        struct ipw_tty *tty = linux_tty->driver_data;
> +        int ret = -ENOIOCTLCMD; // Default return value
> +
> +        if (!tty)
> +                return -ENODEV;
> +
> +        if (!tty->port.count)
> +                return -EINVAL;
> +
> +        // Acquire the mutex to lock the tty object
> +        mutex_lock(&tty->ipw_tty_mutex);
> +
> +        if (tty->tty_type == TTYTYPE_MODEM) {
> +                switch (cmd) {
> +                case PPPIOCGCHAN: {
> +                        int chan = ipwireless_ppp_channel_index(tty->network);
> +
> +                        if (chan < 0) {
> +                                ret = -ENODEV;
> +                                break;
> +                        }
> +                        if (put_user(chan, (int __user *) arg)) {
> +                                ret = -EFAULT;
> +                                break;
> +                        }
> +                        ret = 0;
> +                        break;
> +                }
> +                case PPPIOCGUNIT: {
> +                        int unit = ipwireless_ppp_unit_number(tty->network);
> +
> +                        if (unit < 0) {
> +                                ret = -ENODEV;
> +                                break;
> +                        }
> +                        if (put_user(unit, (int __user *) arg)) {
> +                                ret = -EFAULT;
> +                                break;
> +                        }
> +                        ret = 0;
> +                        break;
> +                }
> +                case FIONREAD: {
> +                        int val = 0;
> +
> +                        if (put_user(val, (int __user *) arg)) {
> +                                ret = -EFAULT;
> +                                break;
> +                        }
> +                        ret = 0;
> +                        break;
> +                }
> +                case TCFLSH:
> +                        ret = tty_perform_flush(linux_tty, arg);
> +                        break;
> +                }
> +        }
> +
> +        // Release the mutex before returning
> +        mutex_unlock(&tty->ipw_tty_mutex);
> +        return ret;
>  }
>  
>  static int add_tty(int j,
> -- 
> 2.43.0
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

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

