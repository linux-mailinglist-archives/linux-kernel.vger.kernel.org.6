Return-Path: <linux-kernel+bounces-547724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3797EA50CA5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 761897A5D71
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E90254B09;
	Wed,  5 Mar 2025 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mjpfc/aJ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902F16426
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207113; cv=none; b=EVgR+2QcRTSf/76vOEgmcc2czwHFyXCFg8IZ9imLH33XE3m7NNihNO/Zh6TneG7z0TV8a4YshtlePv9fSvHnknApi5gg6gFP49cfBAweJVwLhG0cGTBGT0wDwNl7DkKcoumE1EwBHNjjsZUgdvw8fiBjFYVM65jqgSdcZ4bwTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207113; c=relaxed/simple;
	bh=SUGSmluDdEhvhDO1IWjZf9rQXdDfzfv7NvLqMpD4VfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrS3IKj57ykgcH/zXrIXxdjKoa6JXBeJq5odm4rkAP86FQokm/borhS616gH0pgeLqfjvQsj9VSKcQFZuEz86n7geu4ptgDaiEzef1nseqXOVZx2/6pjN9BwnVOROHgZ4pSgTEXofdQT9yYUzkm/NM5Ev/CTC2aJkQGPLw1xxls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mjpfc/aJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223a0da61easo38755ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 12:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741207111; x=1741811911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3maxp7Kr1otabQo3BilxS/8EZ1nqIhNkL7YpFDQpbM=;
        b=mjpfc/aJ1hr6iLbn8wemM63AyXABSRtCH1kk7ZSgpBdYBRec9zyloLI3D0ybAkd/7g
         6DeqzWZ0T/DuqKhiIcuZ9Y3gvGolo4l0XBgVMSWDjre2O0Ov8i16T7NycUrhfirj2NmR
         tu1MyLxNFuQ6oGk80euflK0sQDv9zSdSLje3BeC1RcA1/mWEnJ7k9mabxEDLg7IRg+jL
         AlZSXUQcjBTxjjcZu9xCipAUPWqNWdeOlD+b0hu6QZX4hyru+bZoE1xjZDmBY6U8sR8Y
         6SATf4OefJaVgG4SyrMUk3iLAwe/VXP7+Bo8D0d1XQVIQMrIvf+kPU9AkpL1wSUzLdw2
         Gdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741207111; x=1741811911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3maxp7Kr1otabQo3BilxS/8EZ1nqIhNkL7YpFDQpbM=;
        b=B40uQkbhuR+GxXdDb+nF6MjeHMVFGnd2/1yMBD160CUNiuyP5VcTLwwROFMFaBlJni
         lxtXgp5GeVi4d+o8tjdE46juOpyhoCMXlUXELXd/KplyMVaQDGL42eXRrk8A5gN81CUD
         VfvBzseacX1RRtPrZofIclxxZ1aoY/bDXf5Z0sE4DNbbZlM/AG8IsW/Ht3ku5UsaXpoA
         mCc2ZSz5plHTqlY/E0Uio5OTDeps1GBUf/6VEba6uPQyGh0OpDJeqbD5q3ih4wTy5Vbe
         NZ9ODOPI1B7XVWXbzQheM3NqbtAXWJmRcWU8DAIyVCror5dyGRh1vaG706QWhB6O+xOj
         ePSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuidYF0VDYP6WU3BWzvAhI0kjEFqeo1fxT9m8ejwy5Ap1g/U2WybOIpuxmDLiTDWMKUH7Jz0Qzly80ITU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoTNjKy2WslEHH2PH64lgqzejc9OPcsr4n79XNInIRf2XKsfMP
	bBOOrd78I4MsoWLlPGOwHrwYKZ/HvK6gzw9O/2jSUr/HtYW1TvQ8I7dSqUt/vBf7pp4L2Mcqd1O
	zHqmmmSEjff+OU4wMaVX84N/2tAF2/T49PtMa
X-Gm-Gg: ASbGnct08Ba2958dS7e4dVkBPQ9zcl9aCzlbVibCqgkWGZYamcOKTHKPKagJlni/qPR
	DmGo0rw5LgUOzxiBBtGiWcm3APZmTbLJYVO83rQb40QJ7NLHDqC77Qj/zn3d4gkbm8fWVCoGn6v
	Fb7A/mLYWiq3y7Nmb50alMi8+o4ESeuGcI2BeYxY5OMpzH05zSom6S0Yg=
X-Google-Smtp-Source: AGHT+IHQSxzR/+4fDtkO8ebHdaVDnEWZRcupfSp3LnXPQT1gJeflfxPziwUtmsB+pW15jdmJayu40WWcp+Q191r86uw=
X-Received: by 2002:a17:903:48e:b0:21f:9f4:4a03 with SMTP id
 d9443c01a7336-2240b615f2bmr360315ad.21.1741207110774; Wed, 05 Mar 2025
 12:38:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
