Return-Path: <linux-kernel+bounces-546081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B69AA4F618
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8638E3AA1D4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332341C8603;
	Wed,  5 Mar 2025 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="na/RtRd7"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF401B532F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 04:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741149022; cv=none; b=q9noO+FvpEtnjXnd7tQGic3iXOKS2s7SzAD8N3wEHI1DCWQCnQ9ciyTzKl8SGJVUIalzMZbgE8k3Co06U1uRDT/pt+iBG9/XBqvyeUHtnHCpZm6n4jatMZy1f5O7hY9nG/dXnlWnRO/t5mNW4/jqBXBn1piJaS/JmxFvlFeACXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741149022; c=relaxed/simple;
	bh=O6/s2m8RxEllylHpZfEA1JZvaM68FhhtYDbILLNNmqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyXKU0mkpDICmf7HqK3Z05GkoN2Y5/pvLBbNAQq50/XgQ7kdqZIw0+xy8hVgmV30sBSppt8l+avHe3Re9WKWam3s8WMa61yn0MXWPkXAQYy9vh7I+lkvUma8HKM/UlOimST8bBC5PWaISS9wlcYKkrkzAKLuBdumkGDjQJ18RUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=na/RtRd7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2237a32c03aso60895ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 20:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741149020; x=1741753820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqAVkWXON7xuHQOFv96KRGgH0wCs+/tXGGMj9KqfDeI=;
        b=na/RtRd7tqfTjZRtK3g/RDptCGtcsO7XHnCbqKDG9kGIfqiMMIs+EG9mr4ktRpaNDX
         c9ozLYEb69BUU7EDQvrGm4sQiuAoAyfyYCiV8Q3NjQziLMa6fz15fFUAbhocjnqRtShj
         bt/FZhBuHtWCoqTdHkYNaW2cyvOxqRcIe6Jl6m3BxTkHiJYImuyymJ0oVISu9k4fwSfz
         Q7Vp7fbeZVkAuQqA9dHtVb+XnDO5Gh/I1O6XttIPq7usUfusdw3RjbWGej+N+Kv2DEfD
         CN5lfL/ztNS1LCR+vS/uAxy6MIlmxAyBjalC+M9XF3CwbvC8tijUsOXTAzTllKzp6sRg
         T85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741149020; x=1741753820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqAVkWXON7xuHQOFv96KRGgH0wCs+/tXGGMj9KqfDeI=;
        b=gWe2p97LhVeKntNmacF9y6aO+DkATd4zwSoulVs3BhnrgGZGtdH4MUBpU0MSkiUF1s
         g5xSLldvo2cKIYlmDtONJmeoLvQKXD193AAmELB+ryIQ/T9M/2xc3ty2Eg37FLOEz4AJ
         ZMTVKbncoknE/TLA9/uzwqQVqgpyGu4MPgRF96VDpxNf3vS5ZQe+Wr72lWnCrjOC486u
         IUOZ9bula+m6T3SbJsRwfquFw1ScMuni4YhC7CCiT2XkrS9gsYoTxXFXh4bGI4ZwUCyR
         3WHUPhUVM4yD7C6l7kNvFRQm/E10rU1P9HWRZBzdqcOHoSzAIQPhc1AARb3YJ1rgKEem
         rShg==
X-Forwarded-Encrypted: i=1; AJvYcCXmwORzZTADn42gI1DXlCKHpWOtWNyL63s49oCbF1WOed3tgMMzUlVGImV3dHTERmpR3IJ5Nsei8L6AOsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YznSzivlLp9HRdFZaVN6a51s22brV89GQkmt3lAxiY81Bfa7BxQ
	PtvBcT5Apq/SC6q+1XiFsiV5y+qW1r6LPcujoiBBKoWV5bCwXfea1VF6ip7cw127ADiv58NhvQr
	UpWDGGxXiMURTZj9IVR+UAfKKW1h+CvMSN2SC
X-Gm-Gg: ASbGnctJ9cFaZ8l9JOFFS+RzLMdFPuge5gRnmk8LwLjJrs4K7NhYuikTRoOD5iaO0Iy
	S6vRplo54IW2tMcjLmoGipcQN64GU+JSetBJcWF9SWT3Y7eyUkdKUkTIayfdnXTbZVkqS0ZJ/8E
	nup0lpYqbN5+BqZL/pkRwiM22cL9c=
X-Google-Smtp-Source: AGHT+IFXOo/mmL5SJ31wQtNHPUkm4JMIE8sOGmsWeE1gasbzoqgQCyR5uJ8DMXe8kraJhOzM+x9J4sLkrHLc+hRvljY=
X-Received: by 2002:a17:903:3291:b0:212:26e:1b46 with SMTP id
 d9443c01a7336-223f452ff4bmr1032645ad.23.1741149019562; Tue, 04 Mar 2025
 20:30:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304013906.1393102-1-thomas.falcon@intel.com>
