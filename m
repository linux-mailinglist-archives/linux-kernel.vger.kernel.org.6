Return-Path: <linux-kernel+bounces-330746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2CF97A3B2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF1D5B26B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126E9158548;
	Mon, 16 Sep 2024 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkoBby1/"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE7B1940BE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495140; cv=none; b=aFTuTWhm9Up6V+fSFASVU8qErkdheDc7Tw1J2HG8fX+SdkrRr75XsFlmW6Z2w279VWjhuAmmpmH0YtdRnDSHBEjK2WmaoKuR5I/dZGUy5B2/j/+jxTrcy9IlFfqc1fJHQKrime8KbKhCbsTDyvsnNwXleDMaHqWNHMhidJ4lRUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495140; c=relaxed/simple;
	bh=vdLgIo8GePp53xw04KnAQCJh5F4oiBViPbxwtI67iKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e3WfdPUZHb03ePCLp2/u03cJXlVKEgFUWCiqtmcI7NhdFRYyHZzU9c+ef/WuiB234WRYeu1pGSBit5hiRowW1g5vSM5rDU1MdfLbcVXgNuSUuGZ+uDTgDgNJw5a5EVkU1tg6Tfska0IvfkWMlo2lfw41GZLcLzJXopyIZYW48ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EkoBby1/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c7e64b60so2685711f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726495135; x=1727099935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AtH/7E9TP7UM5eLIlL+QC7O7RdXR/ljZ9YaSiv2f5A=;
        b=EkoBby1/YraoUcAQyMtJSNzAqzq+a9n+Icc4U5LlfHmDHRyzquT15WBT16uD4nUwUw
         /bE/kwGv001Q0CbpiArwV9dsqWJKv+mzN7PcvFTLPhjp7srShEgpunlU9Scxy5xoMxuM
         0UEw93nvowNhUdy4rsrJEbIjIzXgP6vDSLDIIefnbEwabgFp98Y7W1CyNQbRMnBwb1oM
         SxOlCi1nwNY93hYI4UcttC+B1oENgVC7KzDkNpRlQW5N1aMcta/aDrVw356xYnmy5eY7
         JnundSiLAbSfOTzScGJh4jPWYAEIEe1oKWwerPkbZ54eIRlr099ZGF2HBTdJ2H9VF9s0
         JFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495135; x=1727099935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AtH/7E9TP7UM5eLIlL+QC7O7RdXR/ljZ9YaSiv2f5A=;
        b=GzdhzJwAEnE0DZsjqld0SQXh0CZWNt9dYx+EEJLbJf8Y/gc47D7IAlkU5hDPpSMAme
         98j1s7oCcFOvhZMi0amfaWC5TD+lSefNVwxWNya9lDFPwdo4Ad4Xah1VmIzKdQtdUhtd
         X8dPs8zhY6PK2AauG8J6EVojd5MP1JiFrd+CmonDiGgMvatMzTU5i2IP5ELX3n063aNW
         BLFt0oLbaXqPWmXSoe9HlwmfWQXy+CHbDUKY27L2t3eu0I2T2rvNIAG0HVl1JQfo185x
         ZHBqLax4lIaHy3xDSjclsq2Q5/6zPaEaSNLfcMW8m0957CcklSzFcweiYSFDQgdRsKZZ
         LEMw==
X-Forwarded-Encrypted: i=1; AJvYcCVnaqcbry/Ggz9ovYABdt2GVny77TtKVsQMzPbDGV0Z2jyERHSUYeu906ZbhbTAuN0A4C2GW4NrckgZoT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+oxrYbmLECvcIjVZ4arvpZZGVZfh0NwmtWfin1ULOzw4vnLk
	aBbNRAcvR2oTjAulCDrmbENVe4lw12dRalIcK1T/55tkN6TfiXy4rj00Fj8GgJw=
X-Google-Smtp-Source: AGHT+IFAvOSLEn39dzXSrkked00cRci732/juuGdGaJTRnvElRy5+8Op6OR+biwvTP1c/MW380IWUw==
X-Received: by 2002:adf:e7d1:0:b0:375:c4c7:c7ac with SMTP id ffacd0b85a97d-378c2d6165amr7924044f8f.49.1726495135275;
        Mon, 16 Sep 2024 06:58:55 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm7285098f8f.49.2024.09.16.06.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 06:58:54 -0700 (PDT)
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
Subject: [PATCH v3 6/7] perf scripts python cs-etm: Add start and stop arguments
Date: Mon, 16 Sep 2024 14:57:37 +0100
Message-Id: <20240916135743.1490403-7-james.clark@linaro.org>
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

