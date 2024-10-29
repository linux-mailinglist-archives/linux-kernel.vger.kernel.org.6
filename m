Return-Path: <linux-kernel+bounces-386085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26A79B3EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 251E4B22005
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D4C53BE;
	Tue, 29 Oct 2024 00:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDjkGK4q"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E407F1372
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730160952; cv=none; b=s7uoMdtJ/J204lFScaWhQwptaEg3CAFSsZE+ewNpPapT8PRtHNLSd/QPQC4i6k7Mp+dA4aSnsk0yioTEXkBIaUVi0By2cGkni03Ke/pxA/KpUmfvF9f1eD08xeu9l1b89y2PRSyWVXobB6Z1QzlPMe8LCLVkLjSAWH8484er25k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730160952; c=relaxed/simple;
	bh=AqENvL3kumGtTepq7I8/6st5KDw+Xn0DV113c4QDZ0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+R6pHiWvVeOWOvu3rcmjykjjWFocNj9MSQVigJIYNXSp6EuYiDGNYFw4oWgnkr6SSwF4qX5MiyaYUpMlT59ZQSdeUZd6R5zUNn8MxJuX+6t+uauZpnvLYyvUpldlQIYcjgAR5FNQJuOxwiL6WlvS8yS93C6PpM0BSoqVbxqtq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDjkGK4q; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b147a2ff04so417524885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730160949; x=1730765749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IifM/rJcuypKjPAxmZNJts0lwBocLFtwBkfJ/BNv2Ak=;
        b=dDjkGK4qUdcMsP/dNqzd7VgfWDOF0padh4h1Zrm1uj5P0wcvgXo5qpVOvT87sVNkqK
         px3SPHsSgROAmec7VpHU/tb2vYEUtaJtWRgSDTzZ/lDqO+uY89v9wyc07zXfTK1iSwf4
         TqhUIXniEcMBbPhUlQaKz+UGJ9FRrBFPZmSmgKU4O8j4RR00TKuyFQXmpOPJDnEcEmRD
         4AY73F/NSeIM6sRDWMTqmeap74mokRn2VOF4usjhLDHNTaXTaKoCYh9s8v8EaSmlaZw1
         svfc3wWj+0Cy2jqCdx/ZVKxS04aMMJMsLAR4YiAkCskaGmSHW3ijY+dNx3ms3tTubeLV
         oBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730160949; x=1730765749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IifM/rJcuypKjPAxmZNJts0lwBocLFtwBkfJ/BNv2Ak=;
        b=w31LVitISSHXflFRt5oI1lMo2augTQJGQWXvFK3GYI8lc9Cu0wi5JZ9NrCIp2dN55E
         B9gx/KfMsrBNKBbBk3Mx0D1f9ji2lYG3tN/BcId+bl6hsuDVDrSef1scd+b4+ysOY2zZ
         1ChYK8jzsdIhZxy0hftGAr+DUv38b0uc0vj9IIlQfGPCfs0DgpmCTy9cgBwFFB4AYFu4
         2norUzj/wqNhU+BZbHEC8Y6pn3OVLQzA0iZASJRrpqHxrBkbFZZy5lAQaPFz4GKiIBbj
         JmhPwYJSLjArse8SdsqbEXkwbDyh78ude7k2Xd/105C8hMlsEK7acP9SuoJB9utny2Wf
         SRew==
X-Forwarded-Encrypted: i=1; AJvYcCX+zVkY23DIBZAoDzx6/cjjp7Eqj+zoCPH694jNXWuPFu+mdVjcI/+e1sRFeFJglIc8cn9/HMaH/joqlRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE8G/JZ9lJ3UwdGCoEADEekLChKYF0LC3VuTLMY+5gJpOx4LxO
	eZCvz5ulN4bSCU/WXAt+MhgfRh5XOhm2rr1mV0acYll0Z8drJQd8
