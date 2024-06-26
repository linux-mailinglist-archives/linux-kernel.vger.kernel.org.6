Return-Path: <linux-kernel+bounces-229922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE9A917613
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 279E6B217DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B6138DE8;
	Wed, 26 Jun 2024 02:12:46 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7693438396
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719367966; cv=none; b=pU3YcWYS0VId7W27WAYHEmg/1ho0qYqVuaJ8IM2rciQoGFpm56os73A+Bgy4hvQmGRPFcrE1kOeqaSeQsyo4xOc1argkJGE6BvuyaAW7uezuI3CLhBgsdWd4Z/Cfgbyj7Y9CE2WEg0GniuhBj7kKKUXwVrbf+kuHOtg2nbtcCvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719367966; c=relaxed/simple;
	bh=TBMKuKTR4lE5O+72M8IPvIKrMMIXhUi+9db0H3QD0cw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hBbPXB0qHbUzu76ujZUrmGttYerzMwv59sguXJnY9/ARYvntJiHdNq5Cap4AA+fYL232n2fMUVTpQV5I6/xsTym3bRLj/nKw0UiTTtOpgxjQZDbfltYCWEonfFLSfR5kV0eJIBbsX1y9R9r85GapNGN+Vdge7eElQ+6c3dY7BrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp89t1719367907t8caynoa
X-QQ-Originating-IP: o5EFFgSftXUJSvErN3mz/fbPfezZaA++mEl7o5VbBmg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Jun 2024 10:11:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8070621123215097810
From: tuhaowen <tuhaowen@uniontech.com>
To: sudipm.mukherjee@gmail.com,
	alexander.deucher@amd.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	huangbibo@uniontech.com,
	wangyuli@uniontech.com,
	tuhaowen <tuhaowen@uniontech.com>
Subject: [PATCH] dev/parport: fix the array out-of-bounds risk
Date: Wed, 26 Jun 2024 10:11:36 +0800
Message-Id: <20240626021136.12282-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

The array buffer size is 20 bytes.
When executing code in a 64-bit CPU environment, up to 42 bytes of
data will be written into this array
(the size of "%lu\t%lu\n" is 20 + 1 + 20 + 1).

In fact, this line of code for 32-bit CPUs also has the risk of
crossing the boundary, but it can exceed 2 bytes at most. With good
luck, it is local variables that are damaged, and there are no serious
consequences.

Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
---
 drivers/parport/procfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index bd388560ed59..9f501d5fa1ec 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -117,7 +117,7 @@ static int do_hardware_base_addr(struct ctl_table *table, int write,
 				 void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
-	char buffer[20];
+	char buffer[64];
 	int len = 0;
 
 	if (*ppos) {
-- 
2.20.1


