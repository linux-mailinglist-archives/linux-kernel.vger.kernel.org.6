Return-Path: <linux-kernel+bounces-430789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB559E359E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADAD282B14
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1FB196434;
	Wed,  4 Dec 2024 08:40:37 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D489F191489;
	Wed,  4 Dec 2024 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301637; cv=none; b=f5N8RoTBXhaLUQaY/ooc735pOA3AVBf7aGQ8EFIzp0JyAEmjCi+TRQ2qukJT1RE1lZ/BspQUKVo7lUzbssU0XylOfcxUXwEtA5EYF+iazSSu51C9NbXXcH9vFSsOpbRWF2BivCOBOjzU2AtWnTXiDOIF8Ff6X9nlUVcyYICkoi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301637; c=relaxed/simple;
	bh=D0+CwvJjK4KkI3Qr0Lhqfqdn9zkfNfWbDrrcicnW4v8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g3o3uhdW8lefNrq1CF39b18MkH0upmDHAAIXQHRBY8lvU8BjMFP+vnH+YhwEhcq8IS8bLtiHdQEBa1v8IGvGrf82Q7KbwppVqEwxe8rr7Q1brERzKYcCj3h1dy6r4jCQS0fNtA8YvGTvQgwQZc8LShAYpPkBJMcX/wDjHyGNynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56750157dec9-caee0;
	Wed, 04 Dec 2024 16:40:30 +0800 (CST)
X-RM-TRANSID:2ee56750157dec9-caee0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from 192.168.28.197 (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76750157ce96-60ac4;
	Wed, 04 Dec 2024 16:40:30 +0800 (CST)
X-RM-TRANSID:2ee76750157ce96-60ac4
From: liujing <liujing@cmss.chinamobile.com>
To: richard.henderson@linaro.org,
	ink@jurassic.park.msu.ru,
	mattst88@gmail.com,
	paulmck@kernel.org,
	arnd@arndb.de
Cc: linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] alpha: Fix condition 'i>40' is always false
Date: Wed,  4 Dec 2024 16:40:28 +0800
Message-Id: <20241204084028.6067-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i variable is used to count the number of stack frames printed,
but it is initialized to 0 only at the beginning of the loop, and
is not increased later in the loop. Therefore, the value of i is
always 0, resulting in the condition if (i > 40) never being true.

To ensure that i counts correctly, you need to increase the value
of i each time the stack frame is successfully printed.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index 6afae65e9a8b..65c44756f949 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -100,6 +100,7 @@ dik_show_trace(unsigned long *sp, const char *loglvl)
 		if (!is_kernel_text(tmp))
 			continue;
 		printk("%s[<%lx>] %pSR\n", loglvl, tmp, (void *)tmp);
+		i++;
 		if (i > 40) {
 			printk("%s ...", loglvl);
 			break;
-- 
2.27.0




