Return-Path: <linux-kernel+bounces-326822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13C0976D67
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106CB1C23B48
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141B41BBBCB;
	Thu, 12 Sep 2024 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMsAr9HH"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC2B1B9833
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153946; cv=none; b=RgplDLnUpqc+bFB/TQO7GlBgkusOuu8hG8jA6C+5sQrrnWd70E0yW2uNviAcv+jty/AuDQt7lh9fsVCZJbJ9JvqYJFZx7NPueV/yi+rJGg8Q/U+5dsRLscaVmgltZSSIndEKWzGCmqB7IYHldKxEGkJbH5Rye53Arzl4zA/bnM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153946; c=relaxed/simple;
	bh=QlEYYDXtTGIxeBuZbvdktHIfoy0JqF2apXxlZhC0hSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ls4Qr249OMl79JsBhzycKjo6cPnwwDal78B8ydFAVM8UWgrmNjXQm7wkJyDBxSWKy0ifOq0lX6NCC10ZhgXhoGef8wiP9cAsWwZ/FABiYYaYZAW662xSIUd+q/x2BDCguRL99gUwXRDJ6O7bWf+GueqLnYE0q79wQXfhvR5XpqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qMsAr9HH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so10081975e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726153943; x=1726758743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0vEtamCOnYuoncchNofQc9nqoQ7AlgNKS0ZFixTi9Yk=;
        b=qMsAr9HHkSEHz7OPFeNx9YvAwJdCjCj56pIru2FmNGWFLd7zNpEWN9yIeGLv3/Z6zD
         oX1GbriCBD2m0K7TNSkAVazNUSfasUBjS7oRPFbxqrngqexwKWHo2hz7eNwOWsXXxAap
         o+gvTMuQ7QbnPCtRmJY7m6ZFamyoMs/U6d5OY/KCna7SymF2OFWEYAuNWOq3UDSoli6O
         tL+vkMjeM1TSACg7M9FfqN48bfubYEWLrku44DF8KHamnDWyv9kzubzqhGjnThSjExSA
         Lqwmzw8ZIgGOLmzgThv8vgYP3PidvQtXyCECYj1mPBI5OqJ3e0XkTdFceoVv2RlGaOoB
         /2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153943; x=1726758743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vEtamCOnYuoncchNofQc9nqoQ7AlgNKS0ZFixTi9Yk=;
        b=s41B+WTn3aY4Kp23bseY6dRl7uXUeYPvL9gty0vBaImuLkxJ12a6MU+cEmaIhActU8
         7z+EapJxHCXsC6f9P+00Mb1vZb3gAgAWAJeagBVKC8H48odvQiQsR/5oUfB0ff7cFaC4
         XbaRljn2RsfYiRx3EsFtVXsREh0hVoO9yD6Q6Xjq4xwcTYDUdsPbnQe9vRVixju/OgqP
         jFEd8cRQZQC4Z5LwjIgWTN9RNyh3fWjj9VoF2fe4TWwJjXwnjPt2nVLtDjqeGSf1PqMo
         lok+N72DDR+TmReMEaCL0/jZKdtoT3v2AYXjPTi4t0GJskWdxH9RHeadPaHdY130dYH9
         CYDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTcnmn2wYS6eYt2W3ASTVGHIgs6KW7RXJupdPVc7ZxNsWn2kjLERjZHnPl+Xv8NomxaoVmu1IokePRQBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTdHHBUeulf3XNqecLIF+XSNcFkJTiEVsiI6PSGFshFq9LCVSm
	zOKVuTLnn6B+r2QbuvecVzcNQxSp84NzbPOyqMqO0AZr6hoyx81zmvvWUCN9Uoc=
X-Google-Smtp-Source: AGHT+IHpusjf0xjPxFiA1GZfxsDd5yBxUzacHglUD/J7pm0cxmuicT08JsLhs59QcAxNXs2hkgj50w==
X-Received: by 2002:a05:600c:3581:b0:42c:c8be:4217 with SMTP id 5b1f17b1804b1-42cdb53192dmr25176075e9.11.1726153942753;
        Thu, 12 Sep 2024 08:12:22 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb0dbcb6bsm171928845e9.30.2024.09.12.08.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:12:22 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	gankulkarni@os.amperecomputing.com,
	coresight@lists.linaro.org,
	leo.yan@arm.com,
	scclevenger@os.amperecomputing.com
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
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	Ben Gainey <ben.gainey@arm.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/7] perf: cs-etm: Coresight decode and disassembly improvements
Date: Thu, 12 Sep 2024 16:11:31 +0100
Message-Id: <20240912151143.1264483-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A set of changes that came out of the issues reported here [1].

 * First 2 patches fix a decode bug in Perf and add support for new
   consistency checks in OpenCSD
 * The remaining ones make the disassembly script easier to test
   and use. This also involves adding a new Python binding to
   Perf to get a config value (perf_config_get())

[1]: https://lore.kernel.org/linux-arm-kernel/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/

Changes since V1:
  * Keep the flush function for discontinuities
  * Still remove the flush when the buffer fills, but now add
    cs_etm__end_block() for the end trace. That way we won't drop
    the last branch stack if the instruction sample period wasn't
    hit at the very end.

James Clark (7):
  perf cs-etm: Don't flush when packet_queue fills up
  perf cs-etm: Use new OpenCSD consistency checks
  perf scripting python: Add function to get a config value
  perf scripts python cs-etm: Update to use argparse
  perf scripts python cs-etm: Improve arguments
  perf scripts python cs-etm: Add start and stop arguments
  perf test: cs-etm: Test Coresight disassembly script

 .../perf/Documentation/perf-script-python.txt |   2 +-
 .../scripts/python/Perf-Trace-Util/Context.c  |  11 ++
 .../scripts/python/arm-cs-trace-disasm.py     | 109 +++++++++++++-----
 .../tests/shell/test_arm_coresight_disasm.sh  |  63 ++++++++++
 tools/perf/util/config.c                      |  22 ++++
 tools/perf/util/config.h                      |   1 +
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   7 +-
 tools/perf/util/cs-etm.c                      |  25 ++--
 8 files changed, 205 insertions(+), 35 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_arm_coresight_disasm.sh

-- 
2.34.1


