Return-Path: <linux-kernel+bounces-389679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7ED9B6FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61BA3B2237B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8681D0F54;
	Wed, 30 Oct 2024 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zKXBiD/b"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754801BD9E7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730326601; cv=none; b=WhiH4rTyaw1+qVgqZaa3WV6IebzjVCxCgmQ+18ktX5d8SzQlEFTp2ZNTcLV6Op+8+/QlRumXNvMC6ZCUJxTd9TmSBrXIGFstvs2SLUMJkQi8FjYE+KPEpgS+PhET1VcVuTZNhTVFWVeQAnt7h1K30V3uDFcPxRGvBjl/kCAP8sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730326601; c=relaxed/simple;
	bh=x27zj7bkt6bMfPik2cS5129bupoGtGFiuz6JcA5jT8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4su3IFbJXsaAUm6dDmZAiOEZ86ktA9TjnFiAQykCbjaihhJlVKySioOFFix9jrPILbQBTzh55OvyDlCSMS3WMJjyURXnzcnEd+QcoC5wSeNUupYzERerEGNLdbnulM4JNuPLyGIEJXuR9J29pzcCT7X9GjtnrMTUDxc+klh8q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zKXBiD/b; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso36980766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730326598; x=1730931398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeckrXObfHi3msDV22fzQk52trXEUquKLE6RqY4+MfQ=;
        b=zKXBiD/bqJJIcY+vJSm4YBeN7V23YmOPdebDOtq8hNYcmMNJ2UeUHl71q/1nj9nwxl
         +7vzriGp6hWaKMjZ2Zd1WoH47/QKaUBAaC2p9CG2UgBbgdNNLBOqTvw+89trEq0pyjwA
         4m5AlD5iaxT9CNv45nCu1sOYxj3z5L9CHQNDUPmo/ogzVN8dG2CxrboCUpeVpwEyJSXh
         cYez9aK8hxTU/gy6ga3MLSHxpzbvOiYckLLmLZuDsRlW+Uxe3iEXTigQoeLAJqNU3QW9
         MckUdjB/C2VjtSh+Zd8yqx37bwaTp4cHWPk9FW+eTPPEtfx5M2ncvDeffFJlFbifRee2
         PPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730326598; x=1730931398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeckrXObfHi3msDV22fzQk52trXEUquKLE6RqY4+MfQ=;
        b=OAoD3QI6gM5YtmAnQ5DGWlVM2CqOCOvNFlbZjrNl146HXj7Vex5qhX7ul9utINL3UY
         UZlacmY4uZl5h+HpvaLztnkGIxkOlei3roF9SOa4ld4nDYG77qs5A76UpAdzi1MkPpzv
         UUE3LNtfy7Ve7JQeJ3ZJeuX4LMxnUo0Xh5PmSAB/dX4QXQs2aK02xkf8l6hnEz2Q/OyE
         +TX8+YOrsAI0wRXVac9W1wCJuQgiBr2fc3rZ2YM+vyZkwNLXidO/aMX3c6cQLJAWW8By
         InRWbl1OdJ68pF9Qml2jx0cAnxPVV0K9a/ejzUJQJzAhJRUa6tI3idUpdkoET0/LRn33
         1jCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQEDvNPgcAYGn/6aNyC2kx4bgtuH27cBMq8TDNHl5B0FrdLObsiNMR5VE8wgPBrCVGPU133twJVcZam4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJ+V5aa0K9uuS9Uu2MPxUdRH4yIGyvHjPr0Z+MfG8HxO4gag7
	k4n5s5FU5vOoypkDLzx9CcdzSqakSX2713zUH7oKbJK+JjDfRTrH9EuyTO5Ki4f6GV3IIalyNIY
	VEsZi+9a6ni5I3roXX1N8QsaDh2O2ntUOG74=
X-Google-Smtp-Source: AGHT+IFtcnR1pNj7nQdIP3C7pjjkEiP5CGzDG5SrKKy/creuaJ8I/O0AHx8friC7yOnBTk8H3TlxvOFAZUKlJnE8I/Y=
X-Received: by 2002:a17:907:3f04:b0:a99:f167:47c7 with SMTP id
 a640c23a62f3a-a9de632cbb1mr1746522466b.55.1730326597752; Wed, 30 Oct 2024
 15:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410301316.e51421de-lkp@intel.com> <877c9qynxo.ffs@tglx>
In-Reply-To: <877c9qynxo.ffs@tglx>
From: John Stultz <jstultz@google.com>
Date: Wed, 30 Oct 2024 15:16:26 -0700
Message-ID: <CANDhNCoUyqvFa=mqrXra2KQ4ryeTnj-HkO4y8cxtQJyYZWz-2Q@mail.gmail.com>
Subject: Re: [tip:timers/core] [timekeeping] 5aa6c43eca: BUG:KCSAN:data-race_in_timekeeping_debug_get_ns/timekeeping_update_from_shadow
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel test robot <oliver.sang@intel.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 1:50=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Oct 30 2024 at 13:47, kernel test robot wrote:
> > this is another report about BUG:KCSAN, the change does not introduce n=
ew KCSAN
> > issue, but causes stats changes as below.
> >
> > [   70.265411][    C1] BUG: KCSAN: data-race in timekeeping_debug_get_n=
s / timekeeping_update_from_shadow
> > [   70.265430][    C1]
> > [   70.265433][    C1] write to 0xffffffff8483fef8 of 296 bytes by inte=
rrupt on cpu 0:
> > [ 70.265440][ C1] timekeeping_update_from_shadow+0x8e/0x140
> > [ 70.265452][ C1] timekeeping_advance (kernel/time/timekeeping.c:2394)
> > [ 70.265462][ C1] update_wall_time (kernel/time/timekeeping.c:2403)
>
> timekeeping_update_from_shadow() holds the sequence count write.
>
> > [ 70.265642][ C1] timekeeping_debug_get_ns (kernel/time/timekeeping.c:4=
15 kernel/time/timekeeping.c:399 kernel/time/timekeeping.c:307)
> > [ 70.265653][ C1] ktime_get (kernel/time/timekeeping.c:431 (discriminat=
or 4) kernel/time/timekeeping.c:897 (discriminator 4))
> > [ 70.265660][ C1] tick_nohz_lowres_handler (kernel/time/tick-sched.c:22=
0 kernel/time/tick-sched.c:290 kernel/time/tick-sched.c:1486)
>
> ktime_get()
>
>         do {
>            seq =3D read_seqcount_begin(&tk_core.seq);
>            timekeeping_debug_get_ns();
>         } while (read_seqcount_retry(&tk_core.seq, seq));
>
> So this should be safe against concurreny. I assume the issue here is
> that timekeeping_debug_get_ns() has a nested
>
>         do {
>            seq =3D read_seqcount_begin(&tk_core.seq);
>            ....
>         } while (read_seqcount_retry(&tk_core.seq, seq));
>
> inside. Which is still correct, but confuses KCSAN. Marco?
>
> But that aside, since 135225a363ae timekeeping_cycles_to_ns() is fully
> overflow protected and unconditionally handles negative motion (before
> it was x86 only), the value of timekeeping_debug_get_ns() becomes
> questionable.
>
> I'm leaning towards removing it completely.
>
> John?

Yeah. I could be wrong, but I'm not sure of anyone beyond myself that
has really utilized the TIMEKEEPING_DEBUG logic (and I've not enabled
it myself in a few years). I don't think we've had any problem reports
from it either.

So no objection from me.

thanks
-john

