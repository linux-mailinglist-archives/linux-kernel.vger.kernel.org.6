Return-Path: <linux-kernel+bounces-378073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0029ACB02
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EB81F21DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1FF1AC458;
	Wed, 23 Oct 2024 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KD4aZd1L"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C630159583
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689575; cv=none; b=XtZuMwRIM2hUA8MEANpMxvt9h8P3lgSZQZyu0qMV8hSoOqF8kVv0zlIpKSlufvHwaRr5RnPBb3lPfzr8w+Pe4ijDLaOtPHL9VtiH1xD/o5VwIRv12/AAvXvQu/th1jNMWNJmRV+g6FdpdV3QYEVkavA8K2Kl5TYYum5txunKz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689575; c=relaxed/simple;
	bh=cE1kzxn9XszxmbepX83IoLC4BhoWMR+VzWypJktAOrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3+rrb7bLODBElhCddPiVqCuG0Z5z/ZZqEkc0nB9PNussOyad6MYYdDtX2/y9xSNvvokm38nZuYT/FEM+VZAHZy2OKnH0JHnZs+ntGj91748QWcpNVdNO58wcKLBXNaxsgslZHwodd7FAiAetkE9WrAwbu6oOxNouW476/k2vrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KD4aZd1L; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2e2d09decso659134a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729689573; x=1730294373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+nhfAJoe99t9qmdltkllJ52oMwmGFCPSY0c/8BmjTZ0=;
        b=KD4aZd1LRvmQUmdK0uqgraKgHrgtvnWnp207VwjOG26iIU2pnj69ts9z+OvRb7lVlB
         lKPVJsS7ntNj1Lj2VNtP47yQZ1CFu/f74hGSw8odNThZuMqZZXTumtUxHOZl7LcvWrC0
         tgBzJ5RxmB0FHW8+gKZCztZOZJ8FjoCT8/LIHpHDAIwu+S7/5id814OHptzq+1irfLcj
         dzqMc516kBDP7OL3U6GZT6PamRUHoCezyccpceGVfWxP0B9m8I5m0N4gSkqwUprwPXXg
         BDbvN2XpUerhRdCToEJ9SFhlUHcEZUrPeQslh/uzOHEsROTTQZj9h/9amLRuGSX6eTKm
         lvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729689573; x=1730294373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nhfAJoe99t9qmdltkllJ52oMwmGFCPSY0c/8BmjTZ0=;
        b=lNV82g+DTftCFGnXq2h7WPg6Ycozsmrp++hpLxehh5hDzXVwRc5FmaRC7jJ5IrrvRa
         fKvhY2e9XdWTJJSNDPUume7pSEPYG5jc2kXQ8vaSdxHjTJSPDdiK7lG01/jD3EN5nih+
         RZcSFLss/0NuU5gQv/P5Ru9oo07wrmy+pBqmnddcWBLwcFJtoLVAJJ4X6EC1/o90kKjk
         hiQz9k+fRT2BEuHHpO1ipjdvBLQIiOsnBLNkj0y+pPIjwl0zuPln/0W3RFRIcIHqJNzX
         EjO7fJM/0vG1W7MXw/bsomzxoKBDfCsiAp79ZyfYhh5w//yZrNb07t2fZH+X8eF/6bIm
         Sc0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWC5BR2tvAlUFhElPmuhPR8TNL6vkUMbG0d6wvntAWuJy5jUE0juH7IEkzCdoHL3z7Xgrp93s6Qj4CI0fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyibMUlORE8+WP4XZ5lF7Gacrm8Cxo5lDyCIWJ9OrAV32R9GYlM
	UhGHO+WuiJZTC6Ll9a9ZvBTf0uPdugzhc4eTW2HY/V9T9UH1V2V5PzoSZSjso6yQ6z1SwWaQA/k
	g4FL8MIK5ckkx9Vy4OPzrYtHyGC05RIUobdlbpeBRqBiwOMWOEQ==
