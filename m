Return-Path: <linux-kernel+bounces-330741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A383C97A3AB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6875628C2F7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FEA15958E;
	Mon, 16 Sep 2024 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5C5ZQx0"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4145D1591F1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495107; cv=none; b=prUh+L3SvOLLaDCz5vn2HJ152TcTbuf4ypWql18ZkAbFZ1FSTxMgtBfnRRnxWPyWSFTfGq3XdC2lGOuBkcRxtr6AH/jrdLcfxqurKpr6yeELWCPIDQyuOizMvS4C8mr1J59EYVxhHVV5no9jHjnpTdewvpKuSyKYWeTApmRy3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495107; c=relaxed/simple;
	bh=xqzKWqo2N+qrwkny8IWgiAeXyj7BCHbJKMyWllqHEio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gjwE0cc9QuOcjE/Y/klmP7Yvff3Qy2uMWcsX4+OIxL19+qEDj+UkjgfGMWe98DbbZxfV/KCcE49ZWwTkkBYfVJMte8qPIagY3Z5wrNAUQPZEULI5fKrQXkOWrQhYpdZ9pWn3JrM8geSmmExMsx+4FTF+BdDDPG7K5cSZeNEHg8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g5C5ZQx0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3787e067230so3224434f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726495104; x=1727099904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umuEtd6TXriWmaesvaUlkUkqPg9JblHlWbB3iYtKN0A=;
        b=g5C5ZQx0M7PIZ6SlEBGVHMTTHJKcU62m7BbcgxnwSCglj+DPjZZV42A9m9projAnT3
         c4dI//kdmAQYHB+iW5NlCsNVrUl63OUte48j8fi1KYUo9Hz6qbl5AwTued/YztOAxvEc
         /GHAuyBTdoRYwtrmKCLknLRL0uWeNUBFTQsQUCPfoNaGpNFmBhLHq4ZikkfhCEBtX1d2
         yMhm0zMfVNmq5FpiPMmZL2I8gQh+1LbRxSAIT3lweSHEP9OaI3mJm5jdGWHWubSEsEfG
         5QMn75jw0UQ6S4KmtBY6G+jh7cKrPQPeZ7FVbS3n9AMOmwvAXHzDkL6g6xRywu35QFpe
         8i8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495104; x=1727099904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umuEtd6TXriWmaesvaUlkUkqPg9JblHlWbB3iYtKN0A=;
        b=RxHogg+bAI9lLkrLu4xcN6vfJBuqLZmaolBoZKFgdWRZdOmZ4CFJphXUyDLrPkw9XH
         y+OQbqMTyBuqhOAWXSmwsPV9N3osLXcvkqIhKPfgbe6STCO1C4+G4FRmAV5P1ENax2Km
         WPfkg8fGj4CRGMgI19DT7lCFY/BnhetptajrEuFhW9e4DvQN37XfUOST1T+sjgJ1yeSd
         HyZYNsQngbPD2/fi4mD4jtkYfFsVeaxEeeZKT0cMEZSChgW50Y2hG9Yj0tLlHWyBF7pO
         Ll5UQEbCWmqnDEGBAiE1uD13T7n45x4/y8d/FjEy3Zpx3rAkcyfhiw7N6unSzVxstZMV
         JWpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/DrZVV2A+Dc+nA6eQ4J62/L5sGIUcx4s468o3OEzbkkWYVbK1dVWhZy5fOwmNiTfFzMmusuro0FaGS38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBkyTKLmFBCdCcdWHrLu/u1sm+ZJr4g/uBtlbqMUqiXd20SHnd
	rnynTFqRMiWqDJsYsyvEYNGWlUVimLjrUX/SxzLDe2UO6lWo61FXIDFN0Cq9gn4=
X-Google-Smtp-Source: AGHT+IH+TmfCLdIaNzxJmSpEMr+pHlKHl21zQSiG9BRNBBOm0HusB70btlMPY4whjW+3iQfcuOBDCw==
X-Received: by 2002:a5d:56d0:0:b0:374:ce9a:ff11 with SMTP id ffacd0b85a97d-378c2d7298fmr8875256f8f.50.1726495102704;
        Mon, 16 Sep 2024 06:58:22 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm7285098f8f.49.2024.09.16.06.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 06:58:22 -0700 (PDT)
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
Subject: [PATCH v3 1/7] perf cs-etm: Don't flush when packet_queue fills up
Date: Mon, 16 Sep 2024 14:57:32 +0100
Message-Id: <20240916135743.1490403-2-james.clark@linaro.org>
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

Make sure that a final branch stack is output at the end of the trace
by calling cs_etm__end_block(). This is already done for both the
timeless decode paths.

Fixes: 21fe8dc1191a ("perf cs-etm: Add support for CPU-wide trace scenarios")
Reported-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Closes: https://lore.kernel.org/all/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 90f32f327b9b..242788ac9625 100644
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
 
@@ -2638,7 +2632,7 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 
 	while (1) {
 		if (!etm->heap.heap_cnt)
-			goto out;
+			break;
 
 		/* Take the entry at the top of the min heap */
 		cs_queue_nr = etm->heap.heap_array[0].queue_nr;
@@ -2721,6 +2715,23 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 		ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, cs_timestamp);
 	}
 
+	for (i = 0; i < etm->queues.nr_queues; i++) {
+		struct int_node *inode;
+
+		etmq = etm->queues.queue_array[i].priv;
+		if (!etmq)
+			continue;
+
+		intlist__for_each_entry(inode, etmq->traceid_queues_list) {
+			int idx = (int)(intptr_t)inode->priv;
+
+			/* Flush any remaining branch stack entries */
+			tidq = etmq->traceid_queues[idx];
+			ret = cs_etm__end_block(etmq, tidq);
+			if (ret)
+				return ret;
+		}
+	}
 out:
 	return ret;
 }
-- 
2.34.1


