Return-Path: <linux-kernel+bounces-424755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AA99DB8EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290B4B224CD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED89C1AE01D;
	Thu, 28 Nov 2024 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j1gmhwxI"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E421BFE0D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801045; cv=none; b=PX8JuMCVhtNDZMzcJ3m6AimXhALtZA4JjA6PcIXIGmsg1/3/aGwKMVnB2iR1wlki6oL0f1dFCluEqrg0QYeOzmJQhVYlPROPYmSrPdb5FdNwIQTGreLYre0XdweKTfvMiu27jm87dcEmW4e4TWNygMaAc8gBny/2n9U2uC0/d70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801045; c=relaxed/simple;
	bh=Ku4hN7xfqlPUv5w30C4DCKNBadD3qKAbjpkGgl0RasU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FQsPx8pIs79zlyJppoxrAPKNWQFC6/lbThYQ6Edv8uXpgunmCa5xlqDjko68errwavng5o3yosYigP1wnCvPyZCvOEgEnca77/CgX5WSvKRvjwha2obD8CsVa6iQrBoTXkmQDfoESWUvzMxrPgK6UvzVIgmdSfIylEPJxW9mQZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=j1gmhwxI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21200c749bfso7383925ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732801043; x=1733405843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEQuel0RUI05tTYvOewxgm0mSB+lb7Esf6H6O4xZV1s=;
        b=j1gmhwxIMg4u/5OJ7PCjiCw94uQTNdIXIoJhvQNmv4QczEWkbWOZsOQX235Bo8jcqb
         Uf4k9najhsdEAUa1TdnLOrx35360hGkIxc6bgZMj9h+kSj9NRoGGz3IS0u8PJdVCTC3C
         QnrnKHGYZ+g36Gl7EvtO+YIjHnGJuD9RC24muouOW2EKplO0mVDCZhC2fbi6w7Nscqwq
         EM8JDAP733LEotG0kwzZ8931vVRMZafcv/AnDhVZurrQzdX9vFD89qScB3s1AQ+ilHCC
         IQjP9z/c4THJuQmXlpTxCw6kFWxoIW6piIJJhl75IwCFdecnIwaP5z06QIYC9BJQ9hN9
         A3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732801043; x=1733405843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEQuel0RUI05tTYvOewxgm0mSB+lb7Esf6H6O4xZV1s=;
        b=CmZ0ZxWFmMiNxQ6KxEzUXT5eJGuefZE5kXtRHJZvHC1c+dXhXZ8L0W7mPMNUa6HGzk
         aK0Poz/WfBmx41VMVD8a8KIL6Vm+z1afDEHBR/PcKdfaHkv1SDIo7Ha+ZINwxyEEMjIo
         8carh5vaxW6r3JWEiTY4fJcA6ACqxd0RMPSDoDWJD7a/7sTSuyiJmo3Kv1M0kmD4nsLw
         TP0h424Yhx+IRwW0UoHMSZNAI61PcpY7nCXFTM91sZRylXMGNbo2R3XQ+Avg7FU0muaF
         uIpEZ3HUqTP1qK45dK8Araxf9hN4Ar0jFgLUUIrskYfVqTe49Rp5uT/1ECKYaz5Nrd8x
         LM7w==
X-Forwarded-Encrypted: i=1; AJvYcCW4eHhvbS8CKFKzghgWqKxtKqlsqxyypHuao0v7vwEJwU56E7PAXakq/kyiNJ42XdC2TTnJX8KypUnnimE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwflmC5mjcmpLKTf3oXKl54HRtTMCR0ESQluVqIecJkLbsUA84M
	noVDxSw5Cbk1nzJWYeOPyNKymvDzBWNuTf7yOE/WiwbQCXX7OTjWNz2RjSGiGig=
X-Gm-Gg: ASbGncs5iJuO0dvFwnWkBRoJ4ia3ILKEER4dTzpOgrS1JaABw/Cr2IN6trYIxxx8721
	FHCnf6kKckXR3139zfBy7mmuzboT+eogackt98jlaIdNYmeMwYUUvcYwStJ3SiiUzDd0xcHDeSK
	gI6Jmh5Y98ChW+VZVmuQ8bNcbSoQLUczVKdJ3R4poasWTEvFONQoFCTjNXmlj7BcynJSWmSpKUY
	L5Q6jeeoa95bLW07GeMAZycCm7WGoqG+vDfkwn6W62fZXH4+GxL2Hg3IQ==
X-Google-Smtp-Source: AGHT+IGJDPD9pE+AeJXDwNp8BJXO/DIHoUo2WDZp9IvM7Np2ou1DN2+QaRrIFaalT7td21LjD7k1Vw==
X-Received: by 2002:a17:902:fc47:b0:20c:6bff:fcae with SMTP id d9443c01a7336-21501095f5fmr92201495ad.5.1732801043131;
        Thu, 28 Nov 2024 05:37:23 -0800 (PST)
Received: from ubuntu20.04 ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521985632sm12952975ad.206.2024.11.28.05.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:37:22 -0800 (PST)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [RFC 12/12] perf event action: Add parsing builtin time expr support
Date: Thu, 28 Nov 2024 21:35:53 +0800
Message-Id: <20241128133553.823722-13-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128133553.823722-1-yangjihong@bytedance.com>
References: <20241128133553.823722-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support parsing of builtin time expression.

