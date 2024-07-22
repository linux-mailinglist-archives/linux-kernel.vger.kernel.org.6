Return-Path: <linux-kernel+bounces-258851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 117E5938D55
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BC21F2425C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EC916DC36;
	Mon, 22 Jul 2024 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLZ54Yaf"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED15716DC1B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643215; cv=none; b=NQ7aFXMwVopijWHTmWBydb+sRTyeAG6iNZ+k4n8VX4mhKKWed4TJgqUuzRO6JAwGSGyV/TzppjhqQGC8JOOMnX+PTB44OAaJZ+tUbtuA9Zi19CAB7OD/86qbK4Uy78k1r17NEkUR/7Q0PhyfREU54tAEhqNhh7fQ0V5+ELAuwAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643215; c=relaxed/simple;
	bh=ItH9f426qXV+5rIZSG9tiSgqcCYNUSF0NPfya/+tqmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nBAtuzW2cCRIFzYsBCRn0sdmrX32l2ISsPu+SSM+XFkCwRKXYxZt1EoAYwnBytkz8hjcFhfw/y7UCSJ+Vzpf0AV2PL48GwB/9tOvYT4SDvXyWafHb7PUoftE9IDxw3gT3lk+MpjXC+QQVBZ1ldmokbGHXRiW2YZcyPshzsQWB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aLZ54Yaf; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so51756621fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643212; x=1722248012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gac0SAR3KAIOUnKehRmkrRiaYS0y2TNr3epiBL0LQk8=;
        b=aLZ54YafX1paBdvvDhiozd5QD4RCMDtEZxQuSfC1iieNR178jtOhM28ohmLBABpPIf
         HmDBM67kJqCZxEbie4tEAGeZBK1jcJzV63eA2k/ECg5SXzs5YWym9fBbbrcFDlKs08bC
         tVcN08SNbTpZnhHUDlFq1mQSHJvGBYTlgVXwG9Z3TPDM2rUXO2YqWcDwpe5kDDIcxReq
         mTKsRzR7FMRaDqWMvWx8xZTgV2kLrZ9wCOfU9nYY6ftalwZHKfRbe25V8zfuOEZqGb9F
         vO0u8Vm2ERY71qQEoGT2Zr10PoE3HcagCn/Is9fZY5+9j33H8sFx/Fm7vEUmA6mHNECG
         KCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643212; x=1722248012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gac0SAR3KAIOUnKehRmkrRiaYS0y2TNr3epiBL0LQk8=;
        b=q/fnEDiR8MUizlk/HuWRuaPr67rv52pDeYBzAv/hfgDLtDFkQ+VXpPQfKMkC+/QeZB
         8KJRSfO5qm0xsdqWBk5zHcP+ufzKE/E1RFM4Ml1qWg5cHQ1bA5V2OsPIZnoiF2FJ3a+K
         KMcZ+7ZfMsNhPXScOsz1GlmN5yBvuhYPiEoba/28cNPDDpaqNfXiKgn3uxO1jsXXlLWh
         jVjvVeACyIVgeUQZaIkHxyle8zUbyVEdJd8LGZ7Tr3K5JrP7l3MfVPpZsYdGEn2q3OtO
         3ESPd3jxJqUYBoYx55GXCnbNgvwBb+PQ4I9FJJScjgecY0Nb9oFsm4Mue9eeWLW1zzXh
         1piw==
X-Forwarded-Encrypted: i=1; AJvYcCVhHZ6EI4rywOpPqM4mNtJNFPc28KIEmgJP0Tdsil/Dr8fyKEfJXy8luAmS7OwatUrni9cOHvl/bVh/+PAi5PYYSKYWw5/Q9O3jDImD
X-Gm-Message-State: AOJu0Yz0uESigs2cqV4ZjR2NK4J+U6gGPACio3KuKwDkB9b0wr/6rieb
	ADgdscW5FdXZZ3fH3q/BmGvL+RDufGgc/dLfdu9SHOXXSOsgAAvlYkMvXPl4ADY=
