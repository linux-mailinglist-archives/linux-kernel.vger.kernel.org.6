Return-Path: <linux-kernel+bounces-388398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5BA9B5F21
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F15A1F22046
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C9E1E1C2F;
	Wed, 30 Oct 2024 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QhgvzyHc"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C8B192D76
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281611; cv=none; b=fIUylnL0tiWLmgUNLp+5pkjM93aN4A8P64jfnEBQyxViX9wSac1suXOR0AcroeKR+HFy127ZMoNqeoXqv1Q45wPlP0V5ioKiAuFVjpkPdnCfAwVBWAXHSmA2F/G0ERwaHTmAo65TSScRl03RWe6H9b6zSBg9KL7a0VBKrf4YKwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281611; c=relaxed/simple;
	bh=FBmZcXTgIZK0lgSN6xAJ8jAckuE+YGMam+wktSSa9MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqusWLQORfJcsMJuTucwLHyAMCt6r3prsuLJgNf2p7Elq1LwXCYpjxvwYBZ2K0q1of8NQK/iyVhszDYyfJ9CTz2PeMByXs1l0l61KpAP+EebrSSO128zrV/3PJtoGmPlfBDxOVYH5E2V4zVlhIKcYVzrurK63K/xAgl34KpbEhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QhgvzyHc; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e30116efc9so5216448a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730281609; x=1730886409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=57YjU7d3aiShFAeRYMJ4UKLcOCFYenUFjplvSNxBdNs=;
        b=QhgvzyHcxZSik0qo2w6ipsbFr63gP/UzJMXnOXxhm/J32OQhI562A3V3/tqm3Tc3CE
         V3xkra9UXzCsAje64TWIuHEcs5Z7+W/6tRHq+3QwifMjAyvKKxwzBWQJ7hkE18J79R+u
         GOX22tHsYDASDgZDsoMcE/ERXTXzWoFukOghi9jhSAkLJYIlMF8XnNfQX0GY2ypGk2PI
         MlPE0uNqy1cMZFesfuL0bHFIoPBYUVyPp+DflpaUmoDC0LfgGtFxC5hTR3/ew+uSXyO/
         wjvGaX0LfUntC3Cn3FtW4LW5hccl6K4UAjJcZkWH+ufPWPm2pOYy3CQYqIcSaLSJ6nNO
         68+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730281609; x=1730886409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57YjU7d3aiShFAeRYMJ4UKLcOCFYenUFjplvSNxBdNs=;
        b=oXazfq0SgpkbJViLb9wp3wKTm6X6IrHV81nNtyF+wB7Kwf8l2joegqmlPR95zgZ6BE
         YGsEk7YLOGDT6flk9dL/2UOD1PWvKMak8H1JcAnGhaF1PlQZZDVIrUZ3+Zae1PG3wdWy
         GcJDXVokUcFUiK5hUQt1iVAvBYl8hb7QbwLMSJJfQ3n3UKBhgoEca1e5w9wwBueMjyW/
         RFcVNJEQN4mssQg6yHzO4XUPip/S8sC79kKnumypwpLWTIUXb2eIeO7eOT3gxGzk0SHh
         CVh0Tx5ltQgAupsfFqXSDlz17PIOnzQh+P2dGQTWLHDFNlri63dYFbmbQ53rs61kTHLm
         9ezQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYAVnlOzv81axgrNjmS8MnlRqfjin4v7hAjYwQAt/Ka+bc/n4Gm1gzYLnWcZHwIm4Tzp/HjG/bXfaUaqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6cyj6wN2a2+gPnivmzsJIU20KaBMMvZCzEOH14rMOkVbRIRb
	yFLlrcADiFZ/7kzbXw6aNZHP1IvacsMf7XLIFJoJIdgb2YJfUvIpmQ8gzNxdlKs4LxHAAa0dMp9
	2Q0Qbjn3d+KB7+8NhKcrCOpAN1YVvTg5FdYCdvnRAY9Xw6zQyaTn/
