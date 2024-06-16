Return-Path: <linux-kernel+bounces-216065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFB3909AB0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 02:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5EF28319E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 00:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E6023BF;
	Sun, 16 Jun 2024 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PBLurXzQ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226541843
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 00:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718497777; cv=none; b=gplviz1DxGu40eFWKbzUQUxlXyxnKxzN7EnTGNYzMX7mZlvRTKr622FAwvLk1FlIXRSFBC/i93Otu+6dPmMrbYEg+iOyvfRo7NaIkivkmXGdW1oGlgHRYT2nYZz1BxDhfZXn+YJXPOy5rWKT6ZL8aOAJbfYcB5fFHC1SvsezQ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718497777; c=relaxed/simple;
	bh=qNl5LLgt0vuIiiJ6TMFbmpOkuklVeUyDfb4sXN4a0OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBmw3K2XDk3xmRNY7m1Tlcxlxmsb+XC7PtEt/vDOQtIObaoVmXZWOT7EuOghndspX2fLd+XzOY5OQT4V4S60j5YRGjvkonicroyfGXjXBckFHSKu8a6OCse4ejq9EE2r6NmDtjMu+7EHnIoyTjpp2K0n2l+QIKRJ8sQzBwSnfPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PBLurXzQ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57cb9efd8d1so4849126a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718497773; x=1719102573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6osgA93aqonamdWRCetYmklZz/MQRCMhpbnjLMTEVVM=;
        b=PBLurXzQlSKYuGalQaaBU96vFqvPdeESrT7sAsTRe/1fwm9IGNA4ENcWStRtgAGTpj
         77oe30+NNquVX8RBfAqhVw8HVruhFi8XR71i1dF78/mV/pvxK0l4MrCdmkkO4jPmpxvm
         tgpb4pyt+DCJmLFSuEB3Y3HjTNHa5s4j+rI3nqzIcfl1ZTFyan6Ds0tqZn1US7NgSnDv
         71gw7C57xwXhvnUuHqF242/t3NkYIt4/vDuJlEHHiJ5JiS/QzHOxQjvmaYiQyv8qStVW
         +9SzTaMW2ayNHBgUA0uChh58cotsiCyj2V9x/h+xAzCDkhO/zsKvYnI5vr6e08P3kfGV
         ylYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718497773; x=1719102573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6osgA93aqonamdWRCetYmklZz/MQRCMhpbnjLMTEVVM=;
        b=TLKpqAuiQE1jnVvoDWxDcy1HffYvc2pk7zOFcNYWzEssInaLOBhxPYD9b23nYha9Qw
         ZY2GHE+KAj5j3i8zhTSPj13tFAkIIP3zy6NaWnnIkdIbqTu9t6+qfppTbkRmWuMrzBww
         FEuRiNN8sCybzv+KY9kjAyza4DDHQeQk2p/xww08AuItVTj+AmftQeYrDgEdOjtJQM7M
         ijSB+5N19mVe5usa6ZCS9uo38DrhItEyhRNE3SIypgcpBd8Qyteyj1XNr3psyBmZiyfs
         8bo/9N3ZgGTar4ddW1Q4XoipUYp3Ui6sQ8m3HtD/L5UdDoePa/jOVBs5ots6L/M+yjeI
         3mSg==
X-Forwarded-Encrypted: i=1; AJvYcCX0JY9uvPO0zc3ZYlU9QGLXfy3fUbZGXdgKKOcWgcCQ1lBO+E0R5Uj1u2hteZ06qL2SHAZk4aLOJNaPewl0j3apQSVthIim1Cl4taAo
X-Gm-Message-State: AOJu0YzeucS8VJC8CLm0zgEbi9g/dWKUVuqhFcmqfHruu+Sd9VUfBm9z
	fuMTiuxbYclCrSozZCmh2+zET61xrsv3/Nf9spF7wdADDFZG80qCUCecby46YPzF4T8rNHFxCC7
	2WGwnKinDD343co8m9EimPRuUowSPVXaTUUEh
X-Google-Smtp-Source: AGHT+IFJkBx3nd5yg5OaSvrh9uB02SksIZKWWRNEuDuxK7lqkOsnjy11XGrHJ8gM7AbgWsB6IRndKfF+kJDUWM3OMAs=
X-Received: by 2002:a17:907:9406:b0:a6f:1727:cf4b with SMTP id
 a640c23a62f3a-a6f608a7945mr504935266b.23.1718497773009; Sat, 15 Jun 2024
 17:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615081257.3945587-1-shakeel.butt@linux.dev>
