Return-Path: <linux-kernel+bounces-322483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C87A97297B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E2AB22B66
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E061B178389;
	Tue, 10 Sep 2024 06:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="f0uTqgtF"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EC0178CEC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 06:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949622; cv=none; b=Z+3u2clZf2XTEsZBuEYwPxyPKXT445BUW8qczzbIK8oTfKOAHdp9WrKGIvl+ktXispL2bWtD9i/P/OpQQ/cMfUPVbDLWE86E7Uh2BOJ5IxxAYXxjtcfzHngNFCCLCFs1GdE7ng01CxeF4fbpgSTZC6LMtHid1Oe/x2NtfDVF/Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949622; c=relaxed/simple;
	bh=J8V+QR9ohEAwspG4n7Beol9OtE96DuppXu8cCjPnsjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j6MrJpU2jSJjtOSpgHpyNcq77T5zmnw6x2ue9LOSbmybp9G4qaitlqzzj6PWsb2P5aE9AobdaeiGDa/EQuQpr3hUAP+T6oMK6WRyEJnrBdyOrXp2rA6RW84cefx01MqLggtBL1sKOiuLpBLM6hKkSl1CdB3sX7T+ZBQfI13LGUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=f0uTqgtF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso3197250b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 23:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725949620; x=1726554420; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vd6Y1B45d++5dxbQadt4wRVSI5hOBBeCjl8zkXMQa8M=;
        b=f0uTqgtFprC24fZaDMo3VZRzIh4L7zQPiGC5d5fSXc8GBh2jQndwQi/Ty9rnRDr9DT
         qbLjCjVt7ywPbC03ZS+th/UkAqS4hsGQaH4nOQQ8w+Ux5wovfxtNDPO6sC8DrY4MDqrm
         oi3hUlFstFW7Glus9ckmIRJbasOwB84YNUegSrzFN4yt7asqq6dT4xa7AqxgJiSYqgff
         PR2bodySOmmrxTKzJzhYs9rindgRufvu2N1z/c8qrU4KtubyGV1CKRasRsKPmgR8z6iI
         PskrkiNjtJjbMcz5vpBUk20R9Bzp/Ve/yf4Eoyd2Rcp8gskX9kAMtp3wC5s7fiwg7EW5
         kgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725949620; x=1726554420;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vd6Y1B45d++5dxbQadt4wRVSI5hOBBeCjl8zkXMQa8M=;
        b=Yy1nutXUkrVEyyC5XCFDkm+TXrxwAhl74u1dAanfVGG9PA5R79kPr28kB3S7St7xtk
         yAMdFEp+OmCrV/u2vvlm/+76ZXOw3TI5nf1IE8W65C2Aiz0vhmx9PBQ8CgxTgOAMUJWn
         YuVo1vLL+NH8yOPNwmHUdvjUMZoR9Ou96arue0zpJpZU3Xk5UVkrFdRdqGDasqtxDLJ4
         VdSy/qLLSUQ46v4RayNskr/JYrh8dJCfXnErK9IrbiczLHXXhi7LFgInIfigRczK4XEZ
         zU/Ck9himuH/pf4MPMfEtKgtwAAFlDDkt631qHyzeV6b2PmHTOE7Opua7obkNM93u3+l
         laQg==
X-Forwarded-Encrypted: i=1; AJvYcCUItqGxLurq5AjXepyitTtFbkWd4F0G2heO6UQTNw6o2eMZ/gidDgUYGjkoNy2qm+D3K7C3CdbhZvwCuq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx83g/2M6lZBOzkeiK0PsbRqdC1ovrg9EUU4zwQKlHv2Xiq8Lo3
	om8vcla4QdLBRkUFwwrJqocznwmIqlQeqjMCoydDH6iTHTabSr5fR8E6I5JR4S0=
X-Google-Smtp-Source: AGHT+IHtZZFC6fQxHgMMs9+U9GsmAZ2v6gpj5Lhbg1zcpnq1KVATOUFnYdn/PXIrd/kCHO1Tn4Tc2Q==
X-Received: by 2002:a05:6a00:22c8:b0:70b:a46:7db7 with SMTP id d2e1a72fcca58-718e3fe64damr15376110b3a.16.1725949619727;
        Mon, 09 Sep 2024 23:26:59 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d823cf3d58sm4202099a12.20.2024.09.09.23.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 23:26:58 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 09 Sep 2024 23:26:52 -0700
Subject: [PATCH v2] libperf: Add perf_evsel__id() function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-perf_evsel_get_id-v2-1-b26eae02f606@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAKvm32YC/22NQQrCMBBFr1JmbSQTUxVX3kNKqOmkHdCkJCUoJ
 Xc3Fty5fA/++yskikwJLs0KkTInDr6C2jVgp96PJHioDEoqLc9KiZmiM5QTPcxIi+FBuBMhOmx
 bqe9Qd3Mkx6+teesqT5yWEN/bRcav/dUOf2oZBQrpXK+kthqP+ho5h8Te7m14QldK+QBq3qD7t
 QAAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2997; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=J8V+QR9ohEAwspG4n7Beol9OtE96DuppXu8cCjPnsjs=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9r9Z2sqToSsE7cQdPbKLCt40SHwXeRfjNzUeqlt9RVpl
 8S72N53lLIwiHEwyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMBEFKYa/siX6zxzv3Nv+/ey1
 CzM+vLQU80v+oLpM6tkJz40Zfu8adjL8lThxXuyZ8hv/7f47jnnNzTmmbpC1+pJVYGjhXI/c0oA
 yJgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Introduce perf_evsel__id() to collect the id of an evsel. This allows
applications to determine the allocated id of an evsel for each fd. The
"ids" argument is expected to be an array the size of the number of open
fd's for the evsel.  This will allow applications to link the id
returned by PERF_SAMPLE_ID to the event being sampled.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v2:
- Replaced id argument with array of ids for perf_evsel__id() to support
  the id for each fd.
- Link to v1: https://lore.kernel.org/r/20240823-perf_evsel_get_id-v1-1-0ffa204c4164@rivosinc.com
---
 tools/lib/perf/Documentation/libperf.txt |  2 ++
 tools/lib/perf/evsel.c                   | 10 ++++++++++
 tools/lib/perf/include/perf/evsel.h      |  1 +
 3 files changed, 13 insertions(+)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index fcfb9499ef9c..754c103f7b13 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -94,6 +94,8 @@ SYNOPSIS
   void perf_evlist__enable(struct perf_evlist *evlist);
   void perf_evlist__disable(struct perf_evlist *evlist);
 
+  void perf_evsel__id(struct perf_evsel *evsel, __u64 ids[]);
+
   #define perf_evlist__for_each_evsel(evlist, pos)
 
   void perf_evlist__set_maps(struct perf_evlist *evlist,
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index c07160953224..d10dfcb605ba 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -484,6 +484,16 @@ int perf_evsel__disable(struct perf_evsel *evsel)
 	return err;
 }
 
+int perf_evsel__id(struct perf_evsel *evsel, __u64 ids[])
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ID, (unsigned long)&ids[i], i);
+	return err;
+}
+
 int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 {
 	int err = 0, i;
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 6f92204075c2..13f19189839a 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -41,6 +41,7 @@ LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx
 LIBPERF_API int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
+LIBPERF_API int perf_evsel__id(struct perf_evsel *evsel, __u64 ids[]);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
 LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);

---
base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
change-id: 20240822-perf_evsel_get_id-f7e11f15504b
-- 
- Charlie