X-Google-Smtp-Source: AGHT+IGTZQIhy3gNPKPI7DGy65qUrKCQGhBq5C4l1bUGJPNsWt1iC1rZkJ6h0IJVzpzgCf+Q3zsCVw==
X-Received: by 2002:a2e:92d5:0:b0:2ef:2cbc:9074 with SMTP id 38308e7fff4ca-2ef2cbc91c3mr21432381fa.21.1721643212217;
        Mon, 22 Jul 2024 03:13:32 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:13:31 -0700 (PDT)
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
Subject: [PATCH v6 13/17] coresight: Make CPU id map a property of a trace ID map
Date: Mon, 22 Jul 2024 11:11:55 +0100
Message-Id: <20240722101202.26915-14-james.clark@linaro.org>
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

The global CPU ID mappings won't work for per-sink ID maps so move it to
the ID map struct. coresight_trace_id_release_all_pending() is hard
coded to operate on the default map, but once Perf sessions use their
own maps the pending release mechanism will be deleted. So it doesn't
need to be extended to accept a trace ID map argument at this point.

Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-trace-id.c | 16 +++++++++-------
 include/linux/coresight.h                        |  1 +
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index 5561989a03fa..8a777c0af6ea 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -13,10 +13,12 @@
 #include "coresight-trace-id.h"
 
 /* Default trace ID map. Used in sysfs mode and for system sources */
-static struct coresight_trace_id_map id_map_default;
+static DEFINE_PER_CPU(atomic_t, id_map_default_cpu_ids) = ATOMIC_INIT(0);
+static struct coresight_trace_id_map id_map_default = {
+	.cpu_map = &id_map_default_cpu_ids
+};
 
-/* maintain a record of the mapping of IDs and pending releases per cpu */
-static DEFINE_PER_CPU(atomic_t, cpu_id) = ATOMIC_INIT(0);
+/* maintain a record of the pending releases per cpu */
 static cpumask_t cpu_id_release_pending;
 
 /* perf session active counter */
@@ -49,7 +51,7 @@ static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
 /* unlocked read of current trace ID value for given CPU */
 static int _coresight_trace_id_read_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
 {
-	return atomic_read(&per_cpu(cpu_id, cpu));
+	return atomic_read(per_cpu_ptr(id_map->cpu_map, cpu));
 }
 
 /* look for next available odd ID, return 0 if none found */
@@ -145,7 +147,7 @@ static void coresight_trace_id_release_all_pending(void)
 		clear_bit(bit, id_map->pend_rel_ids);
 	}
 	for_each_cpu(cpu, &cpu_id_release_pending) {
-		atomic_set(&per_cpu(cpu_id, cpu), 0);
+		atomic_set(per_cpu_ptr(id_map_default.cpu_map, cpu), 0);
 		cpumask_clear_cpu(cpu, &cpu_id_release_pending);
 	}
 	spin_unlock_irqrestore(&id_map_lock, flags);
@@ -181,7 +183,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
 		goto get_cpu_id_out_unlock;
 
 	/* allocate the new id to the cpu */
-	atomic_set(&per_cpu(cpu_id, cpu), id);
+	atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), id);
 
 get_cpu_id_clr_pend:
 	/* we are (re)using this ID - so ensure it is not marked for release */
@@ -215,7 +217,7 @@ static void _coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_ma
 	} else {
 		/* otherwise clear id */
 		coresight_trace_id_free(id, id_map);
-		atomic_set(&per_cpu(cpu_id, cpu), 0);
+		atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
 	}
 
 	spin_unlock_irqrestore(&id_map_lock, flags);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index c16c61a8411d..7d62b88bfb5c 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -234,6 +234,7 @@ struct coresight_sysfs_link {
 struct coresight_trace_id_map {
 	DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
 	DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
+	atomic_t __percpu *cpu_map;
 };
 
 /**
-- 
2.34.1


