Return-Path: <linux-kernel+bounces-402043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 661B19C229B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFC52870A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33B0198A0D;
	Fri,  8 Nov 2024 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hihv8IEi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E35313B29F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731085346; cv=none; b=j9cBB4j+gWLgOHwxDQEKz1Yce067u4/2k6FscV43Bir8fvzmfKoeTfnLKf784sLwUNyxivBtrKiC1/PxIB7kzGZzPfmrqUMKDC3E/PZ5zqbUu33dtnxOWJ4QrEahH3tPzkNqj8t46Jo8bGdsGUNlPGWOv586kE6jEfnRJWq7vX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731085346; c=relaxed/simple;
	bh=8DOvBAtlvbC7VPCRTflUwOEpS+pJUGXpatZhb9wB9xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIX7vYjVKccUfUNJd9ERWFSorCOIgd8LlaP5Rc8NRrfxsp/BhMCtPNbz3krz7/3HRN/m9uy/MuykO4PrHCF0H68S0WAW5fvqAhKD0kDQjLSlyIYQ9bR37Morwhv6sCiaCkyxZtN0oSEYudJDNVRs0G/yu49ugsdX+D46u/50570=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hihv8IEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C528AC4CECD;
	Fri,  8 Nov 2024 17:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731085345;
	bh=8DOvBAtlvbC7VPCRTflUwOEpS+pJUGXpatZhb9wB9xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hihv8IEi/ku72lqvHSYmwmjxSpn6wtHoEIN1kDRpV4ggWIjxpbXol6tlWdb9P9Thq
	 IEa1e2qfJuZ9EHa9vMn5ppPLkuIGS1V06j72YwXgFqzVIJXdbq7jUh2FjBuTfEK6U9
	 WMgHJcXl/aHrnlT2rPhfEdBPvYzPryIPDC04+QcfwW6n2gBylCpE0WdpROlWg0esSR
	 l2fTruhXfUyQIdcQ9nfjhBTC6MKwXOObpss3KDrsrdNVPhEvT1tEwek+9nF6UhlnHh
	 ZfXaqHR5L21tlHEmbBMrSQnmsn38sRwCcWsmo4lZGNF90xeSmu/ztoMV8/JTXJ+BaS
	 q+KZXU6iw4MBQ==
Date: Fri, 8 Nov 2024 07:02:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de,
	syzbot <syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com>
Subject: Re: [BUG] -next lockdep invalid wait context
Message-ID: <Zy5EIHUwoXjK1sAJ@slm.duckdns.org>
References: <41619255-cdc2-4573-a360-7794fc3614f7@paulmck-laptop>
 <e06d69c9-f067-45c6-b604-fd340c3bd612@suse.cz>
 <ZyK0YPgtWExT4deh@elver.google.com>
 <66a745bb-d381-471c-aeee-3800a504f87d@paulmck-laptop>
 <20241102001224.2789-1-hdanton@sina.com>
 <ZyV2DfuIPsISds-1@Boquns-Mac-mini.local>
 <ZykNhbMOrlgCXFYJ@slm.duckdns.org>
 <20241108100503.H-__545n@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108100503.H-__545n@linutronix.de>

Hello,

On Fri, Nov 08, 2024 at 11:05:03AM +0100, Sebastian Andrzej Siewior wrote:
...
>  static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
>  {
> +	struct kernfs_node *kn_parent;
> +	const char *kn_name;
> +
>  	if (!kn)
>  		return strscpy(buf, "(null)", buflen);
>  
> -	return strscpy(buf, kn->parent ? kn->name : "/", buflen);
> +	kn_parent = rcu_dereference(kn->parent);

kn->parent can never change. This can just be a regular deref.

> +	kn_name = rcu_dereference(kn->name);
> +	return strscpy(buf, kn_parent ? kn_name : "/", buflen);
>  }
>  
>  /* kernfs_node_depth - compute depth from @from to @to */
> @@ -66,7 +70,7 @@ static size_t kernfs_depth(struct kernfs_node *from, struct kernfs_node *to)
>  
>  	while (to->parent && to != from) {
>  		depth++;
> -		to = to->parent;
> +		to = rcu_dereference(to->parent);

Ditto here and other places.

>  int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
>  {
> -	unsigned long flags;
>  	int ret;
>  
> -	read_lock_irqsave(&kernfs_rename_lock, flags);
> +	rcu_read_lock();
>  	ret = kernfs_name_locked(kn, buf, buflen);
> -	read_unlock_irqrestore(&kernfs_rename_lock, flags);
> +	rcu_read_unlock();
>  	return ret;
>  }
>  
> @@ -223,12 +226,11 @@ int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
>  int kernfs_path_from_node(struct kernfs_node *to, struct kernfs_node *from,
>  			  char *buf, size_t buflen)
>  {
> -	unsigned long flags;
>  	int ret;
>  
> -	read_lock_irqsave(&kernfs_rename_lock, flags);
> +	rcu_read_lock();
>  	ret = kernfs_path_from_node_locked(to, from, buf, buflen);
> -	read_unlock_irqrestore(&kernfs_rename_lock, flags);
> +	rcu_read_unlock();
>  	return ret;
>  }

The _locked suffix looks awkward afterwards. Given that there's no
restriction on how the function is called anymore, maybe we can just
collapse _locked bodies into the callers?

...
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index 87c79d076d6d7..733d89de40542 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -199,8 +199,8 @@ struct kernfs_node {
>  	 * never moved to a different parent, it is safe to access the
>  	 * parent directly.
>  	 */
> -	struct kernfs_node	*parent;
> -	const char		*name;
> +	struct kernfs_node	__rcu *parent;
> +	const char		__rcu *name;

->parent doesn't have to be converted to RCU. As long as the node is
accessible, the parent is guaranteed to be pinned and unchanged. We only
need to RCUfy ->name.

Thanks.

-- 
tejun

