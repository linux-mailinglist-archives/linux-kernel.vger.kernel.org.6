Return-Path: <linux-kernel+bounces-261094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E69FA93B2BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974C91F2132C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E03915957D;
	Wed, 24 Jul 2024 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+4ZvqnN"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0894E1E50F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831697; cv=none; b=qUGGjAz9Ke6yxXFqmQogEnmxKP9DifEb7z51MB/3l0anPYAVsISOJLplbk0ckxoGFBuEZmCocAJDhg0dVoyqEHs1p53qECJB9plbTiCEnbjqgkLs/JYNSoNG+7Y/MDt+hNsrKxcMY0jeXyrnu3i2zJA4kDaVBC4qE5WlJTCNsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831697; c=relaxed/simple;
	bh=t5EUGcnche4/CSvOdCl3xbAPqqCIWm8X2sMW8nv5oIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S08v7+BNZ2lfxmMQz+xidYDXe5dTL+SVzKPWlpGiXAAyA84EqNoHWsfT2467ia+q1kkz1HQ0A7YWKtPBwqn2pmHXBp9ioQzHjRJ13d9wwl1dU31B/lXrw+ROvHX2s1kaDapbkIDtRLJ3U0H/m+QMqUgClVZGOfS6IoPQLgXui+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B+4ZvqnN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3683f56b9bdso3742352f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721831694; x=1722436494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4VhERnVjZMf0Sg6OFzVS2dnAmWgxdNCZ5orzDkCtCZ0=;
        b=B+4ZvqnN87B6UI1BppKescHNl/KPjC19QGGLa3JYIgPG8LXooBDfkpEd5adNEOnfRL
         wE90NqFV2ZwLFYfmAmDwWoQ0rKkFhT4g8ZZ2ehq1nY87Pjjy4nd3hqxSa00b3qZZ82J5
         /m6+eHu7/CXx8bSw6agwHBMpXROQzgW5VCeQZarBp5FOStCBImwmaO00aornV+pOJypO
         S4A0p4B7j1veSDH3XvvX6FyYLMCWSKgOzyq7zEvqidf7SKC0F9dHXkjy3fYc0Aht7Knm
         x5cOt+USK8fSvPpcJbiBtZhOygTCMXm2S6qoo1pMSx09vLrKHjLYdMMbs9L+hg77uuQ5
         ExwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721831694; x=1722436494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VhERnVjZMf0Sg6OFzVS2dnAmWgxdNCZ5orzDkCtCZ0=;
        b=EPrc0AwWUrFNYc5geIqrLOD8mwVCQxDXro8qTVNywiLsmmt2yr8fEWg9OhAFBe0UiU
         nqzu1gz5A/xl4bQJuWJKuGBlER4cwcjCJwYSGX8f5h3URFiNa3R1F9N8xmDERZ7ADCXT
         teSBFemLJqNfdOCnMxB+VR9tIU+QThxwQ4kUFPkWjyYhvFRP2wS6eB02QCWcD4FXoH2I
         X851ET+DOh+Iu24WkH2jZPvOs+C0BObymrKlPUPb6C6h6h9HMMQvllGHSVhylF/mYEVk
         CARSYH4A01vR1bj7T6e4mAXLZymnFE6jOIoj45+B4JkCORWi4SkDFrji8z33BkSanz0x
         q/Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXroBd+clrTBXU2+RJm4Uk2pejX/ZnAatYNCPFp/XirHuhxpnAflL6WVjo4+5+3Lt4NERfvKwzLS2Sy713gVoNYxaN27rZb4hnYsuzz
X-Gm-Message-State: AOJu0YzPTKuczOhQml4aEMn7KVCGObt1IC3qgvtRSj2Qqj7sa0uTJ2nN
	WQJJ2i4lxWf9yH/d5akgLbnfiM5xGmMXm1Qj2fOWlaq0u6/qfTb61OaNfVC+7RI=
X-Google-Smtp-Source: AGHT+IHlr0nOuurrzX3Z4gyyCK7iSTvctyAT+dqqlEdpLLITtmGkF24655oMdP6cxoltl8ni+fS6TQ==
X-Received: by 2002:a05:6000:1884:b0:368:5e34:4b4b with SMTP id ffacd0b85a97d-369f5b162b1mr1808467f8f.6.1721831694301;
        Wed, 24 Jul 2024 07:34:54 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ebab0sm14657816f8f.92.2024.07.24.07.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 07:34:53 -0700 (PDT)
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
Subject: [PATCH] perf scripts python: cs-etm: Update example to provide vmlinux path to Perf
Date: Wed, 24 Jul 2024 15:33:18 +0100
Message-Id: <20240724143319.169745-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The example shows the vmlinux path being given to the script, but this
only works when running on the target. If the script is run off the
target, then confusingly the vmlinux argument also needs to be given to
Perf as well.

Without going into too much detail in the example about when it is or
isn't required, just include it. It doesn't do any harm even when
running on the target. Now the example command works in both places.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 7aff02d84ffb..4aeb9b497f7a 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -19,10 +19,10 @@ from perf_trace_context import perf_set_itrace_options, \
 # Below are some example commands for using this script.
 #
 # Output disassembly with objdump:
-#  perf script -s scripts/python/arm-cs-trace-disasm.py \
+#  perf script -k path/to/vmlinux -s scripts/python/arm-cs-trace-disasm.py \
 #		-- -d objdump -k path/to/vmlinux
 # Output disassembly with llvm-objdump:
-#  perf script -s scripts/python/arm-cs-trace-disasm.py \
+#  perf script -k path/to/vmlinux -s scripts/python/arm-cs-trace-disasm.py \
 #		-- -d llvm-objdump-11 -k path/to/vmlinux
 # Output only source line and symbols:
 #  perf script -s scripts/python/arm-cs-trace-disasm.py
-- 
2.34.1


