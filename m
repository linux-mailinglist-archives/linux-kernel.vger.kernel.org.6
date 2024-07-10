Return-Path: <linux-kernel+bounces-247192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090AE92CC53
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83101F21285
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1F184A35;
	Wed, 10 Jul 2024 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cdrOSkbt"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7371D7BB17
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720598167; cv=none; b=XzpWPY/P6SnzeVJy+5PNeD5VrqVsBdz0edx8C1/FRym3tL/pNa1xpXnhoaZUyQdOxbtBPC2/33eg9goC0zrxnYKem3aReM+A7GYSyH6e+Bzvz8t+AHJcU0VjIuRA/GEHAuNPmf8DgzkmVKb+ubFNxOl4vPWMSpXG5bgsTdiJKD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720598167; c=relaxed/simple;
	bh=inmnD2fQgpAM/3A0Ue90iCvsEUAxhw8QfjYju/cmk7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsN4bVKC5s4ioKCs9XNEIA0TLP0sSxbYCMSQDL94NPx727I4INSJ0y4Sk09tFQ2yyWwszYYg8BZWilYK0WOHpCtQ/pBp22Q44e33s+WTRsXT7+u9u2ah3V/xMorjMXaTrisEd333zvhAP6XKj2wSgvOZ9hKFh01B4jjvzg0PTx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cdrOSkbt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9kAqGJsHyHkATKKyUNzXIJNUM9lm6tJYyjP0FY/do5o=; b=cdrOSkbtByOdWixEuGDhRpTe4m
	WpQedhIUoxhHMP6l6lW/lTi0VfGOlHWjmRv1P903QOMcyg7w1sCdQHkhv3HwWvgiGWfkj53XZDO56
	Mq0/n6OSB95PZ1iPJdgdYJQ4Kse9cwy2idgfoJm1u2WQd7ShZ0V7zGiOMwoxVr1rtXGB2b5iH3sLt
	jjk5FaXBchtYCPsUvfdDOgjz8fAl0yIkWwPXRAICATVi2bGFzOVhaKn9lLEjr1wb3anWOEJCfQ7Wv
	9Z7MditnzOi1mciYtRPhnf2CG3bRK2tAQpYxmufi3KQ7KH76GUmhUZgDMa3cvRgkLqHO10KFgTYpH
	i0Mf/i9Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRSBB-00000000sHz-3e1S;
	Wed, 10 Jul 2024 07:55:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3D3B7300694; Wed, 10 Jul 2024 09:55:57 +0200 (CEST)
Date: Wed, 10 Jul 2024 09:55:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 03/10] rbtree: Provide rb_find_rcu() / rb_find_add_rcu()
Message-ID: <20240710075557.GS27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240708092415.464066230@infradead.org>
 <20240710102959.291a71349ec71ef48919a9fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710102959.291a71349ec71ef48919a9fe@kernel.org>

On Wed, Jul 10, 2024 at 10:29:59AM +0900, Masami Hiramatsu wrote:
> On Mon, 08 Jul 2024 11:12:44 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Much like latch_tree, add two RCU methods for the regular RB-tree,
> > which can be used in conjunction with a seqcount to provide lockless
> > lookups.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  include/linux/rbtree.h |   67 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> > 
> > --- a/include/linux/rbtree.h
> > +++ b/include/linux/rbtree.h
> > @@ -245,6 +245,42 @@ rb_find_add(struct rb_node *node, struct
> >  }
> >  
> >  /**
> > + * rb_find_add_rcu() - find equivalent @node in @tree, or add @node
> > + * @node: node to look-for / insert
> > + * @tree: tree to search / modify
> > + * @cmp: operator defining the node order
> > + *
> > + * Adds a Store-Release for link_node.
> > + *
> > + * Returns the rb_node matching @node, or NULL when no match is found and @node
> > + * is inserted.
> > + */
> > +static __always_inline struct rb_node *
> > +rb_find_add_rcu(struct rb_node *node, struct rb_root *tree,
> > +		int (*cmp)(struct rb_node *, const struct rb_node *))
> > +{
> > +	struct rb_node **link = &tree->rb_node;
> > +	struct rb_node *parent = NULL;
> > +	int c;
> > +
> > +	while (*link) {
> 
> 	Don't we need to use rcu_dereference_raw(*link) here?

This is a modifying operation and as such we can assume operation under
the exclusive lock. IOW the tree should be stable here.

> > +		parent = *link;
> > +		c = cmp(node, parent);
> > +
> > +		if (c < 0)
> > +			link = &parent->rb_left;
> > +		else if (c > 0)
> > +			link = &parent->rb_right;
> > +		else
> > +			return parent;
> > +	}
> > +
> > +	rb_link_node_rcu(node, parent, link);

Only the link operation needs the rcu_assign_pointer() thing for
publishing our new node.

> > +	rb_insert_color(node, tree);

The rotations use WRITE_ONCE() to avoid tearing.

> > +	return NULL;
> > +}

