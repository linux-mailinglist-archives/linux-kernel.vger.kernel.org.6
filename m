Return-Path: <linux-kernel+bounces-573967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E166A6DF01
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEB616C615
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7C71E531;
	Mon, 24 Mar 2025 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rg5dx8Zw"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3625F979
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831451; cv=none; b=SCZaTyXOP0S9339bfFkV2XjHHf/0bDfmxpVbYUE94MXhQfCBmW51UGrmJ8H2yGZpVQnQpjKVCC27PyVI6xkrNz8v6fr1iUZu77X+QTKOwRUMJu2PYySO9Vbo1e0tiSIAQTcOfIZ/mMXik0SnxgghnsEv9HyJjm3VzDLgPOj+RCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831451; c=relaxed/simple;
	bh=iC7dfpUdHfAvWLxMF1a4lZ6q0xl4Aagkf2KHFMc1yQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMCUYIbuyN2+YnaNRlKNS3gcA4YwWow891ZTtwqrOVsQj/mjCZwzn+GN9Gufbr7tTJSS1rCcLTIRO6FII1sTCqi8qm/k0Hb7tp9SjwVGLdfX3KtuReKsDkgM4jA7x+IDTt2fbGA1mjRJ/VSK66+08VRBAM14tIuBapa58pI2ucM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rg5dx8Zw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2242ac37caeso383375ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742831448; x=1743436248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvP8eWaYqIznmmYZkIkwVCH6qx4RfXMKSXMvsdyGlPc=;
        b=rg5dx8ZwvOpHWpDBltf3XmmCma5wVBVWmjd9EBG5OhhgnUJUexMaQ9NQ64fRC2VrW+
         vF6/M3e+G2k8quIdG32xPIXDxe7FFRLFVShWKuINTiJjbvIo5zwQWwEqkERHHZdS34RL
         hMZm/6zKYIP1dpXmQKI/qso4xxpD6IAeHo2lBrehFhdhQkEjq+ORUlpWJDgx/i9dyFCQ
         o0qTIo1LzPoD+qpu8FBt5gAdEqm8EDXVRg5pew6HQAXG5yxBpXiBLExyb8+AVNB/wvgI
         zzG8Sb4L/nv5rtmjr2V7GxHe0hUiuCboyntMfqJsIKSo7Rndyzdv7w7jtBn0zeM219TT
         9UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742831448; x=1743436248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvP8eWaYqIznmmYZkIkwVCH6qx4RfXMKSXMvsdyGlPc=;
        b=K4iU1YBhR/eeQt7ALUN6NFattqs/NeS/rxjpQAZDvn0e7etfcx3b1iM45xVf6ms0cB
         9rSAg2wGtHBLV3WWa2GiHUpN/tx7v3IQ4jJQPZ0WFTyYijJyz+ioWOzvCyIZfxC1QZH6
         3xUx1sPsHWz75m8hqSAUWh74QP4ZYZiAy3taFmIdPTgIpbvckMyTZtFrE2k8/GvS1RXT
         YU9per18FT/ugai0niclRglfWtgwE5b/4PBwhrubP0rzZEC+UX3P9sdJI8rECuatmiYA
         3jy0Hirdn7KKh9ILEVlc8L88iy/3Pe/x22UE9TBTKF3skSR/9FgxiNUj8LGLhGOstEdz
         CEHw==
X-Gm-Message-State: AOJu0YxcAygGV7A7iyYuYm9x8g5/ml5JNEXt3MSEsiDBY0krPg8rs9pN
	5ZTS7ZAYB/xk8AEAKdclD7lp/rJosR32eKOjZKVviRR8L+fUCnPD5syvhWlW0/ApXC87MZqrhQ+
	Q+SPeaF/wbSA3azGg20R2aCTG6DlmhlX4T8yR
X-Gm-Gg: ASbGncuHin9j6QpHrQmt2bo6rBgFA44Q77VHUrqpDedsHy46vyZxUw7bd865ThZtZP1
	cxpJckVjmtcMAsgGtR24rMlTCZoJSKZGXm05q6TuYDOlqUfUkvf+SlghJx1jqCcHHnlNQQv4L34
	A/o/uVf5s5EzbhaYHNViSVzFvrInlw1bsu2tSr5wVm6+6Dmn/Psz6piPKkhK5qPt7Zwg==
