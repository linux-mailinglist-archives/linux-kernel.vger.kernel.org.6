Return-Path: <linux-kernel+bounces-426552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0909DF4DD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 07:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56060162DC3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 06:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6156339A1;
	Sun,  1 Dec 2024 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ExKz/JwC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB24C66
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733035462; cv=none; b=b01qOwi1NoQrmDrxofmsoccbKz6cxiJvbU6TrqhsqZdqGcqrL5tu8zgFDyfwaDk88xw65BZ9gd8TKaEnEyVbKch8s3zHq4AqAGj3OJufifAsK8xuNfSH5v60z4bwPtWlJ1RLZfjeh/pa+6b9qcUo8IwOiTPXkJe2c2kEKGzQ1CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733035462; c=relaxed/simple;
	bh=gsnpeJtjLe4QariqBC9pm0OX3G9e3PnVJM/Uc6pmVrE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DNTIv3b5n5DxZ4MZypjTGEfL0DatoUpfQFAaMGZRDzwcCyzkkBA6OazRIbAFU3hwSpsbMMVCVn2nxhw9X8fNlAVRhhg/0p96Ev+gl3Yd8CjBn/IXwZlHSYO581FQysLH5MXPj7VFrlNI3BlqNuulItD+4zlbG+505jQxlCSHDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ExKz/JwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0C3C4CECF;
	Sun,  1 Dec 2024 06:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733035461;
	bh=gsnpeJtjLe4QariqBC9pm0OX3G9e3PnVJM/Uc6pmVrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ExKz/JwCpE+Xrzq2DA+WFew2zJaxqm0cZF7AI5zJwwTd5dkgFM/RXyykUx8Iymymq
	 UrTVq+rtFgnzNdtZBC/LHc8BmiOnDdzeH4JtQw95zpeozzdimitIsboB3Hq2KJwCXh
	 NdA3C7tunDSR1d8GEAJy1PzJSnrSiFOBg33kFCXs=
Date: Sat, 30 Nov 2024 22:44:19 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Wei Yang
 <richard.weiyang@gmail.com>, andrii@kernel.org, jannh@google.com,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org,
 david@redhat.com, willy@infradead.org, brauner@kernel.org, oleg@redhat.com,
 arnd@arndb.de, zhangpeng.00@bytedance.com, linmiaohe@huawei.com,
 viro@zeniv.linux.org.uk, hca@linux.ibm.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm: introduce
 mmap_lock_speculate_{try_begin|retry}
Message-Id: <20241130224419.80c06e9458defceb2a4949ec@linux-foundation.org>
In-Reply-To: <20241125165357.GA16789@noisy.programming.kicks-ass.net>
References: <20241122174416.1367052-1-surenb@google.com>
	<20241122174416.1367052-3-surenb@google.com>
	<20241125005804.libwzfcz6d5zeyi4@master>
	<CAJuCfpF+ZdD3-gTSLr1iwpa=fefUyL5dLoy8vGpv=v7LABnjNw@mail.gmail.com>
	<20241125165357.GA16789@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Nov 2024 17:53:57 +0100 Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Nov 25, 2024 at 08:18:38AM -0800, Suren Baghdasaryan wrote:
> 
> > > >+static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigned int seq)
> > > >+{
> > > >+      return do_read_seqcount_retry(&mm->mm_lock_seq, seq);
> > >
> > > Just curious why we don't use read_seqcount_retry().
> > >
> > > Looks this is the only user outside seqlock.h.
> > 
> > Ah, good eye! read_seqcount_retry() would be better.
> > 
> > Peter, do you want me to post a new patchset or you can patch it when
> > picking it up?
> 
> Fixed up my local copy, thanks!

I take this to mean that you'll be merging these.  I don't see this
series in -next and I'm sitting on the v1 series, which I shall now
drop.


