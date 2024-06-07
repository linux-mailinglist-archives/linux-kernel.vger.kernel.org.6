Return-Path: <linux-kernel+bounces-205393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF268FFAF6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C3E3B28534
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D1016D339;
	Fri,  7 Jun 2024 04:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ue60vCKl"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E47B14F128
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734704; cv=none; b=LR4kZ5RvAZA/GUKlPYap0Aj1uNnX3pQGKWeDyi1/nJvc1/X8T1lhad2vOuM+PGn+CwRv4/d0dOElvvn+lM8iWWtM2rtOILMkLvf21IcIOu3lP3YgJAaVrIkiVRAnTfvhTjR0xGW4LGKmhkzFEkDLIlj+PRe65kxj2cbax4Yxi8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734704; c=relaxed/simple;
	bh=m+FO5prOuAQRG/TGAPSbvyZvd0BG/DyRE8f9rNYUEZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3Ncu6IHiEixhFFub/QK+MJ3VLb4bE9sPXcb48ugunPrnq7U17ZahwnsMqFR1Lnu8cni6EU7fhxevy70uearvfQmDcQv5yw81QLeSNKRJu2DJsUMuocE8NGdhauhT/HG9nCfDeLi1Ic4hSdsFfIRRI6IWD9fya2I9GhM9ahKR6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ue60vCKl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ee5f3123d8so60295ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 21:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717734701; x=1718339501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUQKwpPhBYleEuurbsht3zzd+kMQUMmu39PgM4r1UfU=;
        b=Ue60vCKlT8fsHBn+sSbaPvUPdAqJX/CUvqdRxg77iQy6f/bmNqQ7rF7zqplgGfsbGw
         ehMorhMI1q5YRGCJnG7HD/EwTRoqwmi+cv9tL36HB3Y8Say8kPWkVnlwdYj9dGmVbMFh
         p80LaL8zQRIQZd7m94vOC0nuw7uIZ9idZzNxq6G+HrmAA4s5tIiliWO7yOZRiO6ydwTw
         32HfvOWJbIliqjEkd1EmasU2SrUjak3Otg2Ob4PSRClO0w7t2CHw2bWIUJA4ZEkPku8Z
         WM2EsZaiNEZj6jI9RBOxv5aXe5xUt7mqhsCliU4Zf6xoXJ5zNLiJAInXxcEGMJJvRihS
         QlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717734701; x=1718339501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUQKwpPhBYleEuurbsht3zzd+kMQUMmu39PgM4r1UfU=;
        b=aFJJZzdoBiEiMb7m5tGy+TJnx7Z7WNH/1zikJYI07YKI9p3vaPpscJMqssmubrbQVS
         +aLvTcReMv9wDJfHsmWH+IwhbeGzYzsgxdFR5Vou3DAApZ/GqdbV/kScy+gZpYxh+czB
         JR00/454LH/KXPIGZErxWESJwWw7G1inrbnYhr0b+xnY2jlARXsirkGnKVYwjW87eOSb
         ASS860hZ0ie7JoeCTqzV8FlnYozCsRhMvfaswDLd21ioO8TEaJX5vlyx5p0p0bSbYH37
         qCK4L2mIjMSv2XwY5OtNw11yB+OA6QZP8IxVdrODlGdDnEYxCqkUiqnfYw0tqTy4cNKg
         5tZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAkIwefgciTcZFLYII0StIFTBmDk+gCan3eRbb/dW1l9X8uBT/hpeayh265x0ONc+SmGcIQvZb0JWbn5S9tzec7+iwdQ3p/dVTVt4w
X-Gm-Message-State: AOJu0YzkCC5ePAYXZu1pCAjkEqY34yjKvjOAVffHcBHfKmPkBJUrfx35
	+ZPiqyy2TAI3+1BdZ4CvsvaCt4wFRsPwyXY3sI+Lwl/phqt8nqGMOw1AD7tikhlOVJDEjw/T+62
	gDMZa4cJAJMiV5YIt/WrDF/HP4PX5lkVsRsjB
