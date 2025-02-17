Return-Path: <linux-kernel+bounces-517336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21779A37F87
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D790189940D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5D2217711;
	Mon, 17 Feb 2025 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqtY9zVw"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA92217718
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786761; cv=none; b=ZLbHiTFAOupVhzJVQuf/TkG+PqFIUu/jFwJh3COw17hfPv22iNLecITj46VXl8WIKsZGKQjyunkBd574QfSP1lNW2oNHAnDWDzzoGAL7X0yCeqZ9UyKGv3vVMFB5V5q3qQV5R0/Nh0Z1O1u+uMyJeMwlATbNMIiIS0A07oa2hq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786761; c=relaxed/simple;
	bh=XO6uPpFukGBucmrCA20btnJlN/3eEn2EL2uIuT8mRyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fw7d9LTjYYqykfm33pgsmM7B4nUwS6VCqBhfx824SIsRD9uPuQgre2PugAaSp0AVD2O4Hjq9G56ZyT9AXnPWU2K8wTcR/MUWFGoG//pv1GGwPaEFGn/2t53LB00Cs2fASQNxoI0GVZM83sYEU5f+TvnfKescj+OgJ8GwX0id0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqtY9zVw; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-220d601886fso53562075ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786759; x=1740391559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6ix2sWH7fK+O3pMFw+ar4SRdhAMLkYoHd95tZujCUw=;
        b=bqtY9zVwRJN715fpNi1ki+66yHKpzIMwkaBnNxXzekiQbY1rXYTj5VQ9wLnZW2JBOY
         cuyoxjoPn+SSauU6CAuScXHOn0mx3mQh3d1zOQoFGADK9gZjfohHt1DbRg1+pUkJeJn7
         Uj2Gf0mpJdv0nG/Jbx7W9/NfIj50j3Dm62chqn1GBgtk4Npr9zzM0ZqszokuuEWAMR3J
         Mt33UBK8MeezLjz8XoN/qrsmM+hO6nyYkP+rs57ABtQ2st1qTvPHzDUnkfXVYRrN6Qje
         KZwLk/FPExGDzPL/TVDTwpIKQFlWUvUUI/vsQ7OC3qeYV4/iyJo9kIOIUqv/Y3owoz9X
         /qNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786759; x=1740391559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6ix2sWH7fK+O3pMFw+ar4SRdhAMLkYoHd95tZujCUw=;
        b=EgESTZmQDkHVYFXp9oI0hVLfdfl04swG7C9ZeOiXCTJamrZEYqewX8AtOwWX0hbqAj
         ov0OxwpCjqJOG+rMNwwa7V6KT727aH8BCEfWa6u+82l7Zr3MDd3gVvejzz7skdd+Ju+l
         P+CissRMtfXbikRAM6KViAlywtC+wnRBf2NPvlxPdbxi6tBFO7gm6qiLtNbjvtl0SYQT
         iDxW/Oikgf8AE6Zb4YYmAEAhJKl7waS2Y2H+ShaucMPP2hTftf8Ux+EM0w+RXMKgl3bR
         O/RuTjYyyS5DJm8Kwk59D0Ck0AqsEWUyTP7eDe/cl763SEOeIyfyMrGdqack0YKAOED7
         rgdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMbIRe77sMhIb+Tr5vge4ZdP5ufhdV9kM3ZwilmRGhLtvzCpTx3E9XT8KeKKfCkSj18VLJ8gH0SSomQR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsztUSJEP4f9Yn4h89s2Pv1/m68pAI6uMgLMIUNRf2mOE9T7Q3
	Tk1Sf3+XH8oxFmbqlbbc+jpwc3Uc/eD9WySncMLQ8nC7agqxDirL
X-Gm-Gg: ASbGncupL6QD48s3mmCmvZg7ySUPRh7nnOArvBY2hUYGGcLYvxvowacFnoigPpDWI64
	DI7lnbccyAePzzeX7jefTNZXM8HCdoD67+hbZ8xqmIBmL0QOTycUjD+lG4bsdTD5fULzfDPDacb
	NEvq29O3AAmw6IPkAdMhRIY4DTtW9pMHbWPiBR43wXKKa0odNZd8m7WZ637s9NlshjqP+DChEaI
	xkB64nZc2q+wEnAlCTxbUh0ZmVOYKqgFvZ005K12/gTDuYiTboowKvLM0IvIlPG5wNrZ/Ke9XuJ
	GLPH2TolbF/9JO/nfykR
X-Google-Smtp-Source: AGHT+IFNNtw5MiwVglxdLubZCIsw+nJVWtg78T0UT6HZ55NYVN1f9M21iXjuOWWJttgGCFPw+Y9ffg==
X-Received: by 2002:a17:90a:ec0c:b0:2f5:747:cbd with SMTP id 98e67ed59e1d1-2fc40f22ddfmr16489685a91.18.1739786759369;
        Mon, 17 Feb 2025 02:05:59 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fbf98cfd03sm9830651a91.15.2025.02.17.02.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:05:58 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH 2/2] [PATCH V2 3/4] staging:gpib:agilent_82350b:Removed blank line
Date: Mon, 17 Feb 2025 15:35:13 +0530
Message-ID: <18c12dd0f1a8f2c9cbf14ef8a8c70c6b01119e73.1739783909.git.kumarkairiravi@gmail.com>
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

removed few empty lines that were causing checkpatch script warnings

Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
---
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index 7936c7285d..b6871eb3c8 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -176,7 +176,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 
 	event_status = read_and_clear_event_status(board);
 
-
 #ifdef EXPERIMENTAL
 	pr_info("ag_ac_wr: wait for previous BO to complete if any\n");
 	retval = wait_event_interruptible(board->wait,
@@ -193,8 +192,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 	*bytes_written += num_bytes;
 	if (retval < 0)
 		return retval;
-
-
 	write_byte(tms_priv, tms_priv->imr0_bits & ~HR_BOIE, IMR0);
 	for (i = 1; i < fifotransferlength;) {
 		clear_bit(WRITE_READY_BN, &tms_priv->state);
@@ -207,7 +204,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 		}
 		writeb(ENABLE_TI_TO_SRAM, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
 
-
 		if (agilent_82350b_fifo_is_halted(a_priv)) {
 			writeb(RESTART_STREAM_BIT, a_priv->gpib_base + STREAM_STATUS_REG);
 			//	pr_info("ag_ac_wr: needed restart\n");
-- 
2.48.1


