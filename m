Return-Path: <linux-kernel+bounces-180393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710078C6DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28021C21688
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A6115B551;
	Wed, 15 May 2024 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2GVWIDGy"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41DA15B15B
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715809213; cv=none; b=Ji5peKidrd6fewKoDrKpzve6hx1Lp3lM8DSHZWb9WV4TaUHIG0UVo5rDeMcv35QDYgFVxoXoBTgODvPMG3/7MFiSzmqv0JvHseCJ5IebSbwXX0zKwoa5aCUa8TBJ3alonunyTR5KaUGs/6ONEr9i1ggQdfzdLOzkm5MLzPU/5Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715809213; c=relaxed/simple;
	bh=Z+XgYM30VQnHp7z+uSPBDIaP8spUZThYi3RbwOOKqL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXuMTB2V7lCC6gsG+Iu5XX7b4Gn3QyVUdxmCzmLhHsvVX3cgShy4w26odKGkz+YP3DbShJgYnYfOr8Ac0smhJlLXod7G7upyQROZPHcgH44nhGpzw0gvBOsawiRbvQav7Ne5b6Gzkha2dGQ8YVy4GBm4AjS7dwpsBEr/meW9i1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2GVWIDGy; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36c6056f7bdso107805ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715809210; x=1716414010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6d83dhT+S2lh1yIex2/6qztxlK0GAg9WvVm+H2kk0ds=;
        b=2GVWIDGyQW7rtdLvLBUG/T7AgFUFCST9wQnNV2EsE4GeNiRx6uWSwREJmnhR4w01Va
         w6sTc6/zddzMX1EC4vXQH6apQyLxyfEoBNDAhoF8B+2v5ijUuuHAKgSExVrPY+MES8IO
         SlN7/GflvqhV2z25L4Wx9BlO9gBYYE18jrEqQ4T9wrUwmnq+/fREETJtEAaJcO8EJG4b
         NCB9HvecTXSRVj1MEluTBb/VoJE+YsftHcFKM9Kx6od91TvcWiqe2CJJ00TlYK/Fk7H8
         UILvDe7pOSZx4mZTXVEKKa4NRr7Q3ro0Hx26gulfzECGnft/Dub/Dej0EoSvnoLhXGwX
         u3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715809210; x=1716414010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6d83dhT+S2lh1yIex2/6qztxlK0GAg9WvVm+H2kk0ds=;
        b=RW6eBrFLbNbhDgymEZV59WnUo662jur2v1xDehZIk3RUOSCuBZ96Txbi2RLRwHWJUi
         a9q8t/yqB99ygdLSiryKbocK5LZ5jgb8BLeOuVZX9NqlncBBhIh7Duzm2QWiIFOez1DD
         IMCDfUYuhOwFhNrcSzFsS1qbQt25ymM7AK++85jib20xSY/nkgiyKjGdptR7Sj5LwjgR
         19WZMnMQZ9Swz4E50kECN+1WV7hLaPz1MVCBrx8tDZxby2/nnAk26XkE3HCsv6wkSu2z
         oC8rOG3Wo5UwpGRsjUvfWfwHVtOBxWNFAffI+O5ngRDhqd4Qz6KkmUIVTegRpmQV2nd6
         yIOw==
X-Forwarded-Encrypted: i=1; AJvYcCU1U4uF7k2Qx35yHTM6rcScfp9H6YdyUXUXx4LAfqFwq3epGCwmezzAy2wV/t3pee+hLYJEMv6ig2w/fUpmQ14Kl1p8tFjtzEDKBatw
X-Gm-Message-State: AOJu0YzL3VLv3VeXyfuZazyZrMCxfL7OjMCL9lAhCFDDnGWNGGXh3kIL
	NX7JGD9/MK27J1XJuMUoAti3kD6qCLgZCWQ4V/l5semvkKN59Y5k04LATCKBg6zyU3v6/mDho+C
	zBAKlxAtQEYKnpt+MScVpW8ljUl21C8CpiK45
X-Google-Smtp-Source: AGHT+IEePRaQH68ZHbSj+Ympv+TQCUiCPrMZ8748+iyv/Bh0uQTh1RJELLvOOnVp8tL/LP0Z/Hqgkb85Pgy0Pk2o3v8=
X-Received: by 2002:a05:6e02:681:b0:36a:3d4d:7149 with SMTP id
 e9e14a558f8ab-36ccb88f31fmr12244885ab.8.1715809209884; Wed, 15 May 2024
 14:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515211045.377080-1-leo.yan@arm.com>
In-Reply-To: <20240515211045.377080-1-leo.yan@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 May 2024 14:39:58 -0700
Message-ID: <CAP-5=fVh-i5cCdW9MJ5AeN2k5Os2W6fifSCMi3gi6qMt_cdDPw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] perf maps: Improve the kcore maps merging
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 2:11=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> This patch series follows up on the patch [1] to improve the sorting and
> merging of kcore maps.
>
> Since the kcore maps are not sorted, merging them into the kernel maps
> causes difficulty, e.g. some kcore maps might be ignored. This is why
> the dso__load_kcore() function handles the kernel text section
> particularly for replacement a complete kernel section.
>
> This patch sorts the kcore maps and ensures the subset region is placed
> ahead of the superset region in the list. With this change, merging
> these maps becomes easier - no need the special handling for the kernel
> text section.
>
> This patch series is based on the latest acme's perf-tool-next branch
> and tested on Arm64 Hikey960 board.
>
> [1] https://lore.kernel.org/linux-perf-users/438f8725-ef3f-462f-90e2-840c=
ab478ee5@arm.com/T/#m7c86a69d43103cd0cb446b0993e47c36df0f40f2

Thanks Leo, testing this change on perf-tools-next with an x86 debian
laptop I see:
```
$ perf test 24 -v
24: Object code reading:
--- start ---
test child forked, pid 3407499
Looking at the vmlinux_path (8 entries long)
symsrc__init: build id mismatch for vmlinux.
symsrc__init: cannot get elf header.
overlapping maps in [kernel.kallsyms] (disable tui for more info)
Using /proc/kcore for kernel data
Using /proc/kallsyms for symbols
Parsing event 'cycles'
Using CPUID GenuineIntel-6-8D-1
mmap size 528384B
Reading object code for memory address: 0xfffffffface8d64a
File is: /proc/kcore
On file address is: 0xfffffffface8d64a
dso__data_read_offset failed
---- end(-1) ----
24: Object code reading                                             : FAILE=
D!
```
The test passes without the changes. Let me know if you need me to dig deep=
er.

Thanks,
Ian

> Leo Yan (2):
>   perf maps: Sort kcore maps
>   perf maps: Remove the replacement of kernel map
>
>  tools/perf/util/symbol.c | 117 +++++++++++++++++++--------------------
>  1 file changed, 57 insertions(+), 60 deletions(-)
>
> --
> 2.34.1
>

