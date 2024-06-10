Return-Path: <linux-kernel+bounces-208656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1D59027CA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7B8282586
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003DC1474DA;
	Mon, 10 Jun 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yGaVnFKy"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0F184E04
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040813; cv=none; b=gt3P8sbztEHktlww5az6giSOH6RY5xUMskNzLgFbvauZfut5Wtipcvb7ZsJrpzHus5n/DIdUc6xG1tq1TaXUrZhaSMORvp/MfNlvNw9ZivnJDUpuW+HAz6Ojdyk6XVNjj9tdgsU72lSz/ZTUNxldoZF2zbOY1EGBj91LO4lvqw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040813; c=relaxed/simple;
	bh=bdOYNNG233qRhz3XI+MlkfvaCLqk3IYfd5AUcptTRTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZV0exYR+xJ+44hMq0Bh0LCe27PeBSuU4KseRo4jfME77qsX0ifWYNkoUFPCrUf+ioj4R2Xndz3EDDPu9Dsmy15YaYShUZ3+14uhX52V8lvZEsuN+MAF6bhfzJhZi6AL6kSC4CmogeH8haUsi0db/cQHjErk07GDZHrfB8/YIeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yGaVnFKy; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-375acf90c58so10205ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718040810; x=1718645610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdOYNNG233qRhz3XI+MlkfvaCLqk3IYfd5AUcptTRTM=;
        b=yGaVnFKyg9Rb3zjy0fAVI3x3N5HLyp6OASgZ7cUwUpLkbDNUz8OekH1qdUnh2C+WZg
         KLmVN05dSsp6ufDulXhbGh7+fhfMxFOuCN0vPHZXwdvU32MLqLUkZzaQIOnygQ06FUat
         vrhK37pMCb5BAN7G790lwJXNspVSzRyNyMfzWLI7F4d+EJRIvxUYkqJCWYg/f0DQl5/J
         SzCnACmXpk5+lhv6qdsSyazulC+fQgRyhcUhM4Ab5beORt/Qm2Ar11i9mPY49cYv82WF
         gtsFALksAAjsEzB4Si6bvRPY8N2OnC0UVOZsCrnl3+FHT+7tJ5GREW79MdYGdxuhZz5c
         cdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718040810; x=1718645610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdOYNNG233qRhz3XI+MlkfvaCLqk3IYfd5AUcptTRTM=;
        b=sCe7CrzkR3s61DF9xSi1HBNEG8pq91mnXfoOmQlc4OaE4XWrort0aXIsVYyFnrJY4Q
         v26exIQd0ndKGNz8n8G4uGjcNb3xRAsgztim1ZaS32Zvnq3ZZ5r/Ixjk9P9x4zEtGvTG
         +9u91aPBDWjGt53N345TCxvONjMCGJhC9+59wM/+z2HWzU1x6riFBvcmWCgaQ3GX2ePK
         kbzTK9egOR1jppXW2tYM2N9FfdFsIrF9OBgDHuXIsZ0+iAY1Y7GNcbzwQ+klYOVc+T8q
         kvuJ2PiRhhLreLPT2XIguFQkzqnVUyJCKiEzU66YNDTR0ErbUn2yBHcaJhn893fROk23
         GiNA==
X-Forwarded-Encrypted: i=1; AJvYcCUbgvrM7z20XjjZn54IiKsx9RyFB783adFWJWyZSU3FL7u2/uMLLD7hpG7a67cXJUxRoCmFaRHyqdA3C24Obu2ICM/MEMTzJPB0SxXa
X-Gm-Message-State: AOJu0YwAYj5Tf3EeZTQUzjv5/54HLaGz6M+85Cxz7SMqkRayZpZvt/Uw
	fgdkANEpRY6WbdT+1E0FSFhhbNw866RXb8GoQnvXoWe1liWWgnwsR+2nVlSdkOOUiE8EJW7Pa9Z
	Fg7CWeC3MpxffYqrZu/43UzrOKoeqNJaD4B8Y
X-Google-Smtp-Source: AGHT+IF4RQZ/xzq/w+dPDVh0tFYJbnw/GaaZTMKotm7PBgdv0bYpxjayBecUgCGMMMYygei/AwTVauljApyCg9dziQQ=
X-Received: by 2002:a05:6e02:3701:b0:374:8a2a:6557 with SMTP id
 e9e14a558f8ab-37594fc8d02mr5745345ab.25.1718040810130; Mon, 10 Jun 2024
 10:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607065343.695369-1-irogers@google.com> <23ee1734-7e65-4f11-aede-fea44ada3cc4@arm.com>
In-Reply-To: <23ee1734-7e65-4f11-aede-fea44ada3cc4@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Jun 2024 10:33:18 -0700
Message-ID: <CAP-5=fUP69NJ+j6+9rUnp+UPBxcopJ=BOY-LeOjs8vYdt4soMA@mail.gmail.com>
Subject: Re: [PATCH v1] perf arm: Workaround ARM PMUs cpu maps having offline cpus
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yicong Yang <yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 6:30=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
[snip]
> I did a test for this patch, it works well for me.
>
> Tested-by: Leo Yan <leo.yan@arm.com>
>
> Just a nitpick and I think it is not an issue caused by this patch.
> After hotplug off one CPU and then if specify the CPU with option '-C',
> the 'perf stat' command still continues to run. This is inconsistent
> with the 'perf record' which exits with failures immediately.
>
> Maybe consider to send an extra patch to address this issue?

As you say, this doesn't relate to the problem fixed here. I don't
have a problem with the command line behavior change but I think my
getting shouted at budget is fairly well exhausted. How about we trade
issues, if the following get fixed:

Renaming of the cycles event in arm_dsu_pmu.c - I'd say this is a top
priority issue right now.
Fixing ARM hybrid default perf stat (it is crazy we can accept this
being broken), opening events on both BIG.little PMUs as done here:
https://lore.kernel.org/lkml/20240510053705.2462258-4-irogers@google.com/

I'll address this.

Thanks,
Ian

