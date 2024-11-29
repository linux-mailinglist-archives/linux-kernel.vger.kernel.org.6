Return-Path: <linux-kernel+bounces-425697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A8D9DE939
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D775F162842
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99A213D62B;
	Fri, 29 Nov 2024 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NtoKqj7q"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9930D5A4D5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732893610; cv=none; b=mpA1pwxblCXxtkyOIVO5S/d6u/vdQC45+AddgP5SD+LKDrbVdJKpTREyufzHf2j2mbU7uzBkVfgRpYKPo4qn0+ziMK0nMd6MiU4MQVE3vtdDStlTFA5tTlaMwFJfu5wCIJcO8gIlQ7CkmtsBfsnGnAkZybMwkb6BTRsYDIauE2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732893610; c=relaxed/simple;
	bh=WMiXG5UVLxQ7dqT7HRmR1LceAv7KVX8HDMx2h/1cXvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sV4xdFhC07xgZVYh3VvyzJvcS9zFW2hcvp0sjSlrpNvhRbjLPGaljMJQ/jR09AvmJRKvjAPLmyF60ZYbW8pvilxK23FMagjipHSZYVhSvGw1tO4d9r2RaP03hw+yksWcKFoDWOg62XoYK9IHV53K1rKQ7HceBCXNRcwG6zhKBAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NtoKqj7q; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a68480164so243106766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732893607; x=1733498407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8GWdrWt2EBhjvzgV2YI8PlXuX9R1pC2cNExx3nRNDE=;
        b=NtoKqj7qpLjDL4qsX4lVrg3JKnGLjOtZTujq6f9SftdrR8ieJtNr46aE24LwZOf0ij
         tv8KCX+Uz/Hec9Cl94QCHtE90XCLLvXWzYufiZX/FwD0nFSN72HtXWp0yAGHlBtD9wOe
         J3Rnf6Jr6tEl0/eWPqV3HSrMcYPzN6gwUjkng5+OiHP87gHcipSbbSK+OYfwz9U/V1z9
         UeROEQY2jMvpysCkahubbtu60k2ayHvohl3Sm1cezmrVfyFto0/mHPFzVyxsgYowsLUt
         JU4nMhqkswPeRyCA1DNylnUxOgvK1vkQ0cdWTmqbvzVoYL32hjuzYu1+DRQdnwtMfJIP
         5Ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732893607; x=1733498407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8GWdrWt2EBhjvzgV2YI8PlXuX9R1pC2cNExx3nRNDE=;
        b=WNRyHr/zhsHWRDMG+wByuKiX+P74ArnNPEry/Dqs0BbXDJhGpIQa2L7CsgVK0VNXE8
         bqCy9kBSnIhWkhkfE2Z0pSne0STbThEBZP84KI5DJGT2sh9pKgb5qWWpF/DQy4R/qmeF
         +3fC5EnXvCdFgBVmfdr+WuiRukSuW1h+iX5XOxS5HZVl2wpykH1Y2D3cAQXbo0qc7/e/
         HV6eNF15FG6553tN/bdTu47qmyoUMLiW7GXeDtt7s43grIhbk87vpcg3+OW90pqkrqzw
         H+v07/kkjgYBO+N/HVSEbP6ccZqYIGaD1Td7AP7VITR3up4yXX7gf90d266BUmZgvHHS
         tbpg==
X-Forwarded-Encrypted: i=1; AJvYcCVCnHbvs9O4vXaVFKo8PXmlIEvQtURXfQQOs5B4PbjNDsZkcWioxrPjgqpTE6wDrIm2h67zl2TVtspcRJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX7lqNGithklRc+LZx/QIthK+fBRl2bslcVs1d4Kx4CGcW25xc
	bzfAHp3P39fqNS3RE/sSDi+hpc3llsf04gEXRpj+5odW8HFBmZ6ygno3f4p/O0k=
X-Gm-Gg: ASbGncvdYEQQFGr7cS4XJDCvuIVqTmih/SqOEi93vjdx+xK03WUE9EenBEGihC8Q8Ay
	SHIj0QqBi5qyQSKWI2Q9hnj5l9VQXFpCODhsc2vH6S+hHvcVbmPfaFdGbMSUibjq/QaMhzYSxMh
	+xJDKEUlxVxHbFMJXuvgxHpI1LOUrGxv1ILOjSjMY1aZjvvvuBamkPkwpm+nKN1MAyVPVHh8cFH
	pnMzKvVfoYhM9VLV5Nx7MJWlyIcTsD5xK3yehnRrj4sE9selA==
X-Google-Smtp-Source: AGHT+IGbDhuF1WYnayVyw4OBx+CK4b3YOmGGAp/ufEmQBQ6AfLGaToXTkRv1wBm7KZ5DSaVS8tWrSA==
X-Received: by 2002:a17:906:18b1:b0:aa5:3f53:ad53 with SMTP id a640c23a62f3a-aa580f6aec8mr880140066b.26.1732893606566;
        Fri, 29 Nov 2024 07:20:06 -0800 (PST)
Received: from pop-os.. ([145.224.90.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d4101sm182260966b.73.2024.11.29.07.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:20:06 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf test: Don't signal all processes on system when interrupting tests
Date: Fri, 29 Nov 2024 15:19:48 +0000
Message-Id: <20241129151948.3199732-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This signal handler loops over all tests on ctrl-C, but it's active
while the test list is being constructed. process.pid is 0, then -1,
then finally set to the child pid on fork. If the Ctrl-C is received
during this point a kill(-1, SIGINT) can be sent which affects all
processes.

Make sure the child has forked first before forwarding the signal. This
can be reproduced with ctrl-C immediately after launching perf test
which terminates the ssh connection.

Fixes: 553d5efeb341 ("perf test: Add a signal handler to kill forked child processes")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/builtin-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 8dcf74d3c0a3..4751dd3c6f67 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -508,7 +508,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 		for (size_t x = 0; x < num_tests; x++) {
 			struct child_test *child_test = child_tests[x];
 
-			if (!child_test)
+			if (!child_test || child_test->process.pid <= 0)
 				continue;
 
 			pr_debug3("Killing %d pid %d\n",
-- 
2.34.1


