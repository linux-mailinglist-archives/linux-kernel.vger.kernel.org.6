Return-Path: <linux-kernel+bounces-526534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752F7A3FFEA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769D7176CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE162528EB;
	Fri, 21 Feb 2025 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9L7fx9B"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE62528F6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166994; cv=none; b=PhYjZvK2CAsREZkAjAGJTy1Dp7EArVa469SZyWtVFqgGhgd4ko6M+2S0IACwbvMxBnmuWTqss9w24dbBcz4mZFjDTZJ5E1Ct8TSKlUVZPOvLr2hFEpTqbZGriFMLMKLPt0XCwIv+r56XbAHcadj6Go5BhBz3P0579L6yg+77YS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166994; c=relaxed/simple;
	bh=a523ZQbh86bpyY1RTd3hAJpiDjMv4pYA2cxq33Emrqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a25+/13HMYW8IJNMdUnQt/I4deTEpbv9GBaBixcEYEC0crW0b4VCzt5JvBLijjKSiFjQRs2KCptBX0mmMBRxefldt8vef2lGSsorT9TN8coRP4ZhvEEfX9sl32R07Cl+LjIhm+/nFVSTg+x3S2O8YXX+J8DxFku7XP4JAk3CdZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9L7fx9B; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-471fbfe8b89so53941cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740166991; x=1740771791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a523ZQbh86bpyY1RTd3hAJpiDjMv4pYA2cxq33Emrqs=;
        b=M9L7fx9B/RroN8sQe60TiC6lMg4R8qZw2IUNRzm5QnZqf0LUL92prfLHuuvPp++d7i
         XapMhlMI6lY06JbH+AfiR10mZAeBiUMVGi5al4blEDcqIz46lRXt2O01zHQhZwYipltm
         FbbfJx3Bw7BKAIhw3IgOBR7N019eep2vFihLSLaIKosJiTTkj8TCJuIZwP4xnDZJZal2
         7nUmpjhdzISAfP/d3LTb21F10urhxbPV78TMB2rWqt9OBp1RO8YY/v/Q4hVtogV+Ro3n
         q5umoPsfVULE2dqDgKA7QS4LEkY54SFgAZceEChhX4CB6zw6+4hszWsKL7XejMwROsAs
         owkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740166991; x=1740771791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a523ZQbh86bpyY1RTd3hAJpiDjMv4pYA2cxq33Emrqs=;
        b=tM6cP+wUZ6RMeVSyuivRL7W3X30n3SVZwID5UuRocxR3eSwIq1ADpeHXKvpPPjT4wC
         A2JAHEJqTRcAiE05pGN764Rogwc5FhAn0FYTQXA5iT06/DvCvMT2spWLrNEU+rwZqxz0
         z4OAIWcIrbRLBdHpjPylCLFrmjpusy7JEqxF3IvVDq5NxTfAi+eWlcEBXE4BBfNHNkYB
         61xQ8MaqwKhkg/9IG22j1MvvMuT/tN+VH2/iaCnbpc/pEt/YFTD2DU7e+ag54K7YQfyl
         TkK+YXsTmzuQDMrwb8yh6Dd8k1WyeorxYGD/qmSRYqTTBg4dDU1v5Sqo8dHjSNlZTeN8
         AElw==
X-Forwarded-Encrypted: i=1; AJvYcCVp8Ln4vrX6jmzcqaOX/H+7EAF8qmLwHftLzP4Jg4GP7dJnprbopVRUkXt+SpWCxPoxHRJCHQuJrp1g6W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBfbSfS4mWrG4sfkNZvs2mCSFpRlb+a2pVKpwx5g6TbnruduJ
	JoL7N530864GDASCzVeqnq9GSeHaFDJiYnTzl7tt0hVvEayBLeFV36neulRwH09ki0iLVONBDx+
	9pw88pAviE8ofWo/DBdsGu7OxKaE6w8S+HfpO
