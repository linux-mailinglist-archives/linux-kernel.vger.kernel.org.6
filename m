Return-Path: <linux-kernel+bounces-446543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1609F25F0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 20:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A14A163D6E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 19:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FC21BBBD7;
	Sun, 15 Dec 2024 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmhwgGJq"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1694818CC13
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734292513; cv=none; b=N47f7WCcaxw6990KYPsc8MRf6Xm326wx5peXIxOmJE28d4S9v60BPpaNMOcVjg73UJHVv5Dh2DtVZhm0QwtShjT0f5JuMdpI/sGPQ1qnvtxrBbwYM28RwSlEwDvBGrBZdL2rw/MQDHVB6K5aOInNx1puvMQkUhKq52bBowKs2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734292513; c=relaxed/simple;
	bh=Ng0ihqJksultGRuuZdcU+Us0fVV6LYGGrSDynhO7HrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axFj42LGoXs2LV4q7LYTgBaqNNJ6DizrbWDthvGFIaDPOZcKKCXfBMZLCV8aPBhZNqhneY5Pm84Xb4Ya7WyVC36FVPlXADcPkg2H4j62oFzA8rV51PECbqsOi3ZwqTt+fqojWQh8TGB5gSjnb7k9ya/0thElze4bu9feZDaqqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmhwgGJq; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467a3f1e667so15683181cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 11:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734292511; x=1734897311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KutpQX//29f7Zqo+JdG0d9ubSIqFItXcJu0uFi63PTo=;
        b=YmhwgGJqqgUSeY/RmLHQ3l3qTvaNxoIVj+soyX6DisZwcE8YK8VbYNdQt+CkjTYF4M
         t/ecUXGN2xS95TSJ+0OasTISjqacd/REFJzrTQwCp40KGFqBrNCMvEk7pEqFCg1nA57B
         0SylP50VA5xmKRXLW8DMlptA2sORyaauilTb/ksCOXy2KlCJK4fRupAH2rK/VaQYXDYc
         nqm043WCjUgh1HrougDidxgFi6wLZaYlq8SmhvgBXNOwv1q23jt36ZUl8H63nXtTb+Mp
         Npogo8YVoLeR+Bzb1lELkYJrN8o/cxOfWO6lgDlOnbk+Fu+Yzuk7DBWL9ab49nSXT9f5
         al0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734292511; x=1734897311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KutpQX//29f7Zqo+JdG0d9ubSIqFItXcJu0uFi63PTo=;
        b=k1WTt9ZA9T7nJXWoBvsjGQJkSrKfMXy5otxv+8WGVRmylwn3wEpCBj9XZxfExMWTvX
         qMpA7kRBfxsanjfLULfRea4wQPnq5qGFAfjIOHuK5ZyWcA26a5tLw6NwAO/jqCRiJW3u
         zaYJG+eJdQXca6g021pE3Fy4eeOjAKlvwgV2Dg1/blTWUFmVR80I35BcykGz9Gemn6S+
         iZLc+qppNHzhp9uHVfYs05DkkU1HmDBTrg/Ooh1sO3T2uxTD+M7IHuHuNA++e54HRT3M
         HWG+FukR++SjZSzN02yRUmL/NQRhYr9Bx2U3EySzlrjJfHZajRfJismWneV5GckNqfZk
         b8dQ==
X-Gm-Message-State: AOJu0YyKd5OZCIltWTXrSgoVf9EfXb2F83hKipAZXU/o6i6maMxWuAyY
	a7eB9mnM3y3WPE7vm8FmkjwMtmAWh3w7ZFIxcf17XR++n73Mqz+z/+lx0w==
X-Gm-Gg: ASbGncvspmeKmmxyJ6SNKyTc34C9AvssSL7w1cYV7awCRGVIByVZ5+i8XMqHp3nc/p1
	47ZRhqAgmrqEXsxGxZKlPc/cA3jDj7L6S0UYr9acxV/x/+VhUm3OXFeFkVN3F1JPfTUnjvWSc4v
	JQEDHVJURDdreL2VZJrowA8cGCDAkn522cDYRtfCF/O128yhtnubFeNF8ZPob1YAzVtGo+atlOx
	eT+yUk+Rju6WvmMywf/3Lo3W+D1kd0QAIzAyUYafi5lVF2z05GkqHOEghcTaqiW5SMSr6XcEHnW
	2HiNU4ZlBU2VlyZYfKwNxpSMPY+OTKXqSn6JMMq37orhDFw=
