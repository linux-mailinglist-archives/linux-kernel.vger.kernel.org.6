Return-Path: <linux-kernel+bounces-517334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 504F4A37F82
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FFD18977DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A240E21764E;
	Mon, 17 Feb 2025 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK0Fm+Ci"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A8419CC3E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786750; cv=none; b=OW9EQdQb5EbvUBktkNxd3WPjww0kNMf1LkTRUwsmOd1YdYBXlRB5liCXNLXE0Jg1ov+7NtyUz7DFVivG2xOso/75Ir/ILpEyKn6CNjPR4/ZLLEO12eWk4+sz81qAeXmewkmjjUu7I0f8eY0om8C7RlBqi8fVyyo/xtdaYEFmbXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786750; c=relaxed/simple;
	bh=IAOgtSHPmVLoRJLg+8QXPPOSqnpbN/zZE8yNPOkZR4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q87KWdZDATdCZhak2zHViTbkZBP0bskzWhveXFxxXuWuieOIGY1CSVEzfmAwv/PpE8qSmZiROSi0hG53+CZgwzZVRdLhzpP+Flt0YJJ8N3/mmc38xSe6hkaSYKKIxImKgRjauL+/5cwCUi2BJpbKqT/snIi+mB2p7yLaLB7LSxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK0Fm+Ci; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-220c2a87378so57349375ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786748; x=1740391548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gon5m/uHwX5/tX/GlOAqTznsXMi3PVn+WonV1pVvztk=;
        b=kK0Fm+CigJ6jdq+XRolkktsl3qjikeNAEpiAofQzGn0uFBb8WFTExydnSfke7p2fPb
         aW3YkWxPQz9jZWx1+n1x9EgCIE7t/Z0PIkNuXBX6pMVUIPUM+UeXf5dKDYElhxPBiXVM
         5z6rK5EgpHGAp/5N6h7pNyXEeN6YFrMpOusXuSE12IOxPB8HhuPMDpZdGU4OjvhT0RMz
         GJdRlQUJVz+AWkwu98r4kv3bxz9Ak/lsJgxQVX6CXUdr/KmBZpox9fMVaD9mbhamuLCA
         tsbMzCOM3cZgRt6FZifq7hyldXubnSMuIy28jqYFzskR9KITjIeJXVPKXG7e/FjpcawZ
         vrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786748; x=1740391548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gon5m/uHwX5/tX/GlOAqTznsXMi3PVn+WonV1pVvztk=;
        b=ir4YzUCPABmZrrOuyvD9IUne1rlvQYSD0gc7gt1aazVzCvyPyQUYbeocmLtRcJgBxg
         E9Jwh0pHwKPuT+52CTrrF9fBQjBemx8QCNffK+BbjqzSq3+3zP/Vc6Z/qxNBQ/JPKUW3
         jKX5u4ewbqb4lr+O1grffVkIrI5Stswl0b5fzMLv5yqWjDF/ymhW0ZTWHG9ALgBccAuT
         JTmLwaB9PYsJDaV31XZWH0Yv8ZZhBKkHKRRnFDewL+MFvTVckKQ/hZ6Frx6yDoApvcdI
         MRZ6kegJS4mEedVEccyjdG3Ki/aJ4+uXnJLgPY+9JIJZIqW58MgO3azRMpaTMbd7cc8B
         JAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbygHuypgBxIYGuyawAKc29/7lAQMMXlDQlzMzGDw+prEFKofUwTV5qh6XHKH2kxBSW19BE4o1QTQaNM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJYIUOYl3rhFVzjeks7sbSd779EjgEjrSIdKjCfKMsKDN2xkYA
	nSpfI76766inFREJ6+ACfnClHh/AJFaIpatocxobOgpBI33wHiDrrGE+N5toeBk=
X-Gm-Gg: ASbGnctrdKEUVr6AsBFLKD4C9KkuRF9u1eA/YhuYoFzchi6dLPbylJoFCEqF3EDkdms
	PAXEPXWmp7iSeoxEKhoBnxih2RhrcU2ZS4uQmW9+LOiu80G0NufpXwcwTUnkP40mzVhvHK9xnUn
	Mg2UIzgoyjo7XlzylbSS+S5U5tpWn3S4U268a8KaexcMXM1mTZjR5NDIfQ47RlhUs6vuSexf9lV
	wo39OqGBDvo+caN4GcZP+9xvSwL9PBthbIkTJYa/+pjuL5QCUGio9dBLqGveP6da7LJQa94GFdC
	vLmIE1MiWymYCVuPuoaM
X-Google-Smtp-Source: AGHT+IFKg3x8muXdgwlDkwPXCICIrswO4jMVroF8RLzpfuzitmqcHTBf6fh62HGnqM/gzdxuv1M+DA==
X-Received: by 2002:a05:6a00:244e:b0:732:5f41:ea6 with SMTP id d2e1a72fcca58-73261799c2amr13786184b3a.10.1739786747690;
        Mon, 17 Feb 2025 02:05:47 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7326ea62b03sm3051345b3a.70.2025.02.17.02.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:05:47 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH 1/2] [PATCH V2 2/4] staging:gpib:agilent_82350b: Removed commented out code
Date: Mon, 17 Feb 2025 15:35:11 +0530
Message-ID: <01a91fb16e4774be1d89f8e2819b453ea8936fcf.1739783909.git.kumarkairiravi@gmail.com>
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


