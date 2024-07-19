Return-Path: <linux-kernel+bounces-257182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18058937650
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB62D1F26463
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDB879949;
	Fri, 19 Jul 2024 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRQ21QpA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E029A1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721383374; cv=none; b=H/CWj+oO4VrtV71Xly2GSdI2egdU9YSx3jlsi/vfLsrhNZvm9MJVPG1tL7obPpHeStDPhT2+or94FQQi5sT5YCBXRjCWcxHNPLCcBcLlDwZHK235G3JaMSdF8Wy3h5KwqlLwmLcfPvxf/2RQ4SZYhyU5V3+6u9aoZZahvqvRLHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721383374; c=relaxed/simple;
	bh=KamqmnxntR2x7jpIqxi+eYuMy7eFXf+6aWtQSYySRdU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CSKNbh4KL7kPYkHa4fckY40PocajyZuy/wbiGVFi31HAQJr6UjRaTFUxA1MlLKnJ4TsBNV4NSpoDw+L/cXQspVOqLUsHSZdG9EcmQPmozx/LrnThQ89upShMXnv7iGZ0UA39RGdP6eaKIXvWTU4l8qIz1yicYxYggsJBP1ChOsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRQ21QpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58093C32782;
	Fri, 19 Jul 2024 10:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721383374;
	bh=KamqmnxntR2x7jpIqxi+eYuMy7eFXf+6aWtQSYySRdU=;
	h=From:To:Cc:Subject:Date:From;
	b=QRQ21QpArhbQaLC2Ap3pUl3Nv1gzsBH0/zHGFzVpLWVvCISdzJ4vniXtBPjyGa2J4
	 0D2VlXlOeRYg3x1IV8cfqXNg5GQlHNRjhFaB5T+XJKhKTZs2/O0CTH6Bpm+oGpc+N+
	 uZEKsoVr6RM7q/b+yBfRRAH+lRyEBd7kUdyl44/zr8qih5CnMFinroVvv8zGZWfkRB
	 kP2ou5/XwDeB4NZjLARq8hA2ZLDRGuc3CC/oeaWqH6ZDkm3GzJ2M2lgJBWdm7OgFir
	 KFycFDkKRHQNQLt3slnD36uC79EwChwGqa/USILGHvdvdnpwLN16Pzvwf2Jtb2n1U/
	 CYrAnv1Q6G+mw==
From: Arnd Bergmann <arnd@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: qcom-cpucp: fix 64BIT dependency
Date: Fri, 19 Jul 2024 12:02:23 +0200
Message-Id: <20240719100247.4012087-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This newly added driver fails compile testing on 32-bit architectures
because it relies on 64-bit MMIO register access:

drivers/mailbox/qcom-cpucp-mbox.c: In function 'qcom_cpucp_mbox_irq_fn':
drivers/mailbox/qcom-cpucp-mbox.c:54:18: error: implicit declaration of function 'readq'; did you mean 'readb'? [-Wimplicit-function-declaration]
   54 |         status = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_STAT);
      |                  ^~~~~
      |                  readb
drivers/mailbox/qcom-cpucp-mbox.c:65:17: error: implicit declaration of function 'writeq'; did you mean 'writeb'? [-Wimplicit-function-declaration]
   65 |                 writeq(BIT(i), cpucp->rx_base + APSS_CPUCP_RX_MBOX_CLEAR);
      |                 ^~~~~~
      |                 writeb

Change the Kconfig dependency to disallow that configuration as well.

Fixes: 0e2a9a03106c ("mailbox: Add support for QTI CPUCP mailbox controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mailbox/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index d1f6c758b5e8..4eed97295927 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -278,7 +278,7 @@ config SPRD_MBOX
 
 config QCOM_CPUCP_MBOX
 	tristate "Qualcomm Technologies, Inc. CPUCP mailbox driver"
-	depends on ARCH_QCOM || (COMPILE_TEST && 64BIT)
+	depends on (ARCH_QCOM || COMPILE_TEST) && 64BIT
 	help
 	  Qualcomm Technologies, Inc. CPUSS Control Processor (CPUCP) mailbox
 	  controller driver enables communication between AP and CPUCP. Say
-- 
2.39.2