X-Google-Smtp-Source: AGHT+IEqiXxV7dH3iCz/qBte4rZa/ID9ZRH9WLi2kXmoqzC6IlKcIJ7QN9LfJt4f7LhqQyrz2JmxZQ==
X-Received: by 2002:a05:620a:28cc:b0:7ac:e869:b073 with SMTP id af79cd13be357-7b193f5d468mr1433856985a.63.1730160948754;
        Mon, 28 Oct 2024 17:15:48 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d331b0dsm369524285a.91.2024.10.28.17.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 17:15:48 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id CCF551200069;
	Mon, 28 Oct 2024 20:15:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 28 Oct 2024 20:15:47 -0400
X-ME-Sender: <xms:MykgZ7SUr9lvAvoOTOEspoj5wJieYHKjVj8BrAt6nM72yrZ3fKgDAw>
    <xme:MykgZ8wkQuVyRlB010Tp6n2pMg6wqruF6ffSqQi4kj9eqIWFgAxhmcIHqWzcIiyti
    cwYpfG0nlVeJzS04g>
X-ME-Received: <xmr:MykgZw1LqdUYiZgk6zOjR__HhrpS_Qnh3zHV0vYa8pHlqpT_w8vlxM4ipP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdektddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeitdefvefhteeklefgtefhgeelkeefffelvdev
    hfehueektdevhfettddvteevvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhnrghsrdhosggvrhhhrghushgvrheshh
    hurgifvghitghlohhuugdrtghomhdprhgtphhtthhopehprghulhhmtghksehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurd
    gvughupdhrtghpthhtohepphgrrhhrihdrrghnughrvggrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghrii
    esihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehnphhighhgihhnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepughhohifvghllhhssehrvgguhhgrthdrtghomhdprhgtph
    htthhopehjrdgrlhhglhgrvhgvsehutghlrdgrtgdruhhk
X-ME-Proxy: <xmx:MykgZ7AOYs0dPTyXor0hb_or_ZRzJ8I_JjWmOkhWU87Mk8oLWX1TTg>
    <xmx:MykgZ0gldvJLrgFHu9xBRUMENrNU2j4UF3q5rWmEPeCzgxepdxOf6g>
    <xmx:MykgZ_orE7FSum38azeFoUVC9g1nWl8A9XzsAhfI3AE_znoDWJeT6A>
    <xmx:MykgZ_jmwWeiRMvFNRB3al2Aik2Y4wAcoKxpn9l9o4eX5_5MxacWhQ>
    <xmx:MykgZ3T0Ymh-Cwem0_eYf67U6P348IG9Is-O4W49E56x_YrHcicYk6ZX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 20:15:47 -0400 (EDT)
Date: Mon, 28 Oct 2024 17:15:46 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: paulmck@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
	will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
	linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
	hernan.poncedeleon@huaweicloud.com
Subject: Re: [PATCH v4 5/5] tools/memory-model: Distinguish between syntactic
 and semantic tags
Message-ID: <ZyApMteRMxZbpBta@Boquns-Mac-mini.local>
References: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>
 <20240930105710.383284-6-jonas.oberhauser@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930105710.383284-6-jonas.oberhauser@huaweicloud.com>

On Mon, Sep 30, 2024 at 12:57:10PM +0200, Jonas Oberhauser wrote:
> Not all tags that are always there syntactically also provide semantic
> membership in the corresponding set. For example, an 'acquire tag on a

Maybe:

Not all annotated accesses provide the same semantic as their syntactic
tags...

?

> write does not imply that the write is finally in the Acquire set and
> provides acquire ordering.
> 
> To distinguish in those cases between the syntactic tags and actual
> sets, we capitalize the former, so 'ACQUIRE tags may be present on both
> reads and writes, but only reads will appear in the Acquire set.
> 
> For tags where the two concepts are the same we do not use specific
> capitalization to make this distinction.
> 
> Reported-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

I've tested this series with the following herd version:

	7.57+1, Rev: 8e7e63cd400e3eae8eac22dfdbd9dae0f243319b

all the litmus tests in the litmus-tests/ and all the litmus tests
downloaded and tested by scripts/checkghlitmus.sh (expected two tests
with smp_memb()) passed. So feel free to add:

