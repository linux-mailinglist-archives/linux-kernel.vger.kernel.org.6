Return-Path: <linux-kernel+bounces-334881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C6197DDD3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 18:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D66C281ED8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 16:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C761175D37;
	Sat, 21 Sep 2024 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HKX039vo"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C125A26AC1
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726936375; cv=none; b=PgsdsVmjh1Xu9VAqTbsyzKrNWUunXIZk8dxpL2B8BnjELjyWt26extS3nrlfTAG2vqEIHrDiTbeCTPbIVAbEuzU/UB96AZmxlM/kFfrIHIWfel75M3P3CX8L//UpeUKBVSPAXcmJe/dR1f8wMaY+JK50dqZBsfA6Khgo20X2AOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726936375; c=relaxed/simple;
	bh=fSvu0UEtuoFRRtCGFLDXQ+xB3hriWZ18FEEO9Z7nqDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbbzYXU9vtBp+5ZzA4EDAzvNT8ppd8tNn2xWlG31J9cOjCAzvqJw7ckrccJc75kMR8eLRwvzdINJB3o/BxXGd8xvLcdy0VyU9P0fa+BZDb0io2Bp1zAFr6QYTjnzRx9JylLYuRWrRc9Avdzj436CVzyqx5HLvIQGwHofe2/gOhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HKX039vo; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 21 Sep 2024 12:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726936371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sKPzHX9/1f4+rsnMr7JcyGiXrW+F6CTuBP3VcnzBJJ4=;
	b=HKX039voxfQjgGHlYxWdImUPJBCj/CzqHtPa4ucVb/xbqNme7NNquX1fQW9pFUMcB7BVXU
	Wh35D7G8cbYahJh7UI0uOeFJWopzZn6YtacPHPNoufTGxVubPJPBWFGewB7+1LfJa1w/Kt
	bZ07LHvUQ4Vq/spj4sDwINF5IC4yvGw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Ahmed Ehab <bottaawesome633@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	syzkaller@googlegroups.com, syzbot+f7c41a878676b72c16a6@syzkaller.appspotmail.com
Subject: Re: [PATCH] bcachefs: Relocate rcu_read_lock()/rcu_read_unlock() to
 snapshot_t()
Message-ID: <umyvbe5rg5ulikkt6gozv3tklilnpnege5t5n6lo76l7if2l3d@fmdueymcdc5f>
References: <20240919073603.1827-1-bottaawesome633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919073603.1827-1-bottaawesome633@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 19, 2024 at 10:36:03AM GMT, Ahmed Ehab wrote:
> Syzbot reports a problem that a warning is triggered due to suspicious
> use of rcu_dereference_check(). That is triggered by a call of
> bch2_snapshot_tree_oldest_subvol().
> 
> The cause of the warning is that the rcu_read_lock() is called in wrapper
> methods instead of calling it directly before calling rcu_dereference()
> in snapshot_t().For example in this case, snapshot_t() is called
> directly from bch2_snapshot_tree_oldest_subvol() without holding the
> read lock. This also results in duplicating the rcu_read_lock()
> and rcu_read_unlock() calls, which may lead to future errors in the case
> of forgetting to hold the read locks as in this case.
> 
> To fix this, move rcu_read_lock() and rcu_read_unlock() to snapshot_t().
> This will make sure that rcu_dereference_check() is never called without
> holding the read lock.
> 
> Reported-by: <syzbot+f7c41a878676b72c16a6@syzkaller.appspotmail.com>
> Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
> ---
>  fs/bcachefs/snapshot.h | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/bcachefs/snapshot.h b/fs/bcachefs/snapshot.h
> index eb5ef64221d6..04f18fac56fe 100644
> --- a/fs/bcachefs/snapshot.h
> +++ b/fs/bcachefs/snapshot.h
> @@ -42,15 +42,19 @@ static inline struct snapshot_t *__snapshot_t(struct snapshot_table *t, u32 id)
>  
>  static inline const struct snapshot_t *snapshot_t(struct bch_fs *c, u32 id)
>  {
> -	return __snapshot_t(rcu_dereference(c->snapshots), id);
> +	struct snapshot_table *temp;
> +
> +	rcu_read_lock();
> +	temp = rcu_dereference(c->snapshots);
> +	rcu_read_unlock();
> +
> +	return __snapshot_t(temp, id);

This is very wrong - as in, you need to study up on how RCU works.

We need to be holding rcu_read_lock() while we're accessing the object
we got to from the rcu pointer, so rcu_read_lock() always needs to be
taken by the caller.

