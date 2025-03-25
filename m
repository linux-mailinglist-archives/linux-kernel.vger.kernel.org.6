Return-Path: <linux-kernel+bounces-576280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82BEA70D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092B3170A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679F7269806;
	Tue, 25 Mar 2025 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kQdFXwpL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221341EFF98
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742943238; cv=none; b=IgS6f9oBybyUJ4xhzffmTOCmunEinR9SpEduQ5AoaPznGfbbgW8NbSKclaSWrA0qonc7TUUWutxTnDJ/cj7F5AABN+tr0lYK11A1QzXKsZJPwR0pwYkmGWjEIYkJ8fNdvLy4wbzUsa67ua0I/9d37/LCRFnqqvFZ78ot84IsKsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742943238; c=relaxed/simple;
	bh=2lX4azzgAeTghBjDcton31mgDKIIIdZUB9sjcDT9M/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/6dPFnADxhmsNN9iZfBSwF5dRsxpTIgeTp5pJmLFwTRZ0bDbwCNj7GuzWxdXO81B1AE+5jznmS/s8FSEHxSanaZBnpQGLgtamwXHDKxRZWNUtxONOuM/O0IcMALAOlTt/Pq9u7kPsvsDAq+0o+Y5U/vYbVstkAO2onhLchFpb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kQdFXwpL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6iEGH+wqFikm0aAj4bF7ejT5MwPRP25Q3mYTk/IdX7o=; b=kQdFXwpLhi0YEZSdDnEjGTMsDU
	euZFkSiodwlTIRIXZ+XQmpDKQ4HkcjV41S8LG0XDgt033iXb2jQZa98fAc7+nqhKHxT5yl40Y9A2e
	Md1WfhMwRk7m/YMH8krESkq1xwWNvlyBrtO9fA4VWWItz3Ghv9Kc2kMy4Y0cjBTQqQpYXyLkIB+fc
	PwU5/KtwA33WeBWrqe8BFsyPwbZf8JvTm1MB8U/RBNDGkiOhiykS+wMwMC6P7oWju/mjUAWwab6yO
	i2NSysD3UuJ8tASzf5gv7mSIvmjTh+0/EoTBjhvaE7oF98oOZUSK/Ak8ziRIzENaTO9yc3o4NIxJn
	qnn2WvuQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txD8d-0000000FW62-3roa;
	Tue, 25 Mar 2025 22:53:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 462BC3004AF; Tue, 25 Mar 2025 23:52:51 +0100 (CET)
Date: Tue, 25 Mar 2025 23:52:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 20/21] futex: Implement FUTEX2_NUMA
Message-ID: <20250325225251.GO36322@noisy.programming.kicks-ass.net>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151634.2183278-21-bigeasy@linutronix.de>
 <fc3a6902-a845-4b11-ace8-514f10194288@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc3a6902-a845-4b11-ace8-514f10194288@linux.ibm.com>

On Wed, Mar 26, 2025 at 01:22:19AM +0530, Shrikanth Hegde wrote:

> > +	if (node == FUTEX_NO_NODE) {
> > +		/*
> > +		 * In case of !FLAGS_NUMA, use some unused hash bits to pick a
> > +		 * node -- this ensures regular futexes are interleaved across
> > +		 * the nodes and avoids having to allocate multiple
> > +		 * hash-tables.
> > +		 *
> > +		 * NOTE: this isn't perfectly uniform, but it is fast and
> > +		 * handles sparse node masks.
> > +		 */
> > +		node = (hash >> futex_hashshift) % nr_node_ids;
> > +		if (!node_possible(node)) {
> > +			node = find_next_bit_wrap(node_possible_map.bits,
> > +						  nr_node_ids, node);
> > +		}
> > +	}
> > +
> > +	return &futex_queues[node][hash & futex_hashmask];
> 
> IIUC, when one specifies the numa node it can't be private futex anymore?

The futex can be private just fine. It just won't end up in the process
private hash, since that is a single mm wide hash.



