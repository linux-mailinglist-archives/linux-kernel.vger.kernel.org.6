Return-Path: <linux-kernel+bounces-203435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803C48FDB07
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6C21F29034
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6CC168C2D;
	Wed,  5 Jun 2024 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LyLBvvYs"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C0B168C0A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631595; cv=none; b=iYXx2D4XAglQ7SAoMKnTSMRqIdX9pIKSOULdPLcND/rfl51e7Sjc6XW6+qOLg5ikgqk/9J5iiqfa3OhX9gu/+/LvgnCaihbORQeKSstPX2KoLCquizGELG+btWRO/bKSQ04lYOyVn3UbUr+KNf1OoAe3YEQb0mH6HutE5Va8c8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631595; c=relaxed/simple;
	bh=odPagFywCeLVckyJ7u7Ej1gNPxTHuemqTZ9yer+TyAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k44NL+THN4JYMe+8Ow8Or7FDSxEv81jk7Yx3s1FQZV+aRQHTGS2xb2SimJ9k6naxA+lU3Xzx0DIi4xdAxoYr07IQHiwfeaAO0O59C/dd9J5wXtghi0eNeRcqQxLQIzGAD4pGR6TKQxknQ1BIRD0D4nmKiDH0T1kKXyz3sgc1knw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LyLBvvYs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42152bb7b81so33155e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 16:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717631592; x=1718236392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odPagFywCeLVckyJ7u7Ej1gNPxTHuemqTZ9yer+TyAs=;
        b=LyLBvvYs72ZG0wd8n5nNZQVQoeZW2nz9VXT/p3xru9l6wnKF8a3bGC+PkWKQ/GVI1R
         XGE9FH1VQgYmKhdC3JkpBymc04QBqhm81fUflG7TqXlaySzc+nT7/167CAU+PsjafHNf
         hFrKMGqvOykbrQtvzFkNAxFQJ+qCz0sDrN6fEKI3XFBr+6ApkZtVdNaPlFg1/+n/zjhn
         VOuXqXC6VbK42yQieaG65zxBANarFwYR4H+mUpvTjuNKdvOv3zFx6hhW0iSnbGr+eWGM
         TO4iYmfl3i8L2cO5ytp3b2av25whBqDFVPuPe+P6+VMk+VLK7zJ0aUOu4GUSb6O7X7sl
         y0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717631592; x=1718236392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odPagFywCeLVckyJ7u7Ej1gNPxTHuemqTZ9yer+TyAs=;
        b=cnmjPMaug1gp71jtXet+o8OGrGb3dF6DborTb4v/+9//Tw/QajIP9GeevkLeiN9mOS
         /PqfGmHambPRgP1fRaMH08Lzr3R1pMhIDrPhWRVBITpQAb2xrFq7TpEoCJTpxXS0dWy/
         yKGiFa5IdDc3J3Ar3DKMbLqppK5966HdD65HaA8BeCgCV35YjGyP+9ZX8RMqL4x+tcal
         o6iTrrw9yTVTjymlB/yMZklGachE9TbNoYupYqbTcPw6sQtMHNj/2roVa+0NYo7RLSc7
         Ezh7APj4rQk3jwxAyLpodBAY4YgUBznLMbDOvwAOyfbe1FOukUGE7SpboiQhsj/1r4VN
         e2tA==
X-Forwarded-Encrypted: i=1; AJvYcCWO8jxLbbyj1vhe02c/omLICCnIB2c54LMecUMIOLudTZZSzlkRcOVxuLVxXIU0WFHYnXqtBAbazWZm12SkHjzLIm0au0rvRrXqg56N
X-Gm-Message-State: AOJu0YxfU8lOnNci0gPNQaTnhIUSFOvUBoZ/4L6mNruQT6bZBnZw1tL1
	4t3NVE4w5xO3bBhXfY1rZfB1E4AHeCk0XlcjS/zFsa5CXlZSP+0Boz48B6HZlBVF3HeoCfRILix
	yiLADWKQoBZl/lXYQUTe0ACDObFcP+iA9XCHL
