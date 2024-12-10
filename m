Return-Path: <linux-kernel+bounces-440181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B71DF9EB9C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32112283647
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0219214211;
	Tue, 10 Dec 2024 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdaqnT44"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C072A94D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857406; cv=none; b=lTT7/yjcxI8sWQ+l4pwJTTmpw7wgZCWQf3aBR0OF7bhVkTKQejz3S+bN4xraSpCOnj3c8cIJqr65DGuOJqQoFgYNPSw51/8mwTWN42wprpoA0wMD6Bs8PlBxYhX+Qa1S1xd0OUkdts0ZJmmtqG2MydcKVA08VWPRKlY7YRTZ1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857406; c=relaxed/simple;
	bh=JQPrHyno2Uhcx368ucWsDEb8yj17YXMb2Z1VYots7i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2416i+QGpaIoAZwoKQ2ttbgVcGL4q99zmNfKx2iywpTvw3rLI9/7VAm5tQ1lCu/o3cx8zXRVYiflE1K0JaDWrSbJri7cspjhaf3v6gwJCKXlsd6d5WAqwPwG1WbzM8Gqv+hvW2CVcw5aMYhOUmb8ADu2v1R9KW6iqwj6U4ysyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WdaqnT44; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3c2135f61so1281a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733857402; x=1734462202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Xw37cXKbeko0CglK9u2u4pdjLrr9Djyjn77nsaLsBo=;
        b=WdaqnT443bumkP08NhLXlEU+nTkdTbqD/kumqQ8lkCmgVWhVMSiJttLqdnZ5rVvP/R
         eBb2UXletIkqgrH2cM0vc4/B6VLz1fwciWUs7PP2VU19HgFw1FdsMCW/mAZwuyJWc0Ju
         Ak2S2QBcoLQ90kpP2qcdKti4rqE4aX0A70Jsipbrnv8oOi2i2qN+tBS94kH75b3M/28N
         QB+aTQGbbUg2pJOR6DxUmep7qXyKUCZ1UuWED/kwSCpJSzPpLNd2wm/rXbIHeBTb7Ktj
         P+n60P8Rii/+ox9wE6AUoYFbpHiAQskg/KFj3VvIktmxC3E3KeLL3JIzpmZU56/QVrcW
         aR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733857402; x=1734462202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Xw37cXKbeko0CglK9u2u4pdjLrr9Djyjn77nsaLsBo=;
        b=Q4gdts2aUYd0rPUnsaWmM89yuTv3YSv0VO00/ER5K/p9XVTbo9HvHIj4h1A7HngeDb
         ufrMj+ti+2mRHs4VLDvpfoExAtkfjRxEcmYobxbHaX448+S38V0K5Heu/OMMgl1NyEjR
         HOpUZqOUgAXWpmzKULMx7JJPgPAIuJ1kTIEWAWGO8eoFmphkxQXSF+LNa4QJB6Lf5uDc
         eY8u0BuCyl8x2Xfds5Spuw1skl0LgXZeBkF+QoKd/9Cdnsa1zJX5ZrHdj0MwUwRhfe1T
         BjI5dBLHNlR+hjoql4QnLa1pUHWmCnENnJv1mnjSg90soKBgcW926m6jFcxyab3Gm866
         Efgw==
X-Forwarded-Encrypted: i=1; AJvYcCWEsLtEX5DrWZCLdnFxIeNV81+cbCLCwS1Avcm2QDefQ5UW/c3NYN52Db9miKQYOJOZogxSX4sJQOZFhto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEYim0w88W1QqZJ5QgXi15DCIkY9pWDsvFaCH1qHTFlrM2Cxjx
	IAWjxxjAxSvb25HcxMZxSszXInaRCu2rJBw9aH2241IZ72Clxy6rwsjvztuvX3bKoAsmogb53TW
	zOgHfYLhdLLtNSLjKUn3vzTFi/rZNeWuPsDVtOW3yWsjV8e+h8kVc
X-Gm-Gg: ASbGncvDvSMGeFm+uwcFpr6eUS2nqOy1wM0sk65Q4eRe302fszgA/YiIg291FaCfKBJ
	TirU071nrGcROSMdXosqhrPP6ZL0HVTJqMfPF1nMQusc5UzZxc2XgLK3/47Iu5zw=
