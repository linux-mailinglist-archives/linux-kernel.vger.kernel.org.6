Return-Path: <linux-kernel+bounces-330745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F96197A3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A8D1F28319
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3C7194083;
	Mon, 16 Sep 2024 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IAKisCmk"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59F415ADB8
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495133; cv=none; b=FtKrIsEgwIRukk0bsnHvuxnKtN4/6D8ssJh/IfhL55eGj0gHdhncWmTq9DuVGsjpsdCUlH5bucgwEV3TI0YFc3pPDcRxLwqGsuysgn6ihaUyTrUT9RNtxwStIYGbZShZsAcWA4EG6zuQjx9SSprRgJphN6lk1HOKI9xUYjhFHYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495133; c=relaxed/simple;
	bh=bVkb9Wm6MnZrus/WrNLvL0MJT/HE5RVP/22d/aiAs40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IuuNdPG2GhmzQom94aV2uWtBs0L8NfyGJTVLUB5xd6z4Q7haiFkwccNSofHA3q2a7RNf6x6f5dVoJBXkyJjBjXngRdZX4qjYkKpdw4fzHIMQR31TN1oc/7D1etuVYpe3g8BV0DnvEO2ECE/ZA7dE1wFNu6Be11zS58rqX+KcaQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IAKisCmk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so26662495e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726495130; x=1727099930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQSiMvQctmr2VbpvZ7u0ZKPRwr2TQbe0lgGJUjSaHZ0=;
        b=IAKisCmkI6ef90IbnPr006ECpc03SsIfM1cRWs/0vfQD52qYJVCfw04b4QQhx/A8n2
         jv+tFQepRDok6+rP6adaXkVrOaNwT7aB7AR5YwvzQzDldUj2GZR/Iw8B6C5WBrgNP/aD
         +ocO3VhhBtK8IpkgKKajwEOZNufNpEtf/nZ40j7yILJ8P39vzPd5lvA0P+ui7V0OkoSl
         FQElDsrTEj7R9X9+s8XtgIX4VfLaWpO7uMTZkm8YFxWpwCaMOTDBvJu3C46Qvs7IucWo
         H6ha0h26QKRwpzIxAde/sgnSMPpBelwj8oW6dh8FidhmvZ/w6uNeZ73ELZmWWOLSJv9t
         K4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495130; x=1727099930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQSiMvQctmr2VbpvZ7u0ZKPRwr2TQbe0lgGJUjSaHZ0=;
        b=APOhgNkLn3a+duiiOtHB2gpncAsxa9fEob/rT+OCxOkYL0fwOzycMn2LXeNzKKAzBu
         76KvZaxWmVtPaqH1NbgVvgSvzDdApv5R4zl/EaRsE5zqAhNywLoOvW6Iq8f/0vRRmqIA
         kkLhAK80kVqmVbjcaa/BQ5IeKK12ENRyAGFM3yV5KIQ2Qg55GV+cnjiRHGsOu+ewfkX8
         YsLUFxgd6VkLA9QP71UffMZdB2K+QULigCo06IvK+lPj01Xx4Zqaq2pntW5uVEGrcQD2
         wFu1N9laL7wF8Jpg1ar7izkzzlYE13791w+0a18ggLvX9NfWkKxsKSu7BwTSHPybXwYU
         zm6A==
X-Forwarded-Encrypted: i=1; AJvYcCVNVuTewkYZ6Xnk5J5j7eirj8ftKO69fdQIbs+Y6TQbwPYkiEgn7Jd24vg4wVRzrNAe1kx6QOiHjBa/8pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7a1qqgVaCwdtkMJZ9KDFLphkD0yi/o33UuarxWTf+j1WyMuF
	eNyhywUEx7tf3P5NA9cotV+DQQp2WYfzqgfsw2NmP1iHwlScll5kLteG5zTX48Y=
X-Google-Smtp-Source: AGHT+IE63Rq5/cOxy2xm9RDFbt82etcAarWy5LN2E8qI6q5tX0ZkjrRI0pxkuOxkKIyNRSiiiK0lrw==
X-Received: by 2002:a05:600c:1c29:b0:42c:ba0d:c766 with SMTP id 5b1f17b1804b1-42d9070a5e1mr83851605e9.6.1726495128349;
        Mon, 16 Sep 2024 06:58:48 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm7285098f8f.49.2024.09.16.06.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 06:58:48 -0700 (PDT)
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
Subject: [PATCH v3 5/7] perf scripts python cs-etm: Improve arguments
Date: Mon, 16 Sep 2024 14:57:36 +0100
Message-Id: <20240916135743.1490403-6-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916135743.1490403-1-james.clark@linaro.org>
References: <20240916135743.1490403-1-james.clark@linaro.org>
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

Reviewed-by: Leo Yan <leo.yan@arm.com>
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


