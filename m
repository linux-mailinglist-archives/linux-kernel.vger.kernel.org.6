Return-Path: <linux-kernel+bounces-230459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7161917D19
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BE21F22B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99133175550;
	Wed, 26 Jun 2024 09:58:26 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC2EEEDD;
	Wed, 26 Jun 2024 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395906; cv=none; b=lKayRNJjfUnm/kKtDkCAZi7SkZ1TquJ3FHyAcrUdaUs39EVO0/fhCYpJNWGI4+jm+vgcL+2A6ZMW7hYpxpfE+/5McUkdwe0tQklI0jgkmEqm1Na5MDPwhCbdb3kZqNoaattyQbinxi/69zqCexpUpSiPsn+5kGXeUWz4bFkubyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395906; c=relaxed/simple;
	bh=qotvfWwWQxD9CGbaAkECOEU8prfSwAcDV/MSKkja5xY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=o75OT9dIg5zcpCpiRFE43ZTezdEZn4y+IAZU9zrSeOSRyUvYDLWN5G4zzDbDkUdNzH/+Dn83VkyD5Y/f5tOPRizBfZqUlBRqlGs/vXSP7Fc2vhUziID3ObFyGewaNqUcCxwknpt/I4VgAp6eDB0puLgt6ddpP30b/6zeBin4DxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2667be63c3c4-0e3ca;
	Wed, 26 Jun 2024 17:58:20 +0800 (CST)
X-RM-TRANSID:2ee2667be63c3c4-0e3ca
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea667be63b9e7-a654c;
	Wed, 26 Jun 2024 17:58:20 +0800 (CST)
X-RM-TRANSID:2eea667be63b9e7-a654c
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
Subject: [PATCH] selftests/alsa:Add memset to initialize memory
Date: Wed, 26 Jun 2024 02:58:17 -0700
Message-Id: <20240626095817.5037-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add memset to initialize the requested memory

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




