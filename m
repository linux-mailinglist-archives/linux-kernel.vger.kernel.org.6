Return-Path: <linux-kernel+bounces-440061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517FA9EB829
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFC31630E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4317323ED56;
	Tue, 10 Dec 2024 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YORHxqLr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A1823ED4B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851445; cv=none; b=kXQOVx8+Wpw9oSijLQgek/eHBQWeZXu/vIOkS6Ei8WftgFLML6tZtWNVyephtGsGaZDDzmmeg3uT+nPLHmyv4ytU+9lR2bo3F5LppC2qcN4Xp8SOZ4rgpg+pYq0Dax4f3x5NOa6tTPAkApaaMvhfTKeMGj6u4nDIXymtSePoaLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851445; c=relaxed/simple;
	bh=5pSl0cunFmBca5xc6L98b0QoSaHRTsaK75H7IBvX+PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7PZsrAP4wmeXiYOEjf8epRfY5TmAYWM/YjL+8ORq0wE4KNSoyHHBSKww9ETAiqETJ9K7z/JI8xLf6xeBzAa+Quqz9otthzL6GtNt7KyrQ++Q7VFUwERXkUgUIm68CxHO52Br81kOSblkPsGB4Gyf6H6/PEjxw/y1FhlVwvNbls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YORHxqLr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733851442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ak8IHw6AsyfbuIWIItOfZjhkQX5WqyyGmjWLGshjVLM=;
	b=YORHxqLr1st3LnEpMk6qyPgK9NB/541STHcBd1RMUSadyr7pmIy6qB+nAC+SO+DGH2tP43
	xnRB29ddDxAa3qwnIRSs9AUSKgC5Jl/SCwOTUo9+Jy3yX3HqdF9f8dmid/QJ1JcjL11GQo
	gzjm2XZbz2IwcDz8/Vu0bnG3UmCcmzs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-i2-zsrJRN6SW8DWEgrQr1A-1; Tue,
 10 Dec 2024 12:23:56 -0500
X-MC-Unique: i2-zsrJRN6SW8DWEgrQr1A-1
X-Mimecast-MFC-AGG-ID: i2-zsrJRN6SW8DWEgrQr1A
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E7E319560B6;
	Tue, 10 Dec 2024 17:23:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DC3EE19560A7;
	Tue, 10 Dec 2024 17:23:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 10 Dec 2024 18:23:28 +0100 (CET)
Date: Tue, 10 Dec 2024 18:23:19 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH] fork: avoid inappropriate uprobe access to invalid mm
Message-ID: <20241210172315.GC31266@redhat.com>
References: <20241210163104.55181-1-lorenzo.stoakes@oracle.com>
 <20241210165334.GB31266@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210165334.GB31266@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 12/10, Oleg Nesterov wrote:
>
> I must have missed something, but...
>
> On 12/10, Lorenzo Stoakes wrote:
> >
> > @@ -1746,9 +1741,11 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
> >  	if (!mm_init(mm, tsk, mm->user_ns))
> >  		goto fail_nomem;
> >
> > +	uprobe_start_dup_mmap();
> >  	err = dup_mmap(mm, oldmm);
> >  	if (err)
> > -		goto free_pt;
> > +		goto free_pt_end_uprobe;
> > +	uprobe_end_dup_mmap();
> >
> >  	mm->hiwater_rss = get_mm_rss(mm);
> >  	mm->hiwater_vm = mm->total_vm;
> > @@ -1758,6 +1755,8 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
> >
> >  	return mm;
> >
> > +free_pt_end_uprobe:
> > +	uprobe_end_dup_mmap();
>
> if dup_mmap() fails and "mm" is incomplete, then with this version dup_mmap_sem
> is dropped before __mmput/exit_mmap/etc. How can this help?

Easy to fix, but what ensures that another mmget(mm) is not possible until
dup_mm() calls mmput() and drops dup_mmap_sem? Sorry, my understanding of mm/
is very limited...

Oleg.


