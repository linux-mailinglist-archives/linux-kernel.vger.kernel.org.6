Return-Path: <linux-kernel+bounces-291804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B36956721
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695EE282451
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB71915ECC6;
	Mon, 19 Aug 2024 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdtEPasi"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D81515E5D0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060003; cv=none; b=GjqJqZ7onwUQ8Yiypu9BO+nmS8gfmkfPFjkda1HLSLvpgik/El+aJE2bek8bYyQbfitG+Fz9D+PZ7YSDfxMvQ7rHBHzuPEv+qZo1pwmx5Jrdc9JDFStCrv4EiTVoW+pS9aCg6LZCeBXjREkXG4Oy0Y8h4bs19Nr2VLRcblO2kX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060003; c=relaxed/simple;
	bh=/mE3tHXoeEqsb2A5bih7aGZ8MlP73qQqq5xLMkjY6d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoVLnVeIMDYATqreo4ToeWwctAKcHEsGRrx8IAcVKfGac9MPfY6uAIICe3rcotYPqJ6v5DBGqRrwZ9KX5rdJjxpg7s7rs8VNgne7wt7QJGaxsKxW8v07uTQMWr2XpQo8/VV6wRAxg0DGyvmYPKDi17VK69KPZcbcc8hy7OL39CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdtEPasi; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efd855adbso5067809e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724060000; x=1724664800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4J0qnFMOrentkiYGSo1a6B/wDJGaxKW/vSk+dkg0+20=;
        b=fdtEPasiqxfRpNALjYOGjpC47QgkxM+XXChF5LZd6ipjMFKnVzYdSOTqdjW+Z6hosP
         yy0z1ZCUAtqWq1UIH94uGqeclVHWCm0uVehqwWbtyGLQRI3b+a6a990KI75ilv608fh9
         9VlY6fZdtKpjLK3w01La5VXFD3gg/Gd6SZenAxS4onUEyFGUZibko2rFwi7rWsRcXCHF
         aWk/wngb9lcLlloSUQYPjqrYes+VbZDhgyGL0jPfIn4xtRrmF0JcFFQn2Q8Ay9eaEugK
         wiTwECJCGUZ90EXFeIijD8ulEnz0y8hy0Cy6B3R40b3vZ25cQtzDiBN3WNBR+sU04o7b
         1wwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724060000; x=1724664800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4J0qnFMOrentkiYGSo1a6B/wDJGaxKW/vSk+dkg0+20=;
        b=GCYgMFfu8AGwYiRKv2WGAwnwIJ2za5efZrcJrIIItQjMSKX9GpuJhfijA9LV/dA8Ay
         10Aatq2ATeaHb75YBDeu04mjg56TIEpsv7bovF5DRtPoYIQPyWkJLDtG3H5A0KatPYCH
         AF2WQspD4xNSjRT5fCgiwHf/PgoA+lewJCW4WYfX2Ore+pwA1Dv3S7d9xvvc/a8D78xq
         x0Y1WeIvt2oM2nN1hfBFOvBUlNoTfLu9RumFn/wTwM7utxLakcSRqXqNrBf9+VSl5S5y
         2RzRuityscnfaIIr1TcvTeEj9n9lDwy6yqJWzJG9g37M1SSoOrRn7VAKWnrr8VpcmJYV
         4J1w==
X-Forwarded-Encrypted: i=1; AJvYcCWI5mmmPSYh1eyvru39wYXZlnpGFFJD+Gws/VIzOdPuyLGxDPmTrZ7HctAmwnRzANEfBCiRPHe8e7ZP8bHA61uTRk66/HHKOvXd2FFA
X-Gm-Message-State: AOJu0Yxf71Um0kUysr0mWiu/MUTGglTP0ymcfWFbnmdN8n5L0YrkNcVF
	nAm9/8ej5sKKrtVngP8/6iVX3/V861+G7dRns793xfRB6yIIVJSRUgvSIhysAvZhn3JlMqyGcy9
	fvFXQaXxBeW4tDLx1t8Lhrd05/ZI=
X-Google-Smtp-Source: AGHT+IHx7dzPA4pAKBAD59yH9aV6fV05WUH44yrhFBeWZHGXcwnavSQUNf6F0zWGxzXNv1T4Ba0QyG+JyvsZC3YkObo=
X-Received: by 2002:a05:6512:39d6:b0:533:c9d:a00e with SMTP id
 2adb3069b0e04-5331c6ba097mr6053221e87.34.1724059999456; Mon, 19 Aug 2024
 02:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819070204.753179-1-liuyongqiang13@huawei.com>
In-Reply-To: <20240819070204.753179-1-liuyongqiang13@huawei.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Mon, 19 Aug 2024 18:33:06 +0900
Message-ID: <CAB=+i9TxYRcr+ZRMD31SDay+899RXOwTvQevC=8sv7b27ZO1Vg@mail.gmail.com>
Subject: Re: [PATCH] mm, slub: prefetch freelist in ___slab_alloc()
To: Yongqiang Liu <liuyongqiang13@huawei.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, zhangxiaoxu5@huawei.com, 
	cl@linux.com, wangkefeng.wang@huawei.com, penberg@kernel.org, 
	rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, 
	vbabka@suse.cz, roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 4:02=E2=80=AFPM Yongqiang Liu <liuyongqiang13@huawe=
i.com> wrote:
>
> commit 0ad9500e16fe ("slub: prefetch next freelist pointer in
> slab_alloc()") introduced prefetch_freepointer() for fastpath
> allocation. Use it at the freelist firt load could have a bit
> improvement in some workloads. Here is hackbench results at
> arm64 machine(about 3.8%):
>
> Before:
>   average time cost of 'hackbench -g 100 -l 1000': 17.068
>
> Afther:
>   average time cost of 'hackbench -g 100 -l 1000': 16.416
>
> There is also having about 5% improvement at x86_64 machine
> for hackbench.

I think adding more prefetch might not be a good idea unless we have
more real-world data supporting it because prefetch might help when slab
is frequently used, but it will end up unnecessarily using more cache
lines when slab is not frequently used.

Also I don't understand how adding prefetch in slowpath affects the perform=
ance
because most allocs/frees should be done in the fastpath. Could you
please explain?

> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> ---
>  mm/slub.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index c9d8a2497fd6..f9daaff10c6a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3630,6 +3630,7 @@ static void *___slab_alloc(struct kmem_cache *s, gf=
p_t gfpflags, int node,
>         VM_BUG_ON(!c->slab->frozen);
>         c->freelist =3D get_freepointer(s, freelist);
>         c->tid =3D next_tid(c->tid);
> +       prefetch_freepointer(s, c->freelist);
>         local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>         return freelist;
>
> --
> 2.25.1
>

