Return-Path: <linux-kernel+bounces-290567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BAF9555D3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 08:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BAC7B22685
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 06:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA491459FA;
	Sat, 17 Aug 2024 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KlcxmJZz"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F0E13D533
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877115; cv=none; b=HZYDWVzXz9+Bk0lAzvSS4uitARB8QwjxxRtX3XGlsGZPseTtTKY/bgPCmMLHjYPb1Te2fWMrj4GeASXK7Qq+dEvze+V/cMNroFFY0O7BSbeYpaGLXuNfGYtQtQvaE8xfxS2D52gMalVz29PtFnMoIYGGNRWIBSrcwTsVB5mEMRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877115; c=relaxed/simple;
	bh=Rb69KRKaI/u5A/8MYxV4P2TpQD+CHCaIYh533YAFMbc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=quh2x+ZjlF1BFqS7zJkJ3BahKgVmz/azV+lvRQEoY9RjPQW+RwHkJoqulhTKzdeBwIVBDgmIUxmYJypBNLxLmFyTupqhG5ljG042YPbMuDs4PWnmrkJQOUxfNSUauDz1YXKMvwHhJXVJBWNaSkxgpxj8VkX1ciZmA8zurMUPpEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KlcxmJZz; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b46b3dcc96so10544877b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 23:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723877113; x=1724481913; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUA8AhsoJNih2SdQBlGMtrsJvyfXDO16nIF63MLLSZI=;
        b=KlcxmJZz8S+i/TH8jg3hz0ttl0oIxPnUV4uUqLYGfqVW3uDLklrA92+HBUTvyrmMVI
         P+QbhkLTIGi4F2K98HvTT1QWffNo/wc1iAALkNrQe0guhOMCvQs/6wl3tFoxU5xIP3qb
         1TUyiw7i9wB88uhXvqWFS1i7KQxC5SijCT1JNsRT6Eu4g+Rai+5Gx8UCuEZ2VkjVNeVd
         NZ7D4UxrLl8b3RQmkaWCaA5+AqlqFeGJKulatdA8J86H6XPTzzCdvLCxTZ8Hq0vq9Cmy
         iMUlwMU5hMpNmui5mZsViaDqSmxeVztWg0o72GyMPCFG4V/kZAJLc2icGu+/gkV4cHbS
         hChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877113; x=1724481913;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUA8AhsoJNih2SdQBlGMtrsJvyfXDO16nIF63MLLSZI=;
        b=SiAMAs3BZBXFwYH3tocq2DqZmCZAhysTiERqvT2qiDTg8l4ZWKmV//AWfTcKokRaJu
         v9ZeMTzNHKh0OSnBr9J9GFOHZe01z3b4ZNRl1NZktUP+wp7h9P0HO4nJiaS6InGqdZKI
         FYY75aUXnhO7KPb7w/XBL2a4UR+IveMRYI7a0UoePAWqbCLmF0Afe8kXyuMHFmson8nB
         Z0HZtA4nE+cVm2zkArNgJaDwWWi4uUH2XqqOU4KbLOnCrxiAmbH1THZQg8URBP0Y10ae
         h/wbeog2FWboPd4VImv/b7l8KMvm2kbr5hAIGbLeWFnMSV5f+SHA9h2zSB4FTar62X/A
         PF7w==
X-Forwarded-Encrypted: i=1; AJvYcCU6eTBK6cvzSo7V2qdjNzxx4h6/QItj8Wy562EzwDWf48/v6vRmlACOq+4YhcTypCmrLOfK/VzkK/fY+90+YGIazq7YDq/eaA9vkDFT
X-Gm-Message-State: AOJu0Yw3oCMuDEdwUYFKJx439iMZRIqyZojW/7V1o0Akt7hHSn5i3qdZ
	Ofia29uPtfncONkhDOut+r6SvoZcY75ebd4YEARI9RkW5RlycG8xKoQmxMcnof8Gz8eO8WloypP
	4IvIv/w==
X-Google-Smtp-Source: AGHT+IF6UXe62Ch7dXHjA82oHLXQrRvck/l/nZacvEl3Mldvm/x0HxqD1wmw0YpclopA5YWKR3dSdsq8Yluo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:78c9:5e58:734f:c59f])
 (user=irogers job=sendgmr) by 2002:a05:690c:2e86:b0:65c:1db1:9235 with SMTP
 id 00721157ae682-6b1b16adf5fmr649637b3.0.1723877113170; Fri, 16 Aug 2024
 23:45:13 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:44:34 -0700
In-Reply-To: <20240817064442.2152089-1-irogers@google.com>
Message-Id: <20240817064442.2152089-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240817064442.2152089-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Subject: [PATCH v1 05/13] perf evsel: Constify evsel__id_hdr_size argument
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Casey Chen <cachen@purestorage.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yunseong Kim <yskelg@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allows evsel__id_hdr_size to be used when the evsel is const.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 2 +-
 tools/perf/util/evsel.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 38a74d6dde49..49cc71511c0c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3048,7 +3048,7 @@ int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
 	return 0;
 }
 
-u16 evsel__id_hdr_size(struct evsel *evsel)
+u16 evsel__id_hdr_size(const struct evsel *evsel)
 {
 	u64 sample_type = evsel->core.attr.sample_type;
 	u16 size = 0;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 4316992f6a69..15acf293e12a 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -442,7 +442,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
 				  u64 *timestamp);
 
-u16 evsel__id_hdr_size(struct evsel *evsel);
+u16 evsel__id_hdr_size(const struct evsel *evsel);
 
 static inline struct evsel *evsel__next(struct evsel *evsel)
 {
-- 
2.46.0.184.g6999bdac58-goog


