Return-Path: <linux-kernel+bounces-448292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B59049F3E38
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DC816E268
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722BB1DE2AA;
	Mon, 16 Dec 2024 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ySu7h231"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBD21DDA35
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734391516; cv=none; b=sVLYj9E+0VFXZ7cve2EbEXslV9Re16F/U04SDi0l+X02BJdb6arQ36l6JLDnWl+lhKDX0uiucAjG6HqhENe5PH8HRi2zSchJqzzWNglY67RGFhGux0te5GqlP45bXLqBVyi8PqrO4zFhgXDSDmfFNo5NZiJsYWAmtVXB3OaqjCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734391516; c=relaxed/simple;
	bh=iEVYgx/hxX84VyoDEpscAjkrNLwDJylilFK5OuBYN9g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=N6CV8uGZ/q6ajoeKe6liOHTcxdKEtew1kiCrSAaD/qQPc9+ZGrjSxgzFeCqYn4eEsQ2SnhWv8kQhK17i3k1F58DZSBXCu43mCUB3GuMyxmeqdvZQp6RRfmccTFLQe36vGYXYdRWh6UnLWek56nISZy4sZHMMewDf+d+NUbsSBcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ySu7h231; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e49f3aa78fcso2261316276.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734391514; x=1734996314; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTHl2TPsCH6LymZInluDoB5DdWMc8GssygaKpaKL3WI=;
        b=ySu7h23181UwWbX3I1NG9aj9Z7WJvw5rfzZVCunSWu6M5wRL/3MKid1z1Jq1mQF8ss
         IxdyVPzfn5k25QW60zLy6oMWzCYMrT8VgEB3d4k8OkWkHkj4zaS91IEtyYaFzq46NEH6
         HYG6YhjSM4J2U5jhQhJYtfbMYlnzfg6JCiDIMzBhBN5rbep3+bLRpMTtyhQoCiGyVlln
         3wBKCUZqGFlt++BgOnjugtoSPLv85LnUvqH9QosH1VfafJLIK3Q33c5ERQ643iwTCYGq
         buY/lvfTV7n+P2xfEKoriDujBnvgWhBidSLVu29qRc4PRY8pom/rYVj0B/278AEMLL+M
         syaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734391514; x=1734996314;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTHl2TPsCH6LymZInluDoB5DdWMc8GssygaKpaKL3WI=;
        b=WtWZ2dBVznsX7c8HYf6+1gN3pZmQjircHd4fB6rdnE+p8dlD6ZVywbYtWgj60vwNbK
         2VJrJsBaKZdVsxSBGIL4AxIidmGd0iZThfRpzz7Yl14u5GPTB35KdQJZ12FtsSx8VOb2
         dJntnDguQUefAnYSLYj6zo5Sfre07xarKPAkwPWD3+MauuuQ4fasWN6RdE2MreXVwZXD
         9e3P4RTTXbnlsbgzBbYRRjomt895B/djXdUlG85s6O40eFSel7WRjG8e2LrhR5l1Qd/w
         M73ulccQmDleFRGeGTb2OuNQ6WhcVGQvMy48XVPMXOWPZ+Z2QL6Aydlplrhe7HhoDYP7
         PuBg==
X-Forwarded-Encrypted: i=1; AJvYcCUlnNQ7hZh/8xwAnL5pulAnELOjW2IjpDSH+UNAKw6mNmRSYx9pa9pHuiLaB5++QHF//R1FU8qOaPzlU/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEWE+X12pR/4bXbOMAmA1+VGOADQ2OqGKQ8Xx2jrbw0WDmuzlt
	QCmtPamtyHkV69d0hTBph2tNSHl+r7ARApTVuCX85vMuKKquCiM0J52kMo79rJD7JCaON2wJ0Ug
	TKTsybQ==
X-Google-Smtp-Source: AGHT+IFd1yidZo4+PCjzzLBKzlvBgB+iWRLxaQKGvW8aqa9jBsNOiHI2lkdQ9omQXubeZJj1mM0cO/8DOG7P
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:b850:b916:18b9:17a7])
 (user=irogers job=sendgmr) by 2002:a25:aa51:0:b0:e38:9694:4c6e with SMTP id
 3f1490d57ef6-e5325f97ca3mr554276.2.1734391514479; Mon, 16 Dec 2024 15:25:14
 -0800 (PST)
Date: Mon, 16 Dec 2024 15:24:59 -0800
In-Reply-To: <20241216232459.427642-1-irogers@google.com>
Message-Id: <20241216232459.427642-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216232459.427642-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 5/5] perf record: Assert synthesized events are 8-byte aligned
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Capture that events are 8-byte aligned and avoid later misaligned
event problems.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adbaf80b398c..a5689d0e93ad 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -624,7 +624,10 @@ static int process_synthesized_event(const struct perf_tool *tool,
 				     struct machine *machine __maybe_unused)
 {
 	struct record *rec = container_of(tool, struct record, tool);
-	return record__write(rec, NULL, event, event->header.size);
+	size_t size = event->header.size;
+
+	assert(PERF_ALIGN(size, sizeof(u64)) == size);
+	return record__write(rec, NULL, event, size);
 }
 
 static struct mutex synth_lock;
-- 
2.47.1.613.gc27f4b7a9f-goog


