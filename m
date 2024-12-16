Return-Path: <linux-kernel+bounces-447313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B82E9F3071
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC34B188430A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D91204C01;
	Mon, 16 Dec 2024 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fr/j62SJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1C120012C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351765; cv=none; b=Riq6QzZS81MbnUXaTCuP1ArbMLB0HFDSbEAYUqar3FTFMHe4fmkKE4ZZZ+jhozuog96FIyCRWXim6K0en/VVv3O5nlM+6mJihW9Y8m5rxykqpcxfP4Oxbeolas/V1nGZxb566aW5GyNWoLQJ/pYv6qY9T+Xojxhzu6q/mFGFEJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351765; c=relaxed/simple;
	bh=WUeVZeNcY07UHuAcAEKLKwvqI2g/xCzB3T8DU3xLl4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQh+JOszJnDNwVWg5a4UTofQ0oQ6UKaPPNqEp/2uK8ftu817FjuePUNH/6x37dPwJoYZf7s91VHeUVAAvZCkfSXA7R3zcik7At56z032lC+qDXGRoUWHg9avdYqUAMYQiYC0ub46mDT3eNBtgFhYRzVQm5zXadZE5LxnOhBEl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fr/j62SJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734351762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5IyPoQnMUSRrw4hzgNLn0p2ekpsZi83fqnwbnPuf+9Q=;
	b=fr/j62SJ7NcWFtVK2ovzdZ1VlOz9z1+5SBSF/DJLiNaG738AXWGbqEGUl2CsEoNeY3GG/8
	GmrAiTQBzb2vbT17mEIgZYmsXKVuByDmykV5jXwOSra1OI022jjflbPImh0f0GULUXx5U5
	4rY8TX6UMr/IIUxyVmKTRl4LuvpVgY8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-V8jxa8ICOk6dUpSsE9D0xg-1; Mon,
 16 Dec 2024 07:22:37 -0500
X-MC-Unique: V8jxa8ICOk6dUpSsE9D0xg-1
X-Mimecast-MFC-AGG-ID: V8jxa8ICOk6dUpSsE9D0xg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 233061955F56;
	Mon, 16 Dec 2024 12:22:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.224])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0D90E19560A2;
	Mon, 16 Dec 2024 12:22:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 16 Dec 2024 13:22:11 +0100 (CET)
Date: Mon, 16 Dec 2024 13:22:05 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	'Jiri Olsa' <olsajiri@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20241216122204.GB374@redhat.com>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-9-jolsa@kernel.org>
 <1521ff93bc0649b0aade9cfc444929ca@AcuMS.aculab.com>
 <20241215141412.GA13580@redhat.com>
 <Z1_gFymfO3sAwhiY@krava>
 <c5fb22629d3f42798def5b63ce834801@AcuMS.aculab.com>
 <20241216101258.GA374@redhat.com>
 <0916e24539ba4bae9fb729198b033bd7@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0916e24539ba4bae9fb729198b033bd7@AcuMS.aculab.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

OK, thanks, I am starting to share your concerns...

Oleg.

On 12/16, David Laight wrote:
>
> From: Oleg Nesterov
> > Sent: 16 December 2024 10:13
> >
> > David,
> >
> > let me say first that my understanding of this magic is very limited,
> > please correct me.
>
> I only (half) understand what the 'magic' has to accomplish and
> some of the pitfalls.
>
> I've copied linux-mm - someone there might know more.
>
> > On 12/16, David Laight wrote:
> > >
> > > It all depends on how hard __replace_page() tries to be atomic.
> > > The page has to change from one backed by the executable to a private
> > > one backed by swap - otherwise you can't write to it.
> >
> > This is what uprobe_write_opcode() does,
>
> And will be enough for single byte changes - they'll be picked up
> at some point after the change.
>
> > > But the problems arise when the instruction prefetch unit has read
> > > part of the 5-byte instruction (it might even only read half a cache
> > > line at a time).
> > > I'm not sure how long the pipeline can sit in that state - but I
> > > can do a memory read of a PCIe address that takes ~3000 clocks.
> > > (And a misaligned AVX-512 read is probably eight 8-byte transfers.)
> > >
> > > So I think you need to force an interrupt while the PTE is invalid.
> > > And that need to be simultaneous on all cpu running that process.
> >
> > __replace_page() does ptep_get_and_clear(old_pte) + flush_tlb_page().
> >
> > That's not enough?
>
> I doubt it. As I understand it.
> The hardware page tables will be shared by all the threads of a process.
> So unless you hard synchronise all the cpu (and flush the TLB) while the
> PTE is being changed there is always the possibility of a cpu picking up
> the new PTE before the IPI that (I presume) flush_tlb_page() generates
> is processed.
> If that happens when the instruction you are patching is part-read into
> the instruction decode buffer then you'll execute a mismatch of the two
> instructions.
>
> I can't remember the outcome of discussions about live-patching kernel
> code - and I'm sure that was aligned 32bit writes.
>
> >
> > > Stopping the process using ptrace would do it.
> >
> > Not an option :/
>
> Thought you'd say that.
>
> 	David
>
> >
> > Oleg.
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>


