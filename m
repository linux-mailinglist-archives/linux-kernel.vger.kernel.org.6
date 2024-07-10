Return-Path: <linux-kernel+bounces-247803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F1C92D4B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C439A1C2143F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AC11940AB;
	Wed, 10 Jul 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKb6PWRX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316C618787A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624318; cv=none; b=cKuVqt8Lr7pID0WieyOKMT5T/Fn6CTg/6KKy1383vD6QC9soJxydAQOWXdI60ED796I7A/M4qTHe9WnYT4gK2a3/+y03IUR9wX5aPW6lA3Xc89YT7clU9+Kc8aY57rbGFxI8W6OgZ0Voy1NRzxMnja9sfHDXBUXzPZGSjpSaUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624318; c=relaxed/simple;
	bh=LNkBirJQ4adPCXJy9hBCC0jtret24lPR4ivVVOGMngw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1j0Oc/BfifNw0qDq8u+4O7wVd8PvI8FftFbhJYWrWI6uvNIkzkNssKYWICKxKb+vj++/i0mjXMeYUJIjksu017Gqj45YX2y1VJSLCQjq7Qq0jQYh/xvewukxym8zfTPqo0S9BWK/a5R2iw6f045xEaswwIzB9/BIiHM2IJLddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKb6PWRX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720624316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bUIhA3QSLv4hU5TAA/9TEYvwHl6j0Yi+uuny8nmGoic=;
	b=DKb6PWRXeJ6nfdTfeRGjZM0ehf9RFU11InUS5ujZLtJAh/PXwwSOL69/XqWiwcbzQSeGAD
	usI/oehMopRTOsh7gi8Vlk0aOcWn2HnMsNpWWjwDTx1bFelGbib1ZqMCV3AMJ51X/GClyX
	u5XadRYenrHnM9l7CrYbeLnzzLszsy0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-cgl82ntKNYurxl4efZ6vkQ-1; Wed,
 10 Jul 2024 11:11:50 -0400
X-MC-Unique: cgl82ntKNYurxl4efZ6vkQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDE411955F3D;
	Wed, 10 Jul 2024 15:11:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BC41C1955F29;
	Wed, 10 Jul 2024 15:11:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 10 Jul 2024 17:10:12 +0200 (CEST)
Date: Wed, 10 Jul 2024 17:10:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: andrii@kernel.org, peterz@infradead.org, clm@meta.com, jolsa@kernel.org,
	mingo@kernel.org, paulmck@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] uprobes: document the usage of mm->mmap_lock
Message-ID: <20240710151006.GB9228@redhat.com>
References: <20240710140017.GA1074@redhat.com>
 <20240710140045.GA1084@redhat.com>
 <20240710235159.23b8bc0f5247c358ccea699d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710235159.23b8bc0f5247c358ccea699d@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/10, Masami Hiramatsu wrote:
>
> On Wed, 10 Jul 2024 16:00:45 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > The comment above uprobe_write_opcode() is wrong, unapply_uprobe() calls
> > it under mmap_read_lock() and this is correct.
> >
> > And it is completely unclear why register_for_each_vma() takes mmap_lock
> > for writing, add a comment to explain that mmap_write_lock() is needed to
> > avoid the following race:
> >
> > 	- A task T hits the bp installed by uprobe and calls
> > 	  find_active_uprobe()
> >
> > 	- uprobe_unregister() removes this uprobe/bp
> >
> > 	- T calls find_uprobe() which returns NULL
> >
> > 	- another uprobe_register() installs the bp at the same address
> >
> > 	- T calls is_trap_at_addr() which returns true
> >
> > 	- T returns to handle_swbp() and gets SIGTRAP.

...

> >  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> > @@ -1046,7 +1046,12 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
> >
> >  		if (err && is_register)
> >  			goto free;
> > -
> > +		/*
> > +		 * We take mmap_lock for writing to avoid the race with
> > +		 * find_active_uprobe(), install_breakpoint() must not
> > +		 * make is_trap_at_addr() true right after find_uprobe()
> > +		 * returns NULL.
>
> Sorry, I couldn't catch the latter part. What is the relationship of
> taking the mmap_lock and install_breakpoint() and is_trap_at_addr() here?

Please the the changelog above, it tries to explain this race with more
details...

> You meant that find_active_uprobe() is using find_uprobe() which searchs
> uprobe form rbtree?

Yes,

> But it seems uprobe is already inserted to the rbtree
> in alloc_uprobe() so find_uprobe() will not return NULL here, right?

uprobe_register() -> alloc_uprobe() can come after
find_active_uprobe() -> find_uprobe() returns NULL.

Now, if uprobe_register() -> register_for_each_vma() used mmap_read_lock(), it
could do install_breakpoint() before find_active_uprobe() calls is_trap_at_addr().

In this case find_active_uprobe() returns with uprobe == NULL and is_swbp == 1,
handle_swbp() treat this case as the "normal" int3 without uprobe and do

	if (!uprobe) {
		if (is_swbp > 0) {
			/* No matching uprobe; signal SIGTRAP. */
			force_sig(SIGTRAP);

Does this answer your question?

Oleg.


