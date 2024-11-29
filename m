Return-Path: <linux-kernel+bounces-424753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D47B69DB8EA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9490828343D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28171B2181;
	Thu, 28 Nov 2024 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KovYsLmz"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E655158527
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801032; cv=none; b=R4YRMBcyV2G4rtggZJALCh1jKYPe/CXE0LDQp91E1xuH7g6XVE6JwInCDu7E57TgEtLXOXalQy2wOaP+74URssGj19gowYEu40xJfBWwutgwzTpy0S/sdXGr1XLlOsIADYALXQgkEp+iI7+w3Bcrykxp1GlQybI2FojeO/iVfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801032; c=relaxed/simple;
	bh=DiJVAYAQcrZJd8gKJAcZ/lxvrshliSd5sO0F5CaEIj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPGZcL/9UIjYWJ/uF5xA9l6ddupPnprcYsl8dN2tp3zBXhfJeNApPFMJB1LX40FdzwZHFUxOmsuiUFhBnulcb/W/3lPbq/vyY68LV0DIn76c2U7NkM2IjtqILYVvvzvdVW1BixCQ1AbU0rLbSr92VTmujRQEbREFuq4XmmqzAh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KovYsLmz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-212348d391cso6323605ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732801030; x=1733405830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IH0bZMOBu3riqiEWEU9vnXR7lOK6GZQof6s3qx/MtSI=;
        b=KovYsLmzDKLKMvmdSk+pRmZhIUWiDnOqf8mRPW/NkGaVncYwHbPIvNlDuqGE6mDjUT
         8mLYcY4r5iP/QFtWtaI6qXl7AZT+1KcwZK/PGccukd/YxNqWKiFVzkZOMNUpJjZLUlOs
         9UkyI1LFTVIh+jCxB0v8BzCj+jrzgNOjkAAVSs5tRmzfQogWGOFyGLiksSlq5qjXeedZ
         rpg4HGHqBp4SPD+NgSUsfJKF6SuoCyISAX5M/+eJUH4+/JlGQF7o6GWOzE/gV05fU3cv
         Ll5RU4mOnLpHZsx9QE3Fi37jCMOMdvmRhYPE3Yk1bzJxMfwlmcz0ONqK6lMxWh4H4Nxe
         FFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732801030; x=1733405830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IH0bZMOBu3riqiEWEU9vnXR7lOK6GZQof6s3qx/MtSI=;
        b=GOP2k69QdDPy5gnI2kocCO8mGe1Ppr4cYsUS3pUrhrxZX5Hv0/bHEq37oLlwBoMo5L
         0A/UuN9HcusdvEwQDCma6L6EUf9UEKUn2wC6fG2cGldNKP7hxOYuRoaLkJgVycoWZk5j
         kt/qOdNWFLZk9jaodUNE9Vc4YjtB5udrkkPAGFjGqbHQ3OATh8cfgEdA7id9jx3YRwFs
         tHjMGBtCnMIZf7gw8AuXNX7Kl0uIlYZBDqmP014JEy6rpVyejPMiKqOGKqtDK3NMndS6
         jOKHU+FXk43MSAbq4PexGsspGi8IcKbchu97mGxkCCe+T6w86xcw+vh0SAEByO5llILq
         6vkw==
X-Forwarded-Encrypted: i=1; AJvYcCUox+6uS3Oc7idn1/jN0HYp0SDrxPvaHr3JO4BB8Fcp1ZFxt0BPiRTzliqr4EIfeOIbHWvfHXW+n5fEWw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytKI3qfyRbm5h2wkLZ67zutKQfBpNz8j/YprUrA8u8EwxvTzUs
	u6ywzbZ6dN6J0m9c6bac4R90ltnY9/Gxgl03hDNLopL3ubv3+7FFJuQa5lD4qzU=
X-Gm-Gg: ASbGncsEJ78ixbU8hGlAUTghCX5SW5dQ0Sr1BzmHLYU5SC7L5xezt1+NfOWmf7x2knK
	kNZfrcTChbgutMFp7hjrXxqv8FLCizZEVeLYWEAvCkKl+5iGytIAB/tf5x39To52nV4IH+XKiPy
	MrADw+nglLgEdLMJylVREwqTCZT2W6WS4mm1f+FNYv6LGnt6GvI5WDXXtkKSsZlzJgCbhv//OPr
	pnvOPKj63OlrIuq3o/tivvAWc9h3tdl7OutG+7pnMXH0WcVTBJksx7T+g==
X-Google-Smtp-Source: AGHT+IHRR/nnxlLBQ0K72YvBnIQpQxBM2gsi0t+qZpJP/RxQa0B53I/b7kFI4jpJBRiClaBbUkYt4Q==
X-Received: by 2002:a17:902:da92:b0:207:1675:6709 with SMTP id d9443c01a7336-21500fee592mr91980655ad.0.1732801029815;
        Thu, 28 Nov 2024 05:37:09 -0800 (PST)
