Return-Path: <linux-kernel+bounces-275996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC67948D09
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A941F24BA6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8D81BDA80;
	Tue,  6 Aug 2024 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVfaRy73"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76245161310
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941116; cv=none; b=mytOk3RowyOD+pGgiLrmcuZcxmtvjxg8SacJ/TcXPgik6oa6S5OfS1y/LJo0tr0LtqDznaGCypPwDNKw4/MYujw3dGWwuD7LjD3jt9Y0qtVUHjM4EX5lKb9ovsrOrePKRT3hIMQHU5BdIeWA8+IaT3hiMvBs0Z8+CT1j28dAQnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941116; c=relaxed/simple;
	bh=+vmp79Qb3Tls6NjnMxfgvb4gLjW13lPFJ1eRIACcW78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfAmqg3LyFDgs9vM3twMPRaWzgwBD1R9dzw2wabuNIYHaN8hHaAm62qA+msvQejIHLV/ZCjBli6CbYl3DZ+ZEaDiGkXMDhakmnFKU8ryZ/lkFZJRHQ+AtbSqFn2BzfIfs0x6ZCukLL4jmjjkc9BcB/fi1Dq4WFjhA5QKxbnbLRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVfaRy73; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722941113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gf7zpjnUN0wmUdYB8KWoxMfwdTSfpBnwuV6brudHc/Q=;
	b=cVfaRy738JRG5pSmq6tV9+dJfNoXf2sVo8Ms+Jgc8Adymx/B38gyLv/aLRDpOJw8ZZa5Vk
	kcz0xNIBDrjtmOmTP1mVxzKf82t1iYOEn/cUmVzLcSs9k4GicTgN4q0An912JhfEgDJevQ
	XgZ/E6UnNbeFIzujfzhmjc1vIaSznS8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-NAKf1IueNUu23MhVLxz5bQ-1; Tue,
 06 Aug 2024 06:45:10 -0400
X-MC-Unique: NAKf1IueNUu23MhVLxz5bQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0170019560A2;
	Tue,  6 Aug 2024 10:45:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.155])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B3A1F1955D42;
	Tue,  6 Aug 2024 10:45:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  6 Aug 2024 12:45:05 +0200 (CEST)
Date: Tue, 6 Aug 2024 12:45:00 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH 2/8] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <20240806104500.GA20881@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-3-andrii@kernel.org>
 <20240805134418.GA11049@redhat.com>
 <CAEf4BzYvkAYL4pPcA7ayiR_VT=g4Y1SMZy4MNX3QEV3H=PjYvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYvkAYL4pPcA7ayiR_VT=g4Y1SMZy4MNX3QEV3H=PjYvw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 08/05, Andrii Nakryiko wrote:
>
> On Mon, Aug 5, 2024 at 6:44 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 07/31, Andrii Nakryiko wrote:
> > >
> > > @@ -732,11 +776,13 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
> > >       uprobe->ref_ctr_offset = ref_ctr_offset;
> > >       init_rwsem(&uprobe->register_rwsem);
> > >       init_rwsem(&uprobe->consumer_rwsem);
> > > +     RB_CLEAR_NODE(&uprobe->rb_node);
> >
> > I guess RB_CLEAR_NODE() is not necessary?
>
> I definitely needed that with my batch API changes, but it might be
> that I don't need it anymore. But I'm a bit hesitant to remove it,

OK, lets keep it, it doesn't hurt. Just it wasn't clear to me why did
you add this initialization in this patch.

> > > @@ -1286,15 +1296,19 @@ static void build_probe_list(struct inode *inode,
> > >                       u = rb_entry(t, struct uprobe, rb_node);
> > >                       if (u->inode != inode || u->offset < min)
> > >                               break;
> > > +                     u = try_get_uprobe(u);
> > > +                     if (!u) /* uprobe already went away, safe to ignore */
> > > +                             continue;
> > >                       list_add(&u->pending_list, head);
> >
> > cosmetic nit, feel to ignore, but to me
> >
> >                         if (try_get_uprobe(u))
> >                                 list_add(&u->pending_list, head);
> >
> > looks more readable.
>
> It's not my code base to enforce my preferences, but I'll at least
> explain why I disagree. To me, something like `if (some condition)
> <break/continue>;` is a very clear indication that this item (or even
> the rest of items in case of break) won't be processed anymore.
>
> While
>
> if (some inverted condition)
>    <do some something useful>
> <might be some more code>

OK, I won't insist. To me the most confusing part is

	u = try_get_uprobe(u);
	if (!u)
	...

If you read this code for the 1st time (or you are trying to recall it
after 10 years ;) it looks as if try_get_uprobe() can return another uprobe.

> So I'll invert this just to not be PITA, but I disagree :)

If you disagree, then don't change it ;)

Oleg.


