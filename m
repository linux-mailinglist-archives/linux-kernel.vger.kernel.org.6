Return-Path: <linux-kernel+bounces-428466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 944E69E0EE2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46386283172
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879B91DF964;
	Mon,  2 Dec 2024 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IF5JxS+u"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAC21DED73
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 22:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733178297; cv=none; b=Q+kmo80dzEVT4bAtHjRK2MgW1wB5+ZnboDa3mOdfINl0DujrYxoSMfpjaORn4uxZxbp7hP89kA3ng2UsTxOQCPXsrY1pL7MvgMYS0vnHj+NJ5W8mAin7+qGYVToyMUrMwoEq0sRREeFUzUOfM3HKC0h4iP3JcC6XKVFbaO9UJ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733178297; c=relaxed/simple;
	bh=3SCjs69uV3EDmq6n+IU/rsyU2Ua5ivJVRg07utNZIDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8HXUkYO3yzeh8027mo6PcJRnuVZA4pn33zzGz1EOOda18kwhBtex+GUTBHhvnox6FzgBFB+Skx9fnmWFK/Vq9Q/Ln1EkzGBo1Zg/ioE5kc8AIUHWkBrqBWqXaBBy9YRUlJ3kiOUkdY26NP+GO0S+qQRQW2JCmZjnRt2/gRmFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IF5JxS+u; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71d4e043dd9so2111225a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 14:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733178295; x=1733783095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJCGC/sgJEzOQ87RHSL5ZFr+7rlghNfPZJAqWvkg6xg=;
        b=IF5JxS+uEAs28ydKKCm8+W4du0TZaIcY9/vt5/G37evlbgllg6zI2KAL51ia4ZtLUY
         Skpri9+WG646p250Ckt/R0yR9c+GjUHVMBGRM5HBDQv+a04/l7lMkYzT1ub573E8A7jD
         Amkqj20SrbuB5ZU7DF2sReXdL+CnnYzH4oKyf9uQmeiQrt3RRzfD4d6UfXJ5376ZJOBJ
         497rXO6sUuDpBYoEEh6OLhLM1kkaDCHru7UOwutmyhwep/dE76+hu1jEy7pliL4Fh0VD
         t+e8j7jCO9Jlm13/c7IP+K6AdJHI8I80L3sxIBb3uxSGnVyNL/JbozUR3q5do4Y47kDB
         /nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733178295; x=1733783095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJCGC/sgJEzOQ87RHSL5ZFr+7rlghNfPZJAqWvkg6xg=;
        b=j/vYy8Cr928I++iktuAZNrjL+zk6kzqWW/KIAzl5GrFgUGbRcK6zihcCe2EA+2cYvI
         ZTY68VuhSGEIaWAieiXPXWJ8/XgBI7otldjFn4TLXahsWIfR5CWUZXvYzx8MJRf5CWLb
         rts5By5S+44/37omZxhjVC2ms8M1fKKR1y+IsAirnWmdjDceTQIkWMgHbcC2phkEBRyz
         /sgbzpq5VBGM5yhNZG9uxzeWt9FVBKKpHp3KFZ90hMDfbyPSv+c74JqiqJJ1oN5J///L
         2BTTDXsYyFIMELppHfIS+waZWEJGRbHy4jNtCyqa+4wM9+io/+FpgY1fGF36MSUc5i74
         CUXg==
X-Forwarded-Encrypted: i=1; AJvYcCUXXRKhhkGQy1vsxAFOD2Hz3UzxlS+2mwz38cUxqf+CsmW+cOTPs6BFzBylArLB3IUFxTjPMZswT2GQPWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLefHUSS1cArY/61akEGWi6u4BgysQgXghPZJ0m7woGCL5WeVB
	grbt9IaaGlTPG8nG7BFtXwNliS5I7HXbwXIoEtDk0W10nya/X4Ofnc7U23FebLFvtQ3+dzOonj2
	aJFCrMFFBBeiY5ejEOZR4mI0rNIuZprsApzLh
X-Gm-Gg: ASbGncutysPZIAbr8kUbKzEACwBHnMz9CunyKsqf42boikmt3NPUqQm+FfdsNJC70DO
	6Zy6gAizRnUdysIadomxhu0WemluZQL9Fwt7Q835x1riEu/awmZAZy1ZNgdt5ME4=
X-Google-Smtp-Source: AGHT+IGeeo+ghKLojpnbWTzZom5/ogyh7WRdIQxYXPU0UtlV2C/NyHWZ8m/Ani2xjLVRzoyaFLhWiHGqggOcj7aCcyE=
X-Received: by 2002:a05:6358:280d:b0:1c3:7415:693d with SMTP id
 e5c5f4694b2df-1caeaa8ba16mr49600855d.5.1733178295304; Mon, 02 Dec 2024
 14:24:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411291513.ad55672a-lkp@intel.com>
In-Reply-To: <202411291513.ad55672a-lkp@intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 2 Dec 2024 15:24:18 -0700
Message-ID: <CAOUHufYFT3jeY-1ruDwocuGQmW4-Gn69=-DhEHfQuEpv9t4KtA@mail.gmail.com>
Subject: Re: [linus:master] [madvise] 2f406263e3: stress-ng.mremap.ops_per_sec
 6.7% regression
To: oliver.sang@intel.com
Cc: Yin Fengwei <fengwei.yin@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Matthew Wilcox <willy@infradead.org>, 
	Minchan Kim <minchan@kernel.org>, Vishal Moola <vishal.moola@gmail.com>, 
	Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oliver,

On Fri, Nov 29, 2024 at 12:50=E2=80=AFAM kernel test robot
<oliver.sang@intel.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a 6.7% regression of stress-ng.mremap.ops_per_s=
ec on:
>
>
> commit: 2f406263e3e954aa24c1248edcfa9be0c1bb30fa ("madvise:madvise_cold_o=
r_pageout_pte_range(): don't use mapcount() against large folio for sharing=
 check")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [still regression on fix commit cc864ebba5f612ce2960e7e09322a193e8fda0d7]
>
> testcase: stress-ng
> config: x86_64-rhel-8.3
> compiler: gcc-12
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10G=
Hz (Ice Lake) with 256G memory
> parameters:
>
>         nr_threads: 100%
>         testtime: 60s
>         test: mremap
>         cpufreq_governor: performance
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202411291513.ad55672a-lkp@intel.=
com
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20241129/202411291513.ad55672a-lk=
p@intel.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testc=
ase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/l=
kp-icl-2sp7/mremap/stress-ng/60s
>
> commit:
>   6867c7a332 ("mm: multi-gen LRU: don't spin during memcg release")
>   2f406263e3 ("madvise:madvise_cold_or_pageout_pte_range(): don't use map=
count() against large folio for sharing check")

The .config you attached shows CONFIG_LRU_GEN_ENABLED is NOT set for
LKP. So this regression can't be from the first commit above.

Also, I asked you a few times if it's possible to set it to 'y'. It'd
be great if we could do that :)

