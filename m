Return-Path: <linux-kernel+bounces-445571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 948509F17CA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B1E16C2EB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73798199FBA;
	Fri, 13 Dec 2024 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ywx6XmXO"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD811198836
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123881; cv=none; b=DNkBQg3mgV8H7KvDZFST0ymNqXMQsHbagbJVYqZ3ohNOS6k1ze7xe7t6n+dSyCtWFNKK0dw3VNUVNSwB9K5Ha3PXgvG7V+pNYLgwrPtJ3tMnVKivVMaP+Eglg0VbldI7j+h350UAgyEqf2xSstkhA8ssySuQu44oNfK5m0abY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123881; c=relaxed/simple;
	bh=2AeeJI7hTLZBkAiyK/DWI/sFdQ+nhO6KpS8lk3LdjMw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZG1WKkRAzdXZTnvnNSNQnatTofh5ULLNAcRiyax/4qhyFwuQLWElyubpPdMKjwY9Fwql9ce4VxqNuDtq0hiTIyvYQCCT16PiXJDPzadiuj5omxROUCkQWLJhst49HV0HCMiKuPb/o6RPduw58pbkwaYOT1gzDMXwEH9h5Xdr8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ywx6XmXO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e38dbc5d05bso3365824276.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123879; x=1734728679; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BO6MitYTG3PPlOm9eDgi+DN2s8ThN2cAWOELNwnMFAI=;
        b=Ywx6XmXOlGyb2ROuRL5cX+rWOMyxHMIt+9ORbsIOOAzXmhzkC7ppw0YX/mh3jIELFn
         uIw7zWokZk0e81aaAIs0ttHziMaN77lMvDAxstfFMKD6fkCz896sg8Lw09T2L0PD2pnn
         XsqVM+J0D/KLFpKBz8hcym1D0bXI/pJwDIHFvY3kImtyQU8RbtnE5E2jMf2t6TOMYBw3
         kXjZCmCTfx2Cp7xUQh0Gz39SWphyD92GJmw1fq5+ET+JIOJnZat5NSfQkeE688/3aTDM
         A2CnxGjmBQhBXeBGCGsHw9bmiCIv5DUZpXUSmYt3Auy5gOFVGCr8uALtQEZB8VdZUdo2
         EY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123879; x=1734728679;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BO6MitYTG3PPlOm9eDgi+DN2s8ThN2cAWOELNwnMFAI=;
        b=DfdlIkrE3/IzU2qZmpyRj09Kb342tS9vcG5eyI62+N5W1gcCDU9lO7CE6brQ//iN3+
         hracKIsGGD3/gqT46tZtwXeoJVO60yjSl7NmtAjNBaIDL7NK1Z9ym6wt4+mfXs3WboSf
         phzOv2lKdECir/V/Km6jt9qJYWjxIIXfVc1xV4hS8JfqY5pyJzwKjy46SC9XckNSVx6E
         0BQe6Qe6k2Y4dnRlKWUlDD/8nIpx/iHlfzejWx9dpVYZNiwV4J0kPtU3oWWQcTeb/MKu
         ZHJBQNPGcLjm5p/wMglf2qcpvQciXAvjhf0s/fA33qJ6qSm2ELLjH0t4GQFDi7G56653
         1dww==
X-Forwarded-Encrypted: i=1; AJvYcCVTWzy84FwQs7Y2cf5cqRNU94EOrNr+3kymWViECYgal5tsPgQK57yA4G9QQkgRx3+F+dXFsbURtM0Iajg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGVRqzzjKeLl/sKf4sBySbi7rQ2SBq/EsRuukTCzV2fW0LdpSW
	F6N60YA1uOwVmez0DFCq+H4mRvfPQhfpxIvXU4LMjd1tf+wEKZxAwrecD0WuOtl0pkahDtPo28o
	mQ/5SSQ==
X-Google-Smtp-Source: AGHT+IG14QG/FvZm1o/zP6GcRY5++gc+EhOPsoB8hincRJ7FgCV5ULq+tkuBgEV+o3KlfVnsbI/svufofT6h
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:9a50:5183:644a:3472])
 (user=irogers job=sendgmr) by 2002:a25:aab4:0:b0:e39:fc33:e15e with SMTP id
 3f1490d57ef6-e434f94c734mr1534276.8.1734123878723; Fri, 13 Dec 2024 13:04:38
 -0800 (PST)
Date: Fri, 13 Dec 2024 13:04:20 -0800
In-Reply-To: <20241213210425.526512-1-irogers@google.com>
Message-Id: <20241213210425.526512-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213210425.526512-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 3/8] tools headers: Update offsetof and container_of
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update to match kernel definitions in `include/linux/stddef.h` and
`include/linux/container_of.h`.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/kernel.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 07cfad817d53..10f74f021d55 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -21,9 +21,8 @@
 #define PERF_ALIGN(x, a)	__PERF_ALIGN_MASK(x, (typeof(x))(a)-1)
 #define __PERF_ALIGN_MASK(x, mask)	(((x)+(mask))&~(mask))
 
-#ifndef offsetof
-#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
-#endif
+#undef offsetof
+#define offsetof(TYPE, MEMBER)	__builtin_offsetof(TYPE, MEMBER)
 
 #ifndef container_of
 /**
@@ -32,10 +31,14 @@
  * @type:	the type of the container struct this is embedded in.
  * @member:	the name of the member within the struct.
  *
+ * WARNING: any const qualifier of @ptr is lost.
  */
-#define container_of(ptr, type, member) ({			\
-	const typeof(((type *)0)->member) * __mptr = (ptr);	\
-	(type *)((char *)__mptr - offsetof(type, member)); })
+#define container_of(ptr, type, member) ({				\
+	void *__mptr = (void *)(ptr);					\
+	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
+		      __same_type(*(ptr), void),			\
+		      "pointer type mismatch in container_of()");	\
+	((type *)(__mptr - offsetof(type, member))); })
 #endif
 
 #ifndef max
-- 
2.47.1.613.gc27f4b7a9f-goog