X-Google-Smtp-Source: AGHT+IFzwCEykDbP9Ly/X0rAzdo3MijeJyLnEmlXxvlnXTUjKsWnSOQQMAZ/rXzHLOb7tK4G2rMvLoMlMMrBBc+yXz0=
X-Received: by 2002:a17:902:c402:b0:1e5:62:7a89 with SMTP id
 d9443c01a7336-1f6ba64b814mr6213245ad.18.1717734700474; Thu, 06 Jun 2024
 21:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521165109.708593-1-irogers@google.com> <bc34d0aa-7152-4f0b-a3c4-11b1a63fba9b@arm.com>
In-Reply-To: <bc34d0aa-7152-4f0b-a3c4-11b1a63fba9b@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Jun 2024 21:31:28 -0700
Message-ID: <CAP-5=fXnRWUat1uzQxyJUMp2LF_i3uYuB22HMD7O3b2UpwPRBg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Fix and improve __maps__fixup_overlap_and_insert
To: James Clark <james.clark@arm.com>
Cc: "Steinar H . Gunderson" <sesse@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 3:56=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
>
>
> On 21/05/2024 17:51, Ian Rogers wrote:
> > Fix latent unlikely bugs in __maps__fixup_overlap_and_insert.
> >
> > Improve __maps__fixup_overlap_and_insert's performance 21x in the case
> > of overlapping mmaps. sesse@google.com reported slowness opening
> > perf.data files from chromium where the files contained a large number
> > of overlapping mappings. Improve this case primarily by avoiding
> > unnecessary sorting.
> >
> > Unscientific timing data processing a perf.data file with overlapping
> > mmap events from chromium:
> >
> > Before:
> > real    0m9.856s
> > user    0m9.637s
> > sys     0m0.204s
> >
> > After:
> > real    0m0.675s
> > user    0m0.454s
> > sys     0m0.196s
> >
> > Tested with address/leak sanitizer, invariant checks and validating
> > the before and after output are identical.
> >
> > Ian Rogers (3):
> >   perf maps: Fix use after free in __maps__fixup_overlap_and_insert
> >   perf maps: Reduce sorting for overlapping mappings
> >   perf maps: Add/use a sorted insert for fixup overlap and insert
> >
> >  tools/perf/util/maps.c | 113 +++++++++++++++++++++++++++++++++--------
> >  1 file changed, 92 insertions(+), 21 deletions(-)
> >
>
> Reviewed-by: James Clark <james.clark@arm.com>
>
> I'm wondering if there is any point in the non sorted insert any more?
>
> Maps could be always either sorted by name or sorted by address and
> insert() is always a sorted/fixup-overlaps insert depending on the sort
> style of the list.

One of the motivations for the sorted array, instead of an rbtree, was
to simplify reference count checking. We're in much better shape with
that these days, I think the worst "memory leak" is the dsos holding
onto a dso and its symbols indefinitely, instead of removing older
unused dsos. It'd be hard to go back to an rb tree with reference
counting.

For the rbtree insert it was O(log N), the sorted insert these changes
add is O(N) and the regular insert without sorting is O(1). A common
case from scanning /proc/pid/maps is that when map entries are
inserted they are inserted in order. The O(1) insert checks that and
maintains that the maps are sorted.
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/maps.c?h=3Dperf-tools-next#n469
For the synthesized maps we should be able to insert N map entries in
O(N). The sorted insert would be similar as the memmoves would always
copy 0 elements. So I can see an argument for keeping the array always
sorted. For the perf.data files we commonly process synthesized mmaps
dominate. In the case for this patch, JIT data dominated, with
frequent overlapping mapping changes. I guess the biggest hurdle to
just always keeping things sorted is the mental hurdle of ignoring the
worst insert complexity, which should never apply given how the maps
are commonly built.

Thanks,
Ian

