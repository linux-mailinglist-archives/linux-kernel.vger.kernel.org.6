Return-Path: <linux-kernel+bounces-202923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB538FD306
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F6BB21E77
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2BD18F2F4;
	Wed,  5 Jun 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrThbiOz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB81188CC8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605492; cv=none; b=mCgORGs18hQnc1B+3OB+E7j1HouY4B6JgozW8gPKccv4+t0jJ9gfPZKca62KXTx0Px7eTPBa61ZpdH+SwNsdHXSH3Hpay1CAw8xqHKjjdgF5ldlD0PKSGfFNs9P24lqyCl8FR4WsguOKzzYtECCLtkEjHI1Gxgzt9+qr7SFDKO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605492; c=relaxed/simple;
	bh=qYHQHvxEOL0+ja9/l1xmzQYzTlCH0OQ9ADs1DPd83aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPZOitNZhAHaPl3T/33ADXZkF6gv9O6YXmr+nCx92GjjfisG5YGNy9rbRAuao1pyjPuYbItk2ulPoVbxq/XyqwxDf6SW8p5dUEk7YuofbQUlj0xlW2q/xTBk6dm1TkM9CkJqvvenUIKe7IhK5BZuj7sDJo8gFIZ/Tlxm+M5w9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UrThbiOz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717605489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XBGg4L8V3Q5EYMEYMCQld5ntR2Bf7/IEh8rTgIfGGV0=;
	b=UrThbiOzAkQtnLaax8r6bgFWB513pjgbgpvPnzI8i6MY2H9jdRUc7a0+jdE+fFZmXO64NE
	sWPtgbwNCPDVWpA4pmAZVN1MbehKapYTaxWYgwo06IhhuPYrJ/0PZvgoRssXQFknU3txCG
	vNvKSIDQOzZwXoIi6uabh4GsJRVKCLs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632--yINWIP3P5KgloQ-Sd_GjA-1; Wed,
 05 Jun 2024 12:38:06 -0400
X-MC-Unique: -yINWIP3P5KgloQ-Sd_GjA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCB8C1954216;
	Wed,  5 Jun 2024 16:38:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.62])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0386B3000623;
	Wed,  5 Jun 2024 16:37:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Jun 2024 18:36:32 +0200 (CEST)
Date: Wed, 5 Jun 2024 18:36:25 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC bpf-next 01/10] uprobe: Add session callbacks to
 uprobe_consumer
Message-ID: <20240605163624.GG25006@redhat.com>
References: <20240604200221.377848-1-jolsa@kernel.org>
 <20240604200221.377848-2-jolsa@kernel.org>
 <20240605152457.GD25006@redhat.com>
 <20240605160117.GE25006@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605160117.GE25006@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/05, Oleg Nesterov wrote:
>
> On 06/05, Oleg Nesterov wrote:
> >
> > > +/*
> > > + * Make sure all the uprobe consumers have only one type of entry
> > > + * callback registered (either handler or handler_session) due to
> > > + * different return value actions.
> > > + */
> > > +static int consumer_check(struct uprobe_consumer *curr, struct uprobe_consumer *uc)
> > > +{
> > > +	if (!curr)
> > > +		return 0;
> > > +	if (curr->handler_session || uc->handler_session)
> > > +		return -EBUSY;
> > > +	return 0;
> > > +}
> >
> > Hmm, I don't understand this code, it doesn't match the comment...
> >
> > The comment says "all the uprobe consumers have only one type" but
> > consumer_check() will always fail if the the 1st or 2nd consumer has
> > ->handler_session != NULL ?
> >
> > Perhaps you meant
> >
> > 	if (!!curr->handler != !!uc->handler)
> > 		return -EBUSY;
> >
> > ?
>
> OK, the changelog says
>
> 	Which means that there can be only single user of a uprobe (inode +
> 	offset) when session consumer is registered to it.
>
> so the code is correct. But I still think the comment is misleading.

Cough... perhaps it is correct but I am still confused even we forget about
the comment ;)

OK, uprobe can have a single consumer with ->handler_session != NULL. I guess
this is because return_instance->data is "global".

So uprobe can have multiple handler_session == NULL consumers before
handler_session != NULL, but not after ?

Oleg.


