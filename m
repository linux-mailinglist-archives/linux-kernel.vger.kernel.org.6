Return-Path: <linux-kernel+bounces-251822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EA4930A41
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 15:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7D7B20B8C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971E01311B5;
	Sun, 14 Jul 2024 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nvp+6l3D"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBBE139CEE;
	Sun, 14 Jul 2024 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964474; cv=none; b=WmnGQGgQV70CM+qFbNl5uzwe5qopqWi1QH0dsWDJEPGU5e4gbzXrtpHEIg0qQv5z4k4oqo6FnKLrK4CkkrP46Ue2l2Un8ZsJt3pHrMAfZaCLlTORIdZfYhVN5XALwgPY4aFUzu1h2qJ9mBlTYIlwitLM7aULT2Yf7o0UVilzHq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964474; c=relaxed/simple;
	bh=rB9HB93Rvshe7z6WUpChBtzmZ+pzwvzmTeb5SFGy0zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYhT5H3nhOSAHZ0WFkZ20lwsvkBjhPykWKUZoRM22h1YhznHi7l3EIcXOr+B/hTrNQB1WPMtzVQdZBpKhUeI8kcHaUu30lGm/BJUYJoVkhuujg4DFFwrKM02zpDg3KqmQYzNGxgChpwsybDb35/iPP+zTmLgyAdg6TDEYT5TUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nvp+6l3D; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58ba3e37feeso4183527a12.3;
        Sun, 14 Jul 2024 06:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720964471; x=1721569271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+j1wupx7YxD84513AU7BSAsqVvs64S6cEhC9kkPdJM=;
        b=Nvp+6l3DWpAK42HEUqVgtx4vfA+/4mh8VOkcFTejsviuoLyDzaaHnny/7TD/TS7NCv
         V+wKULfItrDbfkT3p2dTPvx1YADp+axWWJS9QzsdEhhNk/+kdxMXK6gid8ekLv/hCPTa
         3qH7wGzzpDBA7/Jip6uUwB0QzazPQY2Qew8S1/Ic3BjXmazuzjtst6FHfrCpnBr6KCge
         o9Ma+2us5D0dR5lmqo4UOPy6BQ6l4sTfj3ON4h/MLBOVaPtdBzKZ6c6vI7pU6WChdjTc
         46p16XXy324T/ytLlU3RX68o0OgWExbpaJBWcAl7xdblSfR/aNxuwVYowab3/WvixB2c
         oIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720964471; x=1721569271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+j1wupx7YxD84513AU7BSAsqVvs64S6cEhC9kkPdJM=;
        b=eyaw9qwth2gMLoLmci8xt/zLyg056JEJaSAIOcFg6EYV/9aDDldZKnpDs/KmrXFJfv
         nd3te9U77wJuynnnitqXrnBDOSzLNpn5hcvsFzlTj8BTcS+o9eUkw6uyX4AegvYwfhZ7
         Xwi2ZluDmqz9RXHC8dslrAMy4l3PN8i63uqfy+7Fn8L1gn99TD7rL2S8Z5fyX7C+VBwc
         qCXpv735xyWD7L4gnFY69s1QeMS5GyAl2P1nPuxDvLEc6TehrnTC946upp738vbJI18b
         +srDD25n5JRxYziHp/Qs7rDHfKaiNGbOw5PQ3XS9l5ne9vzhRjRQyUSorUbel+cdaENn
         xS6g==
X-Forwarded-Encrypted: i=1; AJvYcCUJpRicmKzUfSrZczokWE/Cy7KXTLYhrS68LCTHzZ/i7MrgdSOnCZq/m4ttbnD7PzwTq+4sDFxWQDKbuTfuIBe0mzQtv1QgQVgV78hZndo0C2Jmhi5TTkEHj7goyjBxEQIbmloOuAw6
X-Gm-Message-State: AOJu0Yxo8DWtZ/72D9c/UyNsxqRIDZC71JHU2j74MUnSjORrjxbFFK58
	4vwiXGirpxGLbYIEfO7UCSItkPpo019Q+646ymWQ98Z6EflIvjW/hIsf7ZkVESQzKjY+cBGneSX
	DNDFlZeFSRyoJGizmQcaSWsiNUpdYRrPb
X-Google-Smtp-Source: AGHT+IGFY5E1w8Bp7j+qOT55kraCMhBsxSoH2P3Rz+jWRhqVeFxU673zE4HJJ9B5eX44chT19InBQUGT6vnjjA0NHWs=
X-Received: by 2002:a05:6402:2554:b0:58b:d7f2:eef3 with SMTP id
 4fb4d7f45d1cf-594baf87f63mr13943531a12.12.1720964470882; Sun, 14 Jul 2024
 06:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713140455.4072847-1-carlos.bilbao.osdev@gmail.com> <20240713140455.4072847-2-carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20240713140455.4072847-2-carlos.bilbao.osdev@gmail.com>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Sun, 14 Jul 2024 15:40:35 +0200
Message-ID: <CAA76j93KgwWSkODWO_hpoiumh2VP_W_DWmdyLBCW3MiL52o2RA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] docs: scheduler: Start documenting the EEVDF scheduler
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: corbet@lwn.net, peterz@infradead.org, rdunlap@infradead.org, bilbao@vt.edu, 
	jembid@ucm.es, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jul 2024 at 16:05, Carlos Bilbao
