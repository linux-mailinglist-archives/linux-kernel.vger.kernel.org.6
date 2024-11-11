Return-Path: <linux-kernel+bounces-404504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 185309C4521
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8136FB26AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847401A76CB;
	Mon, 11 Nov 2024 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P+rltu8m"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC67145B2E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348422; cv=none; b=YPDcS3perWjKxNmgdc03gqVrFIQgLiU3elVc3+mS1+tZnPo7PNgkcN4Mjr+dLJ9chFCPbBLcczpkyhAkyDX5i/zbQdkPtvMmEaacDHJOF4PZjpqX9JfhraNVOM+6ZrsZ2585IGYGe+m2WKXhanpU2xJq9ifQBUk5isgbDWAXg+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348422; c=relaxed/simple;
	bh=58yifx+tAt5X2MkMpoE74hhJqT4YT+wsW4YmxCsyOWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujo9hRB665dHKEwft55tYC71i/dimNFpRiryfnat8zDy+lW703sPjFy6xR804LI7c0eFn7p7odYrBpyEMesLuMtmsYjz51SWzLsVn05/giH21Wfcw26F+LW6sZhWT//xn6pa6+ykjEuoJZjfUn+9L9pGUm+EplTVnLSpcGHQ6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P+rltu8m; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4608dddaa35so12761cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731348420; x=1731953220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EMInV8pEobG874vX8435Av8a9RTLHQ/BDVSTjz7PpQ=;
        b=P+rltu8m7hh73YCLBQsJolwvsUYW5/l/lleQvEyBgbWrxpxnHRhTPHcwLGL7fhHU5N
         MFWIw2gmKqbDjlENKBfZ1WWKtBIZ+tqnyGjPKsHetJuJt/jYcpa2bH0rSWpyqP9/7Jck
         Xi+nw11iHgIrmFGiAOkC+srP3UDtWa/6f8zeLoo497ChLqdeVH9uZAhhRMSTtVgpdMgt
         l0Btd6y+TYw3NoUTpw9NiykAlvv/x4CVOJ4m8aqdsR7+0MADPGydmPlfBANNJbwNGtoa
         ToANpUF8+dt5dsl8z4wS1Xybwa4j8PNGhR7oOIRSBpBy1MjLaAy/d3RojS1CfvNl+Aje
         DQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731348420; x=1731953220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6EMInV8pEobG874vX8435Av8a9RTLHQ/BDVSTjz7PpQ=;
        b=Nb3K2AFdarplykmvHF4D32FuhmXEeZlE2wvYypMwkD7JPfkaoZZLurNfhdUUzB6ZAW
         hAmjwqZ/WIGvK7zQoFq8yGGqaTas1Y8nnAOeQpawCEOPksdto7xRRMTpmKOKEjVatiC/
         zYZl1qSYj+ix8TXwRyxTsPu0cujvaGPgaVSZJaA3vLzbA4h5xuR5ATf0rtp7zHmMU5UF
         PLveU86LVua+eiYvab9U7QSvtxP6l/6F0pGVuhJIsNJdJzAfrdpMGUxu62iUaxIwDq2l
         0QH79hiOf+MfhxhDPeNHxUgdUdWUitve6aUpWBuCquJMY5r2eR2OUAKxabX3FSp5aivo
         7tdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCLlB8ncCj4gOOnQZ6BTDf600y0UgaXJIm4fh5luo5orY4DBBPu66sLhzLfV2L6P4S0A08oBxDpHAfW3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNrxZjm7Ds4flp2jGdwqX+w8Nj8yCWHpWHh/7RQumeYFqCDFvC
	GL+7RMUzX8gHTYxOOBTG157xVzt+CrpRjeBiTIlHBo08sy1f2WwiEsy5Z6XxOo6SCoPHlWTCZwR
	mM9iLpATM9nguTHdMiPrEAXTjyCD6yjNVBgYB
X-Gm-Gg: ASbGncvCXd7TDFGBw+5jPEIORL3pd2WmCLh1KHgja2J6CEi40lMYxiTxhwha6nAryXp
	TCmh6OGuV4goyDd8CXJcKBHhlG6/Y9neuqHDXoe29xpNu1WFDznTdswyL8XkknQM=
X-Google-Smtp-Source: AGHT+IH93gq1Mr7M0g78vwQ00fTS53uekN1hfBALhOMHqZx5ipgMljuXMvOKj3jGLxkySpN9I7BUVc8IBddXmjg3C0k=
X-Received: by 2002:a05:622a:251:b0:45f:997:4e5a with SMTP id
 d75a77b69052e-46317e2f412mr4508021cf.11.1731348419741; Mon, 11 Nov 2024
 10:06:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com> <20241108204137.2444151-10-howardchu95@gmail.com>
In-Reply-To: <20241108204137.2444151-10-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 10:06:48 -0800
Message-ID: <CAP-5=fX-+bcovrhgW585xZZEZv=bx+=w-Aw5Y8ONR3Q0dORA5Q@mail.gmail.com>
Subject: Re: [PATCH v7 09/10] perf record --off-cpu: Dump the remaining
 samples in BPF's stack trace map
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:41=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Dump the remaining samples, as if it is dumping a direct sample.
>
> Put the stack trace, tid, off-cpu time and cgroup id into the raw_data
> section, just like a direct off-cpu sample coming from BPF's
> bpf_perf_event_output().
>
> This ensures that evsel__parse_sample() correctly parses both direct
> samples and accumulated samples.

