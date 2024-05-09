Return-Path: <linux-kernel+bounces-174110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9378E8C0A4C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31CFAB21FD8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E46B1482EA;
	Thu,  9 May 2024 03:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Soah4PO8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0B0146D71
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 03:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715226789; cv=none; b=KHX9Vev6dt1JwFxRK5K5rT9L/XZer8OBLGI+lpPEftr5gKsS514DhDKlcfAzC2hcPPj0EtWWkNV6+eJRVmTn6Nz9nQMzYhR2ytM+ydxgXH3Oos/BM7wmjUa7VHOD4hShlUr5WjobB25b3rUQQkrX6BjC09n8CCX9WteGHvmwUvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715226789; c=relaxed/simple;
	bh=+68GRNHBH1jBWrr/8ph9Kv5X/9L40RQB6vE0mXnN7V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1nAp59Yp+d61njdUkyY6s7lXSe9I0nY7cN1Ku8M7pJ5iU1xdZ4P2CjVmgmSny4GuOHvhUea/9kQnrWY3nSgjMoP+Lzm5n7Pd0ADP/xL8u9cc0scdawCcH09VfIG9r/2Q47YWZNv+wLna/vRdkRpOnGqvDFS9cTl7602vtVwDOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Soah4PO8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715226785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCcmKp6zmQN78GXbnv+RsBfflPl7otSTmRS2SgT3gkA=;
	b=Soah4PO8i390gOpRXL69KObMYETstGC+xmJzrgO2w+RKMwKqNAE+GpeWUaHeuYgxSkGNGv
	FwWtC4IJjLlGauaws5wfrfh3aOSJvbuIiUWUB6zyQJ16VCE/G1eN286bL8y3EmQLeNena7
	lRpyq9NMisba9qb3LswHDwXm11QGrfc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-W7pSZSILNT2NU-yL1iRcpg-1; Wed, 08 May 2024 23:53:02 -0400
X-MC-Unique: W7pSZSILNT2NU-yL1iRcpg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00FEC800053;
	Thu,  9 May 2024 03:53:02 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A6EBE1005B83;
	Thu,  9 May 2024 03:52:59 +0000 (UTC)
Date: Thu, 9 May 2024 11:52:56 +0800
From: Baoquan He <bhe@redhat.com>
To: Rik van Riel <riel@surriel.com>
Cc: akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] fs/proc: fix softlockup in __read_vmcore
Message-ID: <ZjxImBiQ+niK1PEw@MiWiFi-R3L-srv>
References: <20240507091858.36ff767f@imladris.surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507091858.36ff767f@imladris.surriel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hi,

On 05/07/24 at 09:18am, Rik van Riel wrote:
> While taking a kernel core dump with makedumpfile on a larger system,
> softlockup messages often appear.
> 
> While softlockup warnings can be harmless, they can also interfere
> with things like RCU freeing memory, which can be problematic when
> the kdump kexec image is configured with as little memory as possible.
> 
> Avoid the softlockup, and give things like work items and RCU a
> chance to do their thing during __read_vmcore by adding a cond_resched.

Thanks for fixing this.

By the way, is it easy to reproduce? And should we add some trace of the
softlockup into log so that people can search for it and confirm when
encountering it?

Thanks
Baoquan

> ---
>  fs/proc/vmcore.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 1fb213f379a5..d06607a1f137 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -383,6 +383,8 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
>  		/* leave now if filled buffer already */
>  		if (!iov_iter_count(iter))
>  			return acc;
> +
> +		cond_resched();
>  	}
>  
>  	list_for_each_entry(m, &vmcore_list, list) {
> -- 
> 2.42.0
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