X-Gm-Gg: ASbGnctM7eEzpdwjfU5G8F9ETGNmXLTF+ElgKJbGlHb3Ek40hyKvRxAxhMWPRZKUaCr
	QDZyMAWNkB/tVB/BoRxpILQUwXTOOqBJkcdAs1Lt7VDMr3NogEY73BDm7tCbFM86D5mCaCmaRH4
	wf+B/lUrwC
X-Google-Smtp-Source: AGHT+IEOnjZFiRhGxpDJtRI7e1BzpTxFXUpSnGjB68hdpcYJt/skKBjWPsMwz7ISV8LbfReXO+Memq+SOXK0w7M5oLE=
X-Received: by 2002:ac8:7f4b:0:b0:471:b96c:7267 with SMTP id
 d75a77b69052e-472335845f9mr206901cf.20.1740166991241; Fri, 21 Feb 2025
 11:43:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220093257.9380-1-kprateek.nayak@amd.com> <20250220105558.GJ34567@noisy.programming.kicks-ass.net>
 <b2386349-2879-4dce-afb0-f6486c24c117@amd.com> <20250220113227.GL34567@noisy.programming.kicks-ass.net>
 <59d46dd3-33da-4e95-8674-d93fc00d73f6@amd.com> <CABk29NuQZZsg+YYYyGh79Txkc=q6f8KUfKf8W8czB=ys=nPd=A@mail.gmail.com>
 <f4fed3e7-bc64-4717-9939-cd939e0aceea@amd.com>
In-Reply-To: <f4fed3e7-bc64-4717-9939-cd939e0aceea@amd.com>
From: Josh Don <joshdon@google.com>
Date: Fri, 21 Feb 2025 11:42:59 -0800
X-Gm-Features: AWEUYZk5ruyrDHbpBVUV2yisf85ZTa8h0dd93_WN7GhaYhAD1eBvGpXDW_9DlNU
Message-ID: <CABk29Nvn6qwfZdN-DQJs+KUSch=RcJ7Fa+S08a9tiwZvDEUnxQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/22] sched/fair: Defer CFS throttling to exit to
 user mode
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ben Segall <bsegall@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Valentin Schneider <vschneid@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mel Gorman <mgorman@suse.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev, 
	Tejun Heo <tj@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Barret Rhoden <brho@google.com>, 
	Petr Mladek <pmladek@suse.com>, Qais Yousef <qyousef@layalina.io>, 
	"Paul E. McKenney" <paulmck@kernel.org>, David Vernet <dvernet@meta.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:38=E2=80=AFPM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
...
> Just out of curiosity, have you tried running with proxy-execution [1][2]
> on your deployments to mitigate priority inversion in mutexes? I've
> tested it with smaller scale benchmarks and I haven't seem much overhead
> except for in case of a few microbenchmarks but I'm not sure if you've
> run into any issues at your scale.

The confounding issue is that we see tail issues with other types of
primitives, such as semaphores. That led us to trying an approach
similar to yours with treating kernel-mode as a critical section from
the perspective of e.g. CFSB.

> Is it possible to share an example hierarchy from one of your
> deployments? Your presentation for LPC'24 [1] says "O(1000) cgroups" but
> is it possible to reveal the kind of nesting you deal with and at which
> levels are bandwidth controls set. Even something like "O(10) cgroups on
> root with BW throttling set, and each of them contain O(100) cgroups
> below" could also help match a test setup.

Sure, I can help shed some additional light. In terms of cgroup depth,
we try to keep that fairly limited, given the cgroup depth scaling
issues with task enqueue/dequeue. Max depth is maybe around ~5
depending on the exact job configuration, with an average closer to
2-3. However, width is quite large as we have many large dual socket
machines that can handle hundreds of individual jobs (as I called out
in the presentation, larger cpu count leads to more cgroups on the
machine in order to fully utilize resources). The example I referred
to in the presentation looks something like:

root -> subtree_parent (this cgroup has CFSB enabled, period =3D 100ms)
-> (~300-400 direct children, with some fraction having additional
child cgroups, bringing total to O(1000))

Best,
Josh

