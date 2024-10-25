Return-Path: <linux-kernel+bounces-382452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96DD9B0E00
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB38C1C21AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569D220EA3D;
	Fri, 25 Oct 2024 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zNaPU6kk"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF920D507
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883344; cv=none; b=hMufY0kbib69Jy5NAa3Izdm1Ov/XuHyAwyQiuMLmfILKGdXtkp10RvC3Yo5imt8C7QtUeXcw7qE+t5PyBnVEWj0Kdh57+sAcjEzsMRzQjD9Gk2NNiSt8YJ428IKT8gKaDPpr+7J6ffT7dBsp2fRLyjHOvTJhgRjOzLsigzKsvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883344; c=relaxed/simple;
	bh=eC/AFAYbf2dDY+8QOFJqZMSAG5tIud/WX+F+rwJdJoE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X2B9IfZPyWm2QDQTkqrsZ8Oz9hYA1P/Sctq8chkcHusVr8kUbrHr1U0HIopSgdC5FiMixQs9J3/UPnNhcEQl69Vzegs7Y8PhGXu5fyzpEeNoU9xPnc5h70M4uNLtA+yJ+0jqWR/d7+xaYaFfCYuhFkq0Q9Qzqk0PobHAr9rDC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zNaPU6kk; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ea0dbb7cc1so2557935a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729883342; x=1730488142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVWRF1EhwqPVh068E6HWf23D6UaTV/C79XZYsswklao=;
        b=zNaPU6kkNmHrc/O8iwNiOwzSuvEcs8bcIIybPUegMzjT9ywdL0T78Xq4iEPSELBWF7
         eD49LCrvdRGcy9+mvMNr1XjhAywQySIOvXEUHQ4qC7RkQqJUdr9kuoEWLQiaIPKSewvo
         or7U+o0lB/4Vuoq9dOxxu1vUK9e18WwuoeKN8Y0iBOC4hXJHc0dTdpAO/syvjr1k3loe
         8PQF9SbHPudZ6k8Hvk6Nr33y+ALewy3up5b0GD59b1yo/QnJhOVu5EJcSisX/fETgZvZ
         ReOk2chyTWF34f5evM/xSEnKyBfQw2OC6OIqAJUrGaX/hUZic8HR2ZBOla9kH7hDsCxO
         txyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729883342; x=1730488142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVWRF1EhwqPVh068E6HWf23D6UaTV/C79XZYsswklao=;
        b=pMiS95XSgIPI8TumrEHKzfusJo4ii5BBDlAU4n3HqBJooCNn5y6XRg7RYb1VFBep5X
         TtWFb4/2kyvmf2Vao4LxDoDWmdd5gUHhvYxRgsbDYf320UQhvQXEuZHjAmkST23rKENt
         VSfuS6Ycf/A5H7+J45KxviYuSOQtjyYJ2RyZO1yN8ocOxaO5P5VEW/walPif9Fi41Lut
         ScYffJpvcjmiWXfJDopFxbI0Oa3Xz4Q7jgIwPJ7plDGw993ero2t0Sl+y/uiEflghGwf
         yvxyT6fm8/5OF5HAUbPvcDW5kUwn6hkd9n6GFh+KFwgI/PrgoOYYl71TWeDVmNabhe0Y
         BF4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+8tz+7ICcPCLZ5gB3QieC1pAfq+Ihk4vMwcUPVsBsLmHJvm2eq1BixP/OixMkXoJ7pCRYuSrJe5+rDzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyauA1mHHrpGdRpjzjTYsCT0v7031wlYhgp5lMlj488YK0LBUo/
	HVxFGbX4sWKAF1pZ4z0ko7Xzcx4bJZu/ifiblM0iD8HB8uExUH4wTdf2reGnwcGp1Xy/I1BlXA=
	=
X-Google-Smtp-Source: AGHT+IHJvRe9BLo2HN0m+AxXH/BvYMMn7BIpiifD1eWAlC2PY4kjjioOtPMWBI6grulhDzsPYO6sUfue7w==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a17:90a:c90d:b0:2e2:a810:c3e4 with SMTP id
 98e67ed59e1d1-2e77e90a214mr13074a91.4.1729883342024; Fri, 25 Oct 2024
 12:09:02 -0700 (PDT)
Date: Fri, 25 Oct 2024 19:08:54 +0000
In-Reply-To: <20241025182149.500274-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025182149.500274-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241025190854.3030636-1-jrife@google.com>
Subject: Re: [RFC PATCH v1] tracing: Fix syscall tracepoint use-after-free
From: Jordan Rife <jrife@google.com>
To: mathieu.desnoyers@efficios.com
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, 
	andrii.nakryiko@gmail.com, ast@kernel.org, bpf@vger.kernel.org, 
	joel@joelfernandes.org, jrife@google.com, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, mhiramat@kernel.org, mingo@redhat.com, 
	mjeanson@efficios.com, namhyung@kernel.org, paulmck@kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, 
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 59de664e580d..1191dc1d4206 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3006,14 +3006,21 @@ static void bpf_link_free(struct bpf_link *link)
>                 bpf_prog_put(link->prog);

I think we would need the same treatment with bpf_prog_put here.
Something like,

tracepoint_call_rcu(raw_tp->btp->tp, &link->prog->aux->rcu,
		    bpf_link_defer_bpf_prog_put);

static void bpf_link_defer_bpf_prog_put(struct rcu_head *rcu)
{
	struct bpf_prog_aux *aux = container_of(rcu, struct bpf_prog_aux, rcu);
	bpf_prog_put(aux->prox);
}

Alternatively, some context would need to be passed down to
__bpf_prog_put_noref via the call to bpf_prog_put so it can choose
whether or not to use call_rcu or call_rcu_tasks_trace.

> -static inline void release_probes(struct tracepoint_func *old)
> +static bool tracepoint_is_syscall(struct tracepoint *tp)
> +{
> +       return !strcmp(tp->name, "sys_enter") || !strcmp(tp->name, "sys_exit");
> +}

I'm curious if it might be better to add some field to struct
tracepoint like "sleepable" rather than adding a special case here
based on the name? Of course, if it's only ever going to be these
two cases then maybe adding a new field doesn't make sense.

-Jordan

