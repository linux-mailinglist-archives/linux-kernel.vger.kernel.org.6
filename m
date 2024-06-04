Return-Path: <linux-kernel+bounces-200848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AECEF8FB5A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0B31F24D4C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF17148317;
	Tue,  4 Jun 2024 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uN71wiXf"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1C91448CD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511835; cv=none; b=V8BVjhhOhf1/dfeMMoMHRSWqZoEiqZv25rU5ncB2dpAaTZsxnQmFHJvzy+WLWmbHkCsCIX24q92rJJGH5J9JPu7A/FogAxlAa9x8PrUPwLnGy/deJVCiXxfVPXB12x/iV24NzRORJ1ZRY5rkITXKyXfPCtOsGjzPH6Xw/ADCOgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511835; c=relaxed/simple;
	bh=2WBhKCzER5QRGkKRjRUD6vjeP7GmCbMDiVmEYcy6VWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZK0VNkHyQA+wxKJ0edB0OmGBqr5wF2e7k1VEll2eVzFW81D+sGa5II+p7UH2WQf/wnlYUC2z3Trz+j49+19McjF2W7sjfb4Ggwv6BKCpM3hm23w8PHZnP0qJaiU1AWizgcvWvbvQbY3FGet9mFaI2BcaNgKKvXG3CkOpjyivDm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uN71wiXf; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c24115469bso1428549a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 07:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717511833; x=1718116633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPDa51h3OIPRRca1pNet9C1r9RXUkNln6BVibPfIQ7k=;
        b=uN71wiXfvgps2SQksC9bA5qWj3lNngDaeHBj8t2Vkht13/sdRJKZMxMMCmFQlkKgE0
         /QrFU6NAUzHik/pr7R5aVMNj88/HjNncMDIlfhBMOCRsYDnKppSTthlnJ+m7OLeC3Sgm
         LYN1j0WoNPMJb5JgBVYFSiSOfCAxd89zdxtWSX6pZ8HpAbahXLO1BP14mGoucPmlhZ8V
         0gjYFrkLoqMHUn1ZIbyiGC64hOlx+nWljj8rZsv6HIfTqawC9jNyU8fr3TMZY9rfla1c
         y66+tKnrxOPlfh+pUTQ/44VAwDO/sECnTg7TlagLZM4fsrnpIz0IOFBMjJc4nRFW/uXX
         cH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717511833; x=1718116633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPDa51h3OIPRRca1pNet9C1r9RXUkNln6BVibPfIQ7k=;
        b=vv9BR6rh4bJOXM5FbGjjRnYSX5zvxRwMvKH5R93ixv1PAcr6S4lUvykWEZkwPje9R9
         75bq4679tkyJVBwzQ8CGRT6VO23dCTu4RiVWOIXfDikOydtArhe4ooGRkUipDCuTCTQJ
         FYa6gArZicy5o1SziDUVW65tXxUuaym/xl/wO2cyvHVcgGr3KXYFuL1VEq/XT7EYxMQj
         DyFVR47EWUWeTe5LjIADTSXOC7Y6+HvcSTHtNdZr/Ugt9S7s8Iu2tZ7Nu/kwBruuIjo+
         n+dOxp2hLUq6ULwgj7Jv+CTsWYZKMI+Z7TPy7z/5klkbonfseyKtisrEfO+S++Mlxa+W
         EoCw==
X-Forwarded-Encrypted: i=1; AJvYcCXM5TBHhTYWyW9l+t/zJaJUeZAjfY0DmQXU3vcswO57SSMmPPc90QcEqWrtI2f7mIb7JEkslcwdmMP342FgR9tczSwLF7w1AHCwUTGr
X-Gm-Message-State: AOJu0YyRBG2dQ4av2TZ/yBKUCAAxJRUDXoAf+ypTI66qOFETce21ozh6
	c9l1izUNYYDyaYs+QNFgVgQkxUH6U5LcaiM+uUERvqjAOvc1DkS+nZIdOX4XnxJ/q2H6C1u049E
	X/95NuvusiUDCzglqQeJnFiQKnaAeqZb51UbzwQ==
X-Google-Smtp-Source: AGHT+IHhtLFnwXdi+R2aXFv/HWKu0gUi4bBbmBkB66/ECfTiepU3GYfXWnmtFIAj5DEGbHV1/7WutsAAAScuKUavKgQ=
X-Received: by 2002:a17:90b:11c8:b0:2bd:d6c6:f454 with SMTP id
 98e67ed59e1d1-2c2530cf172mr4071854a91.21.1717511832821; Tue, 04 Jun 2024
 07:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531205452.65781-1-tim.c.chen@linux.intel.com>