X-Google-Smtp-Source: AGHT+IEM8nviiqGAZm+EjyEe2ziPKXYXWb/DuENWSh1OOSFcDS/U7oiKqXNRLKyss4ZqQWigkAnieWpX/dFEkm6BEBI=
X-Received: by 2002:a17:90a:3e81:b0:2e2:ad14:e467 with SMTP id
 98e67ed59e1d1-2e5db91088bmr9596722a91.3.1729689573092; Wed, 23 Oct 2024
 06:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f6c7d4.050a0220.38ace9.0026.GAE@google.com> <CAG_fn=XExLPpgq73V-D_NL9Ebp9n965=PeaZPXwfqstN7DRoBQ@mail.gmail.com>
 <20241022113131.GD16066@noisy.programming.kicks-ass.net> <ZxerZIxg8kAMCvYc@elver.google.com>
 <20241022191244.GB9657@noisy.programming.kicks-ass.net> <CANpmjNMgjUi28BLk-uQQpqZ_RnB9sRtHpvymCPjpqrG=sQqGRA@mail.gmail.com>
 <Zxi5tbLnhoG4pEcm@elver.google.com> <CANpmjNNx6QM67jSaAtkYdxA+A5_FGPLBkBxdVXQ_XOLB8pgzNw@mail.gmail.com>
 <20241023093641.GE16066@noisy.programming.kicks-ass.net>
In-Reply-To: <20241023093641.GE16066@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Wed, 23 Oct 2024 15:18:53 +0200
Message-ID: <CANpmjNNXOhRvdFDLAeTSyjLSZSb4qQWVbRgPcvxV_=zKUXrBqw@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KCSAN: assert: race in dequeue_entities
To: Peter Zijlstra <peterz@infradead.org>
Cc: paulmck@kernel.org, Alexander Potapenko <glider@google.com>, 
	syzbot <syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com>, 
	audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, syzkaller-bugs@googlegroups.com, 
	kent.overstreet@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 11:36, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Oct 23, 2024 at 11:03:11AM +0200, Marco Elver wrote:
> > On Wed, 23 Oct 2024 at 10:54, Marco Elver <elver@google.com> wrote:
> > > On Tue, Oct 22, 2024 at 09:57PM +0200, Marco Elver wrote:
> > > > On Tue, 22 Oct 2024 at 21:12, Peter Zijlstra <peterz@infradead.org> wrote:
> > > [...]
> > > > > So KCSAn is trying to tell me these two paths run concurrently on the
> > > > > same 'p' ?!? That would be a horrible bug -- both these call chains
> > > > > should be holding rq->__lock (for task_rq(p)).
> > > >
> > > > Yes correct.
> > > >
> > > > And just to confirm this is no false positive, the way KCSAN works
> > > > _requires_ the race to actually happen before it reports anything;
> > > > this can also be seen in Alexander's report with just 1 stack trace
> > > > where it saw the value transition from 0 to 1 (TASK_ON_RQ_QUEUED) but
> > > > didn't know who did the write because kernel/sched was uninstrumented.
> > >
> > > Got another version of the splat with CONFIG_KCSAN_VERBOSE=y. Lockdep seems to
> > > think that both threads here are holding rq->__lock.
> >
> > Gotta read more carefully, one instance is ffffa2e57dc2f398 another is
> > ffffa2e57dd2f398. If I read it right, then they're not actually the
> > same lock.
>
> Yeah, as explained in the diagram below, the moment the ->on_rq = 0
> store goes through, we no longer own the task. And since
> ASSERT_EXCLUSIVE_WRITER is after that, we go splat.
>
> The below patch changes this order and switches to using
> smp_store_release() and ensures to not reference the task after it.
>
> I've boot tested it, but not much else.
>
> Could you please give this a go (on top of -rc3)?
>
> This also explains the SCHED_WARN_ON() Kent saw, that is subject to the
> same race.
>
> ---
>  kernel/sched/fair.c  | 21 ++++++++++++++-------
>  kernel/sched/sched.h | 34 ++++++++++++++++++++++++++++++++--
>  2 files changed, 46 insertions(+), 9 deletions(-)
[...]

Tested-by: Marco Elver <elver@google.com>

Previously syzkaller would give us that report within ~1h of fuzzing.
Have been fuzzing with your patch applied for 3h now, and this report
has not resurfaced.

