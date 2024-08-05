Return-Path: <linux-kernel+bounces-274583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C23947A56
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BF91C21260
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7F7154BE8;
	Mon,  5 Aug 2024 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5n+JJdv"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247841311AC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857106; cv=none; b=qxchegE9622GNlPm/V2c0Fjk7+YUS5gAb/mEVvbWViZUiY/KrAYYMWLwypDZ2B9iNJxTFqm2fLuF2ay64AowkU6XAw7T7jYnxhRNeXCWWZSv9IUTijkI+p6p73nR5q6q3dmADyObEYLhZUDQsH6ibqz4hLqYA47enWfi9Fi3Wec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857106; c=relaxed/simple;
	bh=BPBVFhvC1ssZoVdGCw5gKfHc/rn6kVLYepwvWVMpm2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbPKaTNL0f/bf2b4GsBYthtILefWuyqzsRpiOed44UGs1USrNKBDiX1JNyybS2kTtPzaB0WqH4JO/6DiidjJGAlmIL+Kpm9j8d7DMnG4HgV6G3wDPrUUrRTS0AxyHoKYagwSNf90M1tzwO5zkkkuGt3btmZDCikACIwohfBzNoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5n+JJdv; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b3fff87e6bso8774764a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 04:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722857103; x=1723461903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFXMf3R67uSoKvDTRLMWNYmM8RYGM52hCNv8M1S6BK0=;
        b=B5n+JJdvB6l2oF0Mkocotk46cf32laS6x0RYFfAL39DTFVG6F84Zn1Pkv1sEnJdVwU
         G+Ml69cl0h8/IZVoW4RRYanaDfrdsQmsdP5m0jkt+Vc9cB6SempVDbGbMLPBvUg1nBsi
         IFQeXYe8DeJ9wGSdUg1otHu+SCqGTUI95qT+8z82JNID5Z6jxfbwHulXEO75ZLD9mLO7
         nLfZWIOL0y2kqOKy2Ke9MR3+pVnTAznFqcCS9Z8/i+SbjI0DlIFm7qqDEhIGgM6FwbGw
         9kbFgIvQzb7xkYj+16VAhROhz55c2ohFiigw7yAZYMI1vvyCtkywC0UzA7KZbH6Fp03s
         CyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722857103; x=1723461903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFXMf3R67uSoKvDTRLMWNYmM8RYGM52hCNv8M1S6BK0=;
        b=aMNJlaCwZ4tkjUjvoH1G0uJeX1IivfAZ9iRF2MReBWrh5nMUJobCjfOJ14fwvT9SEA
         PB0912tpYdE0waBFYVPeEAsZ/m3wpTvZ2D71ybE4bEc6TTWLJsK//CK03+WYg8pCMWDf
         cKdc31FUIpy31bJfanBZxmNcoM1ESAwbl0KnJ4LF/ZVTfD8PFRtuGbXGCAJiAHZAZ1MC
         9F8aVec8YztnKw521h7sLL868Vw65nvOjDakX6EdrwfeLQy9aQv7nqiJb35AhCO9FbE1
         Oem32bkFJQzxHX2hYcdOZiugs8u6JJpK3XJUdV8PHEPNLsPFgB5v7d+x0kZQdNFfwSuk
         uJbA==
X-Forwarded-Encrypted: i=1; AJvYcCVdRFjkqH/b/l/dG2CUllx9qJY2k3fV/rROnjWXn9ST74/bhGztk02jTmVyrercaQgLldC37WvVV62ew21ZgSS9tsTzZW0/y7Ygr6v2
X-Gm-Message-State: AOJu0YzuVp/B2u66Do/l/UIaWPIEVH1gs+Q30JcwWCHPg2eLiGVWR8iw
	H+Q2bloAfLdu4fLrSyX1ndhY7jQZRsSz6c58AitaZki+OzQWJ+dR
X-Google-Smtp-Source: AGHT+IGl8zJrqXM61TCZr9PNc5KrvF91rHZl3Bz/6P2UyX7/YL/NskRppOIpo9ppHmlXkpyGCOKB0A==
X-Received: by 2002:a05:6402:a42:b0:5a2:cc1c:4cf0 with SMTP id 4fb4d7f45d1cf-5b7f36f59ffmr8021608a12.7.1722857103095;
        Mon, 05 Aug 2024 04:25:03 -0700 (PDT)
Received: from f (cst-prg-90-207.cust.vodafone.cz. [46.135.90.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83a14ea04sm4789153a12.49.2024.08.05.04.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 04:25:02 -0700 (PDT)
Date: Mon, 5 Aug 2024 13:24:49 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: Error out on duplicate cache names when DEBUG_VM=y
Message-ID: <zkiaatyjqk4p445wi5wz5oztzxvcanp5lbnmt54pa3cmvqibi6@4r4e7evtclwe>
References: <20240804212839.685795-1-pedro.falcato@gmail.com>
 <CAKbZUD0hBFeMm=Rwb1LX6MYEpLK_qAnr8jfczLzY8V-DKEDn4w@mail.gmail.com>
 <cdc52bd0-dac8-4f3e-bd7b-aca7513a0464@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cdc52bd0-dac8-4f3e-bd7b-aca7513a0464@suse.cz>

On Mon, Aug 05, 2024 at 12:38:29PM +0200, Vlastimil Babka wrote:
> What about module unload/reload with a SLAB_TYPESAFE_BY_RCU cache that will
> delay its freeing. Soon also if there are kfree_rcu()'s in flight. And the
> zombie cache can stay also permamently around if it fails to be destroy
> because some objects were not freed.
> 

It should be an invariant that the cache is fully whacked by the time
kmem_cache_destroy returns, at worst with the exception of when leaked
items are encountered (but even then it should be renamed to something
indicating it is defunct).

Suppose a cache could not have been destroyed and was left as is, then
the offending module was loaded again -- now you got two with the same
name, which is not that great either.

I find myself quite surprised that kmem_cache_destroy can return even if
cache destruction is still pending.

This was added in 657dc2f97220 ("slab: remove synchronous rcu_barrier()
call in memcg cache release path"), citing batching benefits for
frequent kmem cache creation/destruction.

I believe the very notion of doing that *frequently* is b0rked and any
code doing it should be patched to stop regardless.

Even so, if there are any benefits to the committed patch, it perhaps
can be augmented so that the kmem_cache_destroy caller can wait for the
entire thing to finish (e.g., with a completion).

