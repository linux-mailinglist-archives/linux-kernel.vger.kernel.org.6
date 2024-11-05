Return-Path: <linux-kernel+bounces-397011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90F99BD590
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CE628405E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE361E9096;
	Tue,  5 Nov 2024 19:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBW8LdBm"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706681714B3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730833354; cv=none; b=qLg8j87KWqJJzm0/hB/o4SDFNwI3MW5RvskPlyVFOWL4+QZYu0xmJKr1RwQ/AKnKWW0cU/dLoRxTyCLL5QkojaBwiNNGW6PUtMPWOu35aTARF6F44oOXR+XwtdHkcwHLaIn0x4SieSrRYl7TxUIwqooVhXwxSkcj1uC0rPUwRNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730833354; c=relaxed/simple;
	bh=SwjIMrSQMRe3/1+yU13Fx5MlIC1uD52tLk6c3rCJCYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXRdk065ghsDUN36lwVxlG0jbUdL7/SfxIFDzkx6uDkMhWpy5E04izLtj1AISXHW0eaqzsH+AiIxXmjO8orjdUFeqMIu2Vib7BQtZYeefLaRiWCsriqKAi+DA2H6nIFKHyaov8qmIK3vOqlZhZYFCzj33LEFGpIiAIjXYxjboLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBW8LdBm; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d382677c92so5421226d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 11:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730833351; x=1731438151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rC78TUelPE8DH2S6OtkdnEBzOa1Cl9rd67Zo3gx1WM=;
        b=WBW8LdBmHjjOJXlTsb9k+wOWt/Cku/s2+TVO+Zi8AfMHeWdSFYWLCQpCQE59q2IoLH
         hj8sKmqVEgdqZEnDvSd6NiJK7siMaIHLoiJwWHQoUeDwz46PtV5XHak1fbtkNq+92HNK
         x3pWPeo3RumIe7CiJUBwGe1KQ6EslTlQudZSPhGRviEBmiDAudyniSdVcejiLWhpkTzG
         cGXgPaNYBQowTJE2LX0TBeMpALe1vDyV0g9qgd1jJxiw0PxoiOmIAvqJGDeoT8ad1/vq
         eCwfnXbd7YJEDf27mhy0QboQJgJkGC8dYfdM1FM79kFDaLVwX1r+CanYaYVaCDQtfxM3
         uznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730833351; x=1731438151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rC78TUelPE8DH2S6OtkdnEBzOa1Cl9rd67Zo3gx1WM=;
        b=QMTfLDMju/AHYUlEH+VnPuFxBKGm6o8QOuTAKIHn8+wWNbeW7rL52ewX++MBw+ITyH
         xwcg2+161TiKKDVHvUEftuwohA2HTk1Oeg9rVAVHAyPwZDRBvShe+URepqdfuEIpmpGw
         wq2vTDMhBVGd4r/HGsXxx0JXv2iAYl3ZZyuckSmvCW8CLJAd7ecyM2AqMqNhNmZZmfeR
         FT4rJ8fa+RkFaVMevZkPZ0ogxRfDbeXpmEIuZ/IBfayccUv/G0sIeXh8o7wVTtmpFjU2
         3WBQ7PL+jixmnttRTBqbDFquY4U+DOUwbD0RIv3ZJRfKuAeGpeM9PptYWJltUxJVUB+T
         2TZw==
X-Forwarded-Encrypted: i=1; AJvYcCUxmtWo4odT+TpZA9aXfkY20RLcnLchZPs7SNKmqSNkSYGdj7zt7nbaHXwBZ6p+QEVKLhQiIHib+gZacns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyetgnkluN6YltM1xSdNDhQklks228G6CBKHbXiSYP3ryPfw+1i
	uGJPMPTqSyspPGQEhTuLrMWNstPtLcVOS8OGTlg9lwDHyU5bU/cx
X-Google-Smtp-Source: AGHT+IHf70XN7PLh1UIy2gnMS9EXVEVjcQanHW87JpL/a9EH3UqN2CYAcEcggsThNQ8MVBn3h6PoyQ==
X-Received: by 2002:a05:6214:5d0d:b0:6cb:b7ea:2072 with SMTP id 6a1803df08f44-6d35c0a2b38mr273196996d6.1.1730833351188;
        Tue, 05 Nov 2024 11:02:31 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fe786bsm62977876d6.62.2024.11.05.11.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 11:02:30 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id D4287120007C;
	Tue,  5 Nov 2024 14:02:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 05 Nov 2024 14:02:29 -0500
X-ME-Sender: <xms:xWsqZ3NmMkSqYrSQcRDUyBtuBiMfJUcXdBVpUcxZ75046S_GrGUrpQ>
    <xme:xWsqZx8Ne8XtSTKPy8Sb8mHul5ddb5JX0iWI2cP0IT_vavKJt-wx7E6BhBYix1jpg
    dNP2QGK5tfeOjoFaw>
