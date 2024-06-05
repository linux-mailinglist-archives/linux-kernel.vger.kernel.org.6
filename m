Return-Path: <linux-kernel+bounces-202881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017858FD25F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E171F2878A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F8C14EC59;
	Wed,  5 Jun 2024 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNq/XgZF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1361B4D5A2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717603381; cv=none; b=cH8Grxhmc89UVUmXnvYB5x9U4KnB1JFRhYNfQK0xgh4ACEvAZOo+FpJ+qMkQgFTSQNoOUxh4GEADZuxVJG9liFy/yDhrn5JOaJj4kQt8mR5l4GLztQsKPxN1BIq79k49Zh3tinwCcRiSRvrkpt6RaWX4o/3W/PrggwhnGmLDB4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717603381; c=relaxed/simple;
	bh=D8OoY3T7mGC4YRUW2RtL5a4Fc9lBZAegGqyZz35xuZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHeB8BhLY72LDvn67eWtMaIjq0o9GoJwAsGnTn4G+jaqARif7UJ/OTES1dvZWvPTh8K+FDME+UUpyWkNtMhzJwpcl9eEHq+0mANfAp7KE4VDu9oo2bEGZYwttv1d5PLpPYJdFet0JyNeCFWAWd5m7B3ooW/t3BEH4suVGf/TDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNq/XgZF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717603379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mJuDy+kWLrp9AKixbMmEZ9fbIkmFKDgFWSJ9YOKhB7k=;
	b=GNq/XgZFOpMvwGLVAEjnvZKHBf2Ncw6UuK60Ur76LkgBgcx1g7sG3bp/xtTk7NPyKi+odj
	n+J6YL6wnBGRHLz2Vw3wukDGqEXPWVpTDcCJa/4KFuzjb07bTnpAvWbCTw5zDhNLedFEZd
	O6O9+rraf7fdzn1VbfXWwOyGtwi2wnY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-BxGYqY-ePeC5n4RfYyv9PQ-1; Wed,
 05 Jun 2024 12:02:53 -0400
X-MC-Unique: BxGYqY-ePeC5n4RfYyv9PQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BCCB3806702;
	Wed,  5 Jun 2024 16:02:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
	by smtp.corp.redhat.com (Postfix) with SMTP id 6FF23492BFA;
	Wed,  5 Jun 2024 16:02:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Jun 2024 18:01:23 +0200 (CEST)
Date: Wed, 5 Jun 2024 18:01:17 +0200
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
Message-ID: <20240605160117.GE25006@redhat.com>
References: <20240604200221.377848-1-jolsa@kernel.org>
 <20240604200221.377848-2-jolsa@kernel.org>
 <20240605152457.GD25006@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605152457.GD25006@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 06/05, Oleg Nesterov wrote:
>
> > +/*
> > + * Make sure all the uprobe consumers have only one type of entry
> > + * callback registered (either handler or handler_session) due to
> > + * different return value actions.
> > + */
> > +static int consumer_check(struct uprobe_consumer *curr, struct uprobe_consumer *uc)
> > +{
> > +	if (!curr)
> > +		return 0;
> > +	if (curr->handler_session || uc->handler_session)
> > +		return -EBUSY;
> > +	return 0;
> > +}
>
> Hmm, I don't understand this code, it doesn't match the comment...
>
> The comment says "all the uprobe consumers have only one type" but
> consumer_check() will always fail if the the 1st or 2nd consumer has
> ->handler_session != NULL ?
>
> Perhaps you meant
>
> 	if (!!curr->handler != !!uc->handler)
> 		return -EBUSY;
>
> ?

OK, the changelog says

	Which means that there can be only single user of a uprobe (inode +
	offset) when session consumer is registered to it.

so the code is correct. But I still think the comment is misleading.

Oleg.