Testcase:
  # perf record -e sched:sched_switch --action 'print("time = %llu\n", time)' true
  time = 787661350481404
  time = 787661350483823
  time = 787661350493754
  time = 787661350623109
  time = 787661350482984
  time = 787661350642538
  time = 787661350647575
  time = 787661350649706
  time = 787661350650968
  time = 787661350653686
  time = 787661350654928
  ...
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/util/bpf_skel/bpf_record_action.h |  1 +
 tools/perf/util/bpf_skel/record_action.bpf.c | 14 ++++++++++++++
 tools/perf/util/parse-action.c               |  1 +
 tools/perf/util/parse-action.h               |  1 +
 tools/perf/util/parse-action.l               |  1 +
 tools/perf/util/record_action.c              |  4 ++++
 6 files changed, 22 insertions(+)

diff --git a/tools/perf/util/bpf_skel/bpf_record_action.h b/tools/perf/util/bpf_skel/bpf_record_action.h
index 325964b7aac9..e514ac14705e 100644
--- a/tools/perf/util/bpf_skel/bpf_record_action.h
+++ b/tools/perf/util/bpf_skel/bpf_record_action.h
@@ -11,6 +11,7 @@ enum __output_format_type {
 	__OUTPUT_FORMAT_TYPE_PID,
 	__OUTPUT_FORMAT_TYPE_TID,
 	__OUTPUT_FORMAT_TYPE_COMM,
+	__OUTPUT_FORMAT_TYPE_TIME,
 	__OUTPUT_FORMAT_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/bpf_skel/record_action.bpf.c b/tools/perf/util/bpf_skel/record_action.bpf.c
index f809305b16be..ed36f121e90b 100644
--- a/tools/perf/util/bpf_skel/record_action.bpf.c
+++ b/tools/perf/util/bpf_skel/record_action.bpf.c
@@ -84,6 +84,17 @@ static inline int output_comm(__u8 *data, int size)
 	return __TASK_COMM_MAX_SIZE;
 }
 
+static inline int output_time(__u8 *data, int size)
+{
+	__u64 *ts = (__u64 *)data;
+
+	if (size < sizeof(__u64))
+		return -1;
+
+	*ts = bpf_ktime_get_ns();
+	return sizeof(__u64);
+}
+
 SEC("xxx")
 int sample_output(u64 *ctx)
 {
@@ -115,6 +126,9 @@ int sample_output(u64 *ctx)
 		case __OUTPUT_FORMAT_TYPE_COMM:
 			ret = output_comm(data + total, __OUTPUT_DATA_MAX_SIZE - total);
 			break;
+		case __OUTPUT_FORMAT_TYPE_TIME:
+			ret = output_time(data + total, __OUTPUT_DATA_MAX_SIZE - total);
+			break;
 		default:
 			ret = -1;
 			break;
diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
index 8bc1646abe27..4f40e4a24357 100644
--- a/tools/perf/util/parse-action.c
+++ b/tools/perf/util/parse-action.c
@@ -16,6 +16,7 @@
  *     - pid
  *     - tid
  *     - comm
+ *     - time
  */
 
 #include <regex.h>
diff --git a/tools/perf/util/parse-action.h b/tools/perf/util/parse-action.h
index 39fb521f3193..57df6f8294f5 100644
--- a/tools/perf/util/parse-action.h
+++ b/tools/perf/util/parse-action.h
@@ -31,6 +31,7 @@ enum evtact_expr_builtin_type {
 	EVTACT_EXPR_BUILTIN_TYPE_PID,
 	EVTACT_EXPR_BUILTIN_TYPE_TID,
 	EVTACT_EXPR_BUILTIN_TYPE_COMM,
+	EVTACT_EXPR_BUILTIN_TYPE_TIME,
 	EVTACT_EXPR_BUILTIN_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/parse-action.l b/tools/perf/util/parse-action.l
index ddac305c1ca4..9029ac19c128 100644
--- a/tools/perf/util/parse-action.l
+++ b/tools/perf/util/parse-action.l
@@ -107,6 +107,7 @@ cpu		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_CPU);  }
 pid		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_PID);  }
 tid		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_TID);  }
 comm		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_COMM); }
+time		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_TIME); }
 
 print		{ return call(EVTACT_EXPR_CALL_TYPE_PRINT); }
 
diff --git a/tools/perf/util/record_action.c b/tools/perf/util/record_action.c
index ead7eeffb7cc..4de6afcbfb26 100644
--- a/tools/perf/util/record_action.c
+++ b/tools/perf/util/record_action.c
@@ -108,6 +108,10 @@ static int set_expr_builtin_output_format(struct evtact_expr *expr,
 		*format = __OUTPUT_FORMAT_TYPE_COMM;
 		size = __TASK_COMM_MAX_SIZE;
 		break;
+	case EVTACT_EXPR_BUILTIN_TYPE_TIME:
+		*format = __OUTPUT_FORMAT_TYPE_TIME;
+		size = sizeof(u64);
+		break;
 	default:
 		pr_err("set expr builtin output format unknown opcode: %u\n", opcode);
 		return -1;
-- 
2.25.1


