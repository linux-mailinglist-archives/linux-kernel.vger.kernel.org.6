Return-Path: <linux-kernel+bounces-424537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0556D9DB583
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 864F0B22859
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA47418B495;
	Thu, 28 Nov 2024 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1EkPAzH"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FF113B7BC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732789499; cv=none; b=o79bhp0868WYlwvD8IEUrMJd25PJghXpvshFTEQf+ePVuY3e5I33evkyM1rVEnZZwNXI3+xoct3lE3jZ4S5UBgxosObzZZfyOTjIMVit6w37ip8cBlFl9/oggVVOSHrIHX7ITQ4a3QrXDg8BBB0SiNUask6eoeqEzg+q/i0xaqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732789499; c=relaxed/simple;
	bh=u3IYcYpkXnr9O1ePigQd7rLEa0cVnBjI/LxiDXIUnTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaSZCd1FZep9cCHPaP9GjSrdW0kCGzpXq/hdIwCl6rlwpAFLEuz8xj49yI4iD291CsF2tRN9lJGM3LZ0AReRZw1bEUAa8ik2RYtdJ/r2ydB9IWs775RMQUaaghCCRpaV5n2rS+5/kKmKJ8dArFNb0cj36KCQg9d3KR/G/QM3sv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H1EkPAzH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ede8c4fedeso587199a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732789497; x=1733394297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u3IYcYpkXnr9O1ePigQd7rLEa0cVnBjI/LxiDXIUnTs=;
        b=H1EkPAzHoilglKAsYhthmOPz0ccIgi5X3Gh5P81CkxjKMi+gYCSf9pc4f63n+9faxX
         oWxdCvDTcxNzoV/hEsc63SM6nGhMMPs+m/4YQpnM0TgkswjYFTNK077BVEv7rSj2/dVB
         Ey+4DN63lsnw6kunsdns1QcUTKzrgAhp2GKRdVhLtkjn2ZoTGnWVMHStsw4bvk75h5wj
         xk5hQRujAlU9cqpdRfLolDkERt37YUObHTRJlHrB7TLfvo/O+zQGy7vrUtTqj5tv6hgM
         nS89j747Zfa797rTk0kRKlRWPDoCobCNNf6eTX2E+jFkWEYN0PlBJ6s6zrQ0FN/i0x4n
         Rq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732789497; x=1733394297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3IYcYpkXnr9O1ePigQd7rLEa0cVnBjI/LxiDXIUnTs=;
        b=R7P+Grweu6mJ1qka7mPtIl35c4isVxvbawofOyYe6cd/wd3ECYG7EXL5oa2d9Si8/R
         xgoOM1JkOjDpEPBewz7br5eDWHWQtgpuP+iUYfrLkvReiHu/ZYTNhW6UpZS07HAyLZkr
         7CCvyUC5Pnb2aCeCl43/JXNDg/y9Ay9h+DfiNVdxA5U1fhQqd0+UeCe93kp6bUp8V2Te
         ImlX9lg15uD5pNCy878OysXRLlXbaXOWBj5epZrnL6z0CDbVuNakr8YNAV+o+sdnnx/a
         LUOWWIBWT+BMlMizMLt0l2GTy+op4raip6s7VvCQ5R+apzbfbzj/FemoxJFJpRT14NhF
         xftg==
X-Forwarded-Encrypted: i=1; AJvYcCV+JdayhHAAwyHxO3YoHEVD/rxh4S+u2yyttl1ZVerjmrB/5gysRVo3BI2eMpvDB4ba9zyyYPM3ufplLTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOaCabtQHl+b0ax5VQYHGAGxj8E9S4tYGhJ81KlBdyq42+PoVw
	doYifGqjs3UtQkeZxkFI35oBy1xRWGYpIrqD+ctQe7N61yGJXMMz059G5+26FE0moaSauSno0gG
	ScvVykewaBKnNnQscmpt4mtIHMQByTd9SiX/+Hg==
X-Gm-Gg: ASbGnctD7qZ0XFvhqyr9KfV9/au4WoiMwIcNDI1wG0xGwEEIggECqJtOxvJuNEkWv5I
	P0DOwkZIgok0LgejKIuakswqPRWssbs9961pLP1rXwvPhbva8pStyw62RhkM=
X-Google-Smtp-Source: AGHT+IHtfSXkUU3eUtv195chSt9aBRkB/c5fHcAlDeTYByyWXoOpoiTTdWXPPCDFLxVpOlB0VGa6P1CRZ6op4cVQrfM=
X-Received: by 2002:a17:90b:4d0d:b0:2ea:bf1c:1e3a with SMTP id
 98e67ed59e1d1-2ee08eb2ae0mr9631094a91.12.1732789496922; Thu, 28 Nov 2024
 02:24:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128092750.2541735-1-vincent.guittot@linaro.org>
 <20241128092750.2541735-3-vincent.guittot@linaro.org> <20241128095643.GB24400@noisy.programming.kicks-ass.net>
In-Reply-To: <20241128095643.GB24400@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 28 Nov 2024 11:24:45 +0100
Message-ID: <CAKfTPtDKy+Qv63G+o8A4-izJYOExPaa4Z7FAFevBJRaaewbX4A@mail.gmail.com>
Subject: Re: [PATCH 2/9] sched/fair: Add new cfs_rq.h_nr_enqueued
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, pauld@redhat.com, 
	efault@gmx.de, luis.machado@arm.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 10:56, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 28, 2024 at 10:27:43AM +0100, Vincent Guittot wrote:
> > With delayed dequeued feature, a sleeping sched_entity remains enqueued
> > in the rq until its lag has elapsed. As a result, it stays also visible
> > in the statistics that are used to balance the system and in particular
> > the field h_nr_running when the sched_entity is associated to a task.
> >
> > Create a new h_nr_enqueued that tracks all enqueued tasks and restore the
> > behavior of h_nr_running i.e. tracking the number of fair tasks that want
> > to run.
>
> Isn't h_nr_enqueued := h_nr_running - h_nr_delayed ? Does it really make
> sense to have another variable that is so trivially computable?

I changed h_nr_running to track only running tasks and not delayed dequeue

With this patch we have:
 h_nr_enqueued := h_nr_running + h_nr_delayed

And I remove h_nr_delayed in a later patch to keep only h_nr_enqueued
and h_nr_running

>
> Also naming; h_nr_enqueued isn't really adequate I feel, because the
> whole problem is that the delayed tasks are still very much enqueued.

