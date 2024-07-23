Return-Path: <linux-kernel+bounces-260016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E8093A15A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A685A1C22365
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA7D15351B;
	Tue, 23 Jul 2024 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x12E1e9o"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A35814D6EE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741401; cv=none; b=gmzLP7qLu7ahx8K/R9JYrBgnSUenROmuqq5110xTp+gODv2k1txuGzB0HtO7O6H0IoNepEXucUT4neDLoPfvlfQ1aqzRHds6Aot6hCCSusujBVOhA2AlVG2v4l3WidLj6er/6dqS7EVGvJWBK5D/iGTLkUPepjeWAbuQRE9EB8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741401; c=relaxed/simple;
	bh=lRZmalkeED0KsWnjAtNEkpaePLI01kZSC6setsBqClE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ismfpU52ksLNz7E1yaiZE0v5I+fLBrZXPIuS1qKWbxlnBlJrUMbkkucKhPJme5hi3DLZfZ964mLkLpcdQaMFc1UREnTbyFsHpVh8JIUh4JbCMKLxg5n7njDqt3NyNgrIu9Aog5SW9y0kDRRe/IzLeZj+2lGijaqj9C69SkPNNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x12E1e9o; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4267345e746so41089295e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721741399; x=1722346199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hT/gzCHhf+qVfp/KGByTrnu2rADn9gzgQeI0FZbkXbY=;
        b=x12E1e9o7rm1jFLSvq+jqSo/BHDGWkcdfGf2W1dYkox36mSMW+fR6uMfcW7Y0M6Hv2
         0ml8L0oXqb3Xu9h5Kab7sRibZkqMtxzRx11t/ljF29e75yz+50OaqHOEULEkRrfEy+rd
         pJSZ5ObWIIlLX+oTRg07zXqfGzvOZboppmGe0mF/w7iwhOC967Ukn1m6lUCKBB27FsYh
         TLpBuB/CiSJ7YLQ25WzVLB3sKV8bKtvMJPFpraYUna14jKL2IalEHeE/SJNv6m6FyYEf
         6g1AS0uEEbdsIYMhWmF8ubDuuISQ/5FAlOVjHgvjwNCjjC3jRYY8SSwSV/WLZ7JsYwnk
         U/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721741399; x=1722346199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hT/gzCHhf+qVfp/KGByTrnu2rADn9gzgQeI0FZbkXbY=;
        b=kpdzlrnRAGVcwkiSeaotnK0eDt4HgtlE3s7DvYC9MaPEToI2WpIowu4dbfF1fQRhyF
         y2h0j6P3vjRM6t2BYQp6j5ddJAFf9AIgDxTsc08Cl9fMpGgwx4P4stmnpBFEjSDwsLP6
         LrTXbWIfyQBTVvaMc1w8soPo/lKq5nbinn7NKMPBkseegZhwX+i6vxXkZLrdZbQB5Zjb
         Yiz/n1PnpJJpSDMHG0qtwN/Apnl+ZTojfwaxHgc2DT3cciaqdNtTKHA6MS09ohQVwW0+
         LGdWOfOoVjAc3Z9wVJAdEwrLSEwrOjhsp7XDI6ab9VT4uir1VZtstM6qgWB7JgvGADY6
         SkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsCxKEswK6/evkCsfosZsnv4tG+wenL7a/fC1m0baMC+GABvmRFK0CYb82Fuirylj50/IqkGdlIWgU5TYFugmNMHvRcxZJkzJnNiyT
X-Gm-Message-State: AOJu0YxLMlD21EQ30T1crWEw12qcFzrnkAbGKGWlh6ElXb8QIoIx0h8k
	UGhYmqAAmC81LZeelwK/ycuBmjWnQWERp/r3QLVxx/TxslW1yB7IlDuM8IYrXNI=
X-Google-Smtp-Source: AGHT+IHg9yxdq/FSvEEy5p0c/Y+4KCXIFv69webYYsBkh1Jhzsy+DT8KFMnM69flKDYyhbRcmlNbLg==
X-Received: by 2002:a05:600c:5487:b0:427:9dad:8063 with SMTP id 5b1f17b1804b1-427dc51d315mr54599965e9.12.1721741398620;
        Tue, 23 Jul 2024 06:29:58 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d68fa9b1sm176277485e9.8.2024.07.23.06.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 06:29:58 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@arm.com,
	suzuki.poulose@arm.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf scripts python: cs-etm: Restore first sample log in verbose mode
Date: Tue, 23 Jul 2024 14:28:58 +0100
Message-Id: <20240723132858.12747-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linked commit moved the early return on the first sample to before
the verbose log, so move the log earlier too. Now the first sample is
also logged and not skipped.

Fixes: 2d98dbb4c9c5 ("perf scripts python arm-cs-trace-disasm.py: Do not ignore disam first sample")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index d973c2baed1c..7aff02d84ffb 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -192,17 +192,16 @@ def process_event(param_dict):
 	ip = sample["ip"]
 	addr = sample["addr"]
 
+	if (options.verbose == True):
+		print("Event type: %s" % name)
+		print_sample(sample)
+
 	# Initialize CPU data if it's empty, and directly return back
 	# if this is the first tracing event for this CPU.
 	if (cpu_data.get(str(cpu) + 'addr') == None):
 		cpu_data[str(cpu) + 'addr'] = addr
 		return
 
-
-	if (options.verbose == True):
-		print("Event type: %s" % name)
-		print_sample(sample)
-
 	# If cannot find dso so cannot dump assembler, bail out
 	if (dso == '[unknown]'):
 		return
-- 
2.34.1


