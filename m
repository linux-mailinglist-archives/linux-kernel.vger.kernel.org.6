Return-Path: <linux-kernel+bounces-560835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E16A609EC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F33165B51
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8241DF98D;
	Fri, 14 Mar 2025 07:15:20 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2EC1117D2;
	Fri, 14 Mar 2025 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936520; cv=none; b=HpE9yAbj9RxQt8HKLdLkVppfM1Sihkilz/XTaSpgy7QS10EQj3W89c2Jr81+ibtO6fbh4wbvPmN96emdLbHfmMZLoAz0vXvWDbQFJwLOhvOax406H+OAs9HIwwCIjts9i5/2OowqZTGIGko4M0ZH039IQMCpF6F/S3NTX6X0ahw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936520; c=relaxed/simple;
	bh=nYhJZCbhlaC0rSuAhobyC5FkT87b9GIVB4HH4O/O72o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=fGPbuyf4rPOUySFVKrfutVLfLj941U1PefNXHJPcMINVl30eh+X2qjJFY2Hq3h2bU88n1nD8eTnfdhG7C7o/dLOrDuWv3/DDQ0g4e70wya9re59bSv6AK+CviqZ/H5Ao3Gus3TdpPAnT/MzhFTyaVNXPpOiXHEt3RZ4nxUiqBdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id A2D6960680974;
	Fri, 14 Mar 2025 15:15:08 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: zfigura@codeweavers.com,
	shuah@kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	wine-devel@winehq.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 1/4] selftests: ntsync: fix the wrong condition in wake_all
Date: Fri, 14 Mar 2025 15:14:51 +0800
Message-Id: <20250314071454.201697-2-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250314071454.201697-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When  'manual=false' and  'signaled=true', then expected value when using
NTSYNC_IOC_CREATE_EVENT should be greater than zero. Fix this typo error.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 tools/testing/selftests/drivers/ntsync/ntsync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 3aad311574c4..bfb6fad653d0 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -968,7 +968,7 @@ TEST(wake_all)
 	auto_event_args.manual = false;
 	auto_event_args.signaled = true;
 	objs[3] = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &auto_event_args);
-	EXPECT_EQ(0, objs[3]);
+	EXPECT_LE(0, objs[3]);
 
 	wait_args.timeout = get_abs_timeout(1000);
 	wait_args.objs = (uintptr_t)objs;
-- 
2.30.2


