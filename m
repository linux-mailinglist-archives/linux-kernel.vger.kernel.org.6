Return-Path: <linux-kernel+bounces-329914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADB9979760
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 17:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 042C0B21344
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 15:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC771C7B7C;
	Sun, 15 Sep 2024 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcDdhwFq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401AC42A8B
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726412696; cv=none; b=sTa0U7fHiWcktfONZ6QXAW/AO1X0iIG8Od581f93/RtLr/Cm1guGRGAQUSyIh6OPOUyyAXXzkUF16GjfO2W52mQiyXug+ZhworzbdwptF82AtKHLW9m8LKOPDwG0uCEbz+BjqTPYHadX6C6PVnvbpFHnrhojwkzUum/hFNTnVPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726412696; c=relaxed/simple;
	bh=muriC4vnR1Pgp6FrCmeUYns5egLK2oHEwfG6/WSz7Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW8gM8cHFrpEL5DkhdjO93WhDcFN9G+ewLYImdTddHMmMYJ680YGsky8UcKK5QBxp7hbV1O9LyJm8vdIlzrv6ksRZAteKylmErUvu3CVxplO5WOIUmsrQ6aCHkjrPbNcyq4EzRYvzQy5Fb8zGo1Eqm80EirNX9jZbrMeCgayFtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcDdhwFq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726412694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgPXoGAgWEmJuNaNaMNmxrMHZdG9YhV6gHMHUQ6h5z0=;
	b=GcDdhwFqcUHBCmLwEvMTEGRhOZGsEW+IYbpf39Gxau8XcpqbYDP+GDj283GhHRaMBv8ioA
	ttdHGgJKprPCQ4/n7FKz5FPDbawUGfUA0QCscfuzhj344HoKiMrSKIme/crSTa7rOYZ06/
	GlctNiEAPotcWxCTkgzf8Ze7ZAmzP+Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-JbosABjIMUe7gj9-zuvLyw-1; Sun,
 15 Sep 2024 11:04:52 -0400
X-MC-Unique: JbosABjIMUe7gj9-zuvLyw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0DA119560B1;
	Sun, 15 Sep 2024 15:04:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 09EE51956086;
	Sun, 15 Sep 2024 15:04:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 15 Sep 2024 17:04:37 +0200 (CEST)
Date: Sun, 15 Sep 2024 17:04:30 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, mjguzik@gmail.com, brauner@kernel.org,
	jannh@google.com
Subject: Re: [PATCH 2/2] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
Message-ID: <20240915150429.GC27726@redhat.com>
References: <20240906051205.530219-1-andrii@kernel.org>
 <20240906051205.530219-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906051205.530219-3-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 09/05, Andrii Nakryiko wrote:
>
> +static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
> +{
> +	const vm_flags_t flags = VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE;
...
> +	if (!vm_file || (vma->vm_flags & flags) != VM_MAYEXEC)
> +		goto bail;

Not that this can really simplify your patch, feel free to ignore, but I don't
think you need to check vma->vm_flags.

Yes, find_active_uprobe_rcu() does the same valid_vma(vma, false) check, but it
too can/should be removed, afaics.

valid_vma(vma, false) makes sense in, say, unapply_uprobe() to quickly filter
out vma's which can't have this bp installed, but not in the handle_swbp() paths.

Oleg.


