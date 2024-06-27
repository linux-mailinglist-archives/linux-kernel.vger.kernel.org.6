Return-Path: <linux-kernel+bounces-232536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC71891AA84
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46336B26278
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEC3198A2E;
	Thu, 27 Jun 2024 15:07:13 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8186E197A90;
	Thu, 27 Jun 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500832; cv=none; b=LF+Rdh1NpEtKVD2uT6AY5lLQ2tFREoih4X7BRRAMf6a9mEA9AoVYcLAOFBJ6hCH+lW9jekrflQtCzblg81blnfx38h7m2eM19pqD8UnLmR7Y2AMrSAemZSyNhToywoKTW5C8p8waDC6JH/wjkiklptBptdAotp4mjiTZ/d3vVmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500832; c=relaxed/simple;
	bh=hs02989bp1p/bCUJc39bOXew5Ovzy8I/R6oro7OtCVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ng8Tc0V9eRsK4nRnmIZya3ChBkztLeqyV2BzRHOIZAaQx5DhZyUh7Yguc0Anw6oIFriIs+l2ZMCAcJVekXETHtGThCTcIamKSdJ6mP35cdLq4pI8AE2BV18QuhbQBm/rDLRf06tYszuBZGhwDEhv1JgW9/SCElFwYGipJOkIP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Guilherme Amadio <amadio@gentoo.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Guilherme Amadio <amadio@gentoo.org>
Subject: [PATCH 2/2] perf build: warn if libtracefs is not found
Date: Thu, 27 Jun 2024 17:06:06 +0200
Message-ID: <20240627150606.2224888-2-amadio@gentoo.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627150606.2224888-1-amadio@gentoo.org>
References: <20240627150606.2224888-1-amadio@gentoo.org>
Reply-To: <Znxp3bpc-5tvaa3m@x1.smtp.subspace.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
---
 tools/perf/Makefile.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 987b48f242d3..e99afc7eb4b5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1204,6 +1204,8 @@ ifneq ($(NO_LIBTRACEEVENT),1)
     LIBTRACEFS_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEFS_VERSION)))
     LIBTRACEFS_VERSION_CPP := $(shell expr $(LIBTRACEFS_VERSION_1) \* 255 \* 255 + $(LIBTRACEFS_VERSION_2) \* 255 + $(LIBTRACEFS_VERSION_3))
     CFLAGS += -DLIBTRACEFS_VERSION=$(LIBTRACEFS_VERSION_CPP)
+  else
+    $(warning libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
   endif
 endif
 
-- 
2.45.2


