Return-Path: <linux-kernel+bounces-227695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E9A915599
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C5B1F2457D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF33F19F464;
	Mon, 24 Jun 2024 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ofi53Tf4"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1B019EEDD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250888; cv=none; b=UGNTsPfZ8hzHWKaz4DwFbd9GkFR92gqL46jAqIUlyULcegSGV6Qf5J7uLN0TXTMVzbMkvnV9eCJukJYQRXJWixmn0Qfsn994mVlm7r//s9X8oXQq3zplv4azNLY7P1Ipa/Ak4ToPtrEEGDwQUddNI6HwSx0ZGbjOuGvyd31TO40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250888; c=relaxed/simple;
	bh=6Xy0P0JjsXZxZJicveAS1RvVzevvMoz85YH/ChWlqVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqN2ceHXAH3hSo4xlrWB3eZHNEoo1dp7wKq6qYf3bx18tuRONq0/qvZQ3/zkvOSYGkIWmSHT0scsvfL4OJkvng9Pzmbog3JniBIfve8MEXSI3OpYfRAP+PNLfvpp5tdHLMtUSS+LzwE9WtSgQtBwRljn7s5aMWwCiahxTY7LMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ofi53Tf4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a724b3a32d2so183727266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719250885; x=1719855685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Xy0P0JjsXZxZJicveAS1RvVzevvMoz85YH/ChWlqVE=;
        b=Ofi53Tf4tQog+D8EO7dBIwI1LobLB8+JbK6ZS6iGpbFm+egs+eT0CX1f4glwrewQht
         7IoHMdiGbJxNTIIOvfSCQrSq2/ctWaICOP8U7TdbCkY65G3e83e+0NKaw2wlkJxH1RsG
         EYQyNweZPN95il8VJMgElC6lycs0xX12C5wzE3kOnA0QBE1PREOpTvqyYKxhnUOO04+o
         I+HEKOk7twKHScoEjpbf0UPUq+EuRB0mqRXhQEOcYlICzZQR2442dAxy/Z9htaDFhE58
         aKNtx8RXg/k6CJPVRGWar/5SfBlVfgPfadBMHFifDlt826z20ZTGRUwuRMbUHTYho5jW
         rL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719250885; x=1719855685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Xy0P0JjsXZxZJicveAS1RvVzevvMoz85YH/ChWlqVE=;
        b=FeAYjDP4U+Cx97I0+ZtYM+kQP/fF29TaUJoyiUuOTT45TnEcNk5xehdPK1EdPWqI+S
         /a7dLnucJD3PZzwKdtmuemV8S5Sky6iAqwNwFFfYs0/K3yr+KWRudoJzyxaE/FImyO49
         +pgK9ocKNox18SjqNwj1I/getS2AS8l5rlcCXbdxvfTj1IfWgsiQVvpxZwz+RCd+yrIn
         hrVwwrFgkvkKdcUoEAZhhd+U3GPuXNErL/7NseefBF+vPAwCbuTuR9njY4Sywb/7PUhH
         GFjXUeeKnhYGjkwLyERwCbO/ZzypGPjWgxDxuapqGilTy8vEmmihE08yOlhdhb3M7Skq
         CxEg==
X-Forwarded-Encrypted: i=1; AJvYcCUdNEQ0nAJrukwz8+dH5P+Y7vSefz4ryxqGh2B7WHNhuGoImmqvzYkp0VvLnIznr2S6RoG7F6gJ+eiub/exi1WP+V7MzWbDEEutEZ5r
X-Gm-Message-State: AOJu0Yz8uNSCJltsQ3j3mebajpO0lfRFWiJDkiVRUawZzSMr2s0y5nEc
	cChBGav176BYC28fj8U8bIkL3jSks3nEdvcj0Zy/uHWkEbTDpPk22tI3pSPsDtuEmCrun9xe8U7
	2/qUK4abCYM4wNwl0/DgcrNAQIhtm91FB9RlUljHtCyZWckLkWOFTpzI=
