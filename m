Return-Path: <linux-kernel+bounces-510139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CAAA318AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3774A3A4B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5783E268FEA;
	Tue, 11 Feb 2025 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GApyKiki"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D0E2641CE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313300; cv=none; b=G/x2S9+plFNLV6/KErxf4hKzY9IYDFt9244cFRpqRSjaBXVdNxCaJUDnUTzosqOkp14l//P9FTLfbmjnOU5ef2i5WJ3AOF6SN93dbGEOVFHgVh+3ILNsLctY0qarOnYbFKLEGVJ9sIUpnhBSGV4gKX9GL/JqJOrV/SWOVXdBMJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313300; c=relaxed/simple;
	bh=kbDjq5tUv4vG4501STjqXx+cmqZ1GC1gcH0Z0vZHRAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSjx/66WvaVGAqSUk6tDrAsIDoyGf1sVgLca2iZRAw0CExRzwB5YKStJIaHfPibTR6oRjc6156hnEOb45tYcyLGloR/orXJ3QUPyn1tpqSd7IMU+IV2ZUSI5VbZkJPX7/mkkOikccW2DtDxNPtTXwts7T9epcDNq6K3Icbbmvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GApyKiki; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d147331fb5so47655ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 14:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739313297; x=1739918097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LJOvaQN1uD4Gb9j8aBY0XDTg/U6cKrEXmin878seh4=;
        b=GApyKikijjJoXav8Uh8B9FHo4lL9o5n0Y2TNpoU1pgCMXWPtPGgZgxQC1rPnVl/Dut
         VCyXoqWp9PNEeCCszr+3OlUbWc6lUIZsPw+gdtVjpwFq0zL3bpwinJLe9V+p/B+sQQaz
         Y4y7G7MCS/yYEsgju7A1Lphr9oKgv6MwxjbMrQ7Y2quk9jkwH3UWACpdzHNdU9QIIiU5
         ONI45vVMvmUAom+aoLRL+vr5CGo33/xCg4+ii6xVj6IYoocbhjXjadLgOxgUIe9G/ddt
         CKkJNrCouFb1KjEuFuqR68lSamkFUmcTFBtjNWLEbTl0wb8jYPVxK0yrfUOMM93mmahS
         prVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739313297; x=1739918097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LJOvaQN1uD4Gb9j8aBY0XDTg/U6cKrEXmin878seh4=;
        b=E9RGyUs9ae2n7WMOiqay+m6hP8Y/n8TehCmhFa59fofUpxJXYP6Yh6rTNCvMhhEsl6
         fPnpDXu5b0aYL2DimSLijxktMerydJ/536sAAZuwx8hY4UzHti4j7RcWlEL9hGJzaqGX
         ETfXN6kW4cldCQ5cXw2FJ/jS1oP22r8HCW/NkNIaP1tceMcosYDbwZSqW3/+KmShF//T
         seG3kGsi9wL02rt9HUbUK6qblL4emPeqNr6pdOgHHTdOQF69chOncVMxrSNSStWy/Dut
         scaIGhE1SdaRLH+52Po/duXh6BSv02PmmWRLlRzXbcItSw26ZxjrldeLyzj3FCY4Vnuw
         S0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUtJgcXWtQ94ceoJJ0Xci4nn8ZvW/VxbpX4X/BDxk/INjTZXdLv+OlnT5YLOtWfmPVEUtyArVmVjdzjzIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1oE1LPggYs15wKFcmouOhyle2KOiXZGq+1hzePCcbVAp+0Ctt
	aeutHrfIH7AdP+cEQC+4P4/Dqtb9vAlNz+RlM4IXXM0spfkdtafsE1euQhUFEF/JIjnbfASxyTj
	QLfAHYFZPpGMQpjJnWuEyuJlOoWWX3rRQzvZo
