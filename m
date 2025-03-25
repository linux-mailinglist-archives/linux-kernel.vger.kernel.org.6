Return-Path: <linux-kernel+bounces-576217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FA7A70C76
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F018189261A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E3D269B0D;
	Tue, 25 Mar 2025 21:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KMVhwoAR"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C382326980F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742939772; cv=none; b=iU2Xw85cFyIYkThaUBVNvoFuGTr9w13/MJvP2jIc6GnE6xOPTolNd8goraNBBtVVPvjjZEDRcazCZElPY5AfngtgPMOrldZhcwATnqI4RtZlnD32B4h7+dVkaDoZgCZV/JAwGHS9pjG0dqorG8Ql5shviVknLJlLL33On1JcTwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742939772; c=relaxed/simple;
	bh=ZG4/CH4zje5enYEsmtKpWou0CNGqTmtcqj84ZYFPhSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olmxrH0D9xigpB4sESQqihbnL89uD9q6rzTioUzIOjkIipgyLYzufVGAZYsnoNqpBXGmBC3Wvsv/5VDwBO9ozBBXyEgAnjH4F3iHhTwWDiiair0daU4urPPN8Xx9zZZvNVICkgWPsCmBBzpkwwk839VLKxIDnPDGCqhbFpjQhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KMVhwoAR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2242ac37caeso28655ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742939770; x=1743544570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GawijQeSK3EpSZkeGcHDhjBfafNJ3MVAaKRkLHgLy3g=;
        b=KMVhwoARxrKS+7xabgM7M7jy4iseY0ZE/Z4cW8QM/53IWnzb18fBRO0HqiM2tT7hCd
         aJWFBt8Wk7YO8ThMCiYcVtrPuQ/MDLcKcBAeOH//f6NRzpmeQvnTLD52mOakC/QUpGvi
         9D6sz8+kOkP8vr1D3tUtAAbFq87jE1VPTXzn74Vz0PzqbEpv7MtJBgaUXys9H6v0e1N8
         VFS8OR/eC9lbrRj0+NYe/hnxvyIULW5nAtMuXtUXZqJbfHSLxHSNeEtWdVXvo3EWWpP1
         pX3fpsiUbaOVOKxjTwjDFTmSArDQAnRrFLcGNh35HkijTU3pvZ7YPc28r/DdOl6lvse3
         SGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742939770; x=1743544570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GawijQeSK3EpSZkeGcHDhjBfafNJ3MVAaKRkLHgLy3g=;
        b=Wd6rUBUXqlTknAouPHMzoW1NPVKvRWjSNk0NZABhrBd3eqoZxZFMBsIBEHK0vDEqYb
         kUf9HEzjLmM3kf+T19G93ZHCFNtfRQSufvuHZeSwjo1V5Z8JSA7hEuZWLnsBDaAbSfuw
         ok2aS8SWgAA4J1/aiPx2hYe/3n0HdS6ZgPLI5m068x6CJDGWcwsSghQ2X85uufDGoEF5
         cNK6uduqhxuffVk/2B4Vvg3SjO7z1GlAm30cbOchJ7SaH5nO8THq/yMezrZCiYgED4VO
         anfiKSss81lJQSZ4u5OvqPph4V2VHwJCH3S3AoE82WDOmw2k3hp96SdS3JTkqD+Ba6Iw
         auhg==
X-Forwarded-Encrypted: i=1; AJvYcCWfgZuawkAXPspwsSjkbQZOZZLFpYChaEFu7JpxRvb6J38FsF7m+SZ+c5ybKiO1/F2BGYhkQ3cbR5GH42M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwauokEC2egloLDeMylV9HDenLh/36YqQ8IqpUZPWBOxa4nGZys
	y2YgLjiJEM3rmGxQdxmZnpAQ0dGF8mjssWM8dAVTYICx+0LmT6QJdAkKeHmKea5D21DtlQ+9JQV
	byf4v4Nqx2ZE31Je1SXipoQsOHk/PeRnsPkAS
X-Gm-Gg: ASbGncsTMY+YBftO93/YJxfI+Rmm8sagPox3YKVMfxP4/a+lD0ZUw5zWop/Ooio8FVZ
	Tnod9cYudN2pOPYph+zF7SPkEFI9dlye6U0jksKsKKEx843w48hBIDeVNyJEAnOJ5gge2w9be+i
	LnhSa90UqDD/O4EOseftOQzR7slmw6znG2DZFh8CAKbZXGAcI0cKY68C7qm/xkdTcl
