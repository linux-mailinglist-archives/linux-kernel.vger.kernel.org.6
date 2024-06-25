Return-Path: <linux-kernel+bounces-229674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0859172A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D1C1F22998
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0D317D8BD;
	Tue, 25 Jun 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OeYj/WLF"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1DE17CA1E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348342; cv=none; b=BlVSCsGPcZz9ooKZZjw5Jrjb3/sZOZ6b21O7kSNMdgDfzmdVq68IHvjbN04ks1SsbLTj43y1E0IQCe8nlFBIwYtA+0YGsV8pfKtXURHri6sdoRG3eDWt7nMY2bQABFVtmDTP0r5zypBNBUkHVlJ60tDMaRw982tgxI9cvPrNngs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348342; c=relaxed/simple;
	bh=z2P9ILY2ra5KqWGL88ltMawjFM8f8JfLEH0YHaS8cks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxwHTQjrJhuPJhTjEnTnZsqvf6TglAxE3dmL7OBwa9Y/T/MdXOzELV0tReiFeLlZhisQoWWn5vvd/6L6Cqwh309or9GBe33zWul8dUQtYXCa74RM0ATqmb3YuXpqeKOKV3xsfkY96B/9ZPsVwgw+xaJdP628x/HuY2gy6PcAu1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OeYj/WLF; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ce01403f6so3266338e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719348339; x=1719953139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2P9ILY2ra5KqWGL88ltMawjFM8f8JfLEH0YHaS8cks=;
        b=OeYj/WLFS+ZEgAcAl9fAVOPS+9irI6qcLwFZDQLjwITuyMAhxqruRFLQxgamoTJb+L
         B0xquBmeDo1E65A2poCBVqIpZbxCnXwZilLAtzDzHU6pREl8OtUT0ZiemqDwxMtMxIwu
         dyJltH+aQjU3VDLEt76nKwfj0lX5hCprRvpIrTtZIE06wRz0RIX2PJy3OgTWak5U/2dR
         NNVyPlHQx6SyNusDJlE5oKe85bcoSNAtPWpZAbdwPQilr1EyE95oFxSdNqTZCwT+jhb1
         LPt9yR7eV+Q9weYtCNKq070SoXhd5Z+ahkWVEKOr8t871S4SkI7xHjVGydkBBQTJXYBg
         e1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719348339; x=1719953139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2P9ILY2ra5KqWGL88ltMawjFM8f8JfLEH0YHaS8cks=;
        b=gM7DZTO1zjrxWlrce4dyfALilENzYp5zqHXUvCcqoMRD8x71OoDaV/g65l5Mgh56L/
         yj+jkKoXbZ37O0S40QVCNNo+jiY++86zyvYpCNHILX0M5TGGIZMeRmOfq1ZNq15ar7o4
         U1V8b6CPFZXfyWRN9QZ3MEQ8C0FEjyhnWibO+FNxpHFzhehNlUI1CNA2TaZoErupR9G0
         9BAyHG+0i3/t7GuhTke5BqcUKslO6Smn/DI4JAv5Bo58IAsJT3UzRne7CyqzZm0WPZes
         OM+8sYmFHupHzOFr5sUFizUSY9Ad+X8CHfadm2HhdAJzJ1sqvQweDm//ntFzlhtgpMWq
         B2Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVej0MJxzR8yMixyOLRuzvdLs8D7q4k7b9B9TNoh27nf8G5f4EsfxEpg9pRTKnsHHzxnJYViYm5XTSohfS/MJwBbVg3Ocwhf6zs1bGS
X-Gm-Message-State: AOJu0YzuhCQNKCR4Cdx6VRZeqc/eFXrtlkUslXCaI32hfpe45AE1SPbI
	dVMUN2ekGMh2oPyp2dHI5Hba8xrpj/vNbI+kLD3PUDjGPUg1mD2q55BxfA7+y+wemIBEjA+nERY
	paNZloQXcvMqJTCzwvNdAoggS9xhxer68Z5Aq