X-Gm-Gg: ASbGncs3qOiJK6n7A3gi1agjqnmEgZfcPp7gCa4RV/QTMm1S75munjw1NVOyEk/C0WC
	P2U+SUDvSqAqK9xDmYr7DNkbuc/bRlZ6tKQvsdZL2Ui9KO3m14w3CYFNVuH7xJAmouGY/5QPdJT
	ZN/32d5zaNC7UJjb9Lq0Dk73LA
X-Google-Smtp-Source: AGHT+IFpq/X6sl+JYhqIrdvJS3oHdPv0NT2XLFxyoKOkSWcjaLA3F0FA/5h+ObyGxJaY07ihxeweG2UjHT8idfOSfTE=
X-Received: by 2002:a05:6e02:1c03:b0:3cf:a4e4:8f89 with SMTP id
 e9e14a558f8ab-3d17cd5f2a3mr1050775ab.4.1739313297203; Tue, 11 Feb 2025
 14:34:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205121555.180606-1-leo.yan@arm.com>
In-Reply-To: <20250205121555.180606-1-leo.yan@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Feb 2025 14:34:46 -0800
X-Gm-Features: AWEUYZlxuKPWdrL07IcP7PrJXbaGbljBlIOoo18dt_4E8e3ScRzR3nTGDqPPcv8
Message-ID: <CAP-5=fUH6X2F5S5eH+iU+-hT0vNvMKPTqbGt=E9W06sG=MzxEg@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] perf script: Refactor branch flags for Arm SPE
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Graham Woodward <graham.woodward@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 4:16=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> This patch series refactors branch flags for support Arm SPE.  The patch
> set is divided into two parts, the first part is for refactoring common
> code and the second part is for enabling Arm SPE.
>
> For refactoring branch flags, the sample flaghs are classified as branch
> types and events.  A program branch type can be conditional branch,
> function call, return or expection taken.  A branch event happens when
> taking a branch.  This series combines branch types and the associated
> events to present a sample flag.
>
> The second part is to enable Arm SPE's sample flags for expressing
> branch types and events, and support branch stack.
>
> Patches 01 - 03 are to refactor branch types and branch events.
> Patches 04, 05 extend to support not-taken event.
>
> Patches 06 - 09 enables branch flags in Arm SPE.  This allows to print
> out sample flags for samples.
>
> Patch 10 supports branch stack for Arm SPE.  Patch 11 is an enhancement
> for PBT feature.
>
> Before:
>   perf record -e arm_spe_0/load_filter=3D1,store_filter=3D1,branch_filter=
=3D1/ \
>     -- ~/perf-c2c-usage-files/false_sharing.exe 1
>   perf script --itrace=3Di1ibl -F,+flags,+addr,+brstack
>    false_sharing.e  414489 [005] 775348.899294:          1               =
                                   branch:   jmp                   ffffc0fa=
d9ef3d68 ffffc0fad98b2c68 search_cmp_ftr_reg+0x8 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899294:          1               =
                             instructions:   jmp                   ffffc0fa=
d9ef3d68 ffffc0fad98b2c68 search_cmp_ftr_reg+0x8 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899294:          1               =
                                   branch:   jmp                   ffffc0fa=
d98b3708 ffffc0fad98b3704 get_arm64_ftr_reg+0x30 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899294:          1               =
                             instructions:   jmp                   ffffc0fa=
d98b3708 ffffc0fad98b3704 get_arm64_ftr_reg+0x30 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899297:          1               =
                                   branch:   br miss                   ffff=
8266da60     ffff8266dafc __sprintf_chk@plt+0xc (/usr/lib/aarch64-linux-gnu=
/libnuma.so.1.0.0)
>    false_sharing.e  414489 [005] 775348.899297:          1               =
                             instructions:   br miss                   ffff=
8266da60     ffff8266dafc __sprintf_chk@plt+0xc (/usr/lib/aarch64-linux-gnu=
/libnuma.so.1.0.0)
>    false_sharing.e  414489 [005] 775348.899297:          1               =
                                   branch:   br miss                   ffff=
826a44ec     ffff826a44e8 strcmp+0xa8 (/usr/lib/aarch64-linux-gnu/ld-2.31.s=
o)
>    false_sharing.e  414489 [005] 775348.899297:          1               =
                             instructions:   br miss                   ffff=
