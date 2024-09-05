Return-Path: <linux-kernel+bounces-316867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620D796D662
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B6E1C2352B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FD01991BA;
	Thu,  5 Sep 2024 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qmeJlhCB"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E211990BC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533462; cv=none; b=Ebl/4SeZcGzUH4A+BBV7wffq6GEy6K60a+kHbTL/WwV1OIbbTp9QitvcS9yZZqW+jCcVyrjhJKwtp+9kL6L0UmGy4DemViqSMcLgHIQAmon3tMfMRa7q+Yvm7lPB/DxXUCEtrGLLSw71p6qADxGMkQnhh1jSM1GdUjvJ4ADlnrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533462; c=relaxed/simple;
	bh=GNRh2lRRZsVbQ6TfXkUUV9PHKcq0DKE7VIm4q8c3w+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N6YL/Q3I0KRI2wNvBgTxJjrZtVIjigNVV3pRTtUvb27/RL0iUU9P3QJBoMm3H+04nQDcHrOILcW8+otx5Ks3M0BmFkF3sFJI7Elegff1oztKl8CLii/Ho5/EsjvvZZvv+iq1sHu8D3eS5QyZQdGxskaO0anXeUBGAeJa1BizGfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qmeJlhCB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bbc70caa4so4757755e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725533459; x=1726138259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yrDjMdMGpsV+SMiDpPkaWCXT3mQwpYh4u8w/BLX87is=;
        b=qmeJlhCBJzPd50fD9SIJMCz805zF6TLIMNuQQvmJVWWq+n7y1W5DQaUj1TXwihvvLy
         gPwyjJoNKMBQ5CERn55hQo8NMWg6mX5wx0hE1uK+BLh8kdr8NRWIBOhw5XXN+x8kIXgO
         gKCCJU2RbLztsRj6Cg4i1Iu+010wjsF9QXub+YV+6VuXZhuM8G0D7u772bOxwZLhVbvc
         bi5l38Mmv/fd9H8r4iYrURcoHgKagGyBS7QfqIj4cnMHEHNvLR8Ebg7HWopWyD4j19ip
         QryWtnnAovTODHizfFK7HnkH4cpjoMjy2g9x04QBQgzLXF5kiavq3IllwDbUQx367Rax
         oyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533459; x=1726138259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrDjMdMGpsV+SMiDpPkaWCXT3mQwpYh4u8w/BLX87is=;
        b=ASNY4uShQl2VcUrVhXmXOdvCHEqgNpCiZTcjvqHyBi+TFCY3oixIECmhmHuOhuhJnE
         ZVfK0OeJ/7kdHxStPcrrQgm8SkIvAHE/QQNjFOHkV0wBYGnQZlJj4bYG9XyAOw2THxsn
         G4hobXAwChmyPAum8+dWLV/X7a5JUOnd7VA5dq4XJF2qGqtcF3LZWmwIkxkVTbufrszx
         7q1DuuPYVBEfMWdN4ukKaBwlyobcI282KHp/1qWgAUFN8T412yof0JeUux2LxOgtaGgJ
         ARLb3FEQZsiWs6UDOdr2F9+1GO6URFfwJRySTwTxmP4+QXRicCpLpT3oUVj3/CtcJ7JD
         iLRg==
X-Forwarded-Encrypted: i=1; AJvYcCUvRQ6ieuC2LI6DoACYxYg5UhAxs586I2k549KjfS+sOG/zIvf6dXh1jVcG7ISqs2VdBEfUPyrAM5713zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySOq4jazUq6vAuqFBipj12F7shqmsQdUBng5T7feyOYd8RKFKi
	N2yO7Lq1dA08ea25NIeoTCGTCe/Lkv9C2Ghw6DNz4tlHrusk8uq7cAOq7XciraE=
X-Google-Smtp-Source: AGHT+IE3NCEI/gXttimfIrTl8DkzUXfi3ncD+kozCZR22fME7/IdooTQv6dLJudGLUQpNATZJI5Jvw==
X-Received: by 2002:a05:600c:19d2:b0:427:fa39:b0db with SMTP id 5b1f17b1804b1-42c8de9ddb6mr51601575e9.27.1725533458315;
        Thu, 05 Sep 2024 03:50:58 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0dbcsm231089965e9.17.2024.09.05.03.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:50:57 -0700 (PDT)
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
Subject: [PATCH 0/8] perf: cs-etm: Coresight decode and disassembly improvements 
Date: Thu,  5 Sep 2024 11:50:31 +0100
Message-Id: <20240905105043.160225-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A set of changes that came out of the issues reported here [1].

 * First 3 patches fix a decode bug in Perf and add support for new
   consistency checks in OpenCSD
 * The remaining ones make the disassembly script easier to test
   and use. This also involves adding a new Python binding to
   Perf to get a config value (perf_config_get())

[1]: https://lore.kernel.org/linux-arm-kernel/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/

James Clark (8):
  perf cs-etm: Don't flush when packet_queue fills up
  perf cs-etm: Use new OpenCSD consistency checks
  perf cs-etm: Remove cs_etm__flush()
  perf scripting python: Add function to get a config value
  perf scripts python cs-etm: Update to use argparse
  perf scripts python cs-etm: Improve arguments
  perf scripts python cs-etm: Add start and stop arguments
  perf test: cs-etm: Test Coresight disassembly script

 .../perf/Documentation/perf-script-python.txt |   2 +-
 .../scripts/python/Perf-Trace-Util/Context.c  |  11 ++
 .../scripts/python/arm-cs-trace-disasm.py     | 109 +++++++++++++-----
 .../tests/shell/test_arm_coresight_disasm.sh  |  63 ++++++++++
 tools/perf/util/config.c                      |  22 ++++
 tools/perf/util/config.h                      |   1 +
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   7 +-
 tools/perf/util/cs-etm.c                      |  68 +----------
 8 files changed, 192 insertions(+), 91 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_arm_coresight_disasm.sh

-- 
2.34.1


