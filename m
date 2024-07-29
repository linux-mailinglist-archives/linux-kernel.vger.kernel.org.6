Return-Path: <linux-kernel+bounces-266420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDB893FFAB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C19D1F23BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEFE18A926;
	Mon, 29 Jul 2024 20:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="rqeo10el"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C6918A92C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285743; cv=none; b=ATkNI9M7Yz53ZdmpI51TXM8pTHk8Gnm17d+9xZhQVPoa5pak//6KOIrFEjnaRsG9pcu8fnjA/J88v7PbwtdQoDds0gjiAii8rsh7V++3WQDzWACmaU4Tg2RCDCEMh7ZrOSZCBU5lVYBU/l09/upbtTWidRndncovVle9duaPeHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285743; c=relaxed/simple;
	bh=lHo3umKCFr/4l2FqmkS9QVYZeURvE4tr35KjuwOYvSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ynk+wZHzFKI4ICloN0EeJ4JS04EISFtLp8P8armZDONVG1jYx1NEoHybF4iVPRN1FFpuuHjjPm/r48Q2+qG255wQkAj4vbR/jQvhEe7eXaUMSAPum2Kni3H0ojkTqZQrh3k9osEu1t4ApA/6l9mEK50RxIu5YaYsq3Z9yF4tv74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=rqeo10el; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-67682149265so25426367b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1722285740; x=1722890540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvIpqVi/unqKf2PUGVFlRgYuRrsGWm/XOVaDJVH4J6o=;
        b=rqeo10elCkDaZdFCNM26ZV20yglOUpI5p5QS6i3A0s+IpcBTBSYuqEkjC8+yQdARPy
         o/15XO/5clptpupvSz+uH/Hnq/uHCJqVm/FMn9l5mP80Ss1+s1bc4g0CVKgYHmQZqSEm
         Mk2q1Hck1D/twSMvJQ0rqb7/nC6vJEM5pvXje5IucAu6pXNYMEg/O1WB0xNO4rntsm8p
         1EKO9gY480LKqv7gF32EXdwdyYuesLI7pGpkI0RM0QeHBE80+BFlgCuc0T/Ubv9mouap
         +rYk0K7OBQTOQIbSq4uy2P/vA2aFGfZWp1zbd72BBCg4D50SKsNNEkwdwyWfFvNVV1ZE
         JazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722285740; x=1722890540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvIpqVi/unqKf2PUGVFlRgYuRrsGWm/XOVaDJVH4J6o=;
        b=G8HS9ioSJWYWV989ADUxxArdx18XMPPNmlW7MMj6EABnMuOljo9v6dih5cfRM8p4TI
         Xh5EQ9rHrbnuQfqeumYE0QN8943dnU0sbCorKg+xqxRLx5ee8RO6rDgYnBWyXfn9+C2m
         GfNj4EgyXUOH3gYv0aM2eS61luZvlfJ5WkxcEaThykaaoMUWZwQOh76vh7cXo7gknWMo
         d02T/YWmRNaQ3amRMc3BC6TQMZYjgnTvTIpuU9KzEhZbfyXQj9e2EnhB0qPQAZIOcCI5
         K8XxRDwyVYtMRq5sUFDihsefuQmqqvrBx9R4HWXArvcoLi86elCbOftBuq6DfFLzXSqB
         +GLw==
X-Forwarded-Encrypted: i=1; AJvYcCW+eeLFLQwGQF95UK08VDgu0IWmnaH+Wyy/DMNHB9Si+LW/QVszDp33dzrYdoKzngOogHooe1Byrrs45WJECIFAy+1yVk8O6UvAwC1K
X-Gm-Message-State: AOJu0YyK7GnLmy4PO+k1KZRJzIkjHiJ12IbvIZ9RkPU4PvUxGAFeNB8/
	EZqDp0BU+GHcoFArbtdA8Pu39j6othqSCVWxy+MpgaZ7gZIo++q8nQsOvZrf0wjKxJJKdmEbssk
	1nw2UYo9YtGQanRDIgAXHkLSGcf/ClpN/BAMmEA==
X-Google-Smtp-Source: AGHT+IHKNbpWEjMOnF9stmCeCW3k6ca271+PmbgTXkWxWOxH6J5dueW9JQdeI3iW1JGDurQ1Dwl7/eXLBMf7ZnXxTHU=
X-Received: by 2002:a05:690c:4803:b0:62a:530:472f with SMTP id
 00721157ae682-67a09787492mr113265897b3.32.1722285739846; Mon, 29 Jul 2024
 13:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716811043.git.bristot@kernel.org> <CAO7JXPhWvLaaGqCGUZ_YCuja2T1ciWZoUnsUDnNPQ2b4yDB2Jw@mail.gmail.com>
 <20240729103253.GE37996@noisy.programming.kicks-ass.net>
In-Reply-To: <20240729103253.GE37996@noisy.programming.kicks-ass.net>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Mon, 29 Jul 2024 16:42:09 -0400
Message-ID: <CAO7JXPgPypC0z8SLTvt3gNndtLFaayGzh3V2uDf0D0BN1qjpEg@mail.gmail.com>
Subject: Re: [PATCH V7 0/9] SCHED_DEADLINE server infrastructure
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Luca Abeni <luca.abeni@santannapisa.it>, 
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, Thomas Gleixner <tglx@linutronix.de>, 
	Joel Fernandes <joel@joelfernandes.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Phil Auld <pauld@redhat.com>, Suleiman Souhlal <suleiman@google.com>, 
	Youssef Esmat <youssefesmat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 6:32=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Jun 21, 2024 at 10:41:35AM -0400, Vineeth Remanan Pillai wrote:
>
> > Sorry that I could not get to reviewing and testing this revision. In
> > v6 we had experienced a minor bug where suspend/resume had issues with
> > dlserver. Since suspend does not do dequeue, dlserver is not stopped
> > and this causes the premature wakeups. I haven't looked at v7 in
> > detail, but I think the issue might still be present.
>
> It is not.
>
> > We have a workaround patch for this in our 5.15 kernel
>
> That is the problem... your necro kernel doesn't yet have the freezer
> rewrite I imagine:
>
>   f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
>
> That would cause all frozen tasks to be dequeued, and once all tasks
> are dequeued, the deadline server stops itself too.
>
You're right, we are on 5.15 kernel and do not have this fix. Thanks
for pointing this out.

> Juri did some testing to double check and no suspend / resume issues
> were found.
>
> Anyway, I've merged the lot into tip/sched/core.
>
Thanks, I shall port it to chromeos kernel and run through the usual
round of tests and update the details soon.

Thanks,
Vineeth

