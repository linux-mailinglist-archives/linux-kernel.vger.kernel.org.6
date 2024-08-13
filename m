Return-Path: <linux-kernel+bounces-284085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F4D94FCC7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8A42815EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977D51CFB9;
	Tue, 13 Aug 2024 04:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJgMPg86"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553C41A716
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 04:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523685; cv=none; b=WqMRH3BY+tMBAd5hDieCa5KyUlKbRfuZeCsj7pnf8X/OSZo4izBfm3XeEExGiHxbaOjWaL/7/zRYHQNX37WruErM2VFwyUU/EystRtkV4JM0sE7LTYddeP2ovHLVaFanzPc8zBLEAq2MxNKnvI9TY2VfjNl1rPEZrdAHBlm2KjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523685; c=relaxed/simple;
	bh=TXbtAZ78VlYEPkq5bQeQqXfNd0zldDdkfJRq7Lt8DSQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=cKE5yEYmwC+j3qhIdNH5ERfVgIyrgBI2KCg+wOrLBmB31AiFdt7ZQxpipf/S9FpiDJINjhMCnP1cWm49NX1OVA4mK7Cse1dGsn1fAJZIhvytBTlQOmJiUNXPrbfwiprEhpyt7sCKNYkoCHZFHmPtoW1FmcyI9XAu+/dOc6Qvw28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UJgMPg86; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-68fd6ccd4c8so116450927b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723523683; x=1724128483; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KsOsYbtJ24MSH9u5MSn/Posi4hFu1AvbaINA/C3HeDU=;
        b=UJgMPg868uS6z3I+HS9kWdsdv1qXXkoAWW1ByfzmER88Ad2k1qw1dyVXS3vS6zOs85
         rJWKO90r7DbClwen+jmnFeI2n0NugeMBgzg2lDX0D+WtvhxhacdQT6ltklgvXiM9MTjo
         PYP/7e5m71wknY1w2/Gs8L5UEgsOVI0MAoUeLY/z+EjCtIQZDVEmDhJ6vcY99lWSJk5J
         CXjSD7/Kr68YyD2v9rmPLDinv0coplMlZBkAqbPeYRCpuVRvZT88IDbknlEEfnA/XR5+
         6dexuHFgvesQO1+wwdN993oBHbNPhmeM0C0ISRgvRXqrwJ7l3RmVs/6h8HwN4vDLtgZy
         3vOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723523683; x=1724128483;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KsOsYbtJ24MSH9u5MSn/Posi4hFu1AvbaINA/C3HeDU=;
        b=PjbdKa8SjeG8dWvXggvrmXtHHd5FoQQ6jWyZe5M3GVtnw5JlJ05gT1QuJIfrGqbpqL
         DBBdg+VOCaR6LmqgSpYuCfSqp8GPHac8/0OQsVx8JraXYVpWZLIeVzcBvdn25zRdIoFt
         CSjuUoijAjsejZM/iOxxO5t4Ii1wtKXcTkddFGDK4hWUMMwLn4zca0cFVs9BYyeYuBTW
         9QIg1jv6hL6qMjFVxG+JgcrxhgMFjoN2qcku2G3d6Hx2tZ6PnReNQr+f0oQ8QmJZddOQ
         Jd7NMdlvL0G34yGuOBwIN/pe1CZ04+tuUnlz5JEBGQ3fCUOzSXslY4hgBQ1FMMtncRuh
         qFOw==
X-Forwarded-Encrypted: i=1; AJvYcCUs8a+9458rtB04rJMl/eGMEEoLQJgdD09+K/knFj7w/rbY4PcTAwp8rPcxwImmRrd+DQaF5uFGbqnbziGO13x9hNNCgvOZkMA+HCCQ
X-Gm-Message-State: AOJu0YzIx4HZmIDhW3DRGLL4bPS2ANEzr2FO8/kdUsXykEojF2wMxacf
	xHhtwiq5xuvdLK3drIKYeXn9gp8++KZtbq6snDh8dMnTTslEsaCbf/XihjbM93FMG1y+377yZZ5
	n2LGYfw==
