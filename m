Return-Path: <linux-kernel+bounces-222050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1D290FC1C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BB61C231D6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078D52D611;
	Thu, 20 Jun 2024 05:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b5nEx0pe"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF30637E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 05:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718860121; cv=none; b=iwc8uYa02125f8gBy5VTy9TzYReHy+5DrgDyT/v+R4yeDyb8cLxO5Ey9fvXqC7l4x8rLxxVnjhO20JyHK5a/yv1bDb+tu4ziVf0R45xcW0qXuzcWcvEco5DHLT2wSf0raRwKLTG0316eDAI5yl7ewYvFOm4/pgHQYV3y3/uPlHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718860121; c=relaxed/simple;
	bh=PGEcj8aZ0X8uBbNFw1pg4Ohn4geSnMhLB5GTcNk6DQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5E1nkwzI1yJLWSmSLE6OkM0HyjOTSrY6EeEnILaLJ0ZZIAiQ8/FkMkIJ/w5uyqT0BznKz9PkmU7F0mJE8T91FDEXTojy3bts43XKf6rz7gqYk0iY90sUmRK6kRajsEhxBzosrlY3zIqNlZfURV1ZbXnL9Au5Ixzsv4TGYc621E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b5nEx0pe; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52bc121fb1eso470636e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 22:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718860114; x=1719464914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mKJ7tA0uxmt7GivwOPU2qhqe93NAGJzAby4kZnJZbdI=;
        b=b5nEx0pe/gYDTazkR0ULDSkSFzo2OCtd+RwRt6i8ho9DXOc9KFIztYM0M5+sTPaQBZ
         B87ozhePoCzBF3YLmq7sYAVwv+JHfYw8ltYq0H6UNyNdF9J/+9AXKwH6j8N8tstOnViZ
         z/yY0Np0abBy9p3aXMAfKA/9RlPbpRXArNGI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718860114; x=1719464914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKJ7tA0uxmt7GivwOPU2qhqe93NAGJzAby4kZnJZbdI=;
        b=PyjQI0K3Z48weOGqcTymMLs9FYLSUJZ3qcBl2Rwkn10SN23+r9wjOQdQpmCv8ZRQaA
         KL6/YBHolMQNkHVsMuebWBB3yLfWTouA4H7xDbpmhVAk/cQw7VSHiFlVlKq8GDJabqEt
         IFV/m2rBuH7RBAvXGRnWcCMeNQ9qt8sTCONRN9ojYTrwWs+QJrdYg5xez0I8RCIdc8He
         FINVv8guQAlwcMAxxhxAhCtDyyg13h0ygRFr66dCc4DEc5A70UxdUzbS7WnAXVYtRiiY
         L5HmjDBUBLPLib/BczOeMOETIp3FXPehH0J9+w3aq+oNuYxtzetPadfu4mKvCsxjY4gr
         MGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTZL6w4tXbl/TugxnWsbQPlCIUMkdbF0mEmbB4nO+ChhqkMwROO07vHMZedOXwS/yk8NDdh8hYkcc3hzlIlB/VcfwopyoqOnsPyMw2
X-Gm-Message-State: AOJu0YxCVK1c7zlOo2OEVqsfV1sufhl1QLho6bwY04RffV3fq0i1M/+E
	p3QYaAEl6Ah5Txxq7sZCJwLHRG8h1BYQV1fJRU0fJkE6lBEgzwEV3EqMusZfJA+RZ2NmZOi4WKU
	oipmEVA==
X-Google-Smtp-Source: AGHT+IGXIqmTDbiR3t0SpyQm52lffRpgljMwAJQ56fp1oQ3hA+11KFPfntm8PFtsQe71oKQ6rBLoBQ==
X-Received: by 2002:a05:6512:39c5:b0:52c:a465:c61f with SMTP id 2adb3069b0e04-52ccaa59ff1mr2614438e87.56.1718860113697;
        Wed, 19 Jun 2024 22:08:33 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cceaf18fesm166083e87.248.2024.06.19.22.08.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 22:08:32 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52bc121fb1eso470604e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 22:08:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXN4S3jbDR1HpZ3gnvB89aq2OVsY/b0H/S+EFQKQyVkbNK2/f+3w0MX1zJUbtU+Bb1W96e7A9OeZNuJNB89WIKMJU9i887v966o0duL
X-Received: by 2002:a17:907:a0d5:b0:a6f:bd27:3f13 with SMTP id
 a640c23a62f3a-a6fbd273fccmr98231066b.34.1718860091359; Wed, 19 Jun 2024
 22:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx> <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx> <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
In-Reply-To: <878qz0pcir.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jun 2024 22:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
Message-ID: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
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

[ I'll try to look more at this tomorrow, but I'll send this part early ]

On Wed, 19 Jun 2024 at 19:35, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> When I sat there in Richmond with the sched_ext people I gave them very
> deep technical feedback especially on the way how they integrate it:
>
>   Sprinkle hooks and callbacks all over the place until it works by some
>   definition of works.

Are we even talking about the same thing?

There are basically two new hooks, for reweight_task (which is
something the fair scheduler wanted and was the only user of) and for
switching_to(), which is the class changing (again, mainly because
there's now not a hardcoded "normal" class).

And yes, there are a couple of other things where the CFS rules were
just encoded in the core scheduler code, and they got an extra check
or whatever (eg the SCHED_NORMAL changes and things like stop-tick -
things that changed simply because now there isn't a single normal
scheduler any more).

The rest are mostly all the existing scheduler call-ins, afaik. Or
_exactly_ the same thing that other schedulers already do, like the
task_prio() stuff.

Yes, there's scx_rq_activate/deactivate at CPU up/down time. Doesn't
look unreasonable to me. Same goes for the idle cpu management.

In other cases, it takes a few code sequences, turns them into helper
functions, just to be able to re-use them.

The ugliest parts are from what I can see the whole "ok, stop using
user space input over PM events" and that "bypass" stuff is sure not
pretty.

But that's pretty much all internal to sched_ext, and seems mostly
like a sane approach to "what if we do policy in user space"?

And scx_next_task_picked() isn't pretty - as far as I understand, it's
because there's only a "class X picked" callback ("pick_next_task()"),
and no way to tell other classes they weren't picked.

But "sprinkle hooks and callbacks all over the place"?

Could things like that next_active_class() perhaps be done more
prettily? I'm sure.

But I get the very strong feeling that people wanted to limit the
amount of changes they made to the core scheduler code.

> I clearly offered you to try to resolve this amicably within a
> reasonable time frame.
>
> How exaclty is that equivalent to "continue to do nothing" ?

So if we actually *can* resolve this amicably in three months, then
that sounds worth it.

But my reaction is "what changed"? Nothing has become more amicable in
the last nine months. What makes the next three months special?

                        Linus

