Return-Path: <linux-kernel+bounces-424754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 279709DB8ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72C3AB254CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318D41B3940;
	Thu, 28 Nov 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CohC4Icn"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068441AE01D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801039; cv=none; b=dWlOA2rm5fRm4cFP4EdnsGmfFKFTtveeInj8LlkRrHazVPlOJH3ocO7HhZqS8FIdEDfDfUrxMm5e9Qxe/+agcg/7VcN9Fu+HM1TA3MvBqnsMxl9ySiG1tJBsgPSVOEjsJjk6p3qFn87t3bAGV/uwpR2NnSsTThjmUT6sn//m9Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801039; c=relaxed/simple;
	bh=aCJwLOVVtyE/8Zq+i3p+hR8TjcyJ97yAVt7uvU+jGmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JunHIJcXRYHYH3RnPalaaoAWM99s94aSmWz41Rxz1BmSY4niJys3qgg7gifZEqeEkv1+SijIHqpyZ5ioG0WYB9PSNIQVG6qMEQP/gI4tIZFs56sYk/a3sTjKHenW/+gxqtjGe29lbof7kUisxlomq8OidpnfWZ1ApfsmypZy62k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CohC4Icn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21263dbbbc4so8188325ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732801037; x=1733405837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwyLyxXascgIdIFuCrV9bXavAvFUrbiIh9Has6iaSvs=;
        b=CohC4IcnixUqUkvaXmr/sm4/HHjvCSfGL/bl6QusaaXUReAq0t1+N1DLX5p5fboexf
         Lox3EI51amleRMfWKticatlr+uvu2zq87QSrge4S2GrNi46g8oEMDed0/Qn4E0JM9Eis
         weCmF1pDVKOBQ54zalfAXAaLXakaWt61pIeUKk3qY4nDOS2F9fsx0npbqONBWTwJRaGk
         6jgGl7gkYbCr7MBlcdWYOYmaC/jWM8YZU4yxQfvMSH67iVxohYpZukYJ68EbE12dMl7b
         qAt9e+Mspy49ctKroMXyAW7CRfdBYJc/zzQ6DQZxLVmjbJ+Jg1p48vMkO9N7MCaEQKXP
         TXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732801037; x=1733405837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwyLyxXascgIdIFuCrV9bXavAvFUrbiIh9Has6iaSvs=;
        b=tH76W8AWWNM0PK50k8EUrx+1eWhwNZm8mX9drBxR6PJd1LsSZV6MVrMP9FPOcFgceU
         7mJ2H2UR99x6vmY8odEle9nMRSvJurKDgcLANv6owHBIRSNvxrh+noLb6z+zB9kbKkmO
         2lu+VOMvzMCuHmHOHGuEQDmRrT0W3RrKR5FQ3J9S4Tpkq5XhOhBwYqqEUHHKR0VqZiB8
         KJrJcbJ1W+KgPxeOAQ2mN0TTKVRt1ASCr4enzbQNRf9z8yqeZTBqMXVSKaDIpyjcsLeb
         nUXHlRykrT67WghrlgWz6dhYIKee+9lcq1NPBrHtAoRmKy6A5R6jYJ/pP8Qfkk8kZmU1
         yOBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvSXZkfKUTdE6PTO5373LPhyanvc7Dj0S+BZw1t14IvdRTCc+14xVJEZWelTWnar+yfLqwLMr9CS/y1GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHuPUj7uI5138D2fCbZnHZ48f+nu7peqvKqTqSmMTMeHJM0koA
	RomyLraCklZMT92mR4g457uvUbH9SznlKKlLTUEjVHhMi4AtKS9d3j2VEaWx5Hw=
X-Gm-Gg: ASbGncvpApjVgrxowqKKqfgUvm+CJD50jsCzlPGMSBCBOe6+o5L5JGitHxIrIOoSt+R
	Kzt5v+GLlm0n3yB47qIqKSBEtnk+4Uw0c7KwR4ExdCIQ7gymEcMTbzRZDNq7syz56w8neMm0AQv
	ewvJxdayHxAnHSyTdV71GqsStZscYm7tHlkqK1cdVmblHwVh1THV9sVQk8UoihjiuoKAB+ymxrJ
	gFFdXludxRzifcVliFR3Ooy9yvwo+ffKmWQj6GgoUbmW0WjSfbeTNPjmw==
X-Google-Smtp-Source: AGHT+IE4a3HwlWMVvu8/IkbUqmVlhEIwHVCXNf6Xu3znJAzuSXsDK+/mKFwZPq9Fisvr4knYX9PbVQ==
X-Received: by 2002:a17:902:ce88:b0:20c:c9db:7c45 with SMTP id d9443c01a7336-215010921d9mr72930415ad.20.1732801037414;
        Thu, 28 Nov 2024 05:37:17 -0800 (PST)
Received: from ubuntu20.04 ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521985632sm12952975ad.206.2024.11.28.05.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:37:14 -0800 (PST)
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
Subject: [RFC 11/12] perf event action: Add parsing builtin comm expr support
Date: Thu, 28 Nov 2024 21:35:52 +0800
Message-Id: <20241128133553.823722-12-yangjihong@bytedance.com>
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

Support parsing of builtin comm expression.

