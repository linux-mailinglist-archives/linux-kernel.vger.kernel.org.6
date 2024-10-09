Return-Path: <linux-kernel+bounces-356502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C796B996224
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056BB1C20F40
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2044B188018;
	Wed,  9 Oct 2024 08:13:56 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B121537D7
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461635; cv=none; b=hw47nmBlYXPU+iLJ93HRKHSQMFoRX5tWs/I2VC+JBJnyCBSZ/o3XYAnEuxJOMV4OfbC2nfjUoRSvKPfl+eJDdJ6QfTRSsHjpm9Tjbd/ADqFKeEhGYa46RHMz1Bqo+sdAmN8i3QxhOvMeCuBshRh4/0H1ReR2SMZsX7x/A6y3+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461635; c=relaxed/simple;
	bh=2UTGYiLReMk8rd9JJanFNDVohGF0pPe6JbPZPEXO0dE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mPIVn4YyeKty5M56etBz/sFXbsCPne2DFJAShxfdICgyVSDN/uV8XVXIqb6EzTUEj9D0UbTx+vF0n9tpFtzf88N1ABRvDUoQFzrbTBwKH/CpcD51IYNergpPeQ5pTubLMQo+VLpgMJFcYCu7NSIQ6n8l3PZn5h9BQmTW8Fa0tHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee167063b3a401-bbd0e;
	Wed, 09 Oct 2024 16:13:48 +0800 (CST)
X-RM-TRANSID:2ee167063b3a401-bbd0e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea67063b3b7b8-e1926;
	Wed, 09 Oct 2024 16:13:48 +0800 (CST)
X-RM-TRANSID:2eea67063b3b7b8-e1926
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: alcioa@amazon.com
Cc: linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] nitro_enclaves: Fix the wrong format specifier
Date: Wed,  9 Oct 2024 01:13:46 -0700
Message-Id: <20241009081346.7774-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The format specifier of "unsigned int" in printf() should be "%u", not
"%d".

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 samples/nitro_enclaves/ne_ioctl_sample.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/samples/nitro_enclaves/ne_ioctl_sample.c b/samples/nitro_enclaves/ne_ioctl_sample.c
index 765b131c7319..5ccb45b225e2 100644
--- a/samples/nitro_enclaves/ne_ioctl_sample.c
+++ b/samples/nitro_enclaves/ne_ioctl_sample.c
@@ -818,7 +818,7 @@ int main(int argc, char *argv[])
 
 		rc = ne_alloc_user_mem_region(&ne_user_mem_regions[i]);
 		if (rc < 0) {
-			printf("Error in alloc userspace memory region, iter %d\n", i);
+			printf("Error in alloc userspace memory region, iter %u\n", i);
 
 			goto release_enclave_fd;
 		}
@@ -831,7 +831,7 @@ int main(int argc, char *argv[])
 	for (i = 0; i < NE_DEFAULT_NR_MEM_REGIONS; i++) {
 		rc = ne_set_user_mem_region(enclave_fd, ne_user_mem_regions[i]);
 		if (rc < 0) {
-			printf("Error in set memory region, iter %d\n", i);
+			printf("Error in set memory region, iter %u\n", i);
 
 			goto release_enclave_fd;
 		}
@@ -847,12 +847,12 @@ int main(int argc, char *argv[])
 		ne_vcpus[i] = 0;
 		rc = ne_add_vcpu(enclave_fd, &ne_vcpus[i]);
 		if (rc < 0) {
-			printf("Error in add vcpu, iter %d\n", i);
+			printf("Error in add vcpu, iter %u\n", i);
 
 			goto release_enclave_fd;
 		}
 
-		printf("Added vCPU %d to the enclave\n", ne_vcpus[i]);
+		printf("Added vCPU %u to the enclave\n", ne_vcpus[i]);
 	}
 
 	printf("Enclave vCPUs were added\n");
-- 
2.17.1




