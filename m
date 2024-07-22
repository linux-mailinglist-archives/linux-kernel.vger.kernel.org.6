Return-Path: <linux-kernel+bounces-258848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B0E938D52
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99B7283226
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE6E16D9D1;
	Mon, 22 Jul 2024 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="crRQF7Ct"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573A16D9C6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643200; cv=none; b=Kb3IPKrq5mNMQ84GDekTAXB7n+m/461oLjmb9vS7btDwJvgfahLNFbsM4KYYNW/ov26z2HtTHBPgq0ehAMfqlgOxcDIM1P5W3B3wrIM2Faul/bMwGIbwxzqnGkXi0Ss7JSySlIl2ayzOmmpr5DDTFxLOB9K5GwqrFwOewY08Q0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643200; c=relaxed/simple;
	bh=NJv4Ip/0MGeUDqPRCBtTePKyAhBC1HwlgSVGeLozqqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GHqUMKjmywGtgUcTmZcrQkhC+n5d7Nkr7nS9fXoQoWxxrQ/rvMjbhyFGlZzJsWVZy5W+Hrxo/OtsOP1rkFuUoEnDGQIv1Iz1U5S8ylyZztpk0pMawzQp4Tp4P20ANTsnGJYaOTi/IbsMedYLSYyP8L/s80F0bKpy8SBJ7ocGpyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=crRQF7Ct; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-427cede1e86so28794685e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643197; x=1722247997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CvKA9Oo8oUAGLDUMUBH2byBqwwnuDLfYbLv1IHZER0=;
        b=crRQF7CtbV82vfsxE3bSUfs20cH3fmGVf295mQ1iNhPA426ELPz18fSpu1HgUNpMTx
         4hZGUjHf+UAaGpMJDnmtGxSRuCDDkygyn8EeuTuPC8N94qkS2I6fHbp0HQ3IgclpOoEQ
         RotcYcaYTvqcwsnPZCrWLWk1gxSa+OGSo/lKreDqZmRS64kKaaxIPvN5a+Jb2MCVPRyW
         LtKPfTBlWI9UZk1ALE8FXKMpooT9y+qSQJSclB7MH+KH3LPO8pPKKwoCVxb8mlu+Bj+S
         idmqzf3D5Me4l1MNzwwruTZPSgzVN1QGNXpgH4deNeWoIm+fZN3RCyGmiUd+rqO6/y1V
         Dhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643197; x=1722247997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CvKA9Oo8oUAGLDUMUBH2byBqwwnuDLfYbLv1IHZER0=;
        b=e6BIZ2whGs2QiU2FQu4HGeO2w6aQ4zC+BpkKxkNoFyYb36kWBthnl42yDNTeKGfwV9
         aYldP0r/u1UDrXc9L8wraQETa0Fr+5g9PTrkYwKXa8KuS2tY0e9cz7D4GsUUF4KCUamJ
         Kj1nDHaA0tbnmR3vyYUnE7wZYl7rYHoIFgR5/dKIZv73A4CdHDTf07hnUm8h2miP3MJs
         E3SeE/ToT/lGQ8OdPZfAB6VOcr/UVeYwbjRxewxuGTLCEReqXKS1G22SzN2MhRZjcEGd
         m6B/eMUsIHnZ/RffkRLPf09Uo2/O/C2F8NYUNRJ0Ql8Y4BPw/2BZWwBp89gr0pBtlMO2
         SD7A==
X-Forwarded-Encrypted: i=1; AJvYcCUqFD3ROh7jt+6LhT6t17alQSrG985vF6leCJI/yrq76qpJzLRE2x84lTHnhwAnuyGi+OXg3WVNN2TpVSfm8ITrwnRJukPdCJbLthkM
X-Gm-Message-State: AOJu0Yy7K1MADfGplbRlqx1O5q4dAonuVf+ht1seTJY655Xflow5Zytu
	fGhMc712MmOJVoESZ/chMk3C8wIp0AnV1lNQ+qYVfKndSeulUMQAlVhn378fZlw=
X-Google-Smtp-Source: AGHT+IF7qS/l5dBLpir4Vw8LPazyz0x8s3+xWgLLeI6+jb9MqA3mHfayIPDgC0IjLcyLxDckxJt5aw==
X-Received: by 2002:a05:600c:35d4:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-427dc569cb0mr43200815e9.26.1721643197578;
        Mon, 22 Jul 2024 03:13:17 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:13:17 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	Leo Yan <leo.yan@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6 10/17] coresight: Clarify comments around the PID of the sink owner
Date: Mon, 22 Jul 2024 11:11:52 +0100
Message-Id: <20240722101202.26915-11-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722101202.26915-1-james.clark@linaro.org>
References: <20240722101202.26915-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

"Process being monitored" and "pid of the process to monitor" imply that
this would be the same PID if there were two sessions targeting the same
process. But this is actually the PID of the process that did the Perf
event open call, rather than the target of the session. So update the
comments to make this clearer.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Tested-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 5 +++--
 drivers/hwtracing/coresight/coresight-tmc.h     | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index e75428fa1592..8962fc27d04f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -36,7 +36,8 @@ struct etr_buf_hw {
  * etr_perf_buffer - Perf buffer used for ETR
  * @drvdata		- The ETR drvdaga this buffer has been allocated for.
  * @etr_buf		- Actual buffer used by the ETR
- * @pid			- The PID this etr_perf_buffer belongs to.
+ * @pid			- The PID of the session owner that etr_perf_buffer
+ *			  belongs to.
  * @snaphost		- Perf session mode
  * @nr_pages		- Number of pages in the ring buffer.
  * @pages		- Array of Pages in the ring buffer.
@@ -1662,7 +1663,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 		goto unlock_out;
 	}
 
-	/* Get a handle on the pid of the process to monitor */
+	/* Get a handle on the pid of the session owner */
 	pid = etr_perf->pid;
 
 	/* Do not proceed if this device is associated with another session */
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index c77763b49de0..2671926be62a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -171,8 +171,9 @@ struct etr_buf {
  * @csdev:	component vitals needed by the framework.
  * @miscdev:	specifics to handle "/dev/xyz.tmc" entry.
  * @spinlock:	only one at a time pls.
- * @pid:	Process ID of the process being monitored by the session
- *		that is using this component.
+ * @pid:	Process ID of the process that owns the session that is using
+ *		this component. For example this would be the pid of the Perf
+ *		process.
  * @buf:	Snapshot of the trace data for ETF/ETB.
  * @etr_buf:	details of buffer used in TMC-ETR
  * @len:	size of the available trace for ETF/ETB.
-- 
2.34.1