X-ME-Received: <xmr:xWsqZ2TIIpXb-On7QqAdM66pJwzxekj2VPlWhoVQurH8i-TdxqZBVFWtlS4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddtgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhepiedtfeevhfetkeelgfethfegleekfeffledvvefh
    heeukedtvefhtedtvdetvedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrg
    hilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvtddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhonhgrshdrohgsvghrhhgruhhsvghrsehhuh
    grfigvihgtlhhouhgurdgtohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvg
    guuhdprhgtphhtthhopehprghrrhhirdgrnhgurhgvrgesghhmrghilhdrtghomhdprhgt
    phhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiise
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepnhhpihhgghhinhesghhmrghilhdr
    tghomhdprhgtphhtthhopeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepjhdrrghlghhlrghvvgesuhgtlhdrrggtrdhukh
X-ME-Proxy: <xmx:xWsqZ7uW7HjnYg7qoWLc_CqF6c7LL686HAhC0A7bV1gLUE22rai79g>
    <xmx:xWsqZ_fzz2aovBRaRyI3iUHKFzT7e07lK3-3DW6M_902bF0QcSpSGA>
    <xmx:xWsqZ31mVTbz8YRvFYHhVVSfXyXPaIhGbWzDh4Luvz7vqc-IXl5WsQ>
    <xmx:xWsqZ7-CSjALXa-8YVHzvYr73ekfxulAiEmMjr9egh5hlaNKZyZHQw>
    <xmx:xWsqZy8S9rNmkAwXaqc9m1Nb5RWf5JsSLa8SAl5qTxVnCcWqZ5qWnAAt>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 14:02:29 -0500 (EST)
Date: Tue, 5 Nov 2024 11:02:28 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: paulmck@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
	will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
	linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
	hernan.poncedeleon@huaweicloud.com
Subject: Re: [PATCH v5] tools/memory-model: Distinguish between syntactic and
 semantic tags
Message-ID: <ZyprxPlkKPcKtwza@Boquns-Mac-mini.local>
References: <20241105164858.218336-1-jonas.oberhauser@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105164858.218336-1-jonas.oberhauser@huaweicloud.com>

On Tue, Nov 05, 2024 at 05:48:58PM +0100, Jonas Oberhauser wrote:
> Not all annotated accesses provide the semantics their syntactic tags
> would imply. For example, an 'acquire tag on a write does not imply that
> the write is finally in the Acquire set and provides acquire ordering.
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

Regards,
Boqun