X-Google-Smtp-Source: AGHT+IFKX0XgPJ8uEeagN2xbmgV/W6qlop6h040h/mSwx5yI4uJGowwe+eMGBY52OLtI0yxzaa6gdXJKvSR/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ae34:31b6:7154:c399])
 (user=irogers job=sendgmr) by 2002:a81:b810:0:b0:64a:e220:bfb5 with SMTP id
 00721157ae682-6a971adda3bmr1108067b3.1.1723523683272; Mon, 12 Aug 2024
 21:34:43 -0700 (PDT)
Date: Mon, 12 Aug 2024 21:34:38 -0700
Message-Id: <20240813043439.933329-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v1 1/2] perf build-id: Align records to 8 rather than 64 bytes
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

Events are 8-byte aligned in perf.data files, NAME_ALIGN is 64-bytes
which is excessive given the alignment needs. Move the addition the
sizeof so that the alignment considers that the rest of the event is
4-byte aligned.

```
struct perf_record_header_build_id {
        struct perf_event_header   header;               /*     0     8 */
        pid_t                      pid;                  /*     8     4 */
        union {
                __u8               build_id[24];         /*    12    24 */
                struct {
                        __u8       data[20];             /*    12    20 */
                        __u8       size;                 /*    32     1 */
                        __u8       reserved1__;          /*    33     1 */
                        __u16      reserved2__;          /*    34     2 */
                };                                       /*    12    24 */
        };                                               /*    12    24 */
        char                       filename[];           /*    36     0 */

        /* size: 36, cachelines: 1, members: 4 */
        /* last cacheline: 36 bytes */
};
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/build-id.c         | 6 +++---
 tools/perf/util/synthetic-events.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 83a1581e8cf1..8fea17d04468 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -309,8 +309,8 @@ static int write_buildid(const char *name, size_t name_len, struct build_id *bid
 	struct perf_record_header_build_id b;
 	size_t len;
 
-	len = name_len + 1;
-	len = PERF_ALIGN(len, NAME_ALIGN);
+	len = sizeof(b) + name_len + 1;
+	len = PERF_ALIGN(len, sizeof(u64));
 
 	memset(&b, 0, sizeof(b));
 	memcpy(&b.data, bid->data, bid->size);
@@ -318,7 +318,7 @@ static int write_buildid(const char *name, size_t name_len, struct build_id *bid
 	misc |= PERF_RECORD_MISC_BUILD_ID_SIZE;
 	b.pid = pid;
 	b.header.misc = misc;
-	b.header.size = sizeof(b) + len;
+	b.header.size = len;
 
 	err = do_write(fd, &b, sizeof(b));
 	if (err < 0)
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 5498048f56ea..a52b85bcb6b6 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2236,14 +2236,14 @@ int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16
 
 	memset(&ev, 0, sizeof(ev));
 
-	len = dso__long_name_len(pos) + 1;
-	len = PERF_ALIGN(len, NAME_ALIGN);
+	len = sizeof(ev.build_id) + dso__long_name_len(pos) + 1;
+	len = PERF_ALIGN(len, sizeof(u64));
 	ev.build_id.size = min(dso__bid(pos)->size, sizeof(dso__bid(pos)->data));
 	memcpy(&ev.build_id.build_id, dso__bid(pos)->data, ev.build_id.size);
 	ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
 	ev.build_id.header.misc = misc | PERF_RECORD_MISC_BUILD_ID_SIZE;
 	ev.build_id.pid = machine->pid;
-	ev.build_id.header.size = sizeof(ev.build_id) + len;
+	ev.build_id.header.size = len;
 	memcpy(&ev.build_id.filename, dso__long_name(pos), dso__long_name_len(pos));
 
 	return process(tool, &ev, NULL, machine);
-- 
2.46.0.76.ge559c4bf1a-goog


