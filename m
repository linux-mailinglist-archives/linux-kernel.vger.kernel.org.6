Return-Path: <linux-kernel+bounces-438097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1549E9CB9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF79166540
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6808815252D;
	Mon,  9 Dec 2024 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCr4t+Aa"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8F13AA2F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764367; cv=none; b=D2Pjl9ACnWc6SPWz/LqXtDRwVBWJibB4cw2M8okVMSzwDRChnKaIQAGD3em4E7Rm7Te44Zy52reoHyWURMLfpZw/FbLd3Wv078nnDC7plLnehPv3i0X7ngp8FoQRQNDz5Wanne2fXo/o09g5hYj+IJT45Z4zxd5rd6yvo58irl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764367; c=relaxed/simple;
	bh=u1pZFNB4IkXAp3g1I5XpeCyNXZT64f/PRCeyjr73mNI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z0qtpyULbWMocKNAi1A3dGQWWWlXE4a6gEgTus0sYNhuXo4/mCmGqS3nS03rM4B81D1P/B1bM2Mos0JoTCkXgfG3wObJViaIhe1Pfauec0q1qDA5NlAfNhO8Az1uqXFVSQaLGWRWEojSScSuVZybLY+fq8kIlJfYUIppClqk7Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aCr4t+Aa; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434fe0a8cceso6816035e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 09:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733764364; x=1734369164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=99R/pS+JOAF2fBIm3Oge6FcYNKCOWKCH/F0YLLRaqtY=;
        b=aCr4t+Aa81gz4opEH8+D79V4EACBWlFTBLxEPiMCDI15AyPVQGKWA6YEm14yZrUYhz
         eRMep7z3KhSuIFl3uwQnByYw5nGHJ4GJCB/DRtqw3fbmiY+JMevAhQRKJRc0pJIKNOnQ
         lMUrlYRuHWHejL8iFQkhk/Kr/vNkvKX7fGF5zz78Dy6qSutWOzMOKuH3CmC91ca45XDs
         bn/skrDh46J7E99mBV/NNOv6Wsaqg0uskrtBoQUEgvQPjKfE6udagP0d/aQxX9HYaKji
         ElqlDk15/Hb7fzQyQrdtZCVCJbh1tDelq5BO4x99jse3XilpFJtgJd4t0ztQ6E20gE4w
         uiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733764364; x=1734369164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99R/pS+JOAF2fBIm3Oge6FcYNKCOWKCH/F0YLLRaqtY=;
        b=GfKgmHDoCFRAV9bqWCdezDkbvj4HY3GxWZR/Vilr/ePaMnDpTrvDQ/nruY8+n27gGE
         SicPKNlao4zGRcGs9TDylX/OHMVK+WiGGh/VmzIiucdnTFTcTSa99/kYaB4NoiAvvkTs
         AFYETtOH4zZXXMVwJ5P/Z9HL2UYR7gGCWM7m+fZcLpAUXXPRUgcI4nVM1yBN39AsyEBm
         8KN7CEvAGNX3QaPldb7n1b9fnzEiduymx9hU4fwoe/ievnfJfuuzcl9sZFyfT9xxAIzA
         QcwquRJqM+odfKJahMKkIGlT+LuZd9bxo3qjr7u/K9dUcsh436TrfvvCp1OJspDVRrUa
         8YbA==
X-Forwarded-Encrypted: i=1; AJvYcCWvgEW+tBpfyKQfNAvd2Jrq24x8PPJvBI6mA27f2gtAs9AlgdrdHvkigQSDHmeLdJ1m01RWCQhSU7oYhd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/4EsK2UZZGcjcU2nrQEVDD19/uj3/2i8bIhIj/U9oAzXEr/D3
	voMBfF1RAY+C+2qUvzMdRwiR9dr/+VsT4KOLQD1gAmu01PrC04Vo/5ZhdPjAXvU=