826a44ec     ffff826a44e8 strcmp+0xa8 (/usr/lib/aarch64-linux-gnu/ld-2.31.s=
o)
>    false_sharing.e  414489 [005] 775348.899298:          1               =
                             instructions:                                 =
       0 ffffc0fadaad6124 mas_walk+0x274 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899300:          1               =
                             instructions:                                 =
       0 ffffc0fad9b3d98c next_uptodate_folio+0x2a4 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899301:          1               =
                             instructions:                                 =
       0 ffffc0fad98c3dcc __sync_icache_dcache+0x5c ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899301:          1               =
                                   branch:   jmp                   ffffc0fa=
d9ba7f24 ffffc0fad9ba99c0 folio_add_file_rmap_ptes+0x48 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899301:          1               =
                             instructions:   jmp                   ffffc0fa=
d9ba7f24 ffffc0fad9ba99c0 folio_add_file_rmap_ptes+0x48 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899306:          1               =
                             instructions:                                 =
       0 ffffc0fad9b3f184 filemap_map_pages+0x178 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899307:          1               =
                                   branch:   jmp                   ffffc0fa=
d9b3d7b0 ffffc0fad9b3d7ac next_uptodate_folio+0xc4 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899307:          1               =
                             instructions:   jmp                   ffffc0fa=
d9b3d7b0 ffffc0fad9b3d7ac next_uptodate_folio+0xc4 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899307:          1               =
                             instructions:                                 =
       0 ffffc0fad9b3d98c next_uptodate_folio+0x2a4 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899308:          1               =
                                   branch:   jmp                   ffffc0fa=
d9ef3da4 ffffc0fad9ef3d70 bsearch+0x58 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899308:          1               =
                             instructions:   jmp                   ffffc0fa=
d9ef3da4 ffffc0fad9ef3d70 bsearch+0x58 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899310:          1               =
                                   branch:   jmp                   ffffc0fa=
d98a2158 ffffc0fad98a159c el0t_64_sync+0x198 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899310:          1               =
                             instructions:   jmp                   ffffc0fa=
d98a2158 ffffc0fad98a159c el0t_64_sync+0x198 ([kernel.kallsyms])
>    ...
>
> After:
>   perf script --itrace=3Di1ibl -F,+flags,+addr,+brstack
>    false_sharing.e  414489 [005] 775348.899294:          1               =
                                   branch:   return                ffffc0fa=
d9ef3d68 ffffc0fad98b2c68 search_cmp_ftr_reg+0x8 ([kernel.kallsyms]) 0xffff=
c0fad98b2c68 ([kernel.kallsyms])/0xffffc0fad9ef3d68 ([kernel.kallsyms])/P/-=
/-/5/RET/-
>    false_sharing.e  414489 [005] 775348.899294:          1               =
                             instructions:   return                ffffc0fa=
d9ef3d68 ffffc0fad98b2c68 search_cmp_ftr_reg+0x8 ([kernel.kallsyms]) 0xffff=
c0fad98b2c68 ([kernel.kallsyms])/0xffffc0fad9ef3d68 ([kernel.kallsyms])/P/-=
/-/5/RET/-
>    false_sharing.e  414489 [005] 775348.899294:          1               =
                                   branch:   jcc/not_taken/        ffffc0fa=
d98b3708 ffffc0fad98b3704 get_arm64_ftr_reg+0x30 ([kernel.kallsyms]) 0xffff=
c0fad98b3704 ([kernel.kallsyms])/0xffffc0fad98b3708 ([kernel.kallsyms])/PN/=
-/-/6/COND/-
>    false_sharing.e  414489 [005] 775348.899294:          1               =
                             instructions:   jcc/not_taken/        ffffc0fa=
d98b3708 ffffc0fad98b3704 get_arm64_ftr_reg+0x30 ([kernel.kallsyms]) 0xffff=
c0fad98b3704 ([kernel.kallsyms])/0xffffc0fad98b3708 ([kernel.kallsyms])/PN/=
-/-/6/COND/-
>    false_sharing.e  414489 [005] 775348.899297:          1               =
                                   branch:   return/miss/              ffff=
