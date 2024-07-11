Return-Path: <linux-kernel+bounces-249641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544D092EE2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046331F225F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE99816DED5;
	Thu, 11 Jul 2024 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0nnfwzFT"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF4816DEA3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720820; cv=none; b=gTD9nIMxUyncjxavM+RaH6rL1gpGM/cQyLO82TO0UGTlE3RVGJhI0IGqQMrxvS6opiOSglTpGiRsBJVAflna4ZFLNpUn75fAcRkyhI5L3TNRZW6B1zg2AiR4K9hl97aX+OWSwSk2IxPSBLoDiXZlkcZAXiKRCECjdmrEPqMfmqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720820; c=relaxed/simple;
	bh=LctEg2Je3fRQdJP1aZySQP64dlbQCviuGkAlqwvn5oA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Wk6DW1PttqKAV7UfRg2Q4ICjoyBH8+RYpqBqPkZ781MT0iNFaLxYAvthKEjPiqauaOJZH2Vm7fevNErfDQL5o6oQm2z/IJQtPcZ9IcmkP6j4wRbDcOztgYb7KM7YRD9LjfnPnpj97/bgNw52lftQboZRYLSkREls/uOOU0g0qPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0nnfwzFT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-650b621f4cdso17261887b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720818; x=1721325618; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbSFIAjgELn8En/ODTzECP6YTzi/bZUaiF8JxVDqD4U=;
        b=0nnfwzFTMJA3TwWBy/o/JeiG/UXbrr7liokMprepstpUAY1Rg5RBdx7RXbyGX8ly+1
         DF/GKlpLu/P7gPWe5tCevM2lG3lw5CqOEQXbrrOCWbInlF/0oTuxfRssCxsu602tWzx1
         ECkK8tlzNSH9qK/QOTd55OdtH2TiP49vJG9f0hUh0tTF0u682h1rHALsh4b7nAtCpEJK
         QWpVvGzbFM/Wi0OwO8/K1QkXbqp4sE+ftnAftxeEAeStew+hpB5XlqsojfTa1D7F0TSl
         L01pm/ZzeJ9QhQ/a4O0PiT0srNTzpZ2sMwZm/hawkmRjMXbaok0mdFRDQNLO3v703p2+
         0vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720818; x=1721325618;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbSFIAjgELn8En/ODTzECP6YTzi/bZUaiF8JxVDqD4U=;
        b=BBRPVliNVZ3rSQWjQHW/3697/Ssdt2toFi4ImWJ8ZFSrTDls85k+drcgh8BXyB74Pr
         buihWh+fo7O46S71XoQS1SHjbEmI435EQkea6xdXcVJQmT9DafwSbEceVgQHHTU6nBh9
         N1EKJRWhYjAqxmKLgJA5Q/1rtGtsmVe9wrd/XkpektjO9452LDC6EyPF92vshWfzOjdN
         Mq52FjB1Idk6Eli1BR7lxNyOBTOtsiBTVzdFo1rqPFMqrBqP7cKZxOFMJmcowY6t9PU7
         Ydbrub0BDw2KvmhrhHc1OSWTsCv6QEOYn6aacY8f1Rq1a2AHfpV+GdQMTzMhbgdmpfxY
         5NpA==
X-Forwarded-Encrypted: i=1; AJvYcCWDkb7IiVcJisWi/mHen+oiCu9nqsHftSnPO3w6cvECdHMFS7o06OUI6oFWECY0bnZeRPPn8B6MkpwlK/i+qJq5u2JXRcu1w3tq2Fvw
X-Gm-Message-State: AOJu0YymLS4Y7MLFS3JTzdFic1+Yo08TiG/nZ6B1KVKrKWDQTNZyJA7/
	TJMisVbaKaDw6Ab75ESRVkglV0Q2nCisA6inJYOaQ8Ww85o4AWa9W8JmbrK/nIVCQPCPCUQLcrM
	lpykKaw==
X-Google-Smtp-Source: AGHT+IGeXhaeoNjn7pRRBMER91nAV7MjXLe7mlhn6vY1im3CgeEvPZqQsZteJ+XWeT5joa2vWOBK1cIwB1BE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:1025:b0:e03:5a51:382f with SMTP
 id 3f1490d57ef6-e041b1153f4mr804588276.8.1720720817740; Thu, 11 Jul 2024
 11:00:17 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:42 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 02/28] perf s390-cpumsf: Remove unused struct
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

struct s390_cpumsf_synth was likely cargo culted from other auxtrace
examples. It has no users, so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/s390-cpumsf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 6fe478b0b61b..4ec583e511af 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -952,11 +952,6 @@ s390_cpumsf_process_event(struct perf_session *session,
 	return err;
 }
 
-struct s390_cpumsf_synth {
-	struct perf_tool cpumsf_tool;
-	struct perf_session *session;
-};
-
 static int
 s390_cpumsf_process_auxtrace_event(struct perf_session *session,
 				   union perf_event *event __maybe_unused,
-- 
2.45.2.993.g49e7a77208-goog


