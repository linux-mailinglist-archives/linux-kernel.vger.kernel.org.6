Return-Path: <linux-kernel+bounces-232418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E741C91A899
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EB80B236A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D504B19581D;
	Thu, 27 Jun 2024 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VQW8n7v0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F76195806;
	Thu, 27 Jun 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497030; cv=none; b=QfRrKL3JodHtv43+05oHI9IVg+lxJGBSc9g0pdeuPmxWMHYVIZiyn1GiWrBUCviOc565uEzAr3gMTybVYmbKhsI5ODBK2l7ljVhF2uY6bUF770ghTzx9usB92BJ3bha2rWtvKYrodRfVGwFb7EuYiKZXEi958Z39DWBrv1Dspvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497030; c=relaxed/simple;
	bh=fTqaDWu6fhwdcrmqgYQAJlD7OPPMQUDJ106rxf2OwK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8dxvPK+3GV2+2S7KtzHyv6H/hHQ3A6ntrvFyXF6J4wPHYq9d+DtpRj+HTxhResQK4c7EvjNcFqnAMVIK3WUCo65bTLf2iLT5TnuhDkjCjRXQaujulCZ8+EXsEkpVVdAaR3b7kCziHsys4ozjgICXM5LX0MMTMMhc9cbKUi7C6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VQW8n7v0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475F9C2BBFC;
	Thu, 27 Jun 2024 14:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719497029;
	bh=fTqaDWu6fhwdcrmqgYQAJlD7OPPMQUDJ106rxf2OwK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQW8n7v06dH621B4QNXllK9QU6lIGcGlL2I4NKY7U73ZpjpcGjagNx1TRmtoiMXP4
	 7zphxaGxX52Ad8QozqWSvqh35xOid/ixO5a1P1miwE3soF1vhNfEIjCVh0TawQd0n0
	 DO/Zp8TQklV2KlHMfiRH2GVoQxkQMig5NyeqnQ+g=
Date: Thu, 27 Jun 2024 16:03:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
	linux-usb@vger.kernel.org, Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH v4 23/40] usb: cdc-acm: optimize acm_softint()
Message-ID: <2024062732-boneless-emphasis-b7b9@gregkh>
References: <20240620175703.605111-1-yury.norov@gmail.com>
 <20240620175703.605111-24-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620175703.605111-24-yury.norov@gmail.com>

On Thu, Jun 20, 2024 at 10:56:46AM -0700, Yury Norov wrote:
> acm_softint() uses for-loop to traverse urbs_in_error_delay bitmap
> bit by bit to find and clear set bits.
> 
> Simplify it by using for_each_test_and_clear_bit(), because it doesn't
> test already clear bits.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Acked-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/usb/class/cdc-acm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 0e7439dba8fe..f8940f0d7ad8 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -18,6 +18,7 @@
>  #undef DEBUG
>  #undef VERBOSE_DEBUG
>  
> +#include <linux/find_atomic.h>
>  #include <linux/kernel.h>
>  #include <linux/sched/signal.h>
>  #include <linux/errno.h>
> @@ -613,9 +614,8 @@ static void acm_softint(struct work_struct *work)
>  	}
>  
>  	if (test_and_clear_bit(ACM_ERROR_DELAY, &acm->flags)) {
> -		for (i = 0; i < acm->rx_buflimit; i++)
> -			if (test_and_clear_bit(i, &acm->urbs_in_error_delay))
> -				acm_submit_read_urb(acm, i, GFP_KERNEL);
> +		for_each_test_and_clear_bit(i, &acm->urbs_in_error_delay, acm->rx_buflimit)
> +			acm_submit_read_urb(acm, i, GFP_KERNEL);
>  	}
>  
>  	if (test_and_clear_bit(EVENT_TTY_WAKEUP, &acm->flags))
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

