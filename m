Return-Path: <linux-kernel+bounces-229861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EDE917544
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A9C28209B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1ED79E5;
	Wed, 26 Jun 2024 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRWwrH+T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E57179CE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719362348; cv=none; b=gLSAzvTIupDHNn4ynam+z+NF7tauwS74g49PE3oqXBj3qv8I/UDnZGLEuKXIxXZm4HThhOj9yliWnYI4MRaHFhKzuqTXxN5pvHkDSLp5C1nUS5oV4iKdKsubEqzpwBnQjC8I0nolTcryuTt3o7PmoFgN7xdKAIjd/dnGIvsUJCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719362348; c=relaxed/simple;
	bh=vph3snsBVbClZGIZjxHgwbgS1GlkN+zSDa1EVBnWpbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEFXpPxAfbJUyC+wLBs0QjqMkGc51vRmQLhMDoBxyS19mkMuUpCspzEX75GhMabYlmn7nAZpAYXgsqTEp+SzJ15ltZXW1hhS5bpvDEdc+DlbUiOksaf5HEMwDa81skVu1GWtwuho5V+0KSGk3M5vbErynpiIXwOuIn6x/5EwoTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRWwrH+T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719362346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7cosekoPKXkwrvYHFRpUSibVa04zhxh3op5EgjNV2M=;
	b=eRWwrH+TL69cofXtP9qbkfuft55T8GgtN2Bi449Y8A43mUuOYuBk8ry2UkZ7oGNN/g7Zz9
	JCdlLiyl42O2XagHiJ1Ja0Ye50t+dg5MSlbEQ/njaRMl1qgxiAOgxlSoXMX6gSs55wbuzf
	fFJPE0okuCeHX7ZdA/ZJccbJvEZzAaE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-69KgG4rkNx2VmvWPFkVUAQ-1; Tue,
 25 Jun 2024 20:39:03 -0400
X-MC-Unique: 69KgG4rkNx2VmvWPFkVUAQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54DA419560B2;
	Wed, 26 Jun 2024 00:39:02 +0000 (UTC)
Received: from localhost (unknown [10.72.116.8])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4B381956087;
	Wed, 26 Jun 2024 00:39:00 +0000 (UTC)
Date: Wed, 26 Jun 2024 08:38:56 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Nick Bowler <nbowler@draconx.ca>, Hailong Liu <hailong.liu@oppo.com>,
	linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <ZntjIE6msJbF8zTa@MiWiFi-R3L-srv>
References: <Znljtv5n-6EBgpsF@pc636>
 <Zno52QBG0g5Z+otD@MiWiFi-R3L-srv>
 <ZnqcuKt2qrR-wmH3@pc636>
 <ZnqspTVl/76jM9WD@MiWiFi-R3L-srv>
 <Znq6tEtCgB6QnnJH@pc638.lan>
 <Znq/8/HAc/0p6Ja0@MiWiFi-R3L-srv>
 <ZnrjZRq5-_hemrbD@pc636>
 <ZnrnADHvOiNcZv9t@MiWiFi-R3L-srv>
 <Znr1IQ1mssdNNXbv@pc638.lan>
 <ZnsjIB2byIxSgbjc@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnsjIB2byIxSgbjc@pc636>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 06/25/24 at 10:05pm, Uladzislau Rezki wrote:
