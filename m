Return-Path: <linux-kernel+bounces-528073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AE9A41335
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4051893823
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EF119AA56;
	Mon, 24 Feb 2025 02:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V88uZDiz"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FDBEED6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363107; cv=none; b=miZCMhggEavGybPK3rGWrD/R6Ng/nC/iQqfhYs1NyJxqYrFfMVyJewyNXzgnz9YS17m3M813NOUydBEAp62bUhKB5Cy4L94dn8BBZ/0cCw2NFrqsX6S68aOgtfUzmWx/FWoAMKp3v8ZUYrsJhvPxNkA/ZntABK5TPQ4d78RMIUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363107; c=relaxed/simple;
	bh=hBvpezDoNJ7/7bWPwIHgaZq5vyHgAUQ2MXboht8tR5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLgcE0QsLwAcD5wmnNisBs2KmmySvcNnardbvd20mEtlWFvuHo1WOOePkllfi4Jm4RbE8lHQ15gpIQDr4n94f4jqugZdihbzNg0NqQwCZBlgtFar4fAYQrkyf/iOiSaleT8gGOblrKcZ7Mj7ZU1OM91zuF8ll5qgLhPI2iUMPYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V88uZDiz; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c0a4b030f2so528995285a.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363105; x=1740967905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRPOTUWvKIwPCoGVuzKX18gR/kJ5CZNtCyu7DNmFy0U=;
        b=V88uZDizW9YZG8wCKls1S9sYpR7UIGLrCdoCT4NXjV9dVBxsvZk1trKHzC+wRctKR3
         h5k9jl+mNvkpzr58geMiBSt6XO5sgLgbmUb1Fe4npnsyp/EhHKADEvjYulSZzJdcXF1U
         +vmWyjFUwNhxJcya1IZNZGssfXTiuMIVmJP4wTEaMrADDIMEaR4rnoyyJhGVw/qcLlJm
         vvTDXwcGXvHGSDtLTHPyOP7tqEmktS6hi68srs6d4hnoLlaWcD/d/enOkai0PN005NIT
         hoMtJn5qjwjNmMTBE41iqO+JjMed9eXo+AleORyxAMhqaDxFGD0SAdX8d6XaMm5/LfEf
         HUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363105; x=1740967905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRPOTUWvKIwPCoGVuzKX18gR/kJ5CZNtCyu7DNmFy0U=;
        b=DwR3x3cAXzT79QvnVVs/5mmTiwExN/yVzyh4fLLURwFBOx2Mf3uShOUE8ZCJ/hyfJO
         QFWETzMUAq6NP3An0zjlxzzgs0ZvBNwKWaNGhf1NF/1wi2b0Ki6ECbIBLR23R6RFPG38
         gwZOMggyGPu9DaCG2UFlIu1G2C7q2TQ9C+fGHFtuCxMiVbgYOWmiO0iNHUKIHSIVx6Fc
         Da0Xr89B7FWxZ/l7rd+8aJ3gXlVrO5RLzsMwDsd2dzy75VJnMKMkr8q6SNE/FcEIvTn2
         LQRjfTGMRL1mdEh95kod+wObhpP3b/gptVTbnkeKY2UY+lTtGhzn7PbPwSrXvEAKp5ZA
         za7w==
X-Forwarded-Encrypted: i=1; AJvYcCV8eZlh781GFQ6p54OdGsKub/V58Rlm0hVbPO0ScZvQFkKZsuxwkA4bs1ql/7I42XbEXAtlDaYGTTYv1H0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD0V0IJsoy3Qr3u00PgUu9cJBoRHEW/Uoc4lVsmeWvInzeCmk4
	XBzImTFxPhMpqRhG4e42k92RnhjWH7ZUnY7otSdpVuZDoByuILSH
X-Gm-Gg: ASbGncvt74pGruli3my7va++zLgjBuP5t6qHI3U215Zj/2tzV4eAW3jv5z+8RzApWfP
	GfBGNnjcUAWZLDfSwSI5zFmoYSVjtYPV7VpXaZH9fI0qk7ygFxjmmF5IwnTCW92pJDNKIfaPpAC
	PGUycQ2SZPT2eF22naLI/oZB7bRN1zKoHPcuXd0PGdSqwqwbDmXUjNZwFpOJ+H/VasGObWVvlml
	cQq7Y4l2LxjPDpuwW50Di7n1e47IOu8mE1vhUfFkItj9q6qWo4AcihIXXz/jq5b3QujEf8FST4R
	e6qeVWJ5vfQNCweChLhWrdpo4Hy5N85sXJjvIidhK5hmaWuXmeqy+iFJA5dipAgxNOmiep+Phkq
	Q+OxnoUNG4cJeleKY
