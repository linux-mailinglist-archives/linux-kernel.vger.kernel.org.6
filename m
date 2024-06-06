Return-Path: <linux-kernel+bounces-205139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6AB8FF7F5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731C61C236C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F19713DDAA;
	Thu,  6 Jun 2024 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTAVzUDP"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1C513DBBE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 23:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715498; cv=none; b=IXuYBADsimEnfIYRLo4ClCaRgix108FkIlDohnvSuQkghjo+4c2VMQfB0e1bjhKM4en9OiOZEzrJi5MkB031Cr8qBBmF3WArXl2HulB44XTaCjeTmt/1NWbwlf5kXAIUNPrTwVMKJZUEc/w0/0KGPi6HbIAZ63GoLXrzeLUZLO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715498; c=relaxed/simple;
	bh=q+3KPt2nJvf1TgYW57/HxN+zoujEHesZU8KKVd4ivnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmlUTIXhQDPr81Dts8zVrcrczCyYEEABDJGdxQ2W3vzAJ/NrqOXZ9W8pDfi7x9bADAuCzjBKRW+Jqlfug65rl4H+ArRwSQh1yjCjTX2MpNKpMXVl4+xoUsZWDNAeca4AF36LXmTOv7XGEhEj3x/R96Wj4AqBwhepRCLziJT13w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NTAVzUDP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so1896783a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 16:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717715495; x=1718320295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+3KPt2nJvf1TgYW57/HxN+zoujEHesZU8KKVd4ivnY=;
        b=NTAVzUDPYYfzE3FIDRBM/Cmodkl/f6IlxK+vhKlIz+GqfWncNAH4E6Vkf4MOi5ukjw
         061SwqhqhT9Vr3HXO5NFcJU36UNnBDYKHs9nqI9HKYIMmmoZl90Qqta6A+U5mAFv9Lw2
         9w8Nst8dvJahjlfj4L/4W3fCv7NMF8JU6neUV8InC4Z6euqjp2iSqu+N2CAI+ZYg2H3P
         7xComUas08VJKd7r5u430EhSHh4O81I6pW18XxJoFJNfSDOT3TEwcl/DUWC6BRRYzxiZ
         3bYNO/JMaYYUtVpzL58Q2Ni00UaGgCy1v2K6/iH2D4+ZTCOmcwdr6dChpMvh2UtRunSs
         CltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715495; x=1718320295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+3KPt2nJvf1TgYW57/HxN+zoujEHesZU8KKVd4ivnY=;
        b=PlfPar29GvVYaGCM2eKabDPZJNw8Gto9tFo4ocw0GW+moVDqP/7jPYLxo/gW8KCSM2
         c5Iafn7RgtzThI+DTMyg6FsvTe3rNIaAcq7SOd5zEsSHR8vPYylJby7Gl3wiTKZvo9ne
         iJNXGJ+EwE+eAzQM67eLI9JekfSvRl+QZ7FkGnp/lmKuiM+CrN+xzuoGcKFMEja9aiMv
         o1caIePANk87negu6eh33OUbXa4xwKCMq1u/YOZ77rLNnkE/1TqpOOM7962gC7ELbrB2
         hLjNk6WI3aVi98ixbqs5Gs5eUnbRmxMZScGxqfxIVtZJo3pANFIOr1U4owo/WdbZlUcX
         rXHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpN5RsTiuvUhZGuiecfyaSvix1PGYiClf6sMQCPNxnHRHOzSHM5U9HzuaP+DfA7uakz9Jc0jV/PXaw2P69fUVGOPDmpdk6Q4AyzVME
X-Gm-Message-State: AOJu0YxGbuLy/h7Paprf25iVU4C4GdAZww0aCgkU4GLjkMQ9gomZhED3
	ulk39LU9auYZ3vF3a67tRYDbL7GGmLFLtooiJHg44kSsY3XdTooyRDcNsamkcK+3Rt4Vsd44FmP
	RyP5uIfhebieEhrtqZDyFR9xBN7wYL+/BGZJcSAyYYFv6djCp6YtK
X-Google-Smtp-Source: AGHT+IFNiFFnhENwqOI+298n5J5418oaFJcQaIba1KTvkhnfSk8Pre1KoxQy4qsGY35MzxINLXH7AW0DYULAth/OFgc=
X-Received: by 2002:a17:906:694e:b0:a68:d2c:2a23 with SMTP id
 a640c23a62f3a-a6cdc0e0f9dmr54481066b.76.1717715494736; Thu, 06 Jun 2024
 16:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604175340.218175-1-yosryahmed@google.com>
 <ZmI573n9-SoK4dIg@google.com> <CAJD7tkbO+ZLdhs-9BpthztZX32i8C4=QEnoiXGS7bM399nqwzg@mail.gmail.com>
