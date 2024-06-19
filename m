Return-Path: <linux-kernel+bounces-221651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4439390F6C6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866AB284C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F46158A3B;
	Wed, 19 Jun 2024 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRxZbx5B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055B0134A5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718824367; cv=none; b=b8BPp39ClSYbKQxuL/qgeRbrorkFNaLSg9odLyhmKWPDJcdwDBLyNaDuyDPRPIP8FX7QyNHeu4Q1dU13ERlkN2vCnPvZLbfx+LviuqiEe/oNgUodzpJWE3d7UXRkpGJ+XIH0jGomLKuM980KGA4swwy0NA0naVznrsmS32eN30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718824367; c=relaxed/simple;
	bh=GGF/fe6a5yj/a6oly5zHWrK5YZcq1VQVJ3N3/tCxsNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QesNhXv6W7n0YsjJ3y5RlLrVxhMPZER63XbnP+JWWYUMZluR4jBZBHmt346fJkFNGpNRhtS+Pm/AYp/akzCCaPirL1Eq1K99gt87UXfi7r8zQs1lPr8v9hIc+yxsmMTd1piZeMdBH1toLvw4kvEurc0gfDWdn539566hWAGSBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jRxZbx5B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718824364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kXViuHr3FFbCPe+Uz6+9F744Xmz3ZOg5rqNGLZG3fDA=;
	b=jRxZbx5BnjpRl8bhKYDfpLbxBk53Q++CRRvo7iDZUrqXJOQ00t0Fc9BCow4InzSB4lmd60
	42IhNs7jXh3qU1ZHMHfxdZmkYjmBrdPgd4eL8EaiEhe6LCKu0UtLer+snUkU0OlK2YG6tn
	uUB06I8sAiOZcMVLqD7y2Ej+CV7qS5k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-5YJlhXPXMj6eusjUvTwGeg-1; Wed,
 19 Jun 2024 15:12:41 -0400
X-MC-Unique: 5YJlhXPXMj6eusjUvTwGeg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70B1C1956088;
	Wed, 19 Jun 2024 19:12:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.168])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6B2291956050;
	Wed, 19 Jun 2024 19:12:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Jun 2024 21:11:08 +0200 (CEST)
Date: Wed, 19 Jun 2024 21:11:06 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] signal: Make SIGKILL during coredumps an explicit
 special case
Message-ID: <20240619191105.GE24240@redhat.com>
References: <87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
 <20240610152902.GC20640@redhat.com>
 <20240613154541.GD18218@redhat.com>
 <87ikyamf4u.fsf@email.froward.int.ebiederm.org>
 <20240617183758.GB10753@redhat.com>
 <87iky5k2yi.fsf@email.froward.int.ebiederm.org>
 <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org>
 <87iky5inlv.fsf_-_@email.froward.int.ebiederm.org>
 <20240619155016.GC24240@redhat.com>
 <87cyocerda.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyocerda.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 06/19, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > Hi Eric,
> >
> > I'll _try_ to read this (nontrivial) changes this week. To be honest,
> > right now I don't really understand your goals after the quick glance...
> >
> > So far I have only looked at this simple 1/17 and it doesn't look right
> > to me.
>
> It might be worth applying them all on a branch and just looking at the
> end result.

Perhaps. Say, the next 2/17 patch. I'd say it is very difficult to understand
the purpose unless you read the next patches. OK, at least the change log
mentions "in preparation".

> > 	- complete_signal() won't be called, so signal->group_exit_code
> > 	  won't be updated.
> >
> > 	  coredump_finish() won't change it too so the process will exit
> > 	  with group_exit_code == signr /* coredumping signal */.
> >
> > 	  Yes, the fix is obvious and trivial...
>
> The signal handling from the coredump is arguably correct.  The process
> has already exited, and gotten an exit code.

And zap_process() sets roup_exit_code = signr. But,

> But I really don't care about the exit_code either way.  I just want to
> make ``killing'' a dead process while it core dumps independent of
> complete_signal.
>
> That ``killing'' of a dead process is a completely special case.

Sorry I fail to understand...

If the coredumping process is killed by SIGKILL, it should exit with
group_exit_code = SIGKILL, right? At least this is what we have now.

Oleg.


