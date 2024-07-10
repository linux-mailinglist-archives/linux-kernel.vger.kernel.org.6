Return-Path: <linux-kernel+bounces-246847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC2F92C7F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A660B1F24593
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86135522E;
	Wed, 10 Jul 2024 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1x5Fjws"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6123A0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720575004; cv=none; b=k2+EksN+Wnr9slFILsPtvQ0BtcZcXxFJEN7E4JqQ/piIHGsBIGBQaXhG2a6l9jsxMPFYXn6C2ayRC6hWLXzJ4XTSlM50vR8TPZ1mqXOMNZU1/TIgNegCCmSZG6gH6aFXe7Lar8NoltROoHPRC26GLnPL/S3MOpHEjc6Kl8OBeTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720575004; c=relaxed/simple;
	bh=qnZ6x2LJ0zG0gEwnosBWs9LZAhm82lpzt6+fg+/mnos=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=avT38ioZCfZz7tV/gUqM0MNRvpNGK49zsWbJ2FQXzwwE1vn0z4NIWSrYQb8/pH22t77GBZa8pBV/uHAvGvoQudka8QikShNXRimEPe5VWFUjlIA6erl/EHAcvJKGD9W2cgotPQDR+Qrgt5HpYUw3lOPbutCti7Ulm7w1BDBloDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1x5Fjws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64402C32786;
	Wed, 10 Jul 2024 01:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720575004;
	bh=qnZ6x2LJ0zG0gEwnosBWs9LZAhm82lpzt6+fg+/mnos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n1x5FjwsUm3KHxwtPjMkonWdnYzH09rfkQ/h2bq+7f4PsHcXsf2RrUMJjOL54qlEE
	 jbrOIsGhKvDCpYVrGeCqskq7I+if1k41RfXhwUXiT1DzkiJHRPfF/KTK6Ux0seebQG
	 O39wuwxoy+ECRLH3Q/eGV01s50+XdLi5qiSZH7qgeAkgZnE4NnGiQNjj+nI0HbEYbY
	 yev+JTYKnfHsMR0xGN6kcl7TcnUyUk41NWwIWTLEXA1xepyL5mLLH53c/NhmjpFTDF
	 oR9e8vNY1JlOlpghDx7/7Mw4505eQTqmjCzRDcOgCd0C8zmKTv+XgCdiN2HaYKJL0m
	 rDGf8GlTuy/lQ==
Date: Wed, 10 Jul 2024 10:29:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com,
 jolsa@kernel.org, clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 03/10] rbtree: Provide rb_find_rcu() / rb_find_add_rcu()
Message-Id: <20240710102959.291a71349ec71ef48919a9fe@kernel.org>
In-Reply-To: <20240708092415.464066230@infradead.org>
References: <20240708091241.544262971@infradead.org>
	<20240708092415.464066230@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 08 Jul 2024 11:12:44 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Much like latch_tree, add two RCU methods for the regular RB-tree,
> which can be used in conjunction with a seqcount to provide lockless
> lookups.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/rbtree.h |   67 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> --- a/include/linux/rbtree.h
> +++ b/include/linux/rbtree.h
> @@ -245,6 +245,42 @@ rb_find_add(struct rb_node *node, struct
>  }
>  
>  /**
> + * rb_find_add_rcu() - find equivalent @node in @tree, or add @node
> + * @node: node to look-for / insert
> + * @tree: tree to search / modify
> + * @cmp: operator defining the node order
> + *
> + * Adds a Store-Release for link_node.
> + *
> + * Returns the rb_node matching @node, or NULL when no match is found and @node
> + * is inserted.
> + */
> +static __always_inline struct rb_node *
> +rb_find_add_rcu(struct rb_node *node, struct rb_root *tree,
> +		int (*cmp)(struct rb_node *, const struct rb_node *))
> +{
> +	struct rb_node **link = &tree->rb_node;
> +	struct rb_node *parent = NULL;
> +	int c;
> +
> +	while (*link) {

	Don't we need to use rcu_dereference_raw(*link) here?

> +		parent = *link;
> +		c = cmp(node, parent);
> +
> +		if (c < 0)
> +			link = &parent->rb_left;
> +		else if (c > 0)
> +			link = &parent->rb_right;
> +		else
> +			return parent;
> +	}
> +
> +	rb_link_node_rcu(node, parent, link);
> +	rb_insert_color(node, tree);
> +	return NULL;
> +}
> +
> +/**
>   * rb_find() - find @key in tree @tree
>   * @key: key to match
>   * @tree: tree to search
> @@ -268,6 +304,37 @@ rb_find(const void *key, const struct rb
>  		else
>  			return node;
>  	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * rb_find_rcu() - find @key in tree @tree
> + * @key: key to match
> + * @tree: tree to search
> + * @cmp: operator defining the node order
> + *
> + * Notably, tree descent vs concurrent tree rotations is unsound and can result
> + * in false-negatives.
> + *
> + * Returns the rb_node matching @key or NULL.
> + */
> +static __always_inline struct rb_node *
> +rb_find_rcu(const void *key, const struct rb_root *tree,
> +	    int (*cmp)(const void *key, const struct rb_node *))
> +{
> +	struct rb_node *node = tree->rb_node;
> +
> +	while (node) {
> +		int c = cmp(key, node);
> +
> +		if (c < 0)
> +			node = rcu_dereference_raw(node->rb_left);
> +		else if (c > 0)
> +			node = rcu_dereference_raw(node->rb_right);
> +		else
> +			return node;
> +	}
>  
>  	return NULL;
>  }
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

