Return-Path: <linux-kernel+bounces-168778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 782FD8BBD8F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 20:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D801F21BAB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 18:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA636BFA3;
	Sat,  4 May 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ttzVU84V"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDD069D2B
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714846508; cv=none; b=L1tT3gRIPFiyW7JDDOF9C13KgBaJ1vpYjY/k+b1OyrZ8MKu79TLwI4/4LWz1z8PnvYAxsbKQsz5GjSZQzLmjgIWnqF6bNlj2GRZWeVwQA8kcra+BeZRsjhAF9OhxrxGwqLnPtd9lIa9YP3fWktor3dRzG0e5vF3wyz4IB6o/yvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714846508; c=relaxed/simple;
	bh=l1rRfCu9fWy1AZLn+bm87szwb+ZlyN23APuoSSDYtHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZL9xgnJj3Zvt9zb2b3T+qNpfALa4FomkMStEi/9mS/E2/G8PlHFht/M+4Vi4P1XnxpUwGbOpTQk3ZV+igLqToRZqv4Z+pengppTmgiF5rHWp10+NpUf3MFv63LEDsCSodvrYzlODkB/twEilEE/RNWpJTCkajxnOU74Kyqj89Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ttzVU84V; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-439b1c72676so240021cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714846505; x=1715451305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1rRfCu9fWy1AZLn+bm87szwb+ZlyN23APuoSSDYtHM=;
        b=ttzVU84VvrUNAlQd+UORPrm7yXVau1UfR4FG/05c5A7XZyvoUUB14/dvhMtkqg2p3/
         /NGoXkLfl4w1YGSJJuBF/tcUa78DKvAoIwfeumRk5jYdT8n+T2qUV7uKPpLkVkqihEQG
         caCIe9S/kkkBOslPsidACSxffgwbkigFmmf7bTCBGICJs7Jx3fsMS7t2bxfx4rtC7bfB
         CubTuawdJzd4npWaicjIrnILqVbmA8T5pi26E1N/MVzRfyztfz1ILjnEumKE71rYz+YH
         aDwbU4Z26oeNygXVeVIBlHYfm5DD30YZ9qbID92+X8ZuSilOPc8dCKyAXT4QbvtBmykq
         QP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714846505; x=1715451305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1rRfCu9fWy1AZLn+bm87szwb+ZlyN23APuoSSDYtHM=;
        b=JNDM6Q5F1d5IiF2R5Ow1kd8n8v/aa+POrw8sQzF2hl7hb0KJdWE/uDm5mB1vR94IKl
         iJlF1FD2CdDHoURfGQHaREMnbmakhU+QGLA/aJAHcu2bdWD635YGyzgeMzhFf8WbMCu5
         rJr0RsJbG7TqF6OcRhLWomuTlaOTrYJzRmU8Mi1ld2JqYV66XQVPgDgWZRR0XeXnCWMA
         xniWcxM58UDw21fbsnhPSoB8c/cJfRf1Vcl8qaTfkLcrO/5NBL+U1TEtj5gawkiyMiFA
         XYGlUxbQT+pvfztJoyE4as4AglNGVpP9Zjh+E5LO35qV9qYDiYFiwvj8ADmNEhr1s/UQ
         GTlg==
X-Forwarded-Encrypted: i=1; AJvYcCU3eoZxK03w4hFC1qgTpr0AqIXoCpsALpu2JC7ihYn4IO7RKaQenAOWyXhkOE88/+/lM9L9BNuyr7jHFvBwRqLjLSavR9pvaqD5Oc6i
X-Gm-Message-State: AOJu0Yx38jwx1PFZrUBbgdN2FnDa8V9zqdyLpoSqjck9tm4j0pfH5y+A
	YrSGSUABCo0E/IGlhdumERrqQmHTSI9zEfL6lgngOJw5BL4sttCMH0eL2sByFKKvPhjdqCf7+ey
	+a7sPny8l2QisjAMtVn3UepLys8ttkDvdJOzD
X-Google-Smtp-Source: AGHT+IEsI9UYVEQRNLElq3aTlhUXa6WUUqlFDkh1jI3lwlUuAKTRw8gnvZa4Sp/y1hF1OkgsDx0Xz7PuvsIawX92Q9g=
X-Received: by 2002:a05:622a:130d:b0:43a:c9a0:6dae with SMTP id
 d75a77b69052e-43d087968d9mr1437001cf.13.1714846505411; Sat, 04 May 2024
 11:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429184614.1224041-1-irogers@google.com> <20240429184614.1224041-2-irogers@google.com>
 <ZjVHNB7pTKKWERFn@x1>