X-Google-Smtp-Source: AGHT+IGOwOIPTe1qutlh1r9o9P0YrOPCFsE9vhdaTAjW/ucgyIdCYhurdY+x8wDI4ZrsfLorY8Gw/yOrHlksTP5KFMk=
X-Received: by 2002:ac2:550d:0:b0:52c:e126:3d50 with SMTP id
 2adb3069b0e04-52ce183bf44mr4713958e87.36.1719348338679; Tue, 25 Jun 2024
 13:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <exnxkjyaslel2jlvvwxlmebtav4m7fszn2qouiciwhuxpomhky@ljkycu67efbx>
 <CAJD7tkaJXNfWQtoURyf-YWS7WGPMGEc5qDmZrxhH2+RE-LeEEg@mail.gmail.com>
 <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg>
 <CAJD7tkZT_2tyOFq5koK0djMXj4tY8BO3CtSamPb85p=iiXCgXQ@mail.gmail.com>
 <qolg56e7mjloynou6j7ar7xzefqojp4cagzkb3r6duoj5i54vu@jqhi2chs4ecj>
 <CAJD7tka0b52zm=SjqxO-gxc0XTib=81c7nMx9MFNttwVkCVmSg@mail.gmail.com>
 <u3jrec5n42v35f3xiigfqabajjt4onh44eyfajewnzbfqxaekw@5x2daobkkbxh>
 <CAJD7tkaMeevj2TS_aRj_WXVi26CuuBrprYwUfQmszJnwqqJrHw@mail.gmail.com>
 <d3b5f10a-2649-446c-a6f9-9311f96e7569@kernel.org> <CAJD7tkZ0ReOjoioACyxQ848qNMh6a93hH616jNPgX3j72thrLg@mail.gmail.com>
 <zo6shlmgicfgqdjlfbeylpdrckpaqle7gk6ksdik7kqq7axgl6@65q4m73tgnp3>
In-Reply-To: <zo6shlmgicfgqdjlfbeylpdrckpaqle7gk6ksdik7kqq7axgl6@65q4m73tgnp3>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 25 Jun 2024 13:45:00 -0700
Message-ID: <CAJD7tkZ_aba9N9Qe8WeaLcp_ON_jQvuP9dg4tW0919QbCLLTMA@mail.gmail.com>
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 9:21=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Jun 25, 2024 at 09:00:03AM GMT, Yosry Ahmed wrote:
> [...]
> >
> > My point is not about accuracy, although I think it's a reasonable
> > argument on its own (a lot of things could change in a short amount of
> > time, which is why I prefer magnitude-based ratelimiting).
> >
> > My point is about logical ordering. If a userspace program reads the
> > stats *after* an event occurs, it expects to get a snapshot of the
> > system state after that event. Two examples are:
> >
> > - A proactive reclaimer reading the stats after a reclaim attempt to
> > check if it needs to reclaim more memory or fallback.
> > - A userspace OOM killer reading the stats after a usage spike to
> > decide which workload to kill.
> >
> > I listed such examples with more detail in [1], when I removed
> > stats_flush_ongoing from the memcg code.
> >
> > [1]https://lore.kernel.org/lkml/20231129032154.3710765-6-yosryahmed@goo=
gle.com/
>
> You are kind of arbitrarily adding restrictions and rules here. Why not
> follow the rules of a well established and battle tested stats infra
> used by everyone i.e. vmstats? There is no sync flush and there are
> frequent async flushes. I think that is what Jesper wants as well.

That's how the memcg stats worked previously since before rstat and
until the introduction of stats_flush_ongoing AFAICT. We saw an actual
behavioral change when we were moving from a pre-rstat kernel to a
kernel with stats_flush_ongoing. This was the rationale when I removed
stats_flush_ongoing in [1]. It's not a new argument, I am just
reiterating what we discussed back then.

We saw an actual change in the proactive reclaimer as sometimes the
stats read after the reclaim attempt did not reflect the actual state
of the system. Sometimes the proactive reclaimer would back off when
it shouldn't, because it thinks it didn't reclaim memory when it
actually did.

Upon further investigation, we realized that this could also affect
the userspace OOM killer, because it uses the memcg stats to figure
out which memcg will free most memory if it was killed (by looking at
the anon stats, among others). If a memory usage spike occurs, and we
read stats from before the spike, we may kill the wrong memcg.

So as you said, we can experiment with in-kernel flushers, but let's
keep userspace flushing consistent.

Taking a step back, I just want to clarify that my arguments for the
flushing changes, whether it's in this patch or your ratelimiting
patch, are from a purely technical perspective. I am making
suggestions that I believe may be better. I am not trying to stop any
progress in this area or stand in the way. The only thing I really
don't want is affecting userspace flushers as I described above.

[1]https://lore.kernel.org/lkml/20231129032154.3710765-6-yosryahmed@google.=
com/

