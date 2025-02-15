Return-Path: <linux-kernel+bounces-516340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADFCA36FE2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C8D170771
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5FF1DF982;
	Sat, 15 Feb 2025 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GrQ9fAC0"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D772C194C61
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641187; cv=none; b=i7g43cGY72DMQV4L8y+kcDrel3ydIpzsUd9yS4sWJ9CqP/nbqubXKV8ffBvQ3ONJD8bonqkzwYqgPEacnHS4cBYIWKA2Q07U5aIGN1mTFoaN5ncB+9mDHUwJ4K6sK6aIL6//h4cKRZYZCn/XeqfRCvA0TncfgLrBWNpgE3KBgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641187; c=relaxed/simple;
	bh=Vkqk56CiSaIm1WmBYYKCLWsDmdz7leX4C6Zf2dDeBFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkslxKnil0r5zZrU8eaTViQa+nSDqB2YnACscQvKyEoHbA5zuo1DIfnDN8l/OWeQ3XJWgervKtXbg1Ow3uXmiV9YGg6z9KO+VwFsoq8YZI2UP46jU9LNYQCQX0qhY9/rg1O+CDxCs3lyoxNBKIjaQjSFY2E1fTb3WnijgffT/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GrQ9fAC0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BGrG2Mj6SRiHh9feLmfaFG7VLZnuRMYMNio14GTkavQ=; b=GrQ9fAC0Ity9dhazH+K3xIwyUJ
	bR6lnxyapxTErpBSVBYqiB3YZDs+3k/xa4edFPNF1ctzc3qGb2eKNCuiT4mhAqHgPpVCLZK7AZq6y
	F5wsa0zhrzUq35gUkqFJzrhNMp4u/ER1AyJVQ6KjDP2NeYGN/IyTibTDoJPZA0wk4oimeV1q4tFRB
	Drch20WdOGoZQVm7tZ5Nh9XZhRPQkToHi0m9Y53A4/WPQ2SAWztttAE0cqdut1YuIcoLNe2lZpG1Z
	ryijGLMMUPCzf7yU/NPd6PLiZplpSkHdUegv+OgpIMFi5J58G/uQ7qULMwtDyJQ4WPPq/TDKmIj+2
	GcFJr5mg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tjM8j-0000000DO6g-1wPI;
	Sat, 15 Feb 2025 17:39:41 +0000
Date: Sat, 15 Feb 2025 17:39:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Liam.Howlett@oracle.com,
	brauner@kernel.org, lorenzo.stoakes@oracle.com,
	Davidlohr Bueso <dave@stgolabs.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc: fix to protect IPCS lookups using RCU instead of
 semaphore
Message-ID: <Z7DRXSbE8IDxXZeK@casper.infradead.org>
References: <20250214180157.10288-1-aha310510@gmail.com>
 <20250214152128.61a1054b90d1a53eff9cf16b@linux-foundation.org>
 <CAO9qdTHkk-4C59sv=B6ZPkcu4AmSNtuvFsdSWQNmwHoTXTCLmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9qdTHkk-4C59sv=B6ZPkcu4AmSNtuvFsdSWQNmwHoTXTCLmw@mail.gmail.com>

[Fixing Davidlohr's email address -- David could you pop an entry into
.mailmap?]

On Sat, Feb 15, 2025 at 02:00:23PM +0900, Jeongjun Park wrote:
> Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Sat, 15 Feb 2025 03:01:57 +0900 Jeongjun Park <aha310510@gmail.com> wrote:
> >
> > > In shm_destroy_orphaned(), we are not performing updates to the IPCS and are
> > > only calling idr_for_each(), which can be protected by the RCU read-critical
> > > section.
> > >
> > > And if idr_for_each() is not protected by the RCU read-critical section,
> > > then when radix_tree_node_free() is called to free the struct radix_tree_node
> > > through call_rcu(), the node will be freed immediately, and when reading the
> > > next node in radix_tree_for_each_slot(), the memory that has already been
> > > freed may be read.
> >
> > A use-after-free?
> >
> > Is there any report of this occurring, or was this change a result of
> > code inspection?  If the former, please share details (Link:,
> > Reported-by:, Closes:, etc).
> 
> Reported-by: syzbot+a2b84e569d06ca3a949c@syzkaller.appspotmail.com

For anyone else trying to understand what the hell this is about,
the report is at:

https://lore.kernel.org/linux-kernel/67af13f8.050a0220.21dd3.0038.GAE@google.com/

> Sorry I forgot the Reported-by tag. I think the vulnerability is caused by
> misusing RCU. In addition, since it is a function that does not perform
> an update operation, it is possible to protect it through RCU, so we can
> safely get some performance small benefits by using RCU instead of
> semaphore.

shm uses RCU in a very weird way.  You're absolutely right that we need
to hold the RCU read lock here to prevent the tree nodes from being
freed below us.

But I'm not convinced that removing the rwsem is safe.  Look at what
else is in the call chain:

       if (shm_ids(ns).in_use)
                idr_for_each(&shm_ids(ns).ipcs_idr, &shm_try_destroy_orphaned, ns);

shm_try_destroy_orphaned:
                shm_destroy(ns, shp);
shm_destroy:
        shm_rmid(shp);
shm_rmid:
        ipc_rmid(&shm_ids(s->ns), &s->shm_perm);
ipc_rmid:
        WARN_ON_ONCE(idr_remove(&ids->ipcs_idr, idx) != ipcp);

So what's protecting that idr_remove() if not the rwsem?

(the shortcut for this is that shm_destroy() actually documents that it
needs shm_ids.rwsem held.  But it doesn't have a lockdep assertion.
Perhaps you could add one?)

