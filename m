Return-Path: <linux-kernel+bounces-207669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9F2901A63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25D01C20F32
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C7F28377;
	Mon, 10 Jun 2024 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="jc5JOGjW"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826E71865B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998543; cv=none; b=hnT4bNHIjgOGYhidwooTJBRFY0jEZ2J0cP/Rf1ykdy3BUQAs12G1BK6b/x/34BDuAQrXOeVWF9f5Z7/dBYymeeZ428pdHy6RurGcwnKbHz5GAvGEsKehD/S/9+SpFVT/6pZcphLi/MifyxO59vFbe5N6bfaCyFnGKO7LF8gKvTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998543; c=relaxed/simple;
	bh=zidFy4gIdsQ0BrGYX9heGZLqjVgFXnbJ+lDwEHU7JF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oka/vD2CfPKtoxOER6cfi9/lqJFz+XEtR3nSUd7XPtK6CvcWweu2HTbLHEjtjgDxJ2IHxJlG7Kkw+dzQbHeVz4CGYlYiogS7C2m3M0hx4ZCT9zTsDwpCfR9brmGU9AstBWlzDUz8b9Oq6ynxwx9UVdegYl1YjCDWRkL2At+eJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=jc5JOGjW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70432d3406bso745782b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998542; x=1718603342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8m+H7Lrb8URjJe8p9iiLZsUeYML//04IDlIH65oAHC0=;
        b=jc5JOGjW/WMTEIYORL8EE4djQbu2C70fAsqcifK/3OK3NuMIeg9AqMCorMlTYdwgEX
         1rci4wdwFpjjfRLow3i+uoWVriVrSJVHrtA9iU1dsPwzCRJNEfheG1N/afDy3EqIyFxx
         K0X+QK3Lvx2Z2Y6Jt0a3hE8bV0feqRyyZQN6iSTeg8h4MzNqmASZrgu/LX5Ea9XL+//k
         Mr3Qv1PbP04aOGoh6hN4S7lPXfgqCSPKRYEnlwn+QMyEp1m0gEb2vw3Z2rHgZARins8v
         cEGrbLJRkG7bmmL7stqO/bbkpNF8not4ZmnF9ziUWOGox0y/QQ+/EZeL6btV0HXCDq+b
         JCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998542; x=1718603342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8m+H7Lrb8URjJe8p9iiLZsUeYML//04IDlIH65oAHC0=;
        b=i57i5ySYbvODju1G4ANu60lX+XvT1PUZI0obUActw6okK49hOAkm8ooOOmze9RDlRh
         IT3b24InvjsL74VjsQjLYO3TjhzK1QKSB63rFr3KtFlp1Vb5PQRjPfDehKH9cdy2JReO
         zMDovF0TFbOVsh+y6IFDlgxDJJXNCAPsodtf9iRO7Bc+9To+79ebTtobBf7LMS/noU3G
         fodj8kIicpRtVaFU7MxMCnbDCy94shGYoz5uHmY7FMCmGNLnK/bUfRFdAkxoB8d6Yjjp
         teUIxlcJyB5TgSDheT6G6hO2xnySRC8HOT0FPIXfdOpBv2szniYMAwg7w/hLcj7koH9O
         t1wA==
X-Forwarded-Encrypted: i=1; AJvYcCV45+Ec57lctExh+aR1uk3/wA8xQaetczvKFE/ZvpugLG7YRWYKKymATygIpVCWUJghUzwpN+fFPoikwEKNciMg07EJ6ZscYdIFjoup
X-Gm-Message-State: AOJu0YzDBgb/KqiBJmTXxvzWz5wbEpCOugo50zFxM+l7NsTRUzTkildQ
	LiMF6UM0FS/Rn32etvHevO9XJrn28p7DVm75SWE8fnN995ua5WoE3+BJR2ynX0U=
X-Google-Smtp-Source: AGHT+IF90T4rG8JGt9R8y4hHU8+SENL4GlTfeRTYK1NjPgBpYQZPIAOzjbuHzH49+31xD/eDF/sQgQ==
X-Received: by 2002:a05:6a20:8408:b0:1b0:2af5:f183 with SMTP id adf61e73a8af0-1b2f9a2a048mr8814696637.23.1717998541923;
        Sun, 09 Jun 2024 22:49:01 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:01 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 06/24] Staging: rtl8192e: Rename variable bRTSBW
Date: Sun,  9 Jun 2024 22:44:31 -0700
Message-Id: <20240610054449.71316-7-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240610054449.71316-1-tdavies@darkphysics.net>
References: <20240610054449.71316-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bRTSBW to rts_bw
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index a305848dabd5..0131765e451e 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -119,7 +119,7 @@ struct cb_desc {
 	u8 bRTSSTBC:1;
 	u8 RTSSC:1;
 
-	u8 bRTSBW:1;
+	u8 rts_bw:1;
 	u8 bPacketBW:1;
 	u8 rts_use_short_preamble:1;
 	u8 bRTSUseShortGI:1;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index be8de6703e5d..8c9072538688 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -376,7 +376,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 	tcb_desc->bRTSUseShortGI		= false;
 	tcb_desc->bCTSEnable			= false;
 	tcb_desc->RTSSC				= 0;
-	tcb_desc->bRTSBW			= false;
+	tcb_desc->rts_bw			= false;
 
 	if (tcb_desc->bBroadcast || tcb_desc->multicast)
 		return;
@@ -447,7 +447,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 	tcb_desc->bCTSEnable	= false;
 	tcb_desc->rts_rate	= 0;
 	tcb_desc->RTSSC		= 0;
-	tcb_desc->bRTSBW	= false;
+	tcb_desc->rts_bw	= false;
 }
 
 static void rtllib_txrate_selectmode(struct rtllib_device *ieee,
-- 
2.30.2


