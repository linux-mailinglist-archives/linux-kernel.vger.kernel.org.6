Return-Path: <linux-kernel+bounces-203293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174ED8FD905
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86B85B2392E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088BD160791;
	Wed,  5 Jun 2024 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cb+5Zd6o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E119615FD1E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622738; cv=none; b=iqxojnCZky8r2s+Q2+iRRqY2eaaWqNmsas3u8JGq272xmPJUfjX3rmxTMedGSbV2rj8IzyitIfjnFXm3ROoYghe6VkL2ZnyPLSfIonNLxxsSGbLiY/aAk7nH3q8RGJ74BKCgs7n4dF+Ig3x0+5BqdoDUNLY01izSpRBhXnZtB9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622738; c=relaxed/simple;
	bh=vPUsNLtvA3c1wzJPrmq0xqsqKfT7lCp9zPJqLgYvZgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfvnVHpcmn0ZIjI9mOwvIwFrWCiyR/VZ5f5ein1msuajUDD8AKRBcXVxrRW4NDLlgmiCYtKAEsQZuBg/KWEdQWRmtLC3ay8yECP9INsYMupwepk+icjwVVfoSZVl+LT7FIFLr1NIV6GC9otQHY8BS1zVZGxH52/K3wgSvryQmus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cb+5Zd6o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717622735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vPUsNLtvA3c1wzJPrmq0xqsqKfT7lCp9zPJqLgYvZgg=;
	b=Cb+5Zd6o1HIngJypT+aa9uIyM+vmkI5gjS/RG3VcCXwZ5FeUYi6TPHOXFBZr0li7pjyzn5
	u88hMEhnbku4bu8kPSYj7GNLa2wQlUfId4LvX11YkoQe4op+iTaDbd7wOqAc3qMXmESBNN
	e4nv2RB1/9lBheW/2Y5tgp2s/3tINYA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-cJTSEEHmPlaMTdqrJfJyqQ-1; Wed, 05 Jun 2024 17:25:30 -0400
X-MC-Unique: cJTSEEHmPlaMTdqrJfJyqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9120A85A588;
	Wed,  5 Jun 2024 21:25:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.62])
	by smtp.corp.redhat.com (Postfix) with SMTP id 7534A2166AF9;
	Wed,  5 Jun 2024 21:25:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Jun 2024 23:24:00 +0200 (CEST)
Date: Wed, 5 Jun 2024 23:23:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20240605212354.GC19139@redhat.com>
References: <20240604200221.377848-1-jolsa@kernel.org>
 <20240604200221.377848-2-jolsa@kernel.org>
 <CAEf4BzbzgTzvnPRJ24gdhuxN02_w8iNNFn4URh0vEp-t69oPnA@mail.gmail.com>
 <20240605175619.GH25006@redhat.com>
 <CAEf4Bzbz3vi6ahkUu7yABV-QhkzNCF-ROcRjUpGjt0FRjfDuKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbz3vi6ahkUu7yABV-QhkzNCF-ROcRjUpGjt0FRjfDuKQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 06/05, Andrii Nakryiko wrote:
>
> WDYT? It's still fast, and it's simpler than the shadow stack idea, IMO.

Andrii. I am alredy sleeping, I'll try to read your email tomorrow.
Right now I can only say that everything is simpler than the shadow stack ;)

> P.S. Regardless, maybe we should change the order in which we insert
> consumers to uprobe? Right now uprobe consumer added later will be
> executed first, which, while not wrong, is counter-intuitive.

Agreed...

Even if currently this doesn't really matter, I guess it is supposed
that uc->handler() is "non-intrusive".

Oleg.