> ---
>  .../Documentation/herd-representation.txt     |  44 ++--
>  tools/memory-model/linux-kernel.bell          |  22 +-
>  tools/memory-model/linux-kernel.def           | 198 +++++++++---------
>  3 files changed, 132 insertions(+), 132 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/herd-representation.txt b/tools/memory-model/Documentation/herd-representation.txt
> index 7ae1ff3d3769..4e19b4f2a476 100644
> --- a/tools/memory-model/Documentation/herd-representation.txt
> +++ b/tools/memory-model/Documentation/herd-representation.txt
> @@ -21,7 +21,7 @@
>  # Note that the syntactic representation does not always match the sets and
>  # relations in linux-kernel.cat, due to redefinitions in linux-kernel.bell and
>  # lock.cat. For example, the po link between LKR and LKW is upgraded to an rmw
> -# link, and W[acquire] are not included in the Acquire set.
> +# link, and W[ACQUIRE] are not included in the Acquire set.
>  #
>  # Disclaimer.  The table includes representations of "add" and "and" operations;
>  # corresponding/identical representations of "sub", "inc", "dec" and "or", "xor",
> @@ -32,16 +32,16 @@
>      ------------------------------------------------------------------------------
>      |                    Non-RMW ops |                                           |
>      ------------------------------------------------------------------------------
> -    |                      READ_ONCE | R[once]                                   |
> +    |                      READ_ONCE | R[ONCE]                                   |
>      |                    atomic_read |                                           |
> -    |                     WRITE_ONCE | W[once]                                   |
> +    |                     WRITE_ONCE | W[ONCE]                                   |
>      |                     atomic_set |                                           |
> -    |               smp_load_acquire | R[acquire]                                |
> +    |               smp_load_acquire | R[ACQUIRE]                                |
>      |            atomic_read_acquire |                                           |
> -    |              smp_store_release | W[release]                                |
> +    |              smp_store_release | W[RELEASE]                                |
>      |             atomic_set_release |                                           |
> -    |                   smp_store_mb | W[once] ->po F[mb]                        |
> -    |                         smp_mb | F[mb]                                     |
> +    |                   smp_store_mb | W[ONCE] ->po F[MB]                        |
> +    |                         smp_mb | F[MB]                                     |
>      |                        smp_rmb | F[rmb]                                    |
>      |                        smp_wmb | F[wmb]                                    |
>      |          smp_mb__before_atomic | F[before-atomic]                          |
> @@ -54,8 +54,8 @@
>      |                  rcu_read_lock | F[rcu-lock]                               |
>      |                rcu_read_unlock | F[rcu-unlock]                             |
>      |                synchronize_rcu | F[sync-rcu]                               |
> -    |                rcu_dereference | R[once]                                   |
> -    |             rcu_assign_pointer | W[release]                                |
> +    |                rcu_dereference | R[ONCE]                                   |
> +    |             rcu_assign_pointer | W[RELEASE]                                |
>      |                 srcu_read_lock | R[srcu-lock]                              |
>      |                 srcu_down_read |                                           |
>      |               srcu_read_unlock | W[srcu-unlock]                            |
> @@ -65,31 +65,31 @@
>      ------------------------------------------------------------------------------
>      |       RMW ops w/o return value |                                           |
>      ------------------------------------------------------------------------------
> -    |                     atomic_add | R*[noreturn] ->rmw W*[noreturn]           |
> +    |                     atomic_add | R*[NORETURN] ->rmw W*[NORETURN]           |
>      |                     atomic_and |                                           |
>      |                      spin_lock | LKR ->po LKW                              |
>      ------------------------------------------------------------------------------
>      |        RMW ops w/ return value |                                           |
>      ------------------------------------------------------------------------------
> -    |              atomic_add_return | R*[mb] ->rmw W*[mb]                       |
> +    |              atomic_add_return | R*[MB] ->rmw W*[MB]                       |
>      |               atomic_fetch_add |                                           |
>      |               atomic_fetch_and |                                           |
>      |                    atomic_xchg |                                           |
>      |                           xchg |                                           |
>      |            atomic_add_negative |                                           |
> -    |      atomic_add_return_relaxed | R*[once] ->rmw W*[once]                   |
> +    |      atomic_add_return_relaxed | R*[ONCE] ->rmw W*[ONCE]                   |
>      |       atomic_fetch_add_relaxed |                                           |
>      |       atomic_fetch_and_relaxed |                                           |
>      |            atomic_xchg_relaxed |                                           |
>      |                   xchg_relaxed |                                           |
>      |    atomic_add_negative_relaxed |                                           |
> -    |      atomic_add_return_acquire | R*[acquire] ->rmw W*[acquire]             |
> +    |      atomic_add_return_acquire | R*[ACQUIRE] ->rmw W*[ACQUIRE]             |
>      |       atomic_fetch_add_acquire |                                           |
>      |       atomic_fetch_and_acquire |                                           |
>      |            atomic_xchg_acquire |                                           |
>      |                   xchg_acquire |                                           |
>      |    atomic_add_negative_acquire |                                           |
> -    |      atomic_add_return_release | R*[release] ->rmw W*[release]             |
> +    |      atomic_add_return_release | R*[RELEASE] ->rmw W*[RELEASE]             |
>      |       atomic_fetch_add_release |                                           |
>      |       atomic_fetch_and_release |                                           |
>      |            atomic_xchg_release |                                           |
> @@ -98,16 +98,16 @@
>      ------------------------------------------------------------------------------
>      |            Conditional RMW ops |                                           |
>      ------------------------------------------------------------------------------
> -    |                 atomic_cmpxchg | On success: R*[mb] ->rmw W*[mb]           |
> -    |                                | On failure: R*[mb]                        |
> +    |                 atomic_cmpxchg | On success: R*[MB] ->rmw W*[MB]           |
> +    |                                | On failure: R*[MB]                        |
>      |                        cmpxchg |                                           |
>      |              atomic_add_unless |                                           |
> -    |         atomic_cmpxchg_relaxed | On success: R*[once] ->rmw W*[once]       |
> -    |                                | On failure: R*[once]                      |
> -    |         atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[acquire] |
> -    |                                | On failure: R*[acquire]                   |
> -    |         atomic_cmpxchg_release | On success: R*[release] ->rmw W*[release] |
> -    |                                | On failure: R*[release]                   |
> +    |         atomic_cmpxchg_relaxed | On success: R*[ONCE] ->rmw W*[ONCE]       |
> +    |                                | On failure: R*[ONCE]                      |
> +    |         atomic_cmpxchg_acquire | On success: R*[ACQUIRE] ->rmw W*[ACQUIRE] |
> +    |                                | On failure: R*[ACQUIRE]                   |
> +    |         atomic_cmpxchg_release | On success: R*[RELEASE] ->rmw W*[RELEASE] |
> +    |                                | On failure: R*[RELEASE]                   |
>      |                   spin_trylock | On success: LKR ->po LKW                  |
>      |                                | On failure: LF                            |
>      ------------------------------------------------------------------------------
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

