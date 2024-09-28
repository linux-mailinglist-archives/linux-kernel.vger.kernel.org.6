Return-Path: <linux-kernel+bounces-342510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E63988FC9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 16:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0C40B21C70
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D89542077;
	Sat, 28 Sep 2024 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="WC2NqOgW"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A8D4204D
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727535520; cv=none; b=I1SCOlGeAq+nPk2R3aDxXJLjEWwTu/4gn4IpU4gAHFNWYWmyc12uNHlnK5dvzVZLX6pYactLkpTRk7XNTLXU+n7wFeVfBEXoIsw0JwGRxHLgEHbt5NNkNfvp7V8Jxk64blEamVMVsRfaLkhCvhQRqHJlyNFS7sJGSp7YcE/0wjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727535520; c=relaxed/simple;
	bh=fBariXxH/IJvFrRMHnRoVnSQf1cAOY+KADOoz7OAVl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKJOarYwRR88dmYSdCvq7PtsT0JqMC7amCrejsuGk1NLf5XUJRVtQ/VAGTq8WT9Rf5MjNe1JN/fgpAlY77etVHQ5WphMeL546oTTF2fZLiUX8sigdiFC9WsqbLzZ+t3uYAa48kBzo1XbhYOiVa9LXC/61tTePJQX6GcrOEyKXxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=WC2NqOgW; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb3bbb9cf5so18008736d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1727535517; x=1728140317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8NBJZabNRladn0UAprs9dmBImHXM7hhkyIEt9cWdn/M=;
        b=WC2NqOgWMTZrQY9At4Isdp7RNjgaHqXhTKLtUWQaRIowTsIDSh8+5Y0O15MYktsZnf
         vqpHHTWz03pbhlNC0Znqbnn+ukE/Gi/nSEV6MFMVeRR6ItFQA0uOzVr86HccWkFW3Me5
         ocJwRv/54c3KqYl8z/ulF4w1S7GimPjg9174QBxfmpUceuHxjkdBnTboW2xD1MjpDVhr
         31/VLBCN5DbY8kdrCAn+JKpgPAfzOg2+NXRohCc0uJr46OPpuHKNsaJCwB6EPamWuOH2
         cc1Z+Ub6ZIe19/JvuI0K9R+mTUDqvbMjAYPxNgNVZi575DuRCBgAKgQo9s9cioOBvxtm
         pnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727535517; x=1728140317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NBJZabNRladn0UAprs9dmBImHXM7hhkyIEt9cWdn/M=;
        b=Y/JCeCn5jSKQe7iWfS8MVh58e7fOd6Eg4YfiVHGbHCou5KRegOgbWWy2tIG6K8lEp+
         4ohCE/Cvq+ZV381cDQU6Tuj17/xbHQ+rTKVhUYxnHdX4bdWjh/V0SQ8A1wiV2Ehuo2YR
         KDOvrdEdoi+sT763xD5ZIbahQhRmwTBt1mm59XJtafqO93DlHfX7H13CTHSGqPWi7paa
         4T7L1k0vJ8axhqbEEARNvlyAkNOl1hnocEU/iPjLloWZbdzZ47UymChwY1osf6kToSgS
         LprVJYr0gk1uNfJh3Lz+jRuM2SJaOvUnseOsaQIpq7+LbATB2LNcyoaZceHM9m0wNj+J
         Xo/A==
X-Forwarded-Encrypted: i=1; AJvYcCVc1+xYwLZNm/NimmibNV/pBCBYB8dbA9W4ZBQ4fshDTI0BHA8HRhQy3I+VY22eTeGJehCWAppmiebhRo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ24R+EHBDrwhJHP9+31fYF4GQmTOMsKA9kXHWNDQS3DysGYIP
	flz3hM51pX8O5a68Xs5dizuwepPwuCldnGZK/1vHmFgVcqU1tRpo/5fY0eY/dA==
X-Google-Smtp-Source: AGHT+IEJdjl2xfng+t/Ph1sulESx3KVZ0I2AaoyM25c78u+TcoT6qG2QCQkQtoJM3yNdJXOTCcKYAQ==
X-Received: by 2002:a05:6214:5a08:b0:6cb:1006:e9de with SMTP id 6a1803df08f44-6cb3b63f25bmr105456166d6.41.1727535517316;
        Sat, 28 Sep 2024 07:58:37 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::abbf])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b612e93sm20266456d6.32.2024.09.28.07.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 07:58:36 -0700 (PDT)
