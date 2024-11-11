Return-Path: <linux-kernel+bounces-404518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7D69C44AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA442835BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8221AB512;
	Mon, 11 Nov 2024 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QujB9rwJ"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A091AAE34
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348675; cv=none; b=LtQpgU8m56BXEqc4n0YoHprH+OgPkGZLioV37giyzjQvcwXffDWoY9Mr+XNIz/nQcQ8yzoF3TnU9fJpninfhTyh8nDaNdgeRv35NuXWE0C9IMye5idiV6Q+s0Hl+5A3jqqBoGojhZgy6o1/Eck3U/tr6xmcgt45/d43iim0RFmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348675; c=relaxed/simple;
	bh=C8xKwoGQoMQK9ZgUsMPcEh0TUdId4YbQ9YGMzarKLKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Px1w42fQg/7m1wEw32Q3TCkN8fKgmffao+z1hnnCpKiFPDgdu0JnSx1Vq/FsQ1NB2K9hhHqiNln6o/SUlCwtHO9pn2cBx7Fcp+6f/48sqq4PcTNSrFP1ZpdW8cQ7UOtEqWoqQmbOeuujtUVzmwthDjW0giiR+/dZugxayAVfIzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QujB9rwJ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4608dddaa35so16311cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731348672; x=1731953472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLeUScaZOLp4AS2pmDqoo02DY+qDAt8yb7nGV4VChPc=;
        b=QujB9rwJf1vbXBMYn3vi/bjbbadYHe/Dfe5A9UVF1zz0MUjMKZZMPVy3Ob2814JBid
         UGwq5NZPYMHwNuORkf9A9X1WOtVoAUfZnVnBTYmLCO1k6miKMY07F3Vqat9EvqK4BXcw
         Zdumrsvyu7V6nwAjDzn5ciDMNIMkUv7kQ6IK9YySuRzINqoWGh4onwxM6UF2ktM8cCJv
         PAARij9/mnQR0tH2cCwPfD+H8mKGeY6W9IJamXnN8QtZvRN3kgmMqkScIEiSfRRAMMv6
         nnfbhkcbgfIgsGwZF0u7O5Vc+ksFW8V/OXKgLf0l1zpDcMW4l7KnIS5hWqx14wMh9xWE
         WEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731348672; x=1731953472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLeUScaZOLp4AS2pmDqoo02DY+qDAt8yb7nGV4VChPc=;
        b=k5fuvSAw6PrQ+QE02o/HQgLlMMEtlTZBDkTnwgQOBJkGnlW3I4XIUyKt039UO5Tlu2
         FLY4/vB8FwL04WPDdvss+d5UiG/fh8GI/NgyrKuerXenrFdUNXZYcoFDNckhZR11COxp
         K8UgKcjSJUJp6YkAZ9woheSgoiI/rPm8XzXvoL2+UtTz276SMoP1tzafNZAVYsCZ8qON
         YSPZdYiA/ovB5mMc8SKRhYXpPRraVHqFW4Ccal5jda8eY4+rKz70TKa6O9pQoKzOEYzm
         i7nr5uw9s9UXI0AvF1OErSoUellh9unQCsCvrSb9WKIvXp4Bv3B9d6QACNNBR6JXF3iV
         YFeA==
X-Forwarded-Encrypted: i=1; AJvYcCUOuEDxye2Wllg4tJN5d22wc9cLWOyTTUxopDcCOaFpUyKIkynKgY4QkEwKjWVraipxPsnbGawt29vX1KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQJQl8s2dIOrexH7AvSCWvGejCP3QkXk05wacnoVwEnVrsego
	RKONzumj8Y7inZA8Y1IzwriZQ9Ms7rcJ9pB7JsQYy2vmBdx8RgPAlIqW37MeIZIQj4d8iz1nV/W
	Onu5fK2IJ5wf37cYjHxEmSo287U1FCGZo+xJcgQCuk+khxz4tyIsJ
X-Gm-Gg: ASbGncvi34OMlmHpc+ctTg2Tdb8C+u8Bwe5GEmkiloCPGCofDsHrVcSD0k9iHg8kLdA
	qpxjLkbG+2zbysTrGMrVwJqNFJnlIvggmFx8G404G181d2YAvcj/JKsUX4zaYqJQ=