X-Google-Smtp-Source: AGHT+IGkJfovAJUcTu+V4ub2QQUBuFmYLKPYDEisTrTE8Y9Su5oTDwrO3SARs6GFfWGDbycHUkIVfg==
X-Received: by 2002:a05:620a:880f:b0:7c0:b685:1bba with SMTP id af79cd13be357-7c0cf8cd09fmr1348896985a.19.1740363105102;
        Sun, 23 Feb 2025 18:11:45 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a0baa1e9sm926472085a.72.2025.02.23.18.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:11:44 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 162E91200043;
	Sun, 23 Feb 2025 21:11:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 23 Feb 2025 21:11:44 -0500
X-ME-Sender: <xms:X9W7Z3UAvg6V_C-cunSlU-n_XMJ8mBERNuwUkbqbGlwUElZjftkzcg>
    <xme:X9W7Z_lrISUdSZL0qnw_icLlEoXy1n7LTeMep-4W8fRgsflGGH7zpfUW9haJJNJO-
    g0kfAaAsrrRgmfX1Q>
X-ME-Received: <xmr:X9W7ZzYHKUW_iKrEuPRmfC4O12ICYGmSJq14MKpx8GE9xIC_qUphn-9Mkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedufedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    ohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlrdguvggrtg
    honhesrghrmhdrtghomhdprhgtphhtthhopehrhigrsghinhhinhdrrgdrrgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehglhhiuggvrhesghhoohhglhgvrdgtohhmpdhrtghpth
    htoheprghnughrvgihkhhnvhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepughvhihu
    khhovhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvhhinhgtvghniihordhfrhgrsh
    gtihhnohesrghrmhdrtghomh
X-ME-Proxy: <xmx:X9W7ZyUCng1HEuw-GNoc3czs40Ks7UN5ZLLzzk3QweDoprnaOEtU5A>
    <xmx:YNW7Zxnskw4Il1NOtmxTZqPiFXYJeA-JWmKW4i9DVvaoC-s44aZIww>
    <xmx:YNW7Z_eYDPGWBVe2PrN7HN1uWv4p0P5mekFFXymDq_g-pi1iMzzAfg>
    <xmx:YNW7Z7GcHJxpTZQYZP5EuZGKC25FNhj3dFpUs1XWIh-T4zMlZ4UYLQ>
    <xmx:YNW7ZzmK0ibO6cW1pE_lH4wWNlrFHhl6tk0HlOxyBRbckn84GsaRVEuv>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:11:43 -0500 (EST)
Date: Sun, 23 Feb 2025 18:11:42 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 0/4] locking/lockdep: Disable KASAN instrumentation of
 lockdep.c
Message-ID: <Z7vVXs7F1re40KRX@Mac.home>
References: <20250213200228.1993588-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213200228.1993588-1-longman@redhat.com>

On Thu, Feb 13, 2025 at 03:02:24PM -0500, Waiman Long wrote:
>  v3: 
>   - Add another patch to insert lock events into lockdep.c.
>   - Rerun all the tests with the simpler defconfig kernel build and do
>     further analysis of the of the performance difference between the
>     the RT and non-RT debug kernels.
> 
>  v4:
>   - Update test results in patch 3 after incorporating CONFIG_KASAN_INLINE
>     into the test matrix.
>   - Add patch 4 to call kasan_check_byte() in lock_acquire.
> 
> It is found that disabling KASAN instrumentation when compiling
> lockdep.c can significantly improve the performance of RT debug kernel
> while the performance benefit of non-RT debug kernel is relatively
> modest.
> 
> This series also include patches to add locking events to the rtmutex
> slow paths and the lockdep code for better analysis of the different
> performance behavior between RT and non-RT debug kernels.
> 

Thank you, and thank Marco and Andrey for the reviews. Queued for v6.15.

Regards,
Boqun

> Waiman Long (4):
>   locking/lock_events: Add locking events for rtmutex slow paths
>   locking/lock_events: Add locking events for lockdep
>   locking/lockdep: Disable KASAN instrumentation of lockdep.c
>   locking/lockdep: Add kasan_check_byte() check in lock_acquire()
> 
>  kernel/locking/Makefile           |  3 ++-
>  kernel/locking/lock_events_list.h | 29 +++++++++++++++++++++++++++++
>  kernel/locking/lockdep.c          | 22 +++++++++++++++++++++-
>  kernel/locking/rtmutex.c          | 29 ++++++++++++++++++++++++-----
>  4 files changed, 76 insertions(+), 7 deletions(-)
> 
> -- 
> 2.48.1
> 

