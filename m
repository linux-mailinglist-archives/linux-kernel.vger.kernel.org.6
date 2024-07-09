Return-Path: <linux-kernel+bounces-246051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE15B92BD09
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A79D1C239AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCBE19D068;
	Tue,  9 Jul 2024 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQjHQkhr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095AF19CCEF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535689; cv=none; b=Szr3wAnanvYHOKkIeme1KIUW8Medf2MBjeMvlJUzU2re8XLUdlsOhcN2LVarJjZvygu73e/lUy+6Ma5Vf/+LevQBXC0drchB6Y3HxurhyFCIoaFR02vlH5WScn5VpfXJ9fCbeBe8ex4IV9rFmdhflccf1VE8Q/EOfCrmkGZBbdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535689; c=relaxed/simple;
	bh=c0tyW1ijVrR7xsv9J8MUnpSWSwHDTldwccl5EfWtEtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2W/+XRkFR/uhbe4jjluLQh5Uv9D8OiLIKZDqLHaU4cWHmO43l9oCVy5mMOONtFlJfkQ7kVo7P1Q8xG8wNEEOrHkdBrNas86bZ2ioMbsxVs/o9i9/IhY7nIJD6gxrxXYpVtQ+3QUyRXyT+jmsIiJ8Xlq3LBAlfAUPT2sdzo/OIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQjHQkhr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720535687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PucfIIVLf+L1XCVXEbmqJcQ5iJs8yaBnEDX4Ck00ukA=;
	b=ZQjHQkhrmP5GYOzfmV5XqE5JpYQplmtzaWC05pImsU85CoNXeQ7GAD4guCt4CzJ9zPv6w6
	zNbmdgQ4bMHi4/mnEC8fY+Dj7LgH+dTL5gP1RB9qPOY4BtA0VaiCySTp5DnsCCnN1CQxNb
	FS+DDssOQ8pwR99Chf4Mf+WzCewQVCg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-xYeDQG77NlarONmXKcIg5w-1; Tue,
 09 Jul 2024 10:34:43 -0400
X-MC-Unique: xYeDQG77NlarONmXKcIg5w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3B991955BCD;
	Tue,  9 Jul 2024 14:34:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.34])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A51E71953967;
	Tue,  9 Jul 2024 14:34:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  9 Jul 2024 16:33:05 +0200 (CEST)
Date: Tue, 9 Jul 2024 16:32:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 04/10] perf/uprobe: RCU-ify find_uprobe()
Message-ID: <20240709143255.GD28495@redhat.com>
References: <20240708091241.544262971@infradead.org>
 <20240708092415.579623285@infradead.org>
 <20240708163545.GB18761@redhat.com>
 <20240708180837.GC27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708180837.GC27299@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/08, Peter Zijlstra wrote:
>
> On Mon, Jul 08, 2024 at 06:35:45PM +0200, Oleg Nesterov wrote:
> >
> > Suppose we have uprobe U which has no extra refs, so uprobe_unregister()
> > called by the task X should remove it from uprobes_tree and kfree.
> >
> > Suppose that the task T hits the breakpoint and enters handle_swbp().
> >
> > Now,
> >
> > 	- X calls find_uprobe(), this increments U->ref from 1 to 2
> >
> > 	  register_for_each_vma() succeeds
> >
> > 	  X enters delete_uprobe()
> >
> > 	- T calls find_active_uprobe() -> find_uprobe()
> >
> > 	  __read_seqcount_begin__read_seqcount_begin() returns an even number
> >
> > 	  __find_uprobe() -> rb_find_rcu() succeeds
> >
> > 	- X continues and returns from delete_uprobe(), U->ref == 1
> >
> > 	  then it does the final uprobe_unregister()->put_uprobe(U),
> > 	  refcount_dec_and_test() succeeds, X calls call_rcu(uprobe_free_rcu).
> >
> > 	- T does get_uprobe() which changes U->ref from 0 to 1, __find_uprobe()
> > 	  returns, find_uprobe() doesn't check read_seqcount_retry().
>
> I think you're right. However, this get_uprobe() will go away in a few
> patches.

OK, I am looking at 7/10 perf/uprobe: Convert (some) uprobe->refcount to SRCU

Yes, __find_uprobe() no longer does get_uprobe(). But at first glance we have
the same problem with this change

	@@ -1977,7 +1979,7 @@ pre_ssout(struct uprobe *uprobe, struct
			return err;
		}
	 
	-	utask->active_uprobe = uprobe;
	+	utask->active_uprobe = get_uprobe(uprobe);
		utask->state = UTASK_SSTEP;
		return 0;
	 }

from 7/12 above. It can change uprobe->ref from 0 to 1 when
call_srcu(&uprobes_srcu, uprobe_free_rcu) was already scheduled.

Once guard(srcu)(&uprobes_srcu) in handle_swbp() drops the uprobes_srcu lock,
utask->active_uprobe can be freed.

Oleg.


