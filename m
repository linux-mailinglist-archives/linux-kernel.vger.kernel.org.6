Return-Path: <linux-kernel+bounces-213984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788D3907D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F7F286E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E9814B064;
	Thu, 13 Jun 2024 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVu1jITG"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99713B2B2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309791; cv=none; b=WQzMiFeZ8vJFKRzT+MdRAnbT9IMHhk4G3FiPZggGThwyrYBby7OUC9aVvqP7L0wgQMo04GuTiMx/laIqIe3QHq+1/gw/ed3JTEmlironY7t2KW1u51nPKYLc6pnvPwkNDyUnNMeP+me/uYhKaggWmVpqLxjL/YYQ8Hn9OZQViUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309791; c=relaxed/simple;
	bh=zN1UETXXdqrh3WBTxRV+3WqwL49VqCIOmitMRKZXlLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gpb87IDbh6bX/L2oizoZ00diJ5123WOI89Q0AFTSFKXqbvBdbQs/DeIPb3l5AechlHkwJUGlwMxWeBO5ZuJCvUl05OU+m90FVMKTo0rNKA7PmPXPBPFZWDfPh8TagXvTTk5kbPTFcaq6VmDqm9BphWk/Y6TAs0hvFiffM+lbh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVu1jITG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42138eadf64so12381705e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718309788; x=1718914588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BG0M0s1xfKWqVwW2SMl3OjEYd7P2vlsk2ol4M6/ryk=;
        b=PVu1jITGIxE49j21Aa1N6UrjqxcJx8Z3KR9I8oPj0f3D5o5MzuJ7VX3LwVcGe/Fdr/
         JEpau6mB5X5HXOvvWfiWkhmCrsio7yFc5Ak8uwi0DRhmmNBDxus+zksj1oikmiSvVS1l
         DpTNQyoHclXcf6oLUeDrLYvWiG9JYuTrgSMVifFr34r5Q2+Ltne9Vj1gU8mx4iUVqUAH
         BQ9H6ugHcgLgnu61Yn6/lMCexYz9RUmVH0mUz0PApTJ4ilcCGuCZseeOofnO7m7bAUj8
         xXOiaFLh9sx4TMB5AT7b0ApNggQRVTkohl9eU2BodHUHzRSs6+p4y+vIPlDyGhIg8u3j
         n9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718309788; x=1718914588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BG0M0s1xfKWqVwW2SMl3OjEYd7P2vlsk2ol4M6/ryk=;
        b=WyF2xxg1CILxs+vf77ofwbXJ8d+g1irGjojgsuvDOZL47eUnWCWim+J5khIO9kwncq
         1PV0w6+wVMVPgSN1nEIN8ZYMe4b092Cg6PSobtSTDLrZjGFkRR9Nz33Uxj6UL6xOv22a
         4fsuoxgie3rYWUrUKlbEbvwrdj3r+1CJ330e/Ljsz7d4B30NFMTudKmlyx4kVBbvvIMf
         cgIqwQgf9Veqcum8ap14OiBNuNOQglK+3S1lQRYwCNwN52ma4ocLUFbf/RGVjdI9bhjK
         mAaa6aGpqRshCqAhsu80Nhk78vDfFi6530YiZ0ddCf07Dp30GYWcih5XYwqrpEm7VU+w
         tFTw==
X-Forwarded-Encrypted: i=1; AJvYcCV04OmI2RRataUTyA4do6ax+2PRwvUsewddrr12sl5jxMQAIXUUSMRlNVelWjzuClhycu1X0xbzeS2puyjRFB/rZhKsNiCozxFFS01B
X-Gm-Message-State: AOJu0Ywl/UQ7RoWUe5M+xwcrQspce9Cni6lUsBilfeqDHYyHbW8FsLr7
	gPiuDu6sp1uF5DKEbji78pMzCnGWQ0f6hIr7mnB/txQKB2igftJ4
X-Google-Smtp-Source: AGHT+IEaJ7Ed8Sv5fg75UJQdq9VXVVTixwx6aZDvrX/K5bOwOehbhYmpJOCoZkoYu25P5zqQRZ6fbg==
X-Received: by 2002:a05:600c:1ca8:b0:421:7198:3d76 with SMTP id 5b1f17b1804b1-4230484eb81mr6933945e9.28.1718309788154;
        Thu, 13 Jun 2024 13:16:28 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de618sm73817195e9.37.2024.06.13.13.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:16:27 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>
Subject: [PATCH v2 4/5] staging: rtl8192e: Remove unused macro dm_tx_bb_gain_idx_to_amplify
Date: Thu, 13 Jun 2024 21:15:10 +0100
Message-Id: <5ee3df2b02a84e6aeb2d1c4903cb018161d78b1b.1718309120.git.engel.teddy@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1718309120.git.engel.teddy@gmail.com>
References: <cover.1718309120.git.engel.teddy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused macro.

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index 3add5aa933b8..55641f17412b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -133,8 +133,6 @@ extern	struct dig_t dm_digtable;
 extern const u32 dm_tx_bb_gain[TX_BB_GAIN_TABLE_LEN];
 extern const u8 dm_cck_tx_bb_gain[CCK_TX_BB_GAIN_TABLE_LEN][8];
 extern const u8 dm_cck_tx_bb_gain_ch14[CCK_TX_BB_GAIN_TABLE_LEN][8];
-/* Maps table index to iq amplify gain (dB, 12 to -24dB) */
-#define dm_tx_bb_gain_idx_to_amplify(idx) (-idx + 12)
 
 /*------------------------Export global variable----------------------------*/
 
-- 
2.39.2


