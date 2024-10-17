Return-Path: <linux-kernel+bounces-369927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F8F9A248F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4091F2557A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643061DE885;
	Thu, 17 Oct 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+Af1DWj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F01DE4D5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174189; cv=none; b=jO+9P+qmw6ECtjgToEovZSnU16ezu29Dg/kjokdNUl6bV0fQ707ypcR+B+Aw/5AQic4TxK6RBq3cOi6eENt+slWOhCLw/zii3LT0e4XrcJdVUVCYcpdFqtsndoc+WezPzWcLJdwdcIIk68pJjhjlBPGMty2+FzfjuGZbNf8hZSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174189; c=relaxed/simple;
	bh=WJO3QTHbyMYZ2pdr/Pt8j2ljH8mSri42f5zhMpKjqaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fa/J4F/i+BKctNNxEfXIjhXFQyH+z4qI29Zr/0Ou0EF1zNMZZrsT9bRltaAfzodWhnN8fSkeCZ1WdsEGR1M5oi13PDzNyASzx0vB30vCBustDFTpqtQfSCkfeDsMyIolLTI+5kKZ7LPKDP058mfvGfldc81aX6VNYfYdaKxr3zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+Af1DWj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729174187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vV/E+BPFRrJLU+35/XO3Mhx9Fi377jVrQcGBMpnDg7k=;
	b=Z+Af1DWj/3ZB/uLubxXIRqhwd4uC5dhtFO9mflMbl/sYzwnvCSoGc1ItsY/TA0pgWPMSLI
	f2re+Ecv9ZaDLDaUBFxtlFHjyGXK00X5IYAd7EMXIyOmmdWOEC5KMWWnT7z9WyhQaNC/E9
	LVozMNnkVLVoXgNHwN1a8apHhXZfYwA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-BrBKA5z-N2y2DKtXGsbdAw-1; Thu,
 17 Oct 2024 10:09:44 -0400
X-MC-Unique: BrBKA5z-N2y2DKtXGsbdAw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25ED9195608C;
	Thu, 17 Oct 2024 14:09:43 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DD1A1955F42;
	Thu, 17 Oct 2024 14:09:41 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	jwyatt@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v5 1/6] tools/build: Add libcpupower dependency detection
Date: Thu, 17 Oct 2024 16:09:09 +0200
Message-ID: <20241017140914.3200454-2-tglozar@redhat.com>
In-Reply-To: <20241017140914.3200454-1-tglozar@redhat.com>
References: <20241017140914.3200454-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Tomas Glozar <tglozar@redhat.com>

Add the ability to detect the presence of libcpupower on a system to
the Makefiles in tools/build.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
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
2.47.0