> > > > > > /**
> > > > > >  * cpumask_next - get the next cpu in a cpumask
> > > > > >  * @n: the cpu prior to the place to search (i.e. return will be > @n)
> > > > > >  * @srcp: the cpumask pointer
> > > > > >  *
> > > > > >  * Return: >= nr_cpu_ids if no further cpus set.
> > > > > 
> > > > > Ah, I got what you mean. In the vbq case, it may not have chance to get
> > > > > a return number as nr_cpu_ids. Becuase the hashed index limits the
> > > > > range to [0, nr_cpu_ids-1], and cpu_possible(index) will guarantee it
> > > > > won't be the highest cpu number [nr_cpu_ids-1] since CPU[nr_cpu_ids-1] must
> > > > > be possible CPU.
> > > > > 
> > > > > Do I miss some corner cases?
> > > > > 
> > > > Right. We guarantee that a highest CPU is available by doing: % nr_cpu_ids.
> > > > So we do not need to use *next_wrap() variant. You do not miss anything :)
> > > > 
> > > > Hailong Liu has proposed more simpler version:
> > > > 
> > > > <snip>
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 11fe5ea208aa..e1e63ffb9c57 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -1994,8 +1994,9 @@ static struct xarray *
> > > >  addr_to_vb_xa(unsigned long addr)
> > > >  {
> > > >         int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > +       int cpu = cpumask_nth(index, cpu_possible_mask);
> > > > 
> > > > -       return &per_cpu(vmap_block_queue, index).vmap_blocks;
> > > > +       return &per_cpu(vmap_block_queue, cpu).vmap_blocks;
> > > > <snip>
> > > > 
> > > > which just takes a next CPU if an index is not set in the cpu_possible_mask.
> > > > 
> > > > The only thing that can be updated in the patch is to replace num_possible_cpu()
> > > > by the nr_cpu_ids.
> > > > 
> > > > Any thoughts? I think we need to fix it by a minor change so it is
> > > > easier to back-port on stable kernels.
> > > 
> > > Yeah, sounds good since the regresson commit is merged in v6.3.
> > > Please feel free to post this and the hash array patch separately for
> > > formal reviewing.
> > > 
> > Agreed! The patch about hash array i will post later.
> > 
> > > By the way, when I am replying this mail, I check the cpumask_nth()
> > > again. I doubt it may take more checking then cpu_possible(), given most
> > > of systems don't have gaps in cpu_possible_mask. I could be dizzy at
> > > this moment.
> > > 
> > > static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
> > > {
> > >         return find_nth_bit(cpumask_bits(srcp), small_cpumask_bits, cpumask_check(cpu));
> > > }
> > > 
> > Yep, i do not think it is a big problem based on your noted fact.
> > 
> Checked. There is a difference:
> 
> 1. Default
> 
> <snip>
> ...
> +   15.95%     6.05%  [kernel]        [k] __vmap_pages_range_noflush
> +   15.91%     1.74%  [kernel]        [k] addr_to_vb_xa <---------------
> +   15.13%    12.05%  [kernel]        [k] vunmap_p4d_range
> +   14.17%    13.38%  [kernel]        [k] __find_nth_bit <--------------
> +   10.62%     0.00%  [kernel]        [k] ret_from_fork_asm
> +   10.62%     0.00%  [kernel]        [k] ret_from_fork
> +   10.62%     0.00%  [kernel]        [k] kthread
> ...
> <snip>
> 
> 2. Check if cpu_possible() and then fallback to cpumask_nth() if not
> 
> <snip>
> ...
> +    6.84%     0.29%  [kernel]          [k] alloc_vmap_area
> +    6.80%     6.70%  [kernel]          [k] native_queued_spin_lock_slowpath
> +    4.24%     0.09%  [kernel]          [k] free_vmap_block
> +    2.41%     2.38%  [kernel]          [k] addr_to_vb_xa <-----------
> +    1.94%     1.91%  [kernel]          [k] xas_start
> ...
> <snip>
> 
> It is _worth_ to check if an index is in possible mask:
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 45e1506d58c3..af20f78c2cbf 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2542,7 +2542,10 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
>  static struct xarray *
>  addr_to_vb_xa(unsigned long addr)
>  {
> -       int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> +       int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> +
> +       if (!cpu_possible(index))
> +               index = cpumask_nth(index, cpu_possible_mask);
> 
>         return &per_cpu(vmap_block_queue, index).vmap_blocks;
>  }
> 
> cpumask_nth() is not cheap. My measurements are based on a synthetic
> tight test and it detects a difference. In a real workloads it should
> not be visible. Having gaps is not a common case plus a "slow path"
> will be mitigated by the hit against possible mask.

Ah, this is consistent with my understanding from the code, thanks
for confirming by testing.