X-Google-Smtp-Source: AGHT+IGN0kwEH305qXkCZ+rKKYQEXLaxOppsohbq8yTWO5V/Fuld5DFcgw2j47k12u8a0vEpENBk57Mi5GklK0CSoKI=
X-Received: by 2002:a17:907:c301:b0:a6f:5f5d:e924 with SMTP id
 a640c23a62f3a-a7245b4c9bcmr439831666b.6.1719250884154; Mon, 24 Jun 2024
 10:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171923011608.1500238.3591002573732683639.stgit@firesoul>
 <CAJD7tkbHNvQoPO=8Nubrd5an7_9kSWM=5Wh5H1ZV22WD=oFVMg@mail.gmail.com> <tl25itxuzvjxlzliqsvghaa3auzzze6ap26pjdxt6spvhf5oqz@fvc36ntdeg4r>
In-Reply-To: <tl25itxuzvjxlzliqsvghaa3auzzze6ap26pjdxt6spvhf5oqz@fvc36ntdeg4r>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 10:40:48 -0700
Message-ID: <CAJD7tkaKDcG+W+C6Po=_j4HLOYN23rtVnM0jmC077_kkrrq9xA@mail.gmail.com>
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:32=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Mon, Jun 24, 2024 at 05:46:05AM GMT, Yosry Ahmed wrote:
> > On Mon, Jun 24, 2024 at 4:55=E2=80=AFAM Jesper Dangaard Brouer <hawk@ke=
rnel.org> wrote:
> >
> [...]
> > I am assuming this supersedes your other patch titled "[PATCH RFC]
> > cgroup/rstat: avoid thundering herd problem on root cgrp", so I will
> > only respond here.
> >
> > I have two comments:
> > - There is no reason why this should be limited to the root cgroup. We
> > can keep track of the cgroup being flushed, and use
> > cgroup_is_descendant() to find out if the cgroup we want to flush is a
> > descendant of it. We can use a pointer and cmpxchg primitives instead
> > of the atomic here IIUC.
> >
> > - More importantly, I am not a fan of skipping the flush if there is
> > an ongoing one. For all we know, the ongoing flush could have just
> > started and the stats have not been flushed yet. This is another
> > example of non deterministic behavior that could be difficult to
> > debug.
>
> Even with the flush, there will almost always per-cpu updates which will
> be missed. This can not be fixed unless we block the stats updaters as
> well (which is not going to happen). So, we are already ok with this
> level of non-determinism. Why skipping flushing would be worse? One may
> argue 'time window is smaller' but this still does not cap the amount of
> updates. So, unless there is concrete data that this skipping flushing
> is detrimental to the users of stats, I don't see an issue in the
> presense of periodic flusher.

As you mentioned, the updates that happen during the flush are
unavoidable anyway, and the window is small. On the other hand, we
should be able to maintain the current behavior that at least all the
stat updates that happened *before* the call to cgroup_rstat_flush()
are flushed after the call.

The main concern here is that the stats read *after* an event occurs
should reflect the system state at that time. For example, a proactive
reclaimer reading the stats after writing to memory.reclaim should
observe the system state after the reclaim operation happened.

Please see [1] for more details about why this is important, which was
the rationale for removing stats_flush_ongoing in the first place.

[1]https://lore.kernel.org/lkml/20231129032154.3710765-6-yosryahmed@google.=
com/

>
> >
> > I tried a similar approach before where we sleep and wait for the
> > ongoing flush to complete instead, without contending on the lock,
> > using completions [1]. Although that patch has a lot of complexity,
>
> We can definitely add complexity but only if there are no simple good
> enough mitigations.

I agree that my patch was complicated. I am hoping we can have a
simpler version here that just waits for ongoing flushers if the
cgroup is a descendant of the cgroup already being flushed.

