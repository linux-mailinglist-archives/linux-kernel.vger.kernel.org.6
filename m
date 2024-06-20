Return-Path: <linux-kernel+bounces-223633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEDE9115CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCA01C20D72
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D787407A;
	Thu, 20 Jun 2024 22:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xuh6wHzl"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109A46F2F1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718923410; cv=none; b=a3g5HX9QHooNARhIWs4bx9BOyFNaS/vDHB1u50Q4p9tcv0TBkvrcg75NYnyMg8Yn64kyQEEcY7EFhOcQWR8jx95MvR8leK9H7CAcGd6DIVyMlSiUtnsoK4W9ovc3Mory2ffBgFXOS8X9vAtqedXuutAaP2aMbRr88u+XF1YE684=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718923410; c=relaxed/simple;
	bh=Bfe2AgnXI7qc1eB42tP3sJ3GNIZuodteiRtnzVol0M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HV5BNF6hDcicN8Pyx5xo37ugI4NaWx3QgmosbKsUppnTRF7rqItjqYg3yGOEMJdZEgo52fHTjLLKglRhljIjj6/VbMeaDPJaPmOyJMS5Nhr+x4DyuBjioVgBWSySO0Cf0QZHHUdJJjGmtKY8dnsCDFi3HSnS/FVl258FS1tarYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xuh6wHzl; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so20475991fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718923407; x=1719528207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cLIJyrB/gnFlAkantfHrGOHAaqRt3DpcOw/9lCMmFlk=;
        b=Xuh6wHzlzPecf/xTL0rb1TirFDtPYEh56jd8SxwYo2xMciOt0gj2PywNeWP165Nm8l
         C+RsFLMQOSQjcIlbv9UJoeIl3pnqlr6kWhCrQUBDUaM75UsUznqzd3hjJTMsSV2FnN/T
         6H2aLEKT6FW0pGNinr6Z2IFWhMSbrmixvCL98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718923407; x=1719528207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLIJyrB/gnFlAkantfHrGOHAaqRt3DpcOw/9lCMmFlk=;
        b=FLZlBE6HYAlAqq3rO0Vo0Uw9J/5HnG1dwyYvif/X2T3LW0k06AAu+2fQpJ6GPdCoeh
         LFvPb9yeZLb/zL4j5UW60F9gK5dnG+w1AcfyZQxKxOS8QZdm1HXcrYtDrr180rdZ30YK
         99iSs+LYuO6ttvsBkiDF0b14NGvhjsH2fOPEH1v3hqhFh1LEjXp7mWdF5oIBxep7Q3Ix
         vEmwh7RlIlVppjeZUfENOT0B9qb0VQCImggWTL/XStdSd1LHbDgPDm7d8BG7GhdgwgiP
         TAtZt4BaSERgJAN9IRweRnQcUoQ4VHodUGCFbE8/TED090veTH/434rjlwZoB3lK781W
         NVIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNIzUR89shqTGGAqCQp0BNozd9IlLqk8Pr2BhN/etQ3IQeuvyjIv3kLEa4Rxs1BTs/SFWZg78d2QlK5qWkcLj3gb5WwAtHC/U7q4gJ
X-Gm-Message-State: AOJu0YyM/LQq+ImEB+tiQzGEoFI+OItBd2+mc5sEuT0q05VpWv/RHWIp
	Oo5Ufk7zR9VGD/tU0/qwihtVCWzerIT5qqpKM9kjxqFERCem+MLKrrKTQd8HE8OhQ9bvdQZBaMD
	ir0xYuA==
X-Google-Smtp-Source: AGHT+IFxOKsIbj9oyvHY+n6UWwCNqVMMC5JX4HzNrCpS1GPZr150aPAVXlAt9TraFa8ciTOi76Ct7g==
X-Received: by 2002:a2e:9241:0:b0:2eb:e56c:c90a with SMTP id 38308e7fff4ca-2ec3cff96f2mr52947301fa.43.1718923407046;
        Thu, 20 Jun 2024 15:43:27 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf48b29dsm17057766b.78.2024.06.20.15.43.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 15:43:26 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-421d32fda86so16997855e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:43:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPW8WmF+KMvdwZB1QE8g7erbkImFmdiH3KVH+Nh0cZo6jA3jvlpJgi1pOEv834RHsTW84E4Lpw1j6QWGCmrrEdjBRxWDY1uQ9kQn3k
X-Received: by 2002:ac2:5f93:0:b0:52b:e7ff:32b with SMTP id
 2adb3069b0e04-52ccaa32fbdmr4812180e87.23.1718923384950; Thu, 20 Jun 2024
 15:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx> <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx> <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx> <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>
 <ZnRptXC-ONl-PAyX@slm.duckdns.org> <ZnSp5mVp3uhYganb@slm.duckdns.org>
In-Reply-To: <ZnSp5mVp3uhYganb@slm.duckdns.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Jun 2024 15:42:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFPLqo7AXu8maAGEGnOy6reUg-F4zzFhVB0Kyu22h7pw@mail.gmail.com>
Message-ID: <CAHk-=wjFPLqo7AXu8maAGEGnOy6reUg-F4zzFhVB0Kyu22h7pw@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.11] sched, sched_ext: Replace
 scx_next_task_picked() with sched_class->switch_class()
To: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, peterz@infradead.org, 
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

On Thu, 20 Jun 2024 at 15:15, Tejun Heo <tj@kernel.org> wrote:
>
> The changes are straightforward and the code looks better afterwards.
> However, when !CONFIG_SCHED_CLASS_EXT, this just ends up adding an unused
> hook which is unlikely to be useful to other sched_classes. We can #ifdef
> the op with CONFIG_SCHED_CLASS_EXT but then I'm not sure the code
> necessarily looks better afterwards.

So honestly, if people _really_ care about performance here, then I
think that in the long run the right thing to do is

 - expose all the DEFINE_SCHED_CLASS() definitions in a header file

 - rename for_each_class() to FOR_EACH_CLASS() and make it unroll the
whole damn loop statically

which would turn the indirect branches into actual direct branches,
and would statically just remove any "if (!class->zyz)" conditionals.

Pretty? No. But it probably wouldn't be hugely ugly either, and
honestly, looking at the existing for_each_class() uses (and the one
single "for_class_range()" one), they are so small and the number of
classes is so small that unrolling the loop entirely doesn't sound
bad.

It wouldn't help deal with *this* case (since it's a "call variable
class"), but considering that the current __pick_next_task()

 (a) special-cases one class as-is

 (b) does a "for_each_class()" and calls an indirect call for each
when that doesn't trigger

I would claim that people don't care enough about this that one test
for a NULL 'switch_class' function would be worth worrying about.

Btw, indirect calls are now expensive enough that when you have only a
handful of choices, instead of a variable

        class->some_callback(some_arguments);

you might literally be better off with a macro that does

       #define call_sched_fn(class, name, arg...) switch (class) { \
        case &fair_name_class: fair_name_class.name(arg); break; \
        ... unroll them all here..

which then just generates a (very small) tree of if-statements.

Again, this is entirely too ugly to do unless people *really* care.
But for situations where you have a small handful of cases known at
compile-time, it's not out of the question, and it probably does
generate better code.

NOTE NOTE NOTE! This is a comp[letely independent aside, and has
nothing to do with sched_ext except for the very obvious indirect fact
that sched_ext would be one of the classes in this kind of code.

And yes, I suspect it is too ugly to actually do this.

            Linus

