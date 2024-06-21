Return-Path: <linux-kernel+bounces-225066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD08912B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F291F26DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56D016078F;
	Fri, 21 Jun 2024 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LrE/7mLJ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9322DDC4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987704; cv=none; b=qe4iRrlzZhJGrUilnfyt0mBGtH8BSQphCfScZ9LiAm8zbFBWbWw5TJDPUGRKHI/gSGIXBotkllauoO7prXIdDimhORaE8woJ4CYpdo75d2j01fPS+DQ1lc1H/J4VPnvlfrOJ0ixpz9BqiSdUx4Sn0uaOXdSLrpTTtV9cL+sbIKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987704; c=relaxed/simple;
	bh=qGTXBU6L6MXUTWOST93MNu8iX1GGyVWVopEyzWe3ink=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFsAyGNSnXvqtLZbibQQUNpFlQ4RRbTmI0V1FXqfdl7lTmnYpB24dxK3Af+lHd2ezAj+9XBGsUh8rPEi5lJQMPl9u6K32ltIholMCxPMXMXphFJELWjEnhuwh+FyIXuHq357yYa34ErFWSPOKX1Sbs4Y3aaJ0n9zOMu+A1nQokY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LrE/7mLJ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6efe62f583so218196566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718987701; x=1719592501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tAU1GlYr9btps524o7pSIFXimP7Sp6MAR+S3GC5BL3g=;
        b=LrE/7mLJ32NG2MlW91DeBevy2LiBCO/woGjuSmVns4B8abYe6K7/Q8UwCsPoiuuusY
         dfuu2sI4zOGhSz+646M4Sh8Il2h+BeGrfXZ3Mcn4abVSi1pBN7kryUhWes/Q5GwXEL3R
         I/jDij7jIvj39pPCNgBHUQrG3yCknQeCqdSSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718987701; x=1719592501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAU1GlYr9btps524o7pSIFXimP7Sp6MAR+S3GC5BL3g=;
        b=jztIRGPOQaGlufsElDDl3AICst6svz33GhMD+8EJa14i769CXHKhEGhgDD8J8/5jXH
         uKM9I0PxNKdpsPjk9GY2Hveey6UB8mNM2mD4AGoNuPQhC0pqg8xzYvQ4JhIubpqt9Rln
         PsVFgevKIHunItNvmvP0Rrk74ZPvE/aFnaJG4wXPezK1zAtsYFNM3jv0oXqEtjiSfU7x
         Nnxh/jrtLCl9aBBgY7b/3+L6suLzdeZ8mfsMBhT4P3UCs5jo8MpsrBC1HU2Kq4d+bAsO
         O4bwLr/K8XIE3SrQL9RM91FV6cUmoCr+mTBTKaqMMMX7Tv8Hb+8sEgk7tpW+3XBZjJ+c
         JTOA==
X-Forwarded-Encrypted: i=1; AJvYcCUKI5YtukQNYD3rYS+9OOhT6Vq6r4pTHud/0irPI9ybAMCM9ndvlFwlb9RYek1bdY3TgRTsYX+f3FvmYNj8rKzKJapZ/HoghYuj67zk
X-Gm-Message-State: AOJu0YwforviBjV/YO/QYduzHityPSeMZGJJ76xHPDXKFR4TEZfrtnhY
	4LgD2tkEaIHikW8enAI0ahdTozGVreu2njOcq9neOJt1qU42Xhet5+xm3kE7L5gP2cp+1vEdxOB
	Uu9vH0A==
X-Google-Smtp-Source: AGHT+IF9jl0hqWG9CF/M6LPNyTt4GVhIAIyO7W5TdmABeALFW7IINQZGnJ7tDTjHnAghsjoZyZcf1w==
X-Received: by 2002:a17:906:454c:b0:a6f:2448:a274 with SMTP id a640c23a62f3a-a6fab7792f7mr543384666b.59.1718987700737;
        Fri, 21 Jun 2024 09:35:00 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf54923fsm99661966b.104.2024.06.21.09.35.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 09:35:00 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4217d451f69so19183575e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:35:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVohja2u9CAdqcKiNFIDYQ/AolOHE8yIbUD9VtkgNjzau36IErOSZsWYRGF/ZR29dvit+JL+BdKC/ZPLf0rYVU5lEq9vDqw7JUBA8n
