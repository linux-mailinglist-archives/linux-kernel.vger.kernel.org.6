Return-Path: <linux-kernel+bounces-415274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB309D33CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE702837AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 06:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610F660DCF;
	Wed, 20 Nov 2024 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w+XsQmXc"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAA7848C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732085567; cv=none; b=nOBVO64GdCctLw4EgJ54bbLU3OLlYeKUX030XaiWhBsYN/oPLexTkjPxDBzLnVJk2Doh6sRR5AthbP3+8ctpVij1fluK6Ip1cGtc/rei8Jyj8RmvD3jj9ty8N+fgf31B9gdqA146GJQHUwHK3TRVQ6AAJFZUAlvHWkqesC3A9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732085567; c=relaxed/simple;
	bh=zlQRcmOt5d36/S6MQvKaqMJrGGai7g7s0walSI2h4n8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Voh+9ImnZV6/SuoeS3QivAYz0O4udmEN4uqJYhlT/VR2LaoPfeetAfu4/ftFyFX6Eh1o5NHapEteA9ILLSBLeMKLXNnkIGKuiukql1NwQNs2TZZ8gRFrraevjiFgy8XRH4mvvyjN3+pza+Hy5ZjNruLgzmQUeaMtOEq5cApgYE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w+XsQmXc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3891f31330so2938876276.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 22:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732085565; x=1732690365; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MaYH2W8sGkrg/tcGEaEzQRK218luN7NoGjzqVifhNqM=;
        b=w+XsQmXcIDumZfrzZ8YrHcNpYqu3WL3YjQB3mhFlD2e38+g5nRLcV49w13W21SdAuV
         Gd8oY263Q+viyvk/TnUF4ElKptqnqrqZ7kRKZ5jeBzvCqQwIGxncMsYnnFgTmWhQw4Nf
         OQuIAGpEuGZkpw0sMG6bu4IO1VDlJFSnHRhXdnLrGQRWK4qSmI5kNVJutZT6Cx+522sb
         KFiKrYn4duJO0geHdb3MLYrQ1uClGV+TEdLW6Qssew5jQ3ceH5hV0gTjvtyNZFdBfS7o
         /GPLGNVOpJiA0HwNWNcDB9XlCocXU0FgXlxHIL6cgXYz1RxicVvX3/SRxnR+/04nQVOI
         FKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732085565; x=1732690365;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MaYH2W8sGkrg/tcGEaEzQRK218luN7NoGjzqVifhNqM=;
        b=ip5arRoqH1eO9hWG1+90W3e/EGupHl1M/1b4i5an2gOJxHl29H3JKMGir80/u5A5yx
         IoqMoe4g5KZ24/5P4mkCqd/+G13HHwN80ue/VJ6ebE5YjWlw4u7b/9C7fJBpz2IIoK0W
         7lL50fEjDx2c1Yxu0zwoikByfFX+5uYKhqXlFvxmYyix5MkwrolJLx94+Bl9X3DoqJoU
         0QlWTIFlwM2gfwmSDmKN9qJGp3lJlQdmjcgEA0vaz/nJlksJdcuJkq94y1YNXqNzAswE
         fivWn2PWN/OVvLXKFrDCT3BZkF95U4UQl0u5geGyNAzEiqhun6H0I3cF+0RnH9kWj2MH
         jOpA==
X-Forwarded-Encrypted: i=1; AJvYcCUFSGJcp0VhxgNqYGHnt0njh27V6hNzSA9EFUHM/LIsiqGUA8SHeqvtAU2MBmPcpAwW9FcO7RQ7AAyupvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+C26RgrkGF/Oa2q5HREvp20g5elxKrhCKXOWikmAKz6oiBh2X
	2EXdc+D6grxPhTBqzk6334OxPnbnv1Q43wlWohvBqYCKperkWoiQD3Z4xw7A/84f2YiSnlol+ji
	rL5KkBw==
X-Google-Smtp-Source: AGHT+IGyd42lN7O2c3PrxL0xmpHYDINplOY7Y830evcZ89nZnibRmW42rFb+M2k6eliv+I1sDcAufOu9GHJN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f0ab:b1c6:6df2:ed2a])
 (user=irogers job=sendgmr) by 2002:a25:74c7:0:b0:e38:8794:240e with SMTP id
 3f1490d57ef6-e38cb564970mr1101276.3.1732085565348; Tue, 19 Nov 2024 22:52:45
 -0800 (PST)
Date: Tue, 19 Nov 2024 22:52:24 -0800
Message-Id: <20241120065224.286813-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Subject: [PATCH v1] perf string: Avoid undefined NULL+1
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

While the value NULL+1 is never used it triggers a ubsan
warning. Restructure and comment the loop to avoid this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/string.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index 308fc7ec88cc..c0e927bbadf6 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -254,11 +254,20 @@ char *strpbrk_esc(char *str, const char *stopset)
 
 	do {
 		ptr = strpbrk(str, stopset);
-		if (ptr == str ||
-		    (ptr == str + 1 && *(ptr - 1) != '\\'))
+		if (!ptr) {
+			/* stopset not in str. */
 			break;
+		}
+		if (ptr == str) {
+			/* stopset character is first in str. */
+			break;
+		}
+		if (ptr == str + 1 && str[0] != '\\') {
+			/* stopset chacter is second and wasn't preceded by a '\'. */
+			break;
+		}
 		str = ptr + 1;
-	} while (ptr && *(ptr - 1) == '\\' && *(ptr - 2) != '\\');
+	} while (ptr[-1] == '\\' && ptr[-2] != '\\');
 
 	return ptr;
 }
-- 
2.47.0.371.ga323438b13-goog


