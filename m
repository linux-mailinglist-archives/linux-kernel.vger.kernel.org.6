Return-Path: <linux-kernel+bounces-177286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAED8C3C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207DB281024
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B8D146D74;
	Mon, 13 May 2024 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T8/TG7AB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4978146D79
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586574; cv=none; b=Lce8DELpHS+qUfjcUmaSorI+GmYN3b97T0wvbCDeXkxGXqit3d/hySLBWD5BXVNEPp7UjsZKyb979cbtN6KP7exVvtGqRd6rFiFcdZLtcAGsRlVITKiNT8wSzsSzqGg040oMmAgXmcubWAeK3BI0w368IhQVcS5QSXNuKM6OWVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586574; c=relaxed/simple;
	bh=Z92BapNXqrD8mH8Lvn9VhbzXh/a0lrQadfg2Cq2n/08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Utm9nIfBu627jarVC0edAneKi1G83n/cA4eHKm1kw7IT6BeIWieVj+Choo1XPAwdT40WRH677Q3e86oT3SavWMEuEKKGX+2LOVTKqpn4kzPTq0tu7nSc29HSiGHtAcChIT4cjgjeLF47Lx6ZaOZcBnDuuc2IPTF6gGOfgsNuw9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T8/TG7AB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ecd9a81966so35088745ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715586572; x=1716191372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEo/a1+oRG2cXEy6c+2coJnHGUNZUbI5ZqJs4KidFuk=;
        b=T8/TG7AB4Gf7JWTnxoOD+VVRGuh0aPunURRASZ5pZCPx1BSrTSmQzDJnfvXe4PsJIH
         qtwjIdGv2hotBHBdIqCPY62bhHW1bwZMTbvoPuyJkak6Cu9dQuYt7MC3BcNHxkOgbw37
         JDUNfzY2e3QiCcSRSmathECIDfe4F36aRHXxmkp2fjQdMi5zAstmBFXWGYGdqST8ierI
         7zwdmcNI3oXI7Y4juE4kNV2C0bITkjeEnFm5SpGjHBUJo9PBvuxRMXpKWThT7kKDtb/n
         ZnSayqhgfagUnaM0D7rEq3mUwwJ07F/dKegxWpEm34JAtX5piEnt6xKCLdJGQnuTC7uS
         aUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715586572; x=1716191372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEo/a1+oRG2cXEy6c+2coJnHGUNZUbI5ZqJs4KidFuk=;
        b=Q8eYiYcGpRngTdnKukBbujpUYN91NTcFTm4VcyiPCTAM4s2LfZHsbZfmVoc8eaD4jK
         CUSqqZ6RNzn2ugqHUlrGCCF0bz0qJ+/jGzVxbAG8fylMUkDm+r+rUhujiFEdKIdHudEC
         A/dtviI1MoJh2FGvo4rana+E7K7A1ODfpkWo/utJbyMKAoHs1eopm78lmbulKXFNJ16h
         5GkPmvoUtVZ/wUIPyPlyEGdFOOD+eoFtJyxuwtjOnwl4Tnc4kZyHFE9bEIDdgJl/DZXa
         OHaFM/6p7JrHbQP3GDuxXjkD+/n98mvgufiOpd+eG9v7o5KVDyafGHyE19SKg3fM4nrz
         aXsw==
X-Forwarded-Encrypted: i=1; AJvYcCWk4LT3RqGw2OzI7dTVTzlhjqlQT4bZarvbMmXBtr/lILkmRTFbduPyh1BsSIW/54ikPXE/2BD/C7OjrkbH5yj9E/GmWq4QbLrqGKV0
X-Gm-Message-State: AOJu0YyKytzIbmPVE0khe3zSJesWF832EFpDmOTOjwyH6WYqFNMLvkID
	8qX1WnXLrNi+pr+3tNZ1BGwTcGxwV7sEARqiNUkwGHKbqpWVwebTADmNPHPyDi4=
X-Google-Smtp-Source: AGHT+IHoZtwtgD7hFchCDIQOTf44g03q4zF7Jb1rcy/3zG/BIayitweAZoAdp++6XuRxJ1Ft606/JQ==
X-Received: by 2002:a17:902:f68f:b0:1e0:9964:76f4 with SMTP id d9443c01a7336-1ef42e6e646mr129350585ad.14.1715586572235;
        Mon, 13 May 2024 00:49:32 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badadacsm73396695ad.111.2024.05.13.00.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 00:49:31 -0700 (PDT)
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
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2 2/2] perf build: Add libtraceevent lib64 to -L directory & rpath on 64-bit
Date: Mon, 13 May 2024 15:49:10 +0800
Message-Id: <20240513074910.1660373-3-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513074910.1660373-1-yangjihong@bytedance.com>
References: <20240513074910.1660373-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For 64-bit system, libtraceevent will install these libraries into
lib64 directory, so add it to the -L directory and rpath as well.

build libtraceevent:
  $ make EXTRA_CFLAGS="-O0 -g -fsanitize=address" DESTDIR=~/libtrace install

Before:
  $ rm -rf /tmp/perf; mkdir /tmp/perf; make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=address -Wno-error=unused-function" LIBTRACEEVENT_DIR=~/libtrace/usr/local 1>/dev/null
  Makefile.config:1146: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
  Makefile.config:1196: *** ERROR: libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel and/or set LIBTRACEEVENT_DIR or build with NO_LIBTRACEEVENT=1.  Stop.
  make[1]: *** [Makefile.perf:264: sub-make] Error 2
  make: *** [Makefile:70: all] Error 2

After:
  $ rm -rf /tmp/perf; mkdir /tmp/perf; make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=address -Wno-error=unused-function" LIBTRACEEVENT_DIR=~/libtrace/usr/local 1>/dev/null
  Makefile.config:1154: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
    PERF_VERSION = 6.9.0-rc5
  $ echo $?
  0
  $ ldd /tmp/perf/perf
  <SINP>
  	libtraceevent.so.1 => /home/yangjihong/libtrace/usr/local/lib64/libtraceevent.so.1 (0x00007f08983d5000)
  <SINP>

Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/Makefile.config | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a9a923358604..d632c85e6c4d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -188,9 +188,17 @@ TRACEEVENTLIBS := -ltraceevent
 ifdef LIBTRACEEVENT_DIR
   LIBTRACEEVENT_CFLAGS  := -I$(LIBTRACEEVENT_DIR)/include
   LIBTRACEEVENT_LDFLAGS := -L$(LIBTRACEEVENT_DIR)/lib
+  # libtraceevent install libraries into lib64 on 64-bit, so add it to -L directory as well
+  ifeq (${IS_64_BIT}, 1)
+    LIBTRACEEVENT_LDFLAGS += -L$(LIBTRACEEVENT_DIR)/lib64
+  endif
   # Specify rpath for asan/msan build. Generally, cross-compilation will not enable sanitizers.
   ifeq ($(findstring -fsanitize=,${EXTRA_CFLAGS}),-fsanitize=)
     LIBTRACEEVENT_LDFLAGS += -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib
+    # libtraceevent install libraries into lib64 on 64-bit, so add it to rpath as well
+    ifeq (${IS_64_BIT}, 1)
+      LIBTRACEEVENT_LDFLAGS += -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib64
+    endif
   endif
 endif
 FEATURE_CHECK_CFLAGS-libtraceevent := $(LIBTRACEEVENT_CFLAGS)
-- 
2.25.1


