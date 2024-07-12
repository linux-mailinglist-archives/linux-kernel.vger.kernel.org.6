Return-Path: <linux-kernel+bounces-250542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF4992F8E6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEE61C22D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C4916F273;
	Fri, 12 Jul 2024 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s9MInaUI"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAAF16F265
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779778; cv=none; b=lYDn6VbQ9UuqAkF/TnI+Ot6DyhsNsqi9UdRKbHQNH5TzDkonxCQ4pb6dqTR1hqph7FA3rRWOoidzPbXIqCcTIrPf/RGFNTLss8RiNGy9H9IkIcWNbaYA9GD8kuWQeR7jJyL8VUpm1ZBLB2Toy+hG4WOudBWDO33v2e6WiUZSTW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779778; c=relaxed/simple;
	bh=3iG7U2XDNM7p4gkeRnqaYrTMtJwrySSh0VDaDQ9ox2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rFU0pGiFkMpF81OYiUWdJlmuKQhD4lRhWupk0lY7UaqLmsbEkD/v0gcEENHw5bxPlbj0Co1Mt1rf0sq3hNF1nD08fThB+13ku+2311p1tLmWRjLdOcLZBCAPmGQkJC5aMWuumZwytDMaJFvGVKyuJtBAGJ9AbmpKonaf9iiMfp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s9MInaUI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-367a081d1cdso976890f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779775; x=1721384575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmWH7agSbHonx/R3+MefD7iRtWhdpwSVOkyLggPVZz8=;
        b=s9MInaUICc89bVM5kc70sXT5+Y5+F+6r4bZdLjDFNuPKLgOGuTC6pABQOq/N5hO5F9
         0NFI0fA+Oo0t7H/NYHE5LDDdCRJAANpW8RnyFM8QCGFe3JqWlz+VyY6stIhfB3mMav6s
         LzJF8NtEa9BszD3O5cRW6sGdNe6OqBjh+C1tn2PvfWm2ZpQ2zubpAvHQZCaGRQx9xbV8
         kchkjriMzG4LJ/f5G5PupiolU2wyEPVaQLxlwLhCRSO3DPGpnrSOEI5Rjp6hQ2vDd/aM
         aOBg/yZA0apGZQp7CAlTVio+CQn789TDm1tFuVRr+bMwog93hggNszJphClkHdaiRr4q
         ooAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779775; x=1721384575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmWH7agSbHonx/R3+MefD7iRtWhdpwSVOkyLggPVZz8=;
        b=WceBgoI3dDVXjh0NQ1EZ30It2l5BgwE9pMgZo+zmCCcH9q+nNBmzRXNLUU3QUhG2vj
         5GhmQA3TwGNS7WPTwIOWTTU1P5qtPEmgI24gbClQO+VNyJ7x9hBYb39TvHWiIFSP/quz
         Ycr54lCEWbO2sx1AQ6R30SvD537QBrBit8wIKUJN7ZoXudjsgd8fpNGGh8lJFj/DuRTf
         K4efBJqXgsJeQWWYG5SSNqRebZ3Ev2PPF7JCRZn7eYpmHKOgKHrT4YVot3KSyLQ0BAc+
         a5Bab3z7C2UlLo4Bi2Lc2Gws4Ydj0f7G7jvJhBN4COnNYejltU473YESyZ5Gi4iYSMzr
         +Mrg==
X-Forwarded-Encrypted: i=1; AJvYcCWVmdj+WsFAhNN2w85iUpEXUExHQVL6OWlrxhYDqRYX6pjJv1tKBcFijvu+k4xY00WmWVvmgApSVe/Ocl5j89kk6kIqdMLZu32Qfv+a
X-Gm-Message-State: AOJu0YwuT+Q0YDVfdMdnPKRj3B8lQuoibQUgc2oPcHZnTZvF4vK213T6
	Xt0AvFard8F9h4dCanIToIuq5fdQeeh+U9cTM0ieaXOL1EddjV9Gg7zfouY5QvY=
X-Google-Smtp-Source: AGHT+IEcDju9t6NYw7w2pn4HE1UlUqGJVIFxet+KybGAhZdj2K7aQZy/5dyu5Tg/5qQTcXTwx+bEdQ==
X-Received: by 2002:adf:b30b:0:b0:366:df65:8763 with SMTP id ffacd0b85a97d-367cea8f94emr7440282f8f.34.1720779775028;
        Fri, 12 Jul 2024 03:22:55 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm9911058f8f.63.2024.07.12.03.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:22:54 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
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
Subject: [PATCH v5 10/17] coresight: Clarify comments around the PID of the sink owner
Date: Fri, 12 Jul 2024 11:20:19 +0100
Message-Id: <20240712102029.3697965-11-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240712102029.3697965-1-james.clark@linaro.org>
References: <20240712102029.3697965-1-james.clark@linaro.org>
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


