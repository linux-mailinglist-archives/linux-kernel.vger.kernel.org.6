Return-Path: <linux-kernel+bounces-446440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F429F2458
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 15:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9353B188494C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C838318FDD5;
	Sun, 15 Dec 2024 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyze5SNk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608C118FDAA
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734272093; cv=none; b=JSGSdLLaeuSRgTNTS6GajkCceY/3wWYdRbXT+DJCQ/ltO+3zABBXZOQJZQlEHuZfz60UHX3tZHJa0hUbeULtS96qOSwmwaWFClu7pplFptJpTn59SieSJl97IcDNZSWz5uxqiIdvYj/svpLmYs+Qungl9ubq8y4Jt0d5lNQU+CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734272093; c=relaxed/simple;
	bh=a53vNz4PUMmhwfydX5urPkZUSvWv4tcg1WmTFyd1Bk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZR2FQ+vxyFkiA2TI6MACEvcvBygid/6T45Kv2fbR+vk5urk3kY3TLJUIkPHapYI9zCayr6RC6/xZTcKgypZ82mPlnYVN2lQAad6MRMVKweuHSnr3ym72YNynSO37b4Qlf1dxK2iaNpPKxA3Lp+aWyFomZyVGOzLDG+Z2Stj0OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyze5SNk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734272090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W3bWsES4HYFomsBdw8ix9WcXokymLmLN9+uEpumIVv4=;
	b=dyze5SNkmfWdl5fIoerZGtE2r1h8n7XWmPF+jAcFq7AdjsAGsz1nhn2Vpq2+3WtKALwxCS
	FaGFF8OHLAN6Ny+L1iOkXcb5ii8QMGaP3wIISTGALYi+nb0l7aXpIac+cMWgbGjKgoCGVs
	bRHMgSRdSBYYpl8/CX+2aAw733MRwLY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-Ls14WX__PYqYc-D7LfhNYw-1; Sun,
 15 Dec 2024 09:14:45 -0500
X-MC-Unique: Ls14WX__PYqYc-D7LfhNYw-1
X-Mimecast-MFC-AGG-ID: Ls14WX__PYqYc-D7LfhNYw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 933201956089;
	Sun, 15 Dec 2024 14:14:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 295B630044C1;
	Sun, 15 Dec 2024 14:14:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 15 Dec 2024 15:14:19 +0100 (CET)
Date: Sun, 15 Dec 2024 15:14:13 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Jiri Olsa' <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 08/13] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <20241215141412.GA13580@redhat.com>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-9-jolsa@kernel.org>
 <1521ff93bc0649b0aade9cfc444929ca@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521ff93bc0649b0aade9cfc444929ca@AcuMS.aculab.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 12/15, David Laight wrote:
>
> From: Jiri Olsa
> > The optimized uprobe path
> >
> >   - checks the original instruction is 5-byte nop (plus other checks)
> >   - adds (or uses existing) user space trampoline and overwrites original
> >     instruction (5-byte nop) with call to user space trampoline
> >   - the user space trampoline executes uprobe syscall that calls related uprobe
> >     consumers
> >   - trampoline returns back to next instruction
> ...
>
> How on earth can you safely overwrite a randomly aligned 5 byte instruction
> that might be being prefetched and executed by another thread of the
> same process.

uprobe_write_opcode() doesn't overwrite the instruction in place.

It creates the new page with the same content, overwrites the probed insn in
that page, then calls __replace_page().

Oleg.


