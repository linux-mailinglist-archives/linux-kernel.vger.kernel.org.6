Return-Path: <linux-kernel+bounces-389767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8614A9B70F6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320C91F21E35
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38B04C80;
	Thu, 31 Oct 2024 00:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeTHfkwF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8650FEC2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 00:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730333716; cv=none; b=EAoWGvaM9ABui8Jf0O3YFJYwU2bi+njRs53PSKLKXhCuF0QfKzMTCXn3iS8AulFXu1eWJde5TI7aJaL1WWSTdppcilrn0gzisytpHxJ4yT+S+XHoWozr9czdY4YButC+d0QyAlTBQDIEAJHhPLV6mknj1OjnodfdrAwPVxWXGdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730333716; c=relaxed/simple;
	bh=uHbbEMAlsuPt5NdNN9X2F9Zupra3ioP3BN0z5R7Qa88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdxZwFNyWy3VDd2qAOXJ/ZswQE5/9npIQo8zQG3EpnB9lPmZOZD9g7ZJdGTEjjsKVkb9aFi2Nzh0as3amg7zGYON+5xerbrdp+QqdCDXm3iQ/RqStvHrKUl02gWi4Hpwk4nvvoatMPQu0NsdW5MYRLeQNT9haHl3OdLS8VcYlDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NeTHfkwF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730333712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NBeNK9NFh5JOCEfAA5ML5dOmjPRbM5/5eyvk78NXjys=;
	b=NeTHfkwFWReQsmVcLhhqLsslKyNwNZEqCmR8tU5HxjAxLcIrigevkqite+v0aIq7ID8aE2
	mauFxQTIeKEz4PMJyu4q2Dn0emS7iwVptP6aXZymXrSqjmnsAzAt5E6+PPPsqVq/pXF7ry
	BKkVMB28sFktyzOXZELChWbvpIKOMMY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-kEeXRQzDPMytemAEJ99l6Q-1; Wed,
 30 Oct 2024 20:15:05 -0400
X-MC-Unique: kEeXRQzDPMytemAEJ99l6Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 070B41956046;
	Thu, 31 Oct 2024 00:15:03 +0000 (UTC)
Received: from fedora (unknown [10.72.116.15])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 987571956086;
	Thu, 31 Oct 2024 00:14:55 +0000 (UTC)
Date: Thu, 31 Oct 2024 08:14:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
	dhowells@redhat.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	klara@kasm.eu
Subject: Re: [PATCH] iov_iter: don't require contiguous pages in
 iov_iter_extract_bvec_pages
Message-ID: <ZyLL-eXIntwBY5q2@fedora>
References: <20241024050021.627350-1-hch@lst.de>
 <fa2f2722-fab2-4108-8d3a-f7da87bb9efa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa2f2722-fab2-4108-8d3a-f7da87bb9efa@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Oct 30, 2024 at 06:56:48PM +0100, Klara Modin wrote:
> Hi,
> 
> On 2024-10-24 07:00, Christoph Hellwig wrote:
> > From: Ming Lei <ming.lei@redhat.com>
> > 
> > The iov_iter_extract_pages interface allows to return physically
> > discontiguous pages, as long as all but the first and last page
> > in the array are page aligned and page size.  Rewrite
> > iov_iter_extract_bvec_pages to take advantage of that instead of only
> > returning ranges of physically contiguous pages.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > [hch: minor cleanups, new commit log]
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> With this patch (e4e535bff2bc82bb49a633775f9834beeaa527db in next-20241030),
> I'm unable to connect via nvme-tcp with this in the log:
> 
> nvme nvme1: failed to send request -5
> nvme nvme1: Connect command failed: host path error
> nvme nvme1: failed to connect queue: 0 ret=880
> 
> With the patch reverted it works as expected:
> 
> nvme nvme1: creating 24 I/O queues.
> nvme nvme1: mapped 24/0/0 default/read/poll queues.
> nvme nvme1: new ctrl: NQN
> "nqn.2018-06.eu.kasm.int:freenas:backup:parmesan.int.kasm.eu", addr
> [2001:0678:0a5c:1204:6245:cbff:fe9c:4f59]:4420, hostnqn:
> nqn.2018-06.eu.kasm.int:parmesan

I can't reproduce it by running blktest 'nvme_trtype=tcp ./check nvme/'
on both next tree & for-6.13/block.

Can you collect the following bpftrace log by running the script before
connecting to nvme-tcp?

Please enable the following kernel options for bpftrace:

	CONFIG_KPROBE_EVENTS_ON_NOTRACE=y
	CONFIG_NVME_CORE=y
	CONFIG_NVME_FABRICS=y
	CONFIG_NVME_TCP=y

Btw, bpftrace doesn't work on next tree if nvme is built as module.


# cat extract.bt
#!/usr/bin/bpftrace

kprobe:nvmf_connect_io_queue
{
	@connect[tid]=1;
}

kretprobe:nvmf_connect_io_queue
{
	@connect[tid]=0;
}

kprobe:iov_iter_extract_pages
/@connect[tid]/
{
	$i = (struct iov_iter *)arg0;
	printf("extract pages: iter(cnt %lu off %lu) maxsize %u maxpages %u offset %lu\n",
		$i->count, $i->iov_offset, arg2, arg3, *((uint32 *)arg4));
	printf("\t bvec(off %u len %u)\n", $i->bvec->bv_offset, $i->bvec->bv_len);
}

kretprobe:iov_iter_extract_pages
/@connect[tid]/
{
	printf("extract pages: ret %d\n", retval);
}

END {
	clear(@connect);
}



Thanks,
Ming