In-Reply-To: <20240531205452.65781-1-tim.c.chen@linux.intel.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 4 Jun 2024 16:37:01 +0200
Message-ID: <CAKfTPtAm5wTM3TB_s6H=4gs8VmbuFvkHbFMTqn5-ptFPdktHLQ@mail.gmail.com>
Subject: Re: [PATCH] sched/balance: Skip unnecessary updates to idle load
 balancer's flags
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	Chen Yu <yu.c.chen@intel.com>, Vinicius Gomes <vinicius.gomes@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 31 May 2024 at 22:52, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> We observed that the overhead on trigger_load_balance(), now renamed
> sched_balance_trigger(), has risen with a system's core counts.
>
> For an OLTP workload running 6.8 kernel on a 2 socket x86 systems
> having 96 cores/socket, we saw that 0.7% cpu cycles are spent in
> trigger_load_balance(). On older systems with fewer cores/socket, this
> function's overhead was less than 0.1%.
>
> The cause of this overhead was that there are multiple cpus calling
> kick_ilb(flags), updating the balancing work needed to a common idle
> load balancer cpu. The ilb_cpu's flags field got updated unconditionally
> with atomic_fetch_or().  The atomic read and writes to ilb_cpu's flags
> causes much cache bouncing and cpu cycles overhead. This is seen in the
> annotated profile below.
>
>              kick_ilb():
>              if (ilb_cpu < 0)
>                test   %r14d,%r14d
>              =E2=86=91 js     6c
>              flags =3D atomic_fetch_or(flags, nohz_flags(ilb_cpu));
>                mov    $0x2d600,%rdi
>                movslq %r14d,%r8
>                mov    %rdi,%rdx
>                add    -0x7dd0c3e0(,%r8,8),%rdx
>              arch_atomic_read():
>   0.01         mov    0x64(%rdx),%esi
>  35.58         add    $0x64,%rdx
>              arch_atomic_fetch_or():
>
>              static __always_inline int arch_atomic_fetch_or(int i, atomi=
c_t *v)
>              {
>              int val =3D arch_atomic_read(v);
>
>              do { } while (!arch_atomic_try_cmpxchg(v, &val, val | i));
>   0.03  157:   mov    %r12d,%ecx
>              arch_atomic_try_cmpxchg():
>              return arch_try_cmpxchg(&v->counter, old, new);
>   0.00         mov    %esi,%eax
>              arch_atomic_fetch_or():
>              do { } while (!arch_atomic_try_cmpxchg(v, &val, val | i));
>                or     %esi,%ecx
>              arch_atomic_try_cmpxchg():
>              return arch_try_cmpxchg(&v->counter, old, new);
>   0.01         lock   cmpxchg %ecx,(%rdx)
>  42.96       =E2=86=93 jne    2d2
>              kick_ilb():
>
> With instrumentation, we found that 81% of the updates do not result in
> any change in the ilb_cpu's flags.  That is, multiple cpus are asking
> the ilb_cpu to do the same things over and over again, before the ilb_cpu
> has a chance to run NOHZ load balance.
>
> Skip updates to ilb_cpu's flags if no new work needs to be done.
> Such updates do not change ilb_cpu's NOHZ flags.  This requires an extra
> atomic read but it is less expensive than frequent unnecessary atomic
> updates that generate cache bounces.
>
> We saw that on the OLTP workload, cpu cycles from trigger_load_balance()
> (or sched_balance_trigger()) got reduced from 0.7% to 0.2%.

Make sense, we have seen other variables being a bottleneck in the
scheduler like task_group's load_avg or root domain's overload.

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a5b1ae0aa55..9ab6dff6d8ac 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11891,6 +11891,13 @@ static void kick_ilb(unsigned int flags)
>         if (ilb_cpu < 0)
>                 return;
>
> +       /*
> +        * Don't bother if no new NOHZ balance work items for ilb_cpu,
> +        * i.e. all bits in flags are already set in ilb_cpu.
> +        */
> +       if ((atomic_read(nohz_flags(ilb_cpu)) & flags) =3D=3D flags)
> +               return;
> +
>         /*
>          * Access to rq::nohz_csd is serialized by NOHZ_KICK_MASK; he who=
 sets
>          * the first flag owns it; cleared by nohz_csd_func().
> --
> 2.32.0
>

