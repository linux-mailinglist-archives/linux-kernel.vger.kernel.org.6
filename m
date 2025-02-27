Return-Path: <linux-kernel+bounces-536317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48749A47E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB453A758F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E618D22F38E;
	Thu, 27 Feb 2025 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bTtkxD7p"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C9022F388
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660155; cv=none; b=lebboir1BBXuC53egPysAfOVo1ON5CWIq0lD75SWpC0+FMicuEBrqqa3x4Yhlsvd8S19GM1llsYTsivm2PkQQeBqNANmJnKPpLU4ZDwnNjJiuGudnmdoY6yUmO1TxqvEKqvuzPibEZf8ld5Cd1Jz7eTaBc7Elpfcfy3NvSD5THM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660155; c=relaxed/simple;
	bh=KF0xCl2NEuaJCiOmNJEHaaw/HQlE3lWFTR2mMGc7n2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eveR6GXzWqYsTGbMZje2gMRuCLnm26j/NvHdVw/TNDN4DSKyd8Ki7uMH2ckveCwSzGQjHPslmZaQQAQcwIeWAyK7Rw3U19r5dkAXdQ8T4vghrvx88mzDMe547BdXD+ZKBTJ88BC3biCJTu/Has6KWeshvc1jExdzbWGrazdo0Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bTtkxD7p; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220f4dd756eso16149765ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740660153; x=1741264953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JO39NonkIXySEEdjexhrhful6hOdxXOoHMCUy3lutDs=;
        b=bTtkxD7pfo9TKV4yjFuKA6M15N4rvTGxhdHd86E2GB5C/443XgdYQt0xe9EkrTA5kO
         IZeKUmRUP+SIrQxdyX4HPcJQUfB1LOlpWZMYzcNTW2AkwW6IEhPUzP0mitlYhYAk29n0
         kR7/k8Mj4cRM5MLaFXvhFvNMah5Dbjg8oq4IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740660153; x=1741264953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JO39NonkIXySEEdjexhrhful6hOdxXOoHMCUy3lutDs=;
        b=LDMMXIE0FtOzcngQ4ORHhRRGgPr/nAqHs7UVFvjQYYLkgWqimR2rYRGCGa1zvAktxy
         c+Ln8O8aAm8NKZlA8urzDmNX79N/w2WNL0WAArsX6nEsb84W50zWQ4GlQXWRBkrtj6VT
         JrJKg7LkLObzLLnQjzt+u80HL6QbrJ9c/jYuBSluQTWwLs+JPJKu3JF5Ix/NcnRptFDA
         xdZzEo9OE90znXgTcvWNdKpnuz0RnBk0ov51nVhK1bZeHwRlDOesTmviYpDdVXzgyT8z
         4go478z0pjT/fkFZMhfK2Tcn5kjOTpJYuQIECDPZ/wWqyUaLk+Z2NRTTgMPTYXDZN9Ad
         HtYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXncIQGQijrhaWF5hAef45xPdadlQGJuuTtk1VSMOJsfMFRMIi0rvpAKsqanZbLyNR6DAGiKGIpFhH6hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEe++tUn0zMAVnO7VDSyjBzYbAiiHGkJcfOVF97rZkmsvR4O8Y
	lG1sidSphRntknMUisoBKMfY0NXO2A5LPuH6c7nE7uSru8CphMEsOkB9MPbo5Q==
X-Gm-Gg: ASbGncurou3x24plz45FDQapRUdNDLBdowKaiJDXtTxlv93G60U1DZikH+1cZeRsmvc
	ClVKb6oDJff4Zhk5LWY/XwUllDlGME4rManXSw3s5EuLntIrhWalw7omJGhKabVCvFmDYNZlafc
	37DTq+sTi7Ory7XfWF1jc0odrwjimTXoMKSlLLll4RznAxF54z8w95VH/DZMZ0CQKDaogeASMnV
	2GV5OSn7kw8xxwNEvk4YvkQSrDjvttbRvCXsPDwHAxreTjimDUy6UZMOTcLQ3o6mDM/jx0oCCno
	9ErsZmC7pq15B07jvfVXhPhC0Y1kTQ==
