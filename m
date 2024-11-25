Return-Path: <linux-kernel+bounces-421390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E59D8AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CBC168AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAE51B4126;
	Mon, 25 Nov 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cSTTDs13"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2AD1B4F1A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732553664; cv=none; b=kclA3PSX/S3RwvpqHTdB31DbK2m5wYNb51/oKI2ZvoTQWgeK6bXu75Hjxannl3+ZhJofoJGh7piop/lhPsVAWuvJJ5Ak8t+lenURFoTuVDZ4aM0ZZ+sY66z4M3pdunLMOIlqY0x0qpHtjDWTW/5MuZ8Bxa2G+oFLSQFPZ70MjTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732553664; c=relaxed/simple;
	bh=c0VUMZ8rfmZkitQIw08eoA7A5Ca9RrLrwdiRP1Yx4TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti1UYuc0cvgGed2co8sWuiAR2me3jUA7LL8Q/hLQwB9djBx+iIv/B8XRWxa2n1d8+tSt32CqpiVj7VmXnzwLEGX0e/dpuGMtD2OdSPvgd1dM9gk/rec7woOQbEHduh3RsT2mQZQlI0Bx9LD8/V4lItSNNqWgMwPKFXlmufTvT2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cSTTDs13; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E2Re+/DWcuGRoj5t1bYoz9VASCPFYUF6fXcLL5oeIGw=; b=cSTTDs13q0Voxav85dJNtCfvAi
	h81tDHDatyKXr2upRiEwNTU79fp2G3CrMDM9CH7p/bsB/Bg+MFOQga1+lc3O9eYRv1a78+ZdHxppx
	i2weMhHN8GimiArPA4CjzM1we1WbpchmxYuKodE3h6tr46yF8ZV/gCsd89HW+Lx8w76pY6+WrjAzH
	m6/6jswOEczit9ogAhMsmihVa+We1ukh+OYmDGh6NqGa1vQyoJkIecOckrB7b8uJ06qsLklKpNbKv
	YINxw9HrOl9Pxc0xCrLKyp7GwKRS/Xb4YFDiVmAYUR+bXLjR8Sf2Za2cyOhJwXJwmGRMxuzDQjg2f
	h853yH8w==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFcLW-000000016tq-18sH;
	Mon, 25 Nov 2024 16:53:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7EE8730026A; Mon, 25 Nov 2024 17:53:57 +0100 (CET)
Date: Mon, 25 Nov 2024 17:53:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	andrii@kernel.org, jannh@google.com, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, mhocko@kernel.org,
	shakeel.butt@linux.dev, hannes@cmpxchg.org, david@redhat.com,
	willy@infradead.org, brauner@kernel.org, oleg@redhat.com,
	arnd@arndb.de, zhangpeng.00@bytedance.com, linmiaohe@huawei.com,
	viro@zeniv.linux.org.uk, hca@linux.ibm.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm: introduce
 mmap_lock_speculate_{try_begin|retry}
Message-ID: <20241125165357.GA16789@noisy.programming.kicks-ass.net>
References: <20241122174416.1367052-1-surenb@google.com>
 <20241122174416.1367052-3-surenb@google.com>
 <20241125005804.libwzfcz6d5zeyi4@master>
 <CAJuCfpF+ZdD3-gTSLr1iwpa=fefUyL5dLoy8vGpv=v7LABnjNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpF+ZdD3-gTSLr1iwpa=fefUyL5dLoy8vGpv=v7LABnjNw@mail.gmail.com>

On Mon, Nov 25, 2024 at 08:18:38AM -0800, Suren Baghdasaryan wrote:

> > >+static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigned int seq)
> > >+{
> > >+      return do_read_seqcount_retry(&mm->mm_lock_seq, seq);
> >
> > Just curious why we don't use read_seqcount_retry().
> >
> > Looks this is the only user outside seqlock.h.
> 
> Ah, good eye! read_seqcount_retry() would be better.
> 
> Peter, do you want me to post a new patchset or you can patch it when
> picking it up?

Fixed up my local copy, thanks!

