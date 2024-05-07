Return-Path: <linux-kernel+bounces-171985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 447AE8BEB85
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757851C22BF5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4983C16DEB6;
	Tue,  7 May 2024 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XvBeZ3Ig"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E0C16D9C2
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106970; cv=none; b=GJGqClbodiA1qHmI/Hw0vXss4462nmMHv2I7/Vi7UIdXq/fFTcRX82k0n2016JqrIBX20cICPXHkpR93qxNyVpteE37QiKDUnHzawO3f30Q4ClZR5WeG1VVhFXk7/1cjFwgVgFZDTuq2iw9Pz0XskB9gz2aExqKy/Iao3eVOges=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106970; c=relaxed/simple;
	bh=yi0IGqXPFHWkzbXpu9EOHF2YNWNnFamLHfIdbg0rgmA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oY1HYt0SNFDRahtSmE09vfDaIErbMo9bHcsJuZYwTtxyq4GJzVKy+ggsSTmNK5EfKMTMJe0iaysRW0yF/HpO5q9f5JgBVCNBvIXbxWjFrbpq8aVCc34WRxvSlNpQhCsUEfsAznvMouIEn7N8V0/0Iu3MTS5aKZPkLVAsa0iV+GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XvBeZ3Ig; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61e0c1f7169so594567b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715106968; x=1715711768; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nAyKMenex+5IJfc1qyffLzQhoa2twNpQD9DTMrkElUs=;
        b=XvBeZ3IgMzbSraWpzC4SXqHxAJ+8KWOPUSLhnknV1nVdBYsyCthNUQlUwdQ25BJPDF
         8bvoCHNmJXQBhs7FLNygCaB4ENU4tVMDuNGYRj9xVycZxOQIwPReANoWhmXWadQhxCEZ
         TT+/qI2q/ok6RKmxHD9J585AhGFj29mlA4BkurJUTCNIVXybrcZtJDSFk1CC4snvZdEH
         hiVqJpX8pID1xdQquDLOfRKccKkc8uZbjEoEmM+qlCAjUHwgP6OiPQOZu0Hi9+NJ9IJe
         a32a3KtxqEjKv+rvPL06pkBZPpUJcpqL+TFCCvH0gz7mcLo0Y6xZm1mplWP1OqpNeyNv
         vLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715106968; x=1715711768;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAyKMenex+5IJfc1qyffLzQhoa2twNpQD9DTMrkElUs=;
        b=kvuy89j81AK2a1T6mNAw/l03K0geKJWRxN0S/8sg76IzpZwhGQHFCd1boBqF8ylmJ1
         lUT7rX0pm/QYe/bI9Qqt8gJmqjjim1KaiIVIZJ0nakXgvNfiAQYDVCZydtXXsQCnSP3u
         /FbyDoVY1NmsZGuFncYlgu+x9D66KoRZmUpLF8mtCSQgi8Z+P1HntXWWS/4Z8CQhvpad
         U6DNgTJ/00kj3Q/9GBz4GCOMdXvxiH66a4iKkH0q7oyICxl14sR9QwHB5K6oNphI5MeR
         o1Gz3AE+5Hp6HUo18zwGTICN2HXV4yr+4QhVek65fzbZYLxjiSOhoVlVW7DlkcsOlDjd
         7SAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvIPp0+yfHH4KPAzu6yWVXnFoQX/pcLn51RYf4qqd5AtL1CUYVuDjDuirMpYi4zXlMtDsbXZLr4Zod5wKdVd0tNTQpUTpTa6PF4IGw
X-Gm-Message-State: AOJu0Yxn8g7N6rc1rxzLoQ6woj2Gl+EDsAgMV74kvC5gvDy7IJ1mMjbK
	jqqxVtoHTY/bgPSV02ET3egRMcz0X3wbOJiRPArQg0/pieOqVkkv4/opxrDf8o/2MzGAG1df+Xi
	WrUGbcw==
X-Google-Smtp-Source: AGHT+IEFrS6qRkXP2QGeiHghu5TLySBp1SQLXJbuHHXRZt5Be0phxkIoQ4y4pZwWsNfw8wrjcT+hJQqVxhIh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8095:fd7:9773:b1df])
 (user=irogers job=sendgmr) by 2002:a81:a7c6:0:b0:618:9348:6b92 with SMTP id
 00721157ae682-6207652d8a9mr8590217b3.1.1715106968260; Tue, 07 May 2024
 11:36:08 -0700 (PDT)
Date: Tue,  7 May 2024 11:35:39 -0700
In-Reply-To: <20240507183545.1236093-1-irogers@google.com>
Message-Id: <20240507183545.1236093-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507183545.1236093-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 2/8] perf annotate: Fix memory leak in annotated_source
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	James Clark <james.clark@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Kajol Jain <kjain@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Freeing hash map doesn't free the entries added to the hashmap, add
missing free.

Fixes: d3e7cad6f36d ("perf annotate: Add a hashmap for symbol histogram")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index d7d55263fc91..a83722f32d6b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -107,9 +107,15 @@ static struct annotated_source *annotated_source__new(void)
 
 static __maybe_unused void annotated_source__delete(struct annotated_source *src)
 {
+	struct hashmap_entry *cur;
+	size_t bkt;
+
 	if (src == NULL)
 		return;
 
+	hashmap__for_each_entry(src->samples, cur, bkt)
+		zfree(&cur->pvalue);
+
 	hashmap__free(src->samples);
 	zfree(&src->histograms);
 	free(src);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


