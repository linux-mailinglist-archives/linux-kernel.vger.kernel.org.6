Return-Path: <linux-kernel+bounces-177356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6D18C3D70
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 859E9B20D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78781147C93;
	Mon, 13 May 2024 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iy6isypS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC50147C7F
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589614; cv=none; b=p6hRdZlzeqP+dp92UGCR2xxSY4ksknl0hed4+IUkcb5YPxzTB9quRp2xsw1DRSixHcBUBtq05A5jhErmL/TVlVDCaYhg5HLUMMRQm1QwGgNEBVFysx2vjQEcWWThnqS18ZXPI6RW+QKbgTN/Qnqy9n8E7k/Yiu/gAytzP9gj1IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589614; c=relaxed/simple;
	bh=W7Upr80CUPRnv/2p62AHw64D2eAOW6aoxATj8eWlFyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atztx2BslHBZrglyAboX2tf9h8qLkbCTquLOBozuAGZlz3uNBso9Bs8ZxhwbJjO2BhSbgIewwkqi04PQxCkNUt3eoIjl/DAhqm6JPRG3XsmpuMS8EcWSJN5/nvss7LrqpcDmL4YH02t7rJQJ0nSS+j8Vf3ERF1Na1H5RPKuGOVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iy6isypS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715589612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y9TfaHjT18CdtzvNmwQpp2X/7RmpdQsmO2fg/Q54E5g=;
	b=Iy6isypSNr9VBkN1FPWAQ80+eSoyCIoxZb8omnyo2lmJx3MbN+vHVm6QJqD3LPvSj1Mi99
	hCGBVlwJb3PPvnaWPStmemEuU7pr5DaKGG2prjFlbB2X35oiQhUAg5l5pKwJryiOjOeVXB
	+hmYU1ZUeyru8JhcJM1ILX2urZ9ALVU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-5OsPxujyM4GbGF1I4fXupg-1; Mon, 13 May 2024 04:39:57 -0400
X-MC-Unique: 5OsPxujyM4GbGF1I4fXupg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF80C800656;
	Mon, 13 May 2024 08:39:56 +0000 (UTC)
Received: from fedora (unknown [10.72.112.91])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6553540C5D0;
	Mon, 13 May 2024 08:39:52 +0000 (UTC)
Date: Mon, 13 May 2024 16:39:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Benjamin Meier <benjamin.meier70@gmail.com>
Cc: hch@lst.de, kbusch@kernel.org, kbusch@meta.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	tglx@linutronix.de, ming.lei@redhat.com
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <ZkHR1L/cJesDEn60@fedora>
References: <20240510151047.GA10486@lst.de>
 <26d4ad30-c0fe-4286-9802-aa6afbd8074a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26d4ad30-c0fe-4286-9802-aa6afbd8074a@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Mon, May 13, 2024 at 09:33:27AM +0200, Benjamin Meier wrote:
> > From: Christoph Hellwig <hch@lst.de>
> >
> > So let them argue why.  I'd rather have a really, really, really
> > good argument for this crap, and I'd like to hear it from the horses
> > mouth.
> 
> I reached out to Keith to explore the possibility of manually defining
> which cores handle NVMe interrupts.
> 
> The application which we develop and maintain (in the company I work)
> has very high requirements regarding latency. We have some isolated cores

Are these isolated cores controlled by kernel command line `isolcpus=`?

> and we run our application on those.
> 
> Our system is using kernel 5.4 which unfortunately does not support
> "isolcpus=managed_irq". Actually, we did not even know about that
> option, because we are focussed on kernel 5.4. It solves part
> of our problem, but being able to specify where exactly interrupts
> are running is still superior in our opinion.
> 
> E.g. assume the number of house-keeping cores is small, because we
> want to have full control over the system. In our case we have threads
> of different priorities where some get an exclusive core. Some other threads
> share a core (or a group of cores) with other threads. Now we are still
> happy to assign some interrupts to some of the cores which we consider as
> "medium-priority". Due to the small number of non-isolated cores, it can

So these "medium-priority" cores belong to isolated cpu list, you still expect
NVMe interrupts can be handled on these cpu cores, do I understand correctly?

If yes, I think your case still can be covered with 'isolcpus=managed_irq' which
needn't to be same with cpu cores specified from `isolcpus=`, such as
excluding medium-priority cores from 'isolcpus=managed_irq', and
meantime include them in plain `isolcpus=`.

> be tricky to assign all interrupts to those without a performance-penalty.
> 
> Given these requirements, manually specifying interrupt/core assignments
> would offer greater flexibility and control over system performance.
> Moreover, the proposed code changes appear minimal and have no
> impact on existing functionalities.

Looks your main concern is performance, but as Keith mentioned, the proposed
change may degrade nvme perf too:

https://lore.kernel.org/linux-nvme/Zj6745UDnwX1BteO@kbusch-mbp.dhcp.thefacebook.com/



thanks,
Ming


