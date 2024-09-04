Return-Path: <linux-kernel+bounces-314235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777C796B04D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0D01F25C6C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 05:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5597912E1E0;
	Wed,  4 Sep 2024 05:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5WQIo0l"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781C12C552
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 05:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426385; cv=none; b=XFneVa5yQxwX+XH/xBbh6T1f/TbnW4U+rnGuoMWIdh41icy7gyijQVh77pAIW6xhUZ4KdD6PBfHFkVjDsHb05/pTineYKZRRmCv6wlHXFyYFR3Fc4Umstne170BJib9YcEnCoIfJfyCJHeO12FSth7aLZR6DceKuxCuM3xEvPpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426385; c=relaxed/simple;
	bh=Zzp47YpjJrlq/7aNuFnEG/sx74AzSK2oA4jiAlYD1m4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MwpmXkP1xqc+QLGNEJHwJcR5ZxRcOcUDRwuNpkB6c9jpHEq3PjEaWkvt+DeqVGbFW9ue+W1iKra2mG3qXUFYyC6fcXse5G1wi8NuQnjn1KRSDtjNyEUC8t4Fzg7qfsMLXoVm70Sikg6xclu/R78qE1CmvXV6bZF+V3PtlyREzVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y5WQIo0l; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1ab008280aso5754662276.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 22:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725426383; x=1726031183; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5+jy8suatSYU8agZ+1zFUqOrIedBbY+ji9A0DmCUwg=;
        b=Y5WQIo0lY+umlt4tq80jGYjTnjcRkTn6c11ahLAX+KX6r3xkd2cOiEFc0s8TcpiZ+k
         MXSK1hRk1j901wD+veDRuy/sX0DrSCKC7enkqiNwKfqP6QjJ7SWAQ/8rUscZYohhpXxR
         rGhA52tBIiSVh0F5plo8ZG3UgL0HdH6SesJ1u1Na9n5pYDX+u5vPU9G253VI/rrNpQDP
         QBkWocqRhMkXHhBzwzoaEej8DombiTwf9JZl+Y46dxQoaYFBTdCOYCYPyqeEqrtlLaPL
         Nzmfcson0lKdioHhf9S1WhhFQ8EEsMN1LeW1FUnW41BA08B1tqtSlC9PWjSGngbHp1yq
         DRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725426383; x=1726031183;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5+jy8suatSYU8agZ+1zFUqOrIedBbY+ji9A0DmCUwg=;
        b=DV7JOqLfdocNs/J7/Fp0keJA4upRj3s1huhlAwGRscKVC5ZrhEAkFMZVGjBi81EVJm
         xqPNlwFxccLL6E7g0GqOAuTPFFpGpeWMyWqJsez2W6gidh0U0TT8Kb3ZipZCkattoqub
         /4lsOFxW920E1nvUgRL8MqJVfJ0taqAhx/7o1Woxf4vSQ84MoXWHsaWm60gl4+Mn5tzO
         +MYSdNKBxdUgBgW8N3Swdve+NNEyQrCBt1HOlX5153pNEUNRhRsMHHuUULqlYwNXT+q/
         fsVRtdsj0ZJ9bPEhmg+w3ni7RdEPtoCGPUZQXtOHzmUVBp/7k5ZCLKX20qV6MpfBTG2H
         Cj3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvyCQnRQKgG7+lRF7tVcrYcHGAm71PPk5b00TdpqOEhOuNA0vjMtF+ZUrryiA5Bh5wYbXw/nvsu+Pt9ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ9hjDrVDHaOSZQYIdRwOj+hJ77QubRO4jxjXAX/cNd+5w0zSX
	3nFn/witNaNwalNtbVqx+xipNUj5BtX1U+lb4iPwSj4hGSPVMpz/amSQupk065dsGy+hARV6ZkK
	Lz3u02A==
X-Google-Smtp-Source: AGHT+IGGPVF71/v8Ly5msG6tRUJzPuQAIOn9/kjoP6sROxK81r4wDL5JgHaT37QF84+IbQDEH5PUBL+bgQfp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c48b:5e3:a63c:2d09])
 (user=irogers job=sendgmr) by 2002:a25:e910:0:b0:e11:7039:ff92 with SMTP id
 3f1490d57ef6-e1a7a3e8384mr26722276.11.1725426383309; Tue, 03 Sep 2024
 22:06:23 -0700 (PDT)
Date: Tue,  3 Sep 2024 22:06:06 -0700
In-Reply-To: <20240904050606.752788-1-irogers@google.com>
Message-Id: <20240904050606.752788-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904050606.752788-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v2 6/6] perf test: Make watchpoint data 32-bits on i386
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

i386 only supports watchpoints up to size 4, 8 bytes causes extra
counts and test failures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/wp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index cc8719609b19..6c178985e37f 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -20,7 +20,12 @@ do {                                            \
 	TEST_ASSERT_VAL(text, count == val);    \
 } while (0)
 
+#ifdef __i386__
+/* Only breakpoint length less-than 8 has hardware support on i386. */
+volatile u32 data1;
+#else
 volatile u64 data1;
+#endif
 volatile u8 data2[3];
 
 #ifndef __s390x__
-- 
2.46.0.469.g59c65b2a67-goog


