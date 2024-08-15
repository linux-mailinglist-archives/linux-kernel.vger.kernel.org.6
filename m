Return-Path: <linux-kernel+bounces-287527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9D59528C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C315287D37
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE9655897;
	Thu, 15 Aug 2024 05:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ib8pmNLM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17F18EAD;
	Thu, 15 Aug 2024 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723698370; cv=none; b=SoFeDNLciqK07L9ZT/87mlKQ93eTdg7aGIRMMKIS2yAApnE3dW1c2UFTGqeCpE3CCEgUAmIkCYvDn3AoTrRjkLyBD7dL1izx1YQ06/ozizswOEVmjONbdOmrPLeF5ZER1guQRfRY5kh5ZvyK9MaJ7jV6XPQhW6WKZRn0J4jooKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723698370; c=relaxed/simple;
	bh=wBh1msf9z3GE0bZB5BQoBvajLP36wUXPhsD1n9HbVb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGXp2UTmHQX9vdob9aZbyJ+wdtNEvFkiFC21E6xc1fZc2ict/GNnzIo0MBtTHhQiAmuzPh9youzJzwQsypwX1P6E/Y4oEXJ3Rrqb8rT0GUTKPUvwNY5cW50S+OJimtEgG+M5QBGnEKeWQtMS5PZg2cGf4HAjdZsMw6SIOrhxDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ib8pmNLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833B8C4AF09;
	Thu, 15 Aug 2024 05:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723698368;
	bh=wBh1msf9z3GE0bZB5BQoBvajLP36wUXPhsD1n9HbVb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ib8pmNLMODWIF4wbsefMuaotZeXrYYjVTNd1+pxUXkkS8wkjqqTCzjFCzAxJSJQHc
	 UAehxQ+vRVkbWEb+DXNDHsxNN1pzExUDf7RpdBfoQoItR+sJTkCaoM9AagdaLT7Djz
	 nE4RbHo0u/le7ID5Xss5CxGC33P6H3qtWnxFHKME=
Date: Thu, 15 Aug 2024 07:06:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: heikki.krogerus@linux.intel.com, badhri@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kyletso@google.com, rdbabiera@google.com
Subject: Re: [PATCH v2] usb: roles: add lockdep class key to struct
 usb_role_switch
Message-ID: <2024081549-lusty-boondocks-00e4@gregkh>
References: <20240815044058.1493751-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815044058.1493751-1-amitsd@google.com>

On Wed, Aug 14, 2024 at 09:40:55PM -0700, Amit Sunil Dhamne wrote:
> There can be multiple role switch devices running on a platform. Given
> that lockdep is not capable of differentiating between locks of
> different instances, false positive warnings for circular locking are
> reported. To prevent this, register unique lockdep key for each of the
> individual instances.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
> v1->v2
> - Avoid usage of ifdefs.
> ---
>  drivers/usb/roles/class.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> index d7aa913ceb8a..9dbe9f6bea83 100644
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
> @@ -33,6 +34,8 @@ struct usb_role_switch {
>  	usb_role_switch_set_t set;
>  	usb_role_switch_get_t get;
>  	bool allow_userspace_control;
> +
> +	struct lock_class_key key;
>  };
>  
>  #define to_role_switch(d)	container_of(d, struct usb_role_switch, dev)
> @@ -396,6 +399,11 @@ usb_role_switch_register(struct device *parent,
>  
>  	sw->registered = true;
>  
> +	if (IS_ENABLED(CONFIG_LOCKDEP)) {

Why is this if statement needed at all?

Please get someone internal to your company/group to review the change
before sending it out for others to find the obvious issues with it.
That's what your peers are for.  Please do so and get them to provide a
reviewed-by on it before submitting it again.

thanks,

greg k-h

