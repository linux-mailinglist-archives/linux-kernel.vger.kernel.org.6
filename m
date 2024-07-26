Return-Path: <linux-kernel+bounces-263494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D926393D6DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C3DB23A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0239117C7DA;
	Fri, 26 Jul 2024 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cqGCFI/s"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1EA17BB27
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011168; cv=none; b=EMwEekGnixCzPJUHHamVNf0ZvIXgT9VE7o6/m+1r38IsfJxk/bcXxZxuAUy1Guq4RbAuqVGZUuR0yyf66+GhildeXLDMzIaTSrB6IdRH13ocPfZFxsto83nbQAYaATzkWm7uVpbMMI3WhWNo2fkyet8/bQmJxuY2/KvSXBVNtLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011168; c=relaxed/simple;
	bh=A0HotuOlEhWe0MU21I/kfhWImzGIx856Iua/uZw/vls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kl7PZ+u9d3Y1SuxxVGe85JibHAm5WDtojKCEGqwJaFG/vemn+XouECFZAiFeOVaHtRM6CVIaH0RmW+ShnxAOg3hVQ802ItpIvvAE0UiU8FyRNhEzO6NYqT0lOeIrh9DBdbomDQXmLXty1UPkGL9aG4V5fmugDnq7C2IGHcrRlyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cqGCFI/s; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52efa9500e0so1883560e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722011165; x=1722615965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0HotuOlEhWe0MU21I/kfhWImzGIx856Iua/uZw/vls=;
        b=cqGCFI/s724L6dExg51XVkV5JNCD1F5QZVp6iZQyevKPFNSN7x1yU1g6hB6ypjlch/
         gJJoNgIFFORrkXTdpuWS8hY4DEWIbGbTDj5GS4GgWktpm0hMxfaiV2V+EpBUmzjkeI2b
         TfinM6W/lc5OKmACFbqroI3HMXPEekD0rUnFFoywi4vMBiMOgIVIN/PlkAceQjGDi2FI
         c+GtFSk3ez4ojJg4E5y/OwAvBtsh12wjlq5GxsQO+EiaaNnaHxbdGnY/b4l76+RrVXm3
         YyGtLycm3lbQn+3fvqBDfKBiTfC6xhuFPaldPcVraOEQbaate6yhLW3+u571N1tEY19H
         r5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722011165; x=1722615965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0HotuOlEhWe0MU21I/kfhWImzGIx856Iua/uZw/vls=;
        b=c6k+qCjrvQuvh4WjPnGhOuyeY/Y0EFw1umupxDPfYzNHOncYjqKkcFhU4U9KH53qeP
         wHDjMMLvvNtf3KI3ibtxKYO4g19nmAgCvaCRaEWpPFwx+jv0FOG4le216dZQX1w8hIni
         efij0Pq/03M4uNuopvAg2oZUH4IjBo2RoahMmk5Fr30BZdlHaNDh3G44v8UK0XPaeNSh
         XrnjNpG8uIR+dgXvM+LyDz+SC3owGJJrNxuWxAuTVGuJ+GQKpAwGXoWkLHXUpX0l9t1/
         qS/eCjzMZbp7tmu+I2PJw1QJCG8UooxpUk/TNP3rVidwSXTiQmjx/6af936kQjs2Yogm
         G67A==
X-Forwarded-Encrypted: i=1; AJvYcCX1PmGv/qVphMHc9WOmzqCmRmDqxXDIjYzNvrLENZGvd3v2wRpVPfn+OaDJ82CszuAHW6Wl/A44mI1nQfNhURcUyYIjKVw8A69m6HPt
X-Gm-Message-State: AOJu0YzD5p/hWOGipftrCwPGuQCrLfLzeD9BehQA0CtR5nCvUQcGIao6
	o0oNZ93QwACOQgCIgjPCh0R3+D4vka+3hUaXB1tro0BodOtF/EY71bK6HUUi4MYWEsh3ulbw2CP
	IKyzD54J7QRHiyKTqkMMk8ztl3rP6BNqy22IN
X-Google-Smtp-Source: AGHT+IE0xKwFZ4J6T9MLf91CjF70ZKTDtKO/pkaYa9QKl4enwp412VzKpF/js//canxrgU+eLM0aCm2zsQqjZgQXHJg=
X-Received: by 2002:a05:6512:2508:b0:52c:dcab:6738 with SMTP id
 2adb3069b0e04-5309b25a344mr222643e87.1.1722011164051; Fri, 26 Jul 2024
 09:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722225306.1494878-1-shakeel.butt@linux.dev>
 <CAJD7tkaR3s6fzRZWdvMvfSRBRaozSj7d2pH5HUjtbuOW+RROFA@mail.gmail.com> <lhlfj2keag2ciurt7v76d4nhyk5k5czrkvuocbgxkeep6zgwgo@ifjthvn5osvr>
In-Reply-To: <lhlfj2keag2ciurt7v76d4nhyk5k5czrkvuocbgxkeep6zgwgo@ifjthvn5osvr>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 26 Jul 2024 09:25:27 -0700
Message-ID: <CAJD7tkaW8bkwpUChJPc-Bw1epfrLySVhgr8528yZg5eCg3d=JA@mail.gmail.com>
Subject: Re: [RFC PATCH] memcg: expose children memory usage for root
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Greg Thelen <gthelen@google.com>, 
	Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 8:48=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Jul 25, 2024 at 04:20:45PM GMT, Yosry Ahmed wrote:
> > On Mon, Jul 22, 2024 at 3:53=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > Linux kernel does not expose memory.current on the root memcg and the=
re
> > > are applications which have to traverse all the top level memcgs to
> > > calculate the total memory charged in the system. This is more expens=
ive
> > > (directory traversal and multiple open and reads) and is racy on a bu=
sy
> > > machine. As the kernel already have the needed information i.e. root'=
s
> > > memory.current, why not expose that?
> > >
> > > However root's memory.current will have a different semantics than th=
e
> > > non-root's memory.current as the kernel skips the charging for root, =
so
> > > maybe it is better to have a different named interface for the root.
> > > Something like memory.children_usage only for root memcg.
> > >
> > > Now there is still a question that why the kernel does not expose
> > > memory.current for the root. The historical reason was that the memcg
> > > charging was expensice and to provide the users to bypass the memcg
> > > charging by letting them run in the root. However do we still want to
> > > have this exception today? What is stopping us to start charging the
> > > root memcg as well. Of course the root will not have limits but the
> > > allocations will go through memcg charging and then the memory.curren=
t
> > > of root and non-root will have the same semantics.
> > >
> > > This is an RFC to start a discussion on memcg charging for root.
> >
> > I vaguely remember when running some netperf tests (tcp_rr?) in a
> > cgroup that the performance decreases considerably with every level
> > down the hierarchy. I am assuming that charging was a part of the
> > reason. If that's the case, charging the root will be similar to
> > moving all workloads one level down the hierarchy in terms of charging
> > overhead.
>
> No, the workloads running in non-root memcgs will not see any
> difference. Only the workloads running in root will see charging
> overhead.

Oh yeah we already charge the root's page counters hierarchically in
the upstream kernel, we just do not charge them if the origin of the
charge is the root itself.

We also have workloads that iterate top-level memcgs to calculate the
total charged memory, so memory.children_usage for the root memcg
would help.

As for memory.current, do you have any data about how much memory is
charged to the root itself? We think of the memory charged to the root
as system overhead, while the memory charged to top-level memcgs
isn't.

So basically total_memory - root::memory.children_usage would be a
fast way to get a rough estimation of system overhead. The same would
not apply for total_memory - root::memory.current if I understand
correctly.