X-Google-Smtp-Source: AGHT+IE7oP16KMCvkMfL/nB3Ja7AEug/bE2blDeMFWu79MccrzhqoVbY0YgcFFKp0oL77NCqITE3X16PxtwbqurcC5Y=
X-Received: by 2002:a05:6402:5171:b0:5d0:84a6:f1a1 with SMTP id
 4fb4d7f45d1cf-5d4322d70b8mr3923a12.6.1733857402227; Tue, 10 Dec 2024 11:03:22
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-bpf-fix-uprobe-uaf-v3-1-ce50ae2a2f0f@google.com> <CAEf4BzacBUdttSi9d0Ecud7XEgdMrzsbZa0wmpFceLRwjQ-=dg@mail.gmail.com>
In-Reply-To: <CAEf4BzacBUdttSi9d0Ecud7XEgdMrzsbZa0wmpFceLRwjQ-=dg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 10 Dec 2024 20:02:45 +0100
X-Gm-Features: AZHOrDmv1eNKS5kr9MBDIyp1VcoEAu-nXOHDbvNtIu6V50imsXi8ufm9b1sZA7c
Message-ID: <CAG48ez29vVYF2yWDQEJb=_+u+737aUm4idfkhkEtFQjHivv7-g@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: Fix theoretical prog_array UAF in __uprobe_perf_func()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Delyan Kratunov <delyank@fb.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 6:52=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Tue, Dec 10, 2024 at 7:34=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> > Currently, the pointer stored in call->prog_array is loaded in
> > __uprobe_perf_func(), with no RCU annotation and no immediately visible
> > RCU protection, so it looks as if the loaded pointer can immediately be
> > dangling.
> > Later, bpf_prog_run_array_uprobe() starts a RCU-trace read-side critica=
l
> > section, but this is too late. It then uses rcu_dereference_check(), bu=
t
> > this use of rcu_dereference_check() does not actually dereference anyth=
ing.
> >
> > Fix it by aligning the semantics to bpf_prog_run_array(): Let the calle=
r
> > provide rcu_read_lock_trace() protection and then load call->prog_array
> > with rcu_dereference_check().
> >
> > This issue seems to be theoretical: I don't know of any way to reach th=
is
> > code without having handle_swbp() further up the stack, which is alread=
y
> > holding a rcu_read_lock_trace() lock, so where we take
> > rcu_read_lock_trace() in __uprobe_perf_func()/bpf_prog_run_array_uprobe=
()
> > doesn't actually have any effect.
> >
> > Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by chaining gps"=
)
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > Changes in v3:
> > - align semantics with bpf_prog_run_array()
> > - correct commit message: the issue is theoretical
> > - remove stable CC
> > - Link to v2: https://lore.kernel.org/r/20241206-bpf-fix-uprobe-uaf-v2-=
1-4c75c54fe424@google.com
> >
> > Changes in v2:
> > - remove diff chunk in patch notes that confuses git
> > - Link to v1: https://lore.kernel.org/r/20241206-bpf-fix-uprobe-uaf-v1-=
1-6869c8a17258@google.com
> > ---
> >  include/linux/bpf.h         | 11 +++--------
> >  kernel/trace/trace_uprobe.c |  6 +++++-
> >  2 files changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index eaee2a819f4c150a34a7b1075584711609682e4c..7fe5cf181511d543b1b1000=
28db94ebb2a44da5d 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2193,26 +2193,22 @@ bpf_prog_run_array(const struct bpf_prog_array =
*array,
> >   * rcu-protected dynamically sized maps.
> >   */
> >  static __always_inline u32
> > -bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu=
,
> > +bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
> >                           const void *ctx, bpf_prog_run_fn run_prog)
> >  {
> >         const struct bpf_prog_array_item *item;
> >         const struct bpf_prog *prog;
> > -       const struct bpf_prog_array *array;
> >         struct bpf_run_ctx *old_run_ctx;
> >         struct bpf_trace_run_ctx run_ctx;
> >         u32 ret =3D 1;
> >
> >         might_fault();
> > +       RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock held=
");
> >
> > -       rcu_read_lock_trace();
> >         migrate_disable();
> >
> >         run_ctx.is_uprobe =3D true;
> >
> > -       array =3D rcu_dereference_check(array_rcu, rcu_read_lock_trace_=
held());
> > -       if (unlikely(!array))
> > -               goto out;
>
> I think we should keep this unlikely(NULL) check, bpf_prog_run_array()
> has it and see bpf_prog_array_valid() comment below

Whoops, yeah, I removed it here at some point while moving the
dereference around and then forgot to re-add it; will fix.

