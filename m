Return-Path: <linux-kernel+bounces-530507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5133DA43460
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDFD47A5512
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF8E254869;
	Tue, 25 Feb 2025 04:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ab1y6Ey2"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C701634
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 04:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740459099; cv=none; b=NexC9dGouMDIDC3YLKU9s1vVM5qXA1+OxpmEXVXVV98aMuPwNsYh/3KqCC+iJpqIyN2EWsVfi/vD68LWBofWJKHqVUI815LNqNiDZgu+Z4SwzRonLhuGjEF0uMdyJ5qbJPhqOaVpzC886w7hD0Z+0puEcN/ITl364+4JVY7hKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740459099; c=relaxed/simple;
	bh=75YWnMKW5V1bxNmPDSCxqLFmYJGDVWF7QMXU4rryuJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZLHFeTiGObqWzHIuaVLDxn8yw/QEmbzR63xjiWZgWUGjf9WV7ogt8oToXu28vCOEuC7vM9YEShnUq3CwAB7BxCNX7hd2jQAZ935GsjU7sfAWfAslkyimDVUQvRx0cZW+4ZdPus2HJgPXLdoqPgESCciJE/gohdaZn4YhmClLQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ab1y6Ey2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220d28c215eso79385925ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740459097; x=1741063897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAYgr05OUxvf18KV8Fyn2jho0e8ReFZ+XAVl6nv1oZ4=;
        b=Ab1y6Ey2yzFoSrLyDXsUBJQ+FAszGOgITogEgt7eNLYqmqHfqLAQEz+Xk3iY6vqQnN
         L2pjaFFpCRFp9J46HrLGa9hChaRyHzdKmMpNGurkZcQbraJxjOvYoSkCEnM9ZvvEzWr9
         ooO8m043hIWSHkhZGv46pHRIEok72w2XZ/mdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740459097; x=1741063897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAYgr05OUxvf18KV8Fyn2jho0e8ReFZ+XAVl6nv1oZ4=;
        b=nNtvfzpr9u/eivWgtckCSE6zMhV4aOYFbjS8ChQcfHLNfw3JzcAeg/IRET3sWRpWdV
         WpbTtNFmyn+Gte0F6gB6Ppr6sk1LxoX10bn9d4sWZO30rxnM+K+U98QBPShud6OFlIpL
         DAZSdrxgGwcAWF2Dd+lQxrblzjn+eCbPTWjHOdy4cbyz+BgSW4T0drBzGxWBU84PYbKB
         oVwyxKiYOpRK3vXKIwQW/qaGhnW/J3DyU9P5JkpWq8IA8jUj0FUOfTaVO2KkwUgQ47IO
         ii9P26+yIOyxcd3KG0crQ5pyVlqzqb9vRsH7WZv3mdW4KEBIVqPM0K0vHchyXxyA6qD1
         A7wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+9Z4hQZOkF+yc0qZu8USyeEVnylERBVy3+m0xSaYdJkHM7Med7Wr+oeYA2rbf2pDNPGu52YHcpOTDQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+dOnbBtAiZcGKscvaCFQ5abz96z1zoFTi1V2FluYSbOWTYeel
	6VynXX48wVHIfnMdK1munChwVK118TeX8RCpLuGrtJSn1OzoCR4/e5dijiAU4Q==
X-Gm-Gg: ASbGncvokk+i3Mqh7Abj0t2dSQZMyOb4hkUn5rHrCAN120NUj8LOXBew5x+4DDc9IWT
	mpxCQUGy4e9tX7wz1VLdqt1YWHGQO2Bz8xZof/6I4MssraYqQ7BzgyFCIi+c+iEzVvAdd3DEgRz
	jUU6jv/2+KENKhbyHk61FsSA6CwhLZxP14vBj0ljCmHlL1j1NzdLiGPvtIuRuHXATvbFj5gX5Wk
	FaXwks5LFIEjz+Bo9oyqbG3B7vjXxJNNpOw//4AGb53u4cDiINg2bw9KLEuCKc90Ov13ooIY0nJ
	sx7+RG+uKtJDnZg7NZD5Eg/a6f6CVw==
