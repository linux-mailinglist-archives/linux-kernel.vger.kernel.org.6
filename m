Return-Path: <linux-kernel+bounces-316869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0144F96D665
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3091E1C24E04
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B34C19922F;
	Thu,  5 Sep 2024 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="StlV5EhQ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041F198E89
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533468; cv=none; b=VhYECEWOplcj69LDgRKYyISdoO+F9ZP08PEcaj6iQuH6Gd6Eli7PHkyZEUISuVViPupQ9v/GJ7ek4gmhrNKT7Y7yo929hp9LlaCrJaMkELqBK4rv5e617pM4UJUgXNDoi4+yDtrgFVBQHwnbddx3lsbdEoqKhj0SgFYXly4YmRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533468; c=relaxed/simple;
	bh=TQjF7jPPLYqbnWfFtn0ZeCefM3gftDDsQw5DBnhz4Lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n/+Ml0Gcp0ltdwkGEAOEK4VCTfM7DfPfn89ejLqIabGvvPqAhNY7nQzPcpgZemllCYwPxt4aTOqXph2cf7gHv8J8A7pR24juCD6PJRZntsf1M5tYP0r7GQcI7mAw2io5pwMyvlAKyNhnEAa9kab3Kdmb13gLWL6gruWuzx0Ctyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=StlV5EhQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso6160495e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725533465; x=1726138265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCSBDf6vejOduoC/+lNg91tRBdxB4ctW3PuO513YgaA=;
        b=StlV5EhQimy+NGpAsUm6ToloBCen8AHv6WYuaFXIR//tRkCYfDcCsRFw+WiD72z269
         Tx1deb25fPOhHTONwDpsujvsf630YhxxEopmnC4apUFcB/vewugCrbtg6k+zky6azloM
         94EXjjmOPzDlSztJX1GLOWd7SLfqAB32yIoLeECgPX9PiDcK+WW0uFbn+P3AtUEEuMkO
         JedoVPA5sSdatGu0iXMLFq8Lyg/xkqKvta8pVHPpXzsb1eSIfgf29KqAbPF7bTZBvukV
         znNtEKPaWbT1DwMAD79euIpg7UoROfuxCc/jKwqxts/zuHgJisAb9X/ilUOVqts5QV60
         fmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533465; x=1726138265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCSBDf6vejOduoC/+lNg91tRBdxB4ctW3PuO513YgaA=;
        b=SQBWVA+H7Li0P6BdTiG/OQIh0DgybPttdHmayfJgK/APSMfq7Q4QH6L5MdDTAC35KZ
         DuzczoapjcjCysiIMSdI6VAKpKk1A2NLKaZxHYOu63y119KXqGwZlwCG5M6/m8KeXF+c
         4AJ+NdZztKDzKJwAabppAFRyRUrYkhr6xS6kEMIVsUc+3QSyg7Zdqe2P6fCNQMTYrl8Q
         FCGdgtoHJtyQYTtjMUCfBv7BcA97EMWtPCclb/WYJg4s2KEM2kQgvFEgmzXZbZfSTOuN
         iY+tNQArbIOVpmJZL6eZnoJKkSZ1A7Lk02kevovRffGfMy6uWugX/zQsdsqWqMxOSfEL
         if/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWv55uPaKNgDutpjPSnEdzFgpYfvMPyLzhm/0MDN7DJxnd7sh05eNuOI+NStchBvFEjox5jSB5+xPwRj2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrCb1qgY/Yu1m74AWobdb4Vgi9LatxV9TXZoDB36vJymB/F/Ss
	YdW+bSNEqGXcnQRMFcUuYPRg0104tFkwMo6XksJZWdfh0YhCR5imJDgbyvCs3/c=
X-Google-Smtp-Source: AGHT+IEvKTt/6e8xWeLQPHZ+Y88gea0Wee1acuIi7mFkLMpU6DekcEkaro14JQNPOmXmgU7w0uaIgg==
X-Received: by 2002:a05:600c:1c8a:b0:426:59d3:8cae with SMTP id 5b1f17b1804b1-42c9a365902mr18084165e9.13.1725533464564;
        Thu, 05 Sep 2024 03:51:04 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0dbcsm231089965e9.17.2024.09.05.03.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:51:04 -0700 (PDT)
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
Subject: [PATCH 1/8] perf cs-etm: Don't flush when packet_queue fills up
Date: Thu,  5 Sep 2024 11:50:32 +0100
Message-Id: <20240905105043.160225-2-james.clark@linaro.org>
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

cs_etm__flush(), like cs_etm__sample() is an operation that generates a
sample and then swaps the current with the previous packet. Calling
flush after processing the queues results in two swaps which corrupts
the next sample. Therefore it wasn't appropriate to call flush here so
remove it.

Flushing is still done on a discontinuity to explicitly clear the last
branch buffer, but when the packet_queue fills up before reaching a
timestamp, that's not a discontinuity and the call to
cs_etm__process_traceid_queue() already generated samples and drained
the buffers correctly.

This is visible by looking for a branch that has the same target as the
previous branch and the following source is before the address of the
last target, which is impossible as execution would have had to have
gone backwards:

  ffff800080849d40 _find_next_and_bit+0x78 => ffff80008011cadc update_sg_lb_stats+0x94
   (packet_queue fills here before a timestamp, resulting in a flush and
    branch target ffff80008011cadc is duplicated.)
  ffff80008011cb1c update_sg_lb_stats+0xd4 => ffff80008011cadc update_sg_lb_stats+0x94
  ffff8000801117c4 cpu_util+0x24 => ffff8000801117d4 cpu_util+0x34

After removing the flush the correct branch target is used for the
second sample, and ffff8000801117c4 is no longer before the previous
address:

  ffff800080849d40 _find_next_and_bit+0x78 => ffff80008011cadc update_sg_lb_stats+0x94
  ffff80008011cb1c update_sg_lb_stats+0xd4 => ffff8000801117a0 cpu_util+0x0
  ffff8000801117c4 cpu_util+0x24 => ffff8000801117d4 cpu_util+0x34

Fixes: 21fe8dc1191a ("perf cs-etm: Add support for CPU-wide trace scenarios")
Reported-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Closes: https://lore.kernel.org/all/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 90f32f327b9b..602e791ff5ba 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2490,12 +2490,6 @@ static void cs_etm__clear_all_traceid_queues(struct cs_etm_queue *etmq)
 
 		/* Ignore return value */
 		cs_etm__process_traceid_queue(etmq, tidq);
-
-		/*
-		 * Generate an instruction sample with the remaining
-		 * branchstack entries.
-		 */
-		cs_etm__flush(etmq, tidq);
 	}
 }
 
-- 
2.34.1


