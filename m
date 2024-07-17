Return-Path: <linux-kernel+bounces-254619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA1593358A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1E92839A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519006FB9;
	Wed, 17 Jul 2024 02:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YbHZAYqI"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A4469D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721184829; cv=none; b=kKWC5JJwIwNJpuRLmXrpeauYjRE3zmnk8vgbPB/GAOFbw1Zt70SVnX5O7DmgYSRGmOSIu6n31/ZWKp/CMqyvdqXS8gldtHgaxz0DUf0owjqiLI0COgncYWbxr/fOlWyI09TLgjIlnYup7CaoYJesiQyz1x3J/Y5QdDTMGe12XKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721184829; c=relaxed/simple;
	bh=yEGEQC6kdWCldeHXYChp8fv+9XVImMxRQifNP0QHeHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4SqmRb21QuZ0iCmUgavVDn0qDpBsGXHbFHMS5L3J+euXVcgKp6WC/BnC2AoqFPt7XIswMclwdSk5DKIUA03KdTfOtl/bOREbIPsG9owQC9y0IB92C/MGhK4lNcBnl0NGGcumoTyxX3GG+L2K35ShYZQmO/dsJztJzGKcZhklhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YbHZAYqI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77abe5c709so744312366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721184826; x=1721789626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yEGEQC6kdWCldeHXYChp8fv+9XVImMxRQifNP0QHeHw=;
        b=YbHZAYqI+Yvhg5Vq1uxktW73dA9SDc2FXfmfJWp8FTGqLgk0xF+DLcLKKn+vXg4CJ7
         blmjsKflXSXjRO8xG1XT2O+SnkSgGUB/mS9fy3wbM3D9qUlW/Dx46Eel9enAqa5myaSl
         316c40Kilgv1BW7GiDb6+Nv3ZzmOAC9fbA8EEdB90TM/8l+g7PDjLVOS/7ogUye7aUlB
         dEKy68RevjTHHebHUEoboRy13icPBwU3YGBhWhveZIyGolYA/S+bcFZAe3aucmLgFYpf
         P8TESu3wW2Pk4sFyy0AUJ+kvkyZNNEDHWYt/0i6n3LOSpsJjM0ahITKLG1zywNaK/kKY
         jkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721184826; x=1721789626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEGEQC6kdWCldeHXYChp8fv+9XVImMxRQifNP0QHeHw=;
        b=t6rS6/cfCTiwk17E6vKhuvdceOvb9Md9Bo9NsJPr8TbqLbcUjILdHRR0C0u5PI9sYA
         99oOyluOC1jl/OQoHw3b34/W/cZFfhnYFONuPb0mjmwH/5ZOGypyHxw4eaNRLEDP53at
         +etRai+4BDMTnlmbAp83VJr+p8XN2F2GvQ9OHqZ04N2trb4X6rREu3tfyxMxqzFejxaw
         kk8Y4/wuF9SqQsofIY5i5IYn1lGxjBIPpn7RYSy3L3DVvt/pdUjKDYQn2pjGTIFQe9nG
         DG5mgi8FQRb/AAGc5MnxEdkWN9y+RsKs0zWID5DXHMFF5QmRQwGN41l/dAb47uWtIW7X
         5ILg==
X-Forwarded-Encrypted: i=1; AJvYcCXDpcCo9puX/6bDYTdaTQzt7jv4NMKllC2tFlw4A52ygS86LdnVpF1DXgjIQfgidvY2h/FglWfZO8uWzz0njxIsRtZUk6OO5dZw4kZ7
X-Gm-Message-State: AOJu0Yy13CcGME6ydu1yIN3ORDHme1ibz9CJMPmSxtrVpQqhofDNMNwK
	ygrX6+eMDGan8VU/gsbN5tmwKH9SMt3IHPdL0oRZt8nsGihcZLj7w6k7oTgi5UQQdE9nE2/p2KN
	mZXdP4QGS0p0laPmv9XvvYeEqMMrWXrtDvrvV
X-Google-Smtp-Source: AGHT+IHLCpBENZziitiorcnDoDIwuhSfSKnvt9S11GYpvblphLkDbkyMOFs/ks7fVFpa0wDqc9XixU0eg27USliSloQ=
X-Received: by 2002:a17:906:88b:b0:a77:e2e3:3554 with SMTP id
 a640c23a62f3a-a7a011aa0a3mr20816866b.28.1721184825809; Tue, 16 Jul 2024
 19:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <CAKEwX=NL1gOe9k5+JB8Q-UAoZ4ie8SBGg7XTjaqM7j4-hiHv=A@mail.gmail.com> <CAPpoddefXD1RAjyW2+X_ankGYNpQgY0Y0+xd1yOFgCc_egaX8A@mail.gmail.com>
In-Reply-To: <CAPpoddefXD1RAjyW2+X_ankGYNpQgY0Y0+xd1yOFgCc_egaX8A@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 16 Jul 2024 19:53:09 -0700
Message-ID: <CAJD7tkYnBw-QiGXTb4BPScuS1VePBkuRx1qG8p92zN9TeD+gKg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: zswap: global shrinker fix and proactive shrink
To: Takero Funaki <flintglass@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
>
> > My concern is that we are knowingly (and perhaps unnecessarily)
> > creating an LRU inversion here - preferring swapping out the rejected
> > pages over the colder pages in the zswap pool. Shouldn't it be the
> > other way around? For instance, can we spiral into the following
> > scenario:
> >
> > 1. zswap pool becomes full.
> > 2. Memory is still tight, so anonymous memory will be reclaimed. zswap
> > keeps rejecting incoming pages, and putting a hold on the global
> > shrinker.
> > 3. The pages that are swapped out are warmer than the ones stored in
> > the zswap pool, so they will be more likely to be swapped in (which,
> > IIUC, will also further delay the global shrinker).
> >
> > and the cycle keeps going on and on?
>
> I agree this does not follow LRU, but I think the LRU priority
> inversion is unavoidable once the pool limit is hit.
> The accept_thr_percent should be lowered to reduce the probability of
> LRU inversion if it matters. (it is why I implemented proactive
> shrinker.)

Why?

Let's take a step back. You are suggesting that we throttle zswap
writeback to allow reclaim to swapout warmer pages to swap device. As
Nhat said, we are proliferating LRU inversion instead of fixing it.

I think I had a similar discussion with Johannes about this before,
and we discussed that if zswap becomes full, we should instead
throttle reclaim and allow zswap writeback to proceed (i.e. the
opposite of what this series is doing). This would be similar to how
we throttle reclaim today to wait for dirty pages to be written back.

This should reduce/fix the LRU inversion instead of proliferating it,
and it should reduce the total amout of IO as colder pages should go
to disk while warmer pages go to zswap. I am wondering if we can reuse
the reclaim_throttle() mechanism here.

One concern I have is that we will also throttle file pages if we use
reclaim_throttle(), since I don't see per-type throttling there. This
could be fine, since we similarly throttle zswap reclaim if there are
too many dirty file pages. I am not super familiar with reclaim
throttling, so maybe I missed something obvious or there is a better
way, but I believe that from a high level this should be the right way
to go.

I actually think if we do this properly, and throttle reclaim when
zswap becomes full, we may be able to drop the acceptance hysteresis
and rely on the throttling mechanism to make sure we stop reclaim
until we free up enough space in zswap to avoid consistently hitting
the limit, but this could be a future extension.

Johannes, any thoughts here?

Anyway, since patches 1-2 are independent of the rest of the series,
feel free to send them separately, and we can continue the discussion
on the best way forward for the rest of the series.

