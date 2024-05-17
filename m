Return-Path: <linux-kernel+bounces-181662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA86A8C7F54
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 02:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33A3283305
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 00:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D2C811;
	Fri, 17 May 2024 00:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvKGGnuy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA5622
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 00:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715907174; cv=none; b=dZAxLaLzdfynGOjS+pGWcFkAy66QzGFlI1AjKQ9EUnQQaW+YaK6Dn7IhND9QcLOAB3gIycJTETBNF6seCnBr/b0JebzuuVYarFC4ovooBRytv/LZxhC2skZ8a2DIw6ca3t0MO2nyrZWiujcrDZDiFLX2KLHRtPLv+UHEHQz4/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715907174; c=relaxed/simple;
	bh=TegGSMyB0JVbO6jlmENdPDoxx20cRA2GXqpfoyUXYVk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FdRy1f6zjINYG8kpiyLyErjRJXdWAEpbtdc2v2xZvrQParnHV2ICZdXeDPDNuBdvIT+URFCAJlCK088v7C7u/P/KMvBD1LUjl0yJAsLpH6G9gljhmGEQDKajWqX4saE5kAPXm2ZsoRZ/6Fjr0EQ5VUXtBXaHqCIHrSS+r3ejjjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvKGGnuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DAFC113CC;
	Fri, 17 May 2024 00:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715907174;
	bh=TegGSMyB0JVbO6jlmENdPDoxx20cRA2GXqpfoyUXYVk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=gvKGGnuyc4WhtBlCJuhbccSsXprf1zrb45rBV9rU6MXH0h7E4npLggND/8prIh3n5
	 K7JEMSUkE4XcEo4u9g1ewA+wlynihMT99qyPZB13/mfI4jbJbb9FRlpGFG5qLar9mc
	 xyhX1+h33s9YED2fgglcV3pZkRRlJ9Uah4wjuf+dTYijQwCtoLhvOkgEg1ijMcpHnU
	 Aw3eYvTbFutAx6hVWW6WSw3g5YI+m6riav9Jduf2VKXWM0FXSVKov2441NZOZc+FqV
	 d//YZdCaSdsze9BwKzw6StxG7qsrDLjUg5IC/eLX6DqsARE5O5dhDY2pSkfi2leVMu
	 YRWyR2ZHYrAqg==
Date: Thu, 16 May 2024 17:52:51 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Henry Wang <xin.wang2@amd.com>
cc: Stefano Stabellini <sstabellini@kernel.org>, 
    xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
    Juergen Gross <jgross@suse.com>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    Michal Orzel <michal.orzel@amd.com>
