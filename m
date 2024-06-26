Return-Path: <linux-kernel+bounces-230064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACC89177FC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C7A1C21E50
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5A013E3EA;
	Wed, 26 Jun 2024 05:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ap7vHCEl"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF8E22089
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379220; cv=none; b=t3aDpfYKajcZarHNON/DAAJfpy9eJ/Qki1uArKoLzu+lfNfjFm4gWbgeCfZ/FfV+NDaTS1WP+c7u3fFXI1fqYQUevLKP6LtEnLE24Luj3X2+RiRyRmNTYqZvHLkIHyGMwaUZuaxPqZqhw7DT4zd7vqFE9vGmbTQjlXXICd679rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379220; c=relaxed/simple;
	bh=Z6o4P9L38u7aEQSvsLtVIDFfv4hfoZRSG5GKQTvwXxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLBCCiHTVHAoFfP1FEKuIjtdQ4n9aCKC70k0J7dSvB0iMnxFfDiSIxdKtQpMhg424NizNTHEKGoovVWV68JCXorHJ+bdg4i6OoXxtIsybrtJ3unTi6Tp+xSZukYwKIjGbvh7Y+NKtfAlOO9AOhuubwhvuKC7jjqdJxvWuU5TPgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ap7vHCEl; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3762775e9ebso59125ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719379218; x=1719984018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8QaegARV/0Y5L5Bjj9rUOT5RNM5woMGrCyqCQLA/iU=;
        b=Ap7vHCEltOVccJ8/XUHMANYFpc2l7+YF6Opqpd7ZmQwAjOZMh24agS9CvKHX8LD2x8
         PFB/N85Xd+nc6mUNmnu0x2+MPHSh5BJvlivmjnQvjmnqfKynqDiDdUl40/85TJiCZD9w
         Rn8dqy82K9jHqF4OYP4wQDKguvpY80uHuFvyShGQp4PVBxD9rx4lOoJylJVSG3iwF47J
         BKrACEADwwXSX1B3vczLOAcNQofF1Rb2RiB8Xt9ij9eaNIPyWdtLa+nvGJHrdC93xMWB
         e+yHietzXpgBOjoLCGKC8j8kcYKkEQWGJC2CdLNUj9OTdP1dX+C5iAFGVJ5CcyIfRwqB
         HCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719379218; x=1719984018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8QaegARV/0Y5L5Bjj9rUOT5RNM5woMGrCyqCQLA/iU=;
        b=hzkITCPp1+wmJZtF0Tsf4MMkfqtuZLAeGft1yUKN9ULuB7jTpkSjTgQwVryZ6ZD+y9
         MCtii4wz3yflNgcNLadTlHMZCY8jMPP20p+5onG0HBrZWMUil5s5awfi/oljYRKj8YPu
         e/KHcBPHMdO6SdRIFegzDkm2+CJNs8YwvId0hMO64S6qUW8k6A8W1UHjN+IlYKwKs5IY
         8gn8BEqlSmPo4Gun/MWeM5BMEc7xX1nUOnZEVd3Crmd3knpgWTLIOz74PqIMa5ZYwt1u
         8YkbiZDTbXtzlyP3iy/RbZgctyq4YupUXcwRsPafTbQYjAIHY0qe5PCfY4oVotrvRhVO
         1mKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7VnBey/IGi4JknctwwxPOwaa/r7CgpapS0lbeSqrTyKJxV34MeawZG3khfWAK5nay+lsgP5PboFFDIjvAeS6ZQirI7p1WI+Smo2V4
X-Gm-Message-State: AOJu0YxXG4sgClvbMzVru+djsLGxGCmOiLKpyXkkICBTLeCpLjThJeu9
	knr1XT31iOXAlgHQ3D8v0Ld/xdNYac1pd/lkIS6aSUQr40GE/e330g+CkqWUd4ugOMikPzG2xQ9
	qsExYNjLWmnHqLvIQpouoBhgJuAEeMpY++IJF
X-Google-Smtp-Source: AGHT+IGM5+O8KnW1y0wJuNTWetL021Si1kmJ2MHVSmwUzrchz7ZEl9KqfovRKe1HHtoaLAANMyTMFEizPay1Nve3keY=
X-Received: by 2002:a92:dcd2:0:b0:374:7f72:52e1 with SMTP id
 e9e14a558f8ab-377ef3398c8mr1853715ab.18.1719379217924; Tue, 25 Jun 2024
 22:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625182256.291914-1-kan.liang@linux.intel.com>
