Return-Path: <linux-kernel+bounces-518276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7FAA38CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DC91677EB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9639237701;
	Mon, 17 Feb 2025 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6LoSIZN"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A268B237700
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821873; cv=none; b=a+qyegakpJllpviThz4erNdGhpjCI84TQigMuh6WY4Ir1YBjs+W94RpetXbBcWxyX25jh1ygUsxEwQzZ5ASGDQngMI3ywV8NEed+m5Lx3mml47WPTg87RdyZNlje+cQQh7bORF9MmL1N5A1Jx2zyjywzVdlCyaQRuymjY0xyJzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821873; c=relaxed/simple;
	bh=PYFHK2qhY4SY9e6RMO8PCovA0x+FEn7SE2lUoEUqdMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBoxKu+ke7FN1hiuALGdbEk6PlXcGLNbYVeUOrtNMiTbJ2tQYbxPWrK4JR+TCfYkwUCF4FDzFxBzlnnWRh6Nx9BdFBRkliqU0MyKuCBW7OyERW3PEsUP7G7P+wdW7yj4gpR1+uxlIy80+P1KEFv29TyWnNfya14ws6crbBhAJH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6LoSIZN; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-220ca204d04so61873805ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739821871; x=1740426671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynx5vOs0fBAJhKdBzwWt5sfNWCPi33ItYttu879rqfI=;
        b=i6LoSIZNsYb/bzlKZskxtVgjyR40vmDuMedEhYBjW/IAWAL5EgtCHtcs4UxzCA6Bci
         8ljO78+fbuzUvBxmOzG00mDtU+1gCWYtjtvcX9lI5uvWEFHd9HPOiJ57x3wRckU9INjU
         uSX/fZM+t6tuC7qKBPRRmKT1y5K0B8XG7/z9O7dTvehPENTctAu7F9ngeXFzghYvzSCD
         0+PaZDxPvT8O8EJ8NsymPJ+B85yxPsDkCMuKbhDO1zt+TC05Qg97Sm0YThWAFOtfSmnZ
         641z4k8pF/QMRHQf/B0+mpJj6bd3VZ4TF/pOz/PEEuCZcNQU4rtNzBK3C9ZqLnKVnaUc
         qpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739821871; x=1740426671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynx5vOs0fBAJhKdBzwWt5sfNWCPi33ItYttu879rqfI=;
        b=L1VFP4MbE8JJzoe0/pD7P0q8AnkqY2xleG+TCVxGfaSOLvMWqkJKd4i/hagTLcE23V
         5aeXmB1oA1WXBzl0IAhFraKyXEqcOSdmSNNbzabdstg3kTRbCIH2U7fExUBLBeSpuJDY
         YXRUvZHsDCz2cKUWuEQNdWZn8OZF17/waXe9SYHz84W/SispLOfGUwjVtwojAZI727Er
         EXfVMVPxkpoSFceaiUl9aFcEfNweE6Cos1ZEEkG5g0bhj23wlqRl2Dos37b2kCnJk5tB
         svMHvk7aMn6zV4FORfoNoy+jPE97E3Lzel9xb22jFZaqYfn0TTXaBWDi5XnCxJAlEsGB
         3EzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnWw5LRGlj335pR1QiSS3ztBxeQ5zqF9L+twmA4DT4/WKXSZjFyPhUcBZLbjp2I+9Ipy28PAoVO5Z6/rY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkqsd8R1y6NWK19esSLmNLZo4lEWNBGVyDYEK7PZ0Oj+aCQhOL
	oORBjybzDkrwUUIHl2e5gIbwbSXlJ+mgvn06dmkKPouRj6PEqCyA
X-Gm-Gg: ASbGnctMzs6ezSfnYRKOgO++VXOh1WnkrTHyWI0Te9Cagj8/mQIzJSkIvexGoJ1Y2vo
	VuoPkdGQUyERUyMYUqfXL65eDpJo0omqGHkp5NMFFkBr1nfxidPHgc1RW+T3gxTiAsVHPrITNwK
	vOw9QwmtDuPCxe2/vkozO2hZN6XfSrbsfewQnzhuJ4S0Yu2v6Xhrcm6VP3kl4NwkCrDy8pNSBxa
	aLsjqVeinsqIhlGnOSL+tzmfvgZ/CKIOLYqLzmWOLItAVdwi1QDzHRj/pj45udZSId57xOMhLXd
	l3SPAU+sG8rOxgTq6diR