Make it possible to only disassemble a range of timestamps or sample
indexes. This will be used by the test to limit the runtime, but it's
also useful for users.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../scripts/python/arm-cs-trace-disasm.py     | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 02e957d037ea..1128d259b4f4 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -49,13 +49,36 @@ def default_objdump():
 	return config if config else "objdump"
 
 # Command line parsing.
+def int_arg(v):
+	v = int(v)
+	if v < 0:
+		raise argparse.ArgumentTypeError("Argument must be a positive integer")
+	return v
+
 args = argparse.ArgumentParser()
 args.add_argument("-k", "--vmlinux",
 		  help="Set path to vmlinux file. Omit to autodetect if running on same machine")
 args.add_argument("-d", "--objdump", nargs="?", const=default_objdump(),
 		  help="Show disassembly. Can also be used to change the objdump path"),
 args.add_argument("-v", "--verbose", action="store_true", help="Enable debugging log")
+args.add_argument("--start-time", type=int_arg, help="Monotonic clock time of sample to start from. "
+		  "See 'time' field on samples in -v mode.")
+args.add_argument("--stop-time", type=int_arg, help="Monotonic clock time of sample to stop at. "
+		  "See 'time' field on samples in -v mode.")
+args.add_argument("--start-sample", type=int_arg, help="Index of sample to start from. "
+		  "See 'index' field on samples in -v mode.")
+args.add_argument("--stop-sample", type=int_arg, help="Index of sample to stop at. "
+		  "See 'index' field on samples in -v mode.")
+
 options = args.parse_args()
+if (options.start_time and options.stop_time and
+    options.start_time >= options.stop_time):
+	print("--start-time must less than --stop-time")
+	exit(2)
+if (options.start_sample and options.stop_sample and
+    options.start_sample >= options.stop_sample):
+	print("--start-sample must less than --stop-sample")
+	exit(2)
 
 # Initialize global dicts and regular expression
 disasm_cache = dict()
@@ -63,6 +86,7 @@ cpu_data = dict()
 disasm_re = re.compile(r"^\s*([0-9a-fA-F]+):")
 disasm_func_re = re.compile(r"^\s*([0-9a-fA-F]+)\s.*:")
 cache_size = 64*1024
+sample_idx = -1
 
 glb_source_file_name	= None
 glb_line_number		= None
@@ -151,10 +175,10 @@ def print_disam(dso_fname, dso_start, start_addr, stop_addr):
 
 def print_sample(sample):
 	print("Sample = { cpu: %04d addr: 0x%016x phys_addr: 0x%016x ip: 0x%016x " \
-	      "pid: %d tid: %d period: %d time: %d }" % \
+	      "pid: %d tid: %d period: %d time: %d index: %d}" % \
 	      (sample['cpu'], sample['addr'], sample['phys_addr'], \
 	       sample['ip'], sample['pid'], sample['tid'], \
-	       sample['period'], sample['time']))
+	       sample['period'], sample['time'], sample_idx))
 
 def trace_begin():
 	print('ARM CoreSight Trace Data Assembler Dump')
@@ -216,6 +240,7 @@ def print_srccode(comm, param_dict, sample, symbol, dso):
 def process_event(param_dict):
 	global cache_size
 	global options
+	global sample_idx
 
 	sample = param_dict["sample"]
 	comm = param_dict["comm"]
@@ -231,6 +256,17 @@ def process_event(param_dict):
 	ip = sample["ip"]
 	addr = sample["addr"]
 
+	sample_idx += 1
+
+	if (options.start_time and sample["time"] < options.start_time):
+		return
+	if (options.stop_time and sample["time"] > options.stop_time):
+		exit(0)
+	if (options.start_sample and sample_idx < options.start_sample):
+		return
+	if (options.stop_sample and sample_idx > options.stop_sample):
+		exit(0)
+
 	if (options.verbose == True):
 		print("Event type: %s" % name)
 		print_sample(sample)
-- 
2.34.1