8266da60     ffff8266dafc __sprintf_chk@plt+0xc (/usr/lib/aarch64-linux-gnu=
/libnuma.so.1.0.0) 0xffff8266dafc (/usr/lib/aarch64-linux-gnu/libnuma.so.1.=
0.0)/0xffff8266da60 (/usr/lib/aarch64-linux-gnu/libnuma.so.1.0.0)/M/-/-/12/=
RET/-
>    false_sharing.e  414489 [005] 775348.899297:          1               =
                             instructions:   return/miss/              ffff=
8266da60     ffff8266dafc __sprintf_chk@plt+0xc (/usr/lib/aarch64-linux-gnu=
/libnuma.so.1.0.0) 0xffff8266dafc (/usr/lib/aarch64-linux-gnu/libnuma.so.1.=
0.0)/0xffff8266da60 (/usr/lib/aarch64-linux-gnu/libnuma.so.1.0.0)/M/-/-/12/=
RET/-
>    false_sharing.e  414489 [005] 775348.899297:          1               =
                                   branch:   jcc/miss,not_taken/       ffff=
826a44ec     ffff826a44e8 strcmp+0xa8 (/usr/lib/aarch64-linux-gnu/ld-2.31.s=
o) 0xffff826a44e8 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)/0xffff826a44ec (/=
usr/lib/aarch64-linux-gnu/ld-2.31.so)/MN/-/-/23/COND/-
>    false_sharing.e  414489 [005] 775348.899297:          1               =
                             instructions:   jcc/miss,not_taken/       ffff=
826a44ec     ffff826a44e8 strcmp+0xa8 (/usr/lib/aarch64-linux-gnu/ld-2.31.s=
o) 0xffff826a44e8 (/usr/lib/aarch64-linux-gnu/ld-2.31.so)/0xffff826a44ec (/=
usr/lib/aarch64-linux-gnu/ld-2.31.so)/MN/-/-/23/COND/-
>    false_sharing.e  414489 [005] 775348.899298:          1               =
                             instructions:                                 =
       0 ffffc0fadaad6124 mas_walk+0x274 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899300:          1               =
                             instructions:                                 =
       0 ffffc0fad9b3d98c next_uptodate_folio+0x2a4 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899301:          1               =
                             instructions:                                 =
       0 ffffc0fad98c3dcc __sync_icache_dcache+0x5c ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899301:          1               =
                                   branch:   jmp                   ffffc0fa=
d9ba7f24 ffffc0fad9ba99c0 folio_add_file_rmap_ptes+0x48 ([kernel.kallsyms])=
 0xffffc0fad9ba99c0 ([kernel.kallsyms])/0xffffc0fad9ba7f24 ([kernel.kallsym=
s])/P/-/-/8//-
>    false_sharing.e  414489 [005] 775348.899301:          1               =
                             instructions:   jmp                   ffffc0fa=
d9ba7f24 ffffc0fad9ba99c0 folio_add_file_rmap_ptes+0x48 ([kernel.kallsyms])=
 0xffffc0fad9ba99c0 ([kernel.kallsyms])/0xffffc0fad9ba7f24 ([kernel.kallsym=
s])/P/-/-/8//-
>    false_sharing.e  414489 [005] 775348.899306:          1               =
                             instructions:                                 =
       0 ffffc0fad9b3f184 filemap_map_pages+0x178 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899307:          1               =
                                   branch:   jcc/not_taken/        ffffc0fa=
d9b3d7b0 ffffc0fad9b3d7ac next_uptodate_folio+0xc4 ([kernel.kallsyms]) 0xff=
ffc0fad9b3d7ac ([kernel.kallsyms])/0xffffc0fad9b3d7b0 ([kernel.kallsyms])/P=
N/-/-/15/COND/-
>    false_sharing.e  414489 [005] 775348.899307:          1               =
                             instructions:   jcc/not_taken/        ffffc0fa=