X-Google-Smtp-Source: AGHT+IE7lgYEIV78d38bBQCmeTFGzqO5NRmmXQ0QnMeEkI3+tmRum82E2pf3CSYAYaayIhh2GBM+wg==
X-Received: by 2002:a05:6a00:2d9d:b0:730:f1b7:9bc4 with SMTP id d2e1a72fcca58-73261779914mr18081727b3a.4.1739821870715;
        Mon, 17 Feb 2025 11:51:10 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7324275bd28sm8480793b3a.122.2025.02.17.11.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:51:10 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	kuba@kernel.org,
	dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH v5 2/3] staging:gpib:agilent_82350b.c: cleaned commented out code
Date: Tue, 18 Feb 2025 01:20:49 +0530
Message-ID: <20250217195050.117167-3-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217195050.117167-1-kumarkairiravi@gmail.com>
References: <20250217195050.117167-1-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

cleaned code that was commented out and cleaned blank line that resulted
from cleaning out commented code

Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
---
 .../staging/gpib/agilent_82350b/agilent_82350b.c   | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index 5a74a22015..af1bf6e893 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -176,8 +176,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 
 	event_status = read_and_clear_event_status(board);
 
-	//pr_info("ag_ac_wr: event status 0x%x tms state 0x%lx\n", event_status, tms_priv->state);
-
 #ifdef EXPERIMENTAL
 	pr_info("ag_ac_wr: wait for previous BO to complete if any\n");
 	retval = wait_event_interruptible(board->wait,
@@ -190,14 +188,11 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 		return retval;
 #endif
 
-	//pr_info("ag_ac_wr: sending first byte\n");
 	retval = agilent_82350b_write(board, buffer, 1, 0, &num_bytes);
 	*bytes_written += num_bytes;
 	if (retval < 0)
 		return retval;
 
-	//pr_info("ag_ac_wr: %ld bytes eoi %d tms state 0x%lx\n",length, send_eoi, tms_priv->state);
-
 	write_byte(tms_priv, tms_priv->imr0_bits & ~HR_BOIE, IMR0);
 	for (i = 1; i < fifotransferlength;) {
 		clear_bit(WRITE_READY_BN, &tms_priv->state);
@@ -210,12 +205,8 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 		}
 		writeb(ENABLE_TI_TO_SRAM, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
 
-		//pr_info("ag_ac_wr: send block: %d bytes tms 0x%lx\n", block_size,
-		// tms_priv->state);
-
 		if (agilent_82350b_fifo_is_halted(a_priv)) {
 			writeb(RESTART_STREAM_BIT, a_priv->gpib_base + STREAM_STATUS_REG);
-			//	pr_info("ag_ac_wr: needed restart\n");
 		}
 
 		retval = wait_event_interruptible(board->wait,
@@ -226,7 +217,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 						  test_bit(TIMO_NUM, &board->status));
 		writeb(0, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
 		num_bytes = block_size - read_transfer_counter(a_priv);
-		//pr_info("ag_ac_wr: sent  %ld bytes tms 0x%lx\n", num_bytes, tms_priv->state);
 
 		*bytes_written += num_bytes;
 		retval = translate_wait_return_value(board, retval);
@@ -238,9 +228,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 		return retval;
 
 	if (send_eoi) {
-		//pr_info("ag_ac_wr: sending last byte with eoi byte no:   %d\n",
-		// fifotransferlength+1);
-
 		retval = agilent_82350b_write(board, buffer + fifotransferlength, 1, send_eoi,
 					      &num_bytes);
 		*bytes_written += num_bytes;
@@ -284,7 +271,6 @@ static irqreturn_t agilent_82350b_interrupt(int irq, void *arg)
 		tms9914_interrupt_have_status(board, &a_priv->tms9914_priv, tms9914_status1,
 					      tms9914_status2);
 	}
-//pr_info("event_status=0x%x s1 %x s2 %x\n", event_status,tms9914_status1,tms9914_status2);
 //write-clear status bits
 	if (event_status & (BUFFER_END_STATUS_BIT | TERM_COUNT_STATUS_BIT)) {
 		writeb(event_status & (BUFFER_END_STATUS_BIT | TERM_COUNT_STATUS_BIT),
-- 
2.48.1