X-Google-Smtp-Source: AGHT+IGp8JXeHefat2sYKtXMfrAIHQLr7hYftj+JashDB/csUXNinqTUEneXZfdmYVqR0BdM1+g7I+KawBYu30LRXEo=
X-Received: by 2002:a17:902:f64c:b0:215:7ced:9d67 with SMTP id
 d9443c01a7336-227f36a5585mr171955ad.24.1742939769655; Tue, 25 Mar 2025
 14:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324220301.1273038-1-kinseyho@google.com> <fc15a9e2-b771-4357-b724-2c3ce95d86a1@amd.com>
In-Reply-To: <fc15a9e2-b771-4357-b724-2c3ce95d86a1@amd.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Tue, 25 Mar 2025 14:55:52 -0700
X-Gm-Features: AQ5f1JqSK_zS-V30gVeRAqs4kb5kgLUolENQOggIiCEscFmsmuMw79jGcxPABzA
Message-ID: <CAJj2-QFCGZ7==azp+Vh7x7jJDtTUMMWTC5XyYTqVHWeVxETjTg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] mm: multi-gen LRU scanning for page promotion
To: Bharata B Rao <bharata@amd.com>
Cc: Kinsey Ho <kinseyho@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com, 
	Jonathan.Cameron@huawei.com, Michael.Day@amd.com, akpm@linux-foundation.org, 
	dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com, 
	gourry@gourry.net, hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com, 
	jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com, 
	kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com, 
	liam.howlett@oracle.com, mgorman@techsingularity.net, mingo@redhat.com, 
	nadav.amit@gmail.com, nphamcs@gmail.com, peterz@infradead.org, 
	raghavendra.kt@amd.com, riel@surriel.com, rientjes@google.com, 
	rppt@kernel.org, shivankg@amd.com, shy828301@gmail.com, sj@kernel.org, 
	vbabka@suse.cz, weixugc@google.com, willy@infradead.org, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 4:56=E2=80=AFAM Bharata B Rao <bharata@amd.com> wro=
te:
>
> Thanks for your patchset. I haven't looked at the patches in detail yet,
> but gave it a quick try with the micro-benchmark that I have been using.
Thanks for running the numbers. Unfortunately neither of us can attend
LSF/MM in person, but we're excited about this opportunity for
collaboration.

>
> The below numbers can be compared with the base numbers that I have
> posted here
> (https://lore.kernel.org/linux-mm/20250325081832.209140-1-bharata@amd.com=
/).
> Test 2 in the above link is the one I tried with this patchset.
>
> kernel.numa_balancing =3D 0
> demotion=3Dtrue
> cpufreq governor=3Dperformance
>
> Benchmark run configuration:
> Compute-node            =3D 1
> Memory-node             =3D 2
> Memory-size             =3D 206158430208
> Hot-region-size         =3D 1073741824
> Nr-hot-regions          =3D 192
> Access pattern          =3D random
> Access granularity      =3D 4096
> Delay b/n accesses      =3D 0
> Load/store ratio        =3D 50l50s
> THP used                =3D no
> Nr accesses             =3D 25769803776
> Nr repetitions          =3D 512
>
> Benchmark completed in 605983205.0 us
The benchmark does seem to complete in less time, but I'm not sure why
especially given the small number of pages promoted. I think it would
also be useful to see the usage breakdown of DRAM/CXL over time.

>
> numa_hit 63621437
> numa_miss 2721737
> numa_foreign 2721737
> numa_interleave 0
> numa_local 48243292
> numa_other 18099882
> pgpromote_success 0
> pgpromote_candidate 0
> pgdemote_kswapd 15409682
> pgdemote_direct 0
> pgdemote_khugepaged 0
> numa_pte_updates 0
> numa_huge_pte_updates 0
> numa_hint_faults 0
> numa_hint_faults_local 0
> numa_pages_migrated 19596
> pgmigrate_success 15429278
> pgmigrate_fail 256
>
> kpromoted_recorded_accesses 27647687
> kpromoted_recorded_hwhints 0
> kpromoted_recorded_pgtscans 27647687
> kpromoted_record_toptier 0
Makes sense, we skip toptier scanning

> kpromoted_record_added 17184209
> kpromoted_record_exists 10463478
> kpromoted_mig_right_node 0
> kpromoted_mig_non_lru 404308
> kpromoted_mig_cold_old 6417567
> kpromoted_mig_cold_not_accessed 10342825
> kpromoted_mig_promoted 19509
Compared to 611077 (IBS number) this is a lot lower.

> kpromoted_mig_dropped 17164700
>
> When I try to get the same benchmark numbers for kpromoted driven by
> kmmscand, kpromoted gets overwhelmed with the amount of data that
> kmmdscand provides while no such issues with the amount of accesses
> reported by this patchset.
The scan interval in this series is 4 seconds, while the kmmscand's
pause between scanning is 16ms. So there're definitely some gaps here.
The MGLRU page table walk also has a bunch of optimizations, and some
of them are more focused on reclaim, so we might need to tweak some
things there too.


Yuanchu

