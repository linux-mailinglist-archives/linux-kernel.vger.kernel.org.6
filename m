Return-Path: <linux-kernel+bounces-271500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9467C944F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B731C20D8B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528C81AED23;
	Thu,  1 Aug 2024 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XHWc7h73"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C41A99C4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525805; cv=none; b=liMcySVF8DSi8xrGBvbt+JOhVVeR2aa46KGRTyCvr5gjNby0jsHhgvZr+nECTnQDrbxVazfvp7BQSmFHYZc8pKw2TQLnOlgYhBRscoechkSN/RuUkmdfXgc04BJDXAsxPyaxYyu0cSF4fBU2BeBUKebq7kZ3AbOpvtZhQr6s+7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525805; c=relaxed/simple;
	bh=GFGK0UHdzjbGe6UmTb4ohG2TZHo7UbKi49qo76wYcUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsjTtu2NHMsD9lv5WOy9Dhcd9gKRr5UWd7x1R1zRfKJIEukwFL59ZcA7trjpciUIGfpVfWPkqe2a6qfWhlZL378DqGn3p16AVkWSAT+G2Vuxm/LVgQl/X98z4GMPO6g6jkzHJ6OtIktQpxZBYEfgdazeCSmMK1wf5Hi7y0+8kz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XHWc7h73; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44fe76fa0b8so720221cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722525803; x=1723130603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSUo638LAO2tBPwPh6ylMLQD6YOik4Knc6isLVc9yiU=;
        b=XHWc7h73HsX9+PItxhJ9NXhyOF051wkf4/MQ2IdoZri77SXxxv4JWFMrhREn3TdqzH
         nyYZgRM22cVGgdOh5R6j8t2ywFvZhwOvQXyLfndO7vUW6qY0C7ht8QPgpfKmBSah3CEx
         NImXuzFaRByLLNoKIieDPnzgwwEdp2GGKXzmyudXh5OfvhCvP9QAMBn7ncRsOye8UzcU
         J6Z+TBePYKDuEWHBrtFGgUTMbDmiXF8nNrdWfIiMSaGg9446Ryfx7uj0FQ5a9A5rZtsa
         cOcSO4LhpkIUAd8FRSNQvPG7sf7UKCAGOyuaTtfcpiqZLs3weJ88Qfl6woWWnq0242sU
         0waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525803; x=1723130603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSUo638LAO2tBPwPh6ylMLQD6YOik4Knc6isLVc9yiU=;
        b=LoXpKmMef19QqTK4ZuYaaHNTD4WkeaI9AchrghlFXzxKvSrVXGcbT95QK5iN6GdtJw
         X2Z/Yw7vQHEvt0NV2oGKInbnQ4jy2hMlOxHM6qSb1NTeUnln5JZ0a9ZDUful1eezminj
         jEugI4wfenQQ2Jbu26ijcvh3W44SiX/2UfxPiukyC8m8tcVE77D/QvJgG3SOKF1Gx7Wo
         TT3vVhWhIRguVojM3l7lEuA+t+2U0t7R+e0Ytd+xHRjSBmSesGDwIuDej8TzGFiDQlsJ
         6myQPXDPTQQJdDoXLmmKyzOr2XannHA3pB86HmKdKCZ/2Tj8uUUUnHyvntWg81jsjXYc
         UO9g==
X-Forwarded-Encrypted: i=1; AJvYcCVdGCj2ur48Aarkc3Ltb0m4id7nEawRoRUgl6nS0Cc6O3S3qbyzTU7PKus5MCxhqS0iSzKqSSrBNCKPW6dF8zN19/q0muonabCOA0AZ
X-Gm-Message-State: AOJu0Yxd+w2FLra2LpI+wCYOorUWsb7O16wEiiKbKd4NGzTXuvLP5Mmt
	9Ywg/18nt+DbpWMeY82ypjHB3Z4qGKjb779sK5wroDLctjQSDQqUvu96ObtzvG31psqhK2BWuAo
	8E5fT3mD5yQZdq+Up8mnfA5N9TU11s6DWZDee
