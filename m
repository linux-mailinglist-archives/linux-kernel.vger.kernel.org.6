Return-Path: <linux-kernel+bounces-417608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558C59D5690
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8DF280CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B3F10E5;
	Fri, 22 Nov 2024 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jXJxG3Cy"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A3F625
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732234171; cv=none; b=BVxizlpkLCqokS5rwV2OrOcDQrXknk0MpaGnPatLqE+qAYTOvbbW1iT42Rr3AZ1zKJOjKuV+J7UD8/eBJ4koNBhi0OGyiyK03K6jhDBtgIZ61wg5JNJ56dFGHHqX9zHKIabg4HXuUUxX61opwjaHSQtEPaTlGoYRdOVqQqvLyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732234171; c=relaxed/simple;
	bh=1d/tnel8OpAEGUunRv64WUCNjs7TwKyNdceW5M7PaJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZw04fYjf/Bu25f3Q1+32Bog5hinoYejiH3AL8vAqpicfW1vrQ/d8S/+vpkyvuWcPo3Ypxm1HhddngWAyV3a2HaXfkHLdZGcMvpGcTzizH2JDujhtVHg1lKvp0Xpxb81/jpCEl7gEtglYaJO+L9ON1bFvGkhPHFte833MwvEs7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jXJxG3Cy; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cfb81a0af9so4495a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732234168; x=1732838968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BK4/KCXWB96ymSESeJdIEGwR7z31fMLlbynhd7TXEng=;
        b=jXJxG3CyLpIsrJBz60h3QZDL1XUekkMamxDXgjWKr0oPtwKzEt8SWQZ8GO5ExI6Wy0
         XJTFDlBje4uu2zftr5sEPtIVW8lkqHzOky8NKN5KLzIlC9LV/K0cj0bbD9l/kduiuXfQ
         gDK6FhJpE3pZ7fXqFJOQT9Qp3ZGclpkEcKw/yC/N+pGXw3DkAsMWHn4MUqrH/aAxXPy2
         ZCGiBOc7h8hBQzHy7DH7mCzYv+K0NxeoINFPn2lSUSFhl1lKKNg1oki7GrPOpAyHYbJE
         9SD6Jup3dT1A3srh6RUmIDWGqjpfWnZ+ghNWuwtbywR2f2iGPp3UjwiHglcPMqeR7dbX
         CnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732234168; x=1732838968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BK4/KCXWB96ymSESeJdIEGwR7z31fMLlbynhd7TXEng=;
        b=duYUzO5xC6qagQn9aWWw8Qf6CGzTzIbSXtFpaL60iQgkSYL/v8XFO+1BZ88KcTSbog
         Gs/Tx19eNM8frnj+psLURJIc7NsQqJRiQWzPiTSdxCIHgzmfXcPVKLQk3ZG2hLtf5/kD
         AZAOkvmuyU5R/qjkk/eOT5giPY0eNEzVtuG4NuzaTMMBduzSqsOu1aMClgW3zNqkwtwa
         MfWbDUcDNFNBqhUv06nKWYq13Hx4ol0xQfzXsosUBgYqFTqpp2RQqxPs76IWO+IIzXQG
         0d5uc+ydv65U5pWzrYnMxDyJJC6HYj9zpLgAM+29VDFG3oRu1+AlONxILxomnGKTsm4D
         /XyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4WKsJDkX69aCaOpXFs1mCBsHB6NFU55n+KbSTYqt0uUX1k743bKfG+Rqq04Oc7cvx8YXo2isBkXx2whk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw0JcDsvA4HLlM3RHjj9ogL9rOAnYEmivR2FZ8h2v10RAIeIRj
	dgk/+bada0d1QA6Qrm4kFfx9OuWzrHjKIdvEjh/ctSe2fl3roEoGcFdOrS7NQVU9Lc7GKYIqfvS
	J5RRfZhEiFrG8aP7FiWCH0IilY1SqK6glQWOb
X-Gm-Gg: ASbGncv9MEHeR9rhMlAtjtd1xUwMrmECZiUwtIf46wbk5iTdfNiPYduU/hCnT0VCW/b
	sekI4FLL4iQ0K2ElbdQejI+CKrQEYd+rE
X-Google-Smtp-Source: AGHT+IFOeisSTtf3ETJm7V2kdKcjPzKq3mrsDw+Jx5dZpVqqKBpXIMKop81k5VMCEv0SRNmOsanBi5gd10EDjCe9AXA=
X-Received: by 2002:a05:6402:945:b0:5cf:c93f:36f3 with SMTP id
 4fb4d7f45d1cf-5d021787792mr10204a12.7.1732234167906; Thu, 21 Nov 2024
 16:09:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111182738.1832953-1-joshdon@google.com>
In-Reply-To: <20241111182738.1832953-1-joshdon@google.com>
From: Josh Don <joshdon@google.com>
Date: Thu, 21 Nov 2024 16:09:16 -0800
Message-ID: <CABk29NuO0awfERpRBHyEyRPaCcrKJ-Zx1fR9f8RgSrqpqNM_cg@mail.gmail.com>
Subject: Re: [PATCH] sched: fix warning in sched_setaffinity
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Waiman Long <longman@redhat.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	Roman Gushchin <kfree@google.com>, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 10:27=E2=80=AFAM Josh Don <joshdon@google.com> wrot=
e:
>
> Commit 8f9ea86fdf99b added some logic to sched_setaffinity that included
> a WARN when a per-task affinity assignment races with a cpuset update.
>
> Specifically, we can have a race where a cpuset update results in the
> task affinity no longer being a subset of the cpuset. That's fine; we
> have a fallback to instead use the cpuset mask. However, we have a WARN
> set up that will trigger if the cpuset mask has no overlap at all with
> the requested task affinity. This shouldn't be a warning condition; its
> trivial to create this condition.
>
> Reproduced the warning by the following setup:
>
> - $PID inside a cpuset cgroup
> - another thread repeatedly switching the cpuset cpus from 1-2 to just 1
> - another thread repeatedly setting the $PID affinity (via taskset) to 2
>
> Fixes: 8f9ea86fdf99b ("sched: Always preserve the user requested cpumask"=
)
> Signed-off-by: Josh Don <joshdon@google.com>
> Acked-by: Waiman Long <longman@redhat.com>
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Acked-and-tested-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/syscalls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 4fae3cf25a3a..3a88f7c0cb69 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -1321,7 +1321,7 @@ int __sched_setaffinity(struct task_struct *p, stru=
ct affinity_context *ctx)
>                         bool empty =3D !cpumask_and(new_mask, new_mask,
>                                                   ctx->user_mask);
>
> -                       if (WARN_ON_ONCE(empty))
> +                       if (empty)
>                                 cpumask_copy(new_mask, cpus_allowed);
>                 }
>                 __set_cpus_allowed_ptr(p, ctx);
> --
> 2.46.0.469.g59c65b2a67-goog
>

Hey,

I wanted to bump this one last time. It's a pretty simple change that
already has ACK's from 3 other folks, but has seemed to fall through
the cracks [1].

Best,
Josh

[1] Timeline:
Original patch sent Aug 29 and quickly got ACK'd:
https://lkml.org/lkml/2024/8/29/1819
Pinged on Sep 30: https://lkml.org/lkml/2024/9/30/1528
Pinged on Oct 25: https://lkml.org/lkml/2024/10/25/1708
Resent as a new message on Nov 11: https://lkml.org/lkml/2024/11/11/1125

