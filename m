Return-Path: <linux-kernel+bounces-560743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1776BA608FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563213BE654
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177F7148855;
	Fri, 14 Mar 2025 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJ45d1SJ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E6B2F3B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932793; cv=none; b=u9aGzvT+IZd7XLmmEQAn+qp0oVh8GJZ1WBzUsWMY6nSicbg1Xyh/aUo4ylZCrz9RkiafZdy2vly6Qhp1ScDB99OEK8kYHzywQEA0xnlFZiUDqxesrgvCAGucooam1iFY6XY3eMsvVHwezQ0PCG1LeILXFU7ZBkjM3k79WhZt3Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932793; c=relaxed/simple;
	bh=kwUKYtj71unH0ipDRQ8NWTzdRd6U+EqyhhujT6xA67I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvQOZxRPdXeja/hidk0pqpQpl2gOl9YMUgOjq0pTN2yASF0vWQnDLMGNam9+78We4pqe4u6tutyP+si9r+lYGB+sNx8ZI09PyU/3mcT3O7+QT/WOfMrSxJ4ICZG57CNRPXuKICg36ql7prhzAWyIhCzABRgSkGj/LLegr53pGhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJ45d1SJ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54991d85f99so2945931e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741932790; x=1742537590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSQUaTlhhCywm3jAU0nT0yiV49UZf/Q30AeG3DnHqEs=;
        b=OJ45d1SJZmg8rh/IywDjcXPqtR3DGF9xh58aHWYQA/Sm4yftMBl4mYqhMjYYzQowfR
         skW4J3FLfvaItSoCNH+iljGRJ+m+nf9ufqCiXoqZn9LIKUTg9uAFZ4CZLwrQalvuZYrp
         xorGvuqtxOmtkFeoKeGe2wlgL+njphHzQfZbPwmGR9PGhcGB4qeZ3UCtexS4lelKEdm1
         06RMiV/tFkvI8qFQrJQp0CJ6uSkLNv4V4SYHowajieomtYcmqAfC1UtmekkPVhRhr7U9
         Hb+VWxuucVRIIA4JKyS4rEttKlcC/oX8nnxuvwAjSMA86uVsrdQxnjj0M0Jn8gUjMP97
         vVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741932790; x=1742537590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSQUaTlhhCywm3jAU0nT0yiV49UZf/Q30AeG3DnHqEs=;
        b=VgRkyDawbdLwNTcHRS9/SbumU70vQE5aCB9bezTdXoi9LcDo+xLLWelwNji+OtbYQY
         0ckJZp73qCikeKmeH1QyHLHEv+syA9JnHtaGIsdxAqx0fvKX/5U1CIHfJZham3rfvn9/
         hzLdvPT/CVRHmmErG84ojgxixDZ7wmmSJgP3BPpLIu8YrP0i4p/xT0ft/HF0YDVNHIkr
         lY8UxDyd6S+O2NBIioyIYdmne3ntXWfj7lbJ1XNl7Os2wTfidElSXRNOwDS5R/2av6gz
         t1GDvVf6bGPT5oKl6zOUGBAtvOfn5IrqTnUrH8VvECHDpu6bMmBnt15iIOmeAoJSwxIf
         LZmg==
X-Gm-Message-State: AOJu0Yw8nMJDTNDkC5pycnEm4y2XU6+w9dzg5/cMxxyxD/jQij+ULOKD
	kbxf0JfkBQDGThkXjCWxsYgpuZ/XEtL/P09g98QHX3QKOBNbkNvsL6Ytji7/X/BzGYiaKLSoNEm
	/pOyinNTLujIlpbaSpixA4KvdR2ATCxjodsqOLt0PiNQvBWuv
X-Gm-Gg: ASbGncsbYOAqj9kR1vi39Jg44LvUPVNXhAUqMFVMQaL5WAIVKOFQ7QBybfFptOp+cmS
	S102Ouf3VKd39oWNveiWG4V+ByeHKqi8xQ3DPru9J6A6WavIn0XRaZrjHfFSBbkummVIml5JnKx
	SsCGFdxluZ4Zq/aL0uVfvPQNbNXTR+JDdOnIMvw5WojuN+8tdmWxkoGFg=
X-Google-Smtp-Source: AGHT+IFQU6wJc4zDfuZ88Gxnt7++OeInbrwY1v+qZiDuYh6ifQrtpbkc5YCjx4JanpIOxqa55gh9FcgP7j1M/T9Hh3o=
X-Received: by 2002:a05:6512:2203:b0:545:2474:2c9b with SMTP id
 2adb3069b0e04-549c3fca13emr414870e87.22.1741932789606; Thu, 13 Mar 2025
 23:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312221147.1865364-1-jstultz@google.com> <20250312221147.1865364-3-jstultz@google.com>
 <20250313061351.412bc92e@batman.local.home>
In-Reply-To: <20250313061351.412bc92e@batman.local.home>
From: John Stultz <jstultz@google.com>
Date: Thu, 13 Mar 2025 23:12:57 -0700
X-Gm-Features: AQ5f1JpPuoMH-zVCujx7fBYYKMCRzdI4JAIntNcNq1jUuXjVy1SbSUgNhYIr6GE
Message-ID: <CANDhNCou90nzwZR+cQisJnwBis=JGSw0WYE6BDRddhMobrkkXA@mail.gmail.com>
Subject: Re: [RFC PATCH v15 2/7] locking/mutex: Rework task_struct::blocked_on
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 3:14=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
> FYI, this is useful for Masami's "hung task" work that will show what
> tasks a hung task is blocked on in a crash report.
>
>   https://lore.kernel.org/all/174046694331.2194069.15472952050240807469.s=
tgit@mhiramat.tok.corp.google.com/
>

Ah. Indeed, we have similar use cases. There's some slight difference
in when we consider the task blocked, especially in this early patch
(as waking tasks mark us as unblocked so we can be selected to run).
But later on in the series (in the portions I've not yet submitted
here) when the blocked_on_state has been introduced, the blocked_on
value approximates to about the same spot as used here.

So I should be able to unify these. It looks like Masami's patch is
close to being queued, so maybe I'll incorporate it into my series and
rework my set ontop. Any objections to this?

thanks
-john

