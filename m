Return-Path: <linux-kernel+bounces-352098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D0C991A2E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 21:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F231F225F1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 19:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103E015ECD5;
	Sat,  5 Oct 2024 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W4Qiv7ef"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276516A959
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158167; cv=none; b=iWK0+Dar007ZXerHkw+H489ze3rI+mCfHk50QwEX+ThaFQ2iyxTkrWhsVLoZ7EorAMepT7YbaFpLBooomVNXdEaqum0pvh9arr0kBt64emyKtEA4N5nvbpVM/v5OC/rk6vWXVHdDDpLCVqlhvkQ2Pjursze1HZmwD+qmmu5R0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158167; c=relaxed/simple;
	bh=7T62nVUnz2I2Gia0eUGZ0foLAAktxEd4nUH/IRsxY3g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pxfYZMteq8QsCh27S3fHntqOz5ncJNG53s8xcZvcWdrL1jN/CI5vEJqNsWfa3tUN8kE1sNK9NGT5LUqIfwsCoi/2MGDzbMqmD3m2nqiGjO4s5FEfmPZ3T/SktEYawCxPLh1rGqWUQTOSprBkLNG32sSZKJ3SlnexLSexnyKJe9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W4Qiv7ef; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e278b2a5c4so58284987b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 12:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158165; x=1728762965; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kkv8bNfBm9/dMXp08m7d8I1ujeupVoM1qxtGNFcSU78=;
        b=W4Qiv7efgEzDsL33w+nE3HaqipEbVLcG4WzhVoPj0p2ahQcifKeKhEhiXLKzK+HYSt
         w4O23pcdudTEowpSHk5O2Zj7ripu0ZM9dEVA8cAybT894YjrrzF0xAxgwNs14CmjM1Ld
         N3fH72KPs93hW6xzf9AjQ+ncxIwjlX9EBZ46dOsGU4HuxQ7RgQScXTf6TGG44P/jZ0FD
         EtHZqv8MDC9f91hsSW0WcxYV359eQotFZxLx5DB0PYB1vOjql5jb//Kbn46GNxYmMCi6
         H+Lp2g5ejVQg5qQCKDzKu4L+O53nast+sPyIsrx9Syzpp4fXz8b+JL1uD9efNnjenuc+
         SuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158165; x=1728762965;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kkv8bNfBm9/dMXp08m7d8I1ujeupVoM1qxtGNFcSU78=;
        b=Gb7smqQATEHKngiaYHzrxjCLuZPZ3ufCWk8l6VsFGCn14LRzPGLd/JFX98eugd5a56
         LAEIfySJQYO538oCw+yxy2g/NdZ7Ky8xufLD/15kyuAA9H/8uRka7esm4gqtCQpdF3uE
         EWOtWqcBptMA68+7kX1ER7JL2dF6fN4yxJ0KVJJf4HiAe/mRp72nRPDIpROECTJotTar
         n/ancEOT8YxEsTeFjqzE932sH6pOgER6zGa3TuZGRXsSAhJLiuK1XiVJmWfVt2p1M17J
         9ItGpEhr21uH6jxuG8wpPK9Ahj1HH6PdFDPui1WJi0fIjxBDoJULoIq10njbPEfsQ++Q
         v6HA==
X-Forwarded-Encrypted: i=1; AJvYcCXR7QLx4alkmbDkmnK32AzmPxQmjvuRCm39M+05URVl6NqFkfqKW6e7nS5PTTPBIweobC/aFSqfdSp40Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx86tDwG5INQywmyVhkjoaW8BZrryg72Vf03OyCw51CXJLRRp6N
	ner1hnbWe8rMq0k40T6IUrXuQFw0LNsNzoe1AUFUFT2JfJ6bEe5m2aen/MbKFO+yVDJHI3hxvck
	UD2j+3Q==
X-Google-Smtp-Source: AGHT+IHhkYnBtrBd+SOkXzP7+HOoF5g3/WxbcOIpY5cilwtjjCAK86WSpPWlw1sMJUnsYpXgeVLoazZjXm6V
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a25:7446:0:b0:e16:6771:a299 with SMTP id
 3f1490d57ef6-e289394dd4dmr4215276.11.1728158164909; Sat, 05 Oct 2024 12:56:04
 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:13 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 03/31] perf build: Remove defined but never used variable
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>, 
	Shenlin Liang <liangshenlin@eswincomputing.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Yury Norov <yury.norov@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Previously NO_DWARF_UNWIND was part of conditional compilation but it
is now unused so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 55a39211496d..182e14e39cd5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -753,8 +753,6 @@ endif
 ifeq ($(dwarf-post-unwind),1)
   CFLAGS += -DHAVE_DWARF_UNWIND_SUPPORT
   $(call detected,CONFIG_DWARF_UNWIND)
-else
-  NO_DWARF_UNWIND := 1
 endif
 
 ifndef NO_LOCAL_LIBUNWIND
-- 
2.47.0.rc0.187.ge670bccf7e-goog


