Return-Path: <linux-kernel+bounces-349069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5224998F05C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D242829CC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA47019B595;
	Thu,  3 Oct 2024 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SKuzfhG/"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377551714A1
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962159; cv=none; b=e/1jkfByXHdD/GPPs1N+h7cwaNyTxyNBh/X3ScgNG9Jx5Jkkl1ZgQSSHySpxXTp/l9nJRfo2Md6Wyt7J7IjI/PV0JH0m2sLdP3TCekdKLXoe4jdpHYOd+WS/YWqKPkVYw3nwn21y/vI8SY4f0wwSVEAdWZOrtq3qMVrGW3cDg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962159; c=relaxed/simple;
	bh=XHv60hIxaEdRl9RPDdtdEX9rkTSOZ/QanBecpZ3v2vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQjfpp826EHgkcqaGwzTknxgKz94nnJzZ3cmwpMxQ6xnJ3rBKVTfOpDW12EW2bYiUFrAH5pSK+W1R8mRu+5MQoIte3XGL2iYf5pDqEMXAb2VYcVm5cze8U+OKGCS6c55N859CmqsapxnkgqvcghWUS2rblNA4CJa67Wx2iyAFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SKuzfhG/; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mh3WLNw0L2RiLwQ/swS2WLxVc1Om+tQgri4bYobmPkw=; b=SKuzfhG/LtWtLXSoanUFuxxru6
	nrTNZP+F0d83O5RmXhTwlhleJgQpNWK4KsYVwPLZ8oy5FQjOZw8lOnJkzO2BBqD/yhNZxBG+b2f/j
	iFOhAc47DdRMM7IFawnY4UcylMiyC7KkucIMgffocgOV1G2pgFUuZaJp2uE5LBIwoP6RCw7M5B18r
	odN5UT3MSy8mpTxQKIg7cTq6l75N9fCzS0hIzYc8Sym8hyykkIr+OAAB8kFBFSggspZr4Kq+r4VzX
	HI2Dg46cOFlqJ+mypXVkhVY4Ak81bKJlpxgNjxcKgz9Dnrj02QxNRfWUrA5d2672cMhgzzH4JQsYs
	ohFWtvPA==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1swLtA-004MHt-7g; Thu, 03 Oct 2024 15:29:04 +0200
Message-ID: <390874e9-eddd-494d-9bc0-62b34a9bb29b@igalia.com>
Date: Thu, 3 Oct 2024 10:28:57 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] futex: Improve get_inode_sequence_number()
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>
References: <20241003121921.922394-1-ubizjak@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20241003121921.922394-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Uros,

Em 03/10/2024 09:18, Uros Bizjak escreveu:
> Rewrite FOR loop to a DO-WHILE loop where returns are moved out of
> the loop. Use atomic64_inc_return() instead of atomic64_add_return().
> 
> Use !atomic64_try_cmpxchg_relaxed(*ptr, &old, new) instead of
> atomic64_cmpxchg_relaxed (*ptr, old, new) != old.  x86 CMPXCHG
> instruction returns success in ZF flag, so this change saves
> a compare after CMPXCHG..
> 
> Note that due to early return, "old" equals to 0 before
> atomic64_cmpxchg_relaxed(), so initialization of variable to 0
> is not needed.
> 

Despite the implicitly `old = 0`, I think it makes people life easier to 
know explicitly that `old = 0` in the cmpxchg() call.

Also, please state in the commit message the motivation of doing this 
change. Is to make the code simpler or to try to save some instructions? 
The compiler might be already saving such instructions for us :)

> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: "André Almeida" <andrealmeid@igalia.com>
> ---
>   kernel/futex/core.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> index 136768ae2637..665501c885d0 100644
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -173,23 +173,20 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
>   static u64 get_inode_sequence_number(struct inode *inode)
>   {
>   	static atomic64_t i_seq;
> -	u64 old;
> +	u64 old, new;
>   
>   	/* Does the inode already have a sequence number? */
>   	old = atomic64_read(&inode->i_sequence);
>   	if (likely(old))
>   		return old;
>   
> -	for (;;) {
> -		u64 new = atomic64_add_return(1, &i_seq);
> -		if (WARN_ON_ONCE(!new))
> -			continue;
> +	do {
> +		new = atomic64_inc_return(&i_seq);
> +	} while	(WARN_ON_ONCE(!new));
>   
> -		old = atomic64_cmpxchg_relaxed(&inode->i_sequence, 0, new);
> -		if (old)
> -			return old;
> -		return new;
> -	}
> +	if (!atomic64_try_cmpxchg_relaxed(&inode->i_sequence, &old, new))
> +		return old;
> +	return new;
>   }
>   
>   /**

