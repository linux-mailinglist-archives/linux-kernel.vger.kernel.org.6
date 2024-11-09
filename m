Return-Path: <linux-kernel+bounces-402686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6114C9C2A88
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928171C210C2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E51146A73;
	Sat,  9 Nov 2024 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PddJg+Mb"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490F145B27
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 06:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133111; cv=none; b=J2rv2eUCiu9ThM5EbDlBiPEEtNlpyuins1ExDpBCZKwMvddMHPjoaQ77ngDJPwPH9ZNkd1zMpqQx+8Br3IfiH9FH5kUGXZ53cWnvloI/sIQfCK9j1B69uXJM2wXr9jdITPA/0pRFGvahGL9JD7tfhdIrwua5d+amXwYFAXkub9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133111; c=relaxed/simple;
	bh=M3EhLoWJpiHkO7fgF6UjV6G4kHXEsbbL6KnzJZ3Q2AM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=AvN8mlLopM06hjkh7u50IXwfu85/Lyuybqgm345cxIh8zaoOfCsSMr+3jGB0Y47nu0vyxm3eFqTCVuqqzjMqpPlk2weaBupJANVYQkSmZo+F9GEO9LpF4ucwm0ONx5hPqE9yQEMSDXuqe28C7am8hzZwb3raJ29RybzM8/KnWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PddJg+Mb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so5167463276.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 22:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133108; x=1731737908; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AnTa2k5fRDqNj4DNNGYm75Ty05e5sRFryTTBArq6LA8=;
        b=PddJg+MbNmfUgvfN6D6aEWqf3oAVitMmeQTelKqfyJyRQTK5RMYku6tps8uWeQzdMy
         cVsAXi6h+ZSN9yjsCkW3Atlwne52t6RW5aDjHeVYo6HLokLx7WjVLfJ4nPYHayk9WM6R
         WF0uLQ+FzrN/wsXvkxEz4rkg24iJW8Ii9GGi5UuwbzUdIU4W174H47Y0AY2HT64WS0FM
         zCd82Tw+usjLhLajombFL9ua/TzNLqLpASTYtT4MRL30u+RqbmRB5Gwk2h74Y4BFmr/V
         DMPdEd6kfXVL8wx3diOgM978DWbXs1wY/5O92YcILNGWCpUoy16txMmIynz+SeA5Igbm
         B86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133108; x=1731737908;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnTa2k5fRDqNj4DNNGYm75Ty05e5sRFryTTBArq6LA8=;
        b=lHLAc9SeiiCOqgftRO35WY4BSY9a3YZHtlcs1VVinYawntyqNaBUVv0sNXpQrbyDSW
         94rCzNA8/40WcgFXxRbRJJlTonz5yHYyVhsUwX1/uPnuFwn39mv4Mh2+wL7gY8G0h0Zk
         avAA4T6UIJnExL1aTtTNCYxP3ROy4e1ul4Hce0Gp91NAMeAqk7/NItAl1qf6ayAqG2qh
         zKmRDiPuBQFEYYZu7Dea2J2XggAkZfcqAYaugvf4ceQkzE0e39NmMPY3FqLpsRMlR8BB
         5ILfcf5qbmDcLxxQPLkWG8aEsh3ah2P9hokdKnDfF+Hs2ouPK6oQ/p5ZW/Y80gLyNGCY
         /9mg==
X-Forwarded-Encrypted: i=1; AJvYcCUSZ5VAdxNe8Eip2cdLsX1PP8Ofz/IaIp4MMCY8EiaVHhaxVLztUk7ZHrd9c5aRDqGmny3/Qn8wQBj40AM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBPrPMu8C7qi6MfXHgYwy+O1OsQQN1u7sFBQwCnckRevg6JdeM
	B+JkAsr6ckqTnmLv/5nzqeHirzFthN5SSiNv8nfVTPV3q3Oh+/5RBomrH4qSaSZeiNdoQEAD0gR
	Gnl5WgQ==
X-Google-Smtp-Source: AGHT+IEMEIMjqxRWxqS6oH5RjgG4gu+/sTgO3rKvWlcSAlAsgGnQ/nQ6Jr8n34KT+JS6rn74DaEcoK6IaK4W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a25:aaea:0:b0:e2b:d28f:bf28 with SMTP id
 3f1490d57ef6-e337f844036mr13183276.2.1731133108599; Fri, 08 Nov 2024 22:18:28
 -0800 (PST)
Date: Fri,  8 Nov 2024 22:17:50 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 03/22] perf python: Remove unused #include
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Remove unused #include of bpf-filter.h.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 945fb7bee0af..e2109f6c7ead 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -16,7 +16,6 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "util/bpf-filter.h"
 #include "util/env.h"
 #include "util/kvm-stat.h"
 #include "util/stat.h"
-- 
2.47.0.277.g8800431eea-goog