Subject: Re: [PATCH] drivers/xen: Improve the late XenStore init protocol
In-Reply-To: <028f29be-0393-4a57-83e2-ea27fe0320d5@amd.com>
Message-ID: <alpine.DEB.2.22.394.2405161743170.2544314@ubuntu-linux-20-04-desktop>
References: <20240515014330.1044617-1-xin.wang2@amd.com> <alpine.DEB.2.22.394.2405151524270.2544314@ubuntu-linux-20-04-desktop> <028f29be-0393-4a57-83e2-ea27fe0320d5@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-217339045-1715907173=:2544314"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-217339045-1715907173=:2544314
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 16 May 2024, Henry Wang wrote:
> Hi Stefano,
> 
> On 5/16/2024 6:30 AM, Stefano Stabellini wrote:
> > On Wed, 15 May 2024, Henry Wang wrote:
> > > Currently, the late XenStore init protocol is only triggered properly
> > > for the case that HVM_PARAM_STORE_PFN is ~0ULL (invalid). For the
> > > case that XenStore interface is allocated but not ready (the connection
> > > status is not XENSTORE_CONNECTED), Linux should also wait until the
> > > XenStore is set up properly.
> > > 
> > > Introduce a macro to describe the XenStore interface is ready, use
> > > it in xenbus_probe_initcall() and xenbus_probe() to select the code
> > > path of doing the late XenStore init protocol or not.
> > > 
> > > Take the opportunity to enhance the check of the allocated XenStore
> > > interface can be properly mapped, and return error early if the
> > > memremap() fails.
> > > 
> > > Signed-off-by: Henry Wang <xin.wang2@amd.com>
> > > Signed-off-by: Michal Orzel <michal.orzel@amd.com>
> > Please add a Fixes: tag
> 
> Sure. Will do.
> 
> > > ---
> > >   drivers/xen/xenbus/xenbus_probe.c | 21 ++++++++++++++++-----
> > >   1 file changed, 16 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/xen/xenbus/xenbus_probe.c
> > > b/drivers/xen/xenbus/xenbus_probe.c
> > > index 3205e5d724c8..8aec0ed1d047 100644
> > > --- a/drivers/xen/xenbus/xenbus_probe.c
> > > +++ b/drivers/xen/xenbus/xenbus_probe.c
> > > @@ -72,6 +72,10 @@ EXPORT_SYMBOL_GPL(xen_store_evtchn);
> > >   struct xenstore_domain_interface *xen_store_interface;
> > >   EXPORT_SYMBOL_GPL(xen_store_interface);
> > >   +#define XS_INTERFACE_READY \
> > > +	((xen_store_interface != NULL) && \
> > > +	 (xen_store_interface->connection == XENSTORE_CONNECTED))
> > > +
> > >   enum xenstore_init xen_store_domain_type;
> > >   EXPORT_SYMBOL_GPL(xen_store_domain_type);
> > >   @@ -751,9 +755,10 @@ static void xenbus_probe(void)
> > >   {
> > >   	xenstored_ready = 1;
> > >   -	if (!xen_store_interface) {
> > > -		xen_store_interface = memremap(xen_store_gfn <<
> > > XEN_PAGE_SHIFT,
> > > -					       XEN_PAGE_SIZE, MEMREMAP_WB);
> > > +	if (!xen_store_interface || XS_INTERFACE_READY) {
> > > +		if (!xen_store_interface)
> > These two nested if's don't make sense to me. If XS_INTERFACE_READY
> > succeeds, it means that  ((xen_store_interface != NULL) &&
> > (xen_store_interface->connection == XENSTORE_CONNECTED)).
> > 
> > So it is not possible that xen_store_interface == NULL immediately
> > after. Right?
> 
> I think this is because we want to free the irq for the late init case,
> otherwise the init-dom0less will fail. For the xenstore PFN allocated case,
> the connection is already set to CONNECTED when we execute init-dom0less. But
> I agree with you, would below diff makes more sense to you?
> 
> diff --git a/drivers/xen/xenbus/xenbus_probe.c
> b/drivers/xen/xenbus/xenbus_probe.c
> index 8aec0ed1d047..b8005b651a29 100644
> --- a/drivers/xen/xenbus/xenbus_probe.c
> +++ b/drivers/xen/xenbus/xenbus_probe.c
> @@ -76,6 +76,8 @@ EXPORT_SYMBOL_GPL(xen_store_interface);
>         ((xen_store_interface != NULL) && \
>          (xen_store_interface->connection == XENSTORE_CONNECTED))
> 
> +static bool xs_late_init = false;
> +
>  enum xenstore_init xen_store_domain_type;
>  EXPORT_SYMBOL_GPL(xen_store_domain_type);
> 
> @@ -755,7 +757,7 @@ static void xenbus_probe(void)
>  {
>         xenstored_ready = 1;
> 
> -       if (!xen_store_interface || XS_INTERFACE_READY) {
> +       if (xs_late_init) {
>                 if (!xen_store_interface)
>                         xen_store_interface = memremap(xen_store_gfn <<


I would just remove the outer 'if' and do this:


	if (!xen_store_interface)
		xen_store_interface = memremap(xen_store_gfn << XEN_PAGE_SHIFT,
				XEN_PAGE_SIZE, MEMREMAP_WB);
	/*
	 * Now it is safe to free the IRQ used for xenstore late
	 * initialization. No need to unbind: it is about to be
	 * bound again from xb_init_comms. Note that calling
	 * unbind_from_irqhandler now would result in xen_evtchn_close()
	 * being called and the event channel not being enabled again
	 * afterwards, resulting in missed event notifications.
	 */
	if (xs_init_irq > 0)
		free_irq(xs_init_irq, &xb_waitq);


I think this should work fine in all cases. I am unsure if
xs_init_irq==0 is possible valid value for xs_init_irq. If it is not,
then we are fine. If 0 is a possible valid irq number, then we should
initialize xs_init_irq to -1, and here check for xs_init_irq >= 0.
--8323329-217339045-1715907173=:2544314--

