Return-Path: <linux-kernel+bounces-206536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AD2900B24
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA102873A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA4719AD6E;
	Fri,  7 Jun 2024 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LvcvchX/"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9FE134B2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781008; cv=none; b=aVl2C421+2Adb23yky0iOvS2D6+6R72ErGFUM4l8zxAzlWaKdIG7fc7LonQbHSUlKh12PrsyCTgejkaZMOEm5dIW2d/h5MoRK++D5ABfQreApSlRELTBI7og7swwLJm9Io4gApom8/7Uvc+1N54ZFzxKkJyRlzTyZ/IN9nZgc/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781008; c=relaxed/simple;
	bh=p2lF+OviYBBW5AoVLpk3he9hABgq5Fw9ltxH6jMjt1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8oHVvBcTNYgyWkZ8t1BK1yfdLBr+MI61gCGRKWx8qqrlqIHYFZrT4GWXi7bZVqjT80kXne78tiAZMNeYKcSfr/K7a3HyV1DrBZid88tWCvKI5mjn+17pmTh9GCAHlHg6VlswHq5Zc9TZ6ZhLxccJ3sIJlXTQNaIvqGZL/03zcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LvcvchX/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f6a270d1b8so8735ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 10:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717781006; x=1718385806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6W7eNzUkVsvxh0fs7QApe4zLHB8YHFiMurfzjOn05Cc=;
        b=LvcvchX/TY1vzC6SSqot1eMdbcJutXwzt5FoP2cJvNccRSXh1Z0Dm1E9aMZrQBUfkv
         OwbIZaRICB+5R6QQnpL//odFO2eQKu52cEYcwZA11EFFHAbc35dD3MzwBAnNyZNFqWFI
         UVhOsAb6vVrbXAUmSjjk/oMD7X1MxqVrpYgExjTLQaeEMelzTNv1V631O412cWuzG3PI
         mjbxJFD+rnRnEhmCwIoJ6GJg7JGulNnC1q6TwgjZllqzuIis4FnBZmVm+SsTqTlBOq8o
         PFzypyFtimpHPlc78TluuJEza3Lwz9AVnGPv2CFDEDK5WafldXN2exhKH+cGHbYPICg0
         Of0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717781006; x=1718385806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6W7eNzUkVsvxh0fs7QApe4zLHB8YHFiMurfzjOn05Cc=;
        b=KcUcp7PsvT9k8Yym9WSeI0mlpOivXsksJh581FHLKdVZE5Q9DY3BiXaHRdBQNbNkTT
         auSgUKgwhd4aaAQtzlDYEsHobU2LAsqub8ex8U9QGHxIarr1VcddryI9/9eAdyJPUHWg
         nyjL1CNtJ8Edy/zm/tQTIMidVRuFdGIQxXh0rbyBQx6Km4vLPp9DpHbOpkPWQ4MhJkl+
         RrSk4Y3UBWj5O2sz+/wbjmF9RfzoEo3pcu4YX5YBrrMJoql1II/yeecO/HLHhvk1Os+2
         nBELeLxtbl51UMlWAPIPf8JtfMwMjHCfaXh7JWGazyMMqddbs250Ym4cXHOw0mRnVhCP
         tMxA==
X-Forwarded-Encrypted: i=1; AJvYcCUXiTUIfDrj8URXt1KOzkbOlqaQm3neFHfZY+qWeknNpj7r9CpkE3gsfSjoVU6IwB4pM1jhxR5fIIEd9840W7xFbymrxvwUyOSpgt/s
X-Gm-Message-State: AOJu0YyQj7RDQlqD4dbIkRPMZPxDfqV6mzWxTsRSgAUd/yWf4HBHYq+K
	//I7bkj4xMxwfBDLUPSaKn2MC1uetjqSZRF7bqOuiyE1SZyOytTFTCm8VA8LkCe60BJZZ2RLiR9
	i8fnsqpScow6Gnl4nX+kCRdF9gR9zYq5hkZmJ
X-Google-Smtp-Source: AGHT+IF1kBumIybHOnEycCWnTnGC0ewzKueFu/6w+DPgOcUa8Oae8IA/SWiwu846ZjxfYxHaSpC5xnVHoTfKDKov8ws=
X-Received: by 2002:a17:902:6b03:b0:1e0:f525:a831 with SMTP id
 d9443c01a7336-1f6ba65584cmr7839045ad.28.1717781003038; Fri, 07 Jun 2024
 10:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607044354.82225-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20240607044354.82225-1-atrajeev@linux.vnet.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 7 Jun 2024 10:23:11 -0700
