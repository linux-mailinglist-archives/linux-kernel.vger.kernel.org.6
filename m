Return-Path: <linux-kernel+bounces-214566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53754908687
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE3E1B25C05
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B9019148B;
	Fri, 14 Jun 2024 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nWwE/M0O"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7043190076
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354310; cv=none; b=Rg9vpKyQ7Mwtmu5z879EtE0M6ytlaLdSWcRuZIBjFUNhHTsHlV83g9TOW3x4lGBCgEKu3bfNt9tIQMIg4fkEXmbKRbzPJkI9N3Sv9UjWwq1FmvcIaNmNeYqCwzlPqxsuaEIDe+21f74ekjkNYmOYQiDC5VZRZw7xahiUrzDeQPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354310; c=relaxed/simple;
	bh=c+HO6rpfLBrq4Z9yOBu/M6P73t6c6818voOiVXvjIvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAvuTe3gTfbRZzfKVEoA5D4xt0Cbjagab+hKYB6kcdCUjtzn/72vUqIGpP0X4Aca1wM5cWV8t2Zwy9LoVb2U/4bwYywg7C6wmdbFtPhs2QwpS24Zhh8L/k6iG6wDIwOyUdwb8NdRWmEROZ5MWR17QgPgVcduL3eREOWHS99VMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nWwE/M0O; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso11670a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718354307; x=1718959107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+HO6rpfLBrq4Z9yOBu/M6P73t6c6818voOiVXvjIvw=;
        b=nWwE/M0O0gq5uplzuekjg8J8iE2rhreU+wjM7Hjp7X3pv4LmE4j3CP7BZiO/IF20GT
         80KEaHqMR/ams+VbM1aTX5tbZt1Rdc0hSsDa1d7BBRw94Df9kOruep7F6JWfID8lela6
         F7UrV5n+i1QjfH8WaeVoMztQoxVJF+7rMOCn7WIWlgxBLKvg2Fu/UtTq5xHhJDsG4U0c
         mCMSOrTX4P12oYhn2PXzFE7annnfucupBbnRC1kxtqvVHtlko3xJrGVp3Cjk3ylTRo1a
         FZDP+/gtSMe0pZhs/rEKLzNIuyAWmEYqgdML0/dkm9HoMGMAsv1euriOdJO6nGq2wojD
         012g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718354307; x=1718959107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+HO6rpfLBrq4Z9yOBu/M6P73t6c6818voOiVXvjIvw=;
        b=ZmAuFj8ei5mwV/lZ9ADaESYMqP694+foEjJ4gAmD/53OcGLHygsHcolN8hCeC+zTX2
         4h9XWUNVjIqfYmyuvgu9aug6qV3VlAB3NnsjuJepDmTzVVEbWz4ImEKm1hAwLBV6BeKd
         9lMmEXeHEPjCyEFdd1QBiZGx/Ihr/xm4Ypsk9OwkbZQNdphy/jP5z6BaomIc9UB18Ews
         Wk6JX7O8BdYCsGoq+ZMQyKD39489uNtb9ab7ajyuDk4Cczs0wM51zPdCEFQtcnfiYsEM
         TPTA49IxgC1QgFTT3CLlbXeGsATDtD+H9m4gqCfuHeNhuRhJZ+V0GmOleJQx1Z42Zkhi
         Dp9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQKLaSkxtMsF8b9H4nNkleATk/cMb8om8rzUzPArgsj0AfK2WrPc1vBGPgYcFZCKNBM0z6mhAu+hPG7rL0Z5/s8+mqBqq8ipV/VGs+
X-Gm-Message-State: AOJu0YzFY09A/W8sgM1uvFTZ6z8Jpl0mw6ttSX10rULLl86FzDd032yy
	HJx9WGqan1/iBHI7QRwLzezrmfsLKGL3Y5Fh3AP1jwi/KSfTJcdYYATIh0/6bVtX2ykiZPyrQ07
	zk4cCSM9HGYoaeZXes2NI+RU+V99SMHMAul+E
X-Google-Smtp-Source: AGHT+IGOJ5MzRHXpapB8/uqnzhCpdHHzyc6Kpzyhlgt7qEsE81AECbBjRCWFT0B+/wsFnnA9nBNpETQePCJed29eCyk=
X-Received: by 2002:a05:6402:35d1:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-57cbed0de04mr171811a12.4.1718354306227; Fri, 14 Jun 2024
 01:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612170303.3896084-1-bigeasy@linutronix.de>
 <20240612170303.3896084-9-bigeasy@linutronix.de> <20240612131829.2e33ca71@rorschach.local.home>
 <20240614082758.6pSMV3aq@linutronix.de>
In-Reply-To: <20240614082758.6pSMV3aq@linutronix.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Jun 2024 10:38:15 +0200
Message-ID: <CANn89i+YfdmKSMgHni4ogMDq0BpFQtjubA0RxXcfZ8fpgV5_fw@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 08/15] net: softnet_data: Make xmit.recursion
 per task.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, Ben Segall <bsegall@google.com>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 10:28=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-06-12 13:18:29 [-0400], Steven Rostedt wrote:
> > On Wed, 12 Jun 2024 18:44:34 +0200
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >
> > > Softirq is preemptible on PREEMPT_RT. Without a per-CPU lock in
> > > local_bh_disable() there is no guarantee that only one device is
> > > transmitting at a time.
> > > With preemption and multiple senders it is possible that the per-CPU
> > > recursion counter gets incremented by different threads and exceeds
> > > XMIT_RECURSION_LIMIT leading to a false positive recursion alert.
> > >
> > > Instead of adding a lock to protect the per-CPU variable it is simple=
r
> > > to make the counter per-task. Sending and receiving skbs happens alwa=
ys
> > > in thread context anyway.
> > >
> > > Having a lock to protected the per-CPU counter would block/ serialize=
 two
> > > sending threads needlessly. It would also require a recursive lock to
> > > ensure that the owner can increment the counter further.
> > >
> > > Make the recursion counter a task_struct member on PREEMPT_RT.
> >
> > I'm curious to what would be the harm to using a per_task counter
> > instead of per_cpu outside of PREEMPT_RT. That way, we wouldn't have to
> > have the #ifdef.
>
> There should be a hole on !RT, too so we shouldn't gain weight. The
> limit is set to 8 so an u8 would be enough. The counter is only accessed
> with BH-disabled so it will be used only in one context since it can't
> schedule().
>
> I think it should work fine. netdev folks, you want me to remove that
> ifdef and use a per-Task counter unconditionally?

It depends if this adds another cache line miss/dirtying or not.

What about other fields from softnet_data.xmit ?

