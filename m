Return-Path: <linux-kernel+bounces-326831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B64976D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22C71F2453B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4381BE851;
	Thu, 12 Sep 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="psNuG9lt"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EFC1BC9ED
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153993; cv=none; b=N39zeg5gwdGp4wkV5brtKwbCYfZSlXAmydbuVM7ylDzrS0ktjIiyb72CqvhhkuHw6Rmio+VdnDLw9pjVs6kCiM/oBYJqgtjNGv2cM/vd90Z7RL5IjG9fjotshKTEzvThTRrSY8EvL7eMzsHlUMC5vupzW0V0BZuCibZUZL0+FIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153993; c=relaxed/simple;
	bh=x8bv8lif16GzTLpb0Qa7Ebuoe1yqdxh/JFp2faINf78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F7nF4AhY+RdDiBfmhQOb/cOYUl29LI1jOWAUlS7xNeDYlTgsr1lGxIfQzu7EjkBqncUjZNqVwFohbBYcYUd6tqKMBHkJ1CO7tl6arUZDFN+Uhy+ZulMcQkdkb/CjcocifO4xSYzWJxnZctLZWr0RyzYge8KbmTcDUpNcBaHen50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=psNuG9lt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cc8782869so10258715e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726153988; x=1726758788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnGEReYZbV5wa8QJ65oYyeLT0QeGyCwvGtl5g2ahPgo=;
        b=psNuG9lt/LcjzWW5r2j927onbXcIwEdTT8gYoPR3YpUPkc5z6MxWpR0hXNkJwgka1z
         Zhg3ZeEAXyUgnWZjax/vr2Ufz4UdUcv+T8fROmCj7VwIPrqKu5WD2q16wF0Cst2mB2kd
         3V0LXBRnhsmVr4uvfl37UCbggZVRRXSm8nWgGJ648VNfV89RupaH1OOhhPZQ4beOVYBH
         N+wuuqt6r8AQLZW3e4gk7GGE07DEWI/OPifxdBRKPORCRPNS/+NOsP367BsNbH+i0KMy
         t1JwJw7aT3wYBIKqT95GzZ2C7IJ06s/5CVzOM/3T+YKgkxwjNce7yB1xHrBpnTGXkE4d
         0n5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153988; x=1726758788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnGEReYZbV5wa8QJ65oYyeLT0QeGyCwvGtl5g2ahPgo=;
        b=OE3AOphoiik61JNdfhFRZ8OIdYBsXFmcF3G+ptxMTaf8g/CJ3oyCK0q7VLDfktcBcm
         CDPsFYFHpLtllL2abHTP0aZyHs/wYdx5Ud3jxyoJQqf/k7yyXqV7SJkpk2cLdGC747nS
         7kwvb/A4Eg5Q9dGhB0c7oFwXAV34HfbqGIickN+7o7cP9B9ezYcgV0rPzqrxDGfHVx4/
         Uvbk5knITBpS9P5UDpVUHAirhwj5xxBhRXHYBSNXc53ZAlnemkAclGWxTGjHpOiKtRXe
         bSsTUnatKXQJGM8FN+Yy0jV9o8vjx+F59q1iTS45H+tp14yRROId6daJ7hQOwp80PW9M
         u6gg==
X-Forwarded-Encrypted: i=1; AJvYcCV48VI1Psw5hoh/z5Of/8kOOGJOCxi0sj6r5k82PkSFxoddw65/H7LSVfIn6WkSKGewKWENSuvonOi1Neg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwJgCiUaPkYEjGhxYQTWCWDDpRjbHrfuWFwwFiPjCl0paL+Bo9
	+Fi2NW7XL4F83XubwIo9ZT+F3fVotAbAlKCwGpuS5SVbDI+9rknFiXOcLbs6bGo=
X-Google-Smtp-Source: AGHT+IGEre2u3si5izHKSVRnSaDHslzroiOmPSj+IMte3J2/T8vsKx8fqveYcxg7jVPpnaPL6vVMvQ==
X-Received: by 2002:a05:600c:19c8:b0:42c:b187:bde9 with SMTP id 5b1f17b1804b1-42cdb579f3cmr26940435e9.30.1726153987871;
        Thu, 12 Sep 2024 08:13:07 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb0dbcb6bsm171928845e9.30.2024.09.12.08.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:13:07 -0700 (PDT)
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
Subject: [PATCH v2 7/7] perf test: cs-etm: Test Coresight disassembly script
Date: Thu, 12 Sep 2024 16:11:38 +0100
Message-Id: <20240912151143.1264483-8-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912151143.1264483-1-james.clark@linaro.org>
References: <20240912151143.1264483-1-james.clark@linaro.org>
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