In-Reply-To: <CAJD7tkbO+ZLdhs-9BpthztZX32i8C4=QEnoiXGS7bM399nqwzg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 6 Jun 2024 16:10:58 -0700
Message-ID: <CAJD7tkYtZPv26raSsXZrn=t_P8=6A0QCfgSjBjq_WRDu=BntLA@mail.gmail.com>
Subject: Re: [PATCH] mm: zsmalloc: share slab caches for all zsmalloc zpools
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Vlastimil Babka <vbabka@suse.cz>, 
	David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, 
	Erhard Furtner <erhard_f@mailbox.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Chengming Zhou <chengming.zhou@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 4:03=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Thu, Jun 6, 2024 at 3:36=E2=80=AFPM Minchan Kim <minchan@kernel.org> w=
rote:
> >
> > On Tue, Jun 04, 2024 at 05:53:40PM +0000, Yosry Ahmed wrote:
> > > Zswap creates multiple zpools to improve concurrency. Each zsmalloc
> > > zpool creates its own 'zs_handle' and 'zspage' slab caches. Currently=
 we
> > > end up with 32 slab caches of each type.
> > >
> > > Since each slab cache holds some free objects, we end up with a lot o=
f
> > > free objects distributed among the separate zpool caches. Slab caches
> > > are designed to handle concurrent allocations by using percpu
> > > structures, so having a single instance of each cache should be enoug=
h,
> > > and avoids wasting more memory than needed due to fragmentation.
> > >
> > > Additionally, having more slab caches than needed unnecessarily slows
> > > down code paths that iterate slab_caches.
> > >
> > > In the results reported by Eric in [1], the amount of unused slab mem=
ory
> > > in these caches goes down from 242808 bytes to 29216 bytes (-88%). Th=
is
> > > is calculated by (num_objs - active_objs) * objsize for each 'zs_hand=
le'
> > > and 'zspage' cache. Although this patch did not help with the allocat=
ion
> > > failure reported by Eric with zswap + zsmalloc, I think it is still
> > > worth merging on its own.
> > >
> > > [1]https://lore.kernel.org/lkml/20240604134458.3ae4396a@yea/
> >
> > I doubt this is the right direction.
> >
> > Zsmalloc is used for various purposes, each with different object
> > lifecycles. For example, swap operations relatively involve short-lived
> > objects, while filesystem use cases might have longer-lived objects.
> > This mix of lifecycles could lead to fragmentation with this approach.
>
> Even in a swapfile, some objects can be short-lived and some objects
> can be long-lived, and the line between swap and file systems both
> becomes blurry with shmem/tmpfs. I don't think having separate caches
> here is vital, but I am not generally familiar with the file system
> use cases and I don't have data to prove/disprove it.
>
> >
> > I believe the original problem arose when zsmalloc reduced its lock
> > granularity from the class level to a global level. And then, Zswap wen=
t
> > to mitigate the issue with multiple zpools, but it's essentially anothe=
r
> > bandaid on top of the existing problem, IMO.
>
> IIRC we reduced the granularity when we added writeback support to
> zsmalloc, which was relatively recent. I think we have seen lock
> contention with zsmalloc long before that. We have had a similar patch
> internally to use multiple zpools in zswap for many years now.
>
> +Yu Zhao
>
> Yu has more historical context about this, I am hoping he will shed
> more light about this.
>
> >
> > The correct approach would be to further reduce the zsmalloc lock
> > granularity.
>
> I definitely agree that the correct approach should be to fix the lock
> contention at the source and drop zswap's usage of multiple zpools.
> Nonetheless, I think this patch provides value in the meantime. The
> fragmentation within the slab caches is real with zswap's use case.
> OTOH, sharing a cache between swap and file system use cases leading
> to fragmentation within the same slab cache is a less severe problem
> in my opinion.
>
> That being said, I don't feel strongly. If you really don't like this
> patch I am fine with dropping it.

Oh and I forgot to mention, Chengming said he is already working on
restoring the per-class lock and collecting lock contention data, so
maybe that will be enough after all. Ideally we want to compare:
- single zpool with per-pool lock
- multiple zpools with per-pool lock (current)
- single zpool with per-class locks