Tested-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  tools/memory-model/linux-kernel.bell |  22 +--
>  tools/memory-model/linux-kernel.def  | 198 +++++++++++++--------------
>  2 files changed, 110 insertions(+), 110 deletions(-)
> 
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> index 8ae47545df97..fe65998002b9 100644
> --- a/tools/memory-model/linux-kernel.bell
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -13,18 +13,18 @@
>  
>  "Linux-kernel memory consistency model"
>  
> -enum Accesses = 'once (*READ_ONCE,WRITE_ONCE*) ||
> -		'release (*smp_store_release*) ||
> -		'acquire (*smp_load_acquire*) ||
> -		'noreturn (* R of non-return RMW *) ||
> -		'mb (*xchg(),cmpxchg(),...*)
> +enum Accesses = 'ONCE (*READ_ONCE,WRITE_ONCE*) ||
> +		'RELEASE (*smp_store_release*) ||
> +		'ACQUIRE (*smp_load_acquire*) ||
> +		'NORETURN (* R of non-return RMW *) ||
> +		'MB (*xchg(),cmpxchg(),...*)
>  instructions R[Accesses]
>  instructions W[Accesses]
>  instructions RMW[Accesses]
>  
>  enum Barriers = 'wmb (*smp_wmb*) ||
>  		'rmb (*smp_rmb*) ||
> -		'mb (*smp_mb*) ||
> +		'MB (*smp_mb*) ||
>  		'barrier (*barrier*) ||
>  		'rcu-lock (*rcu_read_lock*)  ||
>  		'rcu-unlock (*rcu_read_unlock*) ||
> @@ -42,10 +42,10 @@ instructions F[Barriers]
>   * semantic ordering, such as Acquire on a store or Mb on a failed RMW.
>   *)
>  let FailedRMW = RMW \ (domain(rmw) | range(rmw))
> -let Acquire = Acquire \ W \ FailedRMW
> -let Release = Release \ R \ FailedRMW
> -let Mb = Mb \ FailedRMW
> -let Noreturn = Noreturn \ W
> +let Acquire = ACQUIRE \ W \ FailedRMW
> +let Release = RELEASE \ R \ FailedRMW
> +let Mb = MB \ FailedRMW
> +let Noreturn = NORETURN \ W
>  
>  (* SRCU *)
>  enum SRCU = 'srcu-lock || 'srcu-unlock || 'sync-srcu
> @@ -85,7 +85,7 @@ flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
>  flag ~empty different-values(srcu-rscs) as srcu-bad-value-match
>  
>  (* Compute marked and plain memory accesses *)
> -let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
> +let Marked = (~M) | IW | ONCE | RELEASE | ACQUIRE | MB | RMW |
>  		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
>  let Plain = M \ Marked
>  
> diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> index d7279a357cba..49e402782e49 100644
> --- a/tools/memory-model/linux-kernel.def
> +++ b/tools/memory-model/linux-kernel.def
> @@ -6,18 +6,18 @@
>  // which appeared in ASPLOS 2018.
>  
>  // ONCE
> -READ_ONCE(X) __load{once}(X)
> -WRITE_ONCE(X,V) { __store{once}(X,V); }
> +READ_ONCE(X) __load{ONCE}(X)
> +WRITE_ONCE(X,V) { __store{ONCE}(X,V); }
>  
>  // Release Acquire and friends
> -smp_store_release(X,V) { __store{release}(*X,V); }
> -smp_load_acquire(X) __load{acquire}(*X)
> -rcu_assign_pointer(X,V) { __store{release}(X,V); }
> -rcu_dereference(X) __load{once}(X)
> -smp_store_mb(X,V) { __store{once}(X,V); __fence{mb}; }
> +smp_store_release(X,V) { __store{RELEASE}(*X,V); }
> +smp_load_acquire(X) __load{ACQUIRE}(*X)
> +rcu_assign_pointer(X,V) { __store{RELEASE}(X,V); }
> +rcu_dereference(X) __load{ONCE}(X)
> +smp_store_mb(X,V) { __store{ONCE}(X,V); __fence{MB}; }
>  
>  // Fences
> -smp_mb() { __fence{mb}; }
> +smp_mb() { __fence{MB}; }
>  smp_rmb() { __fence{rmb}; }
>  smp_wmb() { __fence{wmb}; }
>  smp_mb__before_atomic() { __fence{before-atomic}; }
> @@ -28,14 +28,14 @@ smp_mb__after_srcu_read_unlock() { __fence{after-srcu-read-unlock}; }
>  barrier() { __fence{barrier}; }
>  
>  // Exchange
> -xchg(X,V)  __xchg{mb}(X,V)
> -xchg_relaxed(X,V) __xchg{once}(X,V)
> -xchg_release(X,V) __xchg{release}(X,V)
> -xchg_acquire(X,V) __xchg{acquire}(X,V)
> -cmpxchg(X,V,W) __cmpxchg{mb}(X,V,W)
> -cmpxchg_relaxed(X,V,W) __cmpxchg{once}(X,V,W)
> -cmpxchg_acquire(X,V,W) __cmpxchg{acquire}(X,V,W)
> -cmpxchg_release(X,V,W) __cmpxchg{release}(X,V,W)
> +xchg(X,V)  __xchg{MB}(X,V)
> +xchg_relaxed(X,V) __xchg{ONCE}(X,V)
> +xchg_release(X,V) __xchg{RELEASE}(X,V)
> +xchg_acquire(X,V) __xchg{ACQUIRE}(X,V)
> +cmpxchg(X,V,W) __cmpxchg{MB}(X,V,W)
> +cmpxchg_relaxed(X,V,W) __cmpxchg{ONCE}(X,V,W)
> +cmpxchg_acquire(X,V,W) __cmpxchg{ACQUIRE}(X,V,W)
> +cmpxchg_release(X,V,W) __cmpxchg{RELEASE}(X,V,W)
>  
>  // Spinlocks
>  spin_lock(X) { __lock(X); }
> @@ -63,86 +63,86 @@ atomic_set(X,V) { WRITE_ONCE(*X,V); }
>  atomic_read_acquire(X) smp_load_acquire(X)
>  atomic_set_release(X,V) { smp_store_release(X,V); }
>  
> -atomic_add(V,X) { __atomic_op{noreturn}(X,+,V); }
> -atomic_sub(V,X) { __atomic_op{noreturn}(X,-,V); }
> -atomic_and(V,X) { __atomic_op{noreturn}(X,&,V); }
> -atomic_or(V,X)  { __atomic_op{noreturn}(X,|,V); }
> -atomic_xor(V,X) { __atomic_op{noreturn}(X,^,V); }
> -atomic_inc(X)   { __atomic_op{noreturn}(X,+,1); }
> -atomic_dec(X)   { __atomic_op{noreturn}(X,-,1); }
> -atomic_andnot(V,X) { __atomic_op{noreturn}(X,&~,V); }
> -
> -atomic_add_return(V,X) __atomic_op_return{mb}(X,+,V)
> -atomic_add_return_relaxed(V,X) __atomic_op_return{once}(X,+,V)
> -atomic_add_return_acquire(V,X) __atomic_op_return{acquire}(X,+,V)
> -atomic_add_return_release(V,X) __atomic_op_return{release}(X,+,V)
> -atomic_fetch_add(V,X) __atomic_fetch_op{mb}(X,+,V)
> -atomic_fetch_add_relaxed(V,X) __atomic_fetch_op{once}(X,+,V)
> -atomic_fetch_add_acquire(V,X) __atomic_fetch_op{acquire}(X,+,V)
> -atomic_fetch_add_release(V,X) __atomic_fetch_op{release}(X,+,V)
> -
> -atomic_fetch_and(V,X) __atomic_fetch_op{mb}(X,&,V)
> -atomic_fetch_and_relaxed(V,X) __atomic_fetch_op{once}(X,&,V)
> -atomic_fetch_and_acquire(V,X) __atomic_fetch_op{acquire}(X,&,V)
> -atomic_fetch_and_release(V,X) __atomic_fetch_op{release}(X,&,V)
> -
> -atomic_fetch_or(V,X) __atomic_fetch_op{mb}(X,|,V)
> -atomic_fetch_or_relaxed(V,X) __atomic_fetch_op{once}(X,|,V)
> -atomic_fetch_or_acquire(V,X) __atomic_fetch_op{acquire}(X,|,V)
> -atomic_fetch_or_release(V,X) __atomic_fetch_op{release}(X,|,V)
> -
> -atomic_fetch_xor(V,X) __atomic_fetch_op{mb}(X,^,V)
> -atomic_fetch_xor_relaxed(V,X) __atomic_fetch_op{once}(X,^,V)
> -atomic_fetch_xor_acquire(V,X) __atomic_fetch_op{acquire}(X,^,V)
> -atomic_fetch_xor_release(V,X) __atomic_fetch_op{release}(X,^,V)
> -
> -atomic_inc_return(X) __atomic_op_return{mb}(X,+,1)
> -atomic_inc_return_relaxed(X) __atomic_op_return{once}(X,+,1)
> -atomic_inc_return_acquire(X) __atomic_op_return{acquire}(X,+,1)
> -atomic_inc_return_release(X) __atomic_op_return{release}(X,+,1)
> -atomic_fetch_inc(X) __atomic_fetch_op{mb}(X,+,1)
> -atomic_fetch_inc_relaxed(X) __atomic_fetch_op{once}(X,+,1)
> -atomic_fetch_inc_acquire(X) __atomic_fetch_op{acquire}(X,+,1)
> -atomic_fetch_inc_release(X) __atomic_fetch_op{release}(X,+,1)
> -
> -atomic_sub_return(V,X) __atomic_op_return{mb}(X,-,V)
> -atomic_sub_return_relaxed(V,X) __atomic_op_return{once}(X,-,V)
> -atomic_sub_return_acquire(V,X) __atomic_op_return{acquire}(X,-,V)
> -atomic_sub_return_release(V,X) __atomic_op_return{release}(X,-,V)
> -atomic_fetch_sub(V,X) __atomic_fetch_op{mb}(X,-,V)
> -atomic_fetch_sub_relaxed(V,X) __atomic_fetch_op{once}(X,-,V)
> -atomic_fetch_sub_acquire(V,X) __atomic_fetch_op{acquire}(X,-,V)
> -atomic_fetch_sub_release(V,X) __atomic_fetch_op{release}(X,-,V)
> -
> -atomic_dec_return(X) __atomic_op_return{mb}(X,-,1)
> -atomic_dec_return_relaxed(X) __atomic_op_return{once}(X,-,1)
> -atomic_dec_return_acquire(X) __atomic_op_return{acquire}(X,-,1)
> -atomic_dec_return_release(X) __atomic_op_return{release}(X,-,1)
> -atomic_fetch_dec(X) __atomic_fetch_op{mb}(X,-,1)
> -atomic_fetch_dec_relaxed(X) __atomic_fetch_op{once}(X,-,1)
> -atomic_fetch_dec_acquire(X) __atomic_fetch_op{acquire}(X,-,1)
> -atomic_fetch_dec_release(X) __atomic_fetch_op{release}(X,-,1)
> -
> -atomic_xchg(X,V) __xchg{mb}(X,V)
> -atomic_xchg_relaxed(X,V) __xchg{once}(X,V)
> -atomic_xchg_release(X,V) __xchg{release}(X,V)
> -atomic_xchg_acquire(X,V) __xchg{acquire}(X,V)
> -atomic_cmpxchg(X,V,W) __cmpxchg{mb}(X,V,W)
> -atomic_cmpxchg_relaxed(X,V,W) __cmpxchg{once}(X,V,W)
> -atomic_cmpxchg_acquire(X,V,W) __cmpxchg{acquire}(X,V,W)
> -atomic_cmpxchg_release(X,V,W) __cmpxchg{release}(X,V,W)
> -
> -atomic_sub_and_test(V,X) __atomic_op_return{mb}(X,-,V) == 0
> -atomic_dec_and_test(X)  __atomic_op_return{mb}(X,-,1) == 0
> -atomic_inc_and_test(X)  __atomic_op_return{mb}(X,+,1) == 0
> -atomic_add_negative(V,X) __atomic_op_return{mb}(X,+,V) < 0
> -atomic_add_negative_relaxed(V,X) __atomic_op_return{once}(X,+,V) < 0
> -atomic_add_negative_acquire(V,X) __atomic_op_return{acquire}(X,+,V) < 0
> -atomic_add_negative_release(V,X) __atomic_op_return{release}(X,+,V) < 0
> -
> -atomic_fetch_andnot(V,X) __atomic_fetch_op{mb}(X,&~,V)
> -atomic_fetch_andnot_acquire(V,X) __atomic_fetch_op{acquire}(X,&~,V)
> -atomic_fetch_andnot_release(V,X) __atomic_fetch_op{release}(X,&~,V)
> -atomic_fetch_andnot_relaxed(V,X) __atomic_fetch_op{once}(X,&~,V)
> -
> -atomic_add_unless(X,V,W) __atomic_add_unless{mb}(X,V,W)
> +atomic_add(V,X) { __atomic_op{NORETURN}(X,+,V); }
> +atomic_sub(V,X) { __atomic_op{NORETURN}(X,-,V); }
> +atomic_and(V,X) { __atomic_op{NORETURN}(X,&,V); }
> +atomic_or(V,X)  { __atomic_op{NORETURN}(X,|,V); }
> +atomic_xor(V,X) { __atomic_op{NORETURN}(X,^,V); }
> +atomic_inc(X)   { __atomic_op{NORETURN}(X,+,1); }
> +atomic_dec(X)   { __atomic_op{NORETURN}(X,-,1); }
> +atomic_andnot(V,X) { __atomic_op{NORETURN}(X,&~,V); }
> +
> +atomic_add_return(V,X) __atomic_op_return{MB}(X,+,V)
> +atomic_add_return_relaxed(V,X) __atomic_op_return{ONCE}(X,+,V)
> +atomic_add_return_acquire(V,X) __atomic_op_return{ACQUIRE}(X,+,V)
> +atomic_add_return_release(V,X) __atomic_op_return{RELEASE}(X,+,V)
> +atomic_fetch_add(V,X) __atomic_fetch_op{MB}(X,+,V)
> +atomic_fetch_add_relaxed(V,X) __atomic_fetch_op{ONCE}(X,+,V)
> +atomic_fetch_add_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,+,V)
> +atomic_fetch_add_release(V,X) __atomic_fetch_op{RELEASE}(X,+,V)
> +
> +atomic_fetch_and(V,X) __atomic_fetch_op{MB}(X,&,V)
> +atomic_fetch_and_relaxed(V,X) __atomic_fetch_op{ONCE}(X,&,V)
> +atomic_fetch_and_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,&,V)
> +atomic_fetch_and_release(V,X) __atomic_fetch_op{RELEASE}(X,&,V)
> +
> +atomic_fetch_or(V,X) __atomic_fetch_op{MB}(X,|,V)
> +atomic_fetch_or_relaxed(V,X) __atomic_fetch_op{ONCE}(X,|,V)
> +atomic_fetch_or_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,|,V)
> +atomic_fetch_or_release(V,X) __atomic_fetch_op{RELEASE}(X,|,V)
> +
> +atomic_fetch_xor(V,X) __atomic_fetch_op{MB}(X,^,V)
> +atomic_fetch_xor_relaxed(V,X) __atomic_fetch_op{ONCE}(X,^,V)
> +atomic_fetch_xor_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,^,V)
> +atomic_fetch_xor_release(V,X) __atomic_fetch_op{RELEASE}(X,^,V)
> +
> +atomic_inc_return(X) __atomic_op_return{MB}(X,+,1)
> +atomic_inc_return_relaxed(X) __atomic_op_return{ONCE}(X,+,1)
> +atomic_inc_return_acquire(X) __atomic_op_return{ACQUIRE}(X,+,1)
> +atomic_inc_return_release(X) __atomic_op_return{RELEASE}(X,+,1)
> +atomic_fetch_inc(X) __atomic_fetch_op{MB}(X,+,1)
> +atomic_fetch_inc_relaxed(X) __atomic_fetch_op{ONCE}(X,+,1)
> +atomic_fetch_inc_acquire(X) __atomic_fetch_op{ACQUIRE}(X,+,1)
> +atomic_fetch_inc_release(X) __atomic_fetch_op{RELEASE}(X,+,1)
> +
> +atomic_sub_return(V,X) __atomic_op_return{MB}(X,-,V)
> +atomic_sub_return_relaxed(V,X) __atomic_op_return{ONCE}(X,-,V)
> +atomic_sub_return_acquire(V,X) __atomic_op_return{ACQUIRE}(X,-,V)
> +atomic_sub_return_release(V,X) __atomic_op_return{RELEASE}(X,-,V)
> +atomic_fetch_sub(V,X) __atomic_fetch_op{MB}(X,-,V)
> +atomic_fetch_sub_relaxed(V,X) __atomic_fetch_op{ONCE}(X,-,V)
> +atomic_fetch_sub_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,-,V)
> +atomic_fetch_sub_release(V,X) __atomic_fetch_op{RELEASE}(X,-,V)
> +
> +atomic_dec_return(X) __atomic_op_return{MB}(X,-,1)
> +atomic_dec_return_relaxed(X) __atomic_op_return{ONCE}(X,-,1)
> +atomic_dec_return_acquire(X) __atomic_op_return{ACQUIRE}(X,-,1)
> +atomic_dec_return_release(X) __atomic_op_return{RELEASE}(X,-,1)
> +atomic_fetch_dec(X) __atomic_fetch_op{MB}(X,-,1)
> +atomic_fetch_dec_relaxed(X) __atomic_fetch_op{ONCE}(X,-,1)
> +atomic_fetch_dec_acquire(X) __atomic_fetch_op{ACQUIRE}(X,-,1)
> +atomic_fetch_dec_release(X) __atomic_fetch_op{RELEASE}(X,-,1)
> +
> +atomic_xchg(X,V) __xchg{MB}(X,V)
> +atomic_xchg_relaxed(X,V) __xchg{ONCE}(X,V)
> +atomic_xchg_release(X,V) __xchg{RELEASE}(X,V)
> +atomic_xchg_acquire(X,V) __xchg{ACQUIRE}(X,V)
> +atomic_cmpxchg(X,V,W) __cmpxchg{MB}(X,V,W)
> +atomic_cmpxchg_relaxed(X,V,W) __cmpxchg{ONCE}(X,V,W)
> +atomic_cmpxchg_acquire(X,V,W) __cmpxchg{ACQUIRE}(X,V,W)
> +atomic_cmpxchg_release(X,V,W) __cmpxchg{RELEASE}(X,V,W)
> +
> +atomic_sub_and_test(V,X) __atomic_op_return{MB}(X,-,V) == 0
> +atomic_dec_and_test(X)  __atomic_op_return{MB}(X,-,1) == 0
> +atomic_inc_and_test(X)  __atomic_op_return{MB}(X,+,1) == 0
> +atomic_add_negative(V,X) __atomic_op_return{MB}(X,+,V) < 0
> +atomic_add_negative_relaxed(V,X) __atomic_op_return{ONCE}(X,+,V) < 0
> +atomic_add_negative_acquire(V,X) __atomic_op_return{ACQUIRE}(X,+,V) < 0
> +atomic_add_negative_release(V,X) __atomic_op_return{RELEASE}(X,+,V) < 0
> +
> +atomic_fetch_andnot(V,X) __atomic_fetch_op{MB}(X,&~,V)
> +atomic_fetch_andnot_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,&~,V)
> +atomic_fetch_andnot_release(V,X) __atomic_fetch_op{RELEASE}(X,&~,V)
> +atomic_fetch_andnot_relaxed(V,X) __atomic_fetch_op{ONCE}(X,&~,V)
> +
> +atomic_add_unless(X,V,W) __atomic_add_unless{MB}(X,V,W)
> -- 
> 2.34.1
> 
> 

