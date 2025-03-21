Return-Path: <linux-kernel+bounces-571083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7858BA6B8E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAC41891B71
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C79921B9F5;
	Fri, 21 Mar 2025 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I34AwKyj"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB971F03C4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553465; cv=none; b=euPDXM7QcKH9PfkWtAHiKg1hgotp9kpJSF5NW+lsWxtmG79Tj1kXqZuB4Zx0UFI7RmopPL9Nm94QufcMLYHTpuon/SGrulCFnohjXHpwcEfomW9w/OiCIYBB/ng6MqEtA7bCR/WYWjmMjqXMJ7/CO6EgPtRJu3qCNwDi3q0n5Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553465; c=relaxed/simple;
	bh=8qr8uTeaqr+p8zD9zlmtfx52Qsx4YWp+5OcFR7qoSm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfkXK2qCSAPWjL/LyX8OGtGgscPGtupAtMklzU57rpwPUebBBBWuJjccpU/XWydBnk4peBSS3NghLeakc8ANxJIkYu9MTsumx9m7r2pGl/FQSJgNOG/UUTGymXdXMppy4QW+vlbzQXVD/4XnjWrl0HNOAvgR0zPjWM/EKzg78X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I34AwKyj; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4767e969b94so34298281cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 03:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742553463; x=1743158263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18OouvJG6zVbvjzM1FOGerTElGKBPuwHf+zVIFYJM8o=;
        b=I34AwKyjsACN65RVsGqLk8bFXNoo84ZCQhYqd8Pln2Fshhj8R1md8FI0AxJHOF46uI
         PJqudQU/PM6S9SdHmR7TZ1ANteE5PPZ5GKlhgAaxk/tVAKYtI6qjhFrFCQQ+BTqHzVNu
         22mLZ0lGl5y18/jX1TDqNW11Mgw/LvIMsHYg1lfB8kuynVpG8K4511eQfGgxJ7EKbUvL
         KIlvzDDtdP+5bikJusfVjMe1pAdi+MRxRZNCtGtSyTB9ur44bjCKTvyRl1OwyGE5HdEy
         grICTxnZWTxewvEGC4w7i4Cf8MaPZUWtcb6VDDi1w5zlWA4eSBoafIu/hHM3Nz2972C4
         8PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742553463; x=1743158263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18OouvJG6zVbvjzM1FOGerTElGKBPuwHf+zVIFYJM8o=;
        b=Yj4OxZu1ivp7U2u+jCTJ+gmQxJVEIPvvnhzMFZyhqROwh68SJSlOpzpqjkH6j/pQ/4
         oWRgH9QJ4bZwBIo1GtvW2YfW7+BWNlGXSk2qLH4rnDlt7czx0Q73tE4lumGAyEe0vY5u
         /5PqZ3CAoMcbKNn1AsGkrrp4C1nZshilzOeNkHrGF5Hfx6KEuZLwVAF0GZhKUCmK+oAD
         0mjlpq2mwm5f5xjzoQYokjSWoPbuvsQzMlPywp1dJ3neHOXcTD35e613fTj3Ipo7lGMi
         OGdbZLCWXUZuaqz+vh8k08eulxp5GlFeRImNUFQjVrtifL400CZAxSHYupvFLQHkbXUr
         KNxA==
X-Forwarded-Encrypted: i=1; AJvYcCW/9uHar2L8ozpw2JGILO87PacvfOiUrGJilzJHmNm5c+0Rzxab6NLpsFOQ34bh0/0Cunjp0u/rBxQlP2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYKn9dagHBjCTrrkueRYqa6aG7TuWZ3oGgJw+wtwjXVjEiKUj
	ukZZGttJttBSQ+gzInaFD7Q5+hR4ZrZ/C1PRlSq8kgJ/KAM14zmZxW3W2F4sV4xXcPcZBdfkHiU
	edS+YgnJCOHmbWXoCvV9jKCqkqs1iMrhhb73K
X-Gm-Gg: ASbGncsQtWx07FzlIXOJ5f9plDKVLBCKlZuclSNESOEKzelVrcHSCAprE5Xbn6Q0T+L
	9lIr1qE+0VIZ55i8U4VDy74KEu9mDIaJ1RIIit67/Q9OHdcgX6aqE0LVyWKU9OYpXyN5/FfhYpZ
	UYhj8IOfT4bYeKh0g3G77Doku8
X-Google-Smtp-Source: AGHT+IEhqDKb0COnjB68TZ5TBEYvhp3OeCzpUhByZrB+edRRw7lwSaoQkN+wLQkdmuZcX0/594UU6lyrbiuq/pE5gxo=
X-Received: by 2002:a05:622a:59c5:b0:476:6f90:395e with SMTP id
 d75a77b69052e-4771dd94fcbmr41742221cf.21.1742553462772; Fri, 21 Mar 2025
 03:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
In-Reply-To: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Mar 2025 11:37:31 +0100
X-Gm-Features: AQ5f1JoTxQA7eKStn8Kp_wSo6MddPCNrZiUCY5HsiPv1Z7ZL_xYt8c7-8UKvdz4
Message-ID: <CANn89iLpON7eV9rHvErsoEu+GqDz18uYMv6M_4TLsh+WX9VQeg@mail.gmail.com>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with expedited
 RCU synchronization
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	aeh@meta.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	jhs@mojatatu.com, kernel-team@meta.com, Erik Lundgren <elundgren@meta.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 10:31=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> lockdep_unregister_key() is called from critical code paths, including
> sections where rtnl_lock() is held. For example, when replacing a qdisc
> in a network device, network egress traffic is disabled while
> __qdisc_destroy() is called for every network queue.
>
> If lockdep is enabled, __qdisc_destroy() calls lockdep_unregister_key(),
> which gets blocked waiting for synchronize_rcu() to complete.
>
> For example, a simple tc command to replace a qdisc could take 13
> seconds:
>
>   # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
>     real    0m13.195s
>     user    0m0.001s
>     sys     0m2.746s
>
> During this time, network egress is completely frozen while waiting for
> RCU synchronization.
>
> Use synchronize_rcu_expedited() instead to minimize the impact on
> critical operations like network connectivity changes.

Running 'critical operations' with LOCKDEP enabled kernels seems a bit
strange :)

Reviewed-by: Eric Dumazet <edumazet@google.com>

