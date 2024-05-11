Return-Path: <linux-kernel+bounces-176353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C8A8C2E4E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85ACF1F21BDB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D808F5E;
	Sat, 11 May 2024 00:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERjM3D+P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE32F22
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715389177; cv=none; b=EdHdD5/oAvaG0r6tI1Me5fnitr6C5Cq07Lin9W+bWEZr1yrCuDpc+4/zfBfpSTPY10Gr7PyWcdTCrzVXVDOMK36vrUhpEi9WTYsUT9Eyug8HTcoBAU+AQ/N3WymthLAHt9euWem/lGNikzQTSiBLXpMrFs+Vs5NaqpGESdBCll4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715389177; c=relaxed/simple;
	bh=wSzP8M1jahGPp9QcDi41OKWPVRVuugpSHn68DY92plA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoudwvbBl+6wsHfEDbZ+Gl1IKcqmRrA2Hd7mh8xsweVMSToUWw3DZKns9XJFg2nxl9bBJ6DB2cyDMs/CMYo7hT0H01v8dqXIZiu9/1UwVqBRPHKzXrHVw4ZyocJhMdQDkp/WiptHM5lb+qAfHMjir9Cf1iuCsLxckPI1AaPqI68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ERjM3D+P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715389174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lP4kjDNJl8Z5kVFnY+PpwH5yXWS5Ek6nqlqRnF2wXwM=;
	b=ERjM3D+Pv2JgyABQ0LlYz2VllM8Gkn/x1GQyt32KR2iufhkfaMlGfcHOByTxgotDE+TQjl
	IVrBY2YZAa6HlCE9JAr0yl+eAsl3O33yN13ATY7QpORltwKIFDq+RKSCvocyc5CGcId8od
	DMvQ7D6j5lq/PYmAqtDatzBSpZNmLDc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-Ej9y5OyQOUO58lzfQejPXA-1; Fri,
 10 May 2024 20:59:25 -0400
X-MC-Unique: Ej9y5OyQOUO58lzfQejPXA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FE8A3C02521;
	Sat, 11 May 2024 00:59:25 +0000 (UTC)
Received: from fedora (unknown [10.72.116.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B647C2011804;
	Sat, 11 May 2024 00:59:21 +0000 (UTC)
Date: Sat, 11 May 2024 08:59:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <Zj7C5fPCAdGwGsrI@fedora>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com>
 <20240510151047.GA10486@lst.de>
 <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
 <Zj6yvTxIpUnOXl7R@fedora>
 <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Fri, May 10, 2024 at 06:41:58PM -0600, Keith Busch wrote:
> On Sat, May 11, 2024 at 07:50:21AM +0800, Ming Lei wrote:
> > On Fri, May 10, 2024 at 10:20:02AM -0600, Keith Busch wrote:
> > > On Fri, May 10, 2024 at 05:10:47PM +0200, Christoph Hellwig wrote:
> > > > On Fri, May 10, 2024 at 07:14:59AM -0700, Keith Busch wrote:
> > > > > From: Keith Busch <kbusch@kernel.org>
> > > > > 
> > > > > Some people _really_ want to control their interrupt affinity.
> > > > 
> > > > So let them argue why.  I'd rather have a really, really, really
> > > > good argument for this crap, and I'd like to hear it from the horses
> > > > mouth.
> > > 
> > > It's just prioritizing predictable user task scheduling for a subset of
> > > CPUs instead of having consistently better storage performance.
> > > 
> > > We already have "isolcpus=managed_irq," parameter to prevent managed
> > > interrupts from running on a subset of CPUs, so the use case is already
> > > kind of supported. The problem with that parameter is it is a no-op if
> > > the starting affinity spread contains only isolated CPUs.
> > 
> > Can you explain a bit why it is a no-op? If only isolated CPUs are
> > spread on one queue, there will be no IO originated from these isolated
> > CPUs, that is exactly what the isolation needs.
> 
> The "isolcpus=managed_irq," option doesn't limit the dispatching CPUs.

Please see commit a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
in for-6.10/block.

> It only limits where the managed irq will assign the effective_cpus as a
> best effort.

Most of times it does work.

> 
> Example, I boot with a system with 4 threads, one nvme device, and
> kernel parameter:
> 
>   isolcpus=managed_irq,2-3
> 
> Run this:
> 
>   for i in $(seq 0 3); do taskset -c $i dd if=/dev/nvme0n1 of=/dev/null bs=4k count=1000 iflag=direct; done

It is one test problem, when you try to isolate '2-3', it isn't expected
to submit IO or run application on these isolated CPUs.


Thanks, 
Ming