Message-ID: <CAP-5=fVCXW1FEBra5aFLJm48f0-b4a+oTugTZt+VYEv1EySBKg@mail.gmail.com>
Subject: Re: [PATCH 1/3] tools/perf: Fix the nrcpus in perf bench futex to
 enable the run when all CPU's are not online
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 9:44=E2=80=AFPM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> Perf bench futex fails as below when attempted to run on
> on a powerpc system:
>
>  ./perf bench futex all
>  Running futex/hash benchmark...
> Run summary [PID 626307]: 80 threads, each operating on 1024 [private] fu=
texes for 10 secs.
>
> perf: pthread_create: No such file or directory
>
> In the setup where this perf bench was ran, difference was that
> partition had 640 CPU's, but not all CPUs were online. 80 CPUs
> were online. While blocking the threads with futex_wait, code
> sets the affinity using cpumask. The cpumask size used is 80
> which is picked from "nrcpus =3D perf_cpu_map__nr(cpu)". Here the
> benchmark reports fail while setting affinity for cpu number which
> is greater than 80 or higher, because it attempts to set a bit
> position which is not allocated on the cpumask. Fix this by changing
> the size of cpumask to number of possible cpus and not the number
> of online cpus.
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

For the series:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/bench/futex-hash.c          | 2 +-
>  tools/perf/bench/futex-lock-pi.c       | 2 +-
>  tools/perf/bench/futex-requeue.c       | 2 +-
>  tools/perf/bench/futex-wake-parallel.c | 2 +-
>  tools/perf/bench/futex-wake.c          | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.=
c
> index 0c69d20efa32..b472eded521b 100644
> --- a/tools/perf/bench/futex-hash.c
> +++ b/tools/perf/bench/futex-hash.c
> @@ -174,7 +174,7 @@ int bench_futex_hash(int argc, const char **argv)
>         pthread_attr_init(&thread_attr);
>         gettimeofday(&bench__start, NULL);
>
> -       nrcpus =3D perf_cpu_map__nr(cpu);
> +       nrcpus =3D cpu__max_cpu().cpu;
>         cpuset =3D CPU_ALLOC(nrcpus);
>         BUG_ON(!cpuset);
>         size =3D CPU_ALLOC_SIZE(nrcpus);
> diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lo=
ck-pi.c
> index 7a4973346180..0416120c091b 100644
> --- a/tools/perf/bench/futex-lock-pi.c
> +++ b/tools/perf/bench/futex-lock-pi.c
> @@ -122,7 +122,7 @@ static void create_threads(struct worker *w, struct p=
erf_cpu_map *cpu)
>  {
>         cpu_set_t *cpuset;
>         unsigned int i;
> -       int nrcpus =3D  perf_cpu_map__nr(cpu);
> +       int nrcpus =3D  cpu__max_cpu().cpu;
>         size_t size;
>
>         threads_starting =3D params.nthreads;
> diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-re=
queue.c
> index d9ad736c1a3e..aad5bfc4fe18 100644
> --- a/tools/perf/bench/futex-requeue.c
> +++ b/tools/perf/bench/futex-requeue.c
> @@ -125,7 +125,7 @@ static void block_threads(pthread_t *w, struct perf_c=
pu_map *cpu)
>  {
>         cpu_set_t *cpuset;
>         unsigned int i;
> -       int nrcpus =3D perf_cpu_map__nr(cpu);
> +       int nrcpus =3D cpu__max_cpu().cpu;
>         size_t size;
>
>         threads_starting =3D params.nthreads;
> diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/fu=
tex-wake-parallel.c
> index b66df553e561..90a5b91bf139 100644
> --- a/tools/perf/bench/futex-wake-parallel.c
> +++ b/tools/perf/bench/futex-wake-parallel.c
> @@ -149,7 +149,7 @@ static void block_threads(pthread_t *w, struct perf_c=
pu_map *cpu)
>  {
>         cpu_set_t *cpuset;
>         unsigned int i;
> -       int nrcpus =3D perf_cpu_map__nr(cpu);
> +       int nrcpus =3D cpu__max_cpu().cpu;
>         size_t size;
>
>         threads_starting =3D params.nthreads;
> diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.=
c
> index 690fd6d3da13..49b3c89b0b35 100644
> --- a/tools/perf/bench/futex-wake.c
> +++ b/tools/perf/bench/futex-wake.c
> @@ -100,7 +100,7 @@ static void block_threads(pthread_t *w, struct perf_c=
pu_map *cpu)
>         cpu_set_t *cpuset;
>         unsigned int i;
>         size_t size;
> -       int nrcpus =3D perf_cpu_map__nr(cpu);
> +       int nrcpus =3D cpu__max_cpu().cpu;
>         threads_starting =3D params.nthreads;
>
>         cpuset =3D CPU_ALLOC(nrcpus);
> --
> 2.43.0
>

