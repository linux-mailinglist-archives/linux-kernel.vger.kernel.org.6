Return-Path: <linux-kernel+bounces-243223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FD4929333
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4631C211B0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E410717625A;
	Sat,  6 Jul 2024 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="iZZLcf0C"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3789816D31C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264937; cv=none; b=UyqzCTVOzxqS78kjcEyQd4y9Toi8B8vnhafGTO9tpGgBuPGuzE3JkniXbZfDIA14HRk/sTK6fEj6vAI9USj6DFcrOWPJ38GSCdV54bV82s/7HjO/fQwVvJuMIj2ThR88KUEng+Zxr8hZZfvTX6kR9ALdwtLtBrQNqtwVwg4U5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264937; c=relaxed/simple;
	bh=xHPnpi6eiQDJE9L+MxdWpmnPjGGiALkR0vdSK6lSWo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUzjU04Ft2FkboF0c6JkoS1OPt9BGYfugzlN4RbV+ZaTWd9NlYPj7ieI7VxZpFJxkcaxUvzCSzLy6VbURY6PCrldkXRk2DHqtOHJX2UVeWzC8QsAX/8zzT2mQaEnHDwz6t2nPIsuGbDpFWS72GbGtwCt1BkSCS1Qfm7TzM+acAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=iZZLcf0C; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=QJWNzgVhiKNUakSn/o8o6saMacqq+3MIaWzpwwRPzks=; b=iZZLcf
	0C/yqF4Ipvs0fLkbI2GHbneYnvyphkTCN8MGd+HGJadBNkYa44fjrU+RB/Xkbd1e
	8sErBBV7hK7RHG2JkkSWng5cyR6CFsRrib7xfrJAjQjkfSsRxwuGL1NKkYhaAgaR
	naJb93vpPDHn+ngOSDBu8TtjxYtjwrl2GPZ2NLZs9RUvjkdOdAKQXgvxgKoDs195
	kBklfsyqjDehqrrUXtk38Zwb+n8UL3G/Xajz4jQPgHVSHfL8mvv7rkvu4+uayytF
	t7DWCYKVMSN4IRTXntY47KNp6pCw+GVwrxeoz/8n/jQzoHN8DxC+jS8MoNfoPhvt
	DPiF7YZZkLWHpYvQ==
Received: (qmail 3810899 invoked from network); 6 Jul 2024 13:21:55 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:55 +0200
X-UD-Smtp-Session: l3s3148p1@uDUyY5IcSuFQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 47/60] i2c: stm32f4: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:47 +0200
Message-ID: <20240706112116.24543-48-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
References: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the wording of this driver wrt. the newest I2C v7 and SMBus 3.2
specifications and replace "master/slave" with more appropriate terms.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-stm32f4.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
index f8b12be6ef55..230fff0c0bf9 100644
--- a/drivers/i2c/busses/i2c-stm32f4.c
+++ b/drivers/i2c/busses/i2c-stm32f4.c
@@ -95,7 +95,7 @@
 
 /**
  * struct stm32f4_i2c_msg - client specific data
- * @addr: 8-bit slave addr, including r/w bit
+ * @addr: 8-bit target addr, including r/w bit
  * @count: number of bytes to be transferred
  * @buf: data buffer
  * @result: result of the transfer
@@ -480,7 +480,7 @@ static void stm32f4_i2c_handle_rx_done(struct stm32f4_i2c_dev *i2c_dev)
 
 /**
  * stm32f4_i2c_handle_rx_addr() - Handle address matched interrupt in case of
- * master receiver
+ * controller receiver
  * @i2c_dev: Controller's private data
  */
 static void stm32f4_i2c_handle_rx_addr(struct stm32f4_i2c_dev *i2c_dev)
@@ -643,7 +643,7 @@ static irqreturn_t stm32f4_i2c_isr_error(int irq, void *data)
 
 	/*
 	 * Acknowledge failure:
-	 * In master transmitter mode a Stop must be generated by software
+	 * In controller transmitter mode a Stop must be generated by software
 	 */
 	if (status & STM32F4_I2C_SR1_AF) {
 		if (!(msg->addr & I2C_M_RD)) {
@@ -749,7 +749,7 @@ static u32 stm32f4_i2c_func(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm stm32f4_i2c_algo = {
-	.master_xfer = stm32f4_i2c_xfer,
+	.xfer = stm32f4_i2c_xfer,
 	.functionality = stm32f4_i2c_func,
 };
 
-- 
2.43.0