X-Google-Smtp-Source: AGHT+IHZefKrdZylJzqxV6El4ioyRwIYAtkW247cXmfNBWs/GaSwE5K93Yduh6KNbV4UzIhNQK/yFQLnLwFlzCnN3Hw=
X-Received: by 2002:ac8:7d8c:0:b0:447:d7ff:961d with SMTP id
 d75a77b69052e-45181e6e4f1mr2037141cf.9.1722525802741; Thu, 01 Aug 2024
 08:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731235505.710436-1-namhyung@kernel.org>
In-Reply-To: <20240731235505.710436-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Aug 2024 08:23:11 -0700
Message-ID: <CAP-5=fX8Fg4jJDN=d2pHU1Xy3-A119c5gZYXtQu0b0Rwb0-ymQ@mail.gmail.com>
Subject: Re: [PATCHSET 0/6] perf mem: Basic support for data type profiling (v1)
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 4:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> As we added data type profiling, 'perf mem report' should support that
> as well.  This patches just added a couple of convenient options.
>
>   $ perf mem report -T -s mem
>   # To display the perf.data header info, please use --header/--header-on=
ly options.
>   #
>   #
>   # Total Lost Samples: 0
>   #
>   # Samples: 131  of event 'cpu/mem-loads,ldlat=3D30/P'
>   # Total weight : 18561
>   # Sort order   : mem,type
>   #
>   # Overhead       Samples  Memory access                            Data=
 Type
>   # ........  ............  .......................................  ....=
.....
>   #
>       14.84%            22  L1 hit                                   (unk=
nown)
>       12.02%             8  RAM hit                                  (unk=
nown)
>        7.68%             8  LFB/MAB hit                              (unk=
nown)
>        6.29%            12  L1 hit                                   (sta=
ck operation)
>        3.97%             5  LFB/MAB hit                              stru=
ct psi_group_cpu
>        3.69%             3  L1 hit                                   stru=
ct
>        3.18%             3  LFB/MAB hit                              (sta=
ck operation)
>        2.89%             5  L3 hit                                   (unk=
nown)
>        2.58%             3  L1 hit                                   unsi=
gned int
>        2.31%             2  L1 hit                                   stru=
ct psi_group_cpu
>        2.21%             2  LFB/MAB hit                              stru=
ct cfs_rq
>        2.19%             2  RAM hit                                  stru=
ct sched_entity
>        2.16%             1  L1 hit                                   stru=
ct task_struct
>        1.85%             3  L1 hit                                   stru=
ct pcpu_hot
>        1.78%             1  RAM hit                                  stru=
ct tss_struct
>        1.72%             1  LFB/MAB hit                              stru=
ct mm_struct
>        1.62%             2  L1 hit                                   stru=
ct psi_group
>        ...
>
>
> The code is also available at 'perf/mem-type-v1' branch in
> git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (6):
>   perf hist: Correct hist_entry->mem_info refcounts
>   perf mem: Free the allocated sort string
>   perf mem: Rework command option handling
>   perf tools: Add mode argument to sort_help()
>   perf mem: Add -s/--sort option
>   perf mem: Add -T/--data-type option to report subcommand
>
>  tools/perf/builtin-mem.c     | 100 ++++++++++++++++++++++-------------
>  tools/perf/builtin-report.c  |   4 +-
>  tools/perf/util/hist.c       |  14 ++---
>  tools/perf/util/map_symbol.c |  18 +++++++
>  tools/perf/util/map_symbol.h |   3 ++
>  tools/perf/util/mem-info.c   |  13 +++++
>  tools/perf/util/mem-info.h   |   1 +
>  tools/perf/util/sort.c       |  12 +++--
>  tools/perf/util/sort.h       |   2 +-
>  9 files changed, 116 insertions(+), 51 deletions(-)

Lgtm, man page updates?

Thanks,
Ian

