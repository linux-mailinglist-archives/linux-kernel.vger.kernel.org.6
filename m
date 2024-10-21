Return-Path: <linux-kernel+bounces-374663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D81F9A6E44
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9524FB216A3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47141C3F02;
	Mon, 21 Oct 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CYgmH2V5"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D34B1C3F29
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524876; cv=none; b=InrLQg+5W5QobwaXeiPSJW0ACYvfxt4J7YLcAGAkMwsoTRqzgebLPyfSv0rHSvN92cDcFHTXQGDPf55jfesgnXQGEzNV224xPrTt1OGYIbAVi25dAkTSTKpJ5nkdZb0bElIHtuBzOJTUjVV3UgeWc611GjaxNfZwnWhwqnh5zio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524876; c=relaxed/simple;
	bh=n/4VFTv0GOfYfGqcvDOGvguTAkxCU+YxAzm6iilf6qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kK4MSZEFasxYrmeI4GiH4n5PiuuhJxJuA8Xivb4UZ0+ib9pKyCyKiB5ZqSUBA3l5lWWAj2UfhmgWVikFTIEpfO8Fq2c0HTiq12RvryYYjGB4L6WJJdHPCNF91fpxST8hc4O4DowO08gaux0OMUJq5HD+YzF27bo+jON6+G/7DUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CYgmH2V5; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f58c68c5so6834620e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729524872; x=1730129672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kpi3GmQz/NfclizXKPSgfHHhy5JjbE963jj4j4rTyiU=;
        b=CYgmH2V5aVg6S/zh0xIkLtzqpt3qDqDh0aqgzFnuLxQXykh1H6Ob8EOt+j9TShBylJ
         fU/7gjySiPyDVyYn8gToDpnX/oUJGoUBiVBbuiKvZChPrQIAyIksI1zyGweGmAeBdJls
         l8XBdkdSGKibB0hxQvgIXTSVauSKxa8w9Kkkr3OKG0hxojXrSuXka0LuWXvbkwL8tsGF
         548ltWSAWtx3/h7BQmLiBGxryUeqDhvRHk6QIl5cRNQ5RZk2bPDP1QNWP6yw0StEc04z
         9KQXLytvcmXqZjmIbbPdHODWsJlHXTfCn/3erz+aTbwbcT0m4lYDcePTK81BLX4qrbpj
         Ms2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729524872; x=1730129672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kpi3GmQz/NfclizXKPSgfHHhy5JjbE963jj4j4rTyiU=;
        b=mRGkg54GjCbqrijewLFWzL2HsQgk/z5nSwdDM15kvMdP7b7iH49hhHPqp+D2SHgAe/
         T3qith76oWX+Asm4eqWkTeY5DnO/zGfXpumhsbLdZoIQVvMvrL282RBcDFtor/pDfegt
         6OhsixP3mq3uoMNMLEw1naMv/SEHZ/B9MyZKG3/0eVcgueiaVtVAJ0PTjWaLo9x+ps9N
         q5vDOlcoVyYJD25QiWf9u2JGVxY73KNA6ziXwiSChSMh/f7AukujgOvjyJ9fWqGmvxJp
         LMIxgzBQQ3hECx8nx5A5kXwnKHY7fqsKkYiNkRRi0kOCXF4SHKP0NeTNlWODDZvBfLYw
         2njw==
X-Forwarded-Encrypted: i=1; AJvYcCVU/dWWYC9UfBuWMjb24/nxbgdSEfMZRnUZDOCyq8f4t4m7l03F3w+IZAk7sRy7ljBJQw5n0JdxTdXu2ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwDrLgJCD3ehNIZen/jc0z2yB2ChY+ELI8wLN2BV1AQiMkfMtC
	/bVd/OJYWCGP/UQORrOvFcIS2M/1HcXUREC+P1lCz5VhlIahgQ5IGVJac/zz0xw=
X-Google-Smtp-Source: AGHT+IGzzU1TQCW20G0COaHzT8p401xKbkZuwocfdc2Wv/QwRAiKkBR0510ioS+3h4L6HROkPO+JAg==
X-Received: by 2002:a05:6512:1244:b0:536:a7a4:c3d4 with SMTP id 2adb3069b0e04-53a154c9f17mr10043316e87.39.1729524859798;
        Mon, 21 Oct 2024 08:34:19 -0700 (PDT)
Received: from localhost (109-81-89-238.rct.o2.cz. [109.81.89.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370631sm215121766b.104.2024.10.21.08.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 08:34:19 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:34:18 +0200
From: Michal Hocko <mhocko@suse.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org,
	kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de,
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org,
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de,
	xiongwei.song@windriver.com, ardb@kernel.org, vbabka@suse.cz,
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net,
	willy@infradead.org, liam.howlett@oracle.com,
	pasha.tatashin@soleen.com, souravpanda@google.com,
	keescook@chromium.org, dennis@kernel.org, yuzhao@google.com,
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com,
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
Message-ID: <ZxZ0eh95AfFcQSFV@tiehlicka>
References: <9c81a8bb-18e5-4851-9925-769bf8535e46@redhat.com>
 <CAJuCfpH-YqwEi1aqUAF3rCZGByFpvKVSfDckATtCFm=J_4+QOw@mail.gmail.com>
 <ZxJcryjDUk_LzOuj@tiehlicka>
 <CAJuCfpGV3hwCRJj6D-SnSOc+VEe5=_045R1aGJEuYCL7WESsrg@mail.gmail.com>
 <ZxKWBfQ_Lps93fY1@tiehlicka>
 <CAJuCfpHa9qjugR+a3cs6Cud4PUcPWdvc+OgKTJ1qnryyJ9+WXA@mail.gmail.com>
 <CAJuCfpHFmmZhSrWo0iWST9+DGbwJZYdZx7zjHSHJLs_QY-7UbA@mail.gmail.com>
 <ZxYCK0jZVmKSksA4@tiehlicka>
 <62a7eb3f-fb27-43f4-8365-0fa0456c2f01@redhat.com>
 <CAJuCfpE_aSyjokF=xuwXvq9-jpjDfC+OH0etspK=G6PS7SvMFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpE_aSyjokF=xuwXvq9-jpjDfC+OH0etspK=G6PS7SvMFg@mail.gmail.com>

On Mon 21-10-24 08:05:16, Suren Baghdasaryan wrote:
[...]
> Yeah, I thought about adding new values to "mem_profiling" but it's a
> bit complicated. Today it's a tristate:
> 
> mem_profiling=0|1|never
> 
> 0/1 means we disable/enable memory profiling by default but the user
> can enable it at runtime using a sysctl. This means that we enable
> page_ext at boot even when it's set to 0.
> "never" means we do not enable page_ext, memory profiling is disabled
> and sysctl to enable it will not be exposed. Used when a distribution
> has CONFIG_MEM_ALLOC_PROFILING=y but the user does not use it and does
> not want to waste memory on enabling page_ext.
> 
> I can add another option like "pgflags" but then it also needs to
> specify whether we should enable or disable profiling by default
> (similar to 0|1 for page_ext mode). IOW we will need to encode also
> the default state we want. Something like this:
> 
> mem_profiling=0|1|never|pgflags_on|pgflags_off
> 
> Would this be acceptable?

Isn't this overcomplicating it? Why cannot you simply go with
mem_profiling={0|never|1}[,$YOUR_OPTIONS]

While $YOUR_OPTIONS could be compress,fallback,ponies and it would apply
or just be ignored if that is not applicable. 
-- 
Michal Hocko
SUSE Labs

