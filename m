Return-Path: <linux-kernel+bounces-205270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 540F78FFA37
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 05:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04251F22D9F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FD21862F;
	Fri,  7 Jun 2024 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lx49WdBm"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6940017BAB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 03:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717731216; cv=none; b=tLRwx4vInxtBJewiDkTLDleoiaZyoM7ubvfthu50qiB3JOWIFc6J+k6Yk+HF4cjPQ7RrybW6Gzc28oEkn4Z8tWH3P4VmCKmxLRCUkBuaA+JYhE2MnY8nStFQ6dBx34Ijac4rjyhFPFwmsisV3XfkXDCJMkDeeaAazDDMw7w4reA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717731216; c=relaxed/simple;
	bh=/m+uM0gdToz6xyX8C9y0Tpj9D/Dw+puod/k6EAVhNkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUTlvkDaBPKxUl7tEi0jCOGNK8nBP7UHn7WZkG1Te49GbVLAWzeDNDn/Cg0vtJiEpgLQm8z2k6UsfKosn+qd5y5/Vo4rfUugnaPnUgJRjcatTdQ2Oy/mIsIURwA2HY1wejRLGFD0PhzDgnLi+LrfLSRGWua+jKeSTaJWNYwOyeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lx49WdBm; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so19248931fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 20:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717731212; x=1718336012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sqq7mHnfmI6TJ7JmoV4VGdgr/iP+4h0DzRJ3VU79oRU=;
        b=lx49WdBm1Ro5OUHCNnzszapCgbtcXs6JJg8aTkd+PBFN/wT+czZDM1QVa0oTIWl8i4
         JT1O0Wc6fE3tM/8jVMSyvGLdgGpgIY2G2ODf5J//LqEJstZp2/oMKR8M6rZ+/4JwBudR
         zW4IXjMYChCuz19aLxi3oRGftnWvJkv+4R70Ccf2AxzG3TaCnrVAUeiHCVvo0YAfqYoQ
         5WZixSYZ0eZ/h9KDPMqjw0x7tNJ4leOevtfpwkhtO3IpOKYQFlSmkfXQxhLzWqGlknXt
         /X/KYcjsPSJJU/KS/EOMWOGXE9I8bOSxIMrOHthr8wIMrMF+E6rvyZcN/zupi7jakRJn
         yGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717731212; x=1718336012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sqq7mHnfmI6TJ7JmoV4VGdgr/iP+4h0DzRJ3VU79oRU=;
        b=LV5a/CS/Gd5FX8hiOx0lbZHSJHhWNr8ziT3AumalBWKeQE764JCtOVibyY5R3uE6/2
         S8orHjjwVb9SslsgIDm6XxbCImAPOjKUlX3tOTkfddfwxz4AqpU70p4wihESZv+S7EMk
         KpyKcm/nos8T6pPK8on1dWAmf48yXuYyTCy0hYcty9qv9Bt0r+jxdzmHmdYfmuksP9Af
         OCgxJXuuKaIroSXa52gusxA3f7J5fF8uNadNlkqNdi9s9WjVqvmOy+zicuKcYmSR7P4G
         uz40v+C7yeepHquu4wWxfrljZnTn6fOBKPWUjQO0TsGNlSRcCV1hoAVhr2OJ+BszxLFs
         +45A==
X-Forwarded-Encrypted: i=1; AJvYcCWsXEUL9Lie2Yy1O3wutV80DlW2XsLjcK0RP2Efo+m8PI2e5RQUIkWW01+z2QfE3LUtMjEjAcM3nd4KsoOQFZvUN+6fKT0lMepio2NK
X-Gm-Message-State: AOJu0YyFOZIkoEEda0UzQQWyWyfSCASZMFBwUA1Xr7O5JQlhstSv9VBY
	TLGuI0WA5cy01JfRJB0xnCP6tKiWEM/i6vxACAbnOF9SeT7cwm+mo3sVghhJIxbdqPnNrAHVDb6
	nbXWcqpc5FS/Hh3xcKJ7U8691SbfqgO63
X-Google-Smtp-Source: AGHT+IG2//FnpKtMhqe4egPrGkyF60xTQc9V4nuA8pcka42BcoigTHV6P4pF3I1DrlNzyzdRgzqHUbwX8VCoqDur0tI=
X-Received: by 2002:a05:651c:cb:b0:2ea:7f57:5a74 with SMTP id
 38308e7fff4ca-2eadce71d09mr8100281fa.42.1717731212194; Thu, 06 Jun 2024
 20:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530122401.3826022-1-zegao@tencent.com>
In-Reply-To: <20240530122401.3826022-1-zegao@tencent.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Fri, 7 Jun 2024 11:33:20 +0800
Message-ID: <CAD8CoPCgzcrJ369HzanbsBWze6f44FQYy4ofmKh073yrv0Ceuw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] nohz idle time accounting cleanup
To: Frederic Weisbecker <frederic@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>
Cc: Cruz Zhao <CruzZhao@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gently ping for comments on this change ;D

Thanks,
Ze

On Thu, May 30, 2024 at 8:24=E2=80=AFPM Ze Gao <zegao2021@gmail.com> wrote:
>
> Dear all,
>
> Currently we use is_idle_task(current) check to decide if we need
> to call tick_nohz_irq_enter() on irq entry but use idle_cpu() to
> decide if we need to call tick_nohz_irq_exit() on irq exit.
> and we rely this pair (which internally calls tick_nohz_stop_idle()
> and tick_nohz_start_idle() separately) to do accurate idle time
> accounting in most cases.
>
> IIUC, idle_cpu() now is mainly for scheduler and for tick user,
> we seem to ask less than what idle_cpu() gives us and the use of
> idle_cpu() here only make things complicated which can be proved
> by the introduction of sched_core_idle_cpu() for forcing idle
> time accounting.
>
> So I make this RFC to do this cleanup and make things simple again
> here and it should introduce no functional changes.
>
> Reviews welcome and please let me know if I'm being stupid
> or missing something obvious.
>
> Regards,
> Ze
>
> --
>
> Ze Gao (2):
>   timer: Use is_idle_task() check instead of idle_cpu() on irq exit
>   sched/core: Remove sched_core_idle_cpu()
>
>  include/linux/sched.h |  2 --
>  kernel/sched/core.c   | 13 -------------
>  kernel/softirq.c      |  2 +-
>  3 files changed, 1 insertion(+), 16 deletions(-)
>
> --
> 2.41.0
>