<carlos.bilbao.osdev@gmail.com> wrote:
>
> Add some documentation regarding the newly introduced scheduler EEVDF.
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
> ---
>  Documentation/scheduler/index.rst            |  1 +
>  Documentation/scheduler/sched-design-CFS.rst | 10 +++--
>  Documentation/scheduler/sched-eevdf.rst      | 44 ++++++++++++++++++++
>  3 files changed, 51 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/scheduler/sched-eevdf.rst
>
> diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/=
index.rst
> index 43bd8a145b7a..1f2942c4d14b 100644
> --- a/Documentation/scheduler/index.rst
> +++ b/Documentation/scheduler/index.rst
> @@ -12,6 +12,7 @@ Scheduler
>      sched-bwc
>      sched-deadline
>      sched-design-CFS
> +    sched-eevdf
>      sched-domains
>      sched-capacity
>      sched-energy
> diff --git a/Documentation/scheduler/sched-design-CFS.rst b/Documentation=
/scheduler/sched-design-CFS.rst
> index bc1e507269c6..b703c6dcb3cd 100644
> --- a/Documentation/scheduler/sched-design-CFS.rst
> +++ b/Documentation/scheduler/sched-design-CFS.rst
> @@ -8,10 +8,12 @@ CFS Scheduler
>  1.  OVERVIEW
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -CFS stands for "Completely Fair Scheduler," and is the new "desktop" pro=
cess
> -scheduler implemented by Ingo Molnar and merged in Linux 2.6.23.  It is =
the
> -replacement for the previous vanilla scheduler's SCHED_OTHER interactivi=
ty
> -code.
> +CFS stands for "Completely Fair Scheduler," and is the "desktop" process
> +scheduler implemented by Ingo Molnar and merged in Linux 2.6.23. When
> +originally merged, it was the replacement for the previous vanilla
> +scheduler's SCHED_OTHER interactivity code. Nowadays, CFS is making room
> +for EEVDF, for which documentation can be found in
> +:ref:`sched_design_EEVDF`.
>
>  80% of CFS's design can be summed up in a single sentence: CFS basically=
 models
>  an "ideal, precise multi-tasking CPU" on real hardware.
> diff --git a/Documentation/scheduler/sched-eevdf.rst b/Documentation/sche=
duler/sched-eevdf.rst
> new file mode 100644
> index 000000000000..019327da333a
> --- /dev/null
> +++ b/Documentation/scheduler/sched-eevdf.rst
> @@ -0,0 +1,44 @@
> +.. _sched_design_EEVDF:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +EEVDF Scheduler
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The "Earliest Eligible Virtual Deadline First" (EEVDF) was first introdu=
ced
> +in a scientific publication in 1995 [1]. The Linux kernel began
> +transitioning to EEVDF in version 6.6 (as a new option in 2024), moving
> +away from the earlier Completely Fair Scheduler (CFS) in favor of a vers=
ion
> +of EEVDF proposed by Peter Zijlstra in 2023 [2-4]. More information
> +regarding CFS can be found in :ref:`sched_design_CFS`.
> +
> +Similarly to CFS, EEVDF aims to distribute CPU time equally among all
> +runnable tasks with the same priority. To do so, it assigns a virtual ru=
n
> +time to each task, creating a "lag" value that can be used to determine
> +whether a task has received its fair share of CPU time. In this way, a t=
ask
> +with a positive lag is owed CPU time, while a negative lag means the tas=
k
> +has exceeded its portion. EEVDF picks tasks with lag greater or equal to
> +zero and calculates a virtual deadline (VD) for each, selecting the task
> +with the earliest VD to execute next. It's important to note that this
> +allows latency-sensitive tasks with shorter time slices to be prioritize=
d,
> +which helps with their responsiveness.
> +
> +There are ongoing discussions on how to manage lag, especially for sleep=
ing
> +tasks; but at the time of writing EEVDF uses a "decaying" mechanism base=
d
> +on virtual run time (VRT). This prevents tasks from exploiting the syste=
m
> +by sleeping briefly to reset their negative lag: when a task sleeps, it
> +remains on the run queue but marked for "deferred dequeue," allowing its
> +lag to decay over VRT. Hence, long-sleeping tasks eventually have their =
lag
> +reset. Finally, tasks can preempt others if their VD is earlier, and tas=
ks
> +can request specific time slices using the new sched_setattr() system ca=
ll,
> +which further facilitates the job of latency-sensitive applications.
> +
> +REFERENCES
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +[1] https://citeseerx.ist.psu.edu/document?repid=3Drep1&type=3Dpdf&doi=
=3D805acf7726282721504c8f00575d91ebfd750564
> +
> +[2] https://lore.kernel.org/lkml/a79014e6-ea83-b316-1e12-2ae056bda6fa@li=
nux.vnet.ibm.com/
> +
> +[3] https://lwn.net/Articles/969062/
> +
> +[4] https://lwn.net/Articles/925371/
> --
> 2.43.0
>

Reviewed-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>