X-Google-Smtp-Source: AGHT+IF7QGOrB10m8TSdkPb1lL5qpq+ISHcfE235eXXqPxvCD743BLg+mfmQ7wkjVK8VmGQYNle02g==
X-Received: by 2002:ac8:7dd6:0:b0:458:5716:fbd8 with SMTP id d75a77b69052e-467a578fbe2mr211410361cf.32.1734292510865;
        Sun, 15 Dec 2024 11:55:10 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e83fe8sm19812841cf.65.2024.12.15.11.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 11:55:10 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id A5186120006E;
	Sun, 15 Dec 2024 14:55:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 15 Dec 2024 14:55:09 -0500
X-ME-Sender: <xms:HTRfZ-Jm6BvA1V7uv3nyV_-r07id1ZQaZe5ON0hCt7RkcHsndKWGFg>
    <xme:HTRfZ2L2sMoyct16m5tAdGb34j7kAYmNTji9lueNFnjxcoFw_-Cz8tgWoCoXmC-XP
    IPRTpciJ7ovN9tFeQ>
X-ME-Received: <xmr:HTRfZ-tLbWAMgmQeipmzrM-46A0eavdPh1tHQB3_AAW2j-q1Hj645QvkbPbu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledugdduvdekucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:HTRfZzbhRUzwzmrb59t6nrKR_67KK1EPCQQuVE6z69tLCi7rH_FLTA>
    <xmx:HTRfZ1YsI_AMQuAv0T_tWUV7HXYPEH9a8TbbsU69aihW4PgWXv_xbg>
    <xmx:HTRfZ_DA_cwJ6cr39moHoP72_WLIe-OpnNggUXN3Uo_ICc5olhtvdg>
    <xmx:HTRfZ7ZXQLNuEnNhLsAG-ZBkFI8oIN818B219rY0qt5lTjqMHsBIEg>
    <xmx:HTRfZ1qpq9lkYqpBRJYQKQiI2s10VuRBCg9X6Iy72q0SmBL8P_XVTKeO>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Dec 2024 14:55:09 -0500 (EST)
Date: Sun, 15 Dec 2024 11:55:08 -0800
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
Subject: Re: [PATCH v1 1/1] lockdep: Mark chain_hlock_class_idx() with
 __maybe_unused
Message-ID: <Z180HFO6a61PtzYm@tardis.local>
References: <20241209170810.1485183-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209170810.1485183-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Mon, Dec 09, 2024 at 07:08:10PM +0200, Andy Shevchenko wrote:
> When chain_hlock_class_idx() is unused, it prevents kernel builds with clang,
> `make W=1` and CONFIG_WERROR=y:
> 
> kernel/locking/lockdep.c:435:28: error: unused function 'chain_hlock_class_idx' [-Werror,-Wunused-function]
> 
> Fix this by marking it with __maybe_unused.
> 
> See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> inline functions for W=1 build").
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This looks fine to me, so I'm going to queue it, but could you do me
favor if you could share the exact configs that would make
chain_hlock_class_idx() an unused fuction in kernel/locking/lockdep.c ?

I might add these information in commit log.

Thanks!

Regards,
Boqun

> ---
>  kernel/locking/lockdep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index bb65abfcfa71..29acd238dad7 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -432,7 +432,7 @@ static inline u16 hlock_id(struct held_lock *hlock)
>  	return (hlock->class_idx | (hlock->read << MAX_LOCKDEP_KEYS_BITS));
>  }
>  
> -static inline unsigned int chain_hlock_class_idx(u16 hlock_id)
> +static inline __maybe_unused unsigned int chain_hlock_class_idx(u16 hlock_id)
>  {
>  	return hlock_id & (MAX_LOCKDEP_KEYS - 1);
>  }
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

