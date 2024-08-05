Return-Path: <linux-kernel+bounces-275263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EF5948286
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A741C21E0B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A63916CD3E;
	Mon,  5 Aug 2024 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKB4q9Ee"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EFA16C6A5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887079; cv=none; b=ZUW9vlsDdMTnbHsndYRscT69hBBnKDtZfHJPurQpmeNqnhxcLtAOY1GycjLrucGkpbWsSmejprY/4BfaLJksVQgSe8ubJB+/qHm9CjhdiQU6vcJBDHVKFzA8DXhijEnQVnFP2vQUZA0zEZl5/oFLvwk+0/PUwfTY2lkWE97vawY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887079; c=relaxed/simple;
	bh=1QrCpPczpIYO0QWueMZ+t45S7nwr5IGQhXhieD/M880=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cDIKvgBRChc/UL10wraQeUnPT+DZvZ/05b3N1Qk6+dza1W/a1xjnZmU5CirDgu3XpuDSpFvOUlIkg/OvpLBMrMA1qr/5HVnzv6kkA5BziCe6sJYB4LFcRj9nexSJDvlOp5FJU4xW+kXU66EV31GJyLZLGMAS26d2ug7eL9ElaZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NKB4q9Ee; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0e3eb3fe93so2986151276.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722887077; x=1723491877; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z6LamGx0sdNwDED1VdCLCVyXTKgGz4JF2HbccvXV2xg=;
        b=NKB4q9Ee1MY0aFCkFmQN/AQFqY2c6MLZrcEgEIQRpLJ9r/VpXkI+CdZXsAbS+Q5xVT
         mVtXnzwkMib1veQOwagNqzY6gPtZmQchcfbTRrA7iYeCMXSo88RXSZyRBys6KNXPdoiU
         c/CViDmXGSuhfLMJCxrd/tYMvqS4o1UZx7vd9lQwvOMUFG8pgvkskj4iggXfm4BFiH5L
         GS9nFD6dzGMY8RwVCe4wc8xwQTHfNaU6gGNfEwRIRR0XbWjF8WjqChpkR75LQX88VXO7
         cbS1BqbmEmZPmMeWYxWWzzXzFLnCZy7wjjp0uE9BmQwufydOZptXc79doaDqP2NUuAJ8
         D6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887077; x=1723491877;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6LamGx0sdNwDED1VdCLCVyXTKgGz4JF2HbccvXV2xg=;
        b=myeYdB1rPXB85oSrSsTv5l4wbG5EpYRW0/vGXv5WYPxrJKBEHItYF0Hz9pLmIKPAEC
         kKo88kgVMG+HUclCLFcHuf2A4CQsQcJW1uWmYNIs3qsNidYSNr6NfhMhJSeSd4eI1ggc
         yjl5jLbzvnI9/7Ux56QEUcjCTEUq3jo+K4XzCS6ggacYKEgMBRHnuRaiz5hkNza1n3Br
         ShbohEWHrC+rt/BVpgwwp2tZlH6OLRcHglZLNanDSmUjyhMB6Vizo4iDdpwlLssCYmf+
         tsFdOQ/xhemGvSodGhcGdiT9zu5uArHAfw/aXuR/MeWPvI9tYoBEXtSSWqGYnMNHxW6d
         w+CQ==
X-Forwarded-Encrypted: i=1; AJvYcCU31WNvEf6vZAWI8TNaAhFDNToKftaMjOLUZsJFY7euZJnC6PZNw3MajzIBAmpjgHG6spkfycI1bJHyNNk/GhJFNpGbCZYwZ12uZ5Ly
X-Gm-Message-State: AOJu0YzhVZ4+8Yaofnp9YwGuB1oxKRJ61yzjNwAh7U3zRyTHaGzfbpCR
	spmHDFfxIpenpft+9SIRQhGSw++YFNqXBex7J8uW5O718szZR5P3Ld/zy9XuS0cVKJH5Y+Nd+4V
	OC8g4JA==
X-Google-Smtp-Source: AGHT+IFdv3oV3aqOKUmsPGI61CM1Ai9LluPAyOkHwx2uTCKWXxhzLAfMUs0X+MdhGbjcuYrJiIZPaJSwZtB4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:1f65:8dc8:61d0:4b08])
 (user=irogers job=sendgmr) by 2002:a05:6902:1148:b0:e0b:fe07:1e19 with SMTP
 id 3f1490d57ef6-e0bfe072223mr13804276.0.1722887076925; Mon, 05 Aug 2024
 12:44:36 -0700 (PDT)
Date: Mon,  5 Aug 2024 12:44:22 -0700
In-Reply-To: <20240805194424.597244-1-irogers@google.com>
Message-Id: <20240805194424.597244-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240805194424.597244-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v1 3/5] perf pmu-events: Remove duplicated ampereone event
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland <samuel.holland@sifive.com>, 
	Charles Ci-Jyun Wu <dminus@andestech.com>, Locus Wei-Han Chen <locus84@andestech.com>, 
	Atish Patra <atishp@rivosinc.com>, Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	vincent.chen@sifive.com, greentime.hu@sifive.com, 
	Eric Lin <eric.lin@sifive.com>
Content-Type: text/plain; charset="UTF-8"

OP_SPEC is repeated twice in the file which will break invariants in
perf list as discussed in this thread:
https://lore.kernel.org/linux-perf-users/20240719081651.24853-1-eric.lin@sifive.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/arm64/ampere/ampereone/instruction.json    | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/instruction.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/instruction.json
index 18d1f2f76a23..9fe697d12fe0 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/instruction.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/instruction.json
@@ -77,9 +77,6 @@
     {
         "ArchStdEvent": "OP_RETIRED"
     },
-    {
-        "ArchStdEvent": "OP_SPEC"
-    },
     {
         "PublicDescription": "Operation speculatively executed, NOP",
         "EventCode": "0x100",
-- 
2.46.0.rc2.264.g509ed76dc8-goog


