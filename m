Return-Path: <linux-kernel+bounces-567674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E15A688DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0C616F76E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CAD253F1D;
	Wed, 19 Mar 2025 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BmebmIeI"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15186209F32
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377765; cv=none; b=L+OqbLvxDFXTVWmrnfsP8uaBK8xDWHa6yEndXqthlntu7H4Mlr8lZdrLgohp63WL7Xi99I3syXGYtM5JRTfr1eREIDHiJ4/+p3kXjXczyN7+SNFemFNSLaoMncW+CDof0fMHp3cl8eVs+ATHRs/mXKKTYGfLImj1L5r/8P6wUBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377765; c=relaxed/simple;
	bh=baq5CVcLiRILvTPgUlx57wGRXctkM2WUFDLFYOD32NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVYzT+rEdqEAhEe7Y9COiW/YTstQsYE4EXdO3xwW6/t4RqQMy2CZI87TAvBnuLfKQMebYB2A5Dv/rANNCks7vCjnkVZ82D7hTH+5FI+aYd6qQHda3iEQ5p8TGMRgEinTkDiYR7aCudQsmtKFMKdwjt8iKt5kJUeb0xyh6RIuxSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BmebmIeI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5499e3ec54dso6705971e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742377762; x=1742982562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4bpkziAEVYTH39wNSFQa+niMaKl6COY1nUfv4wFPJk=;
        b=BmebmIeIcXUUMkBcHHzjMjZ0OmKscWwUV24kILYYxF6AKTmnU+qUrddxtdXn5r64f7
         HWSZYEBwZGtQ5RNnfEBfoabE3RSepCdAoYCi6aSiWOWiJb6QttRIF0pkOvIreRRN+nE+
         ni6EWxETyAtdsU4tsulHskdeJb/2jAyh8TdSJQgWOxFaCGULvd30wUwJ+Wm/3SJ8lhB9
         trvrW3NcZsS4+UcJBM1wIkIelwzidT3ZsjdYR9sE5O0bItJOatzcuGkx8qA9OoxdhDK9
         O3yK+XNL2Un1IP/JYEMrZSZX2hPD0J/Mk7u/cQO2MGhUV7iuMJnNyG9Y0+NP3XZF1Qpr
         dWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742377762; x=1742982562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4bpkziAEVYTH39wNSFQa+niMaKl6COY1nUfv4wFPJk=;
        b=KeYJNxGb4zPNy8AIYBJUs6xVHlGlh3vLKCGDcdJw7RM/Fp96XTYnuC/ew5IiBmFIUE
         aRI5XnkPRzHs8JHpnRiLnREv13APJT+bl07XIe79gfMv9qVJNMZItXfLpb5+iCOjJlZz
         spxrz7Xkn48YOIGqs3JcoCpLVZX37CGF27jyE7SGBJDuuAlIiut5Z3YngnIbrpbut5ym
         SILcHVC5cr4kV8gd/bVSjasNFSs2uL5BgsmJv1ZgYi/3nqSEmFM4XPSDFYoHOYaWo7gp
         88tsk0b1mvwuuHh9huyyd9s/wynuO3xfbotbAEQkmEpUU6oHwB4RSRjS0F6usBGi/1HK
         iGmg==
X-Forwarded-Encrypted: i=1; AJvYcCXTT3d+WFistS9igOtzqEp7kmP1PFpF5rXHxmxK5nw9aXkMgKxs9B86pfMUy5Fv2zbVs0cneJ0rI5l3Ros=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+KnS32p1cgBQeVWDGZ2hgwP232hNzDYnMGbre2MIGcRPt8f9
	zTbnfxeQ08JMjKfyaMZBhLfWyjrfTj8PulBbJ3ZtVWwnY1DUo8TveWEZ2Jm3fXmdwHcDIHeYeff
	OrGSq2sXbVGEODEA3Eehg+6ctaZkMHBsO3k0=
X-Gm-Gg: ASbGncsx7HpujHo+K/7OZTT/1B182IKCHJR5IXLtxo9uYgNKV9rBwRixlDzM/bZaDQj
	QmqyAj4PtCb4WoqWmKSynktGGP2uVKeYgtuqpVWXouK2BXC7zWyl8NSuTt9kIHvfms4pMGrhFgY
	PlMU/XoawMAQpm4mUjreWIni73Opiy9yL3w+zgPFQNiGHxkgCLDw1hrRE=
X-Google-Smtp-Source: AGHT+IGCbCdSF+DMPxzTIx24sXw5HKWQMsJHhPorYGTRLr+odeoKRc2iHtumGCIDN9uTGoDEcfHCkQboF1dD38ZIZb0=
X-Received: by 2002:a05:6512:1314:b0:549:2ae5:99db with SMTP id
 2adb3069b0e04-54acb21d7abmr580212e87.45.1742377761803; Wed, 19 Mar 2025
 02:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312221147.1865364-1-jstultz@google.com> <20250312221147.1865364-3-jstultz@google.com>
 <20250313061351.412bc92e@batman.local.home> <CANDhNCou90nzwZR+cQisJnwBis=JGSw0WYE6BDRddhMobrkkXA@mail.gmail.com>
 <20250318231101.a77dd6de0f5e48cffad5e08a@kernel.org> <CAK1f24=rTxBF6RGrToHLCg0cZ5ffe-OLEqXu8eyC5nqStMVRwA@mail.gmail.com>
In-Reply-To: <CAK1f24=rTxBF6RGrToHLCg0cZ5ffe-OLEqXu8eyC5nqStMVRwA@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 19 Mar 2025 10:49:10 +0100
X-Gm-Features: AQ5f1JpWHviy0LrccvDjn-N-qwGpTq4GU_BDr3Ks-Ib5bgRpwM11BkN9LTFf7x0
Message-ID: <CANDhNCofYzVrdND+iPBU64feim+Cqi+bOCp-iaWJ8=HkAcDJ2A@mail.gmail.com>
Subject: Re: [RFC PATCH v15 2/7] locking/mutex: Rework task_struct::blocked_on
To: Lance Yang <ioworker0@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com, hikalium@google.com, 
	amaindex@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 4:33=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> When=E2=80=99s the next version expected? I intend to send a new version =
out
> soon, and it=E2=80=99d be great if you could include it in the next versi=
on ;)

Yeah, I've pulled in your old version already, but I'll update my tree
with your new one.  Between conf travel and vacation, it might be
April before I get v16 out.

Most likely I'll be moving much of linux/hung_task.h into
linux/sched.h to get generic accessors to setting and clearing the
task blocked-on relationship (so its not just tied to the hung task
debug logic). Then for proxy I just need to integrate it with the
additional blocked_on_state that is used to determine if the
(previously blocked, but left on the rq) task is runnable or not.

> Also, since we have similar use cases, it might make sense to use
> the same field to store the lock, encoding the lock type in the LSB as
> Masami suggested.

Yep. Agreed.  As I mentioned earlier, proxy only works with mutexes at
the moment, but I do intend to expand that once we have the core proxy
logic well tested upstream, so the multi-type blocked-on relationship
is really useful to have.

thanks!
-john

