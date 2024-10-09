Return-Path: <linux-kernel+bounces-357777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B03BB9975E0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110FA1F237B9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE0C1E1A30;
	Wed,  9 Oct 2024 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QKhKPlfA"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21CE1D356C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728503062; cv=none; b=IehR++8sFo6Hc1uwonWnRmzGLXtCRZm7ToW+ukDaoLXVz13M5LWXMpivsCc2T9N548amLVliF8qIMFD2mtJ+osJTp8ypuyAY8zSJfKqLIZLkzh1joi4xu2rGNWbf+zjT4jMGcu/CmEbX1KFvmJ3ojxDrC3gxmhT8uj3mpjYdh1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728503062; c=relaxed/simple;
	bh=mATPx8c2voUWusUIBApRv+J1dsXwkVLU5ho/N9rL6TM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mU6g3YY6wmvc5k24fplq5KkSFE3hD6FbVbPPJmb4x06dcJzTUw5l9vHZgaAoooXJ4E+JlUXx+Y98nj3begmppEsrrl1r2p8jk6gcnFD+V2bhwxyvfdQmQ4ARlKMDkoNgqg7MKErV1069sf5DXOvn4qnE8kw7GwfgnT5w+MbxRUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QKhKPlfA; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TZ6rT2WT9yvw56zkrk//d+3wxBzpnHGZZMRlTHFdpy4=; b=QKhKPlfA/9jfWgKYFgNaV0KvAD
	ah+NJy9R8HgYQIO14WSd9KP2oZzx+p0se8JhqHgHGMkhBpgvmaf5Gmp7adauL5SWlBpOFgnhLY7yt
	F3rNgllUPSfqSLKKlMSLs1p5+AtifbofKhNwv23+J38qA35F3FvqstTFmsmeGZurr8u4Gu6c1nlo+
	bC4AuBQ8YIZ+urk937O6L1/tnpYCVgXGnhxZ/TeAJlmtTylnqsO6RAnBiHw3J4mxSv1bABXmhzCwY
	XZkcFHByfrLvqdDWRnCq40jnXfbUaLDJ0FDOSzMqQN+MUlZCAuwuhslNwantdEMWZ1CpPu0r7zGyM
	l8TQCsMA==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sycbL-0074UU-Aq; Wed, 09 Oct 2024 21:44:03 +0200
Message-ID: <bb91d63d-c61a-4063-bf14-4cbbb62bec12@igalia.com>
Date: Wed, 9 Oct 2024 16:43:58 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] futex: Rewrite get_inode_sequence_number() to make
 code simpler
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>
References: <20241004085257.10908-1-ubizjak@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20241004085257.10908-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Uros,

Em 04/10/2024 05:52, Uros Bizjak escreveu:
> Rewrite get_inode_sequence_number() to make code simpler:
> 
> a) Rewrite FOR loop to a DO-WHILE loop with returns moved
> out of the loop.
> 
> b) Use atomic64_inc_return() instead of atomic64_add_return().
> 
> c) Use !atomic64_try_cmpxchg_relaxed(*ptr, &old, new) instead of
> atomic64_cmpxchg_relaxed (*ptr, old, new) != old.  x86 CMPXCHG
> instruction returns success in ZF flag, so this change also saves
> a compare instruction after CMPXCHG.

Remember, it's easy to see in the diff that you replace the function, 
but might be not so clear why you did so. I think it would be better to 
understand if you write like:

We are trying to set a value for the i_sequence, that we expect that is 
zero, but if we fail to do so, we are happy to use the current non-zero 
i_sequence value that we found. Instead of using 
atomic64_cmpxchg_relaxed(), use atomic64_try_cmpxchg_relaxed() which 
provides a better semantic for this situation.

> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: "André Almeida" <andrealmeid@igalia.com>
> ---
> v2: Explicitly initialize "old" to zero before the call to
> atomic64_try_cmpxchg_relaxed(). Rewrite commit message to
> state the motivation for the patch.
> ---
>   kernel/futex/core.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> index 136768ae2637..ac650f7ed56c 100644
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -173,23 +173,21 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
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
> +	old = 0;

Please initialize it in the variable declaration.

> +	if (!atomic64_try_cmpxchg_relaxed(&inode->i_sequence, &old, new))
> +		return old;
> +	return new;
>   }
>   
>   /**

