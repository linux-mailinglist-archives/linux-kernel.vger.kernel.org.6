Return-Path: <linux-kernel+bounces-565400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6686CA66773
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26EE43B57D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66F31DED6E;
	Tue, 18 Mar 2025 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="un0dzwLv"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6CE1DE4DE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742268749; cv=none; b=dhbvE1oTRuXucCOh5ld8tLgbA+b4r1fg8xpAcdC6jUiy7+Dz/xTOq8kKJAl4PhM4veRKgbcQI0fq+/X5HRLhynBdnz/Qa+mN/iH1v1hfowqweOfy0R8HfMkG577qiJN6EjdKx8NkHL7F91nNGTE19DtME9CC7ZhdvBEqpEEwugk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742268749; c=relaxed/simple;
	bh=X4cVGKjddUrT1hh6NkP/YFyNfnEK9oIiaFfoZniet0k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ptf3HZaePGABowKI7WUrqgHMWnYcM1ZTEwDLbiU0l4klY1v60WlqaY6g0e5oX+6OCqbEEXrjGcVpFYwsm4eBL5VnSNAojuJZStJZzCT/6ysut6tRcZEtilzPNYTLyHFAZwSJU39rd6ELIuLJ4fQSF9VMI2ibXLjeemPefvYjSv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=un0dzwLv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e63458181eeso8141782276.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 20:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742268746; x=1742873546; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQo9te7ZzJhvscCqCJ9snuZUA/U+ZRpIQMTgL/AyPbA=;
        b=un0dzwLvY6tnVQeaXE1d6veu7ouRB+bsRHu350+W/ZBofJ8zZgdVEZVr+YLTFLw8qx
         /vvD+GnvNLajwkicKCdfl7IvxVKII0Op/tZ0Fd795AD1yxnB6T+5xc/gGs+AKRogGpDG
         oM3CVadx+qPHHErcvMmRqzvIxjUeZbECMMh8evU8/kGgPr8xopK/G5Z12AdGn0PxOAB6
         N1SVY5SsqQpu1nIf4orqX/DoGN9vV9Ug5KUUa/0mHZjGCohLpKqnAHGpKHfxHkoHSaIi
         4jfWYBVRmQ9RDEbMkp3YJqGw8lKazXh0VJ1xBH+LDUwOyb5bIRwNcZ+axOfR2ilNrCjB
         HmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742268746; x=1742873546;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQo9te7ZzJhvscCqCJ9snuZUA/U+ZRpIQMTgL/AyPbA=;
        b=aq/3KoiZIOeFPGGMxe9G11KEu6GfoZpu+IEQ5ioM2ps9FxrbsOfZaVF6HMNCnhNnGA
         wPdymt+PdRYIx5mdqYjbsMKdneDwI+upoL6iUPZM+vrx0wSxtNVMZxL6PBX0QqmhS+d2
         u4Klj66dgPnSDKlryKaCLsLqY9nf85537uTxVX7iSoyIbnAHyFmbbu0ZPrNytPIH04f7
         +1E3IXaTLH6nqzhFHu4Y2OEOqo7cFc0+gVN1wTEGX2T2mWDd9RBWSW2Cd1k5tHgskIEZ
         U4B/PcXuDCH4Puv3H8WjkQ8DeAqxrcPWZsbbQquT/Xe9xK8D8uB/6OGHmOXsI06t9zqK
         xnSA==
X-Forwarded-Encrypted: i=1; AJvYcCWdslFs+RqKiXCeank0O3a/tlnKnrv/2Bc8uYWhbBwFM+1ib0i42Xd+c+YIZs/TAvzv7lrmEQMc7TduaSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCDEVrb9h/8681aoa0N8oXNYnp3a85N89OxvUk9lcgEnMnRyVt
	BnxXOCDtB7exU6Nf84kwWy9LsWMtdJRSazEWUhsYnKhHjQY+WFgjTOSW0tN6UML4WyeBIVcMnqT
	y8aBGRQ==
X-Google-Smtp-Source: AGHT+IGRlVl7Gw//953kKsnqnEm7y8Rwpz1NXG8HWXbHdCQFY9o6z5zJFDv6lHgSfJyidVHvfm/4CNW4I8zo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ef29:15ce:a42a:b69f])
 (user=irogers job=sendgmr) by 2002:a25:8209:0:b0:e5b:f74:f5a with SMTP id
 3f1490d57ef6-e63f65f1718mr7472276.8.1742268745758; Mon, 17 Mar 2025 20:32:25
 -0700 (PDT)
Date: Mon, 17 Mar 2025 20:31:50 -0700
In-Reply-To: <20250318033150.119174-1-irogers@google.com>
Message-Id: <20250318033150.119174-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318033150.119174-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v6 13/13] perf trace: Fix BTF memory leak
From: Ian Rogers <irogers@google.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Add missing btf__free in trace__exit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a5f31472980b..d4bbb6a1e817 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5339,6 +5339,12 @@ static void trace__exit(struct trace *trace)
 		zfree(&trace->syscalls.table);
 	}
 	zfree(&trace->perfconfig_events);
+#ifdef HAVE_LIBBPF_SUPPORT
+	if (trace->btf != NULL) {
+		btf__free(trace->btf);
+		trace->btf = NULL;
+	}
+#endif
 }
 
 #ifdef HAVE_BPF_SKEL
-- 
2.49.0.rc1.451.g8f38331e32-goog