d9b3d7b0 ffffc0fad9b3d7ac next_uptodate_folio+0xc4 ([kernel.kallsyms]) 0xff=
ffc0fad9b3d7ac ([kernel.kallsyms])/0xffffc0fad9b3d7b0 ([kernel.kallsyms])/P=
N/-/-/15/COND/-
>    false_sharing.e  414489 [005] 775348.899307:          1               =
                             instructions:                                 =
       0 ffffc0fad9b3d98c next_uptodate_folio+0x2a4 ([kernel.kallsyms])
>    false_sharing.e  414489 [005] 775348.899308:          1               =
                                   branch:   jcc                   ffffc0fa=
d9ef3da4 ffffc0fad9ef3d70 bsearch+0x58 ([kernel.kallsyms]) 0xffffc0fad9ef3d=
70 ([kernel.kallsyms])/0xffffc0fad9ef3da4 ([kernel.kallsyms])/P/-/-/20/COND=
/-
>    false_sharing.e  414489 [005] 775348.899308:          1               =
                             instructions:   jcc                   ffffc0fa=
d9ef3da4 ffffc0fad9ef3d70 bsearch+0x58 ([kernel.kallsyms]) 0xffffc0fad9ef3d=
70 ([kernel.kallsyms])/0xffffc0fad9ef3da4 ([kernel.kallsyms])/P/-/-/20/COND=
/-
>    false_sharing.e  414489 [005] 775348.899310:          1               =
                                   branch:   jmp                   ffffc0fa=
d98a2158 ffffc0fad98a159c el0t_64_sync+0x198 ([kernel.kallsyms]) 0xffffc0fa=
d98a159c ([kernel.kallsyms])/0xffffc0fad98a2158 ([kernel.kallsyms])/P/-/-/5=
//-
>    false_sharing.e  414489 [005] 775348.899310:          1               =
                             instructions:   jmp                   ffffc0fa=
d98a2158 ffffc0fad98a159c el0t_64_sync+0x198 ([kernel.kallsyms]) 0xffffc0fa=
d98a159c ([kernel.kallsyms])/0xffffc0fad98a2158 ([kernel.kallsyms])/P/-/-/5=
//-
>    ...

Reviewed-by: Ian Rogers <irogers@google.com>

Built and tested (on x86). A little strange patch 5 adds a new bit not
at the end, but "Sample parsing" test wasn't broken so looks like it
is good. I was surprised the use of value in the union:
```
struct branch_flags {
union {
u64 value;
struct {
u64 mispred:1;
u64 predicted:1;
...
```
didn't get broken. Perhaps there's an opportunity for additional tests.

Thanks,
Ian


> Leo Yan (11):
>   perf script: Make printing flags reliable
>   perf script: Refactor sample_flags_to_name() function
>   perf script: Separate events from branch types
>   perf script: Add not taken event for branches
>   perf script: Add not taken event for branch stack
>   perf arm-spe: Extend branch operations
>   perf arm-spe: Decode transactional event
>   perf arm-spe: Fill branch operations and events to record
>   perf arm-spe: Set sample flags with supplement info
>   perf arm-spe: Add branch stack
>   perf arm-spe: Support previous branch target (PBT) address
>
>  tools/perf/builtin-script.c                   |  30 ++--
>  .../util/arm-spe-decoder/arm-spe-decoder.c    |  23 ++-
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  11 +-
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     |  14 +-
>  .../arm-spe-decoder/arm-spe-pkt-decoder.h     |  12 +-
>  tools/perf/util/arm-spe.c                     | 135 ++++++++++++++++++
>  tools/perf/util/branch.h                      |   3 +-
>  tools/perf/util/event.h                       |  12 +-
>  tools/perf/util/trace-event-scripting.c       | 116 +++++++++++----
>  tools/perf/util/trace-event.h                 |   2 +
>  10 files changed, 307 insertions(+), 51 deletions(-)
>
> --
> 2.34.1
>