Received: from ubuntu20.04 ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521985632sm12952975ad.206.2024.11.28.05.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:37:09 -0800 (PST)
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
Subject: [RFC 10/12] perf event action: Add parsing builtin tid expr support
Date: Thu, 28 Nov 2024 21:35:51 +0800
Message-Id: <20241128133553.823722-11-yangjihong@bytedance.com>
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

Support parsing of builtin tid expression.

Testcase:
  # perf record -e sched:sched_switch --action 'print("tid = %d\n", tid)' true
  tid = 134891
  tid = 0
  tid = 134891
  tid = 0
  tid = 0
  tid = 134891
  tid = 132778
  tid = 134891
  tid = 132778
  tid = 134891
  tid = 132778
  tid = 134891
  tid = 132778
  tid = 134891
  tid = 132778
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
index a4817d62bce8..1d2ffa3c260f 100644
--- a/tools/perf/util/bpf_skel/bpf_record_action.h
+++ b/tools/perf/util/bpf_skel/bpf_record_action.h
@@ -9,6 +9,7 @@
 enum __output_format_type {
 	__OUTPUT_FORMAT_TYPE_CPU,
 	__OUTPUT_FORMAT_TYPE_PID,
+	__OUTPUT_FORMAT_TYPE_TID,
 	__OUTPUT_FORMAT_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/bpf_skel/record_action.bpf.c b/tools/perf/util/bpf_skel/record_action.bpf.c
index fd44bb3da663..b6049b9af055 100644
--- a/tools/perf/util/bpf_skel/record_action.bpf.c
+++ b/tools/perf/util/bpf_skel/record_action.bpf.c
@@ -57,6 +57,17 @@ static inline int output_pid(__u8 *data, int size)
 	return sizeof(__u32);
 }
 
+static inline int output_tid(__u8 *data, int size)
+{
+	__u32 *pid = (__u32 *)data;
+
+	if (size < sizeof(__u32))
+		return -1;
+
+	*pid = bpf_get_current_pid_tgid() & 0xffffffff;
+	return sizeof(__u32);
+}
+
 SEC("xxx")
 int sample_output(u64 *ctx)
 {
@@ -82,6 +93,9 @@ int sample_output(u64 *ctx)
 		case __OUTPUT_FORMAT_TYPE_PID:
 			ret = output_pid(data + total, __OUTPUT_DATA_MAX_SIZE - total);
 			break;
+		case __OUTPUT_FORMAT_TYPE_TID:
+			ret = output_tid(data + total, __OUTPUT_DATA_MAX_SIZE - total);
+			break;
 		default:
 			ret = -1;
 			break;
diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
index 0ae998a5d286..6928990c9106 100644
--- a/tools/perf/util/parse-action.c
+++ b/tools/perf/util/parse-action.c
@@ -14,6 +14,7 @@
  *   - builtin:
  *     - cpu
  *     - pid
+ *     - tid
  */
 
 #include <regex.h>
diff --git a/tools/perf/util/parse-action.h b/tools/perf/util/parse-action.h
index e74d3b4e5de8..817e2c4213e0 100644
--- a/tools/perf/util/parse-action.h
+++ b/tools/perf/util/parse-action.h
@@ -29,6 +29,7 @@ enum evtact_expr_call_type {
 enum evtact_expr_builtin_type {
 	EVTACT_EXPR_BUILTIN_TYPE_CPU,
 	EVTACT_EXPR_BUILTIN_TYPE_PID,
+	EVTACT_EXPR_BUILTIN_TYPE_TID,
 	EVTACT_EXPR_BUILTIN_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/parse-action.l b/tools/perf/util/parse-action.l
index 5a5bbe3e1f94..2ada6b4bf091 100644
--- a/tools/perf/util/parse-action.l
+++ b/tools/perf/util/parse-action.l
@@ -105,6 +105,7 @@ ident		[_a-zA-Z][_a-zA-Z0-9]*
 
 cpu		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_CPU);  }
 pid		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_PID);  }
+tid		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_TID);  }
 
 print		{ return call(EVTACT_EXPR_CALL_TYPE_PRINT); }
 
diff --git a/tools/perf/util/record_action.c b/tools/perf/util/record_action.c
index 1d7b603713d1..f4db98b7df4d 100644
--- a/tools/perf/util/record_action.c
+++ b/tools/perf/util/record_action.c
@@ -100,6 +100,10 @@ static int set_expr_builtin_output_format(struct evtact_expr *expr,
 		*format = __OUTPUT_FORMAT_TYPE_PID;
 		size = sizeof(u32);
 		break;
+	case EVTACT_EXPR_BUILTIN_TYPE_TID:
+		*format = __OUTPUT_FORMAT_TYPE_TID;
+		size = sizeof(u32);
+		break;
 	default:
 		pr_err("set expr builtin output format unknown opcode: %u\n", opcode);
 		return -1;
-- 
2.25.1


