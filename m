Return-Path: <linux-kernel+bounces-260460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F09693A998
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB001F2327B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E2B146D7E;
	Tue, 23 Jul 2024 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOpPI3nI"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AA213C90C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721776061; cv=none; b=CsjlW3Ax9gH2STJ+/jQV7a+NHeDKAnyF2KXAwRm1HMWanesfWwCailvJuiJQcsIuRXr1JRm62hkczdIUY+2KMyui9GPc8u9c93pFTU9vfDIVYn0ThVzPjEbo3oZaE9h89HnJvtWCh8FGfynCcpBLSFpkBJUeRh/19rIHg9FeZnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721776061; c=relaxed/simple;
	bh=+forq/4jMQxgwgyJ1Exi9aq4d/6/TnXqiOoAvPwvEGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkZqY5chh1SWFYkfikwHiEG14hdXBNeeY2qCprA3srE6C8lQeJOC1149ZIo/VFaNv2KwED5W74EZKleXZdCp6wAFMdEnKeih/a+Ca6HhBGMEH7oaedn2eeRanVQp0mumzFfc4SsznHp0Dz33LilvdMtgETsHJbA4XChMEEJsuGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fOpPI3nI; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44e534a1fbeso61281cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721776059; x=1722380859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6C+fkFukNiGp5ISGUxgRcyilQiJzLpuodr5Eof9VBJg=;
        b=fOpPI3nIH9h7LuKh+VDilpnm9eckFMoGse3gCE0b5jk8nvavsmgRNklzObBYeGwHv7
         Pr7F4/2dJTc5vkm/s6jzWFu9Fh4sVBnHv0qoR8ritgsnvlUOFGOV6vhkr8TKnELHR9XX
         OhJCBfaz2L5AtnKjNE49lNhDeWXGzce2yYeiImz/5mJbe17BKU/Omp9Pl9FSiSAybCOe
         zLUvWfGT83FeNHzSGmv77kRxZeixX72PoxT0XVx3nIRW14M9XlDy5kEW0t9vhVvFuBx6
         BRKMgp50kGb0i8VJmBp2hpVmxVsPYzupPiPI3rGrk2Qa5mLzvQhcPAe5kKq51Qc8zWk/
         qeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721776059; x=1722380859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6C+fkFukNiGp5ISGUxgRcyilQiJzLpuodr5Eof9VBJg=;
        b=vyEFjpm4lCiC2NcwPyAvL4OGj6QcBF1FaoyvTqgH7QU4qJPFAGxydX1xnpOE7/roDG
         yJr4K75KR6O3TwGsbk47j5hkCsPD7opB/YZbXy4sk7socGF7vm3zBgA/aGDr8vVFQ393
         +FOVyU2QLUbTbEXpeQcnRSg331zHgBUFA8uQ6rilI4hpzoPXaOd/5+iNpIaBBmibP/XM
         bytoBwd2Fc/vLQJNYaeDdjZw6EAoRCiau67WmgW0jC7a7OtjDKqyfpoPJkHiAcDc1/5T
         alUNJBVxRBb7MtZosIMu+SvR8HvS/4z4jaVrTSb8tq8KZxOcGgHaF2jYiSiFHGYxhdkE
         5d+A==
X-Forwarded-Encrypted: i=1; AJvYcCWpTszZcYAVfWWygNoxqtB3+k9EvlWxLlMKFdKJFtU6dP9sBixOBfnnbn/mmAlVUjzqGbKol65RrfnO0S/w4Uu/9rMteB1MUA29clMQ
X-Gm-Message-State: AOJu0YzTFHD9/GLGqbj+ezIBF6fRSCNRv5QK+7GItebPBvAFv2qmaggk
	u6QO0Xeblx3RI9RNT1+4E/PbKvS2MMLPPDFd0obUhrWahBNo20N48KbChjXwc3vN0URtf6PxLR6
	41cm0iVPNRMFQ9TZO9GIsDwjJto7r6YVotTc2Fq+5J5iQxOPUG5YUHbw=
X-Google-Smtp-Source: AGHT+IFgGTZzHeugui0RzmvFiY7doQ86K2Y0h52nLIG0c9YpVHS5634BVNFZRzQv9vFzIFzEs6QM3K+ectPLd0aerco=
X-Received: by 2002:a05:622a:248:b0:444:ccc5:f4c0 with SMTP id
 d75a77b69052e-44fd4ac8c3dmr1983041cf.15.1721776058474; Tue, 23 Jul 2024
 16:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722210648.80892-1-lucas.demarchi@intel.com> <20240722210648.80892-2-lucas.demarchi@intel.com>
