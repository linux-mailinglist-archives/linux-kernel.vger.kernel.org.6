Return-Path: <linux-kernel+bounces-431397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351E69E3CDC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0490164A45
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359A1209F53;
	Wed,  4 Dec 2024 14:33:37 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E74207A2C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322816; cv=none; b=TxuD+dyMbm/X4gIsn6Sz1DKVCls27vVnzC4eDmQ75iL5UaDNTpkOXPvIM9d2kaoh+R1RrihjG0w7EH/L4k4f1SZtpS+192bAUtcmaDs+QHh0AAxlJxbepwz6c6GMcjIhaE6DhmzONnN/bKeS2fB915I+zm5bc9P7Bwe6WOaqlWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322816; c=relaxed/simple;
	bh=fqGPFuZhusVQFp7fCkRFSdEqCVumpGcdeMvXuh5jyKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kI1r+b05aJF8fGLGTYttZ96UgM+4zuAOLBZT/1vRDk76gUXXOuF4g/1/u315vnq0bbrWFkxW1Zl9P7Gy4vpfuKMZah5106HUzP+YYIr1JV0HMH0uo1O/wTNLr/ighYZUej6J/ciEeBtxCaJxW7V2iLc8ZdpE5dSlRYLJSYY5trM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86750683518f-091db;
	Wed, 04 Dec 2024 22:33:25 +0800 (CST)
X-RM-TRANSID:2ee86750683518f-091db
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from 192.168.28.197 (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9675068338ba-6f671;
	Wed, 04 Dec 2024 22:33:24 +0800 (CST)
X-RM-TRANSID:2ee9675068338ba-6f671
From: liujing <liujing@cmss.chinamobile.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	mat.jonczyk@o2.pl,
	rdunlap@infradead.org
Cc: bhelgaas@google.com,
	mario.limonciello@amd.com,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] arch/x86: Fix the wrong format specifier
Date: Wed,  4 Dec 2024 22:33:22 +0800
Message-Id: <20241204143322.7772-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make a minor change to eliminate a static checker warning. The type
of 'i' is unsigned int, so the correct format specifier should be
%u instead of %d.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index c96ae8fee95e..d2cc52530f7f 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -728,7 +728,7 @@ static void __init hpet_select_clockevents(void)
 		if (!(hc->boot_cfg & HPET_TN_FSB_CAP))
 			continue;
 
-		sprintf(hc->name, "hpet%d", i);
+		sprintf(hc->name, "hpet%u", i);
 
 		irq = hpet_assign_irq(hpet_domain, hc, hc->num);
 		if (irq <= 0)
-- 
2.27.0