X-Google-Smtp-Source: AGHT+IFzpXd9zGmGA+nX7CLwsyojNd+rl5R+mn5ACPkmw1xt2toSBXUTHR+DciUmrkBHeWjJboxHHcNAxN+MryXdOps=
X-Received: by 2002:a05:622a:1813:b0:460:491e:d2a2 with SMTP id
 d75a77b69052e-46317e2f552mr5075631cf.17.1731348672277; Mon, 11 Nov 2024
 10:11:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com>
 <20241108204137.2444151-6-howardchu95@gmail.com> <CAP-5=fXDd2MUvukB6NVMN962wxjPN6_F-AxOxOUUb-uj5BVV0A@mail.gmail.com>
 <CAH0uvogkoUW+hA7V8TgyUT-PrGx6JajKZDMj9-w9z25QVT5O4Q@mail.gmail.com>
In-Reply-To: <CAH0uvogkoUW+hA7V8TgyUT-PrGx6JajKZDMj9-w9z25QVT5O4Q@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 10:11:01 -0800
Message-ID: <CAP-5=fVXgQjAh1OFDN7DMp=xw5cAHRaO8j8UQfe4CZHrZc8uFg@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] perf record --off-cpu: Dump off-cpu samples in BPF
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 10:05=E2=80=AFAM Howard Chu <howardchu95@gmail.com>=
 wrote:
>
> Hi Ian,
>
> On Mon, Nov 11, 2024 at 9:54=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Fri, Nov 8, 2024 at 12:41=E2=80=AFPM Howard Chu <howardchu95@gmail.c=
om> wrote:
> > >
> > > Collect tid, period, callchain, and cgroup id and dump them when off-=
cpu
> > > time threshold is reached.
> > >
> > > We don't collect the off-cpu time twice (the delta), it's either in
> > > direct samples, or accumulated samples that are dumped at the end of
> > > perf.data.
> > >
> > > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > > ---
> > >  tools/perf/util/bpf_skel/off_cpu.bpf.c | 83 ++++++++++++++++++++++++=
--
> > >  1 file changed, 78 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util=
/bpf_skel/off_cpu.bpf.c
> > > index dc6acafb9353..bf652c30b1c9 100644
> > > --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > > +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > > @@ -18,10 +18,18 @@
> > >  #define MAX_STACKS   32
> > >  #define MAX_ENTRIES  102400
> > >
> > > +#define MAX_CPUS  4096
> > > +#define MAX_OFFCPU_LEN 37
> > > +
> > > +struct stack {
> > > +       u64 array[MAX_STACKS];
> > > +};
> > > +
> > >  struct tstamp_data {
> > >         __u32 stack_id;
> > >         __u32 state;
> > >         __u64 timestamp;
> > > +       struct stack stack;
> > >  };
> > >
> > >  struct offcpu_key {
> > > @@ -39,6 +47,24 @@ struct {
> > >         __uint(max_entries, MAX_ENTRIES);
> > >  } stacks SEC(".maps");
> > >
> > > +struct offcpu_data {
> > > +       u64 array[MAX_OFFCPU_LEN];
> > > +};
> > > +
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> > > +       __uint(key_size, sizeof(__u32));
> > > +       __uint(value_size, sizeof(__u32));
> > > +       __uint(max_entries, MAX_CPUS);
> > > +} offcpu_output SEC(".maps");
> >
> > Does patch 4 build without this definition? (we're in patch 5 here). I
> > think this should be in patch 4.
>
> Okay sure thanks :)
>
> >
> > > +
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> > > +       __uint(key_size, sizeof(__u32));
> > > +       __uint(value_size, sizeof(struct offcpu_data));
> > > +       __uint(max_entries, 1);
> > > +} offcpu_payload SEC(".maps");
> > > +
> > >  struct {
> > >         __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> > >         __uint(map_flags, BPF_F_NO_PREALLOC);
> > > @@ -185,6 +211,39 @@ static inline int can_record(struct task_struct =
*t, int state)
> > >         return 1;
> > >  }
> > >
> > > +static inline int copy_stack(struct stack *from, struct offcpu_data =
*to, int n)
> > > +{
> > > +       int len =3D 0;
> > > +
> > > +       for (int i =3D 0; i < MAX_STACKS && from->array[i]; ++i, ++le=
n)
> > > +               to->array[n + 2 + i] =3D from->array[i];
> > > +
> > > +       return len;
> > > +}
> > > +
> >
> > Dump is something of a generic name. Could you kernel-doc this
> > function to describe the behavior?
>
> Sure.
>
> >
> > > +static int off_cpu_dump(void *ctx, struct offcpu_data *data, struct =
offcpu_key *key,
> > > +                       struct stack *stack, __u64 delta, __u64 times=
tamp)
> > > +{
> > > +       /* dump tid, period, callchain, and cgroup id */
> > > +       int n =3D 0, len =3D 0;
> > > +
> > > +       data->array[n++] =3D (u64)key->tgid << 32 | key->pid;
> > > +       data->array[n++] =3D delta;
> > > +
> > > +       /* data->array[n] is callchain->nr (updated later) */
> > > +       data->array[n + 1] =3D PERF_CONTEXT_USER;
> > > +       data->array[n + 2] =3D 0;
> > > +       len =3D copy_stack(stack, data, n);
> > > +
> > > +       /* update length of callchain */
> > > +       data->array[n] =3D len + 1;
> > > +       n +=3D len + 2;
> > > +
> > > +       data->array[n++] =3D key->cgroup_id;
> > > +
> > > +       return bpf_perf_event_output(ctx, &offcpu_output, BPF_F_CURRE=
NT_CPU, data, n * sizeof(u64));
> > > +}
> > > +
> > >  static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
> > >                         struct task_struct *next, int state)
> > >  {
> > > @@ -209,6 +268,12 @@ static int off_cpu_stat(u64 *ctx, struct task_st=
ruct *prev,
> > >         pelem->state =3D state;
> > >         pelem->stack_id =3D stack_id;
> > >
> > > +       /*
> > > +        * If stacks are successfully collected by bpf_get_stackid(),=
 collect them once more
> > > +        * in task_storage for direct off-cpu sample dumping
> > > +        */
> > > +       if (stack_id > 0 && bpf_get_stack(ctx, &pelem->stack, MAX_STA=
CKS * sizeof(u64), BPF_F_USER_STACK)) {
> > > +       }
> >
> > Why the empty if?
>
> Forgot to say in the commit message, bpf_get_stack() has a return
> value and if I don't use it I'll get result unused warning from clang,
> so either this or:
>     int __attribute__((unused)) len;
>     len =3D bpf_get_stack(ctx, stack_p->array, MAX_STACKS * sizeof(u64),
>
> We don't need error handling, it goes to "next:" naturally, there's no
> code in between.

Perhaps capture that as a comment in the `if` and/or add a continue,
just to show that the code doesn't care about errors.

Thanks,
Ian

> >
> > > +
> > >  next:
> > >         pelem =3D bpf_task_storage_get(&tstamp, next, NULL, 0);
> > >
> > > @@ -223,11 +288,19 @@ static int off_cpu_stat(u64 *ctx, struct task_s=
truct *prev,
> > >                 __u64 delta =3D ts - pelem->timestamp;
> > >                 __u64 *total;
> > >
> > > -               total =3D bpf_map_lookup_elem(&off_cpu, &key);
> > > -               if (total)
> > > -                       *total +=3D delta;
> > > -               else
> > > -                       bpf_map_update_elem(&off_cpu, &key, &delta, B=
PF_ANY);
> > > +               if (delta >=3D offcpu_thresh) {
> > > +                       int zero =3D 0;
> > > +                       struct offcpu_data *data =3D bpf_map_lookup_e=
lem(&offcpu_payload, &zero);
> > > +
> > > +                       if (data)
> > > +                               off_cpu_dump(ctx, data, &key, &pelem-=
>stack, delta, pelem->timestamp);
> > > +               } else {
> > > +                       total =3D bpf_map_lookup_elem(&off_cpu, &key)=
;
> > > +                       if (total)
> > > +                               *total +=3D delta;
> > > +                       else
> > > +                               bpf_map_update_elem(&off_cpu, &key, &=
delta, BPF_ANY);
> > > +               }
> >
> > Looks good! :-)
> >
> > Thanks,
> > Ian
> >
> > >
> > >                 /* prevent to reuse the timestamp later */
> > >                 pelem->timestamp =3D 0;
> > > --
> > > 2.43.0
> > >
>
> Thanks,
> Howard

