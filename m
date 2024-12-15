Return-Path: <linux-kernel+bounces-446549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F759F25FA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 21:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388851885839
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 20:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7318E1B9831;
	Sun, 15 Dec 2024 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPIcp9mR"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48234175BF
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734293304; cv=none; b=jrdrJMBqMpXqK6FvIpsUkFK+WIKRqdmgBWPIuuN158KCR5VhKzsZ8P+TRYUXyGyF9DR74tcyfqNoWnlTNXOHhvDPLr/05qqk0beEYxIo4Lq1gs9yhaog2lUBGskDzXAuu3ZL8f3iF2vq0nWaThnQW0jweL9DR65cEYdFIO1qisE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734293304; c=relaxed/simple;
	bh=82lBQhfy4ugFlmtxzGDkFOfRQrea802BAqDqgjRI+Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgwMjdnFul4/XEGnH0gOv7Uc8AHuxU4COjsoTldEqb+1PB/KN+cXuLBa0u4cxtpJJElwE8NjOCN+vJyGxX9S4E5YHvJ6whvgVnGtBDOY76F3f6mhkaLlQqYGGSQEZR5r2BFAtP3288NZbrvnQZwb8IMLs5B+vMs+stAaWDNOVpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPIcp9mR; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4678664e22fso34428441cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 12:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734293302; x=1734898102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDzgwa61e+om6LsGHubgAOxXOshOaf1zjEonOuJmqiA=;
        b=HPIcp9mR7SemBf5vlGOMnJesQigvwN0N6hanVfqz23IAv48Cf4UFDQYsi74RL/YxAx
         mQNnK2HjSqPFrBc0Ce4srIsFoRUn+FGGPppgrzvMGBEjMP3VxSCcKIe/+4zA6ZECDGD1
         zKUrB/QTn4Txc9p8aVReQOj7czh1pKSL8QPR7TWHm3uWZaC3SJiveGcKzxqAsq+Lj+iB
         hwLs78qPTV+pzE9GBzNN144MrbeKV5KjKICJ+KPRBuoLnyt2XNaYfxr5Ke2/j+7764ij
         IUEm8buvMJymBV8FnDqAkv0ySDa/CoZI3wB4HPx9SwT4XdeJs6lNS6CYu1mvOsixzRM2
         go1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734293302; x=1734898102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDzgwa61e+om6LsGHubgAOxXOshOaf1zjEonOuJmqiA=;
        b=WYU7fcy0S8KkdmhQ2SKc8ypHa7MzQSX14x2UaZR95eK3CYVk6krtA/EGarOoQ172pT
         UeLAUTHWSgtBABzdKir+ru82dBvQC5CQ4c6fpSyy1KzJGwTTiYMEGdha1IAwE0cBL3dx
         K3fHK8Cnrc2+AAlahOU2qkelrIMjJRmjrUOdwMWCyz21lRk6pu4v/Dq5pMl5Ba3SAIPi
         1/YTNeqAVSiHSa7D8Aufx8TYTQaXRHca6NthC1fp4v5M2vy3IymFlfmFxa66Zt3BFqyb
         /3xFkWdxcMBHi0H6+0PQ+wLjMPXEfTNNCMG1gaCjYXEwCEUe1Wz3Od1+cw3AxwR+Tw3P
         Fn4g==
X-Gm-Message-State: AOJu0YzMKni7KiLfJEprsskuIf7yaNwXHb4TaDlFjdRCrSQgkLPA/Qf9
	NDgHGR4PXjjr7+qzE9YGwJ3e3SC56PiSu6Z6VTHGI0O0C6W3iKtb
X-Gm-Gg: ASbGnctxNanBQU1LywGAN5cziO4hi1fZQzHRRIGa8GmHLuxTylI8PvJyAfKrOjyYFxl
	ip6P0BVbKTjUq12SNPyFeiY9xQ+nw8ib2nbFIU+p+bjNoyAsWS0xDvkozrhoV0dN/RQw7fDg//M
	BKaDcM8lQqtR6mXsqMsHe0LsI+JXd7vodiWWC21KJzgpHJNu5wqjk4Qu4FKieSzFjqe7zQ2EYr3
	Mk4kED1DLnJkC3T+JWS1dq8hf8sRFwnChNK6DHexcyB1fHPPZmGzFkMwlJNRS9XKvw6gHrkPaV/
	tVcgaZ6y7dHW+XFX3H/AyAyAC3DKmEgiiMHQUqxeM/O/hf4=
