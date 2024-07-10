Return-Path: <linux-kernel+bounces-248212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F6592D9F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E423A1C212A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9242B196D8E;
	Wed, 10 Jul 2024 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjSL9Kld"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D014F1E2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720642725; cv=none; b=ThB/MZ9cuobagjLb0yIC3ZFG5SaBgMWOPSqqwBJ9EhMBwrk+H6phiyCCEZP+9rSC9o8RDFX6jCfJBMSmHAgWYgk6jULzhwXfJBhLsUvnBpFvh6/NwcDgJL+6c8FFx9rFw7aEAWt6fBhsBdq++J4V58ktRD/z679xoMbPA9yzaPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720642725; c=relaxed/simple;
	bh=g4E4i+TiwqwSRmK30hc/s/c1QF38lU+sxoqvVxBMhmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRQExippaJ/A/tdjSDw6qVckq6L6BTCdPGBbt04u2xOJsai+aNED6745PHd8Ijoe7SqydtXFqqtTU8lsdpUkSAlY8AgueqEs2znBrbAZlFvuoboRKJNYm1qjjxY0QT6M5yOm+PJAyLZYO5Oa6M+VBbkAHxaNCudmSIvNtucPEzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JjSL9Kld; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720642723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PNhdQqdNC1QXjlFKr3iKy7n7S9eK4noCRcaC5p8aotM=;
	b=JjSL9KldsbJT90k9Omn5nUdmY/+Sdz6zTaxLE9+iKXBbXD+ZaYugLYIhI+y4yFxyvSHs2p
	+loNStJx/GejcWb1nMEDR9tb8fd0QVo85DlKX9y04Weyfs/Ucgb81/hk51k35o5P6xwYQk
	kLf53VhnGOSN12wAu75XBI9l8ZYe0LU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-PG2N21n5O66C9Iqye3CeSw-1; Wed,
 10 Jul 2024 16:18:35 -0400
X-MC-Unique: PG2N21n5O66C9Iqye3CeSw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 950DE19560BA;
	Wed, 10 Jul 2024 20:18:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8749C1956046;
	Wed, 10 Jul 2024 20:18:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 10 Jul 2024 22:16:57 +0200 (CEST)
Date: Wed, 10 Jul 2024 22:16:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org,
	clm@meta.com, jolsa@kernel.org, mingo@kernel.org,
	paulmck@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] uprobes: make uprobe_register() return struct uprobe
 *
Message-ID: <20240710201651.GG9228@redhat.com>
References: <20240710140017.GA1074@redhat.com>
 <20240710163022.GA13298@redhat.com>
 <20240710163133.GD13298@redhat.com>
 <CAEf4BzZa0Ye83QfTbw6Sw3ERg2PJ7ioN_pEFHYui6JGEHhOg4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZa0Ye83QfTbw6Sw3ERg2PJ7ioN_pEFHYui6JGEHhOg4Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/10, Andrii Nakryiko wrote:
>
> On Wed, Jul 10, 2024 at 9:33 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > This way uprobe_unregister() and uprobe_apply() do not need find_uprobe() +
> > put_uprobe(). And to me this change simplifies the code a bit.
> >
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> > ---
> >  include/linux/uprobes.h     | 14 ++++++------
> >  kernel/events/uprobes.c     | 45 ++++++++++++-------------------------
> >  kernel/trace/bpf_trace.c    | 12 +++++-----
> >  kernel/trace/trace_uprobe.c | 28 +++++++++++------------
> >  4 files changed, 41 insertions(+), 58 deletions(-)
> >
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index aa89a8b67039..399509befcf4 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
>
> I don't see struct uprobe forward-declared in this header, maybe we
> should add it?

Probably yes, thanks... Although the current code already uses
struct uprobes * without forward-declaration at least if CONFIG_UPROBES=y.
Thanks, will add.

> >  static inline int
> > -uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool add)
> > +uprobe_apply(struct uprobe* uprobe, struct uprobe_consumer *uc, bool add)
> >  {
> >         return -ENOSYS;
> >  }
>
> complete aside, when I was looking at this code I was wondering why we
> even need uprobe_apply, it looks like some hacky variant of
> uprobe_register and uprobe_unregister.

All I can say is that

	- I can hardly recall this logic, I'll try to do this tomorrow
	  and write another email

	- in any case this logic is ugly and needs more cleanups

	- but this patch only tries to simplify this code without any
	  visible changes.

> > @@ -1133,41 +1126,39 @@ EXPORT_SYMBOL_GPL(uprobe_unregister);
> >   * refcount is released when the last @uc for the @uprobe
> >   * unregisters. Caller of uprobe_register() is required to keep @inode
> >   * (and the containing mount) referenced.
> > - *
> > - * Return errno if it cannot successully install probes
> > - * else return 0 (success)
>
> mention that it never returns NULL, but rather encodes error code
> inside the pointer on error? It's an important part of the contract.

OK...

> >  /*
>
> this should be /** for doccomment checking (you'd get a warning for
> missing @uprobe if there was this extra star)

Well, this is what we have before this patch, but OK

> >   * uprobe_apply - unregister an already registered probe.
> > - * @inode: the file in which the probe has to be removed.
> > - * @offset: offset from the start of the file.
>
> add @uprobe description now?

If only I knew what this @uprobe description can say ;)

> > @@ -3180,10 +3181,8 @@ static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
> >  {
> >         u32 i;
> >
> > -       for (i = 0; i < cnt; i++) {
> > -               uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset,
> > -                                 &uprobes[i].consumer);
> > -       }
> > +       for (i = 0; i < cnt; i++)
>
> you'll now need !IS_ERR_OR_NULL(uprobes[i].uprobe) check (or just NULL
> check if you null-out it below)

Hmm... are you sure? I'll re-check... See also the end of my email.

> > @@ -3477,11 +3476,12 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >                       &bpf_uprobe_multi_link_lops, prog);
> >
> >         for (i = 0; i < cnt; i++) {
> > -               err = uprobe_register(d_real_inode(link->path.dentry),
> > +               uprobes[i].uprobe = uprobe_register(d_real_inode(link->path.dentry),
>
> will uprobe keep inode alive as long as uprobe is attached?

Why? No, this patch doesn't (shouldn't) change the current behaviour.

The users still need kern_path/path_put to, say, prevent umount.

> we can NULL-out uprobe on error for bpf_uprobe_unregister() to handle
> only NULL vs non-NULL case

Not sure I understand...

> or maybe better yet let's just have local struct uprobe variable and
> only assign it if registration succeeded

We can, but

> (still need NULL check in
> bpf_uprobe_unregister above)

Why?

If bpf_uprobe_unregister() is called by bpf_uprobe_multi_link_attach() on
error, it passes cnt = i where is the 1st failed uprobe index. IOW,
uptobes[i].uprobe can't be IS_ERR_OR_NULL() in the 0..cnt-1 range.

If it is called by bpf_uprobe_multi_link_release() then the whole
0..umulti_link->cnt-1 range should be fine?

Oleg.


