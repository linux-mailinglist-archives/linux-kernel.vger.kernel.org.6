Return-Path: <linux-kernel+bounces-396206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0F99BC957
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577C72854FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA601D0F66;
	Tue,  5 Nov 2024 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Je5WzFga"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B7A1AD9F9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799248; cv=none; b=AJ2Txn6fUNMC/g9daPoXUPrH6c3FxInEyuKCYEGdZ4p9yborM0o7ESL1qJgX0f9ATNdqZSbUQVrSrmhoUlFJL1/bUWkMtUAiskM7hozkHf4iQudtwRJFmzgJAAnMpNO6C9qz1zszUL3JnhWZNR2ppwaFkmb9eLATdRls7v9Kl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799248; c=relaxed/simple;
	bh=navUaz/1LHTWtEB0gtdXd6+ahnYxAifsXlH5oHaNo2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyIy99UzYENgi1mdFvFqYJdGASVJrD7v4+lxrBj3LbQQr3o3BIzI7Nhi6Ypq3TCRjqMu+6UnYd10ZdX6YEpevVEJjDJDJEOvXEALPsYUKARd5dlegkiMZHhfh6n7Bs03f6/Wu9GSsZ4i7zd9Tp3mL79Hgxi+g6rMvoGMeXqkFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Je5WzFga; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/Bs5buUWkBHBsOr2+ZZy1EpMRfHdPjXKx1KmY+SwxDs=; b=Je5WzFga/xBByrDLTbjKFtXwpw
	3RgkeoQkLxZpdmx/0Jl6p7dFh/HQxDT8oBRaLFVjEv6+MiHddZ1HiAUQwgzc+75wmN13jGFgGmv5b
	2AI9+pnK1V6bOc3ka91AQVE2dEgJaRxqIvaZnUsmqKSNYBJhHKKKXJoowZK+ugSG9df8jfVhUGnY1
	xCEOBMW63l0kxvbyOqPBnImNHEhdcnP6ujdPrLrKKMMytbi+NrT8GmR6ZLgCmSr0SgnYDaxwD8Fqv
	08VXVVB4Io9WRT4dJuNOaIsZAP8hCf3dsIsqAEfAggL8MW6WXBj+Fdsh2BFmBMmGRFqtu2T9jXbvF
	Wu4Why/w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Fwl-00000002NjH-48Uw;
	Tue, 05 Nov 2024 09:34:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3A78C30083E; Tue,  5 Nov 2024 10:34:00 +0100 (CET)
Date: Tue, 5 Nov 2024 10:34:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marco Elver <elver@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 5/5] kcsan, seqlock: Fix incorrect assumption in
 read_seqbegin()
Message-ID: <20241105093400.GA10375@noisy.programming.kicks-ass.net>
References: <20241104161910.780003-1-elver@google.com>
 <20241104161910.780003-6-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104161910.780003-6-elver@google.com>

On Mon, Nov 04, 2024 at 04:43:09PM +0100, Marco Elver wrote:
> During testing of the preceding changes, I noticed that in some cases,
> current->kcsan_ctx.in_flat_atomic remained true until task exit. This is
> obviously wrong, because _all_ accesses for the given task will be
> treated as atomic, resulting in false negatives i.e. missed data races.
> 
> Debugging led to fs/dcache.c, where we can see this usage of seqlock:
> 
> 	struct dentry *d_lookup(const struct dentry *parent, const struct qstr *name)
> 	{
> 		struct dentry *dentry;
> 		unsigned seq;
> 
> 		do {
> 			seq = read_seqbegin(&rename_lock);
> 			dentry = __d_lookup(parent, name);
> 			if (dentry)
> 				break;
> 		} while (read_seqretry(&rename_lock, seq));
> 	[...]


How's something like this completely untested hack?


	struct dentry *dentry;

	read_seqcount_scope (&rename_lock) {
		dentry = __d_lookup(parent, name);
		if (dentry)
			break;
	}


But perhaps naming isn't right, s/_scope/_loop/ ?


--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -829,6 +829,33 @@ static inline unsigned read_seqretry(con
 	return read_seqcount_retry(&sl->seqcount, start);
 }
 
+
+static inline unsigned read_seq_scope_begin(const struct seqlock_t *sl)
+{
+	unsigned ret = read_seqcount_begin(&sl->seqcount);
+	kcsan_atomic_next(0);
+	kcsan_flat_atomic_begin();
+	return ret;
+}
+
+static inline void read_seq_scope_end(unsigned *seq)
+{
+	kcsan_flat_atomic_end();
+}
+
+static inline bool read_seq_scope_retry(const struct seqlock_t *sl, unsigned *seq)
+{
+	bool done = !read_seqcount_retry(&sl->seqcount, *seq);
+	if (!done)
+		*seq = read_seqcount_begin(&sl->seqcount);
+	return done;
+}
+
+#define read_seqcount_scope(sl) \
+	for (unsigned seq __cleanup(read_seq_scope_end) =		\
+			read_seq_scope_begin(sl), done = 0;		\
+	     !done; done = read_seq_scope_retry(sl, &seq))
+
 /*
  * For all seqlock_t write side functions, use the internal
  * do_write_seqcount_begin() instead of generic write_seqcount_begin().

