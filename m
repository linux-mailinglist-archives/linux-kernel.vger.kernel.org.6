Return-Path: <linux-kernel+bounces-218158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0304B90B9DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC39B1F21D24
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1108197A96;
	Mon, 17 Jun 2024 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jl3H4hSX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A140E225AE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649580; cv=none; b=VX2JFLsZJEo1hbcQBh+JaPBC5hT0GBWrIlww4JMdDYwZ/CKzr0n7VYt150w5bTiETVNu1smGZZkXUer5uC7H+ZNIymXmdezHV1zeUionfAZ/CTy9sWGCFBhFdLvtVWhjKAoV0p6m+anGGPlkaSMbE2Igq22WhF/yIQoabf57cF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649580; c=relaxed/simple;
	bh=hTuDB9qh0rJXHe6YdUBt+jJ5wEiJCYi0ouiG3MHctwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIsycMKfjewF23cXSfWYg0BbT/JV3GrjxI24bHR+uatkIqzpVi61jSzXZHe4P1wfi1XKb67dwN8o9SymSPVfmOHyL33q5TF/ynCgfwhknNHJhWvUOJa/gWTk3FCveWguxge6v7psuRB69mFR0k0TZROQaLGo5VepXbXttIgT33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jl3H4hSX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718649577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aYQPlAErAShHjMCF45zeR7kIJUJ9WeahDrlg6o/nGsg=;
	b=Jl3H4hSXffLs1qmN7MjhrkQF4l/FPR+seyEmZGy/86BugLc0eod/FJhbLTvNb2o0wFUzQR
	xsxfb3Ud0b17OVNDxtY3SmJRmtCeRft1sjZZouQDfvCFAl7fpDjLHUZuF4Bs3vac7a1stt
	2vR7Cq+qlmo35TLc6OUbjEEOu3gbujk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-CGZNS3o2OfyE8YqfTISfCQ-1; Mon,
 17 Jun 2024 14:39:34 -0400
X-MC-Unique: CGZNS3o2OfyE8YqfTISfCQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D487D19560B3;
	Mon, 17 Jun 2024 18:39:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.89])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DE32219560B2;
	Mon, 17 Jun 2024 18:39:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 17 Jun 2024 20:38:01 +0200 (CEST)
Date: Mon, 17 Jun 2024 20:37:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] exit: kill signal_struct->quick_threads
Message-ID: <20240617183758.GB10753@redhat.com>
References: <20240609142342.GA11165@redhat.com>
 <87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
 <20240610152902.GC20640@redhat.com>
 <20240613154541.GD18218@redhat.com>
 <87ikyamf4u.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikyamf4u.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 06/15, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > Eric, do you agree with this patch or not?
>
> I really don't.

OK, I won't insist.

If nothing else, I failed to remove the usage of signal->live in cgroup.c
and this patch (supposed to be a cleanup) can slightly affect the cgroup
iterators.

But. You didn't mention cgroups, so lets forget cgroups to simplify this
discussion.

So. I would like to see at least ONE _technical_ objection to this patch.

Once again, I was worried about this cleanup from the very beginning, that is
why I asked you to review. Thanks for taking a look. But could you help me to
understand what exactly you don't like?

> I think skipping some work if SIGNAL_GROUP_EXIT is already
> set is not necessarily wrong.

OK, so you seem to agree with this part after all.

> I think we need the quick_threads count,

And so far I fail to understand this,

> and related cleanups.
> I was hoping to be able to post a patchset with this reply
> to explain things, but it looks like that is still a couple
> of days off.

OK. This looks as if I need to wait for your cleanups to understand
why do we need quick_threads even if we move atomic_dec_and_test(live)
to the very start of do_exit().

Okay, I'll have to wait.

And. To me the current placement of atomic_dec_and_test(signal->live)
looks "random" no matter what. Even if we forget about cgroups.

> Where I was going, and where I think we should go with quick_threads is
> an exit path that is much easier to reason about and maintain.  But the
> decrement needs to move into the same code that sets SIGNAL_GROUP_EXIT.
> Which makes it something very different from signal->live.

Still can't understand, but see above. Quite possibly I missed something.
I will wait for your patchset.

Oleg.


