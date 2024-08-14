Return-Path: <linux-kernel+bounces-285865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B957951392
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D37E284DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B094754662;
	Wed, 14 Aug 2024 04:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XfhB/O/J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C12365;
	Wed, 14 Aug 2024 04:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723610979; cv=none; b=QgbZWoY6eC78M4xB1fO0RzaZNkLNVvMFmoT12mQhU0pNWN1AK/dMBD81g8NEyCt9zTWef70ZPggtgWZmi+bCp4VQWd/PiRHlco8i6Ji03Vtt+COI6ldgEHO4BeIYNst8obMg/xghNbezRIHnwlmv8lN16HwI2px4SxJxY7FOMEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723610979; c=relaxed/simple;
	bh=tugAs4eWoMEjZPFcVMunvHb9v9M8XBYrOnNi6fn9Q0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H18+CxXuG8qfgzatouoOGGxyHkbDaMbetVnB8s64RoOPxWqKWFKcVy9jYy29hoCDKmbmKe7z1W8s11Uo94hKJ39cM0pTRBYSQ41X/QmUxoFM6v05KeYOJPYNox3IWYxVAmF3MmHl/YHqH+SfoPAtemfy79cbYy6+m5nbVKo3R+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XfhB/O/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C247C32786;
	Wed, 14 Aug 2024 04:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723610978;
	bh=tugAs4eWoMEjZPFcVMunvHb9v9M8XBYrOnNi6fn9Q0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XfhB/O/J9oLZ6QK4FhMzDzKdx6Pf9qiFl76tbRlZpzQgnY83XdPA2BElDRr8vO410
	 MGgdG+lRdeQaxhmj9VUJpYbsmG/y+tR4KIZvvxrh+UDpIlF8iWHG62eKGNID44QqIS
	 fSzqWINEroewR9rjVmuWTR+uS3Wsc+J1ChinWS64=
Date: Wed, 14 Aug 2024 06:49:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: heikki.krogerus@linux.intel.com, badhri@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kyletso@google.com, rdbabiera@google.com
Subject: Re: [PATCH v1] usb: roles: add lockdep class key to struct
 usb_role_switch
Message-ID: <2024081450-triage-glorious-cba5@gregkh>
References: <20240813224216.132619-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813224216.132619-1-amitsd@google.com>

On Tue, Aug 13, 2024 at 03:42:11PM -0700, Amit Sunil Dhamne wrote:
> There can be multiple role switch devices running on a platform. Given
> that lockdep is not capable of differentiating between locks of
> different instances, false positive warnings for circular locking are
> reported. To prevent this, register unique lockdep key for each of the
> individual instances.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  drivers/usb/roles/class.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> index d7aa913ceb8a..807a8f18ec20 100644
> --- a/drivers/usb/roles/class.c
> +++ b/drivers/usb/roles/class.c
> @@ -11,6 +11,7 @@
>  #include <linux/usb/role.h>
>  #include <linux/property.h>
>  #include <linux/device.h>
> +#include <linux/lockdep.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> @@ -33,6 +34,10 @@ struct usb_role_switch {
>  	usb_role_switch_set_t set;
>  	usb_role_switch_get_t get;
>  	bool allow_userspace_control;
> +
> +#ifdef CONFIG_LOCKDEP
> +	struct lock_class_key key;
> +#endif

Please do not put #ifdef lines in .c files, they are not needed for this
change to work properly, right?

checkpatch should have complained about this...

thanks,

greg k-h

