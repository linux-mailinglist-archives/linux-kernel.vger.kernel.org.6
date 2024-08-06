Return-Path: <linux-kernel+bounces-276015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A609948D45
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5AE280CA4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B3E1C0DD3;
	Tue,  6 Aug 2024 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmvaCt3X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058F8161310
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941666; cv=none; b=L7Db1apxuy5g2wwUloZ/ClPs7jPwM3AOGnCKVmLtnXKh0gyjXYirMMHEpFKHBVngOJjf510f5KJgolCFw7M1uFEgjtMv28V2UgUUPVu4SFvHogAZ1fQz1c8mhnGsSV1y9pe7D/z6bEtaFpI/SQcT0qAC9tdzTH9LG8OFk0Ss9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941666; c=relaxed/simple;
	bh=QI76W/6+qyfi/f/458udiZ+vMPBWVCY8s3vj6UfuSig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6Lx4TF4uO88tlymnJysop1EEFXjoHpnPDJWljUiLWa/bU5PcDFMqXXM8OE+5VnxLl/NW3gX4QdFlF/3Myyd4V9/c5WSJA2GAj6wRUeeu1SqoaUgf6CbCHCV4paY1AjSJ9CbS8jTsNQ8XBBcXZokb+LEAZd+TefQOAYUTNdNyUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmvaCt3X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722941662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gegv+FUrL3Bk/gUnU9MjiVdI0lIqs6KIEoJQDH9Pkv4=;
	b=VmvaCt3XqgINwOWj5yTeYIQxFI+wuUTHYrFEdqEEnWVmxxa7NLK8ywXZF0oiNkZ/Fq/Udm
	vu/s4iac0bgeMrXmG/NHmasribgdLUA/dw3U+QByj8WpmTHsr2Zdqn7VclyfFGKxup3Dfi
	RsnAnHFnh3tuWvbAeZCh9LXwaUoJkCk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-WwuZVDk4MyCT6EGtkw8uxA-1; Tue,
 06 Aug 2024 06:54:21 -0400
X-MC-Unique: WwuZVDk4MyCT6EGtkw8uxA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C1AE19560AA;
	Tue,  6 Aug 2024 10:54:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.155])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EABC81955D44;
	Tue,  6 Aug 2024 10:54:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  6 Aug 2024 12:54:16 +0200 (CEST)
Date: Tue, 6 Aug 2024 12:54:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH 5/8] uprobes: travers uprobe's consumer list locklessly
 under SRCU protection
Message-ID: <20240806105411.GB20881@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-6-andrii@kernel.org>
 <20240805155931.GC11049@redhat.com>
 <CAEf4BzZ=W3JLfpYcxEevMGS4whXQ2-nn5ezA+p3zV_WhiGG4iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ=W3JLfpYcxEevMGS4whXQ2-nn5ezA+p3zV_WhiGG4iQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/05, Andrii Nakryiko wrote:
>
> On Mon, Aug 5, 2024 at 8:59 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > >  int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool add)
> > >  {
> > >       struct uprobe_consumer *con;
> > > -     int ret = -ENOENT;
> > > +     int ret = -ENOENT, srcu_idx;
> > >
> > >       down_write(&uprobe->register_rwsem);
> > > -     for (con = uprobe->consumers; con && con != uc ; con = con->next)
> > > -             ;
> > > -     if (con)
> > > -             ret = register_for_each_vma(uprobe, add ? uc : NULL);
> > > +
> > > +     srcu_idx = srcu_read_lock(&uprobes_srcu);
> > > +     list_for_each_entry_srcu(con, &uprobe->consumers, cons_node,
> > > +                              srcu_read_lock_held(&uprobes_srcu)) {
> > > +             if (con == uc) {
> > > +                     ret = register_for_each_vma(uprobe, add ? uc : NULL);
> > > +                     break;
> > > +             }
> > > +     }
> >
> > we can probably remove the similar check above?
> >
> > I mean, why do we need the list_for_each_entry_srcu() above? Is it possible
> > that uprobe_apply(uprobe, uc) is called when "uc" is not on the ->consumers
> > list?
>
> Tbh, I just don't completely understand how (and why) uprobe_apply()
> is used from kernel/trace/trace_uprobe.c, so I wanted to preserve the
> logic exactly. I still don't see when this consumer is added before
> uprobe_apply()... Exposing uprobe_apply() seems like a huge API
> violation to me and I'd rather get rid of its users. But one step at a
> time.

Agreed. Unlike uprobe_unregister(), uprobe_apply() doesn't WARN() or
even explains this check, lets preserve the current logic for now.

And just in case... I am not sure too that the con == NULL case is not
possible with the current code. The recent discussions forced me to recall
some bits in uprobe.c, but not in trace_uprobe.c ;)

Oleg.


