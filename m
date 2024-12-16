Return-Path: <linux-kernel+bounces-448290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 908CA9F3E36
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C595D16E250
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AAB1DD0EC;
	Mon, 16 Dec 2024 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crfsoyi7"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ABF1DC18B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734391512; cv=none; b=mEwUM6fes/QHW0Atew1oClrlE/TdQfooF49sE53P5dTdCk/ctkt8oN2wOZrwiViBQKxGc5rcvVI991Fp25N/kjsZDo7qWEVNU77rdSo+U42r8hzzBgOBHCc7EETYhy7u7PcW2KvMQYdJQpMsRECO3zp+SDa7P8yjFrxkXBRSOO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734391512; c=relaxed/simple;
	bh=BrUJvr7HXzMJyoNYnziI4wlrd5p8WOXp8dhXnVgi80k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=G/kRG5ar7to8zCAPW0t4GuC5k/g/+gMVk5kjNwBp8NBSOM90Sfg8iH/8CpiNa0lVhRW423Gamq4/JL2I1Za/TR9yrcCX6LtVCU1tmekWYNi0HYrkTnQ1JHjNQofGmqamOIXVcoD3HNAAjPg6R3nzOKpbX17BY1WOGnwKDn/mOgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=crfsoyi7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3c61a11a40so6887371276.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734391510; x=1734996310; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cLJ1stvpEh/i9mxehEqquhSJV82oFfMq3Eq8V809bTo=;
        b=crfsoyi7TwlBKtEypJWDFUPLCQZE7GZG8G1J4ekb5xwxsMQ0YUQsntvGoZ2W/9eF8V
         Ge47PAvXRNdxG/btRXTCcoHaz2mi0tWQXyyrSELNgOqP84Z/+108CbQxiJQRsKuMj/32
         MqbI/fcjg4KJSL4jYTuC/DH7yXWX7VAyxSOLUvd6RcZbao6MzDjJxTZ1DZiidybaHcYE
         AS4WSHO2xBUJay6sNfTSACc10D3nxH1HWxAFY80VWoIw3NCytTkBOwi+QqY2LasqR7EY
         fE/YbSqe6ZVbFPG3F6jRCiwE2WWmm6RX1tY0OYX7rP+840A7WWC42onW+dtOtyrgGTbC
         xx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734391510; x=1734996310;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLJ1stvpEh/i9mxehEqquhSJV82oFfMq3Eq8V809bTo=;
        b=G0XFr5uzehEwVYCsgP0JZh+Huh5bWCeDLDxdEv9IPF761+3xFBgs5JzpzU4XGpYs2e
         DJwfOxL8VmT3WoBSUfvEDeiJT3PC7YNckWuxM7ysz49FxYW1+oqVFpEHIKU0LAeS2PQ5
         CjZODNcPdpbgrDfS3GvjLz65iIleFIv4ZTDO2O89X/SYr4zC6jBQYpH7NgvS0vtV27ce
         QBLlpfZFR+/3bRjM37M36ycOMvYNZ29vI47LEnJ5YWlPT+vbXsiQ9ZHzAiRtEDqlxTB7
         YUQ1CF5CIabLFhbwbyYGObh30vBVhyuzA81Txd8xoZjAnafejeNBHVAy0CrMiumZzQav
         GjtA==
X-Forwarded-Encrypted: i=1; AJvYcCWLPoxUa1z7JPJub8OSlnyaYYEoIDDs+xIxAvx12JAFBuggcW2QjrE+A4Jol8VRtVFdtypSy8VqC3804rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqoorYu98i700+05wiGUmonZ8EMsnMLYwuy68sIuQlsDBu5tti
	YSvoW64UiPO1APrpT9bFff/UtMO64h/NrOeeXxPK81NA0nD3mnJE9MRL4YvOlt2R+NWpjixMB+I
	2rlTsKw==
X-Google-Smtp-Source: AGHT+IEBk2ZWqf3tvA5JHyC7+FOyJZXG8fvNRj78GZbr7laoh+Qh/+6h6VlNMjqZMzkUaxrw+ZzcYont7naS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:b850:b916:18b9:17a7])
 (user=irogers job=sendgmr) by 2002:a25:c74d:0:b0:e3c:88e3:b8ba with SMTP id
 3f1490d57ef6-e434e9bfa53mr7252276.5.1734391509720; Mon, 16 Dec 2024 15:25:09
 -0800 (PST)
Date: Mon, 16 Dec 2024 15:24:57 -0800
In-Reply-To: <20241216232459.427642-1-irogers@google.com>
Message-Id: <20241216232459.427642-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216232459.427642-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 3/5] perf synthetic-events: Ensure features are aligned
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

Features like hostname have arbitrary size and break the assumed
8-byte alignment of perf events. Pad all feature events until 8-byte
alignment is restored.

Rather than invent a new mechanism, reuse write_padded but pass an
empty buffer as what to write. As no alignment may be necessary,
update write_padded to be tolerant of 0 as a count and count_aligned
value.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c           | 7 ++++---
 tools/perf/util/synthetic-events.c | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 03e43a9894d4..d10703090e83 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -168,11 +168,12 @@ int write_padded(struct feat_fd *ff, const void *bf,
 		 size_t count, size_t count_aligned)
 {
 	static const char zero_buf[NAME_ALIGN];
-	int err = do_write(ff, bf, count);
+	int err = count > 0 ? do_write(ff, bf, count) : 0;
 
-	if (!err)
+	if (!err && count_aligned > count) {
+		assert(count_aligned - count < sizeof(zero_buf));
 		err = do_write(ff, zero_buf, count_aligned - count);
-
+	}
 	return err;
 }
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index f8ac2ac2da45..ee6e9c2fb11b 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2401,6 +2401,8 @@ int perf_event__synthesize_features(const struct perf_tool *tool, struct perf_se
 			pr_debug("Error writing feature\n");
 			continue;
 		}
+		write_padded(&ff, /*bf=*/NULL, /*count=*/0,
+			     /*count_aligned=*/PERF_ALIGN(ff.offset, sizeof(u64)) - ff.offset);
 		/* ff.buf may have changed due to realloc in do_write() */
 		fe = ff.buf;
 		memset(fe, 0, sizeof(*fe));
-- 
2.47.1.613.gc27f4b7a9f-goog


