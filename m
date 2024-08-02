Return-Path: <linux-kernel+bounces-273027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA3A946380
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7D9281854
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8279B4501F;
	Fri,  2 Aug 2024 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A6d998yR"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B2A1ABEC1
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722625241; cv=none; b=qKOzblZMYta4Bq8h/el7DsHXEF4cskLb0hAfPiCx6ZwVfZiH/j41LQeNSNNUlz0jTsfwscF9gBJNcNqojVVi9+g0sCTPJSKvMZ0xbjQiiirsMvXx0M/I/HhiUB14XnTxyaWCSx67g0heQvDgMrvXoUvwVeo/82l4cFUfuGH9ack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722625241; c=relaxed/simple;
	bh=UvtafIr6sTNTXplrQjYCntX7FdSnb1Tr48PQZWBMJ7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZfj/HapdeEnJU9kE9MgisSFKIBGBmyOn3uKLjnP6+OqqF8NMeaXpDw5DsnxqdcqmAoZGF0dVXPgRrhM/DBvESedVmKlQAknKXYYn5cpzJNgO9fpq2K5JeM1wVWqiOKXUy2DOzmwx0l8l2J84qnCq+NUVPlcHuFvIyJVI/lBTB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A6d998yR; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39a16fab332so468585ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722625239; x=1723230039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQMF8JzoGV0u6x7WIUKkjG9+7GVwEzTDPtC2fYe3ZzM=;
        b=A6d998yRfKHjNo4US82jayHowkLJL/cvR8TfLbRmNwU8DTZXh+1okwtbob5Lga1J1v
         a6mz2sN0hAz77tdyIWe30uWSUPywfyluFvRbk9sO/wIc7CqK00C5+roqnUM7Ke+Ahv+h
         ywlpt66Idw4f2B6/+UajuxCSAd8KPo27DWY202+MzlUaOhyNhtcyYs9eGHirOMWfFJuj
         xnside7B8m5S57s2HeKgwnBRlScnpz6XsZsFAeAJ/zb9lvR4vxqurpUFP25HofJsWlSs
         tgGtKJJynar9/2g8gHaLV5oYRfLTZ3p8ZYjWpVjqXkDWNTQUly0gvhuDOC/ysmEs2cfy
         XCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722625239; x=1723230039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQMF8JzoGV0u6x7WIUKkjG9+7GVwEzTDPtC2fYe3ZzM=;
        b=GZKUwdtzoTCpCI3ugN8d97xqJ0GwnMyzusziJYjpepEd4CAQpOD9FS+JQoQHrWNVZ1
         XBHteh5DAhMKNoe4MTtvOSunX/ga5+qS6E3AFhnnGiMU3KzIXvVU1t1wi97ulP9PrS0u
         QyC0WRRCJnQKvlKCFHhqxFkC90/bg9U/0YVEuSVPV6OLutbbPCwXIR+DvK/9VMyBdB2v
         EOl9oom4Zz0SQyb1gVSiG6ZLzzskQq5vQM2LCjko3O86ccGpIW1k069Y0L3j391rdDj5
         Jn1PQ9Ir2A9mH2qaK+fvPHkHx4XvHDQUIOjt0L6dfrZQR2nRNqYcV9Aetwqhy4lbac59
         Y0dg==
X-Forwarded-Encrypted: i=1; AJvYcCXV11ZVC+bEUlQerWtPXyVmo8H300QwQLDDTgDuvQZ1dgWj+c/JdDBQyU873bLEbFuJ+iu+L0/+ljjO5txynbbQgDZs9DVb797ApzT4
X-Gm-Message-State: AOJu0Yzbo9iofonpcr1fou/nM6//wXxczSk4kdcdlIVJUc5pMgUkA7Bg
	WjjJkWM4p31Zg6NsCqpbQTz9NtIEzRQBnkpQUm70+mwc+8wfV2vJWNLyfrC45MbAgRtPVycxllR
	khOLQB1aD989QALqC7zlKFLhM1W3TTMqX8+4r
X-Google-Smtp-Source: AGHT+IF1aCbJjjZLlxlo8sraTmpBrRvh3vvGD8ORLYMADZKRO0s2CNrPb88fQI8tUgkhz7zrS0AZ86He1q6xHnZUvcQ=
X-Received: by 2002:a05:6e02:1fed:b0:374:a294:58bf with SMTP id
 e9e14a558f8ab-39b2ad13bb3mr326455ab.10.1722625239089; Fri, 02 Aug 2024
 12:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802180913.1023886-1-namhyung@kernel.org>
