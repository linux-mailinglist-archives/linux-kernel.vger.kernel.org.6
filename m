Return-Path: <linux-kernel+bounces-309974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12C9672A5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 18:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343941F22433
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91956E611;
	Sat, 31 Aug 2024 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFbA9J0q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE64219F3
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725121180; cv=none; b=XlXYMDIZZAdiWk4RKNC5xxbqwLxHlmrnsDuY2PEVvg49O4Eiw95MwhJ4YLC+4EnexOuW/UCw2Hz0QtxQXnriGnxDzvWGq5a5xKoV61D/922yj9gFH0dfL0YvrrphBkZEEINBWKC3Oyf2GDq9mmkhutmhtNTTferesFZ9YIchHaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725121180; c=relaxed/simple;
	bh=o32RInfbuL+zWyn8Ou1U9Z6HZtom/bVCsA3/odOFf80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9atwpVem2e7zeDd5q4LT0DpzNxTR46bIL29BTw5RxZiOs2RkfrcWTMN5uM5/3AItEggEb8eO6DZT3us6syI2BNIRsJe4u6j8Iulb8g/jPEJ3rPvd355E1O/i3Jvqh8Le0g1y57uUswCsEXgfSvaXt0WaSoO0FhwZy6bWamgRrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iFbA9J0q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725121177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o32RInfbuL+zWyn8Ou1U9Z6HZtom/bVCsA3/odOFf80=;
	b=iFbA9J0qZGK/aj5cihdgGPMNCOXiAwSo8etsEzKLgqKGYS2Vdrg79rTNVlWU2pdLX/T3Ef
	SujNarTdsjiuTcq405mLgdG+dMknpYt5wbq8UBSJvnD/FK1zRKCbowvrdFPbsseYOc5nWc
	Urqdr2vpLznp4NC4hON4kT16zXELnI0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-I1N5zLFcPyWYmqvwB4IBXQ-1; Sat,
 31 Aug 2024 12:19:33 -0400
X-MC-Unique: I1N5zLFcPyWYmqvwB4IBXQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89F791956080;
	Sat, 31 Aug 2024 16:19:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.49])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 59E8F30001A4;
	Sat, 31 Aug 2024 16:19:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 31 Aug 2024 18:19:21 +0200 (CEST)
Date: Sat, 31 Aug 2024 18:19:15 +0200
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
Message-ID: <20240831161914.GA9683@redhat.com>
References: <20240829183741.3331213-1-andrii@kernel.org>
 <20240829183741.3331213-5-andrii@kernel.org>
 <ZtD_x9zxLjyhS37Z@krava>
 <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
 <ZtHM_C1NmDSKL0pi@krava>
 <20240830143151.GC20163@redhat.com>
 <CAEf4BzbOjB9Str9-ea6pa46sRDdHJF5mb0rj1dyJquvBT-9vnw@mail.gmail.com>
 <20240830202050.GA7440@redhat.com>
 <CAEf4BzZCrchQCOPv9ToUy8coS4q6LjoLUB_c6E6cvPPquR035Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZCrchQCOPv9ToUy8coS4q6LjoLUB_c6E6cvPPquR035Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/30, Andrii Nakryiko wrote:
>
> On Fri, Aug 30, 2024 at 1:21 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > I'll probably write another email (too late for me today), but I agree
> > that "avoid register_rwsem in handler_chain" is obviously a good goal,
> > lets discuss the possible cleanups or even fixlets later, when this
> > series is already applied.
> >
>
> Sounds good. It seems like I'll need another revision due to missing
> include, so if there is any reasonably straightforward clean up we
> should do, I can just incorporate that into my series.

I was thinking about another seq counter incremented in register(), so
that handler_chain() can detect the race with uprobe_register() and skip
unapply_uprobe() in this case. This is what Peter did in one of his series.
Still changes the current behaviour, but not too much.

But see below,

> I still think it's fine, tbh.

and perhaps you are right,

> Which uprobe user violates this contract
> in the kernel?

The only in-kernel user of UPROBE_HANDLER_REMOVE is perf, and it is fine.

But there are out-of-tree users, say systemtap, I have no idea if this
change can affect them.

And in general, this change makes the API less "flexible".

But once again, I agree that it would be better to apply your series first,
then add the fixes in (unlikely) case it breaks something.

But. Since you are going to send another version, may I ask you to add a
note into the changelog to explain that this patch assumes (and enforces)
the rule about handler/filter consistency?

Oleg.


