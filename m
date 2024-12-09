Return-Path: <linux-kernel+bounces-438343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30BC9E9FF3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F75528165D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191421991BF;
	Mon,  9 Dec 2024 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+TjVcQx"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77311993B2
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733774471; cv=none; b=fomsd3yl++fIWavgdf0LoRVz0D/45cm1+OC6y87Bb/9Vr8X5+0PFvLB3cyuAKFlMLffQU5felMz1kwNKrdw6c8Naxj5gqTxcMIYk9763GZmK0Z/bD7scd43G9oFQ5wI9RFRHRXMqqcdskEH7IKV7U6JIxcAb8D5icEg1Wz4Z8g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733774471; c=relaxed/simple;
	bh=jR4luK8+IFd6VWu54V4hUotHm1xxpwamdd+wy2P7dK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DzX2IG5wwG5gwNDP5NRgjJ/p25v8PraNxMm4fiKCMyZvvEoKuWFQbsTqb6b0s7V/lD4zT5W34qxgNVAyKba+2IM8qpu8Unc4c0k+r9/noEb5ZsyOPFnJ/0tOI8YOr5d2Afc30I5vdnaQAF8uFqVNmWfvngDBrv7o6m8QCYSWWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+TjVcQx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21632eacb31so14002195ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 12:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733774469; x=1734379269; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DW8D+45b8xEbyPxEhPUcnEPnEVGFEjj4jIcIes+wDWg=;
        b=G+TjVcQxT5v+W/qoRzT3ZrJoQa/Et9Bk2PqnTLsLHMt/LIIYCuDfIMwEQBiujwLmah
         l2CgntpB5hQBDba1utz6zJlSlytboz+ICG6iC0hClH+uYOwJAqur1C6buDb6U58GzOXO
         T732l3j0YEUyKJbZD4h3DTSrqZaMYED7td2ltEIwJqGFub4hzHxjH79NfwFfOxvyqOwH
         xB+bjtLTfWHp3nFqWr8nkMBf9WnU/OPMXCmlVM+17Ks5SR0i5+voRCCQfpT9tt4UCI+0
         JDtZEQyL1mGSmfFobG/9izYlRvBGYu7Pe2KPs/u0NyP0De1vapIM01TQ4D7W2KwQyPK7
         kL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733774469; x=1734379269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DW8D+45b8xEbyPxEhPUcnEPnEVGFEjj4jIcIes+wDWg=;
        b=aZkBBaYSba12aDqGFACClLutcpGpGaG9mWvE1iBVBeqaufC5LcSWwp0EpV3z/NvBPJ
         Y9fD2MOw1+YI/7GimGoYz2JYp+tU7CD35LdRQxYTMe8ywXQJYCU1SC+oUyikb2bI7EnD
         idGBznRSl08xXiw+AUhOWAM/sOWYz2yMHRzS9DCka/23LtSNxC+xJb9wk/CmYPpZutGd
         /blF0JPgmyNFm/mI/eJB4+Gd4zRka1aNPJHRoA94Wv2ITCoOvXHP33O/96bGSANjnExB
         Ei0XqbBbDbNVdFP9aTBUY7nB4vVlyFGXS+qq56sSI3svzool49glcDDKc1Gefj2inqvb
         30Cw==
X-Gm-Message-State: AOJu0YyRhyY5YwBGyqFOZBXKvNpoHarOHzOiUQ9vHifUoQQ5BBvzy5G6
	9rp+sxwG9kTNEUdH9w9Nl4t5dyq/tHBiRhTZl6YOBycyQ7uyUwB+YDjNKT0mjynmeifmDtq0X4c
	ii9w19V5fPHanB4xpluDPlw/BpFIg+b8b+1ah6F5zm5g7OvANFFHkAuu2Vs7J+pSPf5t/mcYmWj
	2v2jYzko+baawcGtq/SapqQB3xUI480k6OY0BB2Qnd
X-Google-Smtp-Source: AGHT+IGZ2t3vSPZgRvKw/qvWh7sPSvOeQUeWjdJMWA4dXDyoTJuAiYU9MeWYDccdCS1GkVXMZoQl8TNVK58=
X-Received: from plru4.prod.google.com ([2002:a17:902:b284:b0:215:94db:1290])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b05:b0:216:386e:dbf
 with SMTP id d9443c01a7336-216386e11c2mr104336235ad.20.1733774468897; Mon, 09
 Dec 2024 12:01:08 -0800 (PST)
Date: Mon,  9 Dec 2024 12:01:01 -0800
In-Reply-To: <20241209200104.870531-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209200104.870531-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209200104.870531-2-ctshao@google.com>
Subject: [PATCH v4 2/3] perf lock: Fix the wrong name percpu-rwsem
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In `perf lock --help`, the name of `percpu-rwsem` should be
`pcpu-rwsem`. This patch fixes the naming in `lock_type_table`, and also
replaces the mismatched name `percpu-rwsem` before parsing it for
backward compatibility.

Tested `./perf lock con -ab -Y pcpu-sem` and `./perf lock con -ab -Y
percpu-rwsem`

Fixes: 4f701063bfa2 ("perf lock contention: Show lock type with address")
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 7e36bbe3cb80..264acfa648e4 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1587,8 +1587,8 @@ static const struct {
 	{ LCB_F_RT,			"rt-mutex",	"rt-mutex" },
 	{ LCB_F_RT | LCB_F_READ,	"rwlock-rt:R",	"rwlock-rt" },
 	{ LCB_F_RT | LCB_F_WRITE,	"rwlock-rt:W",	"rwlock-rt" },
-	{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R",	"percpu-rwsem" },
-	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem" },
+	{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R",	"pcpu-sem" },
+	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"pcpu-sem" },
 	{ LCB_F_MUTEX,			"mutex",	"mutex" },
 	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
 };
@@ -2365,7 +2365,11 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 		/*
 		 * Otherwise `tok` is `name` in `lock_type_table`.
 		 * Single lock name could contain multiple flags.
+		 * By documentation, `percpu-rwmem` should be `pcpu-sem`.
+		 * For backward compatibility, we replace `percpu-rwmem` with `pcpu-sem`.
 		 */
+		if (!strcmp(tok, "percpu-rwsem"))
+			tok = (char *)"pcpu-sem";
 		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
 			if (!strcmp(lock_type_table[i].name, tok)) {
 				if (add_lock_type(lock_type_table[i].flags)) {
-- 
2.47.0.338.g60cca15819-goog


