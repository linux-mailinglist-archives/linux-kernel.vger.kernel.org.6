Return-Path: <linux-kernel+bounces-201917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E348FC540
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B976E1C22727
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B949D18F2CF;
	Wed,  5 Jun 2024 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SzZBjnR+"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76DD18C35C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574240; cv=none; b=Ji9HLtKeokVpQzUgMdVmvb4SaBo44QCmvl3Ex+sI8CP8CN0bH9xcSDU2v9lGKJMp9YzAiB8h1syeQ7497RXNgjauc+2jgYVmCpsDUo9jJSmwNAD7Lc38/tQUXK45oiq/r2Iwl2eDv8Q8dcP68gGOwyxb/KAOSlGc1ms8HAICoT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574240; c=relaxed/simple;
	bh=MEB3T134sg1+5ITkh0MrNcrAbFTCgwOkdrrL0VU1wg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kp9IyHHqiwDTrlJs2uTeTY313nrpAOJeRz5Qtaeec8i2Z4z1058DHPRWVSL/ESu9kcZFGajmA4TjFyYoEIjplRMX+R5lRvJlirYR76K3JNWN76mb7TELY7oW436HfoN9pRPDlXNKXvlTWCS3ZOJ+tp0vCo5zMmpuz0x9uol0INQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SzZBjnR+; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4eb2b6164b7so361956e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717574237; x=1718179037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K7HNwq80CUl9euhXBEKTrmHO/OrgPhpji/JBSWvl19w=;
        b=SzZBjnR+NuSqO+SsDVfRqkgYkJXYxOxQ47+5e9WEJ/+YQdMW8E7i+I3CKcOlK39+E8
         mi/TNHxzj0d7xot/NDSHny/qJAlPjz6nZT8hgwvAylNAAX6CcwqDP+intqdGGgsOqSZM
         a/sxitBS3D4t81z3pL13XfJCiigJscynBq9uY5tYPrgqJTeXfEkLNlfRUesoiEuY8xrU
         dX2vFLNI+HITy7LmD5jCIganqGV0AuB06UAhkolKAFlq75rrAArIsampWkQ2KkRjejcb
         sShS5poanwKr1ARuvBfyEpDfFQmZ++oFplJ048m06jSZDdNKkYFeiR25blLTHSkzI2MJ
         DMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717574237; x=1718179037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7HNwq80CUl9euhXBEKTrmHO/OrgPhpji/JBSWvl19w=;
        b=CJpB3v37UKXzX+Vcm7xOFNhVx9th/RtJWF+iHftCf1V2dvnQn7fBl0DucvqABPGRiQ
         kElilDKjjbMhOGqCrgOGMzu2xPl8s9KoIUnp70fD7/3jCL06Pghqq4fDmR5NNjYNIzqt
         khRjrjTZD+ZZTdDPQhJjt2zwjC+COKSLCkSjCOdP5/U5iNdZXE3ukLtwP99qukSDzEgK
         uU6EGkv8refwgWYWYxVI9VqaJvEA2XnVxBRCZ2XHWC2aloTQfZRYRRBEsERlJ23DGoGp
         1R2MGIaNbi7dmZzpZcpS5qRF1arlIb90TOLLyONXzkPiKCjEwSpVU3h1kzWVX11lKX8K
         Tu5g==
X-Forwarded-Encrypted: i=1; AJvYcCUCMa7MeIw0LHtHjlAgjqxzdqKKVSckO1A7a5OwfcuAzOgGCUNjio/jRvbe+41eDTzyJOP5qLOQmNkn4q4QItV+WHslOJiGu9kNjNmy
X-Gm-Message-State: AOJu0YwTuc4EJr+WD9BNxbu7WhdgoavvAXXlKuWjF0xapOokEPjKJcmP
	4EksVAPcpyGXxRrSyeRkoYJVk0gQkuekDLWzwoJTlWA8giqZkXybBG+nJArOvezi2jDK7Fuyc4Y
	Q1r3mSYPZ1vXLTxQNuW5FmEHKiNbqlhkOwuam
X-Google-Smtp-Source: AGHT+IHi0oAGYU+C8I6R5jqwLD86we4SP7ouy4HmrcjU04r0ssA25UPb9AuN2gw0FUMDNyuY4qxZjssACgjbQ8m5+YA=
X-Received: by 2002:a05:6122:a18:b0:4eb:e37:2d19 with SMTP id
 71dfb90a1353d-4eb2bc01ecfmr4739547e0c.1.1717574237255; Wed, 05 Jun 2024
 00:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e14ba19e-53aa-4ec1-b58d-6444ffec07c6@paulmck-laptop> <20240604223633.2371664-2-paulmck@kernel.org>
In-Reply-To: <20240604223633.2371664-2-paulmck@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 5 Jun 2024 09:56:41 +0200
Message-ID: <CANpmjNOLuAZfjiNZqZ8zUrziOUiXw-7zOxRpOrwqYP_rgrEgJw@mail.gmail.com>
Subject: Re: [PATCH rcu 2/4] rcutorture: Fix rcu_torture_fwd_cb_cr() data race
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 00:36, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On powerpc systems, spinlock acquisition does not order prior stores
> against later loads.  This means that this statement:
>
>         rfcp->rfc_next = NULL;
>
> Can be reordered to follow this statement:
>
>         WRITE_ONCE(*rfcpp, rfcp);
>
> Which is then a data race with rcu_torture_fwd_prog_cr(), specifically,
> this statement:
>
>         rfcpn = READ_ONCE(rfcp->rfc_next)
>
> KCSAN located this data race, which represents a real failure on powerpc.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: <kasan-dev@googlegroups.com>

Nice find - was this found by KCSAN's weak memory modeling, i.e. the
report showed you that a reordered access resulted in a data race?

Acked-by: Marco Elver <elver@google.com>

> ---
>  kernel/rcu/rcutorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 44cc455e1b615..cafe047d046e8 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2630,7 +2630,7 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
>         spin_lock_irqsave(&rfp->rcu_fwd_lock, flags);
>         rfcpp = rfp->rcu_fwd_cb_tail;
>         rfp->rcu_fwd_cb_tail = &rfcp->rfc_next;
> -       WRITE_ONCE(*rfcpp, rfcp);
> +       smp_store_release(rfcpp, rfcp);
>         WRITE_ONCE(rfp->n_launders_cb, rfp->n_launders_cb + 1);
>         i = ((jiffies - rfp->rcu_fwd_startat) / (HZ / FWD_CBS_HIST_DIV));
>         if (i >= ARRAY_SIZE(rfp->n_launders_hist))
> --
> 2.40.1
>

