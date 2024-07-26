Return-Path: <linux-kernel+bounces-263523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5314493D737
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 946F3B20E05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EE017C7B2;
	Fri, 26 Jul 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yLFVFyUk"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4B7494
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722012668; cv=none; b=UyTJaRzU8sLdTtl5tfwz5geSaaMzhBOBPSqxqAS1EN/DT9UOHT3qOQgVlRK+1dZpcYhFlPOYj3v2XROWKzCZU83oLrOBBdDGFeIZRGnbQaEkD+cqPM3zJ+vpOSiaTxHyqOsbgEjy8fJv5BV1qLM+/gXWSC66x6BzY5lANRD/k3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722012668; c=relaxed/simple;
	bh=4BxA0+YU8HmhWtQ4ARHeqW0BfBOAZJ5OD2VLt2P+zSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrHA5ql0Voh6RnvlpAZXqkh8WNm6xx/okYqnN4HCXLeFlWOfpiTdBua+ro3xxCvC2P6N5iBY9VCiK4XumS9rV2NgGeESqSAV3O93p4w6VRz3M+Dq8/r1XFNWu1TJSDlDKEunasviCN3ip9mKORK4c4OoMT7M1rtgMqzAdvf10SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yLFVFyUk; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0354459844so2152563276.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722012663; x=1722617463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BxA0+YU8HmhWtQ4ARHeqW0BfBOAZJ5OD2VLt2P+zSs=;
        b=yLFVFyUkdo4CFzedVg3bboZogbvjLmFwt/SNYKBjgzsxDn8mM3ijYz2m7+2RI7qAKk
         +vnjPOK2/OQPeFjtcWzVu7AjHU0AgSXW4mD1Y2MCqfhujLyTvII5NYsJIT5vkUNxRWWz
         pQfcY/8yi00P7HyKCOtefqKYYpKls1msBs+8KxKrsvM4DQtD4EWhXEifQgtsGakfX68Z
         ndJ4HhtjxXeqhefICj83SQMsOWm6ekYHK267yWsAY0HopKY7doaLbdmUUYwvP1ZyfzW+
         G6I8ph5yox1BW2PLUCTQbjTI7uY6RGnWxTVlJdugXoQwW8rrE7rtcp5vZahNBD2JaCKf
         re9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722012663; x=1722617463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BxA0+YU8HmhWtQ4ARHeqW0BfBOAZJ5OD2VLt2P+zSs=;
        b=EMSUFg4V5lc3yfvRGSg8RdZoLTBA8t2dvObfqEeG6r1x0gYXp0q+QOPMqAa6Tgdbml
         UCIq1cYltAhwVYFSwIWgns5JH/sq0s/a76dz9c7JqXzB8MSIB6mT0rrVc7oLyDWc8pCy
         UEY8b4kFo8wwIOCo3DWrAfr66Mud2n2TQ1wyEa+4ohJiu8SKMm7DsAD7wFM4GvDJ9bDm
         7oeI9DFdruExnmZLRuf96qTnVXCR2X9bLA7/rR8un7Gjm/3/0vuUjEpDWg+QKdqgFuzT
         ME3Y+kNdMdpGG41o58TaZZG5QU1sKGLxh89qv/hYgfNelnCAm+49AiQYnmLoCVDC99My
         Mm+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuW6s2e5YhPwqUKEjz+L4YKagRP/4zHXyGaY4RGKAAgUGiTZimqu/WpHrchZLQBUI8UtEgLLGGR46zUMWzNp2J32YkfEKDdh8LwOBU
X-Gm-Message-State: AOJu0Yy8siEim4Naww667Cp6mEKTqzVnrxai5vVcEWPCUWoX+kxH/MJp
	Dc2/sgjv6KmRQwtwIXK/xhvPoNaA+GI9mm73HjoHyPyFYI8+6tFCrJ9QosFsT2KIyzNMzC/4Bj+
	YQWAZjLqOdQ6Pn3ovB6UgSUYNHTIDVIVsMz+k7ZowxxxzAl673lev
X-Google-Smtp-Source: AGHT+IHWxj7f6PtHUxoxIKBx/m3q3z5LDExloc7S9hOF5q1/D5McAnn+zGMWjLhVQoAOHESdBoLl/CjGrncZPmFt6Ck=
X-Received: by 2002:a05:6902:2402:b0:e0b:4844:f927 with SMTP id
 3f1490d57ef6-e0b545f4ddcmr417745276.49.1722012662490; Fri, 26 Jul 2024
 09:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722225306.1494878-1-shakeel.butt@linux.dev>
 <CAJD7tkaR3s6fzRZWdvMvfSRBRaozSj7d2pH5HUjtbuOW+RROFA@mail.gmail.com>
 <lhlfj2keag2ciurt7v76d4nhyk5k5czrkvuocbgxkeep6zgwgo@ifjthvn5osvr> <CAJD7tkaW8bkwpUChJPc-Bw1epfrLySVhgr8528yZg5eCg3d=JA@mail.gmail.com>
