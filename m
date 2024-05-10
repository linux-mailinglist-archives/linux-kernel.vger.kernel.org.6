Return-Path: <linux-kernel+bounces-176304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDC18C2DB0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 01:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1141C215EB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C7F17556D;
	Fri, 10 May 2024 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMC5Ccu3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07A518EA1
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715385040; cv=none; b=KHv87wsDgdZyu7pxeGWPcMrUbjaZgp4V9CBBMOZC2tfgq5sqAe04ohuU8mw2sLPaVEM+4jTW00ailVd97JRQuOLfQqDLnIhbo624oiEGzrCqODlsOwJ3eu0Y9DpOnk/YxezXdj98LUkqD4ipzNi4ysiwiMsceuhbLulWmmsT6xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715385040; c=relaxed/simple;
	bh=y5z+M1lyyj10VjOQtNfEmMdhZM6sT9TSdZZeuuyU1Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8T3I6i/nO0Fa7paBBKPufjyV5nt8W2P01NaGto4g+EFXPLclPP97VhdX0yBqu18IdVEvS255gtQvbx6V24N7e5Mx2pICklGAeeCWCxdv+zT0MbJCQL6mimfkUZjqz6n7g8c69Nt26/8pWZ4G59sjKJi28TTHIO3ufYxtTItgso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMC5Ccu3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715385037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m0dHDeJXZCALlp2ufSH87EqN0Fr/YawjQbxw3fUy5tg=;
	b=aMC5Ccu3Vo+w79towc9HXeU8COIVTgtQeRCaF6zxCW6E7quNwMnv+y0YgHKMIoSgl/B1s0
	55Bt30gNXx12HxOfooSxPKfTojxZmQSi8ntB95CFN0fsilM94x0eFil1WBqDYlge/JBlbp
	/lZlfJxEZ++Ra6zrYLHEe0k0cOTrs8Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-sE9Mt34nMKKddJMPk9c91g-1; Fri, 10 May 2024 19:50:34 -0400
X-MC-Unique: sE9Mt34nMKKddJMPk9c91g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB3CD8030A5;
	Fri, 10 May 2024 23:50:33 +0000 (UTC)
Received: from fedora (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7193344E3AFE;
	Fri, 10 May 2024 23:50:30 +0000 (UTC)
Date: Sat, 11 May 2024 07:50:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <Zj6yvTxIpUnOXl7R@fedora>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com>
 <20240510151047.GA10486@lst.de>
 <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Fri, May 10, 2024 at 10:20:02AM -0600, Keith Busch wrote:
> On Fri, May 10, 2024 at 05:10:47PM +0200, Christoph Hellwig wrote:
> > On Fri, May 10, 2024 at 07:14:59AM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > Some people _really_ want to control their interrupt affinity.
> > 
> > So let them argue why.  I'd rather have a really, really, really
> > good argument for this crap, and I'd like to hear it from the horses
> > mouth.
> 
> It's just prioritizing predictable user task scheduling for a subset of
> CPUs instead of having consistently better storage performance.
> 
> We already have "isolcpus=managed_irq," parameter to prevent managed
> interrupts from running on a subset of CPUs, so the use case is already
> kind of supported. The problem with that parameter is it is a no-op if
> the starting affinity spread contains only isolated CPUs.

Can you explain a bit why it is a no-op? If only isolated CPUs are
spread on one queue, there will be no IO originated from these isolated
CPUs, that is exactly what the isolation needs.



Thanks,
Ming