X-Gm-Gg: ASbGncu1LcG7r9/QE7w33FhUPjk22UU/+1xfCpSeQkUbcMA5TzKoDSJrsl1+SUJY2A8
	ivcjJc7Fs1epftwXIoI4xPviZ1u+vfnDyZaMY9cPeeZNkuTS82zVrHbtaOuwunUKvmDZ1VFpYsJ
	zXVf4rVB2cYTMiaFe07zkzdKAzZEXWxhLKfiXEjJmOJsDKA7HSMZH6hD+kocMJZES7ZBkXaz4Ks
	PrTKBsrOZFPa8OMJZ9LNR4YkvP4ENCXEtyFD5n/k4iwMKN3Y90=
X-Google-Smtp-Source: AGHT+IFkm7jj1FED7ocAfVBJOa37YQ3hoNzBuxeY7ZjjgdEVyxL+f/RC6F5mPiRea/S8HR4ulr5jcg==
X-Received: by 2002:a05:6000:184d:b0:385:f89a:402e with SMTP id ffacd0b85a97d-3862b34e4cdmr8876460f8f.14.1733764364117;
        Mon, 09 Dec 2024 09:12:44 -0800 (PST)
Received: from pop-os.. ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862d7158c4sm10530816f8f.54.2024.12.09.09.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 09:12:43 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	acme@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Leo Yan <leo.yan@arm.com>,
	Dima Kogan <dima@secretsauce.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf probe: Fix uninitialized variable
Date: Mon,  9 Dec 2024 17:12:21 +0000
Message-Id: <20241209171222.1422577-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the linked fixes: commit, err is returned uninitialized due to the
removal of "return 0". Initialize err to fix it, and rename err to out
to avoid confusion because buf is still supposed to be freed in non
error cases.

This fixes the following intermittent test failure on release builds:

 $ perf test "testsuite_probe"
 ...
 -- [ FAIL ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -V bar (output regexp parsing)
 Regexp not found: \"Error: switch .+ cannot be used with switch .+\"
 ...

Fixes: 080e47b2a237 ("perf probe: Introduce quotation marks support")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/probe-event.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 6d51a4c98ad7..35af6570cf9b 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1370,7 +1370,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 {
 	char *buf = strdup(arg);
 	char *p;
-	int err;
+	int err = 0;
 
 	if (!buf)
 		return -ENOMEM;
@@ -1383,20 +1383,20 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 		if (p == buf) {
 			semantic_error("No file/function name in '%s'.\n", p);
 			err = -EINVAL;
-			goto err;
+			goto out;
 		}
 		*(p++) = '\0';
 
 		err = parse_line_num(&p, &lr->start, "start line");
 		if (err)
-			goto err;
+			goto out;
 
 		if (*p == '+' || *p == '-') {
 			const char c = *(p++);
 
 			err = parse_line_num(&p, &lr->end, "end line");
 			if (err)
-				goto err;
+				goto out;
 
 			if (c == '+') {
 				lr->end += lr->start;
@@ -1416,11 +1416,11 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 		if (lr->start > lr->end) {
 			semantic_error("Start line must be smaller"
 				       " than end line.\n");
-			goto err;
+			goto out;
 		}
 		if (*p != '\0') {
 			semantic_error("Tailing with invalid str '%s'.\n", p);
-			goto err;
+			goto out;
 		}
 	}
 
@@ -1431,7 +1431,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 			lr->file = strdup_esq(p);
 			if (lr->file == NULL) {
 				err = -ENOMEM;
-				goto err;
+				goto out;
 			}
 		}
 		if (*buf != '\0')
@@ -1439,7 +1439,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 		if (!lr->function && !lr->file) {
 			semantic_error("Only '@*' is not allowed.\n");
 			err = -EINVAL;
-			goto err;
+			goto out;
 		}
 	} else if (strpbrk_esq(buf, "/."))
 		lr->file = strdup_esq(buf);
@@ -1448,10 +1448,10 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 	else {	/* Invalid name */
 		semantic_error("'%s' is not a valid function name.\n", buf);
 		err = -EINVAL;
-		goto err;
+		goto out;
 	}
 
-err:
+out:
 	free(buf);
 	return err;
 }
-- 
2.34.1


