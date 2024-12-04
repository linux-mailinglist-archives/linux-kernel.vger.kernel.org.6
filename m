Return-Path: <linux-kernel+bounces-431093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20269E3962
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93B93B28BC6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFB31B21AB;
	Wed,  4 Dec 2024 11:32:08 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4481AF0BA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311928; cv=none; b=M0cviAJKA4wPpyY/oBcpfWWtnDAliWT/wklFOuSNrE+EOsORJ9d+Ab9i4/el9EPsSypu9ZjhHZVQQ4rG49ujkicf/2z5OJ8Tl5rGuvQn930IEgEdROf/TQn4I+KD3oM8t9dnKUcs+sjnoVNlgxTzNMFogYreDmJAzcl0o1+MvkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311928; c=relaxed/simple;
	bh=2XIjDjHj7EvU1nv2ScaOkrNVstCoqDd/Dj/+/T3EqEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=be/LVYHKbtZ7Gqr0pYD2HnhIKUmH1HmuYhvByvdQSG6MQ5s7UVWg+mnxnpDmmdEwCz09yS9MqVKut3pzdMwuKLq5s0ZQ0cYW5HZLVUTrQY9jwCwyFbHRPlG5qG0j+DqFdq2xGGQUoHxPshMdStWmUuUFiSltKz05YqOolFo/R2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee567503dada9c-ccab3;
	Wed, 04 Dec 2024 19:32:02 +0800 (CST)
X-RM-TRANSID:2ee567503dada9c-ccab3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from 192.168.28.197 (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee567503dae6ae-6a43e;
	Wed, 04 Dec 2024 19:32:01 +0800 (CST)
X-RM-TRANSID:2ee567503dae6ae-6a43e
From: liujing <liujing@cmss.chinamobile.com>
To: luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com
Cc: linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] x86/vdso: Move va_end() before exit
Date: Wed,  4 Dec 2024 19:31:58 +0800
Message-Id: <20241204113158.7170-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes a minor adjustment by moving the va_end call before
exit. Since the exit() function terminates the program, any code
after exit(1) is unreachable and thus notexecuted. Placing va_end
before exit ensures that the va_list is properly cleaned up.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 90d15f2a7205..4446d74340c8 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -114,8 +114,8 @@ static void fail(const char *format, ...)
 	vfprintf(stderr, format, ap);
 	if (outfilename)
 		unlink(outfilename);
-	exit(1);
 	va_end(ap);
+	exit(1);
 }
 
 /*
-- 
2.27.0