In-Reply-To: <ZjVHNB7pTKKWERFn@x1>
From: Ian Rogers <irogers@google.com>
Date: Sat, 4 May 2024 11:14:52 -0700
Message-ID: <CAP-5=fXE6-atL+FdCdD529eqyveWUqgR6QbJgzvGy=5xR_TBRg@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] perf dsos: Switch backing storage to array from rbtree/list
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, nabijaczleweli@nabijaczleweli.xyz, 
	Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Changbin Du <changbin.du@huawei.com>, 
	Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Paran Lee <p4ranlee@gmail.com>, 
	Li Dong <lidong@vivo.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yang Jihong <yangjihong1@huawei.com>, Chengen Du <chengen.du@canonical.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 1:21=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Mon, Apr 29, 2024 at 11:46:08AM -0700, Ian Rogers wrote:
> > DSOs were held on a list for fast iteration and in an rbtree for fast
> > finds. Switch to using a lazily sorted array where iteration is just
> > iterating through the array and binary searches are the same
> > complexity as searching the rbtree. The find may need to sort the
> > array first which does increase the complexity, but add operations
> > have lower complexity and overall the complexity should remain about
> > the same.
>
> With just this first one applied:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git log --oneline -10
> 325557715f1d8593 (HEAD) perf dsos: Switch backing storage to array from r=
btree/list
> 7b6dd7a923281a7c perf pmu: Assume sysfs events are always the same case
> 6debc5aa326fa2ee perf test pmu: Test all sysfs PMU event names are the sa=
me case
> 18eb2ca8c18f0612 perf test pmu: Add an eagerly loaded event test
> aa1551f299ba414c perf test pmu: Refactor format test and exposed test API=
s
> 785623ee855e893d perf Document: Sysfs event names must be lower or upper =
case
> 97c48ea8ff1cd70f perf test pmu-events: Make it clearer that pmu-events te=
sts JSON events
> 3cdd98b42d212160 (x1/perf-tools-next) perf maps: Remove check_invariants(=
) from maps__lock()
> e3123079b906dc2e perf cs-etm: Improve version detection and error reporti=
ng
> bc5e0e1b93565e37 perf cs-etm: Remove repeated fetches of the ETM PMU
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> root@number:~# perf -v
> perf version 6.9.rc5.g325557715f1d
> root@number:~# perf probe -l
> DSO [kernel.kallsyms] is still in rbtree when being deleted!
> DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/drivers/hid/hid-sensor-hub.=
ko.xz is still in rbtree when being deleted!
> DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/drivers/hid/uhid.ko.xz is s=
till in rbtree when being deleted!
> DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/drivers/net/tun.ko.xz is st=
ill in rbtree when being deleted!
> DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/fs/overlayfs/overlay.ko.xz =
is still in rbtree when being deleted!
> DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/net/bluetooth/rfcomm/rfcomm=
ko.xz is still in rbtree when being deleted!
> DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/drivers/input/misc/uinput.k=
o.xz is still in rbtree when being deleted!
> DSO /lib/modules/6.8.7-200.fc39.x86_64/kernel/sound/core/seq/snd-seq-dumm=
y.ko.xz is still in rbtree when being deleted!
> <SNIP a lot of other modules, probably all of them>


Right, we don't have a test on this and this motivates the addition of
reference count checking on DSO in the later patches. With the series
applied, fixing the rebase issue, I see:

$ git log --oneline
eabe5dd91331 (HEAD) perf dso: Use container_of to avoid a pointer in dso_da=
ta
fd47ec98a05c perf dso: Reference counting related fixes
962af2d2b092 perf dso: Add reference count checking and accessor functions
48664a9a6ca4 perf dsos: Switch hand code to bsearch
ae7a9854dabd perf dsos: Remove __dsos__findnew_link_by_longname_id
e616a6b3739d perf dsos: Remove __dsos__addnew
e789368716dd perf dsos: Switch backing storage to array from rbtree/list
7b6dd7a92328 (ptn/tmp.perf-tools-next, ptn/perf-tools-next) perf pmu:
Assume sysfs events are always the same case
..
$ sudo /tmp/perf/perf -v
perf version 6.9.rc5.geabe5dd91331
$ sudo /tmp/perf/perf probe -l
$

I'll see if I can find a fix to backport before sending a new series
to work around the 2 line rebase conflict.

Thanks,
Ian

>
> Then with:
>
> 65e1e704f37916a0 (HEAD -> perf-tools-next) perf dsos: Switch hand code to=
 bsearch
> 64377d6b7d5f9a71 perf dsos: Remove __dsos__findnew_link_by_longname_id
> 8e773b8be95aff66 perf dsos: Remove __dsos__addnew
> b1d064fc9b912ece perf dsos: Switch backing storage to array from rbtree/l=
ist
>
> applied it continues like that, the next patch in line isn't applying.
>
> I'll push what I have to tmp.perf-tools-next.
>
> - Arnaldo

