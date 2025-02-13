Return-Path: <linux-kernel+bounces-513965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B873AA350D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016C43A7D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C188206F15;
	Thu, 13 Feb 2025 22:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mKZSZQHY"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FE41714B7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484227; cv=none; b=ZkPjmlY6NlX0bjU46wkf8NZojCEJSYuNdCoWQNUAIrkjmcAcpX7j7Xb2oWgCVDhShwdjfThzLw7n5JlU0+Q6gaVhN5daGj3PPwpFZlCotsdvDoNturtSZbkXMsPHojfC3Q3gkAR7wWopnsBARzxCT/VlPP50ghS48GatT8gGSs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484227; c=relaxed/simple;
	bh=vRm1GqPMyqXA4pzClKC7bvwwNmM1WifeOw0DDoJQWxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y3bfDthfbQOhjN/p6PtOt3oNQjyfayifHdvGrQXY2zQDokGtutgeAjFE2xwu8w3F4JTOxTUYevXhuBgQBh612YKCu4SlVw305CIXfWY+8jeJ4SE6hVlPZ49T/QxSRypupA6d7GQwUWftyiDHaD9DhOKuY4INBT9l0AhrTRXlAbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mKZSZQHY; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso2518716a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1739484224; x=1740089024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vofSNuCMlReC+WuFTXGYAG+iOC4hNVftxe7EdwNqb5U=;
        b=mKZSZQHYlozsiTZI+eZ2aZ9RN+TbJcsjaUfm7VZ3EPztIaJa8xcuNrBAu+K6JCjStr
         NhMVjDIxXlx8Kr65ANodrFcnY0KeEF2X2uXuTZAs4z9OCk9iGl85RbucbEpxmObyIPp/
         FtgA9yusEAv26k4XtiZqEO+6VYJoRITx6RF5hfb4nholpfgcFDtxApTKcQo9s1mQvjRu
         XrlfRYpJgdes+1japH60Mgb2DgCCvRu8L1PnoUHaqq7CYriijXH8yoFX9cxWYfeNiCFX
         B7T9F0WCiuyUhrJk+RFFvDxIe+I/1cq4eESLJWtJKxAt3W4F8z69rywNHFhG9Um/EOHs
         SqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484224; x=1740089024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vofSNuCMlReC+WuFTXGYAG+iOC4hNVftxe7EdwNqb5U=;
        b=IHr0ORjUNZO0YRTXCjGv45QDvt0Pw3rpnX7wWmmvR4r/oTphuKgzIzM4pzQA3xC2Hf
         4/gH/W0ws9tA9TO3QPm6McQ2odYBUHwjw5eEgLGQBayHGP9RbJqoENqwl7Oz6BSMXSCb
         PMu7Id8eD2c+DiB0Xb2tHIrrFYzyDm2p1G8KrwRFXLXqCHPOfIrbjZGMonWTN32wVIz+
         OgJqG5wbZTKhG9LXekmPzEh2lcLTYdXgKwnVUlryRHUTz7UnsDTDyf3/V13Cvg8ivMAn
         txQuunb7tw3yvrJUnwyurcljJW/252iRP8CSgMUgXdPZqWRj9DMX8Wm7Xd0CqpiRj8j4
         UwEg==
X-Forwarded-Encrypted: i=1; AJvYcCVnBk/MS9kIn1ixwYFUJdrqOuTAHOdDLTd7bDEZ1caf1/LzuxUZKebNftbWaHhDChWgQzZ0BWysZdBVii4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhlNQ5PNIvOc15lo/z1FuUiNLSNqa6JLtINuif9chYxcl7WJBb
	1lVkGVOsFFFamDzky/YxpUFZ2wANuxGdAZS/pn815x+GiL7OTkja3K1WAhuBayM=
X-Gm-Gg: ASbGncvjg/k7BStciyDSw1yq/htuXzoOsCd+JdIPBjggNGjtcVE90FzKLOp8mZ2S4P9
	BYwJw7wLJgCLhKegHCRUkQmvBu5S2S3diiT3+cimLEECux1+1VFptaQujYEqcbeEfTO/odPMCxy
	QlRttttppHT+sf8d8UuhNlzZZvYjm/IjFhkgNRkZqFoMB4kChPQ6Ihsgk0slwwNgh2Pgr84qWXt
	UXqiTpouTg7YODq7nPF/irOhJ/uhlwAw0Om0oqlQgTOqeWO/25kW8Mt5y98zN2bH89/l1NgrUKm
	MKiAMdwi0eFhIMS/lBSepL3R1XQ4Qq/AC5ZOGA==