In-Reply-To: <20240625182256.291914-1-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 25 Jun 2024 22:20:05 -0700
Message-ID: <CAP-5=fXvmDSPVOWhcNzSZ7icBh6PhdgpbopFCZgzZWYk_kGadA@mail.gmail.com>
Subject: Re: [PATCH V2 00/13] Support Lunar Lake and Arrow Lake core PMU
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@kernel.org, acme@kernel.org, 
	namhyung@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, 
	ak@linux.intel.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 11:22=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Changes since V1:
> - Add x86/intel_pmu_max_num_pebs/counters/counters_fixed()
> - Rename model-specific pebs_latency_data functions
> - Rename V6 counter MSRs
>
> From the core PMU' perspective, the Lunar Lake and Arrow Lake are the
> same, which are similar to the previous generation Meteor Lake. Both are
> hybrid platforms, with e-core and p-core.
>
> The key differences include:
> - The e-core supports 3 new fixed counters
> - The p-core supports an updated PEBS Data Source format
> - More GP counters (Updated event constraint table)
> - New Architectural performance monitoring V6
>   (New Perfmon MSRs aliasing, umask2, eq).
> - New PEBS format V6 (Counters Snapshotting group)
> - New RDPMC metrics clear mode
>
> The details for the above new features can be found in the Intel
> Architecture Instruction Set Extensions and Future Features (052).
> https://cdrdv2.intel.com/v1/dl/getContent/671368
>
> The counters may not be continuous anymore. Patch 1-2 converts the max
> number of counters to a mask of counters. The change is a generic change
> which impacts all X86 platforms.
>
> Patch 3-4 supports all the legacy features on LNL and ARL.
>
> Patch 5-7 supports the new Architectural performance monitoring V6.
>
> Patch 8-11 supports the new PEBS format V6.
>
> Patch 12 supports the new RDPMC metrics clear mode.
>
> Kan Liang (13):
>   perf/x86/intel: Support the PEBS event mask
>   perf/x86: Support counter mask
>   perf/x86: Add Lunar Lake and Arrow Lake support
>   perf/x86/intel: Rename model-specific pebs_latency_data functions
>   perf/x86/intel: Support new data source for Lunar Lake
>   perf/x86: Add config_mask to represent EVENTSEL bitmask
>   perf/x86/intel: Support PERFEVTSEL extension
>   perf/x86/intel: Support Perfmon MSRs aliasing
>   perf/x86: Extend event update interface
>   perf: Extend perf_output_read
>   perf/x86/intel: Move PEBS event update after the sample output
>   perf/x86/intel: Support PEBS counters snapshotting
>   perf/x86/intel: Support RDPMC metrics clear mode

Fwiw and beside the nit:

Reviewed-by: Ian Rogers <irogers@google.com>

It seems some of the behaviors could have tests upon them, would it be
possible to add them skipping the test on older and non-Intel
architectures?

Thanks,
Ian

>  arch/x86/events/amd/core.c           |  26 +-
>  arch/x86/events/core.c               | 123 +++----
>  arch/x86/events/intel/core.c         | 471 ++++++++++++++++++++-------
>  arch/x86/events/intel/ds.c           | 288 +++++++++++++---
>  arch/x86/events/intel/knc.c          |   2 +-
>  arch/x86/events/intel/p4.c           |  12 +-
>  arch/x86/events/intel/p6.c           |   2 +-
>  arch/x86/events/perf_event.h         | 105 +++++-
>  arch/x86/events/perf_event_flags.h   |   2 +-
>  arch/x86/events/zhaoxin/core.c       |  14 +-
>  arch/x86/include/asm/intel_ds.h      |   1 +
>  arch/x86/include/asm/msr-index.h     |   6 +
>  arch/x86/include/asm/perf_event.h    |  27 ++
>  include/uapi/linux/perf_event.h      |   6 +-
>  kernel/events/core.c                 |  15 +-
>  tools/perf/Documentation/topdown.txt |   9 +-
>  16 files changed, 839 insertions(+), 270 deletions(-)
>
> --
> 2.35.1
>

