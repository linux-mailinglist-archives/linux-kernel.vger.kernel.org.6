Return-Path: <linux-kernel+bounces-203226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A278FD80E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0F928751F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4379A15F3E0;
	Wed,  5 Jun 2024 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdJ49FRS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AF16A325
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621353; cv=none; b=QQYIvaEsadm6RHro/Rl2YZtA4vZJcN7rP435FQPseMohWauK4CUDBXaal9F4jawsLrd6YSfkGzZCGql9Gl27fxRock+sgqu6EhDdQL2bZA+0CY2FU3Z1LxSfVeXrSioZE6BeU6qEFBLwlWpEvwM5kefK1A/6BanEF2GGt9BiLNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621353; c=relaxed/simple;
	bh=CR6hmo3BYLol4OkDTrDKGhawRzyHwi1OkF6+XlGrv3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBoARUJUZOk6U+3SMP+geB9ratFwzw+lWsytLy6ca+MwVMYE6ArP9ECiohkXSczj2GMtZTgS/0XyKZO7Xpv4GZO3N8laFEEZUbKzX24BFtxquD+HXmys0XP6/xkVP3kaVdGLBrPEX15kltIMP+sfiYzqqVJrjAcrRWLElVc7hUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QdJ49FRS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717621350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CR6hmo3BYLol4OkDTrDKGhawRzyHwi1OkF6+XlGrv3w=;
	b=QdJ49FRStmltlNCCrX72/COOnj/msNmIBq5ehQqHfZfpBZTqag3wiElA2CtKm3kuxOI2b/
	ydztvnGBfvL0U/WGaF9vsANK+zH+/o6pADBhj8zimPYKhWpKTIO2pj+m1zyDF2A+SXym1k
	LS6IewVFKVn43VlBkvcely1632LBkDw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-UlRffepYNUy40V6cIxvZ3w-1; Wed,
 05 Jun 2024 17:02:23 -0400
X-MC-Unique: UlRffepYNUy40V6cIxvZ3w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAF671953955;
	Wed,  5 Jun 2024 21:02:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.62])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 80A511956055;
	Wed,  5 Jun 2024 21:02:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Jun 2024 23:00:52 +0200 (CEST)
Date: Wed, 5 Jun 2024 23:00:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20240605210043.GB19139@redhat.com>
References: <20240604200221.377848-1-jolsa@kernel.org>
 <20240604200221.377848-2-jolsa@kernel.org>
 <CAEf4BzbzgTzvnPRJ24gdhuxN02_w8iNNFn4URh0vEp-t69oPnA@mail.gmail.com>
 <20240605175619.GH25006@redhat.com>
 <ZmDPQH2uiPYTA_df@krava>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmDPQH2uiPYTA_df@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 06/05, Jiri Olsa wrote:
>
> > And the comment about the return value looks confusing too. I mean, the
> > logic doesn't differ from the ret-code from ->handler().
> >
> > "DO NOT install/execute the return uprobe" is not true if another
> > non-session-consumer returns 0.
>
> well they are meant to be exclusive, so there'd be no other non-session-consumer

OK. (but may be the changelog can explain more clearly why they can't
co-exist with the non-session-consumers).

But again, this doesn't differ from the the ret-code from the
non-session-consumer->handler().

If it returns 1 == UPROBE_HANDLER_REMOVE, then without other consumers
prepare_uretprobe() won't be called.

Oleg.


