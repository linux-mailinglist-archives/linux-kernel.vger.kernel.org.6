Return-Path: <linux-kernel+bounces-326828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC31B976D77
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA901C21939
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA871BE227;
	Thu, 12 Sep 2024 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q91+z1+b"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201C1BD51C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153979; cv=none; b=AvJgN3mypZ78FN2OL+UY1zNbGkJEyzRhq4y6StJVqp6AAa4Xi1HwwxR2wnRUR8pdz+gkUq3Vje/vtwfw3tPFes4/fiHjSBbnFvFMm3W8L9ZMc2YVP/y//k/jaGpHwUohYEXuyilvObGBXXsoWJgjF6F8niP0FL0TfKVx9s6WiuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153979; c=relaxed/simple;
	bh=bR690mMXw1GA2mO1jEEJOauZ9J/eD8W1OUd3Hv1VNaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ROYpuqwE/AlQSq3YO9+/h/qaOtJ7qA30tLJJH005MlEZxLd1Rrmm9C5Obi0mFsiSzO4n+TXeIUgJOZQYeboaCG9q2rWDd6tsigOrwN3xLLBqteZ4g+msFAgezA0ke0qX8gJuUvGmNb16yOeJUdiN07K1t3VIh0mNq7Vpq13L+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q91+z1+b; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5367ae52a01so1031453e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726153976; x=1726758776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UQpIycFZTbpTomhD0ThkQ/OGwgElG8NTd5wS8H1d7Y=;
        b=q91+z1+ba1auBukQsrVJ/V9Fjav32n6sVB4gWduRiJ4i6tGw8zUFOLAG+4EsvjGGrd
         YyZR3td5kqhiX+SrT3cCp6XurSuUrCUVHs99rAaUzcASxCzk0Qn1UMaCFxksHaarM+ph
         e/bvSMH0XiaLkxWVchGO2batFGVTCRbNzZEIJFCpcaeYqaRpUdW+2CAopzMe4+Bb1ZwQ
         bgrghFSON8kBg3c7CIv9K0fc62UI5q2vR/J0QTzcOxydOXKbTCB+7JvlnzFGbIat8Lrv
         oxz+4n6o0ljJiiIUHo7bwXK4cBZlEuEVutd7vis18hU+iCEyTvRhYHm+QwXlicZDNx3W
         EoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153976; x=1726758776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UQpIycFZTbpTomhD0ThkQ/OGwgElG8NTd5wS8H1d7Y=;
        b=htLfKYqTU5Iu/yST5GQ4PAZ+QCYuMu5OxaL0OsBc+ZVLw9Ia/Gc/UY+FRBRqhs3P4B
         zzTXT4bcDEtm8U32k057g8vVIE8ZMhL4Kyz37pmlLaVt1TIUK3rnJlyJ7hH7kcGBpvf9
         mLnzThKxRGHGcu3Mab3ajpWh3CxJ6sS9cAElAX2s4UqvZPqMpyH7bkaEph0BYzvKLFeG
         L5a6sFqluGmxKLAXVrm0oZniMO0igTNwcxHtJ5ugPtUy9/oAbJ6bWwyWc+HGWJfB2A8s
         fRdM7A0VRSSmwCkr0WUinpBFdjJquM7MaT5MC/Au7zz97QUHuE1U3L9o7NuhUH/7W3OY
         FeNg==
X-Forwarded-Encrypted: i=1; AJvYcCXk1OzsyBKK06PYhAiX8n30ESDhf8IBbEuEgQ41Cri2QN00YV0lPh94wA6mEFkqVKcaGCOG6gBwZwyB7uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIU5TbkCg1fj9vzTc6J0rwhQiMNagY8SeiDXo5HUYE839R8mff
	QPpfooNW78JM1ebbvcKD+TsJLUHKPZSloiPCUo8XjewqXXTBdWg4FfsPkT2KD4E=
X-Google-Smtp-Source: AGHT+IFgAMjvK9UCvsSa2ENtMA8fugJX5vUx4oGnluWZ4OiPoY/eCDU/q7/1d1etbgQS9qcJkbcEyg==
X-Received: by 2002:a05:6512:2256:b0:535:68ab:7fdd with SMTP id 2adb3069b0e04-53678fb7170mr2044442e87.19.1726153974955;
        Thu, 12 Sep 2024 08:12:54 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb0dbcb6bsm171928845e9.30.2024.09.12.08.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:12:54 -0700 (PDT)
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
Subject: [PATCH v2 5/7] perf scripts python cs-etm: Improve arguments
Date: Thu, 12 Sep 2024 16:11:36 +0100
Message-Id: <20240912151143.1264483-6-james.clark@linaro.org>
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

