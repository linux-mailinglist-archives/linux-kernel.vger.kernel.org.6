Return-Path: <linux-kernel+bounces-255514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28D09341A8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D427D1C2303E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB47B18307E;
	Wed, 17 Jul 2024 17:47:54 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B8C181D07;
	Wed, 17 Jul 2024 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238474; cv=none; b=Q0/4pmxRhtmSuyrtJ2xg26SLBCJxLCFeqrM92SYPnpd3VY+0A5fpVaEtxotf3lUb/6YLvtQ1I4Kjt730P7iOWpV8unOPvcx1vRf3hpfHsyhj2KRJ4TJX6bM+hhDfiK5S01E2GF2dmQjLdPC6LPFm1zS2pbg4k/qA+j4O9xjcvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238474; c=relaxed/simple;
	bh=jRDjt3t0PUjgUbdNF16mDtrjvQ93i6nAoQY7s082Iy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=miV68yxE5YJWwyYNkI8GKzt8qPEQ+sfjda/3d2x17jHA++O6njjUwnaML010qDnGtCTuVXgvGThCdZBXXCiuoDKq/90yeIWu6+Ro0nbavJ2dLzu6Hn+wrnZzKLJFF9bOvNQpz7om1XLzp9IMfbXwxbjG/FIinL8PljmohjXIlac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Guilherme Amadio <amadio@gentoo.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ian Rogers <irogers@google.com>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org,
	linux-trace-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] tools/latency: Use pkg-config in lib_setup of Makefile.config
Date: Wed, 17 Jul 2024 19:47:39 +0200
Message-Id: <20240717174739.186988-6-amadio@gentoo.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240717174739.186988-1-amadio@gentoo.org>
References: <20240717123147.17169873@rorschach.local.home>
 <20240717174739.186988-1-amadio@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows to build against libtraceevent and libtracefs installed
in non-standard locations.

Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
---
 tools/tracing/latency/Makefile.config | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/latency/Makefile.config b/tools/tracing/latency/Makefile.config
index b25e531a1f95..0fe6b50f029b 100644
--- a/tools/tracing/latency/Makefile.config
+++ b/tools/tracing/latency/Makefile.config
@@ -3,8 +3,9 @@
 STOP_ERROR :=
 
 define lib_setup
-  $(eval EXTLIBS += -l$(1))
   $(eval LIB_INCLUDES += $(shell sh -c "$(PKG_CONFIG) --cflags lib$(1)"))
+  $(eval LDFLAGS += $(shell sh -c "$(PKG_CONFIG) --libs-only-L lib$(1)"))
+  $(eval EXTLIBS += $(shell sh -c "$(PKG_CONFIG) --libs-only-l lib$(1)"))
 endef
 
 $(call feature_check,libtraceevent)
-- 
2.39.3


