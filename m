Return-Path: <linux-kernel+bounces-198874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F328D7E98
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF6F0B23BF4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010A684D10;
	Mon,  3 Jun 2024 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="MBAb4wq6"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873CF83CD4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406937; cv=none; b=Wzi/OImff92FUoFoMQa0QKF8VaLQdwLSDqP1YJMpTwGFgY/yD7iLcl6ujl/2oZJnVwPqSKzPRHVd/qwchCyX+RbhMJog63C6Kkc2KqAZjYiO2wZranTa8LS9e32UBAZAH543SSACkOTrAgMUnx4UwNlpz9k8pv3qePUdt6p0RT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406937; c=relaxed/simple;
	bh=C/9KYYddj4qZHqa8y2yNasr0MNOy2tpH9zFMadog84M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCgj5wSWlsAXcnBy31LUZKhElYpQvWfT7VnKhsMZPnrmPpY8Fxdkma9IHWFQyTVIL/kVD8CrSLoKxexx9lMJTE4n68v0oN0rd9UJG2lczueYiCIrjYNWNZON1Hfl5zPfnidInHaHHGVza/sQvlDBEAL4K4Vn03U0aD4SkIWK7KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=MBAb4wq6; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=ytP13Gl64JFAwriGV8x2mCJjir2yJaQn5QnGdupCrjA=; b=MBAb4w
	q69zxA+YcZZEOrgzDEnFtr6xBSFn364fpPZ6+qK6Y/su7ZXQFcmRwJIFNww3OzwF
	RAUa94ILtECzH37bOtAQu37FdSUImWbUcfU7p0BjjFiEQq0Ab8ab1IpBH8AEFvP8
	kVcz6xUCj4+/40Q2q8Sh/1aBUtDtTB1Ki0Z+uuwlUMHO3n+g99NRrbjOW4a0CDh3
	deVPj18S4Ym2IlHtrHdJDEMLBmmTpJdvFHDcSOMa5TzJKe+qewd7KQInb0LH6s1m
	fN8aC4iwhdUo/khS/xSVkI/0k2K6i1OFAb791YJDTqRMBQ+uDzMbVziamd0m7wZI
	c9L5H/3ullyFP1Wg==
Received: (qmail 1903270 invoked from network); 3 Jun 2024 11:28:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2024 11:28:51 +0200
X-UD-Smtp-Session: l3s3148p1@HZUS9vgZPNcgAwDPXzLGAH1eNELjOc3g
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Bluecherry Maintainers <maintainers@bluecherrydvr.com>,
	Anton Sviridenko <anton@corp.bluecherry.net>,
	Andrey Utkin <andrey_utkin@fastmail.com>,
	Ismael Luceno <ismael@iodev.co.uk>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Subject: [PATCH 6/8] media: solo6x10: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon,  3 Jun 2024 11:28:37 +0200
Message-ID: <20240603092841.9500-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603092841.9500-1-wsa+renesas@sang-engineering.com>
References: <20240603092841.9500-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Fix to the proper variable type 'unsigned long' while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/pci/solo6x10/solo6x10-p2m.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/solo6x10/solo6x10-p2m.c b/drivers/media/pci/solo6x10/solo6x10-p2m.c
index ca70a864a3ef..5f100e5e03d9 100644
--- a/drivers/media/pci/solo6x10/solo6x10-p2m.c
+++ b/drivers/media/pci/solo6x10/solo6x10-p2m.c
@@ -57,7 +57,7 @@ int solo_p2m_dma_desc(struct solo_dev *solo_dev,
 		      int desc_cnt)
 {
 	struct solo_p2m_dev *p2m_dev;
-	unsigned int timeout;
+	unsigned long time_left;
 	unsigned int config = 0;
 	int ret = 0;
 	unsigned int p2m_id = 0;
@@ -99,12 +99,12 @@ int solo_p2m_dma_desc(struct solo_dev *solo_dev,
 			       desc[1].ctrl);
 	}
 
-	timeout = wait_for_completion_timeout(&p2m_dev->completion,
-					      solo_dev->p2m_jiffies);
+	time_left = wait_for_completion_timeout(&p2m_dev->completion,
+						solo_dev->p2m_jiffies);
 
 	if (WARN_ON_ONCE(p2m_dev->error))
 		ret = -EIO;
-	else if (timeout == 0) {
+	else if (time_left == 0) {
 		solo_dev->p2m_timeouts++;
 		ret = -EAGAIN;
 	}
-- 
2.43.0


