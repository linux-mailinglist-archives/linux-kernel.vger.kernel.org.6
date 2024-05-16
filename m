Return-Path: <linux-kernel+bounces-181345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1758C7AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6071C21C34
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C329114B940;
	Thu, 16 May 2024 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lrn0JLjo"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468F4C121
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715878657; cv=none; b=WWYrkzt0q2Q1eu9mm2zwpKryPIQ9QyK24H46ApTTl9X2kZ1h+vhpoEMKnvufwCIMCjeCqC+yuZoy7hCqIK6duVE8pfZSMLLU+9OvJdAS4g4HkuzEZmJdsOPrJ/+ap+svv7+Kt4EnQcc2FZ+UeA5duEzZkUwCiCQmPtRdrU498ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715878657; c=relaxed/simple;
	bh=4z0LvThJEiKq2H3kd+RUA72yTT6QSoojsUkp+4+JLzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGgLyi4NXQgTLcfXPwwtys//Qy58H7HV+lHuxQv2i5CvkODC9Ash6r9EDK8S3X9XhotoqcLI2HMDjYVpq3DsMpbUZUsWCKzKBo5YWbBp0vUQfFC5xPxfCnv24IFJYrw3c9r/XOd3OSBAaTbhEh2sNnThc1a0q7y3Zeln1G9bPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lrn0JLjo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1eed90a926fso6035ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715878653; x=1716483453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqpSCcrr1x6Rp9jDqagAxtA7Cjuz8cvYaFzHk9HszMY=;
        b=Lrn0JLjoc+FijiIvegT71s/c1Hg/+wPgW7lnZbramMQeun7hZLk8RcsJ5WsDf0vkL4
         u/OIf7VS92A0tGd05vPg3N9SJEnJsUJ+2ioP42mDhQm7/C39jH2f0OdRE2PA+tOf2dlm
         otOnJX24DcMAKx9ziTw95jU90v2y7Sy/G8BEwaNp+9SIk+q0eM3ER47440qqWapKoYdu
         4elL4ywWezZXQUVRV7MHgju+e8OXqBq3Lbz6Npl4Qc4DlZgRCzfUTqei3UtqseZC7J76
         eR5h/o5LUeK8lmSUyMHBfxROlGxsko3ZFUek0XWAFjCMK0/111+GgnBaAefpbPv2qC5y
         P2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715878653; x=1716483453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqpSCcrr1x6Rp9jDqagAxtA7Cjuz8cvYaFzHk9HszMY=;
        b=Nsj8TFa38BOrr7+olgFjdG/Z5m3Kd2CK89d+Z8SshO6j18X49bGW4Bf7/GbdsOr9ap
         GWaW9gsCW2Fxs/TIjxnRDywqkkhCTQomJnS5X6un7dMUxgmTr3kXZaKKkngCTR2QmaKl
         OY/XVyMT9Ul/KSXg0l2cxle1ka9Q7BR9YoF3vWqFFTHAPIiv54A4unMgAv5MmAyx0gDI
         9irOYfugLJW4Q8a9t8kch1/qSSwkH4iOn6rrUTTlF6W4MCu23AEw1gQ/6xP5ndwrtE67
         0xlcb68P29vdLnwzj7B+b0VGiIvc4RE515Og4YYoxo5Il549eHcCXg0lpoaE7Fqr7lp4
         MsvA==
X-Forwarded-Encrypted: i=1; AJvYcCW4BsftkIKpUELDJxhYaS8J2ZWCaaykxs1FnlObBQHtU9o6L4Oe+FsAA9sbt8nDkgKehfAiLjUKQxeKZNyTbihZ29n5VWrt4/Un+2ll
X-Gm-Message-State: AOJu0YzZRXxPPr0p/0HtqEKPqyFo2QbnzfXStwCKYiBqOPNVwLPGSrwm
	o4XrlZUA53El6ddTwct/uAZbhn2zGxbOkHZNPdw6cerlcrbce5klrExbyodS0iU1mkrGZHjOTGp
	yhGrDGOIKsf8H3jrihFgBqdsY/8m+Xrvk7uP1
X-Google-Smtp-Source: AGHT+IG/XwMydBHOjq3QmTNXCCxT8rv1bnywB6ho3Oni4ZCUNL5rvm9eSm1ulDdNMygSqprtFF73dK32X4UoOiX/iz0=
X-Received: by 2002:a17:902:d4c6:b0:1e8:88b2:17cd with SMTP id
 d9443c01a7336-1f05f651484mr12546175ad.12.1715878653170; Thu, 16 May 2024
 09:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515054443.2824147-1-weilin.wang@intel.com> <20240515054443.2824147-7-weilin.wang@intel.com>
In-Reply-To: <20240515054443.2824147-7-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 May 2024 09:57:21 -0700
Message-ID: <CAP-5=fXDmewhEzZc5ZYhfHYtPUmELjeDTKM5m04PRFaAPaO+vg@mail.gmail.com>
Subject: Re: [RFC PATCH v8 6/7] perf vendor events intel: Add MTL metric json files
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:44=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Add MTL metric json file at TMA4.7 [1]. Some of the metrics' formulas use=
 TPEBS
> retire_latency in MTL.
>
> [1] https://lore.kernel.org/all/20240214011820.644458-1-irogers@google.co=
m/
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>

This change works either with the approach in this series or with the
evsel approach so I don't mind my reviewed-by standing. I'd prefer we
could have an evsel read counter implementation that returns 0 so that
we can run without retirement latency gathering.

TMA 4.7 is broken in that the tma_lock_latency metric uses a
retirement latency event but not within a max function so having the
read counter return 0 would break the metric:

+    {
+        "BriefDescription": "This metric represents fraction of
cycles the CPU spent handling cache misses due to lock operations",
+        "MetricExpr": "MEM_INST_RETIRED.LOCK_LOADS *
MEM_INST_RETIRED.LOCK_LOADS:R / tma_info_thread_clks",
+        "MetricGroup":
"Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1_bound_group",
+        "MetricName": "tma_lock_latency",
+        "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound >
0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of
cycles the CPU spent handling cache misses due to lock operations. Due
to the microarchitecture handling of locks; they are classified as
L1_Bound regardless of what memory source satisfied them. Sample with:
MEM_INST_RETIRED.LOCK_LOADS_PS. Related metrics: tma_store_latency",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },

Other metrics then use that metric specifically
tma_info_bottleneck_memory_data_tlbs and
tma_info_bottleneck_cache_memory_bandwidth.

I couldn't see in the TMA 4.8 release the updated MTL metrics:
https://github.com/intel/perfmon/pull/181/commits/d54c847b2f863c98a917bdd31=
a0680f4d50ff75c
but my belief is that this issue hasn't been addressed.

Thanks,
Ian

