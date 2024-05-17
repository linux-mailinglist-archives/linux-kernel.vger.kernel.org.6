Return-Path: <linux-kernel+bounces-181674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA608C7F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 03:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEE72824AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 01:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FABEC4;
	Fri, 17 May 2024 01:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3ModDtG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019D77FD
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715908919; cv=none; b=C2+fHqbowviOzd31fUmr9ZGtw0E6JeDm/zy2IIeH/OXvo1+6AVE7h+f4UIjTOq3WL45GLgJ+uzt9q525oAwkqxpgZwrDVkO35K952e42EARWP14TZb4n4BVkJRr26BTyPzg5y91/P81IPr7QYdksPIBebMNfqK3dAka6mGLEg+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715908919; c=relaxed/simple;
	bh=/+69Lf2vDX6gQntQK69tY9Tw2kBCjXsZWh6uIw2z2+U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=abvZHEicut6ephaHfcq5mgyq90QwLcixS+qcb7zalpn2vQbFxpaVgf5S0BwqkwlbE01VHKuGxSSpZB1JnShQ2ldcW9I8XyP4A6EJUaCv5aBAYTCGwON/rjsshCOmzPKk1ZAccQkdYS1J/09ZRYLN/VHcnqeGmnAVTuc3BNT8aWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3ModDtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC266C113CC;
	Fri, 17 May 2024 01:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715908918;
	bh=/+69Lf2vDX6gQntQK69tY9Tw2kBCjXsZWh6uIw2z2+U=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=r3ModDtGISt7KGEtcdnrchRxmpJyTWN+T77c9M9MSXgNhqXLH8SVghfzsHCafFlCW
	 /ZeuCQb6sIYhnTfBHsbdXD7LhIS4m5p4GZBup/74EW8zjXS2FEu5HJ1Itj67uJn5N0
	 /8lqOxRgWaq480aacBo0ptQgOxZ4EWDAFoIhmpYpqVmw6VuQy+D3TrtGrjKPiSXWue
	 m5ILlc8RZPTn84+hUSL7bc90XffLGR8KSlj1R/rN3OwzKYtUiypU/hablIeIkBg2Bt
	 EUzd8SCUKtNIXcxWf16nfYF5qYEfHF/L4gnJQCEN5yXNLtrArog+9xYmC/Mh6RE6sR
	 GtVf/nbHM6t7Q==
Date: Thu, 16 May 2024 18:21:55 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Henry Wang <xin.wang2@amd.com>
cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
    Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    Michal Orzel <michal.orzel@amd.com>
Subject: Re: [PATCH v2] drivers/xen: Improve the late XenStore init
 protocol
In-Reply-To: <20240517011516.1451087-1-xin.wang2@amd.com>
Message-ID: <alpine.DEB.2.22.394.2405161821240.2544314@ubuntu-linux-20-04-desktop>
References: <20240517011516.1451087-1-xin.wang2@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 17 May 2024, Henry Wang wrote:
> Currently, the late XenStore init protocol is only triggered properly
> for the case that HVM_PARAM_STORE_PFN is ~0ULL (invalid). For the
> case that XenStore interface is allocated but not ready (the connection
> status is not XENSTORE_CONNECTED), Linux should also wait until the
> XenStore is set up properly.
> 
> Introduce a macro to describe the XenStore interface is ready, use
> it in xenbus_probe_initcall() to select the code path of doing the
> late XenStore init protocol or not. Since now we have more than one
> condition for XenStore late init, rework the check in xenbus_probe()
> for the free_irq().
> 
> Take the opportunity to enhance the check of the allocated XenStore
> interface can be properly mapped, and return error early if the
> memremap() fails.
> 
> Fixes: 5b3353949e89 ("xen: add support for initializing xenstore later as HVM domain")
> Signed-off-by: Henry Wang <xin.wang2@amd.com>
> Signed-off-by: Michal Orzel <michal.orzel@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> v2:
> - Use -EINVAL for the memremap() check. (Stefano)
> - Add Fixes: tag. (Stefano)
> - Rework the condition for free_irq() in xenbus_probe(). (Stefano)
> ---
>  drivers/xen/xenbus/xenbus_probe.c | 36 ++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
> index 3205e5d724c8..1a9ded0cddcb 100644
> --- a/drivers/xen/xenbus/xenbus_probe.c
> +++ b/drivers/xen/xenbus/xenbus_probe.c
> @@ -65,13 +65,17 @@
>  #include "xenbus.h"
>  
>  
> -static int xs_init_irq;
> +static int xs_init_irq = -1;
>  int xen_store_evtchn;
>  EXPORT_SYMBOL_GPL(xen_store_evtchn);
>  
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
> @@ -751,19 +755,19 @@ static void xenbus_probe(void)
>  {
>  	xenstored_ready = 1;
>  
> -	if (!xen_store_interface) {
> +	if (!xen_store_interface)
>  		xen_store_interface = memremap(xen_store_gfn << XEN_PAGE_SHIFT,
>  					       XEN_PAGE_SIZE, MEMREMAP_WB);
> -		/*
> -		 * Now it is safe to free the IRQ used for xenstore late
> -		 * initialization. No need to unbind: it is about to be
> -		 * bound again from xb_init_comms. Note that calling
> -		 * unbind_from_irqhandler now would result in xen_evtchn_close()
> -		 * being called and the event channel not being enabled again
> -		 * afterwards, resulting in missed event notifications.
> -		 */
> +	/*
> +	 * Now it is safe to free the IRQ used for xenstore late
> +	 * initialization. No need to unbind: it is about to be
> +	 * bound again from xb_init_comms. Note that calling
> +	 * unbind_from_irqhandler now would result in xen_evtchn_close()
> +	 * being called and the event channel not being enabled again
> +	 * afterwards, resulting in missed event notifications.
> +	 */
> +	if (xs_init_irq >= 0)
>  		free_irq(xs_init_irq, &xb_waitq);
> -	}
>  
>  	/*
>  	 * In the HVM case, xenbus_init() deferred its call to
> @@ -822,7 +826,7 @@ static int __init xenbus_probe_initcall(void)
>  	if (xen_store_domain_type == XS_PV ||
>  	    (xen_store_domain_type == XS_HVM &&
>  	     !xs_hvm_defer_init_for_callback() &&
> -	     xen_store_interface != NULL))
> +	     XS_INTERFACE_READY))
>  		xenbus_probe();
>  
>  	/*
> @@ -831,7 +835,7 @@ static int __init xenbus_probe_initcall(void)
>  	 * started, then probe.  It will be triggered when communication
>  	 * starts happening, by waiting on xb_waitq.
>  	 */
> -	if (xen_store_domain_type == XS_LOCAL || xen_store_interface == NULL) {
> +	if (xen_store_domain_type == XS_LOCAL || !XS_INTERFACE_READY) {
>  		struct task_struct *probe_task;
>  
>  		probe_task = kthread_run(xenbus_probe_thread, NULL,
> @@ -1014,6 +1018,12 @@ static int __init xenbus_init(void)
>  			xen_store_interface =
>  				memremap(xen_store_gfn << XEN_PAGE_SHIFT,
>  					 XEN_PAGE_SIZE, MEMREMAP_WB);
> +			if (!xen_store_interface) {
> +				pr_err("%s: cannot map HVM_PARAM_STORE_PFN=%llx\n",
> +				       __func__, v);
> +				err = -EINVAL;
> +				goto out_error;
> +			}
>  			if (xen_store_interface->connection != XENSTORE_CONNECTED)
>  				wait = true;
>  		}
> -- 
> 2.34.1
> 