X-Google-Smtp-Source: AGHT+IFR3kCAKs0UvfzCjf6uhp1Rg5CEyCodt3h9VPUhgbP4OciBthJOQNOrY+8kdjGGkoundX4IDA==
X-Received: by 2002:a05:6a00:1828:b0:732:5b10:572b with SMTP id d2e1a72fcca58-734790cbaf5mr3041330b3a.10.1740459097527;
        Mon, 24 Feb 2025 20:51:37 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e27d:842a:e0d1:29c4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6ada86sm525801b3a.30.2025.02.24.20.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 20:51:37 -0800 (PST)
Date: Tue, 25 Feb 2025 13:51:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/17] zram: sleepable entry locking
Message-ID: <i2kgeeehfwzwo22vazakcq4at2m223nebb2xfrqfvsgawpmqya@zjhqhjshvhi3>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
 <20250221222958.2225035-2-senozhatsky@chromium.org>
 <20250224081956.knanS8L_@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224081956.knanS8L_@linutronix.de>

On (25/02/24 09:19), Sebastian Andrzej Siewior wrote:
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index 9f5020b077c5..37c5651305c2 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -58,19 +58,62 @@ static void zram_free_page(struct zram *zram, size_t index);
> >  static int zram_read_from_zspool(struct zram *zram, struct page *page,
> >  				 u32 index);
> >  
> > -static int zram_slot_trylock(struct zram *zram, u32 index)
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +#define slot_dep_map(zram, index) (&(zram)->table[(index)].dep_map)
> > +#define zram_lock_class(zram) (&(zram)->lock_class)
> > +#else
> > +#define slot_dep_map(zram, index) NULL
> > +#define zram_lock_class(zram) NULL
> > +#endif
> 
> That CONFIG_DEBUG_LOCK_ALLOC here is not needed because dep_map as well
> as lock_class goes away in !CONFIG_DEBUG_LOCK_ALLOC case.

Let me give it a try.

> > +static void zram_slot_lock_init(struct zram *zram, u32 index)
> >  {
> > -	return spin_trylock(&zram->table[index].lock);
> > +	lockdep_init_map(slot_dep_map(zram, index),
> > +			 "zram->table[index].lock",
> > +			 zram_lock_class(zram), 0);
> > +}
> Why do need zram_lock_class and slot_dep_map? As far as I can tell, you
> init both in the same place and you acquire both in the same place.
> Therefore it looks like you tell lockdep that you acquire two locks
> while it would be enough to do it with one.

Sorry, I'm not that familiar with lockdep, can you elaborate?
I don't think we can pass NULL as lock-class to lockdep_init_map(),
this should trigger `if (DEBUG_LOCKS_WARN_ON(!key))` as far as I
can tell.  I guess it's something else that you are suggesting?

> >  static void zram_slot_lock(struct zram *zram, u32 index)
> >  {
> > -	spin_lock(&zram->table[index].lock);
> > +	unsigned long *lock = &zram->table[index].flags;
> > +
> > +	mutex_acquire(slot_dep_map(zram, index), 0, 0, _RET_IP_);
> > +	wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK, TASK_UNINTERRUPTIBLE);
> > +	lock_acquired(slot_dep_map(zram, index), _RET_IP_);
> 
> This looks odd. The first mutex_acquire() can be invoked twice by two
> threads, right? The first thread gets both (mutex_acquire() and
> lock_acquired()) while, the second gets mutex_acquire() and blocks on
> wait_on_bit_lock()).

Hmm why is this a problem?  ... and I'm pretty sure it was you who
suggested to put mutex_acquire() before wait_on_bit_lock() [1] ;)

[1] https://lore.kernel.org/all/20250206073803.c2tiyIq6@linutronix.de/