In-Reply-To: <20250304013906.1393102-1-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Mar 2025 20:30:07 -0800
X-Gm-Features: AQ5f1JrWW7mThi0-TdrkenDRcxOAjqehVtorC0CaIsHnJ3yQ2cnbxhzMHLItUls
Message-ID: <CAP-5=fVwrG5ZViysO7qKYUw0326WFfa7nOzwe70drYfHq=AXhA@mail.gmail.com>
Subject: Re: [PATCH v5] perf script: Fix output type for dynamically allocated
 core PMU's
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Kan Liang <kan.liang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:39=E2=80=AFPM Thomas Falcon <thomas.falcon@intel.c=
om> wrote:
>
> This patch was originally posted here:
>
> https://lore.kernel.org/all/20241213215421.661139-1-thomas.falcon@intel.c=
om/
>
> I have rebased on top of Arnaldo's patch here:
>
> https://lore.kernel.org/all/Z2XCi3PgstSrV0SE@x1/
>
> The original commit message:
> "
> perf script output may show different fields on different core PMU's
> that exist on heterogeneous platforms. For example,
>
> perf record -e "{cpu_core/mem-loads-aux/,cpu_core/event=3D0xcd,\
> umask=3D0x01,ldlat=3D3,name=3DMEM_UOPS_RETIRED.LOAD_LATENCY/}:upp"\
> -c10000 -W -d -a -- sleep 1
>
> perf script:
>
> chromium-browse   46572 [002] 544966.882384:      10000         cpu_core/=
MEM_UOPS_RETIRED.LOAD_LATENCY/: 7ffdf1391b0c     10268100142 \
>  |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK    N/A    5   7=
    0   7fad7c47425d [unknown] (/usr/lib64/libglib-2.0.so.0.8000.3)
>
> perf record -e cpu_atom/event=3D0xd0,umask=3D0x05,ldlat=3D3,\
> name=3DMEM_UOPS_RETIRED.LOAD_LATENCY/upp -c10000 -W -d -a -- sleep 1
>
> perf script:
>
> gnome-control-c  534224 [023] 544951.816227:      10000 cpu_atom/MEM_UOPS=
_RETIRED.LOAD_LATENCY/:   7f0aaaa0aae0  [unknown] (/usr/lib64/libglib-2.0.s=
o.0.8000.3)
>
> Some fields, such as data_src, are not included by default.
>
> The cause is that while one PMU may be assigned a type such as
> PERF_TYPE_RAW, other core PMU's are dynamically allocated at boot time.
> If this value does not match an existing PERF_TYPE_X value,
> output_type(perf_event_attr.type) will return OUTPUT_TYPE_OTHER.
>
> Instead search for a core PMU with a matching perf_event_attr type
> and, if one is found, return PERF_TYPE_RAW to match output of other
> core PMU's.
> "
>
> Suggested-by: Kan Liang <kan.liang@intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
> v2: restrict pmu lookup to platforms with more than one core pmu
> v3: only scan core pmu list
> v4: rebase on top of Arnaldo's patch
> v5: update based on Namhyung's feedback here
> https://lore.kernel.org/lkml/Z8YcOidenzGofq7R@google.com/
> ---
>  tools/perf/builtin-script.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index d797cec4f054..4d2764df48a0 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -385,6 +385,19 @@ static int evsel_script__fprintf(struct evsel_script=
 *es, FILE *fp)
>                        st.st_size / 1024.0 / 1024.0, es->filename, es->sa=
mples);
>  }
>
> +static bool is_core_pmu_type(unsigned int type)
> +{
> +       struct perf_pmu *pmu =3D NULL;
> +
> +       if (perf_pmus__num_core_pmus() > 1) {

On ARM it isn't a given that if there is 1 core PMU the type will be
PERF_TYPE_RAW, on x86 this is normally the case.

> +               while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> +                       if (pmu->type =3D=3D type)
> +                               return true;
> +               }
> +       }
> +       return type =3D=3D PERF_TYPE_RAW;
> +}
> +
>  static inline int output_type(unsigned int type)
>  {
>         switch (type) {
> @@ -395,6 +408,9 @@ static inline int output_type(unsigned int type)
>                         return type;
>         }
>
> +       if (is_core_pmu_type(type))

Given this is called by evsel__output_type I think you can do:
```
static inline int output_type(unsigned int type)
{
       switch (type) {
       case PERF_TYPE_SYNTH:
               return OUTPUT_TYPE_SYNTH;
       default:
               if (type < PERF_TYPE_MAX)
                       return type;
       }

       return OUTPUT_TYPE_OTHER;
}

static inline int evsel__output_type(struct evsel *evsel)
{
       int output_type =3D evsel->script_output_type;

       if (output_type =3D=3D OUTPUT_TYPE_UNSET) {
               output_type =3D output_type(evsel->core.attr.type);
               if (output_type =3D=3D OUTPUT_TYPE_OTHER) {
                      struct perf_pmu *pmu =3D evsel__find_pmu(evsel);

                      if (pmu && pmu->is_core)
                             output_type =3D PERF_TYPE_RAW;
               }
               evsel->script_output_type =3D output_type;

       return output_type;
}
```
The evsel__find_pmu will cache the PMU for future callers.

Thanks,
Ian

> +               return PERF_TYPE_RAW;
> +
>         return OUTPUT_TYPE_OTHER;
>  }
>
> --
> 2.48.1
>

