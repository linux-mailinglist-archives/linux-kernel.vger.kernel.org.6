Return-Path: <linux-kernel+bounces-307441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BC6964D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311291C21C32
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED711B81DE;
	Thu, 29 Aug 2024 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EoOZz/wi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B620C198E75
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955941; cv=none; b=Ya3/BalOnIEgH5SEm0+QlrAmGdXm7VssJfo7s/GycZ3n/ktNp0G29OIv6FgJLDlPJ0w90awseXoRo7w+nz8gys6vzobY5oDS7eUI9NCLjhkzZG1SfYKsongtlM50NSbBvfCpqRY7Edj937FALhW3BCddwIzMA51IFmWNxqlAaZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955941; c=relaxed/simple;
	bh=Gjg8UW8CEgn5X8SLBulfcOt+fLIdeyhXPrSg9RypIo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AiNFJYjXoK0PrlNteBdIDb46ERuKCy+XkXHCB1Od2eA2renUMGocij7e9maLI55JZAfY5ontUgUdoGsHpudHWQ92MzChNHRnExtkkbzT6D9UVyqzzpcumDIp7W02DkJEKNzx9zmvLYcri6RV1d5TVlQtvTYBDUTQqBlGxtFDvAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=EoOZz/wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB11DC4CEC1;
	Thu, 29 Aug 2024 18:25:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EoOZz/wi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724955939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9FEyOiscUzfLeD82tPiqsYpTB1BBDH/yHWoEvCkisrU=;
	b=EoOZz/wiGg1BmXNpKT8xNvmGxdgfsPk+rcHLi85QdZD/BmVuW2Ks6aSRddfRGgJZE1a2Xt
	mUfncEFeuW7oQ+nE6EfvU+I9u572sS9A8uBH7oowfEYOPhQptjEi3fhfnXup+mNWN2vRjs
	qAdPrdYX25t6OiSi6Y09DeVltH6Ef9k=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id daac063d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 18:25:37 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Subject: [PATCH] selftests/vDSO: skip getrandom test if architecture is unsupported
Date: Thu, 29 Aug 2024 20:25:31 +0200
Message-ID: <20240829182531.250502-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the getrandom test compiles for an arch, don't exit fatally if the
actual cpu it's running on is unsupported.

Suggested-by: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 20bbef992c48..5db8ac8999cd 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -104,6 +104,7 @@ static void vgetrandom_init(void)
 	const char *version = versions[VDSO_VERSION];
 	const char *name = names[VDSO_NAMES][6];
 	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
+	size_t ret;
 
 	if (!sysinfo_ehdr) {
 		printf("AT_SYSINFO_EHDR is not present!\n");
@@ -115,7 +116,11 @@ static void vgetrandom_init(void)
 		printf("%s is missing!\n", name);
 		exit(KSFT_FAIL);
 	}
-	if (vgrnd.fn(NULL, 0, 0, &vgrnd.params, ~0UL) != 0) {
+	ret = vgrnd.fn(NULL, 0, 0, &vgrnd.params, ~0UL);
+	if (ret == -ENOSYS) {
+		printf("unsupported architecture\n");
+		exit(KSFT_SKIP);
+	} else if (ret) {
 		printf("failed to fetch vgetrandom params!\n");
 		exit(KSFT_FAIL);
 	}
-- 
2.46.0


