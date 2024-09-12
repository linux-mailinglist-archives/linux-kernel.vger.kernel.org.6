Return-Path: <linux-kernel+bounces-326827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDF5976D76
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941281F2141A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B3C1BE22D;
	Thu, 12 Sep 2024 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVx/dzlS"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776A51BE227
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153972; cv=none; b=QLliniQnCiyDgDJq2wWhWByiZHx01dU6IJrLNwtefAPtUxcBcr7MHbGgLhD8rbbeSWRNulTq6BeNFfDGgdf0rrbD3uCUyp6ESqfGH6Me3sb94qllbDHnZQ4CeSAoGcbvLjDEpsILF3Ggq6xh2FILjDkozMhQ1MO74ggvnYPusEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153972; c=relaxed/simple;
	bh=Ent3NPYjQTNnHv+iKIcd7ubFUpZT8IyAhhOTjZikImk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y8er0h1+NmdBSx+U9Zju14yXHFUelcvhLJJ0Af/RUeHaVb7IsDfQHbyA1TQZoH7wU1jA6e5DYTLqgekTbWRPTzmsWjrb10DHHSHqdZ00rVPI8NdkiFoVbgD4sAEo+NzdEiWFQOJgwNt6MMF+CTc0YeRyqF8+FYiU3s5BJqfWwV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PVx/dzlS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso6905155e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726153969; x=1726758769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvd47gfary40B5CZwKU25bQw1FRFKdvBGhXDTC0MpmU=;
        b=PVx/dzlS6y6TEKgYPMrbB3c4pb5gnR9KN0ZVJc+S1kwwOmduIVRbLafck4XNSa8gMf
         jZWcSo+BHnnnVHjDyds25Ut6M6yIjCBDR2HuyK2idHZreJbeLoKLJtuxERriia7iPk75
         ST86mER2a7v1QiR52zqbbXKPhggYbm4h4oF7zhOwbWBguC7cHqJmEEOmFinbIPHCrwyi
         iDr7xbTlFkgYwY3IMzv/rswYrHhGPi03HKlr4vFDr1nH2xFELCiqocacHvDkXNWCphr3
         kvMXzeICpnkgB4c+jCCHmXCTE5nETTuKXoCgFt0rUGbBQTHe38ByaCEPuGCVSICaO5eU
         FeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153969; x=1726758769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvd47gfary40B5CZwKU25bQw1FRFKdvBGhXDTC0MpmU=;
        b=Q9xQxtMuCZPLHRqv2VDFUYbKEj54PU4ufaWmucucW51uGeVyxEvb4TSU3WeDlcG+FH
         +tea4PMtjEM90YJwUY01FWxHX0mxio99yfQ2b7l4bGtjUl22RF3Zz4LZegATOyw0s5bB
         4SwY6lTa+ZtoZTONUEpOGw4KVjJmEawofy/Gug+Mqn6XypXzKctKDQLIfREbAMAq26Dh
         RmodpDrAHxxprQc6ypR2IcJobY36fe4cilpTUxDzj1rnjivjbzKiQyzpLfTtOkxIzIOG
         IBk+AYxxwzTd/bMhUmhvM+LXxNL65pHXK1wT+27dxPtANMRARcaS5f914dykh8np3wUF
         mIkg==
X-Forwarded-Encrypted: i=1; AJvYcCXxbOZd3udKJSeDTSffEmvm73XxjJbu09U8pQ5E2qWrareRBbN+EyWTXlfr3Enq/tUbin7YNy14y4qFZMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF0fAVwYO27stu/Jq3CwsHKmxc6BIZIoGzoxl5dQbO7t40GRrC
	xweCZJMo8sAWknJdXuuzD/SmEt9eVCP9d8Y6Z7rJR1xgKAq2lcadf6QdVX910DQ=
X-Google-Smtp-Source: AGHT+IGXc5ywzLhmjTHKXlNIwnMTOMLrdQHiAdNlmIcNXtaF4leLAP0V2tpbvYPIKGpqX0pwKDC7nw==
X-Received: by 2002:a05:600c:3516:b0:42c:b7ae:4c97 with SMTP id 5b1f17b1804b1-42cbde1a867mr66142135e9.11.1726153968510;
        Thu, 12 Sep 2024 08:12:48 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb0dbcb6bsm171928845e9.30.2024.09.12.08.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:12:48 -0700 (PDT)
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
Subject: [PATCH v2 4/7] perf scripts python cs-etm: Update to use argparse
Date: Thu, 12 Sep 2024 16:11:35 +0100
Message-Id: <20240912151143.1264483-5-james.clark@linaro.org>
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


