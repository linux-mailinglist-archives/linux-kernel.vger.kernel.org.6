Return-Path: <linux-kernel+bounces-395855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3019BC3F6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3E31C20D8F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB58187325;
	Tue,  5 Nov 2024 03:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R1b4aJ4N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EEB3C39
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730778025; cv=none; b=HYD+sV32By4vExdtu66xxTH80MxJ7erlHVOX3GlmQZnhQ1zCGLyPzw+DTwAMEcoBvK6IU4rHVcVw+dMX9GbfERyMYyAEbmd3MbC9J0wrlI+PZiWIrM/skha7VoWFro6aIApmY6PVe7QNBsBFo1vnZbXNCHPjThgeAWYP1ZOckOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730778025; c=relaxed/simple;
	bh=QxjNHT4TitqMtQmgK+mrt83B6I4xGZlhjxuQha47rTo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oOtc5sF52x41JguzojpTtGxmMMepgzc7Shb8crtDuAAlAbgmzxGwpqpji/jIPaSCj4FMWI3sPm+yZVEfUqDTTXwny5yTE8zlDzhpdx78aWmDPbAmNKrWWNGPuRS9h8BlwhY/bjrf2Fd1iEl3jqNceS+kYQvHJSBgwdJfRYCsn3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R1b4aJ4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19A4C4CECF;
	Tue,  5 Nov 2024 03:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730778025;
	bh=QxjNHT4TitqMtQmgK+mrt83B6I4xGZlhjxuQha47rTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R1b4aJ4NyjKe6zc2SBzWEdsakiDQzkHlWwJzpqU3Mcn0CexPwa52HVR1q0FZZ0cft
	 MQPNDvPyHo0tDMPivyrj8CFkeQDF9KyAdH2s8xTgr+epB0b0KgARAtJekPW54dheGy
	 w+OLM6KzcGbzuXplZllIJzdHpx4IZwHg9BzY3sgs=
Date: Mon, 4 Nov 2024 19:40:24 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, Usama Arif <usamaarif642@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Barry Song
 <v-songbaohua@oppo.com>, Chengming Zhou <chengming.zhou@linux.dev>, Yosry
 Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>, Matthew
 Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, Andi
 Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, Kairui
 Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v2] mm: count zeromap read and set for swapout and
 swapin
Message-Id: <20241104194024.0284288a28a71a70a3eab9b0@linux-foundation.org>
In-Reply-To: <3f943f72-59d6-4124-96b2-e0bb8d7a5ebd@redhat.com>
References: <20241102101240.35072-1-21cnbao@gmail.com>
	<6c14ab2c-7917-489b-b51e-401d208067f3@gmail.com>
	<CAGsJ_4wpdf6Fky7jj8O6OuLc0WTBjKXTfEqxE0cXiUjxxuLgZA@mail.gmail.com>
	<3f943f72-59d6-4124-96b2-e0bb8d7a5ebd@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 13:32:55 +0100 David Hildenbrand <david@redhat.com> wrote:

> > As mentioned above, this isn't about fixing a bug; it's simply to ensure
> > that swap-related metrics don't disappear.
> 
> Documentation/process/submitting-patches.rst:
> 
> "A Fixes: tag indicates that the patch fixes an issue in a previous 
> commit. It is used to make it easy to determine where a bug originated, 
> which can help review a bug fix."
> 
> If there is no BUG, I'm afraid you are abusing that tag.

I think the abuse is reasonable.  We have no Should-be-included-with:.

0ca0c24e3211 is only in 6.12-rcX so this is the time to make
userspace-visible tweaks, so the 6.12 interfaces are the same as the
6.13+ interfaces (which is what I think is happening here?)

And including the Fixes in this patch might be useful to someone who is
backporting 0ca0c24e3211 into some earlier kernel for their own
purposes.