Testcase:
  # perf record -e sched:sched_switch --action 'print("comm = %s\n", comm)' true
  comm = perf
  comm = swapper/7
  comm = perf
  comm = swapper/7
  comm = swapper/1
  comm = perf
  comm = kworker/u40:0
  comm = perf
  comm = kworker/u40:0
  ...
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/util/bpf_skel/bpf_record_action.h |  1 +
 tools/perf/util/bpf_skel/record_action.bpf.c | 19 +++++++++++++++++++
 tools/perf/util/parse-action.c               |  1 +
 tools/perf/util/parse-action.h               |  1 +
 tools/perf/util/parse-action.l               |  1 +
 tools/perf/util/record_action.c              |  4 ++++
 6 files changed, 27 insertions(+)

diff --git a/tools/perf/util/bpf_skel/bpf_record_action.h b/tools/perf/util/bpf_skel/bpf_record_action.h
index 1d2ffa3c260f..325964b7aac9 100644
--- a/tools/perf/util/bpf_skel/bpf_record_action.h
+++ b/tools/perf/util/bpf_skel/bpf_record_action.h
@@ -10,6 +10,7 @@ enum __output_format_type {
 	__OUTPUT_FORMAT_TYPE_CPU,
 	__OUTPUT_FORMAT_TYPE_PID,
 	__OUTPUT_FORMAT_TYPE_TID,
+	__OUTPUT_FORMAT_TYPE_COMM,
 	__OUTPUT_FORMAT_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/bpf_skel/record_action.bpf.c b/tools/perf/util/bpf_skel/record_action.bpf.c
index b6049b9af055..f809305b16be 100644
--- a/tools/perf/util/bpf_skel/record_action.bpf.c
+++ b/tools/perf/util/bpf_skel/record_action.bpf.c
@@ -68,6 +68,22 @@ static inline int output_tid(__u8 *data, int size)
 	return sizeof(__u32);
 }
 
+static inline int output_comm(__u8 *data, int size)
+{
+	struct task_struct *task = (struct task_struct *)bpf_get_current_task();
+
+	if (!task) {
+		data[0] = '\0';
+		return 0;
+	}
+
+	if (size < __TASK_COMM_MAX_SIZE)
+		return -1;
+
+	bpf_core_read_str(data, __TASK_COMM_MAX_SIZE, &task->comm);
+	return __TASK_COMM_MAX_SIZE;
+}
+
 SEC("xxx")
 int sample_output(u64 *ctx)
 {
@@ -96,6 +112,9 @@ int sample_output(u64 *ctx)
 		case __OUTPUT_FORMAT_TYPE_TID:
 			ret = output_tid(data + total, __OUTPUT_DATA_MAX_SIZE - total);
 			break;
+		case __OUTPUT_FORMAT_TYPE_COMM:
+			ret = output_comm(data + total, __OUTPUT_DATA_MAX_SIZE - total);
+			break;
 		default:
 			ret = -1;
 			break;
diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
index 6928990c9106..8bc1646abe27 100644
--- a/tools/perf/util/parse-action.c
+++ b/tools/perf/util/parse-action.c
@@ -15,6 +15,7 @@
  *     - cpu
  *     - pid
  *     - tid
+ *     - comm
  */
 
 #include <regex.h>
diff --git a/tools/perf/util/parse-action.h b/tools/perf/util/parse-action.h
index 817e2c4213e0..39fb521f3193 100644
--- a/tools/perf/util/parse-action.h
+++ b/tools/perf/util/parse-action.h
@@ -30,6 +30,7 @@ enum evtact_expr_builtin_type {
 	EVTACT_EXPR_BUILTIN_TYPE_CPU,
 	EVTACT_EXPR_BUILTIN_TYPE_PID,
 	EVTACT_EXPR_BUILTIN_TYPE_TID,
+	EVTACT_EXPR_BUILTIN_TYPE_COMM,
 	EVTACT_EXPR_BUILTIN_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/parse-action.l b/tools/perf/util/parse-action.l
index 2ada6b4bf091..ddac305c1ca4 100644
--- a/tools/perf/util/parse-action.l
+++ b/tools/perf/util/parse-action.l
@@ -106,6 +106,7 @@ ident		[_a-zA-Z][_a-zA-Z0-9]*
 cpu		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_CPU);  }
 pid		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_PID);  }
 tid		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_TID);  }
+comm		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_COMM); }
 
 print		{ return call(EVTACT_EXPR_CALL_TYPE_PRINT); }
 
diff --git a/tools/perf/util/record_action.c b/tools/perf/util/record_action.c
index f4db98b7df4d..ead7eeffb7cc 100644
--- a/tools/perf/util/record_action.c
+++ b/tools/perf/util/record_action.c
@@ -104,6 +104,10 @@ static int set_expr_builtin_output_format(struct evtact_expr *expr,
 		*format = __OUTPUT_FORMAT_TYPE_TID;
 		size = sizeof(u32);
 		break;
+	case EVTACT_EXPR_BUILTIN_TYPE_COMM:
+		*format = __OUTPUT_FORMAT_TYPE_COMM;
+		size = __TASK_COMM_MAX_SIZE;
+		break;
 	default:
 		pr_err("set expr builtin output format unknown opcode: %u\n", opcode);
 		return -1;
-- 
2.25.1


