Return-Path: <linux-kernel+bounces-274647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FECC947B0D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2702281A0A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70CB15531A;
	Mon,  5 Aug 2024 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="GUfWye8C"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77561E884
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861308; cv=none; b=Rzff025W/iSSiHXnJ1vdmyHZzlv0FqEXA/OGuLHy1Yqt7BVIOI6jS/e6PrAvM5KwNe6WQyhf6jF2Zl8FBBs0lEVp5KKfqO3YteqqC9IvjDVn1q3cqZ07cXVYjqvz9NiqPew5xoSI0LbULg3Z2YETJAMI1ghyLoZEndP9v0vP8j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861308; c=relaxed/simple;
	bh=3bjKwXr3tNdbCNJIfn130LqguJ3TOGCoAoBNutiivBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1MTvtl9d/7Hcqj7LoQFUDj4ZXmUzNIkPC2AdFUyNPvPaPdYuzvX9Xo99da8pVsss2BIONbI8oFdYY9dRPNWXDglddUd2+ZxMaFxxbXaj+2042Z5e6/RhBhpuZ8qd1az4pOoR4ADFyZHATODVxUNSrfq6UgMGul8w5QJtw7+vfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=GUfWye8C; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efdf02d13so16945279e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 05:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722861304; x=1723466104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WP3TDcwdS7rbvqo3h2WAW7LOD9LbYGzGSPJDJtBCZmo=;
        b=GUfWye8CcqqgnWvYsMhamNcSC2rW0SY6xtd7ht+HcJDiVuufD/77dL7+itVmkBSL2B
         v2+qE7viksklAm2bHIYnVmJJYKR99sPTaayfCkRzNwSXNKDyykVMBQGC9mdI/Y0Weg/u
         ZxWqmozidhfPdnvn7XXNPSLv4B7Ad93mQ4AwCzZrfAhVlibls294FUtwGP2LzEjepo6z
         0zU12CqvrV3VOdhBvLjoM5K8ZATSyw+rT5TTNzrZG2nJgk36wM6aD/qd8Iqm7NE958IO
         9dzQwcbYvTZOMrjXCVZkIFtvlz/zU1bofDhJZy5GRn4CB0o2ueK7lFrAIJMDSZs8DTL/
         8DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722861304; x=1723466104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WP3TDcwdS7rbvqo3h2WAW7LOD9LbYGzGSPJDJtBCZmo=;
        b=gD/xXXmgSFJHhzrDVo7YJoIm+vZHLfbfJB/DjfwtqFL4NSLA2vP0AREL5iuh6vcFNg
         C91VFfoHhmynGEYNSBzHKGNl3jP7CB3dTp3d4yPqw5soZXbBS0F3VJfhLMImu7haQL2B
         dhNkB4BhqP7jbDvavyTuDIhEwGNYuA3wqR+gyL86htUKcR2D+PWnbcrLbNcZ+j7KqiPk
         +1SJZ9k0zhLGNs956s4gWBWO89HuCpl3/dZhJFLjiv24T+gPKWqW14U7E/p5TwrsbAj4
         Q0obfD3E/9kC4Y1YmxrHMSxUQdD3nDXQXJXh83UdqHv4eWApYWW0N3sEqI9sL7xf5COF
         z+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyaRQS7zp0NXEXve5YM9ixhAGkop2bbytWw7mWIHS7ZvaRQPai6XatRERGFeCGIwr9xVzvX63DhnCC4NgrUv2DR5TLgSmNRTZAoZGp
X-Gm-Message-State: AOJu0YzSkS30zCRFiz4ZB276NeMxc476cDaQvu87no6Pp5hewsWG93H+
	r7BQ4PtiB2x/VzKFK587WhwfcU8p9ziwg5wXEQDSLjvvc5qBBWAiGNlmxyM2ZYWppLATIuQt4cY
	CmvY2aNJz25D6c+k2O9C+thL6vHFeqbVNPtf8zQ==