X-Google-Smtp-Source: AGHT+IHQDfnD4YCR20HmdNquT6tjT8Vc6oH3OvR16gag9lE7O1kspFHtXL7T10uSf6M1PlhbDM0jsQ==
X-Received: by 2002:a17:903:41d1:b0:21f:6ce6:7243 with SMTP id d9443c01a7336-22307e79375mr163730555ad.51.1740660152660;
        Thu, 27 Feb 2025 04:42:32 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5c67sm13289625ad.135.2025.02.27.04.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:42:31 -0800 (PST)
Date: Thu, 27 Feb 2025 21:42:25 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/17] zram: sleepable entry locking
Message-ID: <irpjhnu7utkhf4dds5ghklsbdug6nf32ulsp52ibvym6t3wqfg@pqu7w6uvgbvw>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
 <20250221222958.2225035-2-senozhatsky@chromium.org>
 <20250224081956.knanS8L_@linutronix.de>
 <i2kgeeehfwzwo22vazakcq4at2m223nebb2xfrqfvsgawpmqya@zjhqhjshvhi3>
 <20250227120532.OsZr4v2A@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227120532.OsZr4v2A@linutronix.de>

On (25/02/27 13:05), Sebastian Andrzej Siewior wrote:
> > > > +static void zram_slot_lock_init(struct zram *zram, u32 index)
> > > >  {
> > > > -	return spin_trylock(&zram->table[index].lock);
> > > > +	lockdep_init_map(slot_dep_map(zram, index),
> > > > +			 "zram->table[index].lock",
> > > > +			 zram_lock_class(zram), 0);
> > > > +}
> > > Why do need zram_lock_class and slot_dep_map? As far as I can tell, you
> > > init both in the same place and you acquire both in the same place.
> > > Therefore it looks like you tell lockdep that you acquire two locks
> > > while it would be enough to do it with one.
> > 
> > Sorry, I'm not that familiar with lockdep, can you elaborate?
> > I don't think we can pass NULL as lock-class to lockdep_init_map(),
> > this should trigger `if (DEBUG_LOCKS_WARN_ON(!key))` as far as I
> > can tell.  I guess it's something else that you are suggesting?
> 
> ach. Got it. What about
> 
> | static void zram_slot_lock_init(struct zram *zram, u32 index)
> | {
> | 	static struct lock_class_key __key;
> | 
> | 	lockdep_init_map(slot_dep_map(zram, index),
> | 			 "zram->table[index].lock",
> | 			 &__key, 0);
> | }
> 
> So every lock coming from zram belongs to the same class. Otherwise each
> lock coming from zram_slot_lock_init() would belong to a different class
> and for lockdep it would look like they are different locks. But they
> are used always in the same way.

I see.  I thought that they key was "shared" between zram meta table
entries because the key is per-zram device, which sort of made sense
(we can have different zram devices in a system - one swap, a bunch
mounted with various file-systems on them).

I can do a 'static key', one for all zram devices.

> > > >  static void zram_slot_lock(struct zram *zram, u32 index)
> > > >  {
> > > > -	spin_lock(&zram->table[index].lock);
> > > > +	unsigned long *lock = &zram->table[index].flags;
> > > > +
> > > > +	mutex_acquire(slot_dep_map(zram, index), 0, 0, _RET_IP_);
> > > > +	wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK, TASK_UNINTERRUPTIBLE);
> > > > +	lock_acquired(slot_dep_map(zram, index), _RET_IP_);
> > > 
> > > This looks odd. The first mutex_acquire() can be invoked twice by two
> > > threads, right? The first thread gets both (mutex_acquire() and
> > > lock_acquired()) while, the second gets mutex_acquire() and blocks on
> > > wait_on_bit_lock()).
> > 
> > Hmm why is this a problem?  ... and I'm pretty sure it was you who
> > suggested to put mutex_acquire() before wait_on_bit_lock() [1] ;)
> 
> Sure. I was confused that you issue it twice. I didn't noticed the d in
> lock_acquired(). So you have one for lockdep and one for lockstat. That
> is okay ;)

Cool!