X-Google-Smtp-Source: AGHT+IFaz0i8cgEfY0DYlrzEKrDKTNo5RklXtakhOCYBmYhqAaimHaovnYvcnFQZUHdgJHAfZ9A9l/1Vg2XhMu6EH+c=
X-Received: by 2002:a05:600c:3ba9:b0:41c:ab7:f9af with SMTP id
 5b1f17b1804b1-4215c0da3e7mr514005e9.3.1717631592034; Wed, 05 Jun 2024
 16:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508202111.768b7a4d@yea> <20240515224524.1c8befbe@yea>
 <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
 <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
 <20240602200332.3e531ff1@yea> <20240604001304.5420284f@yea>
 <CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com>
 <20240604134458.3ae4396a@yea> <CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
 <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
 <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
 <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
 <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
 <20240604231019.18e2f373@yea> <CAJD7tkYq5u7B+0UH2XKpeWJnUxoO2kJ1_XZ2JOgYpyNEVR7u0g@mail.gmail.com>
 <20240606010431.2b33318c@yea> <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
In-Reply-To: <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 5 Jun 2024 17:52:34 -0600
Message-ID: <CAOUHufZ8BTTx1LoXHjHGnzJE9dzyv8EnvhpXMUm0NOt=P5KHVg@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Erhard Furtner <erhard_f@mailbox.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 5:42=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Wed, Jun 5, 2024 at 4:04=E2=80=AFPM Erhard Furtner <erhard_f@mailbox.o=
rg> wrote:
> >
> > On Tue, 4 Jun 2024 20:03:27 -0700
> > Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > > Could you check if the attached patch helps? It basically changes the
> > > number of zpools from 32 to min(32, nr_cpus).
> >
> > Thanks! The patch does not fix the issue but it helps.
> >
> > Means I still get to see the 'kswapd0: page allocation failure' in the =
dmesg, a 'stress-ng-vm: page allocation failure' later on, another kswapd0 =
error later on, etc. _but_ the machine keeps running the workload, stays us=
able via VNC and I get no hard crash any longer.
> >
> > Without patch kswapd0 error and hard crash (need to power-cycle) <3min.=
 With patch several kswapd0 errors but running for 2 hrs now. I double chec=
ked this to be sure.
>
> Thanks for trying this out. This is interesting, so even two zpools is
> too much fragmentation for your use case.

Now I'm a little bit skeptical that the problem is due to fragmentation.

> I think there are multiple ways to go forward here:
> (a) Make the number of zpools a config option, leave the default as
> 32, but allow special use cases to set it to 1 or similar. This is
> probably not preferable because it is not clear to users how to set
> it, but the idea is that no one will have to set it except special use
> cases such as Erhard's (who will want to set it to 1 in this case).
>
> (b) Make the number of zpools scale linearly with the number of CPUs.
> Maybe something like nr_cpus/4 or nr_cpus/8. The problem with this
> approach is that with a large number of CPUs, too many zpools will
> start having diminishing returns. Fragmentation will keep increasing,
> while the scalability/concurrency gains will diminish.
>
> (c) Make the number of zpools scale logarithmically with the number of
> CPUs. Maybe something like 4log2(nr_cpus). This will keep the number
> of zpools from increasing too much and close to the status quo. The
> problem is that at a small number of CPUs (e.g. 2), 4log2(nr_cpus)
> will actually give a nr_zpools > nr_cpus. So we will need to come up
> with a more fancy magic equation (e.g. 4log2(nr_cpus/4)).
>
> (d) Make the number of zpools scale linearly with memory. This makes
> more sense than scaling with CPUs because increasing the number of
> zpools increases fragmentation, so it makes sense to limit it by the
> available memory. This is also more consistent with other magic
> numbers we have (e.g. SWAP_ADDRESS_SPACE_SHIFT).
>
> The problem is that unlike zswap trees, the zswap pool is not
> connected to the swapfile size, so we don't have an indication for how
> much memory will be in the zswap pool. We can scale the number of
> zpools with the entire memory on the machine during boot, but this
> seems like it would be difficult to figure out, and will not take into
> consideration memory hotplugging and the zswap global limit changing.
>
> (e) A creative mix of the above.
>
> (f) Something else (probably simpler).
>
> I am personally leaning toward (c), but I want to hear the opinions of
> other people here. Yu, Vlastimil, Johannes, Nhat? Anyone else?

I double checked that commit and didn't find anything wrong. If we are
all in the mood of getting to the bottom, can we try using only 1
zpool while there are 2 available? I.e.,

static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
{
 - return entry->pool->zpools[hash_ptr(entry, ilog2(ZSWAP_NR_ZPOOLS))];
 + return entry->pool->zpools[0];
}

> In the long-term, I think we may want to address the lock contention
> in zsmalloc itself instead of zswap spawning multiple zpools.
>
> >
> > The patch did not apply cleanly on v6.9.3 so I applied it on v6.10-rc2.=
 dmesg of the current v6.10-rc2 run attached.
> >
> > Regards,
> > Erhard

