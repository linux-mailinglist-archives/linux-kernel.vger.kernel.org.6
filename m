Return-Path: <linux-kernel+bounces-442725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA8E9EE0D7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F167D2821CC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D5120C013;
	Thu, 12 Dec 2024 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAAke++y"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E0B20C00E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990740; cv=none; b=e8bhK8JhKkoJGyqk5vzm93Swd/oa8NooM9tERykx4xphNd3Oc+DR+eyY4b2VnSpApNFrouAx0TWE3EzVENW9UkxA9qRS8Z2+qIDhCAKfPsTzwOqenTJAriUlqVD4YL+EBPde5X6AFIj3u3tH1BEW5sCkEYp7xpS3O40xuEC3Uas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990740; c=relaxed/simple;
	bh=iEVYgx/hxX84VyoDEpscAjkrNLwDJylilFK5OuBYN9g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WIL5/1J3KLRqMCM5yzlYVSnNoDOiKGJdRUJaoX95iU/6lscWFnhCOgcTrVCM1S/AdXVi/0nS6ZNxKc900rCDxsH3JckFvqtHCaAIADPRIx2gmnQMBXUD2pNp3edNRw0G17OVm0nS8FrFQc3leQhgbpIEaJMb+Ay3FqRvE5/EckY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LAAke++y; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3c61a11a40so401853276.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733990738; x=1734595538; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTHl2TPsCH6LymZInluDoB5DdWMc8GssygaKpaKL3WI=;
        b=LAAke++yMNo/sV7z6+FgooHbJAWChVprJHnV4u2VQIW8t8U+iQs2fGDm1rM87+KK2S
         jJQpl2F8uLrnM3SM4dLNbnb/fHGn+fF5TiFGHOYF1ls2MbM3eHLiJpd9oEnOezhTRfd9
         bRhEINvmhhhOXvtXoUt3/ygcDW5Vtit/mlRdj1/gPRBLYKDI64YIJIi/4GV2BGWj8zcV
         /YR4t15uhUkD3jXgxNGlJL+oQ/7UGGZu4uCYug11vvuQNdiy3hLoIdE1tQ0+WSzS2MW3
         IdMzA6BI/2RdyO1r/kClxhsyINso54d86Ha8XsXpxx0G8hSzpf2UqbcjRIEgpMGNpvq+
         lK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990738; x=1734595538;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTHl2TPsCH6LymZInluDoB5DdWMc8GssygaKpaKL3WI=;
        b=JoqDfftznzuCz18Yzv5NpM2eazTkpM73MEM1noJLy5mCtb1i1czTZeWm7EXDoVJQ2D
         dg65K1R/uZQo+Uf31ME3yobJV5JdNlPeYFpC+UHvJ7NW4b/C0xNGH/qS+fbLwA1GSZRw
         wpMYXY8cNw+wIATRmJP26VqBm+IPri6Mn0ehQQkr0UNCr7psCmpgMYTxgjTPDN6gEjj8
         FrdDruYCddApWJ/Y3huJWsoBHHFTlvvzJ3xZdSWA4ADS5FDNQIPs9birhmA5XmsKecj6
         s1gdsIVZPborEsnDAPzmgj/9IeoQeeHMO55cw40uDGXD5Q1md9wxamWwhFql/FqWB+ON
         XTCg==
X-Forwarded-Encrypted: i=1; AJvYcCUf7ypzKUZSL1qYEck7UCpASDh1l0oCG/inaGaY57oHfy3I09Q720/C9qZDn4mIe08ceaAHViDem5tMZjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz25EdfO/DaPpuNIUtUZ4AW1eykVTu56acsxQQnn0z2UN23/I5l
	VwiuClKzPbw3E3DBqw3TGK8nEu1iC9/b2Ne7ZEp0/eGWTTJhHT/lz6J6aZ9utjS24FBA7c/n1Aq
	nWrvmuw==
X-Google-Smtp-Source: AGHT+IGBXWJ3ucqX9hMLm0vrc3zRY5NRfTUR84iS3B8eBzM1iEFlb5CZtt1FWUdjD/dw6Z5GJ9hNZsv5a41v
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c22f:1975:e7cf:849c])
 (user=irogers job=sendgmr) by 2002:a25:58c2:0:b0:e39:fc33:e15e with SMTP id
 3f1490d57ef6-e3da21da53amr1406276.8.1733990737951; Thu, 12 Dec 2024 00:05:37
 -0800 (PST)
Date: Thu, 12 Dec 2024 00:05:30 -0800
In-Reply-To: <20241212080530.1329601-1-irogers@google.com>
Message-Id: <20241212080530.1329601-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212080530.1329601-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 3/3] perf record: Assert synthesized events are 8-byte aligned
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