X-Received: by 2002:a17:907:8011:b0:a6f:11c9:f349 with SMTP id
 a640c23a62f3a-a6fab61c1f4mr501416466b.23.1718987679221; Fri, 21 Jun 2024
 09:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <871q4rpi2s.ffs@tglx> <CAHk-=wgN6DRks55fsqiJYE3uV=_QTgzdxOvh1ZZNgm_YooKdYA@mail.gmail.com>
 <87v822ocy2.ffs@tglx>
In-Reply-To: <87v822ocy2.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 Jun 2024 09:34:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRgsFsrnTR8XShrS_-aYS--4DSrRPmaWtYJ55-fmjznA@mail.gmail.com>
Message-ID: <CAHk-=wiRgsFsrnTR8XShrS_-aYS--4DSrRPmaWtYJ55-fmjznA@mail.gmail.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	andrea.righi@canonical.com, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 02:35, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > But secondly, the "keep things out" is itself counter-productive.
>
> Says the one who kept asking me repeatedly whether I can't keep the
> remaining stuff of RT out of tree forever. The last time you asked that
> was not that long ago.

Thomas, you are starting to just make made-up arguments now.

Did I require that the RT patches be done right over two decades? Hell
yes. But those RT patches didn't change some single subsystem, they
made fundamental changes to the most core things out there.

The RT patches made something as fundamental and core as "disable
interrupts for spinlocks" be a special magical thing that normal
people weren't allowed to do, and that turned into a sleeping lock.
They affected _everything_. They very literally affected subsystems
and rules that had been there since linux-0.01 (not the spinlocks -
they came later - but things like tty / printk were in fact some of
the very first things written).

And don't get me wrong - I'm not complaining about the RT patches. I
think they improved things enormously in the end. They've been great.

I'm just saying that they are _not_ the norm to compare against.

The sched_ext patches? Not even remotely in the same class. The
sched_ext patches are more like fuse - another filesystem, just a
slightly odd one that has that big user space component.

And yes, fuse caused worries too because of the whole "filesystem
development in user space" outside the confines of the normal kernel
development model. It mostly just was (and is) a shim-layer that asks
user space for policy, while still using the kernel infrastructure for
most real work. Did those worries actually materialize? No. No they
did not.

Now, fuse to some degree was easier, because while it was merged about
two decades ago, even by that time we already had over a decade of
pluggable filesystems. So the VFS layer had a lot of pluggability
already, and it wasn't very hardcoded.

The scheduler also has the scheduler class pluggability, but it *is*
fairly hardcoded. So in addition to the kinds of issues FUSE had (with
all the "impedance matching" between the kernel interface and the user
level interfaces), the sched_ext patches have some of that hardcoded
pluggability that it needs to fix up.

So maybe a better comparison would be autofs - but autofs was added
_so_ long ago that I only vaguely remember the odd pain points for
waiting for mount points. Over the years, all of that special sauce
that no other filesystem needs has become such an integral part of the
vfs layer that people don't even think about it any more.

You can most definitely still see the effects of autofs - as opposed
to "regular" filesystems - on the vfs layer if you go look (things
like "finish_automount()" and friends), but it's been integrated for
so long that it's a non-issue. But back in the day, it all needed what
at the time was some special glue.

Anyway, what I'm saying is that you trying to equate this with the RT
patches is absolutely laughable and intellectually dishonest.

