Return-Path: <linux-kernel+bounces-402701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3F79C2A97
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFD71C21A7D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C101465BE;
	Sat,  9 Nov 2024 06:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pe0PyR/b"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638AC194A54
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133144; cv=none; b=kzo0ZuBQOAPjXyOiEbUpMPEJ2L0MsR+sT7i9UwXmHTHsPrJvJSJ1nD2ACrV8xqS6WsWhUF+OrlW56mibeYy6dZHztRZnzCDCToIz8xcqyhyYkAu3vNYzk8Qz9zr0rU+N0tR15p/CSldz18BKXG0bd/5iLc6jfxZniOA6aYKirOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133144; c=relaxed/simple;
	bh=0iUYu8ZIw3nC+tEYsru/9b2KOk5bw5n11avghkE86XA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=V4pGDDvPqfrTgyZYGN/2Cf5/mUQSLNWuhMNTsWiGMw4GZijfmMjJ0n3dnDRG2uF3pt+OlZvmAuDpgK12RsUWbd4PMkUxUuDS0LZEhSrAv9BDZVG4oLnp2CWPSta/Bn4VxxPycS9sH00W5g2SH9lhgDGd6m1XTr3vADYN4LBQk1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pe0PyR/b; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2b9f2c6559so4455925276.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 22:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133142; x=1731737942; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S5SFBUvJ8uwJxM/+aez6JFuBLxdqirz/XmWsuAyloP0=;
        b=pe0PyR/brtyINSUrq2YTH4JmbZYi3hReROvO0OEF6Ey8JmnRYdQRaZIkIob624UDNt
         c0dflv/Yc88+fTaoh0mPokfV1pDlHh+Z8U+H5yzHsSE0XxcVrvHstRekv22XGREvqGn4
         6IwAyT8TxQrOLgVW/CiKM50T+zK5rEKoJYcR1lA6AFM3ZxAfJVUAMaeRrwf6jS/t51zf
         EpnHhx0vcxuCVYnkp8ablv6enA3tuvLNbsTQ01ta68TKMWQFTKEj9P4YNKBgf8pX6fXY
         ORI/KuAzmSa0pQ49B4PhfTd3WAK85i/OpXigEHwJqDSYZFlVhM6ukkFsHJaJuItrdyf4
         9D4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133142; x=1731737942;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5SFBUvJ8uwJxM/+aez6JFuBLxdqirz/XmWsuAyloP0=;
        b=RJwUfrD6auAtLWYIraKKJhvCu0oHxFzoM/ZZItrUcm/Zc6a9BcpryX0/XhdNUfUhgF
         BnezkBcojwJgDmqLUmCywezykgZ3sla3VVz7dex63+dksUXY/DcY2LtoiZaqsgL9TS6S
         8XLs5khIqNe83wNp9taG9Z1d0WmIgWm589Sxj2Nulin7KwSAeDB4iX0kOf1G5ywynC6Z
         LHpRuaAycfHofKP2WT0//057nHK9fU9G4T7TGJUZPPo7JMbIqLHfI9q5+33sZTdTWh4D
         P4PZCydzhO2W/aYWrTrPhcni0R5k+qjSrOEHnJbc04OjggN+zp2OeTIUz6to5jM0MsbI
         0l9A==
X-Forwarded-Encrypted: i=1; AJvYcCXNS19ljEk/yECOJcyhZoeSZHx/VUN7JpqWBMXnMWXu08zDOfCbjYTfsRP1Xgl5JUTzKj+GHnUT6gHtpCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYR/L+CbWiSIOn6jYTlTU7TNwyXqrdCmwX5eLrbQs8ir4zhaPx
	J7xeiyfPyP9nJCS/3o7k87sJx0F/UiXRHNBu5N2KETK9azvbQZTtf7nO87Rv3Pw+yRGzSZbS3su
	1t8aeqg==
X-Google-Smtp-Source: AGHT+IH9AHh43wZI95SDyksqtxouXEyTkhOjimgLo4B9ZLCzen6gdneqeJ2en9MS4bz5JA8JbbcbHNuqPciu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a25:3355:0:b0:e2b:cd96:67a6 with SMTP id
 3f1490d57ef6-e337f8c133dmr3844276.5.1731133142342; Fri, 08 Nov 2024 22:19:02
 -0800 (PST)
Date: Fri,  8 Nov 2024 22:18:05 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 18/22] perf build: Remove test library from python shared object
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

With the attr.c code moved to a shell test, there is no need to link
the test code into the python dso to avoid a missing reference to
test_attr__open. Drop the test code from the python library.

With the bench and test code removed from the python library on my x86
debian derived laptop the python library is reduced in size by 508,712
bytes or nearly 5%.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index cbcb698cea38..adbc7ab325c7 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -487,7 +487,7 @@ endif
 EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
 LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
-PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH),$(PERFLIBS))
+PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH) $(LIBPERF_TEST),$(PERFLIBS))
 LIBS_PY = -Wl,--whole-archive $(PERFLIBS_PY) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
 export INSTALL SHELL_PATH
-- 
2.47.0.277.g8800431eea-goog


