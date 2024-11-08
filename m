Return-Path: <linux-kernel+bounces-400957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4A29C1470
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2C21F2298E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E39D17C200;
	Fri,  8 Nov 2024 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecetJbNB"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B81186250;
	Fri,  8 Nov 2024 03:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731035436; cv=none; b=r79aGGouEFVRCtBeoWgY9BdOVVJ8ovAScqq45wWaOv6tLdu81bam0lGW51T3h6ILBJo0JhYQI/BQydYL6QFDZjw9qloaYEOHMATSVpwTxnGAix5mIpguiEjJpso1QdBgM8+KzA9vIlIK8f8sJnCupGcyn8Mcyxuzim0UPZcbu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731035436; c=relaxed/simple;
	bh=WghlnAOSQzh0tLET1EFta8yXK3KowjJJNyX13wL1r7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBkDEzFGWY0TawCFhaYC2CWmIIWhVN3yP1mkTM3ogW1bmYJ1uJ1ajyqrDaainJyFIBtY5WvDadYWv0vIGJjGn9yJkrGXaak39xFCMMbE44QL/SpkOeXrBHBfTKqc3JiddNuMjlMI0pZbSyrjFdMSxiZ7ggLPGR7ZNSUVTM3zsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecetJbNB; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720d14c8dbfso1511395b3a.0;
        Thu, 07 Nov 2024 19:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731035434; x=1731640234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORYNcgG6Ifk3psthlMW5Uyr0pn/PRohTUyRYk2R1thI=;
        b=ecetJbNBgDyAR0vdPTSg65GJNwls4+NGoSy7ZGorF9RWi8YfJm7/8Fdnz2IWHB08JC
         cHzIG22JT1dyzxnZj1QeLxqFC2Rb4O2ItQoogvrcckplgvGiZACX2In1dYDIwPQShvax
         dygsmO5eOJzeCXbh8S/4zGglUmhJzgqxuwRaqspGmB5PvQGF3XTObCVgIFbYNAT2xKxL
         NemfgzkjGxpvsvCYt1n053Ww6tucJkd8CFOa2nghgnjdVZXSKt2rSunC+vI0JMNwIK39
         +OyjmWoGqkDwDchTi1S9QPBTVE04O+Yjp+wbFi+QNzVEr+tB8/+cdLMUCLD2RHtUYuSA
         TaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731035434; x=1731640234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORYNcgG6Ifk3psthlMW5Uyr0pn/PRohTUyRYk2R1thI=;
        b=F5njmiQbg2euU5RofC1iJnfwkedqoRxCyVBAPQzlbCLrCZKMecFBCr6GDbZsAqOILm
         goR9WRLcmD3KHio0qZtbCH618CS0a8CXN2E/ziS1p7jz8a/zk/ZSxkPZmzLhCvcMyvL8
         z5DTG8+T1ozIXbLxWu89yOPTXgEsSb8xyx3cId3G5JvtE6W4dFXXmHta8cE00sIdFV3E
         Mz5OT/xC3iTQvGaprTk6paOSdE0NF2p+b6zEyDa9gttNrEiXHfTIgDw3kPhbO2LzwDQB
         TTqXeDPiR/LyIz+YfgGVSVjAa+9MqTJhh3GGiqxphuBWswF8JP6u/qDla+lUmZmuIRaS
         QBYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtjikfqzoJnt96/gRs23AI9uUFrr1GYPG+wrOYMJgpHoyDhJ1l1jJ+0r+sc/nao2G41wb94a9ba7yZRYh+SA4=@vger.kernel.org, AJvYcCUuxNPSh6Y9cvOh92Vhb/ALwi9MRA+kZgHzw0v97zKsjHkQq+13N8cvY22r0L72WbH5pnlyFqj79XJP/fA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeh7iiQgyLQYNfDoSHcrnHl0lNXeFDJ/OvLYE/j41K3qijJ/wI
	8iU4WZDe87+egOl7iRaWi/cybodgzdqvmGAs6gXTedAVOLN/N7en
X-Google-Smtp-Source: AGHT+IG/tsc8aqtowY57l4TlPxG5PQLRzQ4wphercEhISUtvJBk5y3JNAGZAE3F3yf4BUT+ovJgn/w==
X-Received: by 2002:a05:6a00:2354:b0:71e:60fc:ad11 with SMTP id d2e1a72fcca58-72413354230mr2066620b3a.16.1731035433669;
        Thu, 07 Nov 2024 19:10:33 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa86dsm2589816b3a.127.2024.11.07.19.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 19:10:33 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: a.hindborg@kernel.org,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alistair.francis@wdc.com,
	rust-for-linux@vger.kernel.org,
	me@kloenk.dev,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	tmgross@umich.edu,
	linux-kernel@vger.kernel.org,
	alex.gaynor@gmail.com,
	ojeda@kernel.org,
	gary@garyguo.net
Cc: alistair23@gmail.com
Subject: [PATCH v2 02/11] rust: helpers: Remove blk helper
Date: Fri,  8 Nov 2024 13:10:03 +1000
Message-ID: <20241108031012.335203-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108031012.335203-1-alistair.francis@wdc.com>
References: <20241108031012.335203-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helper.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindgen_static_functions |  1 +
 rust/helpers/blk.c            | 14 --------------
 rust/helpers/helpers.c        |  1 -
 3 files changed, 1 insertion(+), 15 deletions(-)
 delete mode 100644 rust/helpers/blk.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 1f24360daeb3..42e45ce34221 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -4,3 +4,4 @@
 --blocklist-type '.*'
 
 --allowlist-function blk_mq_rq_to_pdu
+--allowlist-function blk_mq_rq_from_pdu
diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
deleted file mode 100644
index cc9f4e6a2d23..000000000000
--- a/rust/helpers/blk.c
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/blk-mq.h>
-#include <linux/blkdev.h>
-
-void *rust_helper_blk_mq_rq_to_pdu(struct request *rq)
-{
-	return blk_mq_rq_to_pdu(rq);
-}
-
-struct request *rust_helper_blk_mq_rq_from_pdu(void *pdu)
-{
-	return blk_mq_rq_from_pdu(pdu);
-}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 20a0c69d5cc7..426b0d7f6587 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -7,7 +7,6 @@
  * Sorted alphabetically.
  */
 
-#include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
-- 
2.47.0


