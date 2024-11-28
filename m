Return-Path: <linux-kernel+bounces-424752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE1C9DB8E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDB328326C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04F71BD9C5;
	Thu, 28 Nov 2024 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZJ+DZRDv"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6EC158527
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801026; cv=none; b=gwSQR7hZ7Inty5UdQI88XLztjHblDtNmH6SjuTVGIaVXVKOAKmVVxDEGlbncGQ49+A9MQxPU6jV3NEJ2Xlqb0ckiUa/TN9LQVfggah7GqYLupfTqfjMeDB7kCeL6J2fZBT8RQan9jFgXhRfSjxWQzGTO9B5MlBOPtEPoJm/Ouq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801026; c=relaxed/simple;
	bh=50d69piWWU2jaYxxxoAX9izh5i1+CaCy4aEpH5ck7fM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WwgQgAii2an0EiL2KTe6cGr2rH7B7d/JzLD8SOcDuf74qtQYqk82L1K/An4+ckvhMUkNajzMFSRC7CRHjJd8Uw4CBPMvTHuZOdQGDkjkU7f/ZeLShEyPSz6wr0NMw0hptonKn55vGiS0bbAwZ1MlKRJPPmd3JFmOqIN9VhCmzkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZJ+DZRDv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21285c1b196so7812195ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732801024; x=1733405824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgdLWqoEhgyt5G/z7Uvb0KNRe9T81wk05S67wMjuGxY=;
        b=ZJ+DZRDv5M2Degdik/SSLlV86pFgsPsF/Z7jjPMog66MvU6ZwYp0k1ZKj7a4drq907
         1+0HNyYjY2OrYfc5rFvrocqNl4FfsilgwTFxCu/5llB66AOqWgHLBmEOaExRV8kwV8ZA
         v/lnf78b5htj8C/gd4+D7UDOBQsb7t/2VBOVS/il5RMS83Y5OBIelQEylJWZMbHO4480
         DHOXu+i7u/o4tzEdAXe69MfKhFEkpcUYa/eRIcu1QPr3A3wxCSMwBRoWsXxRoRwzKkEt
         h7G2nNCT8OkocU5ybPtr61r69T5euixpv+qdAZAx6rB/2CecwKkfIBO/Jdq8zoOZzseJ
         gPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732801024; x=1733405824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgdLWqoEhgyt5G/z7Uvb0KNRe9T81wk05S67wMjuGxY=;
        b=go1t+IwTi3SiRQlid0lkNsT5SHIPGbv6dZ9eg5DgHZknTTsxTn576NoednzbtM3Pth
         63Gwkn/6LOWF5Erp2luwtyBzUR+nSSP8XP8PEFG+SHM00Bq/7egndZ6/Wy+sv454NfCL
         JhGi0kgxqpR6xDRdqQV6AbrAsgQf5kaGi+umUkkw4LrkTAi96dlUUekFZ+frfiEkmTbO
         OPQBRbS6T23Ug7LqfB0e4hA+OJBd+0yJn8Hgz/H+cUGl32uMCJTuoafMWZE3xO5kQEVP
         ++kAaXuQYGShZ11AiVrmd44D9/bWlIfIk1MrTr8s8ioCc1ubYm/6IXljCmGmM6gYlMCU
         P8dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFFZefKv0cm7UUtUDgnVVdl4GdtWqWYj1eGo9mMpQ/Ks3TIHSaocpYUQwV5Z7XFo26br6fNjOa2fT4Wmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpMw/CROuisAP4Pqiifc60uz8pGCtzUoIQMdE/5AzqIo5TzxBe
	6e3auhTJAOZgIeXgLDSsxlbmCoc2lTOC+yXuQo2WEOr0pBwrP/7eQeKq9TXA8RdB3zftnzzU24y
	b
X-Gm-Gg: ASbGncvPNDgDfP2tE5PvC0Eim0O1gBNlrZy+H3i/WZswu4Y8vbxrKa/Nw6WCEp6iWIn
	9fGDmad8CleimiG/sUyqk4aM/gf09BbUXul84M18Ke63mO8EhVXOVSC/7itCiroCWXiOK6vPcf2
	mmn2gX1U+GWkqNP4HDIn/wosRHUbUkXe3cxlsqPWC3qYdpU1jDy/+2eg9iBAo4i6Q3ubEaUNyb0
	HJUPqksUKnHDYnjTGYXQIhFaFzBbj7EhLW547fHVG0e4CNEWVlhOV90aw==
X-Google-Smtp-Source: AGHT+IG1kcWnGOJI3fbIBd0J1173C2aDQsba2PEgZo0mOOfdj4DoYdahDuneldwbxDr6nCD+qCY1WA==
X-Received: by 2002:a17:902:ecc2:b0:212:b2b:6f10 with SMTP id d9443c01a7336-21501088172mr82517785ad.8.1732801024126;
        Thu, 28 Nov 2024 05:37:04 -0800 (PST)
