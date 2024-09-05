Return-Path: <linux-kernel+bounces-316873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F093196D66A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F46E1F24CEE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5137219924D;
	Thu,  5 Sep 2024 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9beb/pt"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A86B199248
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533493; cv=none; b=h0431bpH8Khd5PZZ2Ir6op/2FQkJxrd578ylZ4wreSQxpUwVdauk7wnjB0E8XSv9jfzMcBLJ2hNbisfmi1//7+UMc8cAelXuEzUNQbAI/i3AxoQ0NW+TAZis6+DqvzU1U9A9JbIFlh4Zf+WMbcv8apH3sqKd/aZQ6V13WKjWCRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533493; c=relaxed/simple;
	bh=Ent3NPYjQTNnHv+iKIcd7ubFUpZT8IyAhhOTjZikImk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wzlp4WMsmS3mORlCWnBVj71qWaX+pDM67xHm8WAgu1nVoA8g+0VzrzGlWP7lEwYqnhCk32EM20BJQfAXZKhplzZWII8GQn7X3TxOmpB7eh6lLup9vzD0FCE9t4y5nvxJokE7acIz7mOs873uS7W4Y73KTjqaJAJ5oeI23uaf9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z9beb/pt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so4662275e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725533490; x=1726138290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvd47gfary40B5CZwKU25bQw1FRFKdvBGhXDTC0MpmU=;
        b=Z9beb/ptpvgmM/HWB6IjBKc5lFMYGZRjJCLlvO6oh1UCy3cfyOEnOdaikBe4VdOiob
         dAM9VAW5RLiVGEL8hNsYWpjKOTXIzXQZtuX5/nMXKxasdfk8Mv5TGNYnJseutpgMULQr
         ok/dFRbQeeOjQHBTmuzrJCbuDJMkNsGXBvGX6TopadxjcqiHj0rwN8VjAkMPQtUcwV2C
         0Sx8l1WDSVhblXJouheFvd6a9agEiWLhfiJfnwej/6TSWZE4K3PV99QpWgI+UTFjcLrF
         ZNOaNECsgWJ445SlG7LS9BAJaIwm56zSDRbPk0y0VJxR6U0nNatCkvERZyF342gLY3oq
         y9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533490; x=1726138290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvd47gfary40B5CZwKU25bQw1FRFKdvBGhXDTC0MpmU=;
        b=vkN8QsUJe27krstyCnkrzB4DsqUB+zKlByil7UKuUBV4XbtaO+/LFR3ltgsVe4IzYM
         c1OJVqTYf4drE0AaB3jL2v//swuq23DMzCu/vfwaWYL93JeoVoO+mxzuNJdPmS6/ATD8
         Nv2ceXhkxqOBWqMA6Ok8eScBK/DypVTvYbeYnwuKMJBuFyzR3WqmWB05Nmos/VsQfEv9
         bhSXb8s+UA1HaIJybu8loigiN7I7l/Muyn3KyYJPRBVI8jmBN7LQNwBxFeNdVhB5CPrN
         J8Bt1WPouc4aCbi9SPNSnts2rNCUSHIlbB6q2u78SVabOcRC0MWsDq+MxXd3WDiUlYn/
         zNtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/xzMMZR7Qk/IE0FtZAruOe5PXRhKXwcQT2Dq8CBMwonRUSlRdXKie6TgUovmjl9tNnhGUA/CKy3y0QLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPywMkgHUCPmhR7vgvkiMnPwUMhyptgwlU/+mWCRCttc7IXi2
	IoNdW7GDtxqCjcmFwNmPvaIr8SAmIVasBMRsPq6/fF+TeDn3rSM+KvvoPKNg9+E=
X-Google-Smtp-Source: AGHT+IH/+XS62yXBkrtQXdlyQqjo3Bxww5IdiYqj0rBOSr4rHkxQrx9C9Aypty2rFMzvzq+ymudjxA==
X-Received: by 2002:a05:600c:4f4f:b0:426:6000:565a with SMTP id 5b1f17b1804b1-42c7b5a8ee2mr111733575e9.16.1725533489532;
        Thu, 05 Sep 2024 03:51:29 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0dbcsm231089965e9.17.2024.09.05.03.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:51:29 -0700 (PDT)
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
Subject: [PATCH 5/8] perf scripts python cs-etm: Update to use argparse
Date: Thu,  5 Sep 2024 11:50:36 +0100
Message-Id: <20240905105043.160225-6-james.clark@linaro.org>
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

optparse is deprecated and less flexible than argparse so update it.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../scripts/python/arm-cs-trace-disasm.py     | 28 +++++++------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 7aff02d84ffb..45f682a8b34d 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -11,7 +11,7 @@ import os
 from os import path
 import re
 from subprocess import *
-from optparse import OptionParser, make_option
+import argparse
 
 from perf_trace_context import perf_set_itrace_options, \
 	perf_sample_insn, perf_sample_srccode
@@ -28,19 +28,11 @@ from perf_trace_context import perf_set_itrace_options, \
 #  perf script -s scripts/python/arm-cs-trace-disasm.py
 
 # Command line parsing.
-option_list = [
-	# formatting options for the bottom entry of the stack
-	make_option("-k", "--vmlinux", dest="vmlinux_name",
-		    help="Set path to vmlinux file"),
-	make_option("-d", "--objdump", dest="objdump_name",
-		    help="Set path to objdump executable file"),
-	make_option("-v", "--verbose", dest="verbose",
-		    action="store_true", default=False,
-		    help="Enable debugging log")
-]
-
-parser = OptionParser(option_list=option_list)
-(options, args) = parser.parse_args()
+args = argparse.ArgumentParser()
+args.add_argument("-k", "--vmlinux", help="Set path to vmlinux file")
+args.add_argument("-d", "--objdump", help="Set path to objdump executable file"),
+args.add_argument("-v", "--verbose", action="store_true", help="Enable debugging log")
+options = args.parse_args()
 
 # Initialize global dicts and regular expression
 disasm_cache = dict()
@@ -65,8 +57,8 @@ def get_offset(perf_dict, field):
 
 def get_dso_file_path(dso_name, dso_build_id):
 	if (dso_name == "[kernel.kallsyms]" or dso_name == "vmlinux"):
-		if (options.vmlinux_name):
-			return options.vmlinux_name;
+		if (options.vmlinux):
+			return options.vmlinux;
 		else:
 			return dso_name
 
@@ -92,7 +84,7 @@ def read_disam(dso_fname, dso_start, start_addr, stop_addr):
 	else:
 		start_addr = start_addr - dso_start;
 		stop_addr = stop_addr - dso_start;
-		disasm = [ options.objdump_name, "-d", "-z",
+		disasm = [ options.objdump, "-d", "-z",
 			   "--start-address="+format(start_addr,"#x"),
 			   "--stop-address="+format(stop_addr,"#x") ]
 		disasm += [ dso_fname ]
@@ -256,7 +248,7 @@ def process_event(param_dict):
 		print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
 		return
 
-	if (options.objdump_name != None):
+	if (options.objdump != None):
 		# It doesn't need to decrease virtual memory offset for disassembly
 		# for kernel dso and executable file dso, so in this case we set
 		# vm_start to zero.
-- 
2.34.1


