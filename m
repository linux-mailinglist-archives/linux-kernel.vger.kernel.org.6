Return-Path: <linux-kernel+bounces-312683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A3D9699C4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8AA281A04
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED621AD26B;
	Tue,  3 Sep 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ac/w9/e3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qWzN5Nqt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAC51A4E9D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358191; cv=none; b=a7DF1XzbCI+mGCj3J/j3vBC1yJJP0SfIYBuooFlgykO9271HKbGGuNwFNILGVuupBCyzNZBhQmoYEv3fDl8b7lJku1qaWobt84Xu3U2T5b03X75AerB6CzDA88ON2pz5pBpCVnqjrQDo1xgpcfEMNf9jkVz0+IFgSDv3wnyc0ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358191; c=relaxed/simple;
	bh=zcbAF1LeQY3Z4mzr9aFhGjfAtuXkITEdtBy0lyTz3YU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Awt1ugpeEUc3L9NIcJ1Wc31Tlv1vauLaqk2huxa+PnPLbH5prM5/w9MtMbANs6WPpx0fz6kcj6ELTjqv5HQjKzu9ZvOLMd5Uo5tQ4/sKA03+WMnMpYl7z+jXnQ8nQXLJL0hZeainK+oMrGBider6BGiTHPDUpnOzGbyGO6r3rZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ac/w9/e3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qWzN5Nqt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725358187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qtK3fQoj7dHmNLo9cTwXxZhqau9QaTWDDMonT7Mq39o=;
	b=Ac/w9/e3Cs4Bgz+s7ZRij+jfL7wJB5p+d2/ui9ufFT9LaVdOJM4caq/S2jLxoAq+8NkpTs
	4PTqn1IeuP7VcA1hZa5dAlF5qMPATOvrnU+ulfvrqLbW5BUBMwFAXTBtA/rZKX0Bat2QgJ
	10qBCNxO8XlTllK3iM0kOARL8oJOhgSv9wtnP/LxZmhs477R39Di1XzCjia0Mkjp4i89oG
	cKQG/SeJKOE3l1aPEjSQGoyGO7GC7V5Gh/gHBKvImPpmUUYEoChZk/7EaGyCST7/AYGbUO
	T7FUQ0CTKreGlVF+fR9rmf9h/EODrCe/21rW7QzLDBFJZ5Qomo9Kc7HOVJrlVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725358187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qtK3fQoj7dHmNLo9cTwXxZhqau9QaTWDDMonT7Mq39o=;
	b=qWzN5NqtSgjZCfBd51yXxkfu6Am0A4BarquD8KMxu8MUUwTWG++ON/Ncjq9GBg+qNAqXxN
	qqg1Zh+xH6vmleBg==
To: Zhen Lei <thunder.leizhen@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 4/5] debugobjects: Use hlist_splice_init() to reduce
 lock conflicts
In-Reply-To: <20240902140532.2028-5-thunder.leizhen@huawei.com>
References: <20240902140532.2028-1-thunder.leizhen@huawei.com>
 <20240902140532.2028-5-thunder.leizhen@huawei.com>
Date: Tue, 03 Sep 2024 12:09:47 +0200
Message-ID: <87le0982vo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 02 2024 at 22:05, Zhen Lei wrote:

> The sub list can be prepared in advance outside the lock, so that the
> operation time inside the lock can be reduced and the possibility of
> lock conflict can be reduced.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  lib/debugobjects.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index fc8224f9f0eda8f..998724e9dee526b 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -167,23 +167,25 @@ static void fill_pool(void)
>  		return;
>  
>  	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
> -		struct debug_obj *new[ODEBUG_BATCH_SIZE];
> +		HLIST_HEAD(batch_list);
> +		struct debug_obj *new, *last;

Variable ordering please.

>  		int cnt;
>  
>  		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
> -			new[cnt] = kmem_cache_zalloc(obj_cache, gfp);
> -			if (!new[cnt])
> +			new = kmem_cache_zalloc(obj_cache, gfp);
> +			if (!new)
>  				break;
> +			hlist_add_head(&new->node, &batch_list);
> +			if (cnt == 0)
                        
                        if (!cnt)

but it would be more self explaining if you have:

		struct debug_obj *new, *last = NULL;

and then
                if (!last)

> +				last = new;
>  		}

Thanks,

        tglx