Received: from ubuntu20.04 ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521985632sm12952975ad.206.2024.11.28.05.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:37:03 -0800 (PST)
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
Subject: [RFC 09/12] perf event action: Add parsing builtin pid expr support
Date: Thu, 28 Nov 2024 21:35:50 +0800
Message-Id: <20241128133553.823722-10-yangjihong@bytedance.com>
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

Support parsing of builtin pid expression.

Testcase:
  # perf record -e sched:sched_switch --action 'print("pid = %d\n", pid)'
  pid = 132784
  pid = 0
  pid = 132784
  pid = 132778
  pid = 0
  pid = 0
  pid = 132784
  pid = 0
  pid = 132784
  pid = 0
  pid = 132784
  pid = 0
  pid = 132784
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
index 91a307b89f85..a4817d62bce8 100644
--- a/tools/perf/util/bpf_skel/bpf_record_action.h
+++ b/tools/perf/util/bpf_skel/bpf_record_action.h
@@ -8,6 +8,7 @@
 
 enum __output_format_type {
 	__OUTPUT_FORMAT_TYPE_CPU,
+	__OUTPUT_FORMAT_TYPE_PID,
 	__OUTPUT_FORMAT_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/bpf_skel/record_action.bpf.c b/tools/perf/util/bpf_skel/record_action.bpf.c
index 4b7698554ead..fd44bb3da663 100644
--- a/tools/perf/util/bpf_skel/record_action.bpf.c
+++ b/tools/perf/util/bpf_skel/record_action.bpf.c
@@ -46,6 +46,17 @@ static inline int output_cpu(__u8 *data, int size)
 	return sizeof(__u32);
 }
 
+static inline int output_pid(__u8 *data, int size)
+{
+	__u32 *pid = (__u32 *)data;
+
+	if (size < sizeof(__u32))
+		return -1;
+
+	*pid = bpf_get_current_pid_tgid() >> 32;
+	return sizeof(__u32);
+}
+
 SEC("xxx")
 int sample_output(u64 *ctx)
 {
@@ -68,6 +79,9 @@ int sample_output(u64 *ctx)
 		case __OUTPUT_FORMAT_TYPE_CPU:
 			ret = output_cpu(data + total, __OUTPUT_DATA_MAX_SIZE - total);
 			break;
+		case __OUTPUT_FORMAT_TYPE_PID:
+			ret = output_pid(data + total, __OUTPUT_DATA_MAX_SIZE - total);
+			break;
 		default:
 			ret = -1;
 			break;
diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
index 2bb32cc16ae7..0ae998a5d286 100644
--- a/tools/perf/util/parse-action.c
+++ b/tools/perf/util/parse-action.c
@@ -13,6 +13,7 @@
  *     - print
  *   - builtin:
  *     - cpu
+ *     - pid
  */
 
 #include <regex.h>
diff --git a/tools/perf/util/parse-action.h b/tools/perf/util/parse-action.h
index ee949ed07111..e74d3b4e5de8 100644
--- a/tools/perf/util/parse-action.h
+++ b/tools/perf/util/parse-action.h
@@ -28,6 +28,7 @@ enum evtact_expr_call_type {
 
 enum evtact_expr_builtin_type {
 	EVTACT_EXPR_BUILTIN_TYPE_CPU,
+	EVTACT_EXPR_BUILTIN_TYPE_PID,
 	EVTACT_EXPR_BUILTIN_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/parse-action.l b/tools/perf/util/parse-action.l
index dab8066a1038..5a5bbe3e1f94 100644
--- a/tools/perf/util/parse-action.l
+++ b/tools/perf/util/parse-action.l
@@ -104,6 +104,7 @@ ident		[_a-zA-Z][_a-zA-Z0-9]*
 {space}		{ }
 
 cpu		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_CPU);  }
+pid		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_PID);  }
 
 print		{ return call(EVTACT_EXPR_CALL_TYPE_PRINT); }
 
diff --git a/tools/perf/util/record_action.c b/tools/perf/util/record_action.c
index 15e8b1740e32..1d7b603713d1 100644
--- a/tools/perf/util/record_action.c
+++ b/tools/perf/util/record_action.c
@@ -96,6 +96,10 @@ static int set_expr_builtin_output_format(struct evtact_expr *expr,
 		*format = __OUTPUT_FORMAT_TYPE_CPU;
 		size = sizeof(u32);
 		break;
+	case EVTACT_EXPR_BUILTIN_TYPE_PID:
+		*format = __OUTPUT_FORMAT_TYPE_PID;
+		size = sizeof(u32);
+		break;
 	default:
 		pr_err("set expr builtin output format unknown opcode: %u\n", opcode);
 		return -1;
-- 
2.25.1