Nice, hopefully this should mean we can get rid of the logic holding
all threads live for the sake of off-CPU, as off-CPU events were being
"sampled" after threads had terminated
(symbol_conf.keep_exited_threads). An example of this logic is:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/builtin-report.c?h=3Dperf-tools-next#n1484
Perhaps there is a follow up to dump exiting processes with a BPF
program on `tp/sched/sched_process_exit`. If the exited process is
already "dumped" then its map entry can be removed which may lower
overhead if off-CPU is running for a long time system wide.


> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf_off_cpu.c | 62 +++++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 24 deletions(-)
>
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.=
c
> index cfe5b17393e9..f1be354e2fe7 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -37,6 +37,8 @@ union off_cpu_data {
>         u64 array[1024 / sizeof(u64)];
>  };
>
> +u64 off_cpu_raw[MAX_STACKS + 5];
> +
>  static int off_cpu_config(struct evlist *evlist)
>  {
>         char off_cpu_event[64];
> @@ -61,6 +63,9 @@ static int off_cpu_config(struct evlist *evlist)
>  static void off_cpu_start(void *arg)
>  {
>         struct evlist *evlist =3D arg;
> +       struct evsel *evsel;
> +       struct perf_cpu pcpu;
> +       int i, err;
>
>         /* update task filter for the given workload */
>         if (skel->rodata->has_task && skel->rodata->uses_tgid &&
> @@ -304,6 +309,7 @@ int off_cpu_write(struct perf_session *session)
>  {
>         int bytes =3D 0, size;
>         int fd, stack;
> +       u32 raw_size;
>         u64 sample_type, val, sid =3D 0;
>         struct evsel *evsel;
>         struct perf_data_file *file =3D &session->data->file;
> @@ -343,46 +349,54 @@ int off_cpu_write(struct perf_session *session)
>
>         while (!bpf_map_get_next_key(fd, &prev, &key)) {
>                 int n =3D 1;  /* start from perf_event_header */
> -               int ip_pos =3D -1;
>
>                 bpf_map_lookup_elem(fd, &key, &val);
>
> +               /* zero-fill some of the fields, will be overwritten by r=
aw_data when parsing */
>                 if (sample_type & PERF_SAMPLE_IDENTIFIER)
>                         data.array[n++] =3D sid;
> -               if (sample_type & PERF_SAMPLE_IP) {
> -                       ip_pos =3D n;
> +               if (sample_type & PERF_SAMPLE_IP)
>                         data.array[n++] =3D 0;  /* will be updated */
> -               }
>                 if (sample_type & PERF_SAMPLE_TID)
> -                       data.array[n++] =3D (u64)key.pid << 32 | key.tgid=
;
> +                       data.array[n++] =3D 0;
>                 if (sample_type & PERF_SAMPLE_TIME)
>                         data.array[n++] =3D tstamp;
> -               if (sample_type & PERF_SAMPLE_ID)
> -                       data.array[n++] =3D sid;
>                 if (sample_type & PERF_SAMPLE_CPU)
>                         data.array[n++] =3D 0;
>                 if (sample_type & PERF_SAMPLE_PERIOD)
> -                       data.array[n++] =3D val;
> -               if (sample_type & PERF_SAMPLE_CALLCHAIN) {
> -                       int len =3D 0;
> -
> -                       /* data.array[n] is callchain->nr (updated later)=
 */
> -                       data.array[n + 1] =3D PERF_CONTEXT_USER;
> -                       data.array[n + 2] =3D 0;
> -
> -                       bpf_map_lookup_elem(stack, &key.stack_id, &data.a=
rray[n + 2]);
> -                       while (data.array[n + 2 + len])
> +                       data.array[n++] =3D 0;
> +               if (sample_type & PERF_SAMPLE_RAW) {
> +                       /*
> +                        *  [ size ][ data ]
> +                        *  [     data     ]
> +                        *  [     data     ]
> +                        *  [     data     ]
> +                        *  [ data ][ empty]
> +                        */
> +                       int len =3D 0, i =3D 0;
> +                       void *raw_data =3D (void *)data.array + n * sizeo=
f(u64);
> +
> +                       off_cpu_raw[i++] =3D (u64)key.pid << 32 | key.tgi=
d;
> +                       off_cpu_raw[i++] =3D val;
> +
> +                       /* off_cpu_raw[i] is callchain->nr (updated later=
) */
> +                       off_cpu_raw[i + 1] =3D PERF_CONTEXT_USER;
> +                       off_cpu_raw[i + 2] =3D 0;
> +
> +                       bpf_map_lookup_elem(stack, &key.stack_id, &off_cp=
u_raw[i + 2]);
> +                       while (off_cpu_raw[i + 2 + len])
>                                 len++;
>
> -                       /* update length of callchain */
> -                       data.array[n] =3D len + 1;
> +                       off_cpu_raw[i] =3D len + 1;
> +                       i +=3D len + 2;
> +
> +                       off_cpu_raw[i++] =3D key.cgroup_id;
>
> -                       /* update sample ip with the first callchain entr=
y */
> -                       if (ip_pos >=3D 0)
> -                               data.array[ip_pos] =3D data.array[n + 2];
> +                       raw_size =3D i * sizeof(u64) + sizeof(u32); /* 4 =
bytes for alignment */
> +                       memcpy(raw_data, &raw_size, sizeof(raw_size));
> +                       memcpy(raw_data + sizeof(u32), off_cpu_raw, i * s=
izeof(u64));
>
> -                       /* calculate sample callchain data array length *=
/
> -                       n +=3D len + 2;
> +                       n +=3D i + 1;
>                 }
>                 if (sample_type & PERF_SAMPLE_CGROUP)
>                         data.array[n++] =3D key.cgroup_id;
> --
> 2.43.0
>

