Return-Path: <linux-kernel+bounces-316874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C685296D66B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD8C1C22E01
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E757E1990DD;
	Thu,  5 Sep 2024 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LeVvEAkf"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4FE199248
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533499; cv=none; b=UbOGCvawKTLzLxF7BV9BZdEgPEmrY5uAvZFCglNJ0QjzbdLK2EeB7xIAh3mPgnxC4A5m1eCbgfd4ZfrHUFTtLMhvV6wH8ywu47tprZrdUgVcbySuxIiIMv8JASJHzDBeo+P7lzb6259HPLRnoxKvLa7nugs9K/fktb2Lw8d9mBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533499; c=relaxed/simple;
	bh=bR690mMXw1GA2mO1jEEJOauZ9J/eD8W1OUd3Hv1VNaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hQDxhmhCUX8mxpkXkQJ7pnli7YWr7Rayxbh865pX0ltIKTuTOLl5n5+PnCjKWexLz6ooVf/CthzL+CMfFHJ1O1Rq/03n3j+2f9WXFsWAwAgXNEgvxnpHx8ELZMEJQfKLI6FFO6IJuG4j+uOAsB8IsVXRJXXwBujflcK9gmHkoo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LeVvEAkf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42bbd0a40faso5434915e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725533496; x=1726138296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UQpIycFZTbpTomhD0ThkQ/OGwgElG8NTd5wS8H1d7Y=;
        b=LeVvEAkfvO41ofNgejm4iJEtD2v8xlURx8FEfwZ3kKghjyinQ5dGgAcEa9UijO8yQN
         pUc2LKVZZ9PEek2WYc9ypv6vnNb75LqsYHhZhw50kSl7dTzYWXamessDbk9dVG1PN7bs
         nWRwM2olGrlMrQQZeWA6bgTChrzTRoyjis6hOK9UVcR44PfejP8cR1/qlR06+aRghI3b
         mOTYU30Gok2fax0zhui1GQzmpf69i3qzXIIwB9h85oM7GoRReKh/P/uPGdCv4D/BTWLc
         YkcULgxvEeGQS4H43WL3vrmiFPdQB4tYQtiGGni9xWBjcIjfMvWzsWY9V0Oe7W+qpT/g
         Li2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533496; x=1726138296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UQpIycFZTbpTomhD0ThkQ/OGwgElG8NTd5wS8H1d7Y=;
        b=BiKdN55PJZcWGhh8noEPlY+sw6vhJQSzq1NsdGRkNht92ZUONREtMoLtztuD/e3WXb
         zK65PXoOZ+zfVlOzOGy220W2TBlpSXYB9jAlQeFX0rqJ+obxc/kuEEiTckkhnjB1RR91
         +10UBxXM2ctELIdQ6kN4oMHZfDZ1B0cp+yuFtt/zxvBMkxdp9/EtcJK2QAhDPD81VMUB
         UCm1o3TGcmG2TBeO8UjAMdMI5WrFHKUFDr+cb9lgWolCx9Gr5ZWfBxtDCvPDsrd0mo4w
         sy+XLUwa5GBcsnFB0Zo8dIZ9Hve0eThgYPmr2wjGobtyXJBEs7CZbjcDH7g4KTF6sbT/
         5grQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj+v5A8wJaiazYNteT+fZVSMXfLm4/835CxFR0feSvI05fTknsKIzf1Nn6Wk1NlsGw0BSH/tDK+4WSYww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzguxjWRIB/wqFq7+vM81sX+LLbg5PwH8onn391RR1W4IzaElSh
	C6jIs3mH6cWT6oRiTW5qpIYjJKKoCy45jDdpiB6ZM8x0pfpCgHGHlP+/DvuVZQ0=
X-Google-Smtp-Source: AGHT+IEpfxBxgTLRhNXbNPhyw43kJddfslQaOh/lWQNdxGiZ7XJq9Wynx2djlTu5N/y0tXW9TP/TcQ==
X-Received: by 2002:a5d:6b8d:0:b0:374:bf62:bc91 with SMTP id ffacd0b85a97d-374ecc8f283mr6307799f8f.25.1725533495732;
        Thu, 05 Sep 2024 03:51:35 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0dbcsm231089965e9.17.2024.09.05.03.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:51:35 -0700 (PDT)
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
Subject: [PATCH 6/8] perf scripts python cs-etm: Improve arguments
Date: Thu,  5 Sep 2024 11:50:37 +0100
Message-Id: <20240905105043.160225-7-james.clark@linaro.org>
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


