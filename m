Return-Path: <linux-kernel+bounces-513966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26FEA350D9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6674016D644
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D36A269810;
	Thu, 13 Feb 2025 22:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Q6m+YClU"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186A420A5DF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484227; cv=none; b=iX+M1IMOmCIwh1Ypjw3v7G/4j5j3LxKVG0reUwMcgYj/DiE0UgadsBBSkyj8N83Ro6Qv2RO4NuMPuMUgzYhOoUvMUsC+9O50B7uVMihDp38lqqDmFZFlpO3OSD20njkCeT5wqjpSfuemC63pm97c0bsVc8cdM0eJIUJpwF7j4bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484227; c=relaxed/simple;
	bh=EBcnEm/QrNPY7L+pJSBMhYwK2erXTVxT15U4RvvSL5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlC6NtM/HRxGk8bFPmyMMXzR+1lUQB5zmOj0sbO13eDcG1TwuQTbIy/khUcvN8beAZow9fUMPlchansRDTo0xwnH5YJX/MFufgK3t45o8yPRfUGu3brHASZzK4CCsVAQMw9WzycFbqnhLZm7roz5k1N84o3R0Jm62BGWKWnUj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Q6m+YClU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso2081548a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1739484225; x=1740089025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sn7Sf/VJa7o2kQnvv17430q5LGkiKAmnPlLEbt0xnSg=;
        b=Q6m+YClUznpyuaO+bzan+jRFkwokm0vtrOII2aW3oEaxtWG+sdbxnhcFJcNcv5bwhO
         bdu2l3bOBO0OGhWmqQB4lqpa2dvKjjv2SYBmVsXZF6EOBXY23NZmVO1M40Nh5LQx59Du
         VddqH7GsPONhq482rKrLbC+X5ou/zSsWSGTREkg+fpXyfR7SUCtlCtzgX5QO45UHDStr
         6afJ4MwluTlpZsglOcyzl2B8cp61XTi5UNVgczgry1rnqiOuXeYPgYxFUOvnD1M6dNse
         Oopc2LGjyaB+3UoCUZeLV6d2sxB2TqhbNPsvgO5z1CtLkT4/vuGl/JvVmqd6Hp1GgEa+
         vc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484225; x=1740089025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sn7Sf/VJa7o2kQnvv17430q5LGkiKAmnPlLEbt0xnSg=;
        b=Lzgr3xk9iWRwawU1AXLBKUuHdSIMIN34ch4zN3NLQqGV5BfZwWbWQEUjcZc4qGfxrz
         njEorxFuW+V/F+uaUC/xmPrNyqlFzdi0A3V7A4+Wcyw98uzEgNrLcqPhKeHWcTSNLDjz
         9DMX1sTnLYTA/uOmXPZUoQXJdfeCu9BjFI0mSRmYsb6khFs675YBSKr01KGRd90uDTc9
         De2VoF7Rsq4bRapnB0QC0QfH9nzQIe3s+OLE1UvwOglD+D8+8XDRDnJVh+shG3oeRA3Z
         JJL0O3wgCgHPnwgh3ZJ0M/cxZLKQJ7FCGipL2c2z3d2Sl/OURCJs83uBC/xZurNiEET/
         jp7w==
X-Forwarded-Encrypted: i=1; AJvYcCWAceXd7jxDqf8GmyIsjObB9linKvu+VJVnipMztRJlGc6IdMLw4OURPWqHwSb3fc5Wd7gt29jGkWmySOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzCVU1lZ20HVebzCDyHZyvuv4QZwe4wwKSDZt5zQ9PtG6P3Bpj
	TD5YVn1x9DYUQCBgo8w5bVdN7W1Bp6tP4cGIwcOlzErit2rqT/IMSufLdzy85SA=
X-Gm-Gg: ASbGncs8g6rHKRuOKVmN4ehBdzSWOKFH6kZ/4vzOHxb0MQ0LplaWhYXN20jpKJIjm7h
	kQZhDMgH6QdKz4sS3yhAWhHcR5NUaxNTGna7dTkfa8dUXtQYHRMXlTCdsYZCoYYNipNDqcl3LoC
	LBwmsaLfK55H6QQ1PHuZx2Ulg+mMtZ15ndygFAOkMG5rGY6PvHa4dA/a2ikVVdO2PFMgTW0xiMt
	svp55DjO6l9iOjRj40JmYxVQeFzZkmjRFJtFrJlPuXMgfpVwnCSKWqCgOMSbFTWlIRw4hdxboK/
	zta7Jrw0KEU78KO9iAIvzQmOVv2l+odavxQoLg==
X-Google-Smtp-Source: AGHT+IHkFJ+qjdPn6uu0QPcmGwTebP9L3ITV/fNakdUXm6n9V5utSpWvIQRkdMaseOUVz3BmpGbQ1g==
X-Received: by 2002:a05:6a00:2ea3:b0:730:9204:f0c6 with SMTP id d2e1a72fcca58-7322c4310b4mr11699224b3a.16.1739484225285;
        Thu, 13 Feb 2025 14:03:45 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e438sm1847491b3a.94.2025.02.13.14.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:03:45 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [RESEND PATCH 1/7] perf vendor events riscv: Rename U74 to Bullet
Date: Wed, 12 Feb 2025 17:21:34 -0800
Message-ID: <20250213220341.3215660-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250213220341.3215660-1-samuel.holland@sifive.com>
References: <20250213220341.3215660-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set of PMU event descriptions applies not only to the SiFive U74
core configuration, but also to other SiFive cores that implement the
Bullet microarchitecture (such as U64, P270, and X280). Rename the
directory to be more generic.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 tools/perf/pmu-events/arch/riscv/mapfile.csv                    | 2 +-
 .../pmu-events/arch/riscv/sifive/{u74 => bullet}/firmware.json  | 0
 .../sifive/{u74/instructions.json => bullet/instruction.json}   | 0
 .../pmu-events/arch/riscv/sifive/{u74 => bullet}/memory.json    | 0
 .../pmu-events/arch/riscv/sifive/{u74 => bullet}/microarch.json | 0
 5 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/riscv/sifive/{u74 => bullet}/firmware.json (100%)
 rename tools/perf/pmu-events/arch/riscv/sifive/{u74/instructions.json => bullet/instruction.json} (100%)
 rename tools/perf/pmu-events/arch/riscv/sifive/{u74 => bullet}/memory.json (100%)
 rename tools/perf/pmu-events/arch/riscv/sifive/{u74 => bullet}/microarch.json (100%)

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index 3d3a809a5446..521f416b0006 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -14,7 +14,7 @@
 #
 #
 #MVENDORID-MARCHID-MIMPID,Version,Filename,EventType
-0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
+0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/bullet,core
 0x5b7-0x0-0x0,v1,thead/c900-legacy,core
 0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
 0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet/firmware.json
similarity index 100%
rename from tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
rename to tools/perf/pmu-events/arch/riscv/sifive/bullet/firmware.json
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json
similarity index 100%
rename from tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
rename to tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json
similarity index 100%
rename from tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
rename to tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json b/tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json
similarity index 100%
rename from tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json
rename to tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json
-- 
2.47.0


