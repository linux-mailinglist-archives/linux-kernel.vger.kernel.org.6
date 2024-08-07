Return-Path: <linux-kernel+bounces-278448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E3094B058
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9091F236D3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8311614534C;
	Wed,  7 Aug 2024 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHf92pUD"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18714389E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057955; cv=none; b=YzGEXSBFcp499t8x+0Wh7SKhLTYUpRJI3ItAYz4Cc63GW42yseAGJaoq3rJEtyHt+JoQZn2h2KzhYPvzkqhl9OVpmfzOlxWfDTqRXXUktLAWx9blq5cTgEQ8rGAe0GZIr9dtQpWe8i3t+nXCGipx6MZVSZNe9PG886rmOQ+0Idw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057955; c=relaxed/simple;
	bh=TZmc//vzgWXo1JCuuQnsejz5TEP5eZApTnDweP28nSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFpm80Bf8cN+A2jT1IpjW6aZo+EbPP0rLDig4qe4LtM4GELZ6stL+r2UISnsLGfU8cdFNcK6bv/w7FumBlt66R07njtFJzg+eUsIYx43dc2vtAxf6qNTW6VrPtFz76U2zzAA212Y3mWu7dfaCdK6BaS2Uor4j+nWziG84IHMXPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHf92pUD; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso4034a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723057952; x=1723662752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZmc//vzgWXo1JCuuQnsejz5TEP5eZApTnDweP28nSI=;
        b=MHf92pUDes+JismALbCqlNH50RJcmj4isqGP+zAdSn2RKv+xyCBcJ1kbdrb8zcXbZ/
         x63+SbcnFaWUAno8v4ZmUXUZeyluG0dM9JnkF8WRWZy/PhEq6MKEO4kgjiKm1pkMVG6g
         tSvt9B9mHnA/URvLlXA4b/DjWsNinSfxo+V31MeTQA5n7fjPPywjG9VZhY59qIpja/Bh
         SkypbhXBJLnd9QZir09qucOwq8eNkDplkkg0732/NENCGveVFL8o7VepP/khm76Do2wj
         dGEHjx2LYx7RXdU0h9s3cm1oE+IIsTUgaDd8SmL+HGMaBUihP9oRg7UfG2+0sGmOhFpz
         9yYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057952; x=1723662752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZmc//vzgWXo1JCuuQnsejz5TEP5eZApTnDweP28nSI=;
        b=a0CTrS8dltuxtEd2nrfaDsYZDns+/mvZKstMXDiznIGriW+r3Hcbh9nIy/RHsXSYki
         0STnsOdNcCSMFyYs4mRy++YL0PuH2JlfEGKU94ZSsGp7yM3l2lgzC3oquM/wgJy/ApzY
         //qrr5H09NHABaXyB4HSF3LtvGWevDRtpS/FSxelGrRN+qgGB8eVNV22fzlIH15AoDmK
         dIXCrE+sVDlJsUDxXHujwyIOAXoinzOVxd0qOmvmhzkc/i2nYwV2qsyleE2XUdwCV2Z1
         cOhujsI3pxnuHHMogyQ6l0bQK6Lyct2va46nZ7ZkC2RxNl9d3i2Y9lBIvbvx0CvqZkXA
         AI6g==
X-Forwarded-Encrypted: i=1; AJvYcCXmyylhhS+uTXNW4Lv1Z1evt9+vyO7Jfv+7Bu6NCyeA00MJYdCHBp7H3Uh5x4vF1CAXurYpC/F44uhJ1nJXg55ml4d1Cb4Gjqfj1Kp9
X-Gm-Message-State: AOJu0YwCGE/fsYn7ssJ4J8DZ4/77qFU9pB8tfBt+Pg7bKIr52sKTAkkQ
	BgDTmh6MQPhEZJZB3zX4BJhue5+BHRRnGh6pLu/G9MURHiMxwKxyEO+llxBG0iF5TrtfKQA1sVb
	HG0XKk7U001/uEjV98U0knzzQmyqTQu8nYgMG
X-Google-Smtp-Source: AGHT+IEWsir3HEKnOjK+rBAIzUOG5Z3eD6jzI+A9vec1Y+JEUjH8OsnE80fEMcreoSJa6HiGM0YfubeWsAYKupDvuRU=
X-Received: by 2002:a05:6402:254b:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5bbaff955fbmr27180a12.4.1723057951910; Wed, 07 Aug 2024
 12:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz> <20240807-b4-slab-kfree_rcu-destroy-v2-4-ea79102f428c@suse.cz>
In-Reply-To: <20240807-b4-slab-kfree_rcu-destroy-v2-4-ea79102f428c@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Wed, 7 Aug 2024 21:11:55 +0200
Message-ID: <CAG48ez2jKFXxkMhq-Q7-WNHp_FTYL7yOpCQa8e_yFDm05e3Few@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] mm, slab: reintroduce rcu_barrier() into kmem_cache_destroy()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Jakub Kicinski <kuba@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 12:31=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> There used to be a rcu_barrier() for SLAB_TYPESAFE_BY_RCU caches in
> kmem_cache_destroy() until commit 657dc2f97220 ("slab: remove
> synchronous rcu_barrier() call in memcg cache release path") moved it to
> an asynchronous work that finishes the destroying of such caches.
>
> The motivation for that commit was the MEMCG_KMEM integration that at
> the time created and removed clones of the global slab caches together
> with their cgroups, and blocking cgroups removal was unwelcome. The
> implementation later changed to per-object memcg tracking using a single
> cache, so there should be no more need for a fast non-blocking
> kmem_cache_destroy(), which is typically only done when a module is
> unloaded etc.
>
> Going back to synchronous barrier has the following advantages:
>
> - simpler implementation
> - it's easier to test the result of kmem_cache_destroy() in a kunit test
>
> Thus effectively revert commit 657dc2f97220. It is not a 1:1 revert as
> the code has changed since. The main part is that kmem_cache_release(s)
> is always called from kmem_cache_destroy(), but for SLAB_TYPESAFE_BY_RCU
> caches there's a rcu_barrier() first.
>
> Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Jann Horn <jannh@google.com>

