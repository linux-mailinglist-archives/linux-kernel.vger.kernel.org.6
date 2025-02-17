Return-Path: <linux-kernel+bounces-517393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E92DA38037
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812BE3AE91F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C9B217668;
	Mon, 17 Feb 2025 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKplP09c"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134C101FF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788278; cv=none; b=Ky9gdX4/tVsgXzEGLPcO4qaAqRmo9aZ9BG7ODElvBxDBES/GqIPCcG7hnn57ny0f0q+lk3q1Z3UXBBZwGQy4uhTo00ZO7zXdyOTkEylEz8geKqFOeG17COFljYusC69ftcttUqQp5Xl8wuWcsvZYvpN4v/cwireET89KChxtJ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788278; c=relaxed/simple;
	bh=IAOgtSHPmVLoRJLg+8QXPPOSqnpbN/zZE8yNPOkZR4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcbSwBbXRLuthByNvFEgTIRblMviNEOw3RCsGejnnDF7nRzZGswoHM0utZ7SD3X3X/d5my3FqXnvbCIdXt0kdsWmdWEGLaz6U+AEMYhNC2HzfXgZxHqk+Tei5DVrm+aXuujfq9jDl4sCLsixPY9Tv3KoDEwYz1o/MxtspxaEFk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKplP09c; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2fc1c80cdc8so5603840a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739788275; x=1740393075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gon5m/uHwX5/tX/GlOAqTznsXMi3PVn+WonV1pVvztk=;
        b=aKplP09ccwfxfHdUl/12FLtlfZo9wlaj/0+AXwqcWfZb2wcdmlLDldKH4BSaqpRVyr
         v0Rg8SCKmqR7+dCubz7vHXFhVRwwK6Hn70lNWqoURYOKgSHR9W7rdreeqngK6tn+GcuQ
         N8y2dOHrGVu1NyEGx7fea79ZHQrtVr5nABq05iB2doR0r9OmKQfM6Sfecw6uZwmfF6C7
         jZLSGY0jU1m/KnYZ7xJl2Y/2vwL3Ng0GRD0sAT1Asl1JMGYpRKw0O9b8Kum1b62v4ugU
         hrCv93bM032sJqvRqHvLkXFtvr/AL6joqaOhaXkqUnAy+yoCcJC9io6ghQi0rait5uOe
         sm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788275; x=1740393075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gon5m/uHwX5/tX/GlOAqTznsXMi3PVn+WonV1pVvztk=;
        b=UvXHZQWdsOIE3iutmTwuahclVPCBoke3KAJh7zjpbT9moP8r60UURaPFjhpxcqB6VB
         XKE3iiFhCC8M4zvfe79LdblcrDeNs4WRtL8lWdnaMiUVJr5oLOZETCYCRnNr17FxofF8
         RVAPH4CeQp8c+lOpoYJ0+0BwNUJBB5BvyPXcGXxImZdWpVjngfbycovOdx74aXao6Un8
         NrPEkmRLIb6V+warDgoepcDIsaTFDFhTc/+9DZAAscjGGJ/eAmCxUMSSIQ9kQ5iLsec4
         j8iuHCo2L3mbC3VUQTvzM7FUl1dwqXYm0FQn/BoWIon+tzeBauF8pLqqHWg1E/4GfG3P
         dRTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKLD3p2q377Yx6f3VAjx0fDLuc5Fv3k2LEpUOa8sKfWB4AOdL6TezlViTbEm3A8UlpB9g1Cvpq7EkiZNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBNK1lwyzpC4hkfk0qV8x07hTKdzwXkjbfY2u8ZAybV9/MQvAC
	bl//XSKyQFxIcaBMwYoGDQE8k/oDiUOsMCIPPhHyJDDJRBTiXVvp
X-Gm-Gg: ASbGncueW4qhNByxqMHcYINeg2U/l4D4sQp3ug9iDCH4C6U8zPw/7yuksQzreUNJjEN
	XwTFw2EVq547VfzTLf2pOkULmhbI+xM1XbfSWnu20G5sohbQx7XHSPSQ52RVdn0Pa5TEiXpWnoK
	WewV8fxYB5SHjg6tnNVdmKZSDF+Zj+/Yo5avxA8GZfbcjHJV5MdMQYb8kz/mFPXMBn0Lsxaaixr
	EeX7e/KoLQEg8PbtLLoqEycISOIyfvHw2EcZu3wg0J9rDGib8biOtSh4Ql0C+ciLD0k6HIKoFW+
	3sR7VemiLV1cZf14jyV5
X-Google-Smtp-Source: AGHT+IFmlIM3XT7JkRePyLttLZv7uBkqX4zHAjFsBgxNCqrkB/IRmq4oiv5CJ/mXXvBtEGAUOxSzxA==
X-Received: by 2002:a17:90b:3ec5:b0:2ee:7698:e565 with SMTP id 98e67ed59e1d1-2fc40f0f503mr13083882a91.8.1739788273722;
        Mon, 17 Feb 2025 02:31:13 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fc13b9125dsm7782624a91.38.2025.02.17.02.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:31:13 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH v3 2/4] [PATCH V2 2/4] staging:gpib:agilent_82350b: Removed commented out code
Date: Mon, 17 Feb 2025 16:00:36 +0530
Message-ID: <20250217103046.54294-3-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217103046.54294-1-kumarkairiravi@gmail.com>
References: <20250217103046.54294-1-kumarkairiravi@gmail.com>
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


