Return-Path: <linux-kernel+bounces-313513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE02196A66B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A102281379
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26976190660;
	Tue,  3 Sep 2024 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAxHSOPw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1932618EFC9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725387948; cv=none; b=gfGhuduMO9wYRx4qH7fgtQklO7yHtS0GR4LD1MgWseGdMQlCfF+yKT8nqW+TYF0onmhS1WfNeZH2z2MT243yO82JVAii0CM9eKwK1Ummn9oQAQ1TxfyLJJ+BAbM7nqv95nKqS64VyNu7SWJr7PL+wOPmWKF27YxMO6ab5Av0Hn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725387948; c=relaxed/simple;
	bh=hJS6EaFB6prKGPaSLYwj+YKNJglp4aYVfW5lYICPAgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVkIYaxVv9G5COESy6ws+t4WMf1kW8ejsARVJp5HHNgpAV+7BS/DDpgH3fIfR4DOO8hcEkqxcidhYRCsRoLPZ27dB1zGjrITm9/GCsuIqOiH2FQDMVGbTj2AwG/eplXJvIXiMnEmCNkWhzNDBf5E2J+b2AZ/Orih5WBLmmOqE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAxHSOPw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725387945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJS6EaFB6prKGPaSLYwj+YKNJglp4aYVfW5lYICPAgk=;
	b=BAxHSOPwQLPZXDVacXYR5jjaJ1ki37w3rLW/QLjKNxYCE20fk5zm+lVLvZRhBL2EOVmgQr
	KUDpefedxWa67Cp+1buc4mk00JC4Hmlzj7fJsQU27st2u0+yhNORqxayS4EapjLAPmUb88
	mWyMk61vtejNQJ7AKi5yDYYQxLU1gDk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-OZYe8k1LP0ezeXn8VZ0taw-1; Tue,
 03 Sep 2024 14:25:41 -0400
X-MC-Unique: OZYe8k1LP0ezeXn8VZ0taw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CAB919560B4;
	Tue,  3 Sep 2024 18:25:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.38])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 801FE19560AE;
	Tue,  3 Sep 2024 18:25:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  3 Sep 2024 20:25:29 +0200 (CEST)
Date: Tue, 3 Sep 2024 20:25:23 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 4/8] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
Message-ID: <20240903182523.GH17936@redhat.com>
References: <20240829183741.3331213-5-andrii@kernel.org>
 <ZtD_x9zxLjyhS37Z@krava>
 <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
 <ZtHM_C1NmDSKL0pi@krava>
 <20240830143151.GC20163@redhat.com>
 <CAEf4BzbOjB9Str9-ea6pa46sRDdHJF5mb0rj1dyJquvBT-9vnw@mail.gmail.com>
 <20240830202050.GA7440@redhat.com>
 <CAEf4BzZCrchQCOPv9ToUy8coS4q6LjoLUB_c6E6cvPPquR035Q@mail.gmail.com>
 <20240831161914.GA9683@redhat.com>
 <CAEf4BzYE7+YgM7HMb-JceoC33f=irjHkj=5x46WaXdCcgTk4xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYE7+YgM7HMb-JceoC33f=irjHkj=5x46WaXdCcgTk4xg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/03, Andrii Nakryiko wrote:
>
> On Sat, Aug 31, 2024 at 9:19 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > I was thinking about another seq counter incremented in register(), so
> > that handler_chain() can detect the race with uprobe_register() and skip
> > unapply_uprobe() in this case. This is what Peter did in one of his series.
> > Still changes the current behaviour, but not too much.
>
> We could do that, but then worst case, when we do detect registration
> race, what do we do?

Do nothing and skip unapply_uprobe().

> But as you said, this all can/should be addressed as a follow up
> discussion.

Yes, yes,

> You mentioned some clean ups you wanted to do, let's
> discuss all that as part of that?

Yes, sure.

And please note that in reply to myself I also mentioned that I am stupid
and these cleanups can't help to change/improve this behaviour ;)

> > The only in-kernel user of UPROBE_HANDLER_REMOVE is perf, and it is fine.
> >
>
> Well, BPF program can accidentally trigger this as well, but that's a
> bug, we should fix it ASAP in the bpf tree.

not sure, but...

> > And in general, this change makes the API less "flexible".
>
> it maybe makes a weird and too-flexible case a bit more work to
> implement. Because if consumer want to be that flexible, they can
> still define filter that will be coordinated between filter() and
> handler() implementation.

perhaps, but lets discuss this later, on top of your series.

> > But once again, I agree that it would be better to apply your series first,
> > then add the fixes in (unlikely) case it breaks something.
>
> Yep, agreed, thanks! Will send a new version ASAP, so we have a common
> base to work on top of.

Thanks. Hopefully Peter will queue your V5 soon.

Oleg.


