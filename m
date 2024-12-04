Return-Path: <linux-kernel+bounces-431155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6099E39D5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C179B3A79C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E811B87D6;
	Wed,  4 Dec 2024 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DAVWzc7Y"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C044D1B81DC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314316; cv=none; b=Nm8sYMLQqt6hab+yI7RmHlaDhvnI8JErLTbfepE4Yk2mrBcUGmPrTTqejJgZaYRGG8kMrILnnoPQTMpOIJb8x5SlpwmLl8M6FosFWSO89t2Dhm23h9itVLnOnpy0V71+kwke8TrgtFwX97HYAskv93SGpySlRvBbQ1AQHpguZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314316; c=relaxed/simple;
	bh=bmOv8dHKm+h6YIB+9sGaNR2bD8pKHVQN2XHvFsxAu5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVHoQ6ae1+ZXIgP1NJJpCc7N9vdb37Rauzm80mpCDza/WHaJDROiFT9FsG/UE3xUi1Gdq4X9Lmtk5t6rjzxa27PLeLIcXiow2R0f2AsvUUo3HePB+oPooPtJkbh0AOa2V5YTsHSp5A5Qy8Xuk7d8qFJ6elMXVWslAf7kWSFIHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DAVWzc7Y; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9e8522445dso937452066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733314313; x=1733919113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRFuG3PiOj6PlkwBJ3cIrdG7oQVVs/3CSY6wYR/X++s=;
        b=DAVWzc7YpgRcG/c1qf21BEOXz3zUOFAsd5/0mxgqz1uLcqMZly72NKfb8jzLO9UKoB
         kSl397jU4cJdE3WgzzW2Ho4JQqR0J35fbcGJoayZhERNICCEwnHJhq89eDAgcgKvHkD0
         0qq8EHN83RL6fhYGJmgneabXSQowqPXQH2G7q3STjSvsJ9oUUZ5KnKhvPIUPVxoOIuKh
         0m5cUG/0CLYDJ1oFDFu2vvUfPJGgUFD9thcAPsIwN1Bmzh9Oy+Y2OgBy/dpWzHJdqEQk
         5SfNPaI5cDKxFLqIRP09Zp93j4a6TXR6c1rQXf+BLtgNx0p6j0wLUwtZhiicqoJvPMmk
         xMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733314313; x=1733919113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRFuG3PiOj6PlkwBJ3cIrdG7oQVVs/3CSY6wYR/X++s=;
        b=ZvZS5qfm/oLzJQt/cY2NTjRzJ8xokV3YvwpeIftaTv3Xl37bu8UV7cHW4WpZxO8e7x
         iuIret43NeF7trotFFnGG8S5hFmwQoewe9J4S4Stn7vH+dTdpSqCUa/5w1PYF2wpkEwS
         fbWy5bG8Iv24S26O6PFqEvwrgWSbRnXYpq8jnMHbM8hluylTXOZ3dZLu5vj1tNwZKSnN
         ryruy5PuL4yYsXWaFrgx61PMtomy0oXRzLmomHxKnms1oEFr7+VamtWkpzWTGtmb770F
         iY+6zHiROQOV+jPXNwo5z04ASgj+Rs4F1C15MZ7Y88aIaIKhEBWjeJPd4xHhDWvRk3Yz
         CfBw==
X-Forwarded-Encrypted: i=1; AJvYcCX7lMJWtCBzUdyUhWMY9APAxHs7+Rnk52weg+XoE+7kfY/R+zlG+XajJcSvzIfHntZehiAUJRDoYOE1DBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPRWvy9bL99OFBFonocNvlQN8lj5dlupoilfL1UA0GevtkYuJr
	QLVzscyAPl3vb/cNtafrLT86ivItMWbDXBtVzOLP5GFW6qFDjLq5gteyiBY6lziCjUzVCcP3mJA
	2nGgYpyKdD3vM7+/J/AUmnpt5tKNlbxEKO4Qt
X-Gm-Gg: ASbGncuvYCyV2jE9TOnWyJdH2bIM6EaCGfdMCQE6JuVfi/uCkJ2GbymHk+nAFjwHgOy
	NpqocFNzr9rpXC5bnk/sP9N/kv3jw5Lwq
X-Google-Smtp-Source: AGHT+IE+PewjMa0mEHtyeqwBytsWAUZHirCIUBbwztyT4virh3IT7us/tEMBvPvnKoceSir7uuVYA3UNrowtbDRu9Gw=
X-Received: by 2002:a17:906:2192:b0:aa5:4800:37be with SMTP id
 a640c23a62f3a-aa5f7da96ffmr479877166b.32.1733314312852; Wed, 04 Dec 2024
 04:11:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+ZtxW1HoiZaA2hB4r4+QBbif=biG6tQ1Fc2jHFPWH8Sw@mail.gmail.com>
 <1733310027-29602-1-git-send-email-mengensun@tencent.com>
In-Reply-To: <1733310027-29602-1-git-send-email-mengensun@tencent.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 13:11:41 +0100
Message-ID: <CANn89iJ6PxKf4AbwaXK7cLg8rgeVGe=1WNoPkhrc_etdCo+_XA@mail.gmail.com>
Subject: Re: [PATCH] tcp: replace head->tstamp with head->skb_mstamp_ns in tcp_tso_should_defer()
To: MengEn Sun <mengensun88@gmail.com>
Cc: dsahern@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mengensun@tencent.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, yuehongwu@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 12:00=E2=80=AFPM MengEn Sun <mengensun88@gmail.com> =
wrote:
>
> Thank you very much for your reply!
>
> There is no functional issue with using tstamp here.
>
> TCP does indeed use tstamp in many places, but it seems that most of
> them are related to SO_TIMESTAMP*.

Not at all. TCP switched to EDT model back in 2018, the goal had
nothing to do with SO_TIMESTAMP

commit d3edd06ea8ea9e03de6567fda80b8be57e21a537 tcp: provide earliest
departure time in skb->tstamp

Note how a prior field (skb->skb_mstamp) has been renamed to
skb->skb_mstamp_ns to express
the fact that a change in units happened at that time, because suddenly
TCP was providing skb->tstamp to lower stack (fq qdisc for instance
makes use of it) in ns units.

Starting from this point, skb->tstamp and skb->skb_mstamp_ns had the
same meaning as far as TCP is concerned.

Note how it is absolutely clear in the doc:

include/linux/skbuff.h:762: *   @skb_mstamp_ns: (aka @tstamp) earliest
departure time; start point
include/linux/skbuff.h:892:             u64             skb_mstamp_ns;
/* earliest departure time */

I actually had in my TODO list a _removal_ of skb_mstamp_ns, mostly because=
 of
an unfortunate naming (mstamp would imply millisecond units, which is
simply not true)

Same remark for tp->tcp_mstamp :  quite a bad name, but unfortunately
changing it would make future backports more difficult.