X-Google-Smtp-Source: AGHT+IFWjPE3ccC6zX44KQ1hRdtd3zkraAOtpY+wfSfEq+cGdymbOq9rpKWmdMj9cpaAjqf+tF5QLQ==
X-Received: by 2002:ac8:7f52:0:b0:467:5462:4a10 with SMTP id d75a77b69052e-467a54bab28mr194892211cf.0.1734293302174;
        Sun, 15 Dec 2024 12:08:22 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2ca087esm20073701cf.28.2024.12.15.12.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 12:08:21 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4C78F1200043;
	Sun, 15 Dec 2024 15:08:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 15 Dec 2024 15:08:21 -0500
X-ME-Sender: <xms:NTdfZ2jAbtEli5nAm2pCSYWvaPoP2BY372qijFxRu3lCcsK0tE1HrQ>
    <xme:NTdfZ3B424QQhvGYDchEqxWMhF6QM-U8JCu3Il3HPzMn0gg54L-wEpakjwJafujep
    vaGTrrFig7WvENYag>
X-ME-Received: <xmr:NTdfZ-E_R96XOSFuYYdMFYQPaiGt238hTN7WwP_YAFEtcf-0IBe9Ug3Sa0q2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledugddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhose
    hlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhlvhhmsehlihhsthhsrd
    hlihhnuhigrdguvghvpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdho
    rhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfi
    hilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgr
    thdrtghomhdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepnhguvghsrghulhhnihgvrhhssehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:NTdfZ_TECe5bR4_1MpbNCsBpPxCSf6eu2aXCvI4QupWGW_yLzbYw_Q>
    <xmx:NTdfZzzYT4blah1-18vms1xPqrQZR794NZiNIUtjatTrkcH7FhsNBA>
    <xmx:NTdfZ96Ve8x6CZbjwvccK9iyVlSrsLwtyAKmhCzVkY1YQ7ebRdCbgg>
    <xmx:NTdfZwzViTgonunbME11O_54ORvG3P5FvLPvyvKBRWHDV3zse8NYcQ>
    <xmx:NTdfZ_hK2b9lmvtv1VF88AhC_boteAkrVH3VSUdRnFSNe1erabGeN6-H>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Dec 2024 15:08:20 -0500 (EST)
Date: Sun, 15 Dec 2024 12:08:19 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] lockdep: Move lockdep_assert_locked() under
 #ifdef CONFIG_PROVE_LOCKING
Message-ID: <Z183M9-JIH6mG3q9@tardis.local>
References: <20241202193445.769567-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202193445.769567-1-andriy.shevchenko@linux.intel.com>

On Mon, Dec 02, 2024 at 09:34:45PM +0200, Andy Shevchenko wrote:
> When lockdep_assert_locked() is unused, it prevents kernel builds
> with clang, `make W=1` and CONFIG_WERROR=y:
> 
>   kernel/locking/lockdep.c:160:20: error: unused function 'lockdep_assert_locked' [-Werror,-Wunused-function]
> 
> Fix this by moving it under the respective ifdeffery.
> 
> See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> inline functions for W=1 build").
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Queued for more testing, thanks!

Regards,
Boqun

> ---
>  kernel/locking/lockdep.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 2d8ec0351ef9..bb65abfcfa71 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -157,10 +157,12 @@ static inline void lockdep_unlock(void)
>  	__this_cpu_dec(lockdep_recursion);
>  }
>  
> +#ifdef CONFIG_PROVE_LOCKING
>  static inline bool lockdep_assert_locked(void)
>  {
>  	return DEBUG_LOCKS_WARN_ON(__owner != current);
>  }
> +#endif
>  
>  static struct task_struct *lockdep_selftest_task_struct;
>  
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

