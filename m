Return-Path: <linux-kernel+bounces-276073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485FA948E14
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EB5288B91
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3019D1C3F13;
	Tue,  6 Aug 2024 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="caJoPGOh"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222271C4602
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944904; cv=none; b=EBSKHn11ljDFr52eYliBzjBK+U31galpVEBa6fC4QBSbqI1bojpITP/f3Hw6jX6b2eTzajejiBFwpgDvtRpITD9RBy4qinlGs3lFKVq8UcLH3SGL4vnstIjwjKumRd0BmNtt+8xp1m8tQ/J7eq8UPGsOJn9O4Cqi3rmu6eVjFms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944904; c=relaxed/simple;
	bh=qIjEnSp/JD5JYvreiYWkbvBNFQ5Bxx+6BfLNwZTCc7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LRqU0AL5Q2wsH3Ne3JbG/O7pQESdUVU8QUv0w7h6kO7QGE+SEmv3jiRqoKLqMEPsCgRtqmN/uNGMcOppsd5pHtJnOQqMpF8IQiEYKx2OuknFKqDUGNpsq4++OewDm3AJxG9SdC6AhY72DGdIwcoZhFlwTxRkyuuyNEIVG4xUhwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=caJoPGOh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70eb73a9f14so322967b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 04:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722944902; x=1723549702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAh5UOxYiMS3JZXwzAnpcBRKJRQgjrownZOetlAThLM=;
        b=caJoPGOh+t/yGXHj90WGjnDWT+5uyxWYRmuK/YWB+UAJGSwPeLCA6yR0+gh+N/I5+5
         kDp+HODBX3hM5NZgbf/gBlAjolv7Z2bRRtxtqdl5Ea1uMRT+8lN9JQZ53cXfgMMqiMZD
         xu1LGW9mHwflx7XQS5XIhpXJtJzxpFjKf4ziGaVhKdlTF9AnIoI3JuLsmALzCfmnauWH
         o30uXNf8v10E7mwiJmAtI/02ajxZ7ByY9Gt9CmwUKiXLVgiWeC80+eIrDSJeUPcI5CoP
         Q0rM4Yq7YN+Os2yCi3X5XLIRycAm9sIjefo21kdOZvJG0dCTyQnrKMJv65/O19mRQPJq
         KgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944902; x=1723549702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAh5UOxYiMS3JZXwzAnpcBRKJRQgjrownZOetlAThLM=;
        b=f0voXL3UKSWT9dgCC3DmDmGmsqqOsVv8ph0SgsWy3Xuca21GKJpDUeNjH2Qc6wb3PT
         8RPCDC7T/4khU+bjbSg0VvoyuWMnnEdxm+oMFaxizXosqAJYrdrd2fZkb+8nioi8Ambe
         8f22Ud5QSRsiJ56lFk8MB2i9OWk5rAbpZZVYn6jHqO7EV+StXubimubiNVuGcoiW1pyP
         Xt1rFZzDtDnTDBHAl5bTHVosFBIFzIIpykZV+uIqv4rMl4BQwceDEE6totq//esJju+4
         aPQLPd1B/ataQEj1HUmU5KiyULw+73gqv0opXlRE6//g9htoSnr4IE7YYk1oOtsF649c
         FvGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW1H1ws98RfzqM1wI8ZgBUlED8jkxGwOCdTdySWFOUQVe641H4ZpL4OGV2V5A5jh4/sBiz44htlaTTXjcteRLIce/eNNexmdI53VPQ
X-Gm-Message-State: AOJu0YwK9+jfsJXbSeZg3xKBtIa/qAHQdOeRyj3t5/WX5hsw4LpKUauw
	bWTphucY+Hpn+XDqc1EZNjUti40scPqGM78T72p5SdBCEFmuexjIvY92oDejdFw=
X-Google-Smtp-Source: AGHT+IGETLylbGwprz73Zkb8SQDnD4ImVbvWets0mlYTX8wJt4kjBTZn14Hr8rpwYH7jmye+eOK5pw==
X-Received: by 2002:a05:6a00:b53:b0:70d:2837:6089 with SMTP id d2e1a72fcca58-7106cfbb944mr19895801b3a.11.1722944902392;
        Tue, 06 Aug 2024 04:48:22 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec43944sm6831705b3a.75.2024.08.06.04.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:48:21 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2 2/3] perf: build: Fix build feature-dwarf_getlocations fail for old libdw
Date: Tue,  6 Aug 2024 19:48:00 +0800
Message-Id: <20240806114801.1652417-3-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806114801.1652417-1-yangjihong@bytedance.com>
References: <20240806114801.1652417-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For libdw versions below 0.177, need to link libdl.a in addition to
libbebl.a during static compilation, otherwise feature-dwarf_getlocations
compilation will fail.

Before:

  $ make LDFLAGS=-static
    BUILD:   Doing 'make -j20' parallel build
  <SNIP>
  Makefile.config:483: Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.157
  <SNIP>

  $ cat ../build/feature/test-dwarf_getlocations.make.output
  /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/9/../../../x86_64-linux-gnu/libebl.a(eblclosebackend.o): in function `ebl_closebackend':
  (.text+0x20): undefined reference to `dlclose'
  collect2: error: ld returned 1 exit status

After:

  $ make LDFLAGS=-static
  <SNIP>
    Auto-detecting system features:
  ...                                   dwarf: [ on  ]
  <SNIP>

    $ ./perf probe
   Usage: perf probe [<options>] 'PROBEDEF' ['PROBEDEF' ...]
      or: perf probe [<options>] --add 'PROBEDEF' [--add 'PROBEDEF' ...]
      or: perf probe [<options>] --del '[GROUP:]EVENT' ...
      or: perf probe --list [GROUP:]EVENT ...
  <SNIP>

Fixes: 536661da6ea1 ("perf: build: Only link libebl.a for old libdw")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/build/feature/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index b18513ec4da6..1fc651cae9e5 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -179,7 +179,7 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
   # Elfutils merged libebl.a into libdw.a starting from version 0.177,
   # Link libebl.a only if libdw is older than this version.
   ifeq ($(shell test $(LIBDW_VERSION_2)0 -lt 1770; echo $$?),0)
-    DWARFLIBS += -lebl
+    DWARFLIBS += -lebl -ldl
   endif
 endif
 
-- 
2.25.1