In-Reply-To: <20240722210648.80892-2-lucas.demarchi@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jul 2024 16:07:27 -0700
Message-ID: <CAP-5=fUgxQB-pzxNHZXGzFh1B3yL=ui0izM-dp_K7oubh8UOOg@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf/core: Add pmu get/put
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, linux-perf-users@vger.kernel.org, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 2:07=E2=80=AFPM Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
>
> If a pmu is unregistered while there's an active event, perf will still
> access the pmu via event->pmu, even after the event is destroyed. This
> makes it difficult for drivers like i915 that take a reference on the
> device when the event is created and put it when it's destroyed.
> Currently the following use-after-free happens just after destroying the
> event:
>
>         BUG: KASAN: use-after-free in exclusive_event_destroy+0xd8/0xf0
>         Read of size 4 at addr ffff88816e2bb63c by task perf/7748
>
> Whenever and event is created, get a pmu reference to use in event->pmu
> and just before calling module_put(), drop the reference..
>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  include/linux/perf_event.h |  3 +++
>  kernel/events/core.c       | 32 ++++++++++++++++++++++++++++----
>  2 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index a5304ae8c654..7048a505e93c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -540,6 +540,9 @@ struct pmu {
>          * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
>          */
>         int (*check_period)             (struct perf_event *event, u64 va=
lue); /* optional */
> +
> +       struct pmu *(*get)              (struct pmu *pmu); /* optional: g=
et a reference */
> +       void (*put)                     (struct pmu *pmu); /* optional: p=
ut a reference */
>  };
>
>  enum perf_addr_filter_action_t {
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1b6f5dc7ed32..cc7541b644b0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5208,6 +5208,8 @@ static void perf_addr_filters_splice(struct perf_ev=
ent *event,
>
>  static void _free_event(struct perf_event *event)
>  {
> +       struct module *module;
> +
>         irq_work_sync(&event->pending_irq);
>
>         unaccount_event(event);
> @@ -5259,7 +5261,13 @@ static void _free_event(struct perf_event *event)
>                 put_ctx(event->ctx);
>
>         exclusive_event_destroy(event);
> -       module_put(event->pmu->module);
> +
> +       module =3D event->pmu->module;
> +       event->pmu->put(event->pmu);
> +       /* can't touch pmu anymore */
> +       event->pmu =3D NULL;
> +
> +       module_put(module);
>
>         call_rcu(&event->rcu_head, free_event_rcu);
>  }
> @@ -11331,6 +11339,11 @@ static int perf_pmu_nop_int(struct pmu *pmu)
>         return 0;
>  }
>
> +static struct pmu *perf_pmu_nop_pmu(struct pmu *pmu)
> +{
> +       return pmu;
> +}
> +
>  static int perf_event_nop_int(struct perf_event *event, u64 value)
>  {
>         return 0;
> @@ -11617,6 +11630,12 @@ int perf_pmu_register(struct pmu *pmu, const cha=
r *name, int type)
>         if (!pmu->event_idx)
>                 pmu->event_idx =3D perf_event_idx_default;
>
> +       if (!pmu->get)
> +               pmu->get =3D perf_pmu_nop_pmu;
> +
> +       if (!pmu->put)
> +               pmu->put =3D perf_pmu_nop_void;
> +
>         list_add_rcu(&pmu->entry, &pmus);
>         atomic_set(&pmu->exclusive_cnt, 0);
>         ret =3D 0;
> @@ -11695,7 +11714,8 @@ static int perf_try_init_event(struct pmu *pmu, s=
truct perf_event *event)
>                 BUG_ON(!ctx);
>         }
>
> -       event->pmu =3D pmu;
> +       event->pmu =3D pmu->get(pmu);
> +
>         ret =3D pmu->event_init(event);
>
>         if (ctx)
> @@ -11714,8 +11734,12 @@ static int perf_try_init_event(struct pmu *pmu, =
struct perf_event *event)
>                         event->destroy(event);
>         }
>
> -       if (ret)
> -               module_put(pmu->module);
> +       if (ret) {
> +               struct module *module =3D pmu->module;
> +
> +               pmu->put(pmu);

I think this is a great fix, a nit here, wouldn't it be good to do:

event->pmu =3D NULL;

Thanks,
Ian

> +               module_put(module);
> +       }
>
>         return ret;
>  }
> --
> 2.43.0
>
>

