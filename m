Return-Path: <linux-kernel+bounces-252326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 219DE9311A7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D00284D96
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FD5186E4C;
	Mon, 15 Jul 2024 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLT+cNid"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FE01862AB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036898; cv=none; b=rrvqkRbcYeVnr6jVzND36E9EpF7aZrMlwh8Y17beilxzqzF11VbVK87e8SiLFFWGSAfknNQb/lR978SQb90LPW4ck/3esytlBwkhuRnwmAqHuDPWZ8jT/WhRuuAjzH1UcxEchWyJEuLLt/7JH7XXKKIjR4I6URLZjzduv3wlMsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036898; c=relaxed/simple;
	bh=u7jyj5MsChkaLDUlBKY78YItMCLqtBC4NrHf1i3jZK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aRPzUnFnpyj6izy6WF31jqFoPWElN//jLT2ziyucxNVUmGUqHj2N8T9NvtXy1hBAHG+VR5BVIojYUrEE76sOjUP0ZC0bQYbFyXdP24evqn0TMr9Gei9fC+DPWhhFpXd5yyWgs0bCWHNNDDge4YjVWtzIA47vEwCrL+Cg5yO9lAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KLT+cNid; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea7d2a039so4274293e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721036893; x=1721641693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PkqupnN5QS9vbAPZ3s53ee8SAPBpZYOOqApz2BVwlvI=;
        b=KLT+cNidftjAkHwkEiX+VEI+PWtKD1IrrWvpUV0LFirhtHUmO5zAFW5J8YdHCdG4kh
         HI9l9O+DR9Ruu/nVhm7HbLtcl8uJcIM3jMNT7byDBPlLtkGYDY0YvubD3w9auNt16a4T
         1Hi/Bzt+t3k2tFaBTyLklx14EVvXCIhDGrqLotNAxL1+n3WK+G66XeeJFMY9ile5Nkhj
         IUaLNkfGO8cU4ILdC5DjLIBhpKtvn2O2BqGyiu6KVncgR60xgnwMcRXU6ZT+6BaA2vSn
         oacFLRtkxFn6a4KZthdjYN/HUgBW8fr5rNgNmnk+Gr1fTNOSex3M6/eooqi//Gt5qdjN
         zNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721036893; x=1721641693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkqupnN5QS9vbAPZ3s53ee8SAPBpZYOOqApz2BVwlvI=;
        b=ZG4mG76w7abfXRlQSIRar69GSFWRPvGwtTPIXKGUiNhVESwJuUsOcAI19IidZ5SaAi
         GDsPQW7gKZOvLlNYrastT2ArR0jP/ElOANsORWAONgadvMuw5t2pXue3A4ntQkRJ3FNb
         0iFEf+h+TsDgEOHfE+MVljyC2lb1g9JIXDo1ifrix7wdCp1mCHkWWsRcm6O4u/u2VbWi
         lG3INPL7Yb+OFUk4x4rjwvdwESwtoNB1xdC0O6UKsKCYroUlhzJkt+tbcLVB+qdlsIP4
         H31KriJaP0G7eTAjabuN5wrBIBecjhdOpKYYanAlyA3k+k27DibzxnpSxxNNBHf204wx
         vtJA==
X-Forwarded-Encrypted: i=1; AJvYcCWN8p6hOj0MzJZouXmIeUPNMnheWSSNYNVSb2fNFYF4BNaOxGGLrn8PlfZSFJgL9yFoa9ODzhWhoaQP84VS23I+wcH3L/BzCewehOKx
X-Gm-Message-State: AOJu0Ywdejk/ErFvW5se6XrTt8ygjlYf9EAjmn39LFFRY9Jthj1+55kp
	GGhmhfUXvisKTdb6DXbBufSXKnFx/xRWni5XENxc5jhLn3QSQVOWv/Ommtp/V9c=
X-Google-Smtp-Source: AGHT+IHd7j+mfNmvOz/ltgRfupxx+Wvx748wXOxU1MYGwbcekjafHCtkA4P40moncFJUHNgwIe4wYQ==
X-Received: by 2002:ac2:5e9c:0:b0:52c:dd7d:3fd4 with SMTP id 2adb3069b0e04-52eb9997357mr10764123e87.25.1721036893196;
        Mon, 15 Jul 2024 02:48:13 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f23cc5bsm113282245e9.2.2024.07.15.02.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 02:48:12 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Leo Yan <leo.yan@linux.dev>,
	Yunseong Kim <yskelg@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf dso: Fix build when libunwind is enabled
Date: Mon, 15 Jul 2024 10:47:13 +0100
Message-Id: <20240715094715.3914813-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that symsrc_filename is always accessed through an accessor, we also
need a free() function for it to avoid the following compilation error:

  util/unwind-libunwind-local.c:416:12: error: lvalue required as unary
    ‘&’ operand
  416 |      zfree(&dso__symsrc_filename(dso));

Fixes: 1553419c3c10 ("perf dso: Fix address sanitizer build")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/dso.c                    | 2 +-
 tools/perf/util/dso.h                    | 5 +++++
 tools/perf/util/unwind-libunwind-local.c | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 2340c4f6d0c2..67414944f245 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1501,7 +1501,7 @@ void dso__delete(struct dso *dso)
 	auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
 	dso_cache__free(dso);
 	dso__free_a2l(dso);
-	zfree(&RC_CHK_ACCESS(dso)->symsrc_filename);
+	dso__free_symsrc_filename(dso);
 	nsinfo__zput(RC_CHK_ACCESS(dso)->nsinfo);
 	mutex_destroy(dso__lock(dso));
 	RC_CHK_FREE(dso);
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 878c1f441868..ed0068251c65 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -602,6 +602,11 @@ static inline void dso__set_symsrc_filename(struct dso *dso, char *val)
 	RC_CHK_ACCESS(dso)->symsrc_filename = val;
 }
 
+static inline void dso__free_symsrc_filename(struct dso *dso)
+{
+	zfree(&RC_CHK_ACCESS(dso)->symsrc_filename);
+}
+
 static inline enum dso_binary_type dso__symtab_type(const struct dso *dso)
 {
 	return RC_CHK_ACCESS(dso)->symtab_type;
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index f6a6f6a91030..16c2b03831f3 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -413,7 +413,7 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
 							__func__,
 							dso__symsrc_filename(dso),
 							debuglink);
-					zfree(&dso__symsrc_filename(dso));
+					dso__free_symsrc_filename(dso);
 				}
 				dso__set_symsrc_filename(dso, debuglink);
 			} else {
-- 
2.34.1