X-Google-Smtp-Source: AGHT+IEkqLjkjkKV0BoryNLZCKYsJZuoARtK320e+r0SizuUym1WHCy1JsYihCnG35nWDbqzuoSwrGMxS3kMcOx8ipg=
X-Received: by 2002:a17:902:f707:b0:21f:40e8:6398 with SMTP id
 d9443c01a7336-22798319d4emr5412215ad.26.1742831447311; Mon, 24 Mar 2025
 08:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324152756.3879571-1-tmricht@linux.ibm.com> <CAP-5=fXPgoocDSRxzYpkzcLsPwKsp9b80b1KPDWv-obkmiX-fA@mail.gmail.com>
In-Reply-To: <CAP-5=fXPgoocDSRxzYpkzcLsPwKsp9b80b1KPDWv-obkmiX-fA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Mar 2025 08:50:36 -0700
X-Gm-Features: AQ5f1JoLnJ6gBw7l0R3pxQ2BDt_h9unn7xjMEHDp0sSAorOpWJxUv0zpcHKd3tU
Message-ID: <CAP-5=fU+9EQKT2fOuBQ5ds6s4Bh6rWrvco1ow6B-CQ92XuO1kQ@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Fix wrong size to bpf_map__update_elem call
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	james.clark@linaro.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 8:38=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Mar 24, 2025 at 8:28=E2=80=AFAM Thomas Richter <tmricht@linux.ibm=
.com> wrote:
> >
> > In linux-next
> > commit c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t"=
)
> > causes the perf tests 100 126 to fail on s390:
> >
> > Output before:
> >  # ./perf test 100
> >  100: perf trace BTF general tests         : FAILED!
> >  #
> >
> > The root cause is the change from int to int16_t for the
> > cpu maps. The size of the CPU key value pair changes from
> > four bytes to two bytes. However a two byte key size is
> > not supported for bpf_map__update_elem().
>
> Nice catch!
>
> > Note: validate_map_op() in libbpf.c emits warning
> >  libbpf: map '__augmented_syscalls__': \
> >          unexpected key size 2 provided, expected 4
> > when key size is set to int16_t.
>
> Wow, weird.

Ah, I guess it is a mismatch with the declaration in
tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c?h=3Dperf-tools=
-next#n31
```
/* bpf-output associated map */
struct __augmented_syscalls__ {
       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
       __type(key, int);
       __type(value, __u32);
       __uint(max_entries, MAX_CPUS);
} __augmented_syscalls__ SEC(".maps");
```
but this looks wrong. The values are file descriptors, so should be
ints. I think it should be:
```
struct __augmented_syscalls__ {
       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
       __type(key, int16_t);
       __type(value, int);
       __uint(max_entries, MAX_CPUS);
} __augmented_syscalls__ SEC(".maps");
```
I'm not sure if max_entries can be a uint16_t too. I suspect this may
well interfere with BPF_MAP_TYPE_PERF_EVENT_ARRAY and its use by
bpf_perf_event_output. Probably best to keep things in the BPF code as
they are and do your builtin-trace.c fix. Perhaps someone else can
clean this up.

Thanks,
Ian

> > Therefore change to variable size back to 4 bytes for
> > invocation of bpf_map__update_elem().
> >
> > Output after:
> >  # ./perf test 100
> >  100: perf trace BTF general tests         : Ok
> >  #
> >
> > Fixes: c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t"=
)
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: James Clark <james.clark@linaro.org>
> > ---
> >  tools/perf/builtin-trace.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 092c5f6404ba..464c97a11852 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -4375,10 +4375,12 @@ static int trace__run(struct trace *trace, int =
argc, const char **argv)
> >                  * CPU the bpf-output event's file descriptor.
> >                  */
> >                 perf_cpu_map__for_each_cpu(cpu, i, trace->syscalls.even=
ts.bpf_output->core.cpus) {
> > +                       int mycpu =3D cpu.cpu;
> > +
> >                         bpf_map__update_elem(trace->skel->maps.__augmen=
ted_syscalls__,
> > -                                       &cpu.cpu, sizeof(int),
> > +                                       &mycpu, sizeof(int),
>
> nit: It is usually preferred to do "sizeof(mycpu)" to avoid the
> problems like the one this fix is fixing. And I'm blamed for the bad
> code in:
> 5e6da6be3082 perf trace: Migrate BPF augmentation to use a skeleton
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks for the fixes!
> Ian
>
> >                                         xyarray__entry(trace->syscalls.=
events.bpf_output->core.fd,
> > -                                                      cpu.cpu, 0),
> > +                                                      mycpu, 0),
> >                                         sizeof(__u32), BPF_ANY);
> >                 }
> >         }
> > --
> > 2.48.1
> >

