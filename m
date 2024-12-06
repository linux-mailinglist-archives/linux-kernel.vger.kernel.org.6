Return-Path: <linux-kernel+bounces-434282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 144749E6457
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF96169554
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2077C17BB32;
	Fri,  6 Dec 2024 02:42:05 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C06186E2F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 02:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733452924; cv=none; b=A6Zqv2LRiz84ukiETYXpcnnQMFwUn4xTaYXVEikZ0fyyzz351bWabhln+vL6+akcZP/ADWhMT6etxkcU5YmXowqBXSZ8f9WUgc/aXcdhYXYhMHBkh+dtOLfbF7+ZL9jCXKsY8B2bWmFQW/mSVSDKd2cCLra1GYP47PrGnIP8BRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733452924; c=relaxed/simple;
	bh=fERWwJUm9HEPYwcPNCE0Kf51PyLvBJbIkRTPyusu0H4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uwECcy9DcyEBue/Y/mWHqrRZEu64Dv88AMvS1jYOwL60UKAgdknBEbGeDVhMOvlVCde3nRyPKaRgzww6io14u7yltNtmeynhMJz6LYWuueOVJHYWqZRreE1RyzTnut2D+05kkTlcl62UkOKNEkuK1irvHjWhAwgfBBLA2NYHQ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee767526476274-db294;
	Fri, 06 Dec 2024 10:41:58 +0800 (CST)
X-RM-TRANSID:2ee767526476274-db294
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5675264756f6-ce8db;
	Fri, 06 Dec 2024 10:41:58 +0800 (CST)
X-RM-TRANSID:2ee5675264756f6-ce8db
From: liujing <liujing@cmss.chinamobile.com>
To: gregkh@linuxfoundation.org,
	thorsten.blum@toblux.com
Cc: linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] sample/acrn: Remove redundant assignment to itself
Date: Fri,  6 Dec 2024 10:41:27 +0800
Message-Id: <20241206024127.2732-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete the self-redundancy assignment for sig, argc, and argv.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/samples/acrn/vm-sample.c b/samples/acrn/vm-sample.c
index c61e0f91456e..f6d62d1659ef 100644
--- a/samples/acrn/vm-sample.c
+++ b/samples/acrn/vm-sample.c
@@ -34,7 +34,6 @@ int is_running = 1;
 
 void vm_exit(int sig)
 {
-	sig = sig;
 
 	is_running = 0;
 	ioctl(hsm_fd, ACRN_IOCTL_PAUSE_VM, vmid);
@@ -50,8 +49,6 @@ int main(int argc, char **argv)
 	struct acrn_io_request *io_req;
 	struct acrn_ioreq_notify __attribute__((aligned(8))) notify;
 
-	argc = argc;
-	argv = argv;
 
 	ret = posix_memalign(&guest_memory, 4096, GUEST_MEMORY_SIZE);
 	if (ret < 0) {
-- 
2.27.0




