Return-Path: <linux-kernel+bounces-299508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AA695D5A5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370891F23102
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C8E1922C9;
	Fri, 23 Aug 2024 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="l5FCax2L"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8EE191499
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439531; cv=none; b=YPpt+3/VKPdeCgzgnW+Rz0L1+9q1btlr+/YNP433eACVI1+9v530CuBKD9tAMw2I6nZAqbgkW0CRRTIZ/HGbdCgaE0R7PxfytE9ro6mk8a46VEocRUbi35F0h9l2akFj9bPXZecz/Ap2oS5Poru8X4bzusevrRqOngNu/Ydo70w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439531; c=relaxed/simple;
	bh=OL8zr06dGVXX8/JNnl4KISBbwjutHYB3v6J2H8cHVqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P+mMpdfMYn+pOhmzOq3Nwl9KDEKon8UnrhaxTTDYvYPDWeJz2W/9pg535MVMfC772T2pUjl/cuYcvJxH+UIrUfV4J7CaaR111l+b5xTytwb4UwQG0R2p/V4laOuVl35b3O0uenroyEtKuOhFWQBgw8BIYclhpxK2w0QRDH5GvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=l5FCax2L; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-714261089c1so1711635b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724439529; x=1725044329; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yorPWSJYc8UNX8jsP1Uyq6fHvCa9beJkHZhYtqkCUp4=;
        b=l5FCax2LBK5Dp5Yw3Zw83gIAe1yQ6+D8b5mjofVnRjtq4i/Xt08D8htqEfAHbpwz2Q
         nDM/EAmkL+OXhAADjDACh2vfVpizrYhAWB7a9hXSLjyZXI5sbnIMprqt3Y1zPncJp7h9
         3pTnqCkvVSs+JOlWQwpq0I4Ceg1iWmSfnnL9O2skrmswWTSX8ZS/lL1rKOKa3CXrRxdr
         peOeJvKCmAGnh0+TajU+g95Ws1LyvsrU3SpdK/NJ3fyjbSLgTskiqOZv28VEJ6jQwnNP
         zb59DTFPaR17LdB2jfI9NVzD7IZ2bqWy6/lSMZNSyg5GmoSd/m42zmdzJBVAUmow6JEQ
         Cm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724439529; x=1725044329;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yorPWSJYc8UNX8jsP1Uyq6fHvCa9beJkHZhYtqkCUp4=;
        b=ame2pStkiHkm4AV3XRxuDGfAxi+6OsmUi8T5IcF3U78V7vtWFbAGQJHzHZn3F2hB9r
         x4c7curSEpC8Hyi00Jv7h54I2lBTDIJhVP7+ZD2OEsjDXfwdsOY7gR0Zcav4USS8Teqz
         1IHZ3wQInNqjZ4v+X/DUrBqOj8udrag8YgMAh2e1oE0/v47X+/Ln8mMqeszi9QItuLom
         I6l0P1JlL6sNtxKAMC0bJv6Jp1KLk3EzUCIKYtXfANQBd+hYplRJOWnVlhbm7ktvDa0R
         1TDBHBC7roQjNk5kFMCXvXjTQjcwRH3vxb60EteND7C3pCcsu3eAK84GI3PicZd2xH8c
         JSTA==
X-Forwarded-Encrypted: i=1; AJvYcCWNG7ORMW03AZVAovokBaCiz/uf3Rc0Rm6+W9yNp9c1F2ygrgIovLSy8B8vXGGVDY5ffvQ2nIStVmWX8iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxajeIJ5Yypngr9+eOXZ15D3o7hGjzz4XUXicjzjyPfhv/0NpVV
	TNplP8KsyZJh/7rsvU5iZM5c2h5yzMm79xtxRXXJmMt9Odmcgkq9c3ZZdi+39NxzOE8MI0MvjEi
	k
X-Google-Smtp-Source: AGHT+IFawJQXOP4HPBZOeYzX+BNP0Qr+kt+7szwDGJXyVIrQHEtcZM9vyLrqns+0VupnLR/ut52lcA==
X-Received: by 2002:aa7:8ec2:0:b0:714:2371:7a02 with SMTP id d2e1a72fcca58-7143173d6b0mr11838910b3a.5.1724439528774;
        Fri, 23 Aug 2024 11:58:48 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342731acsm3366222b3a.88.2024.08.23.11.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:58:48 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 23 Aug 2024 11:58:38 -0700
Subject: [PATCH] libperf: Add perf_evsel__id() function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-perf_evsel_get_id-v1-1-0ffa204c4164@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAN3byGYC/x3MWwqAIBBG4a3EPCc4YhRtJUK6/NZAVGhIEO096
 fF7OOehiCCI1BYPBSSJcuwZXBY0rcO+QMmcTUYbqxtj1IngHVLE5hZcTmblazB7riptR8rdGeD
 l/p9d/74fnmOTE2MAAAA=
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2669; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=OL8zr06dGVXX8/JNnl4KISBbwjutHYB3v6J2H8cHVqs=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9qJ2/e/z2PYuvAu97UFoUdsy6v/Jz1gOX6m9fH2Ex/el
 1/p/MD2oaOUhUGMg0FWTJGF51oDc+sd/bKjomUTYOawMoEMYeDiFICJBLEzMvTlS9xX3MDvE3GY
 r+BidplB9JKrod93y/1ff+6oEn/NMTuGPxys4dMPaC4wMV6m53Vm1ZkZ11Y6MFzY6JB88cR6geJ
 Tj/kA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Introduce perf_evsel__id() to collect the id of an evsel. It is not
currently possible when using libperf to determine the id of an evsel.
This will allow applications to link the id returned by PERF_SAMPLE_ID
to the event being sampled.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/lib/perf/Documentation/libperf.txt |  2 ++
 tools/lib/perf/evsel.c                   | 10 ++++++++++
 tools/lib/perf/include/perf/evsel.h      |  1 +
 3 files changed, 13 insertions(+)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index fcfb9499ef9c..69c1d7efb659 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -94,6 +94,8 @@ SYNOPSIS
   void perf_evlist__enable(struct perf_evlist *evlist);
   void perf_evlist__disable(struct perf_evlist *evlist);
 
+  void perf_evsel__id(struct perf_evsel *evsel, u64 *id);
+
   #define perf_evlist__for_each_evsel(evlist, pos)
 
   void perf_evlist__set_maps(struct perf_evlist *evlist,
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index c07160953224..765b17045342 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -484,6 +484,16 @@ int perf_evsel__disable(struct perf_evsel *evsel)
 	return err;
 }
 
+int perf_evsel__id(struct perf_evsel *evsel, __u64 *id)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ID, (unsigned long)id, i);
+	return err;
+}
+
 int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 {
 	int err = 0, i;
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 6f92204075c2..1457e5a46b28 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -41,6 +41,7 @@ LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx
 LIBPERF_API int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
+LIBPERF_API int perf_evsel__id(struct perf_evsel *evsel, __u64 *id);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
 LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);

---
base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
change-id: 20240822-perf_evsel_get_id-f7e11f15504b
-- 
- Charlie


