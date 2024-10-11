Return-Path: <linux-kernel+bounces-361656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E4799AAF9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7371F22FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C9E1C68BF;
	Fri, 11 Oct 2024 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="j9zn4uMn"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB01D38DF9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671321; cv=none; b=dGqiWKlN+l5FsW3S9ecNsKuyTAvaGwAVBG60K2avTFB4I4QaTQ1G+eHqp0WZRI4jRXtDSb1X2Vxucb4Yz7V1aTiscbB2R2/Spd3k3XsTajKPYJ35iE12GVOfVqNC8acpR29F83YUXB+hCZyaNZ0IDiaouQ5VtmBeKmiq6hijeEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671321; c=relaxed/simple;
	bh=l2UvrNQIKRmHj3uOcMWExb9bsvfrjIPTrrSYOe9n1ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8SX50JHrmr6SW5hu0WWsQMZV2yplVRodaA55y/Ww3XEXqb/fibxsyF8N58lbq1WJ7GBP73uHOUalipfOIDCom04gN0O7CvqGUsduYIenGkK6EqRO4Er5RZiqDqPYHliYcHUUTBpzghTG9wLTi6xzq4MnyYz3hLWzY5tO5qwGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=j9zn4uMn; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b10e800ba9so262204185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1728671317; x=1729276117; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S5TP3pWed8mCMbT6UNBmabqJdMAQFYc90u2/dTq3ojo=;
        b=j9zn4uMntqzMaO/4XoLXNcn6DVFaRWR76zAL8PuShrPuhT7oMiob0Ee4JDkPXmVI5x
         38MfiwNYyKZSdXMfI7968m8o9Y2yzOoWvbN1J2uwMscwTkQZ/qrgxyln1HnZ5zrYe1Fg
         4YzU+ByvFWE2Qqb1G9+LzE04K+cub8/A7ZD0yH6oaCycCpCcG2pcUZKwxaSbnl/r2Ds2
         8w48oqW04A9TU/W49lsz2KLN2/I3upOmShW2W7WDJAltuOZPwvkyCqTIGkqlTXzKKHqJ
         xyNCAlXlkdr9OdKsSu8I3D9c/RF6H1CrUA7nPaWbiQ9jKaqPAuoYJbvCc3B3W27mrhHD
         GIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728671317; x=1729276117;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5TP3pWed8mCMbT6UNBmabqJdMAQFYc90u2/dTq3ojo=;
        b=bZ6HZrhB99NudPjTx4NdYgsUFfoQ/LBaXBYy8wV2B0yJfZIMbEW4SQDDK5GDcu7ill
         YU6cjy9scVBDWlSzjWPAzo0MCcpgEmOA7auMBcdJU78XNBe0fLWufxiWFnw75rTdSm38
         kYvMCnI70mtYrqbmOhp8+1YbLN5hM+GstQ44ndOeIXnuVWmGSof4rlqyLK3Md97XvtbP
         iccd7BYhgeIxnWVeBHrvl8zwNLHUHjBTwGFmxDsMQC/F6ykDp/cCw+H3gkSucPGh9l5p
         gbkC4Zbqlfk/GwoHUUILmqG9p080dxoeVoutFZGSfbWsMJOSziWw8SixVsBysPn8KsC1
         xXLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyDERh/SGPql62CEztQ/uboeiTRJ763PLX/p5jkM8dwdPDCJZqYhMq3lGMpkiO1NU6h0PpEY5H/fcKRlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygwz4QiKIrUBAuIHArH4IjI4g3T9XCiiPYkwqyoCgX/xBvDWQk
	tLF69QJAGEACK4gwF9gs+czJGQXfGH3U0JhLRjib86VMhEMYC3iRbY/J+dCFN6Y=
X-Google-Smtp-Source: AGHT+IHOy2os4AygFCj/si9mO5WDycK903UcjlcAD35+buWA3h7q1akh/to8orx4kFmKiivr7kOhDQ==
X-Received: by 2002:a05:620a:46aa:b0:7a9:a389:c12e with SMTP id af79cd13be357-7b1124c81dbmr1305699285a.16.1728671317537;
        Fri, 11 Oct 2024 11:28:37 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148c7e54sm154774185a.18.2024.10.11.11.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:28:36 -0700 (PDT)
Date: Fri, 11 Oct 2024 14:28:31 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	"Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/zswap: avoid touching XArray for unnecessary
 invalidation
Message-ID: <20241011182831.GC351101@cmpxchg.org>
References: <20241011171950.62684-1-ryncsn@gmail.com>
 <CAJD7tkaZgEHUNce5c8LWpWXKnTZ7geOuBym41t+UoZax_nky7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaZgEHUNce5c8LWpWXKnTZ7geOuBym41t+UoZax_nky7Q@mail.gmail.com>

On Fri, Oct 11, 2024 at 10:53:31AM -0700, Yosry Ahmed wrote:
> On Fri, Oct 11, 2024 at 10:20 AM Kairui Song <ryncsn@gmail.com> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > zswap_invalidation simply calls xa_erase, which acquires the Xarray
> > lock first, then does a look up. This has a higher overhead even if
> > zswap is not used or the tree is empty.
> >
> > So instead, do a very lightweight xa_empty check first, if there is
> > nothing to erase, don't touch the lock or the tree.

Great idea!

> XA_STATE(xas, ..);
> 
> rcu_read_lock();
> entry = xas_load(&xas);
> if (entry) {
>     xas_lock(&xas);
>     WARN_ON_ONCE(xas_reload(&xas) != entry);
>     xas_store(&xas, NULL);
>     xas_unlock(&xas);
> }
> rcu_read_unlock();

This does the optimization more reliably, and I think we should go
with this version.

First, swapcache is size-targeted to 50% of total swap capacity (see
vm_swap_full()), and swap is rarely full. Second, entries in swapcache
don't hold on to zswap copies. In combination, this means that after
pressure spikes we routinely end up with many swapcache entries and
only a few zswap entries. Those few zswapped entries would defeat the
optimization when invalidating the many swapcached entries.

So checking on a per-entry basis makes a lot of sense.

