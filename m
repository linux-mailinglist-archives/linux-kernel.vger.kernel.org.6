Return-Path: <linux-kernel+bounces-561248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24816A60F39
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1367B1B61E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B70F1FA267;
	Fri, 14 Mar 2025 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LpQOF44O"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A532E3364
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948986; cv=none; b=Q/OiJDO4sqpgJnuLBM5rTgLrgZudJosjjo2bwmJTGITLpIrfszPxNqkb0qx8ICTkeawd0+EGm9JVQ983Two8e1daa9Zi4KcPjDnQwbhsAK630BFtQ0qBWqGv0vKWQzaK0JNZK+yKDVyhiG7YEdbxbGV4oaDYA3FKq1Ljk2uZiiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948986; c=relaxed/simple;
	bh=xj5c3h3+9EHkZ7D08SDqSz9QHp7ya7b97JcQdUnsllg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQV9zaVH+xdm9zauacwvu04V4TmC2zzHqHg8qOKzGh6RvwQkTFxJxIMvStkmoRUYLQNNI8VbSNrTSr8m470w2PyILrhf0WkjO719BQ/HEkPj5hP582f45Zbj4HwiknarrDzqxoFSClymRCVvZrlb6vHUuOGD86fWehOgeDdS3Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LpQOF44O; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rd6w4yigRO8h2ZWJqdyz+Nf8QWgTX27yrEZWX1ITIoI=; b=LpQOF44OeVabPjmlD7yGVHEN2I
	HjOrpU+Q7JNGRhdJYCfr1BPmKkVskSEJk5jbbrwuLiKsWS+YlPIcQvKWDHhuLE5C1k1GJRsp1SKb3
	4maPq4oekgrEPLlfAJe/rBSf0+04k0L0TYPXMF5/9xanD2Tet4YH5ZAfPcQFcZXf71ymZIWAcFZ7d
	VJBpnuqtPEySsrdIAufoF2kDpL89/ultjKVNdmfoSESn6wGJ1C2uQ9DU6RYALLF69gl6dL+lk4Zrr
	+CeCmkjQ0RrbOc5gPE1N99/TPyqMHS9PUASYBeTn1j7U9xBkL6Ygci8dooPt031Um40KPcJ+PAORW
	6A3HV2Lw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt2VH-00000002spA-2Nlf;
	Fri, 14 Mar 2025 10:42:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 262BF300599; Fri, 14 Mar 2025 11:42:59 +0100 (CET)
Date: Fri, 14 Mar 2025 11:42:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v10 00/21] futex: Add support task local hash maps,
 FUTEX2_NUMA and FUTEX2_MPOL
Message-ID: <20250314104259.GA36322@noisy.programming.kicks-ass.net>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151848.RlB_XuHA@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312151848.RlB_XuHA@linutronix.de>

On Wed, Mar 12, 2025 at 04:18:48PM +0100, Sebastian Andrzej Siewior wrote:
> @@ -196,12 +196,12 @@ static bool __futex_pivot_hash(struct mm_struct *mm,
>  {
>  	struct futex_private_hash *fph;
>  
> -	lockdep_assert_held(&mm->futex_hash_lock);
>  	WARN_ON_ONCE(mm->futex_phash_new);
>  
> -	fph = mm->futex_phash;
> +	fph = rcu_dereference_protected(mm->futex_phash,
> +					lockdep_is_held(&mm->futex_hash_lock));

I are confused... this makes no sense. Why ?!

We only ever write that variable while holding this lock, we hold the
lock, we don't need RCU to read the variable.


