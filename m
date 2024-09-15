Return-Path: <linux-kernel+bounces-329646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9315B979441
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 03:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BDE41C22863
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 01:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427824414;
	Sun, 15 Sep 2024 01:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="NDVAewn4"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4F10E0
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726364081; cv=none; b=Q9wCv7kzn9suTqbIaIFhqHfNfPTOK9/02jalaFR+gEHOhBzR8LlCdrBvjBxQ+ozDTaGuPnGYyvqk0gX/6l2VwoOZ/hMu30JU+WsFdaQJF3xJB1CzvSyJH5iBYGyMgs94Q0/+wcV8M7aYZCcvEtwYyEtaKGWBSvc/dMgYOxAoBpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726364081; c=relaxed/simple;
	bh=WHsjzXtXBijmxvygC5nGMZx8Br6m9SY8IsuFanUqI0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=toKegNtRBXYU+beNqlMD96AkLJftf7qFT/jgqdhT0Uc9jJU1VAmCiBVa6+wL+adc8NHDW1eUHWIQHfxfuwXP45eF9UWSqazTuU4FHXhLI9Osi9LV9BvZC2D19ZGO42pUQSIVVnJOg8IfdZY0ohfJmVjAfUfUqeOs5ZEUIE0AJsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=NDVAewn4; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7db299608e7so1294079a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 18:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726364080; x=1726968880; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TxC7pKFRGcmNKUwXYsUBgABTyllr0V6K/bCfbRkqsEc=;
        b=NDVAewn4KyI2I+QMLejCH5bO99keEax1mr7MxQy0fAfpi/zIZioO0IhnSKXfZJ8bHH
         VNQtBruEkP7RKQVEXAcLjvRaxQqvxVQdrB/90bk4pqutlU6vwep9zJcBoKhz7y6UnbDZ
         6FIsZ4nZLS3WnIa8ZtYAnGcncD7X01EgWDWV2e9MUnurXWA/ZDNfnjZYaecRSnNo1Xyh
         /l4yv1eBc6RjLQa0MS3pLYXgNU8v0tiDqUfXZxp6MG27RR1t33qOxF/BqRRCNc4kgpCJ
         kfnkJ0DQBMTpN3yz5pjvH4DvEOpo75/YV+zzEuiW4cDvfxM8Ux8VBqkGtKcARKSSld5G
         Ks1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726364080; x=1726968880;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxC7pKFRGcmNKUwXYsUBgABTyllr0V6K/bCfbRkqsEc=;
        b=jqkY+rnA6Wo2bfuUw1vF+TNga1lLq9ztxZ1Q7QMBH5sq7TFgBdTa+cKIJ2Tl38xe2Z
         2aJQwiAddF4PvT79YbDgMPhWxqr23FQn61ESNgifqacYPN/FU6NBsF//dljQrPFKACCK
         yU+YVbjveaQRSleukUrSPWsbX244OPhdmAPcH2ODFrkOLmlskJOM+/WlA96NBUi/UUzD
         WoM26+KhFL3JkF9UtLTjggTxvrGRGwNIw5wG5DFMu8nqdtkNLayRuFmf7TNmOrVKaad9
         WYN22qze4s6hdMPy10akZN0Jnob8wq2Zr1iYmQRmLcYCF59GDSgvMFdWo682Y9FkJghJ
         19JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg0TBhkOObftDtkw3KU/iaclgt5+exjmrj0ddwjn/uZlSbulY1l2jOylDU2767vejFs4rSwJb51WwcOaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoCJPUWIJNFmdKrBsCYsi9fb04SYUS1D9fFaNEAa6cAfa1VvZi
	Jmu5HCXy10g4NS8hhwY8CYqE7gRU30kOaiFKSWUXt/MWW2M8CdOerveaOIffO/XN0G5JAYMTbUI
	cv4I=
X-Google-Smtp-Source: AGHT+IFcG0w5Ow6ZUv91tanxPQP3rJiOqiKtymzQ+bt/5UGpy1GHWpsZXm0FXKr7A56G205mM+Yq1g==
X-Received: by 2002:a05:6a21:6e41:b0:1cf:46d7:54a5 with SMTP id adf61e73a8af0-1d112e8bf0amr11640742637.40.1726364079761;
        Sat, 14 Sep 2024 18:34:39 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71944b97e45sm1521188b3a.164.2024.09.14.18.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:34:39 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:34:29 +0900
Subject: [PATCH] libperf: Explicitly specify install-html dependencies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-perf-v1-1-cbfd9cd1d482@daynix.com>
X-B4-Tracking: v=1; b=H4sIAKQ55mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwMT3YLUojTdNHNzyzRLQyNjM9M0JaDSgqLUtMwKsDHRsbW1AAiDQEp
 WAAAA
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

install_doc of tools/lib/perf/Makefile invokes install-man,
install-html, and install-examples of
tools/lib/perf/Documentation/Makefile at once. This invocation succeeds
when make runs in serial but can fail when make runs in parallel because
while install-man of tools/lib/perf/Documentation/Makefile depends on
all, install-html depends on nothing and can run ahead of all.

Explicitly specify the dependencies of install-html to ensure that
they are resolved before install-html.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/lib/perf/Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/Documentation/Makefile b/tools/lib/perf/Documentation/Makefile
index 972754082a85..573ca5b27556 100644
--- a/tools/lib/perf/Documentation/Makefile
+++ b/tools/lib/perf/Documentation/Makefile
@@ -121,7 +121,7 @@ install-man: all
 		$(INSTALL) -d -m 755 $(DESTDIR)$(man7dir); \
 		$(INSTALL) -m 644 $(MAN_7) $(DESTDIR)$(man7dir);
 
-install-html:
+install-html: $(MAN_HTML)
 	$(call QUIET_INSTALL, html) \
 		$(INSTALL) -d -m 755 $(DESTDIR)$(htmldir); \
 		$(INSTALL) -m 644 $(MAN_HTML) $(DESTDIR)$(htmldir); \

---
base-commit: 46a0057a5853cbdb58211c19e89ba7777dc6fd50
change-id: 20240904-perf-f779f912365f

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


