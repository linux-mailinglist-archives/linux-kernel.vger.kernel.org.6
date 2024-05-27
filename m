Return-Path: <linux-kernel+bounces-190305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12498CFCA5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D0EAB209D1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBC4139D00;
	Mon, 27 May 2024 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNlZfRCb"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516238BF0
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801577; cv=none; b=I4FprBMDqTZcEv6lo95fLerz9DDPZEMv4uoNhmwJngbe8/8PN/9ANNFcE8O+x+MMU9bPtRn8O6nqwSbjM+WrGAz48naSqdLCRm7wKP+phkq4mnY6he8wtLNunAkmtMvtqdR3326D7j0K9b7XR7axwv9pGYZBqh9aTXv21Fl8DsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801577; c=relaxed/simple;
	bh=6s7QI+6FqcqfGbxcK5P4xjyA+PcrxGUxjsFcHwCZ9N0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m6d/tPs+yRA/w1raoKS/SrUcegyRkgEeLcQJRgcIZwDVv0Ims6ACIBFCSwfM5N63JkZTtWF/+9jWDHPKKkCDnN/3OQa1+2EGFnWyq8USWEmImwkAOblY6hiE9hCTVBq1Uulo3pFTRDbViYaf8k0Sx/81Txjd7LV4bX8gVRCbYLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNlZfRCb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f44b45d6abso24256555ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716801575; x=1717406375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qso6X8UxasecMwnu6XdFhpmE9Nh1v3UsdcX3ZS5Jc8A=;
        b=UNlZfRCbUyJuJZ7CkWTPMbpKxiCViRfiomLEvLhyw+0ZVcOfTiU3zBnUrA7cYYKRqV
         y3KB+BnCPbxtB8NNjM0Bd9YLM+wbJsFmCj88il3aol4yJTxxfitfDZrJ34Ww5NWxPioW
         ehtvNb7JN/OS+RxtA/nEf2lnMsODzVZy6UDPUJd9rdJN7qD4TUiZKzlbMstDN9x09de5
         jp5de51DY3+HxG7JOomGZe050rSuRvWkyO9O4d9Zyx82NyXcVyTYebOHlBf9hsLeEVgp
         Bri8EdSoNO+UnAKxNF0y6KHEKrqESFy8x6eDaPOl7lVoB/tLOuaAfX12CIs77KaHhQ+P
         btHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716801575; x=1717406375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qso6X8UxasecMwnu6XdFhpmE9Nh1v3UsdcX3ZS5Jc8A=;
        b=gNvHLOtaVJVz9k2COGUL2ojGxksxKVW/P2wM+wirLdHdOWv76NxF7myD+GIDN4anfs
         BfzjilOa12+/CH1qjKVonF+wcI3Yz7t9YNTMOcKPPsU5K/vqWFqvASVBt3DHj5x3RODA
         Nyl5RzxNixi/VhRUtCZzuox3kj/RSQLl2qMi3Aj/INGmbnvZUPmX4J7BIMWz1Hk1T96H
         y4D+4zVanszX7cJN8hU9gWDDlLNt9IlxTJo4322WlxwhVQblBrIPjFseb0PkTlawHJAG
         NsnHzDTvvADyUCi3K5aoIUgKfmvHFuyqjjM6U8w4z4o/dO6denWMwoamdIrepfWrHiZb
         JuGA==
X-Forwarded-Encrypted: i=1; AJvYcCWvbhKMVcuGSP+LxOUVHMcy7smEE7r4RTbj2YTEg+bnE3/oQ4LlbIHqadcVcM9L/p4utWYwnGLSag97vO6owIxAilokXVnGGDMNuRYH
X-Gm-Message-State: AOJu0YyOxX51eDml01FLSt198ePAEdyOJU/TeOlydWQN7irHTv9BT6wJ
	RgBdO9ftoKscOcm14bBoeKaGN0ZJkitthS9GSjbWiefWFADkBbJP
X-Google-Smtp-Source: AGHT+IFSmzN6RRxkbQ5XaFim0x0ZMP4GNcc36IWc7qrmgvH3e+4OZIBBobvdWT6hI3rajwlqbzYRdQ==
X-Received: by 2002:a17:903:2386:b0:1f4:9137:77de with SMTP id d9443c01a7336-1f491377970mr19086915ad.57.1716801575371;
        Mon, 27 May 2024 02:19:35 -0700 (PDT)
Received: from xiaoa.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c99e9a7sm57723745ad.216.2024.05.27.02.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:19:35 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: pmladek@suse.com
Cc: rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	linux-kernel@vger.kernel.org,
	fengqi@xiaomi.com,
	xiaoa <gaoxiang19870307@163.com>
Subject: [PATCH] printk: Increase PRINTK_PREFIX_MAX and the buf size in print_caller.
Date: Mon, 27 May 2024 17:19:29 +0800
Message-Id: <20240527091929.316471-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: xiaoa <gaoxiang19870307@163.com>

Sometimes we need to add our own hooks to carry more caller information
to improve debug efficiency, but currently the buf in print caller is
too small.

Signed-off-by: xiaoa <gaoxiang19870307@163.com>
---
 kernel/printk/internal.h | 2 +-
 kernel/printk/printk.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6c2afee5ef62..27a3cc11289c 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -23,7 +23,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 #ifdef CONFIG_PRINTK
 
 #ifdef CONFIG_PRINTK_CALLER
-#define PRINTK_PREFIX_MAX	48
+#define PRINTK_PREFIX_MAX	64
 #else
 #define PRINTK_PREFIX_MAX	32
 #endif
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 420fd310129d..2d7f003113f7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1331,7 +1331,7 @@ static size_t print_time(u64 ts, char *buf)
 #ifdef CONFIG_PRINTK_CALLER
 static size_t print_caller(u32 id, char *buf)
 {
-	char caller[12];
+	char caller[32];
 
 	snprintf(caller, sizeof(caller), "%c%u",
 		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
-- 
2.34.1


