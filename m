Return-Path: <linux-kernel+bounces-247736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D74B92D3C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBF22B21ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15782193453;
	Wed, 10 Jul 2024 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZA/P6SR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4E4190075
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620327; cv=none; b=hR9Oe2O7vazQr4I6er/Yg6TZopO6UTX2U8n0Az5kHfVAdlWkAEuKSGOapYML/UVRtuNgqcg6/1CN62yn4s6o4TpIfS/X2eNEvDf+KT7e1M+1sZnSyiZj56D3bEMvS1iumvSC1XZEj/p537K3RAcYNqphAoIQvURTiv4366og7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620327; c=relaxed/simple;
	bh=HtlymKn4vVZB7cE/VW/XbqpAg4LhAbY/Dpx6qL2BAbw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sFQMfneVDBS4Ca2mrlee4FUpyMNES/XDh506yUkBUl5FbHBMVb0EE01H5adp1wcv8oYzWZwVI2+N2wYcmCCvMn++enXzIcIUSL/265/V0jQLJQSrKOmbB07V3Qat/lmHKS1fE5zeMGaqoc1YD5jSvw0zQ37lCTjb7qGUgKRyPaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZA/P6SR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D605FC32781;
	Wed, 10 Jul 2024 14:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720620326;
	bh=HtlymKn4vVZB7cE/VW/XbqpAg4LhAbY/Dpx6qL2BAbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KZA/P6SRLVafNoU8yO8WykWyAR7MfA7uN6nn2fq185T5U1mV25oTYvQ/6K9S77SHn
	 8qTtSCxMpC3X3a7dbfb3YKqZkI7qoTwo2Le1NddF7UigPv+EsRMYX3x+2XVexmCesp
	 MAvOdbnXJAvSsOzzSBwRTA4RxmRceyiHO22XR8Hzhg7awa2b6zJ923jt1MzMJHQiLK
	 JGjNRKU1rUswvwfVx4QyaCmRrdJNM2yL6Ui08yjlCJi1mcvVoCycliXCdST/FfCCya
	 gdMo2h7MwU8pMUtDyEjbUcjtKxUM+K6XMAF+/vyb0ltMEduZ4PyT3mC03AacDwrV2Q
	 SpasbGMyeI8+Q==
Date: Wed, 10 Jul 2024 23:05:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org, clm@meta.com,
 paulmck@kernel.org
Subject: Re: [PATCH 03/10] rbtree: Provide rb_find_rcu() / rb_find_add_rcu()
Message-Id: <20240710230521.db73990a46ca2f927dd0e8a5@kernel.org>
In-Reply-To: <20240710075557.GS27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
	<20240708092415.464066230@infradead.org>
	<20240710102959.291a71349ec71ef48919a9fe@kernel.org>
	<20240710075557.GS27299@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 09:55:57 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jul 10, 2024 at 10:29:59AM +0900, Masami Hiramatsu wrote:
> > On Mon, 08 Jul 2024 11:12:44 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > Much like latch_tree, add two RCU methods for the regular RB-tree,
> > > which can be used in conjunction with a seqcount to provide lockless
> > > lookups.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  include/linux/rbtree.h |   67 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 67 insertions(+)
> > > 
> > > --- a/include/linux/rbtree.h
> > > +++ b/include/linux/rbtree.h
> > > @@ -245,6 +245,42 @@ rb_find_add(struct rb_node *node, struct
> > >  }
> > >  
> > >  /**
> > > + * rb_find_add_rcu() - find equivalent @node in @tree, or add @node
> > > + * @node: node to look-for / insert
> > > + * @tree: tree to search / modify
> > > + * @cmp: operator defining the node order
> > > + *
> > > + * Adds a Store-Release for link_node.
> > > + *
> > > + * Returns the rb_node matching @node, or NULL when no match is found and @node
> > > + * is inserted.
> > > + */
> > > +static __always_inline struct rb_node *
> > > +rb_find_add_rcu(struct rb_node *node, struct rb_root *tree,
> > > +		int (*cmp)(struct rb_node *, const struct rb_node *))
> > > +{
> > > +	struct rb_node **link = &tree->rb_node;
> > > +	struct rb_node *parent = NULL;
> > > +	int c;
> > > +
> > > +	while (*link) {
> > 
> > 	Don't we need to use rcu_dereference_raw(*link) here?
> 
> This is a modifying operation and as such we can assume operation under
> the exclusive lock. IOW the tree should be stable here.

Ah, got it.

> 
> > > +		parent = *link;
> > > +		c = cmp(node, parent);
> > > +
> > > +		if (c < 0)
> > > +			link = &parent->rb_left;
> > > +		else if (c > 0)
> > > +			link = &parent->rb_right;
> > > +		else
> > > +			return parent;
> > > +	}
> > > +
> > > +	rb_link_node_rcu(node, parent, link);
> 
> Only the link operation needs the rcu_assign_pointer() thing for
> publishing our new node.

Yes.

> 
> > > +	rb_insert_color(node, tree);
> 
> The rotations use WRITE_ONCE() to avoid tearing.

OK, thanks for confirmation.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> > > +	return NULL;
> > > +}


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

