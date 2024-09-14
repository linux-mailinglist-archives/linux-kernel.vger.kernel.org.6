Return-Path: <linux-kernel+bounces-329026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F8C978C3A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 02:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AFA2870F2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 00:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7A42F56;
	Sat, 14 Sep 2024 00:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TcuKtfXP"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C04C6E
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726274244; cv=none; b=eg1k8nlGPf8gIXOOL0TqDGXxUbc2n+bt8n7VB/kHp8NG2jY/1pg5zb3JXVl4YCScIItnSf3UM7WeRvQG0wmZU/ptOIVV4gMVbPFnRnYCKNPdM4MqmftwUQoPL4gbqPBzyBh8gmRj2CCrfygGpJdfBMYIQcVHgtuLweQ/wN9VnHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726274244; c=relaxed/simple;
	bh=RTzDpsJT3aW2jJibA0QXRjsEY5d1N4cIw2XADng6ot0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ffy6NI29IPIjh3iDDDVQwXNtAJeR72s6uE5qO/kNLQBylQpAPhI4NAm1gIzFiGrAYhPfn93DTccrgq1o1L4eX8oBE7D7+fNPWWNg6cdOg6eiJO7CMoQ9OI4HQmQH5bm8KhXoNPLKIth00XIMsjEaHMigL8dMO86taQDIECv+esU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TcuKtfXP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-378c16a4d3eso1507633f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726274241; x=1726879041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+jOycPGSwq1ePA6ixu4fJZLfQQpDHMjNmpy29S17Wc=;
        b=TcuKtfXPL8zNPcZNfza941b/pVY7cxiSteL37zdW5Lefkavuamm8Ix3xeBdjrrkDC1
         nH2iKQ4NhzmkLrPjKL2jFen5awmj2lwLGg4plY+/DqiltTvSh7PR3ObbDLORvw3NpYfY
         gaTvWnA3mvQ6hmQHZ87TUFxISnS4hF5OF6pG7MCjCVhVpTGX2MAlmt1ACZh77ApTBl5F
         mSxUbxde+AsNXNms2tYn7hZWhTT3a5NCIgMtJRuK04LpvXgtZ3pQPwl1xx8txUQmg68S
         kuy83KEF7zWsuXdDf4DQk86xH2xXFtzPgFSXgX5qjS48wDjj+Pk8a/DIyAltT4cntqko
         0V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726274241; x=1726879041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+jOycPGSwq1ePA6ixu4fJZLfQQpDHMjNmpy29S17Wc=;
        b=DyQCWM+l0X3pPaUu1QE/ufBdxEa2jmeUfCP3HkKibBuhv37r3bb7rzTcef7BcEorY/
         x4pRKgi32ESStHPpHB8ECXTztM4vEFqi3t2LMlnbNgBTqb8vTjC2rAYlUn1hrSgS1MtH
         kNxY6VjiUx3PWeowj8h8PzzevgYGveD39ENXXLiP4RRxX+uWJWjXGMoyuq8NT5Ae/EqO
         5smbma223YZwaf10gGdfE5rzPTjhWcOi0DlDUYQYdh/2i27136GQMIEuzf/XmR3M9QH2
         2hdtp+VlBURj8387cZO/u/4zzQbYOesFfOsIOtKGcMF7H4b6Neoc1CDRYhIVZNTMLmwH
         sqDQ==
X-Gm-Message-State: AOJu0Yxv0pd2PDBZpQ1AnOeSfeRt1wmCB+w9mR1vQz8wtNK12vog/2vB
	OYJ01wz0QMgDX0a2cKNxAbIfNENP/cqHyafn0ozSD4R+ulBOHFGbYSgnxOD453gAXrZEpX6Jop/
	0LNRsqVk4s1UKdHoqjDF+4nQiR8WCGw7Zf7s=
X-Google-Smtp-Source: AGHT+IG0R3iZSYDceJ8QQ7aQUZ5mvB7fALHhi5+yuQq3+Zk4UOHO9Z9eK9IPl6HzSfkk6HkzS8GeL1OtpkYSa73FER4=
X-Received: by 2002:a05:6000:1862:b0:374:cc4b:596e with SMTP id
 ffacd0b85a97d-378d6235e10mr4454924f8f.37.1726274240277; Fri, 13 Sep 2024
 17:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910221235.2132138-1-jstultz@google.com> <20240910221235.2132138-6-jstultz@google.com>
 <a608c2df-ce2b-45d8-94f5-16c830104d46@arm.com>
In-Reply-To: <a608c2df-ce2b-45d8-94f5-16c830104d46@arm.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 13 Sep 2024 17:37:08 -0700
Message-ID: <CANDhNCoQU3x7tkXve0Tuwyo_WDTq8-pNbmsAHcABPJCy2txpog@mail.gmail.com>
Subject: Re: [RESEND x2][PATCH v12 5/7] sched: Consolidate pick_*_task to
 task_is_pushable helper
To: Christian Loehle <christian.loehle@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:29=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
> On 9/10/24 23:12, John Stultz wrote:
> > +static inline
> > +bool task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
> > +{
> > +     if (!task_on_cpu(rq, p) &&
> > +         cpumask_test_cpu(cpu, &p->cpus_mask))
> > +             return true;
> > +
> > +     return false;
> > +}
>
> The slightly awkward
> if (condition)
>         return true;
> return false;
>
> is more convenient for you for the tri-state later, I assume.
> Fine by me FWIW.
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thanks so much for the review! Very much appreciate it!
-john

