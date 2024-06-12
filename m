Return-Path: <linux-kernel+bounces-210862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CD2904985
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E0AB24A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BA936B17;
	Wed, 12 Jun 2024 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="iM7pffaD"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB461208A8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162558; cv=none; b=ANH1rzmQ/nN9HHjV2fPhy1Wjbhivtnk1b0aDfN+43GvuFxXORtjnubGKcBZQf5I6AiA/v0gScU7Td466FfcKbtqars3+Z4NvgljVVDqhZth8c8hsmyV8AejMa1bQpD0E2QSD6WTwUsu6sDZAvHaod0kjEwZcdFszGNS5MdGpQ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162558; c=relaxed/simple;
	bh=UnmB/RJmdXqhKRC4QCOmL/T/yVwrSMTmzh7khofAmpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XBaOne6S+PgTh+OBb55zWJO3JBSZrbKz+JExJow9EJTak2jS9DJevTMSOy8s4CaaknDAmMcWcuEOkJe+lWvMIwCHYwCkLkyrliJ4xTFzCGeddpMyedlmNSU4h1E8yBRZXudX3M3tQByKe73BgK0+ac6OnFcqPz/ebdtS5ubqgUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=iM7pffaD; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b9f9e7176eso2997746eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162556; x=1718767356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GXRj6n9mBHwLqddHwXCNNC1CDrIqC2G4HITZu8QmAU=;
        b=iM7pffaDvW/1wqHFaq4qpOWsFag1DBCJcByaabAxUeHUqMi031OChuUTKRoqFYSUL9
         WyJHjb89o5ZnE7z4kvryWf40ctgRxygWQAqPlO9b5+4ZmUPn7ypb/NUgZvWFb9nENlKf
         i1oR5i/tO1MuBFYfXnSYzpEOOociRDkSWozDuoviByT7URZJX7jIZc+lIGKQlvBTnNPe
         7/MrX6d/5sl6woxdCWXLcDuovOMFDLXo97iRYre8oSo6u483QMLxK//pYOnZCXtwX6jg
         PsMD1p3lOY9kCCe3ycCtferl0I7MAiAG4kVAcfx4d6BCiAmbTRkB2qLdc2DbQ6yMK+WL
         DXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162556; x=1718767356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GXRj6n9mBHwLqddHwXCNNC1CDrIqC2G4HITZu8QmAU=;
        b=f4bi2Sxxg7LZVbt1N3RFtFJzXURTOhYkfgG1oDfBN2aNyBwz/50tYxrx0RvLvQYjGj
         9EBhEqp9KPRruW+CVu0dGsJif9gazxusx98wiccYag84rQGGDDAF5tdUANzeJoEOUyMb
         fpMUvxcm6YE4+9rNUORFGSi2sA4vFg8xQz6fdcThLSGs2xbY1tyLKeMJAizs9psylfXm
         JuzMqDWGtOaYirVOl0zBrd5jo8a1tqOmiphHpXMli11omz9GsaBcuGyzrqbEHyk4Mc2j
         e14BR+lEMc5NSWxuWIhfphfuFgYcR8xiLCRRJ0iw79TQuPvd06gs9GUJq04wZWeOxkWA
         /wvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaKp7TVWNXTO454ZZTwVKtBIs5+TcksZFLgq5+JnLnR7D/5qM4YZep+nmpmpqny/mql2+BvU/ns+E/Sr6qDsOjirwWjih8A5vlLLgt
X-Gm-Message-State: AOJu0YwBw5EAgGeJK227jCUq3+qZcIe3frMyQ625bU/EEesJdi77NuMI
	mKj0c85tgLON2yqJ95uwKr/bFbsKCg9HO1ZFassZN/zg5HGy3fBK4jkpHRxQnlk=
X-Google-Smtp-Source: AGHT+IGaJkZgaXaAECx5apOGxtFYL2uPvtMgrrrC3AGi63URAQ5W2zli4XmPhP+FUKvhG0cr7tEHfg==
X-Received: by 2002:a05:6358:5328:b0:19f:4d0f:eca7 with SMTP id e5c5f4694b2df-19f69d29b4emr100263155d.4.1718162555702;
        Tue, 11 Jun 2024 20:22:35 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:35 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 03/24] Staging: rtl8192e: Rename variable HTCurrentOperaRate
Date: Tue, 11 Jun 2024 20:22:09 -0700
Message-Id: <20240612032230.9738-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240612032230.9738-1-tdavies@darkphysics.net>
References: <20240612032230.9738-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable HTCurrentOperaRate to ht_curr_op_rate
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Change
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 36a734ded7dc..e38cd0c9c013 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -496,7 +496,7 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 	ieee->HTHighestOperaRate = ht_get_highest_mcs_rate(ieee,
 						       ieee->dot11ht_oper_rate_set,
 						       pMcsFilter);
-	ieee->HTCurrentOperaRate = ieee->HTHighestOperaRate;
+	ieee->ht_curr_op_rate = ieee->HTHighestOperaRate;
 
 	ht_info->current_op_mode = pPeerHTInfo->opt_mode;
 }
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 46bc3561f56f..6dc641f78202 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1198,7 +1198,7 @@ struct rtllib_device {
 	u8	reg_dot11tx_ht_oper_rate_set[16];
 	u8	dot11ht_oper_rate_set[16];
 	u8	reg_ht_supp_rate_set[16];
-	u8	HTCurrentOperaRate;
+	u8	ht_curr_op_rate;
 	u8	HTHighestOperaRate;
 	u8	tx_dis_rate_fallback;
 	u8	tx_use_drv_assinged_rate;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 8856191a1228..360d1cc446d0 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -510,8 +510,8 @@ static u8 rtllib_current_rate(struct rtllib_device *ieee)
 	if (ieee->mode & IEEE_MODE_MASK)
 		return ieee->rate;
 
-	if (ieee->HTCurrentOperaRate)
-		return ieee->HTCurrentOperaRate;
+	if (ieee->ht_curr_op_rate)
+		return ieee->ht_curr_op_rate;
 	else
 		return ieee->rate & 0x7F;
 }
-- 
2.30.2


