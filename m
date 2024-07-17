Return-Path: <linux-kernel+bounces-255386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D21A1934022
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8684C1F23931
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60271181CE8;
	Wed, 17 Jul 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xQ0thuGq"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D51EA8F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721232355; cv=none; b=N9FrxPfRL/+UIqNIaIyk+npFF6GVijvq5VSswguVFsf4/DxJQFaL7UwKGXKn8fFnYcNEWtMdf0yM0V8GwdG/3kJmTq5E6WZ4a/BQ6CEI6XsRUAHItwtxD1Bm2l282l4dOECiPmoGZysdCO/wV+Pr1nImLGdayKx6LkZ4AQ4aY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721232355; c=relaxed/simple;
	bh=YcjsHP54RpwUKtiYpkm/nJMYQg9aJFKhLDJMn31KcwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMlQk7G2LPVAv2jh/ML75aCxNCPfCdCUya2vD6kGQtscosbYIz4o691/2GOGhmJJ1NKrgNAINNTWl/Rlluh2pqJ6Gz1ykoABpIPySPGP8gsKPZtO07kz9OkV12Kpiy5Pjx1K2EiBsoyjwomlNaFc+lm2oN6DGLIRoN9ewVQP81E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xQ0thuGq; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58b0beaf703so8370723a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721232352; x=1721837152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XzbkbJcXikIhEb+ZP9zYLgNCMH4osHfm1Sg9VEiM7Q=;
        b=xQ0thuGqB7hpZsxBYTT+o0e8j8k+TlRqVXirqALZ47HjLSMi98klJpUkYYI+mhImf6
         BYfZu8NdvUozBKsQ6DC5bfBgJYEu83w4ETPBMYRrhr149KymWaojk2cx5ts1Bvnx1Kpn
         FrxrpbFgc+ek0e4KBQMYdlkp3Bj3ueQwTJDoUwfQJaZOUeehHZM/ao8aAkJhQ2rSaDKA
         rSwZ7EfGi7pdF16tmvBuKMvWt+MAQbKreIp4VKJLmogF5RgQL0zoSoxc/s9w2TNqTCdw
         pkVFeq6KpKBbQPg8XIAy8xknUbIg5o4qXFnr7ueYUHsDVdCwQQtTfEFRqZ6yQwFVfe0M
         vh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721232352; x=1721837152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XzbkbJcXikIhEb+ZP9zYLgNCMH4osHfm1Sg9VEiM7Q=;
        b=YFsm4Rit42PNS0HWX6+WvmOJb3CZ9K4NsmTK4qHiwZXGXfuxyeiH8awNJ/VMFOjzDT
         y3TF7GNBapmyKtHa3P7J7ygtnSxL0bq6zEkZ6laKuCtRyGVc23iibb/xKEpY6/N+vK+j
         YYyKLqCl9HhIgxadsYdVoSRcLw2e8LYB0/a3Qc6Xapy5RUR+e/53ge0m1PXMNMPFDsd6
         j7O5uvOudvQI7DMi+fXSqshXnLMDIyUMoibD2nAJkPUA1oQ3diay1sJB2BAwnDgGcrFm
         YBQDNlCIbq6QWp5mR7JaewkjbR+KmPIx9qkCJeKIoL4YmPswIyqsMPcgE8B8GA04zM5H
         LtLw==
X-Forwarded-Encrypted: i=1; AJvYcCX+0L+AEe5y+IOvqIA1U5sMszraiuT0lAC1upwwlhD/CsyiAnZRYMg5jF2E9vKaFkjlHU2fvUuqT7pWM7iJofHHWCR6gbS5kQuCA2YZ
X-Gm-Message-State: AOJu0Yw2WrfiSrzQmi6EZoTzJm32uYc0/w908OcnniwbddCelR+eDeMs
	WRgSpcm4KOhq+gcXwXpIt0XAjfGHW+lsMGp60T0VFhuszHc3TgC33u/+n+/BPHfzvwwEeWvHoDN
	Ys/5vFGVXjTCAlfGGIv6zOG3ZgUZ6+6iZBUo3
X-Google-Smtp-Source: AGHT+IF612kZUE8JtTrcOb7CBHDJfT/vFSLwBjbycByRk2UQLAz14lfAY2/3C531BxfWpFzgaaEvnI7pwI9M7gPPalQ=
X-Received: by 2002:a17:906:1444:b0:a6f:e456:4207 with SMTP id
 a640c23a62f3a-a7a01352c5fmr121415666b.61.1721232351397; Wed, 17 Jul 2024
 09:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org> <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <623e62c5-3045-4dca-9f2c-ed15b8d3bad8@redhat.com>
In-Reply-To: <623e62c5-3045-4dca-9f2c-ed15b8d3bad8@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jul 2024 09:05:15 -0700
Message-ID: <CAJD7tkZ6WOtbtiMy_2nemLQnHgO_tC0cfH1tJF-vD-Lb8PoUuA@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Waiman Long <longman@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 8:00=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 7/16/24 20:35, Yosry Ahmed wrote:
> > [..]
> >>
> >> This is a clean (meaning no cadvisor interference) example of kswapd
> >> starting simultaniously on many NUMA nodes, that in 27 out of 98 cases
> >> hit the race (which is handled in V6 and V7).
> >>
> >> The BPF "cnt" maps are getting cleared every second, so this
> >> approximates per sec numbers.  This patch reduce pressure on the lock,
> >> but we are still seeing (kfunc:vmlinux:cgroup_rstat_flush_locked) full
> >> flushes approx 37 per sec (every 27 ms). On the positive side
> >> ongoing_flusher mitigation stopped 98 per sec of these.
> >>
> >> In this clean kswapd case the patch removes the lock contention issue
> >> for kswapd. The lock_contended cases 27 seems to be all related to
> >> handled_race cases 27.
> >>
> >> The remaning high flush rate should also be addressed, and we should
> >> also work on aproaches to limit this like my ealier proposal[1].
> > I honestly don't think a high number of flushes is a problem on its
> > own as long as we are not spending too much time flushing, especially
> > when we have magnitude-based thresholding so we know there is
> > something to flush (although it may not be relevant to what we are
> > doing).
> >
> > If we keep observing a lot of lock contention, one thing that I
> > thought about is to have a variant of spin_lock with a timeout. This
> > limits the flushing latency, instead of limiting the number of flushes
> > (which I believe is the wrong metric to optimize).
>
> Except for semaphore, none of our locking primitives allow for a timeout
> parameter. For sleeping locks, I don't think it is hard to add variants
> with timeout parameter, but not the spinning locks.

Thanks for pointing this out. I am assuming a mutex with a timeout
will also address the priority inversion problem that Shakeel was
talking about AFAICT.

