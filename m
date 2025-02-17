Return-Path: <linux-kernel+bounces-517337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70617A37F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC7F3A2B92
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0175B217736;
	Mon, 17 Feb 2025 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLGn8ppv"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFA2216E32
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786767; cv=none; b=Cx5UWIF947WdGvHkC9ff5BHsEUBBIEeHzHNyuY1oPqOmjA0FEIgJCE7KjKd5HrJGcKXbaU67nO0KNX5cPKSZSh3DuOsafqY4xsg9acj4C3HEzeErZIVQ5+JDyKt8VCoLgMz4s4PQdTXKLyZtbuseqGO3UHaHXoMU6IOT6mCCS8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786767; c=relaxed/simple;
	bh=XO6uPpFukGBucmrCA20btnJlN/3eEn2EL2uIuT8mRyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZ2JCVIczrOcH6ucvLdGwAA0zV2QyBG8inlTLONC/LTUhaO8OIhz8J6Z3ZRa5MHiWZNnHkHy7UWgwsx8sDMHUd/rEPRYuM0zRPQR31qNlvbL2oFxpaSgwQAqaWTi3QnM+e9XJgtvO88tcGfCbffSzmHuqwv4nQeJhrS2dNBAq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLGn8ppv; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-220bff984a0so73532805ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786765; x=1740391565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6ix2sWH7fK+O3pMFw+ar4SRdhAMLkYoHd95tZujCUw=;
        b=NLGn8ppvgB5YRFEMx+lx5QKlN06dNxjvA0qdTFU3m6ZJqAdAWMfmvSnPPCthWfclv1
         HaqSsJVLxE7e9c86XWOkG5Y9oe5mwH1vtxNHyjDNLyDkC3xxO5zvWcbevFydbQSPTYFn
         EKkvTHumwh7WbyURItxaCjkHOwoPhY+7J++DX6Zq/yEsbGd9Ay5xB8I2IqM/ndDrY5bn
         kUN0rNNQtOGfKv33OPEF+nlIgxnMfwTijCDUeVyHDlH8hms5821lG3wG1BvfH2Dizsk/
         WNG97poOwBxcqE3K7AT7vkIt43IK5UZhR8irErKfpJ8dF60wVm/4Igc90p2sdzuyafmP
         RREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786765; x=1740391565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6ix2sWH7fK+O3pMFw+ar4SRdhAMLkYoHd95tZujCUw=;
        b=G31Dd0AStlr919eGhpLVbHf0masHYewFLQ+aeAc0wBJjXoCQsVS5rYgvfDrPr+f52U
         dbbwieLNjh9LoPzg2Bt89GLdwf51ae0bZwYrVGdezadS89nIpGFIrckhktI4c3HTRLe/
         yidE5dOBCN2pJL7Y+GrNQReO/NGW81IdBozu/2ZoGfrS56IfJJKNIpTrvAvh+BxVrbDi
         O82YxT8qF9Lu//j1elK4YnSj2Xi94y5/PzuVBFEp73CTtMKcC7LWetWXGxyoQBd/zN7y
         BBgzOICrl9KQWhuBAdxb4HIigxLQ7A+9BI6TJcpC6lA6eTPIosr6v8WTrLkCx7jdiKtW
         fGDA==
X-Forwarded-Encrypted: i=1; AJvYcCWfMI7xAlW6/ZXRXhy39hc7Kmd07SobHPceNIy80IeCbDpdH1GLUyJm81T+l2+Gwdm+hbP23aAcQOLxLMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPTsgyZfC3grEzYMGPlk4uYBcIjA2HFOHVbPa85EqOl+XjjG1b
	B+Q7LKGDPPfGXPQe4P7vb1P9SjkF3DC4madFOezaN2GR9YHBGb6r
X-Gm-Gg: ASbGncsQ5kA03S2IsGrokPddWVP6+Yp6tubMcDiqsPBY8YUvurSamJRCfV4DBS/w62l
	kY05jOy3Pl7kidX1HtZhbsq0gFMESpV1JER/ArQOOvQG9QaBuelTchYY1cm38n9G3rKDaD1m/GR
	NAvCuOg5uelbH/i1zT9nQ7ozyVwM0jwQAoVBObY3fdEzVtNc/N7OJKDVIEHa5QeOfMqpqEs9gCa
	e+8pz8N44nG5re9rA3v97RmL3+RkjwXAW+Jyg/uuVUR5+ucW89v9X0noFVooSELH8pNGr7wUv/3
	usRu7fekl3mUAIuwbhVg
X-Google-Smtp-Source: AGHT+IFbDOL3i6j3BURqUMS3ItFOJZ1h2qXrhvCIQnMGGh3yLOf0nB7QRnzYly5/+dLiERt90iYUoA==
X-Received: by 2002:a17:902:fc4e:b0:220:ecf7:4b5c with SMTP id d9443c01a7336-22103f16d99mr145753355ad.14.1739786765212;
        Mon, 17 Feb 2025 02:06:05 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d556f967sm67786555ad.162.2025.02.17.02.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:06:04 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH 3/4] [PATCH V2 3/4] staging:gpib:agilent_82350b:Removed blank line
Date: Mon, 17 Feb 2025 15:35:14 +0530
Message-ID: <20250217100526.49495-4-kumarkairiravi@gmail.com>
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


