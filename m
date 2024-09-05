Return-Path: <linux-kernel+bounces-316871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B56196D667
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A971C2085C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4B91991DD;
	Thu,  5 Sep 2024 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pc6TCSp+"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB5C198E89
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533480; cv=none; b=f5SDnW/95UcniljKk7NHyb3q0mzXC8F4o4kRN5ECTVlGwfPH5jEzUABqVGT3hjLSLPStG/OrAqF5Q8EJ/iPlcTlc+llGsHCsWSYAcv/JTFirAaUTaDbHS/avTBja4XiitmbcuZSa7OZbAmadAG5QWYPZeqQuTrqLqNSvoSEzZmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533480; c=relaxed/simple;
	bh=wzk9SyvQfKoXUMQnerIZ1e1CQ5nCLvLIdMZfnrTV2M4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GtIs+JbafgmfBxCbtjvFiuvSyarZRNjOdyMNuEs1xZVSHYnauQT9Y9ks//aKmOFxOh/PzMG3GlEwwLngucwcbMQDLozcxmEP5lrNdIeAScHmw7P+BxhJmvHmYsMAxmWvQSpvaDgehtHhApkfOZ5rTJ10EaXAU7xUWoExlep0rAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pc6TCSp+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42c7a384b18so5096175e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725533477; x=1726138277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVd4bq0YTjw4v+0IMoc3Cm2fVjGVCOS4YTrWYkTu6OE=;
        b=Pc6TCSp+cTes7yo7UyKK3TevcHf8sJSDNfpAsOdR9e4qZfGoZE5DXQH0ET2KGR8L7E
         INXVbVF17E7U1u1/OrzU60XPxHaNb15crUe4AM7NcbG5YcWDYNSv4+i4x55JfkilsjnQ
         7YjbSFJGny392eUMct6wtAl6lUCa5Cb9DNC7+HSP85I6jc4D70nXTqLUhweXBKsjSHNT
         lyLheFtrLrumKS9NnSURNrprKERngMf6nGMoJLkbd0uMreLXXBPuh8iUWnSkt3bhW3IB
         MBB30eJtRyUtorbdzBXE04diK9q4/nIIQcbX8kqxgH38ovRlqWXRukqLSNmmzHtaS8fN
         44lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533477; x=1726138277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVd4bq0YTjw4v+0IMoc3Cm2fVjGVCOS4YTrWYkTu6OE=;
        b=vjvFsaPnCUASmk7C5n2OQnQ6c+MfsFohXD2RbfgPvjMWjavcpQmv4hcyzLZfMLdsvg
         pHG6akKMiQKQtF/tpYcYfQaR3QWGESlj7cGym1WzwztGRyEMgWsnPX7AK3mzXqRA3fW4
         t4AdMvPFrLgXdGHLDG8zpKFYagVXsT4CCfIi6rB92zOFBO8tEFbJDowTlgtT3yJq7XoZ
         /xyTRt32LXqPKHqeatFqzsteMMZVLi98VZGtNUawYzLpAcrLfAc4gp9ZRGidKSuFhvV/
         jKA0TFopWCjxHhyOk4EW9frla8CwblRJNjyr9vzLdFRx1ya3aW604D0d3rTQ66bf6h3U
         asbA==
X-Forwarded-Encrypted: i=1; AJvYcCXZZU1Q+bzzbkmQ0Hk8pd31M3vJ5M1Ub1PcmoY2ltayCdY9oL64S8qkROLz82xExN/RL1Lv3sZf9uQDqBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZIy3WurvRgToXPKO0tJODSbQEWXiJX7Eb1wOm/ZhE4KpHkp/L
	xl7yAgbdIFHAQq0PCXeXDXhRispYV3S1IAdPWLx2sLNArWz1DodqcBpvnwHPMww=
X-Google-Smtp-Source: AGHT+IHLKD1lksVjuCFdRAy71VLeSYs/LO7EW6oQprwBpHDtYZTrW3t9QhBgsgUf6sAqeRl0YMfHGA==
X-Received: by 2002:a05:600c:3584:b0:42b:afd8:7568 with SMTP id 5b1f17b1804b1-42bdc64e498mr125056915e9.23.1725533477165;
        Thu, 05 Sep 2024 03:51:17 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0dbcsm231089965e9.17.2024.09.05.03.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:51:16 -0700 (PDT)
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
Subject: [PATCH 3/8] perf cs-etm: Remove cs_etm__flush()
Date: Thu,  5 Sep 2024 11:50:34 +0100
Message-Id: <20240905105043.160225-4-james.clark@linaro.org>
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

This is only called on a discontinuity, and it generates a normal
sample and then clears the branch buffer. I'm not convinced that any
of the subtle differences between cs_etm__flush() and cs_etm__sample()
weren't actual bugs or potential sources of them.

Replace it with a call to the existing sample function and then a clear
of the branch buffer.

One obvious difference is that it now generates a range of instructions
based on instructions_sample_period, rather than only a single
instruction sample. I think this is actually the correct thing to do.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 62 ++++------------------------------------
 1 file changed, 5 insertions(+), 57 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 602e791ff5ba..cdda8403af2b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1908,60 +1908,6 @@ static int cs_etm__exception(struct cs_etm_traceid_queue *tidq)
 	return 0;
 }
 
-static int cs_etm__flush(struct cs_etm_queue *etmq,
-			 struct cs_etm_traceid_queue *tidq)
-{
-	int err = 0;
-	struct cs_etm_auxtrace *etm = etmq->etm;
-
-	/* Handle start tracing packet */
-	if (tidq->prev_packet->sample_type == CS_ETM_EMPTY)
-		goto swap_packet;
-
-	if (etmq->etm->synth_opts.last_branch &&
-	    etmq->etm->synth_opts.instructions &&
-	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
-		u64 addr;
-
-		/* Prepare last branches for instruction sample */
-		cs_etm__copy_last_branch_rb(etmq, tidq);
-
-		/*
-		 * Generate a last branch event for the branches left in the
-		 * circular buffer at the end of the trace.
-		 *
-		 * Use the address of the end of the last reported execution
-		 * range
-		 */
-		addr = cs_etm__last_executed_instr(tidq->prev_packet);
-
-		err = cs_etm__synth_instruction_sample(
-			etmq, tidq, addr,
-			tidq->period_instructions);
-		if (err)
-			return err;
-
-		tidq->period_instructions = 0;
-
-	}
-
-	if (etm->synth_opts.branches &&
-	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
-		err = cs_etm__synth_branch_sample(etmq, tidq);
-		if (err)
-			return err;
-	}
-
-swap_packet:
-	cs_etm__packet_swap(etm, tidq);
-
-	/* Reset last branches after flush the trace */
-	if (etm->synth_opts.last_branch)
-		cs_etm__reset_last_branch_rb(tidq);
-
-	return err;
-}
-
 static int cs_etm__end_block(struct cs_etm_queue *etmq,
 			     struct cs_etm_traceid_queue *tidq)
 {
@@ -2457,10 +2403,12 @@ static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
 			break;
 		case CS_ETM_DISCONTINUITY:
 			/*
-			 * Discontinuity in trace, flush
-			 * previous branch stack
+			 * Discontinuity in trace, generate a sample then
+			 * clear the branch stack.
 			 */
-			cs_etm__flush(etmq, tidq);
+			cs_etm__sample(etmq, tidq);
+			if (etmq->etm->synth_opts.last_branch)
+				cs_etm__reset_last_branch_rb(tidq);
 			break;
 		case CS_ETM_EMPTY:
 			/*
-- 
2.34.1


