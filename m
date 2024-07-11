Return-Path: <linux-kernel+bounces-248913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D3A92E3C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C04E1F22F63
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9BC155CA5;
	Thu, 11 Jul 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCLkWLJy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A231509AE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720691493; cv=none; b=Rn5key0+P068PaICyzqp+XBQKYRnmqXHPUrsfNvEkPaCaFzFK7nZuUsCL3DgFYZqiMFjl5vRgQCYayeA9Sxh6jBXRzVkmIEGKjGVd6YJCwjLXMGxCTTAl4u8dBJaWKLZkkcFZXnfI+eBa4WIQLqTNVRpwaiZ3wX94Lfxv5B2iUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720691493; c=relaxed/simple;
	bh=tfqxVxsHHemgAz/lFxxDT1crfRqIK3t67BHFqX0LmMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jODoUT/AHQemc3bqUkL5Xmr2KZmAHPJp3McWt1b62DCSoHiZ/V4ysRINomil/DRvq52Akdut1B+RJQesHNz/4DxJSS9oWL3ZXr1lQZooxX9yCtlU3KhZjcFUQ3OcNPdMGp9w+OPbD9C/UZcmokY7wdrbOEDhTxf0SjIaxS6/rnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jCLkWLJy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720691490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dnGmSRQ9L6y9e6BBw6SvRgZoIrKxWqDQV/0SOBRCcNA=;
	b=jCLkWLJydEKQn9k0Oxaab33hV8uf0CRjfpznIzhEg9jEYaGaccR784Dfx8MX3IY6iAu7Lr
	EgGE0CXXML3u23O64JMdiRVRMdW5DQuckP5KqnwKc6Zii69nHGbWRcOB6T0o276amR+t5M
	wkeRLU1JdhQnYC8aqtyeGQiFkPh8B3M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-71REoLzfM-OCQJCopqVDcQ-1; Thu,
 11 Jul 2024 05:51:23 -0400
X-MC-Unique: 71REoLzfM-OCQJCopqVDcQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E03751955BC9;
	Thu, 11 Jul 2024 09:51:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.32])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E0B70195606C;
	Thu, 11 Jul 2024 09:51:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 11 Jul 2024 11:49:44 +0200 (CEST)
Date: Thu, 11 Jul 2024 11:49:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: andrii@kernel.org, peterz@infradead.org, clm@meta.com, jolsa@kernel.org,
	mingo@kernel.org, paulmck@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] uprobes: document the usage of mm->mmap_lock
Message-ID: <20240711094940.GB16902@redhat.com>
References: <20240710140017.GA1074@redhat.com>
 <20240710140045.GA1084@redhat.com>
 <20240710235159.23b8bc0f5247c358ccea699d@kernel.org>
 <20240710151006.GB9228@redhat.com>
 <20240711090704.556216a0bca595ad44ee9dbf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711090704.556216a0bca595ad44ee9dbf@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 07/11, Masami Hiramatsu wrote:
>
> On Wed, 10 Jul 2024 17:10:07 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > > >  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> > > > @@ -1046,7 +1046,12 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
> > > >
> > > >  		if (err && is_register)
> > > >  			goto free;
> > > > -
> > > > +		/*
> > > > +		 * We take mmap_lock for writing to avoid the race with
> > > > +		 * find_active_uprobe(), install_breakpoint() must not
> > > > +		 * make is_trap_at_addr() true right after find_uprobe()
> > > > +		 * returns NULL.
> > >

...

> OK, but it seems we should write the above longer explanation here.
> What about the comment like this?

Well, I am biased, but your version looks much more confusing to me...

> /*
>  * We take mmap_lock for writing to avoid the race with
>  * find_active_uprobe() and is_trap_at_adder() in reader
>  * side.
>  * If the reader, which hits a swbp and is handling it,
>  * does not take mmap_lock for reading,

this looks as if the reader which hits a swbp takes mmap_lock for reading
because of this race. No, find_active_uprobe() needs mmap_read_lock() for
vma_lookup, get_user_pages, etc.

> it is possible
>  * that find_active_uprobe() returns NULL (because
>  * uprobe_unregister() removes uprobes right before that),
>  * but is_trap_at_addr() can return true afterwards (because
>  * another thread calls uprobe_register() on the same address).
     ^^^^^^^^^^^^^^^
We are the thread which called uprobe_register(), we are going to
do install_breakpoint().

And btw, not that I think this makes sense, but register_for_each_vma()
could probably do

	if (is_register)
		mmap_write_lock(mm);
	else
		mmap_read_lock(mm);

Oleg.


