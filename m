Return-Path: <linux-kernel+bounces-517335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C1AA37F85
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9F418992CB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBB621764D;
	Mon, 17 Feb 2025 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1YCu8vg"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D32B21766E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786756; cv=none; b=puGAwoT6eKvtykC4WNbdktusnJ2QEdJE/Qy4BeH4mP+6HEIu6fMFtSjGY3xMM9LyDbo3ToHxBJmCHz5EUaUsL7I/INlsAGBfYhuhsjKt0GJ86kdtuv0vey5kSehD+/pmHvnCaFvsno6v/nrDw1i+4YdWNyK3BT1vPIGUIqK7X9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786756; c=relaxed/simple;
	bh=IAOgtSHPmVLoRJLg+8QXPPOSqnpbN/zZE8yNPOkZR4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAeAXqp3BlMD9J/FbBv8+9EbDp8Zdg/joO86vfc0lbGJ8HAP1L4uxGHrYgXYZLM4JWJpZChvuBOkhBI9Ri4gf6uOqhjC+RU6IxpTB+FLdTtx9QXTmwLYM5LteEZtb2tlduceA4OItriqMFDMMavvQnchlA4cciveOW1hz7A7nZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1YCu8vg; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-221057b6ac4so26173345ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786754; x=1740391554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gon5m/uHwX5/tX/GlOAqTznsXMi3PVn+WonV1pVvztk=;
        b=X1YCu8vgVClvJ7mjBn6ULKALcF+1Hro8w6WB8EvViInQMQ4OcJyzQiJOy6xj7FrAQJ
         k0N51u8/ghTKcs9sBSG16LrswwFdCQNLV1gIiVWRaOKl6naumva82iiRzDB3u5QmG0+e
         Q4iKT7sHR0rGSRS1hd6FTt2sjf4iWqclDyoCCBTNwu/9BzCwXzrkhpLiXG4AQm4FPC7H
         xWPc2vzxKbGUgkshwj33ZlgiJBlRD1TemMOCb/ZiRhh7f+L98zPM9uToTIX202f7bRli
         ziWwUEM70xWu/bThQz9wZ1XvP8io5CZdzUxCLP9MCdzw5FyNy8/MD58c23jzWgBH6+kO
         e04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786754; x=1740391554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gon5m/uHwX5/tX/GlOAqTznsXMi3PVn+WonV1pVvztk=;
        b=XVdLNljLqTjsO7fJ/JmT5+MIHEK3jfhii/REu1fQ4LxUYfEj0S0HoLASHdTQ6YL6vS
         JkZ9+S/B/AOP2cqFkmZVFx1H1PybANaN+UU7JlxET1W2ioeYihGLT+ahnIlH4hoiJZm0
         9iRK0r73uaIWDgjrOG+EOI1bngxFGh/dqAjlc6ljFWdZRzws3mFc0ApVoh6WsQYGW9fZ
         kNoiaFO2s+S0qH+FUr5mhQbiWMfbWGm2UcjxpdSbD1cqsDzRU54HJjkjo1y+M5U+jlxz
         fDRzTScwUODwnAcXzB6GaqOBzDaJ1USveE8Y7tLtPR+jlIdFdjlsG2I1qVWcanF9QXJn
         nSCg==
X-Forwarded-Encrypted: i=1; AJvYcCViuVo+gyth06jeEsgZi25R6211rmZpleu9JUwDa7oZBMfDwHgtlDmGVPpm4chDD7yFPmBYlVu0sqIIukw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrUIEqiW2swE/0Zk6Ew0pW9PTWRiEIjESf/y4itW9i4u6O33/s
	93o5vpT9ACyeO//2ckmdIUVh6ZSsngRPBntozfcL0plfVf5AQTOpd2eDr00pYBY=
X-Gm-Gg: ASbGncvzFPcaJXxn36AZU3Sm6SQ4V/yqLAMiP7zBQJ07kaPKdJ8T3bZ1nGKwb81t8Go
	y108vGH8FRQEP8wJ0cMv/Y9hcAlJ8/dnSvJLjY6dCMQ7xE846jXhDiLVn15M12bwStIwEnkm/Zt
	CDIn7LF9/q8pfIya5sCDN7ipNHE9EJ0iuKcQF1Mlbw8ZZdaGBWav1llxBpD0fiIQG/s8gJnkd3A
	lfneMHB0r5KduEGEDuRHjGTPSw7dZdu/TRdWlZkNVd9SZlrtC/QsID22fMiCkfeibtPSeGx6Nvs
	d8l9CZjToai8qYmZb+8N
