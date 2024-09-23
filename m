Return-Path: <linux-kernel+bounces-335841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2307D97EB62
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C861C21580
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC02D19885B;
	Mon, 23 Sep 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g31kGf2e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA9762D7
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093632; cv=none; b=T6uMDz+BgmCkZL4to6FLC1PC1wxjsuSKgcNHWrYmbGskqxbM5Jz224FuYsEiyhYSDnDdQpWNU+ic1r9pSgiuLdf9awCpknsItnlS8iizrJmi5WkNfVXK78BYohWW6HvkAAFlTqlSmmlF1i0U21Bjn85lvWagUtNQKSYKnwQoI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093632; c=relaxed/simple;
	bh=QEy7BbUv17XgPef66l5Pl1s/1sq3pazOx8siZI8jVpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNaGr5uiptqkonBmkIwsSgMsGnRv7M54RrykQ1oADhGeti5XhrkIceeaWxmop4+HUKfOe5OC0O8VuPA7QL4UxrCHdWXc8tCZH4oaXmCYbQaQMi2BUeqJevK/EgCo1brekzN2/B+/55R5/4Zdv16GamJ0VSziwABcmMmza3BRhTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g31kGf2e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727093629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QEy7BbUv17XgPef66l5Pl1s/1sq3pazOx8siZI8jVpY=;
	b=g31kGf2eZbyscsyxLyfb9A9rShXuz15kXYaDM6gT8X/fb50J+cfF96wBYf9RKvceMNmQwR
	nQ7kXYuNwO7mYVl/0Zn6ZjO1k8VjE2Jd9kyGpTns/wPuWeyqAiNB/mXH0r0iTyKR4wU1xU
	2R2aaJhlDfOz5kh0ZsG5bcfm0vBUs6c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-1OYWd4CiNoKU5SzGIIWhLQ-1; Mon,
 23 Sep 2024 08:13:46 -0400
X-MC-Unique: 1OYWd4CiNoKU5SzGIIWhLQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C24C1190C4D3;
	Mon, 23 Sep 2024 12:13:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.16])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A22751956060;
	Mon, 23 Sep 2024 12:13:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 23 Sep 2024 14:13:31 +0200 (CEST)
Date: Mon, 23 Sep 2024 14:13:23 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 02/14] uprobe: Add support for session consumer
Message-ID: <20240923121322.GC20793@redhat.com>
References: <20240917085024.765883-1-jolsa@kernel.org>
 <20240917085024.765883-3-jolsa@kernel.org>
 <20240917120250.GA7752@redhat.com>
 <Zul7UCsftY_ZX6wT@krava>
 <20240922152722.GA12833@redhat.com>
 <ZvEhL114tyhLmfB1@krava>
 <20240923100552.GA20793@redhat.com>
 <ZvFKy9WLiz18GjEZ@krava>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvFKy9WLiz18GjEZ@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 09/23, Jiri Olsa wrote:
>
> On Mon, Sep 23, 2024 at 12:05:53PM +0200, Oleg Nesterov wrote:
> > On 09/23, Jiri Olsa wrote:
> > >
> > > change below should do what you proposed originally
> >
> > LGTM, just one nit below.
> >
> > But I guess you need to do this on top of bpf/bpf.git, Andrii has already
> > applied your series.
>
> that seems confusing

Yes ;)

> but looks like just that one fix with the
> commit link in [1] was applied

Ah, OK.

> > And to remind, 02/14 must be fixed in any case unless I am totally confused,
> > handler_chain() can leak return_instance.
>
> yep it was missing kfree, but it's not needed in this new version

Yes, yes, the new version looks fine to me.

Oleg.