In-Reply-To: <CAJD7tkaW8bkwpUChJPc-Bw1epfrLySVhgr8528yZg5eCg3d=JA@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 26 Jul 2024 09:50:49 -0700
Message-ID: <CABdmKX0XtaBCF-Dwv2rJBUTjj1NXOus9CL9k2ubaJRSGM35vTg@mail.gmail.com>
Subject: Re: [RFC PATCH] memcg: expose children memory usage for root
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Greg Thelen <gthelen@google.com>, Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 9:26=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Fri, Jul 26, 2024 at 8:48=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> >
> > On Thu, Jul 25, 2024 at 04:20:45PM GMT, Yosry Ahmed wrote:
> > > On Mon, Jul 22, 2024 at 3:53=E2=80=AFPM Shakeel Butt <shakeel.butt@li=
nux.dev> wrote:
> > > >
> > > > Linux kernel does not expose memory.current on the root memcg and t=
here
> > > > are applications which have to traverse all the top level memcgs to
> > > > calculate the total memory charged in the system. This is more expe=
nsive
> > > > (directory traversal and multiple open and reads) and is racy on a =
busy
> > > > machine. As the kernel already have the needed information i.e. roo=
t's
> > > > memory.current, why not expose that?
> > > >
> > > > However root's memory.current will have a different semantics than =
the
> > > > non-root's memory.current as the kernel skips the charging for root=
, so
> > > > maybe it is better to have a different named interface for the root=
.
> > > > Something like memory.children_usage only for root memcg.
> > > >
> > > > Now there is still a question that why the kernel does not expose
> > > > memory.current for the root. The historical reason was that the mem=
cg
> > > > charging was expensice and to provide the users to bypass the memcg
> > > > charging by letting them run in the root. However do we still want =
to
> > > > have this exception today? What is stopping us to start charging th=
e
> > > > root memcg as well. Of course the root will not have limits but the
> > > > allocations will go through memcg charging and then the memory.curr=
ent
> > > > of root and non-root will have the same semantics.
> > > >
> > > > This is an RFC to start a discussion on memcg charging for root.
> > >
> > > I vaguely remember when running some netperf tests (tcp_rr?) in a
> > > cgroup that the performance decreases considerably with every level
> > > down the hierarchy. I am assuming that charging was a part of the
> > > reason. If that's the case, charging the root will be similar to
> > > moving all workloads one level down the hierarchy in terms of chargin=
g
> > > overhead.
> >
> > No, the workloads running in non-root memcgs will not see any
> > difference. Only the workloads running in root will see charging
> > overhead.
>
> Oh yeah we already charge the root's page counters hierarchically in
> the upstream kernel, we just do not charge them if the origin of the
> charge is the root itself.
>
> We also have workloads that iterate top-level memcgs to calculate the
> total charged memory, so memory.children_usage for the root memcg
> would help.
>
> As for memory.current, do you have any data about how much memory is
> charged to the root itself?

Yeah I wonder if we'd be able to see any significant regressions for
stuff that lives there today if we were to start charging it. I can
try running a test with Android next week. I guess try_charge() is the
main thing that would need to change to allow root charges?

> We think of the memory charged to the root
> as system overhead, while the memory charged to top-level memcgs
> isn't.
>
> So basically total_memory - root::memory.children_usage would be a
> fast way to get a rough estimation of system overhead. The same would
> not apply for total_memory - root::memory.current if I understand
> correctly.
>

On Fri, Jul 26, 2024 at 9:26=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Fri, Jul 26, 2024 at 8:48=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> >
> > On Thu, Jul 25, 2024 at 04:20:45PM GMT, Yosry Ahmed wrote:
> > > On Mon, Jul 22, 2024 at 3:53=E2=80=AFPM Shakeel Butt <shakeel.butt@li=
nux.dev> wrote:
> > > >
> > > > Linux kernel does not expose memory.current on the root memcg and t=
here
> > > > are applications which have to traverse all the top level memcgs to
> > > > calculate the total memory charged in the system. This is more expe=
nsive
> > > > (directory traversal and multiple open and reads) and is racy on a =
busy
> > > > machine. As the kernel already have the needed information i.e. roo=
t's
> > > > memory.current, why not expose that?
> > > >
> > > > However root's memory.current will have a different semantics than =
the
> > > > non-root's memory.current as the kernel skips the charging for root=
, so
> > > > maybe it is better to have a different named interface for the root=
.
> > > > Something like memory.children_usage only for root memcg.
> > > >
> > > > Now there is still a question that why the kernel does not expose
> > > > memory.current for the root. The historical reason was that the mem=
cg
> > > > charging was expensice and to provide the users to bypass the memcg
> > > > charging by letting them run in the root. However do we still want =
to
> > > > have this exception today? What is stopping us to start charging th=
e
> > > > root memcg as well. Of course the root will not have limits but the
> > > > allocations will go through memcg charging and then the memory.curr=
ent
> > > > of root and non-root will have the same semantics.
> > > >
> > > > This is an RFC to start a discussion on memcg charging for root.
> > >
> > > I vaguely remember when running some netperf tests (tcp_rr?) in a
> > > cgroup that the performance decreases considerably with every level
> > > down the hierarchy. I am assuming that charging was a part of the
> > > reason. If that's the case, charging the root will be similar to
> > > moving all workloads one level down the hierarchy in terms of chargin=
g
> > > overhead.
> >
> > No, the workloads running in non-root memcgs will not see any
> > difference. Only the workloads running in root will see charging
> > overhead.
>
> Oh yeah we already charge the root's page counters hierarchically in
> the upstream kernel, we just do not charge them if the origin of the
> charge is the root itself.
>
> We also have workloads that iterate top-level memcgs to calculate the
> total charged memory, so memory.children_usage for the root memcg
> would help.
>
> As for memory.current, do you have any data about how much memory is
> charged to the root itself? We think of the memory charged to the root
> as system overhead, while the memory charged to top-level memcgs
> isn't.
>
> So basically total_memory - root::memory.children_usage would be a
> fast way to get a rough estimation of system overhead. The same would
> not apply for total_memory - root::memory.current if I understand
> correctly.
>

