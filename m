Return-Path: <linux-kernel+bounces-170268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 622728BD44C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018811F25362
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C98158A2A;
	Mon,  6 May 2024 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a3Do7Wgg"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18519157493
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018515; cv=none; b=bRcqSvkc8UPyksH7OcacpHw77b0hbMlV4YmjYGdPJnQbGTzERekjVMWXcdcjLevXG2qPKnooGvKyBExcraSGD5NnJo9kcKgACY8WhruTuPLYeaLmajWvu76PnyOoACJTbTi7ZsqVeUP0j6j3orlus32DV4vm4twl+tb28FtGAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018515; c=relaxed/simple;
	bh=70y0Uq70fTi9vP6E1n3v/21p95xUIVe00JfnSvODJ4M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WJzdAxPcvj/vvTThUKJUn7K3DQMn2kqojQYP5wRX8S2FE8bFnVknkBqbK4POmEVsQD5c356m/dXT1ai4epN3Gc1e63XYvHkjHz9as1JX+q6jB6IDnX6dW5Voa0xwboFQBI50C/i73lHD0gENOGm8GdyR5L73JH+XPh7RxB/a224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a3Do7Wgg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de617c7649dso4377559276.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715018513; x=1715623313; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0nd3szNl+OFQsnbvKRBpAQwbxRmYTuaSHyM0OpbQt04=;
        b=a3Do7WggtAq/5DHafmiQOhbax/yaC4GHim3qOAatI1BlC3x5AZT5wX/uybqHQJDNE7
         qAtmCSEVk1tRrFVmld/ZOyBQh8B+VSDW0vDZ79lRYOLqeJNXYJoO/UQJHA4vloaqCFlS
         zMU5+F+jdESru34V8MJIphlIw7a9oHsbfDaqEMMBoAbHOGnTBP8W9g6q+4XW/xt82EUE
         Gk8gopvwIPqMiJ4X6EFC+jNp+RTgcgneFewqDfDi+o3ZJTm31Id28g4golaHQ7glpuoQ
         Vk3EvqFAPK8a/sLHg7v4ZmMQIjj69FfByHCGV1gdmsRN4NNTN2ohlPDRi05g+NUBIWV1
         o1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715018513; x=1715623313;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0nd3szNl+OFQsnbvKRBpAQwbxRmYTuaSHyM0OpbQt04=;
        b=rjMmpS+MCssxZe91yQfQCItfp0ctwBa+7eIrmj261DJlwfxS9ovvxJ9MpdIwHfzzex
         MqVbJg6OwnQ1gNA/ifLDjkjOaadHQYGzRTE7cFD65KMwtKgwyibFVBhq/xUbnuftM409
         6lvAHu5Aj/sRIx62E5C20KeS6++9ah7emjNfrMhL3iLuotzcCe5bPH/0TXnmlcu/vapK
         Vt2V9PJgmXolFoaaVvrO9Kmm5N5ViSXmYHGDWTd537vatPO7rxHn5Rw2pKJ//l/i4NHH
         26HlYCh/gerDTAOxLd8laBvB4XQAY6S9uJfwhg8nJK7nlUYXoWjx3OpUXMLqV4hJQ7Ma
         VwSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyNtdJQhWGuFLdZf5v6kGINwVjSYN/+jE47kt3KqsGZQgp9FxP+ytA39Z9yAo+MClVUKM7TWwToFq6PVCgzTtdOuhvit5BRoxq0aI0
X-Gm-Message-State: AOJu0Yw09MSiNwZTTo+BF/qcVIXI6Y1OIXg/cbjQmZZpfLluAo8EQM7W
	xf77hFGc1NLABlWq6lHM2lFmqNHSDdZ3Kph60tgxWNd4NP+6rnDllugNn2X4FHlk7C1RUGaHyz5
	b5UtjJw==
X-Google-Smtp-Source: AGHT+IFIF+mKPfdZA5z89/oE5y8/Z4uzaRdxsq56RtVsVl63c4Yu6VzU7+jSmmjQuDKupcDjwG02lEt15AT1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:91df:9b7f:c8d8:409a])
 (user=irogers job=sendgmr) by 2002:a05:6902:726:b0:de5:5693:4e8e with SMTP id
 l6-20020a056902072600b00de556934e8emr1533970ybt.11.1715018513213; Mon, 06 May
 2024 11:01:53 -0700 (PDT)
Date: Mon,  6 May 2024 11:01:01 -0700
In-Reply-To: <20240506180104.485674-1-irogers@google.com>
Message-Id: <20240506180104.485674-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506180104.485674-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v7 1/4] perf map: Add missing dso__put in map__new
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Changbin Du <changbin.du@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A dso__put is needed for the dsos__find when the map is created and a
buildid is sought.

Fixes: f649ed80f3ca ("perf dsos: Tidy reference counting and locking")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 117c4bb78b35..e1d14936a60d 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -200,6 +200,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 				dso__set_build_id(dso, dso__bid(header_bid_dso));
 				dso__set_header_build_id(dso, 1);
 			}
+			dso__put(header_bid_dso);
 		}
 		dso__put(dso);
 	}
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


