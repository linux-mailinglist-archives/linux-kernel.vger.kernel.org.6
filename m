Return-Path: <linux-kernel+bounces-293503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 819D595809C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37981281E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4528C18A926;
	Tue, 20 Aug 2024 08:10:54 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BC918A6BE
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141453; cv=none; b=R9dcyROMLyALpbXRiyB/x7ZZMf2efI3U9sJZLGpXzQENAJKrLyx+6nOQWkC9A0IGW/c+9hLrBSIR5L/jh3QCygzGgIut1Py2AFurjnIJIZDs0FKipFZyufxWZuRXwb5Ky5VtO00p9TqFdIhS26y8/FVBliI8etFyxiBu0YkpIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141453; c=relaxed/simple;
	bh=fHOqn1HdXmcUcViwzDri7kkPsiZLOnprqZGcYoSR1nI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Xs+L6tx57PUknzk8zW/gZCZjuskygA4096MqCbi0yuu9TuzCBwGMBDKoiIQgGUYWpgVrxG8e52Gj0TW/obx5GkC5chW5qbDPNemwyhGJsTEWPAGoUkgIRDdQaTjPB3Gz8o/tcGTaR+IBIsFCnJX8GAJM45SFdnTIkW4y4bXYE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee466c44f87c3c-3b52f;
	Tue, 20 Aug 2024 16:10:47 +0800 (CST)
X-RM-TRANSID:2ee466c44f87c3c-3b52f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee666c44f877b8-ffe9a;
	Tue, 20 Aug 2024 16:10:47 +0800 (CST)
X-RM-TRANSID:2ee666c44f877b8-ffe9a
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: martin.lau@linux.dev
Cc: eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] samples/bpf:Fix the wrong format specifier
Date: Tue, 20 Aug 2024 01:10:46 -0700
Message-Id: <20240820081046.5267-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The format specifier of "int" in printf() should be "%d", not
"%u"

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 samples/bpf/map_perf_test_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/map_perf_test_user.c b/samples/bpf/map_perf_test_user.c
index 07ff471ed6ae..dc27057c7dc1 100644
--- a/samples/bpf/map_perf_test_user.c
+++ b/samples/bpf/map_perf_test_user.c
@@ -159,7 +159,7 @@ static void do_test_lru(enum test_type test, int cpu)
 					  &inner_lru_map_fds[cpu],
 					  BPF_ANY);
 		if (ret) {
-			printf("cannot update ARRAY_OF_LRU_HASHS with key:%u. %s(%d)\n",
+			printf("cannot update ARRAY_OF_LRU_HASHS with key:%d. %s(%d)\n",
 			       cpu, strerror(errno), errno);
 			exit(1);
 		}
-- 
2.17.1




