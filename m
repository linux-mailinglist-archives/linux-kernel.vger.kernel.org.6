Return-Path: <linux-kernel+bounces-418146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9C89D5DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FDC2825AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEDD1DE2AD;
	Fri, 22 Nov 2024 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W4ZslHOT"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320971DE2A3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273589; cv=none; b=rXyOnjivbNlW6AvG6rEUILGBRlKVbwXVSF8QS1suh8fXDwyantmycTcCE9OxCuZGA9XJs42PgcV9pxyps/lAqPee7Tu2byji3kPCjHJzASPjk+AlG8kmqmlAZJIyIM9DU6t/WPuc1AF3tuQUnggm2b+I6egNdqpskQ5FLeWicjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273589; c=relaxed/simple;
	bh=IKAQMrZzl9npvXfj9svSIjgU5gamU+wIAP+aO0PLjUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdT7SCQlHHO8dq9AqxNW06oSChSsalIOPdGJ06IqADpxjg3QCkhPoChONz0ba9mR5OmVKoFNnBKO9rDTD5ML6ha6eDntToMxe0rxs2cYa3aqYugnUM65ZMUVEHCUdFAYcQu7j1c+uaoxnAPtR3JHJnHg0uuTXauI7hDMNvdg+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W4ZslHOT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PK5XMeMWTKs+nqsPJkM2UEruSaQteTZxuGzB/+p61s8=; b=W4ZslHOTn2pVO1rAxLyQRhuNDU
	5ee0NH5hOEfmpFPWrNTp4HwSAWB56/EUZxnhRIOv2NAlbhaGlGG5qXZuGyVhbzMNpGaispKDx0ucF
	69V9/h83vSxpfpOU/AWfVpyv/KLk33aYAikD1IjYjyP8E4T9uWjhZpVL6oOAR5pIpgrdBTBl+Clpb
	VvQZVpwdhBnXEMOWXBDLaro6kIVuvUobBqJodRiOKNTrJj9Z16JQbzIxx12uMfr0KFtd7rcfudYxm
	jcTJG9ZMoI4B6RYIjBBpRfUCSIPTqzVIALm+EwGvnMV4rKg+bCHsoN6sMO455fOfI6qQRAs8DqQ60
	cKQ14oxg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tERU6-00000000hH8-1UCi;
	Fri, 22 Nov 2024 11:05:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1DCF430066A; Fri, 22 Nov 2024 12:05:57 +0100 (CET)
Date: Fri, 22 Nov 2024 12:05:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, andrii@kernel.org, jannh@google.com,
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
	mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	david@redhat.com, willy@infradead.org, brauner@kernel.org,
	oleg@redhat.com, arnd@arndb.de, richard.weiyang@gmail.com,
	zhangpeng.00@bytedance.com, linmiaohe@huawei.com,
	viro@zeniv.linux.org.uk, hca@linux.ibm.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm: introduce
 mmap_lock_speculate_{try_begin|retry}
Message-ID: <20241122110557.GO24774@noisy.programming.kicks-ass.net>
References: <20241121162826.987947-1-surenb@google.com>
 <20241121162826.987947-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121162826.987947-3-surenb@google.com>

On Thu, Nov 21, 2024 at 08:28:26AM -0800, Suren Baghdasaryan wrote:
> Add helper functions to speculatively perform operations without
> read-locking mmap_lock, expecting that mmap_lock will not be
> write-locked and mm is not modified from under us.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Thanks for these, you're okay with me taking these through tip/perf/core
for the next cycle along with Andrii's uprobe patch?

