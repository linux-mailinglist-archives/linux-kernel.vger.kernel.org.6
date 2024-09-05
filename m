Return-Path: <linux-kernel+bounces-316877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B4496D671
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C391C228C5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3FF19AD7D;
	Thu,  5 Sep 2024 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8cOHbRB"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9930199248
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533511; cv=none; b=fEk9SQDHi8GVdb30GmaKBzhvICELhnJEjuiPZqM3Hgjb3ruj9m/lprnTr3BreOZJ9IvhIzaiyN3rXIuF8Tn/zc2B6Kt8L/Z36pMox9ZTKhWOt15Wu685xz2r0w97zjTNOarqeNmYB0qmdvkgcD7/fq7wJt0Gjmj45Iq2lrsGuT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533511; c=relaxed/simple;
	bh=x8bv8lif16GzTLpb0Qa7Ebuoe1yqdxh/JFp2faINf78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ROZ/iI6U/w/07rTETwSEdwgtVY93TP0bWc8WLcohvLTfzazcrEBcgHr5mC2OSwqWpz+KT0LAp2IgHUI2mFw3CqkVVjfRoVs1PvJ3IcLRR+Rnyp1eH9gUSgrfpwiaJl6r2lwcbkCnVyj9gtqsaR9Jp5YLHbWscEVbphuLeWT4yHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R8cOHbRB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42bc19e94bdso4676975e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725533508; x=1726138308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnGEReYZbV5wa8QJ65oYyeLT0QeGyCwvGtl5g2ahPgo=;
        b=R8cOHbRBI+ktZkgHiUCX/xKeLQnit8awp1pzVUQgP5jjp5bLxxnA0h3fu6e3LZsBRG
         OjmeCWEFNF8AOEz1wftkuyIVbFdPZ3pyUneNlseKC0ec9IUa2mN6kb6Di8G+3GyjqN2J
         PBVtG3vbU4ySClIPJF11ldLeAWAvZMgk1e+MbvMu5693VnLLkuf1QpWdgnXkB0KhecPo
         u2LOxj8C48y609f/uF1sPN/x7OHQvcYHs4gYZmuOCbEGG9Y/2FB/SkqqKKtSOSocVKCD
         I6OQ1LF75w+plwEwNWhUiFKLR6SGHYRG650MMPeKpVIvOjDxFcmo2Gjct0ZjwR+pGeOy
         B0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533508; x=1726138308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnGEReYZbV5wa8QJ65oYyeLT0QeGyCwvGtl5g2ahPgo=;
        b=cZSUeTQynfJh0ZqcKTXERQ48xZ28jS9VYzkxiq4VCVBvn2qGydbjPID5pjcVn9WpdE
         QznsZYT/NtsBSSlFp+yQuDFMuLUTHYygr0AATWTw2N/XEPOtjg2L3NCXnlixKdSvnjG5
         /7gay8vW6ksU+kUepgKsSBYw0+yteCrLfV1AQJhw1TJTNzacdhweqmVuM0oPtupBl3G8
         oW79M/Ru4Aez3jcT8u+O8c+goOxP4lKKZg8fol6/ScM5zDZ/ZK9171jmbMFYq6vg0q5m
         og3LpAEgK3giS3fY9PhNzGJ9URJe71KoK6FN8U3D7f1dpMilv9OvneoV9K8Qikiq3lOz
         6woA==
X-Forwarded-Encrypted: i=1; AJvYcCV79G7RzNC4EEnvEJiKiaW0lTWQ4GgiNuTEF+r5Gep3vUTV5fixg9oxE6xsagK98B+8th8dx7RWmKwgYk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdEDeyyEPP2eIm5UPmX+okc2U9L/7A3PBjwLbRRF3uXhcIK412
	A9z7fANSzthCUrJdjv6PvfJKsMjB7LCdG3K0mgIi40A87tAo1Zg/7qF/iE8t4DI=
X-Google-Smtp-Source: AGHT+IFLXh3uz6cqXjbXRFB+ADKQOX2EZTgrK+sgT0hn+8Lnw3zLZAPRZF6rIycBh6dNiFzAE5OxVA==
X-Received: by 2002:a05:600c:b4b:b0:42c:9999:4fb3 with SMTP id 5b1f17b1804b1-42c999952dcmr18219615e9.34.1725533508196;
        Thu, 05 Sep 2024 03:51:48 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0dbcsm231089965e9.17.2024.09.05.03.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:51:47 -0700 (PDT)
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
Subject: [PATCH 8/8] perf test: cs-etm: Test Coresight disassembly script
Date: Thu,  5 Sep 2024 11:50:39 +0100
Message-Id: <20240905105043.160225-9-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905105043.160225-1-james.clark@linaro.org>
References: <20240905105043.160225-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Run a few samples through the disassembly script and check to see that
at least one branch instruction is printed.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../tests/shell/test_arm_coresight_disasm.sh  | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_arm_coresight_disasm.sh

diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
new file mode 100755
index 000000000000..6d004bf29f80
--- /dev/null
+++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+# Check Arm CoreSight disassembly script completes without errors
+# SPDX-License-Identifier: GPL-2.0
+
+# The disassembly script reconstructs ranges of instructions and gives these to objdump to
+# decode. objdump doesn't like ranges that go backwards, but these are a good indication
+# that decoding has gone wrong either in OpenCSD, Perf or in the range reconstruction in
+# the script. Test all 3 parts are working correctly by running the script.
+
+skip_if_no_cs_etm_event() {
+	perf list | grep -q 'cs_etm//' && return 0
+
+	# cs_etm event doesn't exist
+	return 2
+}
+
+skip_if_no_cs_etm_event || exit 2
+
+# Assume an error unless we reach the very end
+set -e
+glb_err=1
+
+perfdata_dir=$(mktemp -d /tmp/__perf_test.perf.data.XXXXX)
+perfdata=${perfdata_dir}/perf.data
+file=$(mktemp /tmp/temporary_file.XXXXX)
+
+cleanup_files()
+{
+	set +e
+	rm -rf ${perfdata_dir}
+	rm -f ${file}
+	trap - EXIT TERM INT
+	exit $glb_err
+}
+
+trap cleanup_files EXIT TERM INT
+
+# Ranges start and end on branches, so check for some likely branch instructions
+sep="\s\|\s"
+branch_search="\sbl${sep}b${sep}b.ne${sep}b.eq${sep}cbz\s"
+
+## Test kernel ##
+if [ -e /proc/kcore ]; then
+	echo "Testing kernel disassembly"
+	perf record -o ${perfdata} -e cs_etm//k --kcore -- touch $file > /dev/null 2>&1
+	perf script -i ${perfdata} -s python:tools/perf/scripts/python/arm-cs-trace-disasm.py -- \
+		-d --stop-sample=30 2> /dev/null > ${file}
+	grep -q -e ${branch_search} ${file}
+	echo "Found kernel branches"
+else
+	# kcore is required for correct kernel decode due to runtime code patching
+	echo "No kcore, skipping kernel test"
+fi
+
+## Test user ##
+echo "Testing userspace disassembly"
+perf record -o ${perfdata} -e cs_etm//u -- touch $file > /dev/null 2>&1
+perf script -i ${perfdata} -s python:tools/perf/scripts/python/arm-cs-trace-disasm.py -- \
+	-d --stop-sample=30 2> /dev/null > ${file}
+grep -q -e ${branch_search} ${file}
+echo "Found userspace branches"
+
+glb_err=0
-- 
2.34.1