Date: Sat, 28 Sep 2024 10:58:32 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>, Gary Guo <gary@garyguo.net>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [PATCH 2/2] Documentation: RCU: Refer to ptr_eq()
Message-ID: <7b50a773-9d5b-4ff4-8de2-b491f3b91f52@rowland.harvard.edu>
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-3-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928135128.991110-3-mathieu.desnoyers@efficios.com>

On Sat, Sep 28, 2024 at 09:51:28AM -0400, Mathieu Desnoyers wrote:
> Refer to ptr_eq() in the rcu_dereference() documentation.
> 
> ptr_eq() is a mechanism that preserves address dependencies when
> comparing pointers, and should be favored when comparing a pointer
> obtained from rcu_dereference() against another pointer.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: John Stultz <jstultz@google.com>
> Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: maged.michael@gmail.com
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> Cc: rcu@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: lkmm@lists.linux.dev
> ---
>  Documentation/RCU/rcu_dereference.rst | 34 +++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
> index 2524dcdadde2..c36b8d1721f6 100644
> --- a/Documentation/RCU/rcu_dereference.rst
> +++ b/Documentation/RCU/rcu_dereference.rst
> @@ -104,11 +104,13 @@ readers working properly:
>  	after such branches, but can speculate loads, which can again
>  	result in misordering bugs.
>  
> --	Be very careful about comparing pointers obtained from
> -	rcu_dereference() against non-NULL values.  As Linus Torvalds
> -	explained, if the two pointers are equal, the compiler could
> -	substitute the pointer you are comparing against for the pointer
> -	obtained from rcu_dereference().  For example::
> +-	Use relational operators which preserve address dependencies
> +	(such as "ptr_eq()") to compare pointers obtained from

Nit: ptr_eq() is an inline function, not a relational operator.  Say 
"operations that" instead of "relational operators which".

> +	rcu_dereference() against non-NULL values or against pointers
> +	obtained from prior loads. As Linus Torvalds explained, if the
> +	two pointers are equal, the compiler could substitute the
> +	pointer you are comparing against for the pointer obtained from
> +	rcu_dereference().  For example::
>  
>  		p = rcu_dereference(gp);
>  		if (p == &default_struct)
> @@ -125,6 +127,23 @@ readers working properly:
>  	On ARM and Power hardware, the load from "default_struct.a"
>  	can now be speculated, such that it might happen before the
>  	rcu_dereference().  This could result in bugs due to misordering.
> +	Performing the comparison with "ptr_eq()" ensures the compiler
> +	does not perform such transformation.
> +
> +	If the comparison is against a pointer obtained from prior
> +	loads, the compiler is allowed to use either register for the

This is true even when the comparison is against a pointer obtained from 
a later load.  Just say "another pointer" instead of "a pointer obtained 
from prior loads".  (And why would someone need multiple loads to 
obtain a single pointer?)

Also, say "pointer" instead of "register".

> +	following accesses, which loses the address dependency and
> +	allows weakly-ordered architectures such as ARM and PowerPC
> +	to speculate the address-dependent load before rcu_dereference().
> +	For example::
> +
> +		p1 = READ_ONCE(gp);
> +		p2 = rcu_dereference(gp);
> +		if (p1 == p2)
> +			do_default(p2->a);

Here you should say that the compiler could use p1->a rather than p2->a, 
destroying the address dependency.  That's the whole point of this; you 
shouldn't skip over it.

> +
> +	Performing the comparison with "ptr_eq()" ensures the compiler
> +	preserves the address dependencies.
>  
>  	However, comparisons are OK in the following cases:
>  
> @@ -204,6 +223,11 @@ readers working properly:
>  		comparison will provide exactly the information that the
>  		compiler needs to deduce the value of the pointer.
>  
> +	When in doubt, use relational operators that preserve address

Again, "operations" instead of "relational operators".

Alan Stern

> +	dependencies (such as "ptr_eq()") to compare pointers obtained
> +	from rcu_dereference() against non-NULL values or against
> +	pointers obtained from prior loads.
> +
>  -	Disable any value-speculation optimizations that your compiler
>  	might provide, especially if you are making use of feedback-based
>  	optimizations that take data collected from prior runs.  Such
> -- 
> 2.39.2
> 