X-Google-Smtp-Source: AGHT+IHZZb2Jta84jO1YUZkaqS3bvyvNnQldZh8oh2u99VvWuVBNfNp7QsimOh8/7XV9ie22K9NXig==
X-Received: by 2002:a05:6a00:3d46:b0:72f:f872:30a7 with SMTP id d2e1a72fcca58-7322c37d9b1mr13653146b3a.6.1739484224011;
        Thu, 13 Feb 2025 14:03:44 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e438sm1847491b3a.94.2025.02.13.14.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:03:43 -0800 (PST)
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
Subject: [RESEND PATCH 0/7] perf vendor events riscv: Update SiFive CPU PMU events
Date: Wed, 12 Feb 2025 17:21:33 -0800
Message-ID: <20250213220341.3215660-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series updates the PMU event JSON files to add support for newer
SiFive CPUs, including those used in the HiFive Premier P550 board.
Since most changes are incremental, symbolic links are used when a set
of events is unchanged from the previous CPU series.

I originally sent this series about a year ago[1], but received no
feedback. The P550 board is now available (and I have tested this series
on it), so it would be good to get perf support for it upstream.

[1]: https://lore.kernel.org/linux-perf-users/20240509021531.680920-1-samuel.holland@sifive.com/


Eric Lin (5):
  perf vendor events riscv: Update SiFive Bullet events
  perf vendor events riscv: Add SiFive Bullet version 0x07 events
  perf vendor events riscv: Add SiFive Bullet version 0x0d events
  perf vendor events riscv: Add SiFive P550 events
  perf vendor events riscv: Add SiFive P650 events

Samuel Holland (2):
  perf vendor events riscv: Rename U74 to Bullet
  perf vendor events riscv: Remove leading zeroes

 tools/perf/pmu-events/arch/riscv/mapfile.csv  |  6 +-
 .../cycle-and-instruction-count.json          | 12 +++
 .../arch/riscv/sifive/bullet-07/firmware.json |  1 +
 .../riscv/sifive/bullet-07/instruction.json   |  1 +
 .../arch/riscv/sifive/bullet-07/memory.json   |  1 +
 .../riscv/sifive/bullet-07/microarch.json     | 62 +++++++++++++
 .../riscv/sifive/bullet-07/watchpoint.json    | 42 +++++++++
 .../cycle-and-instruction-count.json          |  1 +
 .../arch/riscv/sifive/bullet-0d/firmware.json |  1 +
 .../riscv/sifive/bullet-0d/instruction.json   |  1 +
 .../arch/riscv/sifive/bullet-0d/memory.json   |  1 +
 .../riscv/sifive/bullet-0d/microarch.json     | 72 +++++++++++++++
 .../riscv/sifive/bullet-0d/watchpoint.json    |  1 +
 .../sifive/{u74 => bullet}/firmware.json      |  0
 .../arch/riscv/sifive/bullet/instruction.json | 92 +++++++++++++++++++
 .../arch/riscv/sifive/bullet/memory.json      | 32 +++++++
 .../arch/riscv/sifive/bullet/microarch.json   | 57 ++++++++++++
 .../arch/riscv/sifive/p550/firmware.json      |  1 +
 .../arch/riscv/sifive/p550/instruction.json   |  1 +
 .../arch/riscv/sifive/p550/memory.json        | 47 ++++++++++
 .../arch/riscv/sifive/p550/microarch.json     |  1 +
 .../p650/cycle-and-instruction-count.json     |  1 +
 .../arch/riscv/sifive/p650/firmware.json      |  1 +
 .../arch/riscv/sifive/p650/instruction.json   |  1 +
 .../arch/riscv/sifive/p650/memory.json        | 57 ++++++++++++
 .../arch/riscv/sifive/p650/microarch.json     | 62 +++++++++++++
 .../arch/riscv/sifive/p650/watchpoint.json    |  1 +
 .../arch/riscv/sifive/u74/instructions.json   | 92 -------------------
 .../arch/riscv/sifive/u74/memory.json         | 32 -------
 .../arch/riscv/sifive/u74/microarch.json      | 57 ------------
 30 files changed, 555 insertions(+), 182 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/cycle-and-instruction-count.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/firmware.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/instruction.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/microarch.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/watchpoint.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/cycle-and-instruction-count.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/firmware.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/instruction.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/microarch.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/watchpoint.json
 rename tools/perf/pmu-events/arch/riscv/sifive/{u74 => bullet}/firmware.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/firmware.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p550/memory.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/microarch.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/cycle-and-instruction-count.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/firmware.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/microarch.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/watchpoint.json
 delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
 delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
 delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json

-- 
2.47.0


