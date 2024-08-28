Return-Path: <linux-kernel+bounces-304508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB822962119
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A037B24323
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6100158DA3;
	Wed, 28 Aug 2024 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R1knZe88"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD114BF92
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830217; cv=none; b=rZRSSVw+DLeC+r2j5xVYFnvBC3ic6JL56ujx8K3TMzR3ckrOiI7nCU7+a8ZhyQ9L3D+uSKLoficfyPoU5W9/k19m3lQ1NAhTlc7taHVwzNIlQ2sROQt4bboljNAxrF3Ca+is7FWSQIcfkYqwQl2AepjfZfzAQsyiX4Y5wFZNsZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830217; c=relaxed/simple;
	bh=6D0a0spx7P8RAG+1zJk8ocf2zHpBv4xJNan/6sJxJeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CORMUhdkrYP2+//ygwdphh0FPerN/67aCRKhaVXE/cHZufKms5jxKx6Xc5hpjaKIVYtFQDMaahRIECYJkNoj3o9/ZP8SLd2IJzTZxREpkGKOMmldPLEnklRZq5+DJkwTfSo3NQP/FGvItlQk/kYb6UuTsXoEOOD4dlRHf+QiFPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R1knZe88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D907DC4AF49;
	Wed, 28 Aug 2024 07:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724830216;
	bh=6D0a0spx7P8RAG+1zJk8ocf2zHpBv4xJNan/6sJxJeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R1knZe886UkbAbEo+OL/VYkhYdlmNIA5xIrH2K6T7xEHoxI9wUXGiExtZDH7/ru1C
	 IRstoVwatnRwqWHsVxOFyK1D632kUJ1NlrULaJ4ABe4I07DHY32X8s7stNf1+MzZQ4
	 3DkPE82BCjAXHieLVdXpWORpuPS92ZJ0IModwnlo=
Date: Wed, 28 Aug 2024 09:30:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Tao Liu <thomas.liu@ucloud.cn>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: CVE-2022-48936: gso: do not skip outer ip header in case of ipip
 and net_failover
Message-ID: <2024082854-reassign-uniformed-2c2f@gregkh>
References: <2024082224-CVE-2022-48936-9302@gregkh>
 <z3hh3yrf5wym3obgol6obh3dkmqoc3rwbkj23qcmadf63b47h2@nn2232wngans>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <z3hh3yrf5wym3obgol6obh3dkmqoc3rwbkj23qcmadf63b47h2@nn2232wngans>

On Tue, Aug 27, 2024 at 05:02:36PM +0200, Michal Koutný wrote:
> On Thu, Aug 22, 2024 at 11:31:37AM GMT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > We encounter a tcp drop issue in our cloud environment. Packet GROed in
> > host forwards to a VM virtio_net nic with net_failover enabled. VM acts
> > as a IPVS LB with ipip encapsulation. The full path like:
> > host gro -> vm virtio_net rx -> net_failover rx -> ipvs fullnat
> >  -> ipip encap -> net_failover tx -> virtio_net tx
> > 
> > When net_failover transmits a ipip pkt (gso_type = 0x0103, which means
> > SKB_GSO_TCPV4, SKB_GSO_DODGY and SKB_GSO_IPXIP4), there is no gso
> > did because it supports TSO and GSO_IPXIP4. But network_header points to
> > inner ip header.
> > 
> > Call Trace:
> >  tcp4_gso_segment        ------> return NULL
> >  inet_gso_segment        ------> inner iph, network_header points to
> >  ipip_gso_segment
> >  inet_gso_segment        ------> outer iph
> >  skb_mac_gso_segment
> 
> > Afterwards virtio_net transmits the pkt, only inner ip header is modified.
> > And the outer one just keeps unchanged. The pkt will be dropped in remote
> > host.
> 
> That may appear like a transient connection issue or permanently
> impossible connection?

I don't know.

> > Call Trace:
> >  inet_gso_segment        ------> inner iph, outer iph is skipped
> >  skb_mac_gso_segment
> >  __skb_gso_segment
> >  validate_xmit_skb
> >  validate_xmit_skb_list
> >  sch_direct_xmit
> >  __qdisc_run
> >  __dev_queue_xmit        ------> virtio_net
> >  dev_hard_start_xmit
> >  __dev_queue_xmit        ------> net_failover
> >  ip_finish_output2
> >  ip_output
> >  iptunnel_xmit
> >  ip_tunnel_xmit
> >  ipip_tunnel_xmit        ------> ipip
> >  dev_hard_start_xmit
> >  __dev_queue_xmit
> >  ip_finish_output2
> >  ip_output
> >  ip_forward
> >  ip_rcv
> >  __netif_receive_skb_one_core
> >  netif_receive_skb_internal
> >  napi_gro_receive
> >  receive_buf
> >  virtnet_poll
> >  net_rx_action
> > 
> > The root cause of this issue is specific with the rare combination of
> > SKB_GSO_DODGY and a tunnel device that adds an SKB_GSO_ tunnel option.
> > SKB_GSO_DODGY is set from external virtio_net. We need to reset network
> > header when callbacks.gso_segment() returns NULL.
> 
> Who's in control of these configuration (who can cause this incorrect
> packet being sent)?
> 
> > This patch also includes ipv6_gso_segment(), considering SIT, etc.
> > 
> > The Linux kernel CVE team has assigned CVE-2022-48936 to this issue.
> 
> What is the security issue here?

This was assigned as part of the import of the Linux kernel GSD entries
into CVEs as required by the CVE board of directors (hence the 2022
date).  If you don't feel this should be assigned a CVE, just let me
know and I will be glad to reject it.

thanks,

greg k-h