In-Reply-To: <20240802180913.1023886-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 2 Aug 2024 12:00:27 -0700
Message-ID: <CAP-5=fU2HNnJKzRQUaM51ht7evxO30gSR0H5sQ9mSOE+xqkLjA@mail.gmail.com>
Subject: Re: [PATCH] perf mem: Update documentation for new options
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 11:09=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Add a common options section and move some items to the section.  Also
> add description of new options to report options.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-mem.txt | 94 ++++++++++++++++++---------
>  1 file changed, 63 insertions(+), 31 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documenta=
tion/perf-mem.txt
> index 47456b212e99..8a1bd9ff0f86 100644
> --- a/tools/perf/Documentation/perf-mem.txt
> +++ b/tools/perf/Documentation/perf-mem.txt
> @@ -28,15 +28,8 @@ and kernel support is required. See linkperf:perf-arm-=
spe[1] for a setup guide.
>  Due to the statistical nature of SPE sampling, not every memory operatio=
n will
>  be sampled.
>
> -OPTIONS
> --------
> -<command>...::
> -       Any command you can specify in a shell.
> -
> --i::
> ---input=3D<file>::
> -       Input file name.
> -
> +COMMON OPTIONS
> +--------------
>  -f::
>  --force::
>         Don't do ownership validation
> @@ -45,24 +38,9 @@ OPTIONS
>  --type=3D<type>::
>         Select the memory operation type: load or store (default: load,st=
ore)
>
> --D::
> ---dump-raw-samples::
> -       Dump the raw decoded samples on the screen in a format that is ea=
sy to parse with
> -       one sample per line.
> -
> --x::
> ---field-separator=3D<separator>::
> -       Specify the field separator used when dump raw samples (-D option=
). By default,
> -       The separator is the space character.
> -
> --C::
> ---cpu=3D<cpu>::
> -       Monitor only on the list of CPUs provided. Multiple CPUs can be p=
rovided as a
> -        comma-separated list with no space: 0,1. Ranges of CPUs are spec=
ified with -: 0-2. Default
> -        is to monitor all CPUS.
> --U::
> ---hide-unresolved::
> -       Only display entries resolved to a symbol.
> +-v::
> +--verbose::
> +       Be more verbose (show counter open errors, etc)
>
>  -p::
>  --phys-data::
> @@ -73,6 +51,9 @@ OPTIONS
>
>  RECORD OPTIONS
>  --------------
> +<command>...::
> +       Any command you can specify in a shell.
> +
>  -e::
>  --event <event>::
>         Event selector. Use 'perf mem record -e list' to list available e=
vents.
> @@ -85,14 +66,65 @@ RECORD OPTIONS
>  --all-user::
>         Configure all used events to run in user space.
>
> --v::
> ---verbose::
> -       Be more verbose (show counter open errors, etc)
> -
>  --ldlat <n>::
>         Specify desired latency for loads event. Supported on Intel and A=
rm64
>         processors only. Ignored on other archs.
>
> +REPORT OPTIONS
> +--------------
> +-i::
> +--input=3D<file>::
> +       Input file name.
> +
> +-C::
> +--cpu=3D<cpu>::
> +       Monitor only on the list of CPUs provided. Multiple CPUs can be p=
rovided as a
> +        comma-separated list with no space: 0,1. Ranges of CPUs are spec=
ified with -
> +       like 0-2. Default is to monitor all CPUS.
> +
> +-D::
> +--dump-raw-samples::
> +       Dump the raw decoded samples on the screen in a format that is ea=
sy to parse with
> +       one sample per line.
> +
> +-s::
> +--sort=3D<key>::
> +       Group result by given key(s) - multiple keys can be specified
> +       in CSV format.  The keys are specific to memory samples are:
> +       symbol_daddr, symbol_iaddr, dso_daddr, locked, tlb, mem, snoop,
> +       dcacheline, phys_daddr, data_page_size, blocked.
> +
> +       - symbol_daddr: name of data symbol being executed on at the time=
 of sample
> +       - symbol_iaddr: name of code symbol being executed on at the time=
 of sample
> +       - dso_daddr: name of library or module containing the data being =
executed
> +                    on at the time of the sample
> +       - locked: whether the bus was locked at the time of the sample
> +       - tlb: type of tlb access for the data at the time of the sample
> +       - mem: type of memory access for the data at the time of the samp=
le
> +       - snoop: type of snoop (if any) for the data at the time of the s=
ample
> +       - dcacheline: the cacheline the data address is on at the time of=
 the sample
> +       - phys_daddr: physical address of data being executed on at the t=
ime of sample
> +       - data_page_size: the data page size of data being executed on at=
 the time of sample
> +       - blocked: reason of blocked load access for the data at the time=
 of the sample
> +
> +       And the default sort keys are changed to local_weight, mem, sym, =
dso,
> +       symbol_daddr, dso_daddr, snoop, tlb, locked, blocked, local_ins_l=
at.
> +
> +-T::
> +--type-profile::
> +       Show data-type profile result instead of code symbols.  This requ=
ires
> +       the debug information and it will change the default sort keys to=
:
> +       mem, snoop, tlb, type.
> +
> +-U::
> +--hide-unresolved::
> +       Only display entries resolved to a symbol.
> +
> +-x::
> +--field-separator=3D<separator>::
> +       Specify the field separator used when dump raw samples (-D option=
). By default,
> +       The separator is the space character.
> +
>  In addition, for report all perf report options are valid, and for recor=
d
>  all perf record options.
>
> --
> 2.46.0.rc2.264.g509ed76dc8-goog
>

