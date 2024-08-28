Return-Path: <linux-kernel+bounces-305462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA7D962F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2C11C21CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563E41A76BB;
	Wed, 28 Aug 2024 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UnDikNKm"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170501A4F38
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867919; cv=none; b=jFad/2SRjH6Y9DCWNEJ60Fb6kLM5KL9tkV3iPTVYCHyhX/b31jGi13E2VeKY7YyLWmVgyH4yfnH8vhM8owo68v+PUqWE9OCiDbRZZ4opEnfQYQqLyTlq+xvFKBnfIWr4+QIwtmFJsi75whxX95s6CGEZKwUAW0a5ySMnYyGS9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867919; c=relaxed/simple;
	bh=5HfJVoZUf09/yyuSOEaoOPwo1/GxAhoJbnY8gPaxN5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFO7w13WwVfVFBbJEgUfU+D30J5fdlJJfEdcz4Yx0y0AhgKBCB8fT/Q9wTOREyTsLnTWXwbp6WVRmTkXg1XIQMvlkJhKl3vtgaO4k90EJ6sBMTDn5qayJWh8yi/fG3/Qtg1UIcve+DuJVZGaBrb0lDnv65iv9E0DanudgnFzbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UnDikNKm; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-45029af1408so22161cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724867917; x=1725472717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GV5dbJzassVE92Ckkqje6sBzWbYCfklUNPbX30/kMzA=;
        b=UnDikNKm9FnpJysjhjq1+aiSze3y/qbtK8R/4gurBq2i0hcCXRQTi9bZE0tS4C1NDr
         ur8cN4xFXl97lo2fPrXEvALQy5/h4fP5Dptr/+dKB5LQleJ3TKApTgDsd4LAEBs0+WmQ
         i3pKR3dI5akQujm8wFaytZDMRBx4bmtpS2t8ubgy/ktIOHlpX2+1H9kN1J+uQtBy6YzJ
         su9B7xoEU462O4BY2nFKB3apSFHgjrNDA51FToQICrLfI5aieDUZTILW+SYmg4FqItCx
         WPxaghP8nESrZ3atXPZ0MujI+1SHJeYqaeIjB5LvhEDHF7recsq3MPYKiOHOvDcsaAfc
         OfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724867917; x=1725472717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GV5dbJzassVE92Ckkqje6sBzWbYCfklUNPbX30/kMzA=;
        b=qsODXvLdpIdQW9GnihrXydK9cIb15zuqo2BGOYQih3vR+50/mobRzroth0MIsqcQUS
         rH7fyF3CWne8lJlc4+awnc89qmsT1cmERQf33m/ueHDp+I4tuPi4DVqwCBZ+fc6XNK6r
         jn4X7SrPjN1GcEWotrHUJg7PqN7YFmDKfKxJIsTbzBhJN9Fjx4qkD/87h7RxtA+s+8XP
         X5YrubG66TE7Yvp6ljhd8hPI28BgOI1qf/wBcHEH20Y6x0yHG8Y77SwRDfA6lt3KXoEW
         qPxiFcligXkSVgFm5jg+Zqx5eDQcUaw0SGo936cHOWUQuOgPN2VEf2BVSKnY4yJI8YSi
         fjSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQi2xEy03jTiSZ6zL+YRVWXjGprXHcFSYtOMJuPfQ2JB9VJBquL+TQKaqViLku0fHAs553yb1irJk2D5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFx+u3+jGZcotS0OefyJ1eZ+pINdZgm9kg7J2mPEs2cU/6nGjm
	9pNqvbegKfqeWlCmQhfn5r5fqlZ24VcA/zpRDgWetMQYlgcBaR+yGF/2ojmHzxd91EN5ntMXBaQ
	ty7LOoLGp40/5ilSE5l2vsZgTDFPhHih5v3j8
X-Google-Smtp-Source: AGHT+IGVPYdTHR5UwWuRVhw4md8Wv5OEpWr/gP/bx0HY4TvrXmMLFX6yrNpCmoZP/otzyEYzbYJw4zSUNRD68rtuOrA=
X-Received: by 2002:ac8:7e47:0:b0:456:7ec0:39a9 with SMTP id
 d75a77b69052e-456801069e8mr39051cf.5.1724867916761; Wed, 28 Aug 2024 10:58:36
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827230753.2073580-1-kinseyho@google.com> <20240827230753.2073580-3-kinseyho@google.com>
In-Reply-To: <20240827230753.2073580-3-kinseyho@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 28 Aug 2024 10:58:25 -0700
Message-ID: <CABdmKX3vOnjrLyZ1BMJ27cMU52+gPKWAYE+OrkeC5JLehS8Zaw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v3 2/5] mm: don't hold css->refcnt during traversal
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:11=E2=80=AFPM Kinsey Ho <kinseyho@google.com> wro=
te:
>
> To obtain the pointer to the next memcg position, mem_cgroup_iter()
> currently holds css->refcnt during memcg traversal only to put
> css->refcnt at the end of the routine. This isn't necessary as an
> rcu_read_lock is already held throughout the function. The use of
> the RCU read lock with css_next_descendant_pre() guarantees that
> sibling linkage is safe without holding a ref on the passed-in @css.
>
> Remove css->refcnt usage during traversal by leveraging RCU.
>
> Signed-off-by: Kinsey Ho <kinseyho@google.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

I found a different place where a more trivial css get/put pair than
this could be removed, but I couldn't measure a perf difference. Like
Yosry, I appreciate the simplicity gains here though.

> ---
>  mm/memcontrol.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 35431035e782..67b1994377b7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1013,20 +1013,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgro=
up *root,
>                 else if (reclaim->generation !=3D iter->generation)
>                         goto out_unlock;
>
> -               while (1) {
> -                       pos =3D READ_ONCE(iter->position);
> -                       if (!pos || css_tryget(&pos->css))
> -                               break;
> -                       /*
> -                        * css reference reached zero, so iter->position =
will
> -                        * be cleared by ->css_released. However, we shou=
ld not
> -                        * rely on this happening soon, because ->css_rel=
eased
> -                        * is called from a work queue, and by busy-waiti=
ng we
> -                        * might block it. So we clear iter->position rig=
ht
> -                        * away.
> -                        */
> -                       (void)cmpxchg(&iter->position, pos, NULL);
> -               }
> +               pos =3D READ_ONCE(iter->position);
>         } else if (prev) {
>                 pos =3D prev;
>         }
> @@ -1067,9 +1054,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgrou=
p *root,
>                  */
>                 (void)cmpxchg(&iter->position, pos, memcg);
>
> -               if (pos)
> -                       css_put(&pos->css);
> -
>                 if (!memcg)
>                         iter->generation++;
>         }
> --
> 2.46.0.295.g3b9ea8a38a-goog
>
>