X-Google-Smtp-Source: AGHT+IH3fn6ruZvmVbfVZA/heT5i3BY36VeD/JfcO5bNPtOZmGRDCFwBN4W8l978gaiFOsM8CtJUOw==
X-Received: by 2002:a05:6a21:6e91:b0:1ee:8634:75a5 with SMTP id adf61e73a8af0-1ee8cbd7eefmr15973546637.26.1739786753608;
        Mon, 17 Feb 2025 02:05:53 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-add3f326b31sm4670219a12.64.2025.02.17.02.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:05:53 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH 2/4] [PATCH V2 2/4] staging:gpib:agilent_82350b: Removed commented out code
Date: Mon, 17 Feb 2025 15:35:12 +0530
Message-ID: <20250217100526.49495-3-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739783909.git.kumarkairiravi@gmail.com>
References: <cover.1739783909.git.kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

Removed commented out debugging code to make code look cleaner as
spcified by TODO

Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
---
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index 5a74a22015..7936c7285d 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -176,7 +176,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 
 	event_status = read_and_clear_event_status(board);
 
-	//pr_info("ag_ac_wr: event status 0x%x tms state 0x%lx\n", event_status, tms_priv->state);
 
 #ifdef EXPERIMENTAL
 	pr_info("ag_ac_wr: wait for previous BO to complete if any\n");
@@ -190,13 +189,11 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 		return retval;
 #endif
 
-	//pr_info("ag_ac_wr: sending first byte\n");
 	retval = agilent_82350b_write(board, buffer, 1, 0, &num_bytes);
 	*bytes_written += num_bytes;
 	if (retval < 0)
 		return retval;
 
-	//pr_info("ag_ac_wr: %ld bytes eoi %d tms state 0x%lx\n",length, send_eoi, tms_priv->state);
 
 	write_byte(tms_priv, tms_priv->imr0_bits & ~HR_BOIE, IMR0);
 	for (i = 1; i < fifotransferlength;) {
@@ -210,8 +207,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 		}
 		writeb(ENABLE_TI_TO_SRAM, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
 
-		//pr_info("ag_ac_wr: send block: %d bytes tms 0x%lx\n", block_size,
-		// tms_priv->state);
 
 		if (agilent_82350b_fifo_is_halted(a_priv)) {
 			writeb(RESTART_STREAM_BIT, a_priv->gpib_base + STREAM_STATUS_REG);
@@ -226,7 +221,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 						  test_bit(TIMO_NUM, &board->status));
 		writeb(0, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
 		num_bytes = block_size - read_transfer_counter(a_priv);
-		//pr_info("ag_ac_wr: sent  %ld bytes tms 0x%lx\n", num_bytes, tms_priv->state);
 
 		*bytes_written += num_bytes;
 		retval = translate_wait_return_value(board, retval);
@@ -238,8 +232,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 		return retval;
 
 	if (send_eoi) {
-		//pr_info("ag_ac_wr: sending last byte with eoi byte no:   %d\n",
-		// fifotransferlength+1);
 
 		retval = agilent_82350b_write(board, buffer + fifotransferlength, 1, send_eoi,
 					      &num_bytes);
@@ -284,7 +276,6 @@ static irqreturn_t agilent_82350b_interrupt(int irq, void *arg)
 		tms9914_interrupt_have_status(board, &a_priv->tms9914_priv, tms9914_status1,
 					      tms9914_status2);
 	}
-//pr_info("event_status=0x%x s1 %x s2 %x\n", event_status,tms9914_status1,tms9914_status2);
 //write-clear status bits
 	if (event_status & (BUFFER_END_STATUS_BIT | TERM_COUNT_STATUS_BIT)) {
 		writeb(event_status & (BUFFER_END_STATUS_BIT | TERM_COUNT_STATUS_BIT),
-- 
2.48.1