In-Reply-To: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Mar 2025 12:38:19 -0800
X-Gm-Features: AQ5f1JoLT3IuJ3nQ4KIws464rDSz3AuKiuLoSZwb27YQADITZNYEU07uXU5v3T8
Message-ID: <CAP-5=fUtS5-vHj+GWDsyWG-2CUYy6e0qhjuUtD9x7FudPsRpOQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf list: Collapse similar events across PMUs
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:50=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> Some changes related to the discussion here [1] about deduplication of
> PMUs. This change stands on its own right now, but it may not go far
> enough. This can either be dropped for now or applied and improved
> later. Extra ideas are as follows.
>
> Treating alphanumeric suffixes as duplicate has been slightly
> problematic due to marketing strings having looks-like-but-not-actually
> alphanumeric suffixes. For example 'cpum_cf' and now the one digit
> longer than before 'cortex-a720'. The easy fix is to increase the
> minimum length considered for deduplication as suggested [1], but as
> also mentioned, the current mrvl_ddr_pmu PMU names don't zero pad the
> address, meaning that > 2 alphanumeric suffixes are already technically
> not enough to deduplicate the same PMUs. They could have only a 2 digit
> alphanumeric address suffix. Increasing the minimum digits feels a bit
> like kicking the can down the road and it places awkward limitations on
> marketing names which we have no control over. Also I'm not sure helps
> the following much:

The hex suffix thing was very unfortunate, can we reverse that
decision and move the physical address.. it captures into a caps file?

Fwiw, we have a similar hex mess with raw events. A raw event can be
r0xead or read, but read also makes a pretty nice event name. This is
solved by first checking if read is an event and if not assuming it is
a raw encoding. Would anyone really care if raw events always had to
start with r0x? We seem to get tangled up in corner cases like this
too often, for example legacy event priorities and topdown event
sorting. Keeping things simple would be nice from a correctness pov
but also so that it's easy for other tools to emulate.

> The problem is that arm_cmn_[n] PMUs have a numeric suffix, but they can
> have different events. Even if we were adding this PMU today, keeping
> the suffix rule in mind, it would be difficult to come up with a suffix
> that differentiates the different ones. Flavour words might work, but
> that complicates the kernel which would have to group them and come up
> with flavours rather than just doing an i++. Deduplicating too
> aggressively on only PMU name suffix means only arm_cmn_1's events get
> listed, missing other events, and it's hard to see which events relate
> to which PMU.
>
> Therefore in addition to the changes in this patchset I'd like to look
> into:
>
>  * Collapsing duplicate PMU names into ranges, for example
>    arm_pmu_v3_[0-4], rather than simply concatenating names as done in
>    this patchset

The current suffix rule is weird as Intel's GPU i915 PMU appears to be
a PMU called 'i' with a 915 numeric suffix.
I think capturing the rules in the ABI doc and some kind of legacy
compatibility is do-able.
I like regular expressions over globs/fnmatch, for example, we could
use flex to turn the CPUID matches in mapfile.csv into something that
is parsed and matched with less interpretation/compilation at runtime.
I suspect we can bike-shed for a long time on what these new rules
will be, which has been why I've generally just tried to match
existing and inelegant behaviors.

>  * Deduplicate uncore based on the contents of events/ rather than just
>    the suffix
>
> As some background, the original commit for deduplication, commit
> 3241d46f5f54 ("perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu")
> mentions reducing the number of duplicate PMUs, and is presumably
> motivated by usability. But there are also other commits mentioning
> reducing openat()s, for example lazily loading formats 504026412162
> ("perf pmu: Make the loading of formats lazy"). Deduplicating based on
> the contents of the events/ folder is somewhat in contention with this
> reduction, but could be done along side some more lazy loading (like of
> the terms) and hashing the result of readdir() without opening any of
> the contents. JSON tables can have event name hashes calculated at build
> time if we want to consider them for deduplication too.

I worry about the run time cost of this when there are 100s of uncore
PMUs. I wonder if the case of an empty events directory would also be
common.
Wrt the x86 conventions I think Kan is best placed to say what the
preferred convention should be.
The json will routinely say this event is on a PMU name without a
suffix, and the number of PMUs will only be known at runtime. Hashing
without the suffix would be fine but I think the controversy is over
what should be considered a suffix.

Thanks for doing the series, I'll dig into/test each one in turn.
Ian

> Then with the events hash, PMU's can be sorted based on this and the
> 'Unit:' string can be constructed with a set of values that collapses
> adjacent suffixes to display as ranges. I believe that could remove the
> need for any further changes to duplication based on suffix, but still
> avoids over deduplication.
>
> [1]: https://lore.kernel.org/linux-perf-users/CAP-5=3DfW_Sq4iFxoWPWuixz9f=
MLBPyPUO0RG0KPbYa-5T0DZbTA@mail.gmail.com/
>
> ---
> James Clark (3):
>       perf list: Order events by event name before PMU name
>       perf list: Collapse similar events across PMUs
>       perf list: Don't deduplicate core PMUs when listing events
>
>  tools/perf/builtin-list.c      |  2 +
>  tools/perf/util/pmu.c          |  5 ++-
>  tools/perf/util/pmu.h          |  2 +
>  tools/perf/util/pmus.c         | 95 ++++++++++++++++++++++++++++++++++--=
------
>  tools/perf/util/print-events.h |  1 +
>  5 files changed, 86 insertions(+), 19 deletions(-)
> ---
> base-commit: 7788ad59d1d9617792037a83513be5b1dd14150f
> change-id: 20250304-james-perf-hybrid-list-11b888cf435a
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>

