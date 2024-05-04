Return-Path: <linux-kernel+bounces-168556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69EB8BBA1E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 10:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F8FB21878
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 08:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9628F12B7F;
	Sat,  4 May 2024 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XgnpODUi"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C79211C83
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714811979; cv=none; b=KB3Yh7W3ZBJIetFOe02ShFgqx3RP8i4PYgki8XJpYatkX64Y8nvX/znImx9YYevvp2WRbJ3gqdiRQyppEF95ajUyhANrxCLlaJUIOBmhXNHJ5iWBXH4Vs0QKo1YvD3bCB+n7yU5YFhBvRQuOcmgB9FAEdkiA1c6NEP8bJ20Z774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714811979; c=relaxed/simple;
	bh=pS9GUyr/Rb4KQ2oCmIUticmklLFBQYHkSGp5cW0WkQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwOClsh7K11DaVBYWDkvGb2fN/A2IWkOgzhvU3mAP4YGfF/BoFGYR89LuBsA1gsg3Z1VsyfP7Yc9mNUxQathtSBBGrUc77UPFaQgxcGEpwOQASG2wrFn6VhvpdvYcmPRnONvM39g7BYlC9kvG79L0qeooKPsHsd3YOEl9wqIIjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XgnpODUi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-418820e6effso21955e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 01:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714811977; x=1715416777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0t5CPQQsxj2vgCF+u2Twafxclh98sEiPLbitj8vQ18=;
        b=XgnpODUiCeKl4XODAAL1QxNO1WrnW/Mxf2KX1YFKFaWLQ6WHQsRlm2ixgSoyEJnkTp
         GNudod9jl99+Yh79ZqKwUrX2m5mhChkUXbwpD2DlXAUD0GyxdmhpRa6rMckrn4R8QyQJ
         wYz0aZeiFCSATLqwBXRKLVHB0mL1SHkxMUjxnJEpuEUSV+3fKPithK3YyynYON8UBJ5J
         jZ9kY3z9AvKp1x/TOEsIHRBR5XngCfC1Pr+EGd2YmXLY09cgHkUARG7W8XXDeBZomIw1
         JaqXiLPjm7oGHfq5AzGw/5u5MgpwiO762DmN18V6MeBxJPKwxh91u39NLeCHLq/ZpK+F
         SFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714811977; x=1715416777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0t5CPQQsxj2vgCF+u2Twafxclh98sEiPLbitj8vQ18=;
        b=VIyUswmu9b2kGdrutdKKuWNR+/Bg2SK/fn/IdfYQbrnemj6t8oXROlzs/jYMtvCXc9
         gCdtlwwlIfSoRgz63Ea+9BSGcpsAS5MgS46+IB9fatdwVbH5iWXY3gtPG6ye88l7Gc+Z
         t84Q8XkeWyFJyyRC0DuqUxwKtdA+Xn2SGxkufgiR6yOecolLF7OFJFGojp+cVHidqlut
         xNS/QSyPOlRZiYCUhS4IgWvWXXgxwQwdO4vywmpbPu4Q40PNqhsXBQ5aK7Ljm8Xv095f
         Qh2wSZNT3zxfRe5hjUNukQUBZizr/XqjK59NGu60XNKyThdcCLrQ928VHnQeJGglp0+7
         gSyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfOdBxA9FnIR1tqfOSykPZrxQHYhy4hnu/Yo05cHvhn4RfMjobdRqB4XRlcoMZvd9SUtjU0f82m3zsz6smX7ZbMbQyJ1XHBJuIYOlY
X-Gm-Message-State: AOJu0YxlLKI7/ArN36Oh6K3zzbe/V1aiIPSaweTTxTlnCrhe2+W7ua9n
	oCG4T/fWCjhke8Wtbp5exm7ExXmVhW/A3X1c4jMtpXmaQK/u5zF6JdlbqwirOaXs171cBbKFXRb
	ulObB/u0YhWeRv6hrKYb957wuQbvNddWGNNM=
X-Google-Smtp-Source: AGHT+IHKZ79tYRwfIfKH6NTayUjVgFntgfvssDoGafTukL6FFYiULiu+lRJw1Y725qf7MWVs8Lup8faj9B/nOfFuzbc=
X-Received: by 2002:a05:600c:1c24:b0:41b:8715:1158 with SMTP id
 5b1f17b1804b1-41e5a4eb27emr1125985e9.6.1714811976712; Sat, 04 May 2024
 01:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANDhNCq2n2HVUnVi0K+cw_7MUd1h49BzTxLEk6V3G2c=BBUYBw@mail.gmail.com>
 <ZjWh2MbDs1CF8PUB@slm.duckdns.org>
In-Reply-To: <ZjWh2MbDs1CF8PUB@slm.duckdns.org>
From: John Stultz <jstultz@google.com>
Date: Sat, 4 May 2024 01:39:23 -0700
Message-ID: <CANDhNCoefufFFR=nbqo3Gn-NAXBqnLMXuZujz-cTzD_weO84+A@mail.gmail.com>
Subject: Re: WW_MUTEX_SELFTEST hangs w/ 6.9-rc workqueue changes
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Will Deacon <will@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 7:47=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> On Fri, May 03, 2024 at 06:01:49PM -0700, John Stultz wrote:
> > Hey All,
> >    In doing some local testing, I noticed I've started to see boot
> > stalls with CONFIG_WW_MUTEX_SELFTEST with 6.9-rc on a 64cpu qemu
> > environment.
> >
> > I've bisected the problem down to:
> >   5797b1c18919 (workqueue: Implement system-wide nr_active enforcement
> > for unbound workqueues)
> > + the fix needed for that change:
> >   15930da42f89 (workqueue: Don't call cpumask_test_cpu() with -1 CPU
> > in wq_update_node_max_active())
>
> This should be fixed by d40f92020c7a ("workqueue: The default node_nr_act=
ive
> should have its max set to max_active"). Can you please confirm the fix?

Ah! Thank you, that does resolve the issue!

> Thanks and sorry about the hassle.

Thanks so much for the quick response (can't beat a fix already in the tree=
!)
-john

