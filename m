Return-Path: <linux-kernel+bounces-180446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0AA8C6EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6DC1F237FE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4566F3C062;
	Wed, 15 May 2024 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC2NxJVE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3CF2A8D7
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715812237; cv=none; b=h2zMADEMMyQdEHIWouLD0dM2vwUZbO40KRqh7C2MlhSdJCeEf2YcTW4dpN/amYr6GH12AlLY87ooR9sRg84Ln84nFa3l58ffgs4NcyOKWA/m+ntyg2GZjSvEW8+ninrIusJykZHCo5dXeSJYwoGWK7iCrzM1c7d5MXV520iKxKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715812237; c=relaxed/simple;
	bh=BhaxKrSJ2V074gHXzgPwRKtFyji5OeLt5R3Sl21D4t0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iutCIJLWgROsFN4a6brlrBp3ZengIrPdVjimT79LbVTgxqsKWqfG3FyulPAIaXOqvLoZvzSHnh64/ZBu7BQPX8M2LOUiEqc0ytUCdrYgMiwxSPKq847lco7oFg897cEE9u3GZ9P3mL/uBbXT4N9U+4F+P36IOpU1bwcaTYlU6aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC2NxJVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D22C116B1;
	Wed, 15 May 2024 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715812237;
	bh=BhaxKrSJ2V074gHXzgPwRKtFyji5OeLt5R3Sl21D4t0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=DC2NxJVEy31yOLjZq9huooHYPwBBmjBjscRNb0ZIy3x6OEpnlOzGNuQT92ALOTRRV
	 1NNhrZjfbKC0lEtLDZOmnnkdgi080nHff9IsAxUVb/vA1ieHqy5fJddxyiP7BlRu07
	 HG78AuDwrZh9dO0iHbi3gN/jF1hi1vGY/F/9TLhql3jUuWpIr9rRHNB99sBSVcfHte
	 0joH++aTxyWzb7rwjAJ0PSCxJrYrGnt6ObW8dQm/61+/4UlfEcEzW7mcCJgjOv2vxt
	 OcBtySvKnw9a3yyXI8RbwBEuusgl/lGV/8pqUE8U0okm/NYcsTjYEWnd+a8Bzvuj3M
	 kdb3NJxOwTmtg==
Date: Wed, 15 May 2024 15:30:34 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Henry Wang <xin.wang2@amd.com>
cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
    Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    Michal Orzel <michal.orzel@amd.com>
Subject: Re: [PATCH] drivers/xen: Improve the late XenStore init protocol
In-Reply-To: <20240515014330.1044617-1-xin.wang2@amd.com>
Message-ID: <alpine.DEB.2.22.394.2405151524270.2544314@ubuntu-linux-20-04-desktop>
References: <20240515014330.1044617-1-xin.wang2@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 May 2024, Henry Wang wrote:
> Currently, the late XenStore init protocol is only triggered properly
> for the case that HVM_PARAM_STORE_PFN is ~0ULL (invalid). For the
> case that XenStore interface is allocated but not ready (the connection
> status is not XENSTORE_CONNECTED), Linux should also wait until the
> XenStore is set up properly.
> 
> Introduce a macro to describe the XenStore interface is ready, use
> it in xenbus_probe_initcall() and xenbus_probe() to select the code
> path of doing the late XenStore init protocol or not.
> 
> Take the opportunity to enhance the check of the allocated XenStore
> interface can be properly mapped, and return error early if the
> memremap() fails.
> 
> Signed-off-by: Henry Wang <xin.wang2@amd.com>
> Signed-off-by: Michal Orzel <michal.orzel@amd.com>

Please add a Fixes: tag


> ---
>  drivers/xen/xenbus/xenbus_probe.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
> index 3205e5d724c8..8aec0ed1d047 100644
> --- a/drivers/xen/xenbus/xenbus_probe.c
> +++ b/drivers/xen/xenbus/xenbus_probe.c
> @@ -72,6 +72,10 @@ EXPORT_SYMBOL_GPL(xen_store_evtchn);
>  struct xenstore_domain_interface *xen_store_interface;
>  EXPORT_SYMBOL_GPL(xen_store_interface);
>  
> +#define XS_INTERFACE_READY \
> +	((xen_store_interface != NULL) && \
> +	 (xen_store_interface->connection == XENSTORE_CONNECTED))
> +
>  enum xenstore_init xen_store_domain_type;
>  EXPORT_SYMBOL_GPL(xen_store_domain_type);
>  
> @@ -751,9 +755,10 @@ static void xenbus_probe(void)
>  {
>  	xenstored_ready = 1;
>  
> -	if (!xen_store_interface) {
> -		xen_store_interface = memremap(xen_store_gfn << XEN_PAGE_SHIFT,
> -					       XEN_PAGE_SIZE, MEMREMAP_WB);
> +	if (!xen_store_interface || XS_INTERFACE_READY) {
> +		if (!xen_store_interface)

These two nested if's don't make sense to me. If XS_INTERFACE_READY
succeeds, it means that  ((xen_store_interface != NULL) &&
(xen_store_interface->connection == XENSTORE_CONNECTED)).

So it is not possible that xen_store_interface == NULL immediately
after. Right?


> +			xen_store_interface = memremap(xen_store_gfn << XEN_PAGE_SHIFT,
> +						       XEN_PAGE_SIZE, MEMREMAP_WB);
>  		/*
>  		 * Now it is safe to free the IRQ used for xenstore late
>  		 * initialization. No need to unbind: it is about to be
> @@ -822,7 +827,7 @@ static int __init xenbus_probe_initcall(void)
>  	if (xen_store_domain_type == XS_PV ||
>  	    (xen_store_domain_type == XS_HVM &&
>  	     !xs_hvm_defer_init_for_callback() &&
> -	     xen_store_interface != NULL))
> +	     XS_INTERFACE_READY))
>  		xenbus_probe();
>  
>  	/*
> @@ -831,7 +836,7 @@ static int __init xenbus_probe_initcall(void)
>  	 * started, then probe.  It will be triggered when communication
>  	 * starts happening, by waiting on xb_waitq.
>  	 */
> -	if (xen_store_domain_type == XS_LOCAL || xen_store_interface == NULL) {
> +	if (xen_store_domain_type == XS_LOCAL || !XS_INTERFACE_READY) {
>  		struct task_struct *probe_task;
>  
>  		probe_task = kthread_run(xenbus_probe_thread, NULL,
> @@ -1014,6 +1019,12 @@ static int __init xenbus_init(void)
>  			xen_store_interface =
>  				memremap(xen_store_gfn << XEN_PAGE_SHIFT,
>  					 XEN_PAGE_SIZE, MEMREMAP_WB);
> +			if (!xen_store_interface) {
> +				pr_err("%s: cannot map HVM_PARAM_STORE_PFN=%llx\n",
> +				       __func__, v);
> +				err = -ENOMEM;

I think this should -EINVAL


> +				goto out_error;
> +			}
>  			if (xen_store_interface->connection != XENSTORE_CONNECTED)
>  				wait = true;
>  		}
> -- 
> 2.34.1
> 

