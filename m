Return-Path: <linux-kernel+bounces-438796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B729EA616
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D7D1886B20
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832B01D5CE8;
	Tue, 10 Dec 2024 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="ibYzfgWm"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA2A1D31B5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733799548; cv=none; b=E7Q8j3Mh5aoRTQNtaf+xF8GiP5yNEFhIZX0iolb0Dm7+sxqYEuiF7nlITXdGJ6jx8nEgqVD27cSvYpNrbzWGT1C8GWydg17QpJ4DdxhZgMFYOB243JptItP38mAzWI4/pUQ3NF4ZK2CAVXFwzIq1daEhLUgyv2BttaEpfx9Cj8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733799548; c=relaxed/simple;
	bh=bfsUeisHEu6lR+oxAOInMQv/E9b73VupUc7a5RdlakM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0V8CHXflCb/iygY9kmZeCC7RMH5VGoOQJBscWWou36+0Axi4qc6TcxP/4xVzLWYxbCIeQ8awEU41BKZgs57PhMjR9Km8ciD2+ysYyayHL1BOCRM8StNlbahdRhvxOmIqOhKD+QT0l8bC4pk0+BZuT2ci+WCQIOoGiAnwQXZ8KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=ibYzfgWm; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6eff5f6fe07so20156437b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 18:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1733799546; x=1734404346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rs/gW358ue5xC/zVahNg27eE6CQJ16ZkM7/3bu7P/XU=;
        b=ibYzfgWmgK5DQYAE2AP2KA8L6GoJnqNwBjwBv42pfNY+xFuA7LTtIHd9643GQIeXmt
         t9lKQOrxlrtaIB9dqA9y6b/CYbaa0be649iM9Ckn2D0CHil0/hHQmuRPeckMZGQhoz2+
         EYlUs13ZFKacLyBsTD53WZ1ElgQFygDbrGFzWu/WCN9lsWz+9K31bZn/fSyZvPO4rb3L
         EQrBy0604IClHcVpIHgMoH2RF2a6K6EAzH9Nu/BndzsF/0wvC4xL/GQtNU/vKII+oeHU
         pUR6cfZLmeJXDRoXJLVCgRL5D0W5+l50vX8y7i9W4TO4mvZnrL1iBJ8FOgECYQufHEHU
         YlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733799546; x=1734404346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rs/gW358ue5xC/zVahNg27eE6CQJ16ZkM7/3bu7P/XU=;
        b=aR/jPBAQTQrkhiFFdTWNH0kMi4uz9czYPxAXL4C+N8tcksQwfEE5zao+f29T7kfy7g
         Ui4PFxBqmvuCxodyajd1UAWrv/JB+5k8pE0fzM3yQtN5a1GERLTIYgBib/lhhZ+zrMQk
         q/gH4lBHDrrkdOxZpCaojYXdezhAe0AgvS+qC0WkA+k+X/S0YcWXY9/cdIICUuAi5UXi
         bgeSyX4Po2esfEZxOu0pphSUd1dQboA9cb9BIPqSK9jD6j+aI5RFCnEXPrYpH6CHoZYa
         iPk5JCiNo2piucccEMr6PKth/JILmV1zDLZ0ThJpB3Jmq4C3rgWv9gbjZExiuoCPRjS2
         VXGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHbRUppsfhxClSKIfylibvD6YaXZN/8nb8Plg1gpvbHolXWj9yKRuO6cJAimjVPnEe3/7m01gUohlZzI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUGQAAExqUkzmf/CdyhVkCON5yQr1sYx5aKIytbDXxsiCbMXpE
	Loh8oGGZyn8gDqEYTZLxVGr03ujlGWcK53XyE3BYBzV52AYCZ2TncNntZjvA/eY9Ra8E7yCFjye
	6wJbS8cSb7fvAOeGgcI9br3xJqTC6HzTKM43L6g==
X-Gm-Gg: ASbGncta7A0jqdkCCvfF4EWDc1SkuIty8Bo+jh7XdeOsIMROdaDwLuQrYfk6v3XaZOn
	TOfSZW4vmh6tuEKvHmUg7IJp93dQAM6006tI=
X-Google-Smtp-Source: AGHT+IGuRz2Smsv5Gv0WeNvOJXdl+g1uOqY3a7aG3ffg7RUTxEcYRsKmrrwaOk2UxHLS6sZUeRQh8/wRJ/BwT5mfMCg=
X-Received: by 2002:a05:690c:6f86:b0:6e5:adf8:b0a8 with SMTP id
 00721157ae682-6f0258377cbmr19715607b3.6.1733799545816; Mon, 09 Dec 2024
 18:59:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org> <20241206151819.GA3949140@google.com>
 <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
 <20241209105514.GK21636@noisy.programming.kicks-ass.net> <CAO7JXPgSYCzu0mtnWqBaS8ihmoQXX3WE_Yb_rEYuMeQn+B6KJg@mail.gmail.com>
 <20241209125601.GQ35539@noisy.programming.kicks-ass.net> <8ff30c5d-b8ac-4825-874a-d73931b85014@ovn.org>
 <CAO7JXPijXstA3Eh_LrRGiK26U1Mfn8C1jSXP+4kfTnQRxSax7g@mail.gmail.com>
In-Reply-To: <CAO7JXPijXstA3Eh_LrRGiK26U1Mfn8C1jSXP+4kfTnQRxSax7g@mail.gmail.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Mon, 9 Dec 2024 21:58:55 -0500
Message-ID: <CAO7JXPjGFmfwAVcSaRhtM2Mf=V9P6oQm6H=QfHcFhtkLU8magQ@mail.gmail.com>
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, vineethrp@google.com, 
	shraash@google.com, marcel.ziswiler@codethink.co.uk
Content-Type: text/plain; charset="UTF-8"

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fbdca89c677f..1f4b76c1f032 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1159,8 +1159,6 @@ static inline void update_curr_task(struct
> task_struct *p, s64 delta_exec)
>         trace_sched_stat_runtime(p, delta_exec);
>         account_group_exec_runtime(p, delta_exec);
>         cgroup_account_cputime(p, delta_exec);
> -       if (p->dl_server)
> -               dl_server_update(p->dl_server, delta_exec);
>  }
>
>  static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct
> sched_entity *curr)
> @@ -1210,6 +1208,11 @@ s64 update_curr_common(struct rq *rq)
>         return delta_exec;
>  }
>
> +static inline bool dl_server_active(struct dl_sched_entity *dl_se)
Sorry a small typo in here. it should be struct sched_dl_entity and
not dl_sched_entity. The line should be:

"static inline bool dl_server_active(struct sched_dl_entity *dl_se)"


Thanks,
Vineeth