X-Google-Smtp-Source: AGHT+IFVNCkB9/DRJmdbf+zjkqWnFvmw1u/jKcw2DCF48IFpN0m3e/Vm61IsAgiljPY96jI7b3ZaxGtjzl88VXrcwOg=
X-Received: by 2002:a05:6512:12d3:b0:530:ac41:4cb with SMTP id
 2adb3069b0e04-530bb373747mr10726937e87.3.1722861303930; Mon, 05 Aug 2024
 05:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
 <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com>
In-Reply-To: <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 5 Aug 2024 14:34:52 +0200
Message-ID: <CAKPOu+-DdwTCFDjW+ykKM5Da5wmLW3gSx5=x+fsSdaMEwUuvJw@mail.gmail.com>
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
To: Suren Baghdasaryan <surenb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 7:01=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> I think you can check if this theory pans out by adding a WARN_ON() ar
> the end of psi_task_switch():
>
> void psi_task_switch(struct task_struct *prev, struct task_struct
> *next, bool sleep)
> {
> ...
>         if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
>                 clear &=3D ~TSK_ONCPU;
>                 for (; group; group =3D group->parent)
>                         psi_group_change(group, cpu, clear, set, now,
> wake_clock);
>         }
> +        WARN_ON(prev->__state & TASK_DEAD && prev->psi_flags & TSK_MEMST=
ALL);
> }

Our servers have been running with this experimental WARN_ON line you
suggested, and today I found one of them had produced more than 300
warnings since it was rebooted yesterday:

 ------------[ cut here ]------------
 WARNING: CPU: 38 PID: 448145 at kernel/sched/psi.c:992
psi_task_switch+0x114/0x218
 Modules linked in:
 CPU: 38 PID: 448145 Comm: php-cgi8.1 Not tainted 6.9.12-cm4all1-ampere+ #1=
78
 Hardware name: Supermicro ARS-110M-NR/R12SPD-A, BIOS 1.1b 10/17/2023
 pstate: 404000c9 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
 pc : psi_task_switch+0x114/0x218
 lr : psi_task_switch+0x98/0x218
 sp : ffff8000c5493c80
 x29: ffff8000c5493c80 x28: ffff0837ccd18640 x27: ffff07ff81ee3300
 x26: ffff0837ccd18000 x25: 0000000000000000 x24: 0000000000000001
 x23: 000000000000001c x22: 0000000000000026 x21: 00003010d610f448
 x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000000000
 x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
 x14: 0000000000000004 x13: ffff08072ca62000 x12: ffffc22f32e1a000
 x11: 0000000000000001 x10: 0000000000000026 x9 : ffffc22f3129b150
 x8 : ffffc22f32e1aa88 x7 : 000000000000000c x6 : 0000d7ed3b360390
 x5 : ffff08faff6fb88c x4 : 0000000000000000 x3 : 0000000000e9de78
 x2 : 000000008ff70300 x1 : 000000008ff8d518 x0 : 0000000000000002
 Call trace:
  psi_task_switch+0x114/0x218
  __schedule+0x390/0xbc8
  do_task_dead+0x64/0xa0
  do_exit+0x5ac/0x9c0
  __arm64_sys_exit+0x1c/0x28
  invoke_syscall.constprop.0+0x54/0xf0
  do_el0_svc+0xa4/0xc8
  el0_svc+0x18/0x58
  el0t_64_sync_handler+0xf8/0x128
  el0t_64_sync+0x14c/0x150
 ---[ end trace 0000000000000000 ]---

And indeed, it has a constant (and bogus) memory pressure value:

 # cat /proc/pressure/memory
 some avg10=3D99.99 avg60=3D98.65 avg300=3D98.70 total=3D176280880996
 full avg10=3D98.16 avg60=3D96.70 avg300=3D96.82 total=3D173950123267

It's taken nearly two months. and none of the other servers had
produced this; this seems to be a bug that's really rare.

Max