Look, ignoring the actual sched_ext code itself (and the examples,
documentation and test-cases which I certainly hope nobody would
object to), the actual core footprint ot fht sched_ext patches is
this:

 MAINTAINERS                       |  13 +++
 Makefile                          |   8 +-
 drivers/tty/sysrq.c               |   1 +
 include/asm-generic/vmlinux.lds.h |   1 +
 include/linux/cgroup.h            |   4 +-
 include/linux/sched.h             |   5 +
 include/linux/sched/task.h        |   3 +-
 include/uapi/linux/sched.h        |   1 +
 init/init_task.c                  |  12 +++
 kernel/Kconfig.preempt            |  24 +++++
 kernel/fork.c                     |  17 +++-
 kernel/sched/build_policy.c       |  10 ++
 kernel/sched/core.c               | 187 ++++++++++++++++++++++++++++++--------
 kernel/sched/debug.c              |   3 +
 kernel/sched/ext.h                | 114 +++++++++++++++++++++++
 kernel/sched/fair.c               |  21 ++---
 kernel/sched/idle.c               |   2 +
 kernel/sched/sched.h              |  75 ++++++++++++++-
 kernel/sched/syscalls.c           |  26 ++++++
 lib/dump_stack.c                  |   1 +
 20 files changed, 464 insertions(+), 64 deletions(-)

and honestly, I went through it all. None of it looks really
objectionable. Some of it is trivial cleanups and makes the code look
better (the "refactor" parts).

And yes, some of it is "We have a new scheduler class that wants more".

Realistically, of the above, I think the *only* parts that are even at
all halfway interesting are these:

 kernel/sched/core.c               | 187 ++++++++++++++++++++++++++++++--------
 kernel/sched/ext.h                | 114 +++++++++++++++++++++++

and that ext.h is on that "interesting" list only because of
for_each_active_class(), and I think it should probably just be in
core.c.

See why I do not think that this is AT ALL comparable to something
like the RT patches.

And yes, I do think code should be cleaned up, but the two cleanups
that struck me personally were literally just

 (a) scx_next_task_picked, where I slept on it, came up with a
three-line alternative suggestion, and Tejun sent the "real patch"
almost immediately

 (b) the for_each_active_class() thing that I think would actually be
better off just being done explicitly in sched/core.c, but probably
only makes sense after integration

and it really strikes me as "neither of these issues were worth nine
months of delay".

Although hopefully the nine months weren't entirely unproductive, and
maybe the patches have improved. Knock wood.

Because *most* of the two files above are actually normal stuff.
Things that other scheduler classes already do. Sometimes just with an
#ifdef around it (although many of the ifdef's are basically hidden as
"inline function that is empty if disabled" - which is how we tend to
do things in the kernel in general.

So it's not even "200+ lines of objectionable code". No. It's all fairly small.

Arguably much of the strangeness comes from "it can be enabled /
disabled both statically and dynamically".

The "dynamically disable" code may look particularly odd because some
of that is the "scx_switched_all()" thing that basically disables some
of the CFS special cases. Is that pretty? No, but in most cases I'd
say that the cause of said issue was that the CFS rules were
hardcoded.

So it's pretty small, it's pretty self-contained, and it only affects
one single subsystem.

See where I'm coming from?

> Aside of that you are completely ignoring my point.
>
> Collaborative integration is the right thing to do no matter what.

Yes. And am willing to say "ok, if three more months make this more
amicable, I'll delay merging for another release".

Amicable resolutions are obviously preferred. And I am certainly
willing to going back and telling people "ok, it's going to be 6.12,
not 6.11". Some people are going to be disappointed in me. That's my
job, and I don't think this needs to be *rushed*.

But really, in the very next sentence of "I don't think this needs to
be *rushed*", I do want to re-iterate that I feel like this pointless
delay this has seen seems unnecessary.

I hope I have explained above why I think this whole thing has not
been worth the brouhaha and pain that it has caused. It's really not
that big, and the issues I see have either had small clean trivial
solutions, or have very much looked to me like "ok, it's not
integrated, but I see why an external patch would try to do it that
way".

And yes, I may be missing some big ugly point. But I really _have_
been going through those roughly 200 lines of diff that actually seem
to be relevant to this whole argument. Multiple times.

So if I don't see it, please point it out very very explicitly, and
using small words to make me understand.

                Linus