In-Reply-To: <20240615081257.3945587-1-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Sat, 15 Jun 2024 17:28:55 -0700
Message-ID: <CAJD7tkbpFu8z1HaUgkaE6bup_fsD39QLPmgNyOnaTrm+hZ_9hA@mail.gmail.com>
Subject: Re: [PATCH] memcg: use ratelimited stats flush in the reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Muchun Song <songmuchun@bytedance.com>, Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 1:13=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> The Meta prod is seeing large amount of stalls in memcg stats flush
> from the memcg reclaim code path. At the moment, this specific callsite
> is doing a synchronous memcg stats flush. The rstat flush is an
> expensive and time consuming operation, so concurrent relaimers will
> busywait on the lock potentially for a long time. Actually this issue is
> not unique to Meta and has been observed by Cloudflare [1] as well. For
> the Cloudflare case, the stalls were due to contention between kswapd
> threads running on their 8 numa node machines which does not make sense
> as rstat flush is global and flush from one kswapd thread should be
> sufficient for all. Simply replace the synchronous flush with the
> ratelimited one.
>
> One may raise a concern on potentially using 2 sec stale (at worst)
> stats for heuristics like desirable inactive:active ratio and preferring
> inactive file pages over anon pages but these specific heuristics do not
> require very precise stats and also are ignored under severe memory
> pressure. This patch has been running on Meta fleet for more than a
> month and we have not observed any issues. Please note that MGLRU is not
> impacted by this issue at all as it avoids rstat flushing completely.
>
> Link: https://lore.kernel.org/all/6ee2518b-81dd-4082-bdf5-322883895ffc@ke=
rnel.org [1]
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c0429fd6c573..bda4f92eba71 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2263,7 +2263,7 @@ static void prepare_scan_control(pg_data_t *pgdat, =
struct scan_control *sc)
>          * Flush the memory cgroup stats, so that we read accurate per-me=
mcg
>          * lruvec stats for heuristics.
>          */
> -       mem_cgroup_flush_stats(sc->target_mem_cgroup);
> +       mem_cgroup_flush_stats_ratelimited(sc->target_mem_cgroup);

I think you already know my opinion about this one :) I don't like it
at all, and I will explain why below. I know it may be a necessary
evil, but I would like us to make sure there is no other option before
going forward with this.

Unfortunately, I am travelling this week, so I probably won't be able
to follow up on this for a week or so, but I will try to lay down my
thoughts as much as I can.

Why don't I like this?

- From a high level, I don't like the approach of replacing
problematic flushing calls with the ratelimited version. It strikes me
as a whac-a-mole approach that is mitigating symptoms of a larger
problem.

- With the added thresholding code, a flush is only done if there is a
significant number of pending updates in the relevant subtree.
Choosing the ratelimited approach is intentionally ignoring a
significant change in stats (although arguably it could be irrelevant
stats).

- Reclaim code is an iterative process, so not updating the stats on
every retry is very counterintuitive. We are retrying reclaim using
the same stats and heuristics used by a previous iteration,
essentially dismissing the effects of those previous iterations.

- Indeterministic behavior like this one is very difficult to debug if
it causes problems. The missing updates in the last 2s (or whatever
period) could be of any magnitude. We may be ignoring GBs of
free/allocated memory. What's worse is, if it causes any problems,
tracing it back to this flush will be extremely difficult.

What can we do?

- Try to make more fundamental improvements to the flushing code (for
memcgs or cgroups in general). The per-memcg flushing thresholding is
an example of this. For example, if flushing is taking too long
because we are flushing all subsystems, it may make sense to have
separate rstat trees for separate subsystems.

One other thing we can try is add a mutex in the memcg flushing path.
I had initially had this in my subtree flushing series [1], but I
dropped it as we thought it's not very useful. Currently in
mem_cgroup_flush_stats(), we check if there are enough pending updates
to flush, then we call cgroup_flush_stats() and spin on the lock. It
is possible that while we spin, those pending updates we observed have
been flushed. If we add back the mutex like in [1], then once we
acquire the mutex we check again to make sure there are still enough
stats to flush.

[1]https://lore.kernel.org/all/20231010032117.1577496-6-yosryahmed@google.c=
om/

- Try to avoid the need for flushing in this path. I am not sure what
approach MGLRU uses to avoid the flush, but if we can do something
similar for classic LRUs that would be preferable. I am guessing MGLRU
may be maintaining its own stats outside of the rstat framework.

- Try to figure out if one (or a few) update paths are regressing all
flushers. If one specific stat or stats update path is causing most of
the updates, we can try to fix that instead. Especially if it's a
counter that is continuously being increased and decreases (so the net
change is not as high as we think).

At the end of the day, all of the above may not work, and we may have
to live with just using the ratelimited approach. But I *really* hope
we could actually go the other way. Fix things on a more fundamental
level and eventually drop the ratelimited variants completely.

Just my 2c. Sorry for the long email :)

