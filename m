Return-Path: <linux-kernel+bounces-230452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0403A917CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2011F23890
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE7816F904;
	Wed, 26 Jun 2024 09:54:22 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA506EEDD;
	Wed, 26 Jun 2024 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395661; cv=none; b=rq088VmPRH51GpGwTdzo3iH0JzWXevbOh9i1V7UKmXWbMvk4cS60Qms0vu2qyUaPNoCl5LmpDe2X38g7GQbF/C1Q+VGUg3MsUjuf2fPRQl2b80hxId1gOoU/xZg3QoTbdYgfkgpPaV/1MCZFTMb+00dWKnjwW2n4nMjLpz+RSPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395661; c=relaxed/simple;
	bh=OnP7ck+3qjAxiEpNKP8kmfe9Stx4BYFEUcWQ8/qetCw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=n25IjkqsFGBe3k93JSfrbzMj9y8PIY7hS7OuMb6GGyG1PeqKChSmTDKI88z9V9jx1zADAbDn6UC2JLjr+cXcPFgozsT6svLIBQpYCGqHgQeeu2v912U5JkGfKWJiEImgtZl5Sg8Jyp2NMNnv0AhImjrKKBG+LzTIBIabuqc8aBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5667be5440e0-819a2;
	Wed, 26 Jun 2024 17:54:12 +0800 (CST)
X-RM-TRANSID:2ee5667be5440e0-819a2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee3667be54232f-a6d7c;
	Wed, 26 Jun 2024 17:54:12 +0800 (CST)
X-RM-TRANSID:2ee3667be54232f-a6d7c
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: ivan.orlov0322@gmail.com
Cc: broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shuah@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] selftests/alsa:Replace malloc with calloc
Date: Wed, 26 Jun 2024 02:54:09 -0700
Message-Id: <20240626095409.4908-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Using calloc to handling memory allocation, calloc
can initialize the allocated memory

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/alsa/test-pcmtest-driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/alsa/test-pcmtest-driver.c b/tools/testing/selftests/alsa/test-pcmtest-driver.c
index ca81afa4ee90..0a551b5f41f7 100644
--- a/tools/testing/selftests/alsa/test-pcmtest-driver.c
+++ b/tools/testing/selftests/alsa/test-pcmtest-driver.c
@@ -134,6 +134,7 @@ FIXTURE_SETUP(pcmtest) {
 		SKIP(return, "Can't read patterns. Probably, module isn't loaded");
 
 	card_name = malloc(127);
+	memset(card_name, 0, 127);
 	ASSERT_NE(card_name, NULL);
 	self->params.buffer_size = 16384;
 	self->params.period_size = 4096;
-- 
2.17.1




