Return-Path: <linux-kernel+bounces-403773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBEB9C3AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26441C218CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FA115D5B8;
	Mon, 11 Nov 2024 09:17:15 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B105149C4A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316635; cv=none; b=tiWXUu2ST5Kpr5YNAU5eYRNR3+ddPkZR0z7xjm/y72h1IpHBkDyvYsg+STUp4HrfMRFi8bm0Jxfnp0G+K1WK5xoL1+gqpyeHIGdraP1HfTetPHmWjCxXT4g8acRsqwmB0v7OCe0IGVhi21AhSC9DMK9/NA0P8l0VSLFBz3svtQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316635; c=relaxed/simple;
	bh=SsAUIRV4dI67TI/ZhJOFyUAXdCCfU6LycSKaXyT+mKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WKVWE5oX1PDMs829j7dhBoLAFVCaE+SQEa5h6qF3cfzW8Wv2Parf9BATErT/mExtaA/lLXzVxnuxRkCBkWgyoxqCFRznhDC1a9Wz404c15vjBkE8HfGmhfxE4SIc8rhYoKxxEkNR9VZmi90yzd3W2LmA8WBKfkAFKNGlFBuQ/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66731cb8f228-d3af8;
	Mon, 11 Nov 2024 17:17:03 +0800 (CST)
X-RM-TRANSID:2ee66731cb8f228-d3af8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56731cb8e9fa-217c4;
	Mon, 11 Nov 2024 17:17:03 +0800 (CST)
X-RM-TRANSID:2ee56731cb8e9fa-217c4
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: jpoimboe@redhat.com,
	acme@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] tools/lib/subcmd: Move va_end before exit
Date: Mon, 11 Nov 2024 17:17:01 +0800
Message-Id: <20241111091701.275496-1-luoyifan@cmss.chinamobile.com>
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
after exit(128) (i.e., va_end(params)) is unreachable and thus not
executed. Placing va_end before exit ensures that the va_list is
properly cleaned up.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 tools/lib/subcmd/subcmd-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/subcmd/subcmd-util.h b/tools/lib/subcmd/subcmd-util.h
index dfac76e35..c742b0881 100644
--- a/tools/lib/subcmd/subcmd-util.h
+++ b/tools/lib/subcmd/subcmd-util.h
@@ -20,8 +20,8 @@ static __noreturn inline void die(const char *err, ...)
 
 	va_start(params, err);
 	report(" Fatal: ", err, params);
-	exit(128);
 	va_end(params);
+	exit(128);
 }
 
 #define zfree(ptr) ({ free(*ptr); *ptr = NULL; })
-- 
2.27.0