X-Google-Smtp-Source: AGHT+IEMiikB0ur+6JqcKyOPWa2U/umSi1YVN7U5yB+G+Q68oHDPcN14Ls0bj3HSlcONgRgrvUhm9z+LBgmvXEBJrcY=
X-Received: by 2002:a17:90b:4b42:b0:2e2:d434:8547 with SMTP id
 98e67ed59e1d1-2e8f104aa36mr17310892a91.7.1730281608721; Wed, 30 Oct 2024
 02:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410301316.e51421de-lkp@intel.com> <877c9qynxo.ffs@tglx>
In-Reply-To: <877c9qynxo.ffs@tglx>
From: Marco Elver <elver@google.com>
Date: Wed, 30 Oct 2024 10:46:10 +0100
Message-ID: <CANpmjNNbZOQjc=5h4z_yS1v-F94bN06dwogi7o1vN9tLtVE+zw@mail.gmail.com>
Subject: Re: [tip:timers/core] [timekeeping] 5aa6c43eca: BUG:KCSAN:data-race_in_timekeeping_debug_get_ns/timekeeping_update_from_shadow
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel test robot <oliver.sang@intel.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	x86@kernel.org, John Stultz <jstultz@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 09:50, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, Oct 30 2024 at 13:47, kernel test robot wrote:
> > this is another report about BUG:KCSAN, the change does not introduce new KCSAN
> > issue, but causes stats changes as below.
> >
> > [   70.265411][    C1] BUG: KCSAN: data-race in timekeeping_debug_get_ns / timekeeping_update_from_shadow
> > [   70.265430][    C1]
> > [   70.265433][    C1] write to 0xffffffff8483fef8 of 296 bytes by interrupt on cpu 0:
> > [ 70.265440][ C1] timekeeping_update_from_shadow+0x8e/0x140
> > [ 70.265452][ C1] timekeeping_advance (kernel/time/timekeeping.c:2394)
> > [ 70.265462][ C1] update_wall_time (kernel/time/timekeeping.c:2403)
>
> timekeeping_update_from_shadow() holds the sequence count write.
>
> > [ 70.265642][ C1] timekeeping_debug_get_ns (kernel/time/timekeeping.c:415 kernel/time/timekeeping.c:399 kernel/time/timekeeping.c:307)
> > [ 70.265653][ C1] ktime_get (kernel/time/timekeeping.c:431 (discriminator 4) kernel/time/timekeeping.c:897 (discriminator 4))
> > [ 70.265660][ C1] tick_nohz_lowres_handler (kernel/time/tick-sched.c:220 kernel/time/tick-sched.c:290 kernel/time/tick-sched.c:1486)
>
> ktime_get()
>
>         do {
>            seq = read_seqcount_begin(&tk_core.seq);
>            timekeeping_debug_get_ns();
>         } while (read_seqcount_retry(&tk_core.seq, seq));
>
> So this should be safe against concurreny. I assume the issue here is
> that timekeeping_debug_get_ns() has a nested
>
>         do {
>            seq = read_seqcount_begin(&tk_core.seq);
>            ....
>         } while (read_seqcount_retry(&tk_core.seq, seq));
>
> inside. Which is still correct, but confuses KCSAN. Marco?

Right... Nested seqlocks have always been tricky for KCSAN, because
any racing access (vs. writer) after the inner read_seqcount_retry()
(after the loop) may end up being reported as a data race. The inner
read_seqcount_retry() will tell KCSAN "kcsan_atomic_next(0)", ending
the critical section, but at this point it's also forgotten the outer
one. The main problem with seqlocks has always been that there's no
requirement to cleanly denote a critical section with one
read_seqcount_begin() and a matching read_seqcount_retry(). Which is
why we opted for the kcsan_atomic_next(..) approach for seqlocks, so
that it can recover if the begin/retry calls are imbalanced. If the
seqlock interface were to change to require balanced
read_seqcount_begin/retry, then we could use
kcsan_nestable_atomic_begin/end().

I think for the few seqlock anomalies which KCSAN cannot deal with
today, it would be fair to mark such functions as __no_kcsan (or
surround with kcsan_disable_current()/kcsan_enable_current() to
include callees).

I'm also trying to figure out the seqcount_latch thing right now,
which is causing similar headaches:
https://lore.kernel.org/all/20241029083658.1096492-1-elver@google.com/T/#u

