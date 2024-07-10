Return-Path: <linux-kernel+bounces-248185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A378D92D939
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1F31F21AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBD7197A97;
	Wed, 10 Jul 2024 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rw1tD+o1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E3619581F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720640079; cv=none; b=ZbGtzik42VWQvYxffthoHefn9WKp6I0p+aCImGeSc5pBscqpKNCFE27uivWAnqOte6LXFWvej+nnJdGeWn48w7rw+kwVyS0dS8hJGdGLd7E8HLBEOF4AhkgsvlASAH8Pdw8SdeaL6GvmXwq1EDBMdFcxn3bU1FlQ2w8j8DLqJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720640079; c=relaxed/simple;
	bh=64t0Aq4QgYaKBUkQonjMvxKiLmYxKlraga+aohTNPeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf4X8E5meYiZVyGHLmyUt+2VrYVudktRmP73v28yz4xCr55ifsHZ+bRPxWB3OF1tqBaS7jfMlNrH+voSoDoescsjesT+5x3KA1XS4r8oI/J/Y787CI+mgjFJwMPGBvTYFZ2eboWT9ZNHMnLlVZP2SBLucXcdo0hC9QMZSuIqooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rw1tD+o1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720640077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eOesnJNRQi3jaBPH6NJfpUI/R/hKqS/yl/hzu4dJSVA=;
	b=Rw1tD+o1PPkpGVeIQqn9zY7JjiM0yTH8cjKaSIdUJT+bNbhPzIM4mrmR0QfveQjdLkpEDh
	z0yBratesNQBtbgMVbzFLm7XSlbMr0q1LP9tNjC11TQkEZGmPHS8U6/+Mr4L2VgJONaMa4
	zkhz8snd09LWhlG3grIQkp/IoH0tOyI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-3qm987oGP2yOPMv4RhNh_A-1; Wed,
 10 Jul 2024 15:34:29 -0400
X-MC-Unique: 3qm987oGP2yOPMv4RhNh_A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA6E5195608A;
	Wed, 10 Jul 2024 19:34:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id ABA071955F3B;
	Wed, 10 Jul 2024 19:34:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 10 Jul 2024 21:32:50 +0200 (CEST)
Date: Wed, 10 Jul 2024 21:32:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org,
	clm@meta.com, jolsa@kernel.org, mingo@kernel.org,
	paulmck@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] uprobes: kill uprobe_register_refctr()
Message-ID: <20240710193245.GF9228@redhat.com>
References: <20240710140017.GA1074@redhat.com>
 <20240710163022.GA13298@redhat.com>
 <20240710163047.GB13298@redhat.com>
 <CAEf4BzZScUsh94P67-1rKOj=26ycj87nmT0fBrP9BvvmxAi8kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZScUsh94P67-1rKOj=26ycj87nmT0fBrP9BvvmxAi8kQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/10, Andrii Nakryiko wrote:
>
> LGTM with few nits below.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks for looking at this.

> > @@ -3477,7 +3477,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >                       &bpf_uprobe_multi_link_lops, prog);
> >
> >         for (i = 0; i < cnt; i++) {
> > -               err = uprobe_register_refctr(d_real_inode(link->path.dentry),
> > +               err = uprobe_register(d_real_inode(link->path.dentry),
> >                                              uprobes[i].offset,
> >                                              uprobes[i].ref_ctr_offset,
> >                                              &uprobes[i].consumer);
>
> please adjust indentation here

OK,

> > -       if (tu->ref_ctr_offset)
> > -               ret = uprobe_register_refctr(tu->inode, tu->offset,
> > -                               tu->ref_ctr_offset, &tu->consumer);
> > -       else
> > -               ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
> > -
> > +       ret = uprobe_register(tu->inode, tu->offset, tu->ref_ctr_offset,
> > +                             &tu->consumer);
>
> doesn't fit under 100 characters? If it does, please keep as a single line.

OK, will do.

Oleg.


