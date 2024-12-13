Return-Path: <linux-kernel+bounces-445360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C51C9F150A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E25528324C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9B11E570E;
	Fri, 13 Dec 2024 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qKi7brVi"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0AB1E25F6
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734114973; cv=none; b=kSp9SMiG+UbU1xxeDZ8xuzVq1Qu/hviDvwXNbSXXgxiKqApnakBeIgVWee0DTgnarNFUm5pEc0usFWLi1XvFpWZsDFQ3pmVmahEtdKYtHropau1WNCpvMKauXl/ZCOLl2oWxCJgZoPo3ajDWVFW6rY2ReXH0QgSFhkhMuw5Qb2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734114973; c=relaxed/simple;
	bh=Lex8M3vbwXk+SNMmsIMbUwfKnRA3ICs/RXou1t8ZPic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoZOj9w5ZsGiCsw+dtpB+O4210ypgFrSr6BdQd4yf17+kU/bLan7oTVTNqe48VkKYnzo265dXCxBgHTlZUf030f1+Vzv09wpSJzMy1HBNeKLD4yEX2sXHOUgf5Y0jByTcRDzkppUzKN6WVA6MNWsNNIwWsCDFAfTWcJobbj/wxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qKi7brVi; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=QP0rLrZEOWtLvGAvpM2Dc2lFdgXH5FkqvO9qJJBzHq4=; b=qKi7brVi6zL51rH4AXAGj4hZyq
	nzqxoZKVsx+/TMlDZdIKGvOFn/IxKZqNk0yTb+4DWTi87oJltg0ll3WpLTbfeTj76NBKqilVxjGW+
	hlMt/ahJnK8/BV87QmxQLyhPrOdFbgDaEqEAE8+LJIw4UYkyZxGECyNCbKqiclsWqc9DTvxZbZT+J
	YI+QZRbzPqH4P2OIOYfWLu6uI9scjHZpxP7hN/K2o/6MECD3BeBxn/td2F+tE2pgLQUwouaHCvcho
	fmSNJD7F0GZyO2Y+uiRrkHun9hdZTYRtAH3gJ0lkw4A+suoe41dfi+P1QjfSx4lWQsi5CGT8pb5Fm
	zIDfmkTQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tMAVw-00000004K5m-0Hax;
	Fri, 13 Dec 2024 18:35:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9984A30049D; Fri, 13 Dec 2024 19:35:46 +0100 (CET)
Date: Fri, 13 Dec 2024 19:35:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com,
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
	mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
	hughd@google.com, minchan@google.com, jannh@google.com,
	shakeel.butt@linux.dev, souravpanda@google.com,
	pasha.tatashin@soleen.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 3/4] mm: replace rw_semaphore with atomic_t in vma_lock
Message-ID: <20241213183546.GB12338@noisy.programming.kicks-ass.net>
References: <CAJuCfpETJZVFYwf+P=6FnY_6n8E7fQsKH6HrOV1Q_q9cFizEKw@mail.gmail.com>
 <20241211082541.GQ21636@noisy.programming.kicks-ass.net>
 <CAJuCfpEMYhAmOPwjGO+j1t+069MJZxUs1O1co-zJ4+vEeXCtng@mail.gmail.com>
 <CAJuCfpGOOcRAJ46sbPRoCUNuuhi2fnkM97F=CfZ1=_N5ZFUcLw@mail.gmail.com>
 <20241212091659.GU21636@noisy.programming.kicks-ass.net>
 <CAJuCfpHKFZ2Q1R1Knh-LFLUYcTX6CJuEsqNM5AwxRyDUAzdcVw@mail.gmail.com>
 <CAJuCfpGKEthmc2JkbOcfEJqsM_cBcm0cAvv0VFe-acMi169fcQ@mail.gmail.com>
 <CAJuCfpGJcrCkzOtaZDH98_oQK01+HNxHzzsf7SS95cXVRyXUPg@mail.gmail.com>
 <20241213095729.GC2484@noisy.programming.kicks-ass.net>
 <CAJuCfpHJn9jLT4zW2vPc4kv-Y3_3BTNXkn7pjFEKLVeFjxL4oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHJn9jLT4zW2vPc4kv-Y3_3BTNXkn7pjFEKLVeFjxL4oQ@mail.gmail.com>

On Fri, Dec 13, 2024 at 09:45:33AM -0800, Suren Baghdasaryan wrote:
> On Fri, Dec 13, 2024 at 1:57 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Dec 12, 2024 at 08:48:52PM -0800, Suren Baghdasaryan wrote:
> >
> > > I'm not sure if this is the best way to deal with this circular
> > > dependency. Any other ideas?
> >
> > Move the waiting into an out-of-line slow-path?
> >
> >   if (atomic_read(&vma->refcnt) != 2)
> >     __vma_write_start_wait(mm, vma);
> 
> The problem is not a function but the addition of struct rcuwait into

Durr, in my brain that was a struct task_struct pointer, totally forgot
we had a type there. Yeah, as Willy says, move it to compiler_types.h or
somesuch.

