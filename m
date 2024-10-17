Return-Path: <linux-kernel+bounces-370616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D409A2FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A23328194D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E221D319C;
	Thu, 17 Oct 2024 21:23:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFCF33997
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729200209; cv=none; b=nF2Bo/7UomMrb6Own2b3lWgdC1+tw6alADBccNuoGq1bI1fd89m6lfwl7HIaV614fqYma5BooV5E9pY6c3AQk3OWUKoqDJ/bM8CZr5SYhBkFybdV+6QgvbEUJLOJ4U+pUjuF6p1xFtwyBBukY1Agx68WLdE9qraxDTukBT4Gd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729200209; c=relaxed/simple;
	bh=5sUr069gIl2sxBaw/iPtSmVSTq07pqlX253AH/L+U2k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sZsXCcECHylxT7qwd0NkWuHLqU5ZArIIbcVfVNJ+RkakDSQkYMmeTqyNvmsOwn4CSs3d0UibnjQOVmBhtYOWhrGJZZU1rxMXqxZntHbgFh7Vu2CdVvjK5yOhtQr7w2nLOiZwuyze7OtC7uGTo14OjHdKY1SarDx+3G17Oe32FaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B397C4CECE;
	Thu, 17 Oct 2024 21:23:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t1XyM-00000003wD8-0ZGi;
	Thu, 17 Oct 2024 17:23:54 -0400
Message-ID: <20241017212353.995046941@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 17 Oct 2024 17:23:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 1/6] tools/build: Add libcpupower dependency detection
References: <20241017212328.560060762@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Add the ability to detect the presence of libcpupower on a system to
the Makefiles in tools/build.

Link: https://lore.kernel.org/20241017140914.3200454-2-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/build/Makefile.feature           | 1 +
 tools/build/feature/Makefile           | 4 ++++
 tools/build/feature/test-libcpupower.c | 8 ++++++++
 3 files changed, 13 insertions(+)
 create mode 100644 tools/build/feature/test-libcpupower.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index ffd117135094..2ebfb826dcea 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -53,6 +53,7 @@ FEATURE_TESTS_BASIC :=                  \
         libslang-include-subdir         \
         libtraceevent                   \
         libtracefs                      \
+        libcpupower                     \
         libcrypto                       \
         libunwind                       \
         pthread-attr-setaffinity-np     \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 5938cf799dc6..6ef3e1ca583e 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -38,6 +38,7 @@ FILES=                                          \
          test-libslang.bin                      \
          test-libslang-include-subdir.bin       \
          test-libtraceevent.bin                 \
+         test-libcpupower.bin                   \
          test-libtracefs.bin                    \
          test-libcrypto.bin                     \
          test-libunwind.bin                     \
@@ -245,6 +246,9 @@ $(OUTPUT)test-libslang-include-subdir.bin:
 $(OUTPUT)test-libtraceevent.bin:
 	$(BUILD) -ltraceevent
 
+$(OUTPUT)test-libcpupower.bin:
+	$(BUILD) -lcpupower
+
 $(OUTPUT)test-libtracefs.bin:
 	 $(BUILD) $(shell $(PKG_CONFIG) --cflags libtracefs 2>/dev/null) -ltracefs
 
diff --git a/tools/build/feature/test-libcpupower.c b/tools/build/feature/test-libcpupower.c
new file mode 100644
index 000000000000..a346aa332a71
--- /dev/null
+++ b/tools/build/feature/test-libcpupower.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <cpuidle.h>
+
+int main(void)
+{
+	int rv = cpuidle_state_count(0);
+	return rv;
+}
-- 
2.45.2