Make vmlinux detection automatic and use Perf's default objdump
when -d is specified. This will make it easier for a test to use the
script without having to provide arguments. And similarly for users.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../scripts/python/arm-cs-trace-disasm.py     | 63 ++++++++++++++++---
 1 file changed, 55 insertions(+), 8 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 45f682a8b34d..02e957d037ea 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -12,25 +12,48 @@ from os import path
 import re
 from subprocess import *
 import argparse
+import platform
 
-from perf_trace_context import perf_set_itrace_options, \
-	perf_sample_insn, perf_sample_srccode
+from perf_trace_context import perf_sample_srccode, perf_config_get
 
 # Below are some example commands for using this script.
+# Note a --kcore recording is required for accurate decode
+# due to the alternatives patching mechanism. However this
+# script only supports reading vmlinux for disassembly dump,
+# meaning that any patched instructions will appear
+# as unpatched, but the instruction ranges themselves will
+# be correct. In addition to this, source line info comes
+# from Perf, and when using kcore there is no debug info. The
+# following lists the supported features in each mode:
+#
+# +-----------+-----------------+------------------+------------------+
+# | Recording | Accurate decode | Source line dump | Disassembly dump |
+# +-----------+-----------------+------------------+------------------+
+# | --kcore   | yes             | no               | yes              |
+# | normal    | no              | yes              | yes              |
+# +-----------+-----------------+------------------+------------------+
+#
+# Output disassembly with objdump and auto detect vmlinux
+# (when running on same machine.)
+#  perf script -s scripts/python/arm-cs-trace-disasm.py -d
 #
-# Output disassembly with objdump:
-#  perf script -s scripts/python/arm-cs-trace-disasm.py \
-#		-- -d objdump -k path/to/vmlinux
 # Output disassembly with llvm-objdump:
 #  perf script -s scripts/python/arm-cs-trace-disasm.py \
 #		-- -d llvm-objdump-11 -k path/to/vmlinux
+#
 # Output only source line and symbols:
 #  perf script -s scripts/python/arm-cs-trace-disasm.py
 
+def default_objdump():
+	config = perf_config_get("annotate.objdump")
+	return config if config else "objdump"
+
 # Command line parsing.
 args = argparse.ArgumentParser()
-args.add_argument("-k", "--vmlinux", help="Set path to vmlinux file")
-args.add_argument("-d", "--objdump", help="Set path to objdump executable file"),
+args.add_argument("-k", "--vmlinux",
+		  help="Set path to vmlinux file. Omit to autodetect if running on same machine")
+args.add_argument("-d", "--objdump", nargs="?", const=default_objdump(),
+		  help="Show disassembly. Can also be used to change the objdump path"),
 args.add_argument("-v", "--verbose", action="store_true", help="Enable debugging log")
 options = args.parse_args()
 
@@ -45,6 +68,17 @@ glb_source_file_name	= None
 glb_line_number		= None
 glb_dso			= None
 
+kver = platform.release()
+vmlinux_paths = [
+	f"/usr/lib/debug/boot/vmlinux-{kver}.debug",
+	f"/usr/lib/debug/lib/modules/{kver}/vmlinux",
+	f"/lib/modules/{kver}/build/vmlinux",
+	f"/usr/lib/debug/boot/vmlinux-{kver}",
+	f"/boot/vmlinux-{kver}",
+	f"/boot/vmlinux",
+	f"vmlinux"
+]
+
 def get_optional(perf_dict, field):
        if field in perf_dict:
                return perf_dict[field]
@@ -55,12 +89,25 @@ def get_offset(perf_dict, field):
 		return "+%#x" % perf_dict[field]
 	return ""
 
+def find_vmlinux():
+	if hasattr(find_vmlinux, "path"):
+		return find_vmlinux.path
+
+	for v in vmlinux_paths:
+		if os.access(v, os.R_OK):
+			find_vmlinux.path = v
+			break
+	else:
+		find_vmlinux.path = None
+
+	return find_vmlinux.path
+
 def get_dso_file_path(dso_name, dso_build_id):
 	if (dso_name == "[kernel.kallsyms]" or dso_name == "vmlinux"):
 		if (options.vmlinux):
 			return options.vmlinux;
 		else:
-			return dso_name
+			return find_vmlinux() if find_vmlinux() else dso_name
 
 	if (dso_name == "[vdso]") :
 		append = "/vdso"
-- 
2.34.1


