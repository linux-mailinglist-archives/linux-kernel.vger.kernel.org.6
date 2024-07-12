Return-Path: <linux-kernel+bounces-250546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 564C492F8EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC00B24B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD3B16F908;
	Fri, 12 Jul 2024 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="idUqtYGO"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ADC16F849
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779792; cv=none; b=Gdym/4ocN07hh0B9Zogwnwv4B6xB1cYDR6Erqx+pU10Sa4AQjeLhfAz062FneCgdjPqTyLKLaZ4ufvjtR7yn1BpCuiH6gqfv6v/mQHSlIvPh67P98916zc7k5rRtrxh5jtUixU+oE8tJjdSw7gTs7S7hE97QZiTquGSDdTSPo7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779792; c=relaxed/simple;
	bh=gnTXbiccgzUnnX4qc4YNi4bpg4hJ80pexWIQs6J5Ydg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r3/ORxMjgRbkcUcvnf19Fq2Ew6z4l6+uV+XMLetFLPZrb8DeCD8OeoJ0VJDWktlsKC5gQXMmSEObkPMRKZ3uq+vfnRoERi300z7g4XV8SbDp8dWn6W/3hWMuGfk/fy/qJQyeGdbZCE5fnpaa3O0fIoGW8+NqHFpaUO1s/goc3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=idUqtYGO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3679f806223so1750217f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779788; x=1721384588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmiqFINbf2RIIt2/HIb6pHgQita750CuprYaFJouhH8=;
        b=idUqtYGOFLQIg9ytG0fKzmRUAmyvgzyNFQ5koUXesQzPps1WJ+Cvs91iVvCNaN0pDN
         2GY8WzAjkss5CpyH25vuaIO/7F8FB7sPmUJ3Pw5LlEmyprQRTF8b2kUZ99vbtRKIUmjq
         wRfoF4oM8kCUgLpTe+qJV4KvQwcLkmBLE4yLBtJSEhN2z6I80bC9YUmuxskUaX/ghf0N
         yIFJMWQNFijnkbpqBhxjv5KjjZ4jo0BIl7IamO4DZe6+87VGBg+AGAHiP4uKMMcnCN72
         iiyQad6IfbmHRU8wN8mbMZpakvJBvlnDf7ZXk8FmU8yomGne8T/iO16mA7gbJgpIAOb5
         3UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779788; x=1721384588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmiqFINbf2RIIt2/HIb6pHgQita750CuprYaFJouhH8=;
        b=j2+CKNlVHoZUTp5nOMeywzqMUD2VcUXT18LQrGfYlFMPP6RxvFP/KjiB3bl6xPbF47
         ZKhuhKaHCLIdatEbdfrVqc+AnspTfFMziJrWd0yHILWUyCdeweT7i+DAZaQSTFhKlIZf
         K0cmD2o5oDS6zYHSRLomo8iAAMIOXFYf9Dj/+Hyip/DPKfYeQr9EutcflE7zOlU3Sfqp
         Hu/gGcLJ5a7iT/+jG/9R2ZAk/sQH1fAFA96LL3AZ0u52SvJrzE5oSOBHj0EIK00ppDNZ
         tCWdfzz3TtIqRHnSdmBrxKX7mDxkFZxoGFo3+GJ6HJH9jJcIX6dLzA8xbRJWVoUHUFYG
         r5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUuzu2O4UhO/+u0vGcm9vhv4nhYtTQ72n0MItRZgfo7WBcnDoGNTWE9q6KSx5rVaRD4UEyFg/cb/A2XNr1DkiMTQUZTnXi6Fs4KxVoV
X-Gm-Message-State: AOJu0YwZQUN0cIqgCTOoombCFalzya1+w0uLehObSEBW7wOJ3LMdiZPv
	AA4C1Bc+8SfZsEyU9IWuk4O/GLaK+PMwJk9SRsGitHhr63SIBJY9WeZU1jkIS9U=
X-Google-Smtp-Source: AGHT+IFKnifONx2hAygp5d6pDLaQbUSgl5BqBFN0FJ2vM12b1+fRzec1gBmGmiVevI48O36kPXQXfg==
X-Received: by 2002:a05:6000:1f84:b0:367:9268:bfca with SMTP id ffacd0b85a97d-367ff705355mr1998840f8f.22.1720779788576;
        Fri, 12 Jul 2024 03:23:08 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm9911058f8f.63.2024.07.12.03.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:23:08 -0700 (PDT)
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
Subject: [PATCH v5 13/17] coresight: Make CPU id map a property of a trace ID map
Date: Fri, 12 Jul 2024 11:20:22 +0100
Message-Id: <20240712102029.3697965-14-james.clark@linaro.org>
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

The global CPU ID mappings won't work for per-sink ID maps so move it to
the ID map struct. coresight_trace_id_release_all_pending() is hard
coded to operate on the default map, but once Perf sessions use their
own maps the pending release mechanism will be deleted. So it doesn't
need to be extended to accept a trace ID map argument at this point.

Signed-off-by: James Clark <james.clark@arm.com>
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


