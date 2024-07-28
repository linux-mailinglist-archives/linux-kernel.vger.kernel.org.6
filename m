Return-Path: <linux-kernel+bounces-264867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E7493E977
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 22:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676681F21544
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66BA7580C;
	Sun, 28 Jul 2024 20:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IYo4nPou"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A2210FF
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 20:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722200089; cv=none; b=K2shbtqKUi1YRrcVwS+KW+8jvl3QFZl4mQiTGVjVuIp8M1uIKBeEfFq5EoE1UyG5sldVsmuiNKhPLd9g3u7apkvpOy7KjCv210+QVqCKTLW47Imk0SqrB9NsO6lcDDyA8zOOxWUiUYIxMJiL5YSi1k+QMFpK210tvi1jUDO+0ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722200089; c=relaxed/simple;
	bh=MAU1ikI6v16DyZvdLv0S92uOhVuGjagitvH5oKp7HDY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=K0r24amQcXZ95hHclbY1I7Aw4nmqbLdT7f7xRahubqLfjiqweAoQmLZXA75/mAR/KbO6ICKNh82/CuPA5TZFbJ69OTVkQFJQNylta6PAm7BxvJxCjsdiKPwtNFgFc7SpImYcy7Y06lGIaXzEapWEAR33+ixt4MJMYH4eQJQwTvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IYo4nPou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C528C116B1;
	Sun, 28 Jul 2024 20:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722200088;
	bh=MAU1ikI6v16DyZvdLv0S92uOhVuGjagitvH5oKp7HDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IYo4nPouf6CpSTVS2ELBpRlKJMUdykEzMfkhbAbpA+vRb8qD8b8LWb7kYIX5MuMX/
	 9VsqbDF5t7OpvjFDSY1cEhfxL1tTezkzfnotFa29dw905pMyKHY4sMZVSAfzkZ/6PG
	 KQEewi5etss8oZyoxSb63zvB542jhqZwDayi2JU0=
Date: Sun, 28 Jul 2024 13:54:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Shakeel
 Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v3 3/3] mm: page_counters: initialize usage using
 ATOMIC_LONG_INIT() macro
Message-Id: <20240728135447.bd5f7b44e1b7a583bfaaee36@linux-foundation.org>
In-Reply-To: <20240726231110.GF1702603@cmpxchg.org>
References: <20240726203110.1577216-1-roman.gushchin@linux.dev>
	<20240726203110.1577216-4-roman.gushchin@linux.dev>
	<20240726231110.GF1702603@cmpxchg.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 19:11:10 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Fri, Jul 26, 2024 at 08:31:10PM +0000, Roman Gushchin wrote:
> > When a page_counter structure is initialized, there is no need to
> > use an atomic set operation to initialize the usage counter because
> > at this point the structure is not visible to anybody else.
> > ATOMIC_LONG_INIT() is what should be used in such cases.
> > 
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > ---
> >  include/linux/page_counter.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> > index cf837d0f8ed1..5da11392b382 100644
> > --- a/include/linux/page_counter.h
> > +++ b/include/linux/page_counter.h
> > @@ -53,7 +53,7 @@ static inline void page_counter_init(struct page_counter *counter,
> >  				     struct page_counter *parent,
> >  				     bool protection_support)
> >  {
> > -	atomic_long_set(&counter->usage, 0);
> > +	counter->usage = (atomic_long_t)ATOMIC_LONG_INIT(0);
> 
> Pretty cool that ATOMIC_LONG_INIT() return value needs a cast to
> atomic_long_t! ^_^

That's because this wicked patch passed in an `int'. 

	counter->usage = ATOMIC_LONG_INIT((atomic_long_t)0);



