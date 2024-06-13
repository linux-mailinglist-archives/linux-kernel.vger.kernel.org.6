Return-Path: <linux-kernel+bounces-213524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C91907669
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97E72818CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B892C14A4DD;
	Thu, 13 Jun 2024 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFo5zqrD"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024D3149DEE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291868; cv=none; b=Lp1o9JoG664Rkxy5egVfgYYTbtT9xSwivSA8LUtt+s4CcOBN6iKlDrut+aUcbqbppWpKqUKjflAsLaNNiiiw8KvK12XgTy5oeS5sZ8INBV1PY5beZ65bQ6EVK/aafvni+5XRsywlPLaC+/5Xw5ZcUqF0mjDQseFEuGzCJS3xm38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291868; c=relaxed/simple;
	bh=qQRjjZZws/Ma6VIvIPN2Ic4SkHiuVcNFQMuhJXO9qHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aP+mh1pke8btvpAan30tuhtrz1m0/jAqtlxD7wTMejPuEm0gcUMJNFEMVaOnz3j6PejQ9gMeBHxSNaDyMgslkHvf693XQxyRxgSHLzqDHfpk/tfCHpZhJYoDwYtaFKdRrqwVKwXAcW5nfFcWOC8wUGR3bfgKIXmYgQcW9xkgRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFo5zqrD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35f27eed98aso1076579f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718291863; x=1718896663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcEzKvcxuUEgSwRZ+SIVZqsXz/1BXJpqKsYkBURq044=;
        b=FFo5zqrDgJNpWzdRYMQ/mgNKlcQFCGcpH0ynanqlYyMF2N/WvOvRHAo94DSZ6dX8RF
         6JykYNaUATVIcphURAw55BzSE80Z9zdV484hVJQmzBykYVfzlZqpb13/Ngjtk2+G+O3p
         WOl1m2W4GXTJ9sNgUzhaCtPba7dsu03dt/hsPJ+X1RtJ0gT2nYd3HB8GLe+CnSfHrf80
         rZfZ4PiuoD1ttfww2eGBxK6wxqYpy9yh2U4KExDs6OcNTo8Bv45eIcINkxxEY31F1yXM
         KerZLnCPxlBImNAPWGrMxGLWTF7ZI+8YWx46JK7+zqPb9zWXxjk9HJhFhGwDZmzSvZjB
         OJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718291863; x=1718896663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcEzKvcxuUEgSwRZ+SIVZqsXz/1BXJpqKsYkBURq044=;
        b=TNSkW8N4e/X8MFAsiLjyewbzbmFiGky5McCMCD/tv2+13xAfmm9f/SrJUe9uHqs05n
         EgPOvLLfYLKIUND8BKqIq5OKVjJuJurVUPQyOYxkZfD028PuvSYL8tho/AqTcUdYmC5U
         ogsz5F5+IDJ/3W06gLHawLqr8ToD4IvVPOdRwU4xHONZ6hgi0ZvGGa8/n7SeQZjTegMh
         4fRkAVpcFTeIpfd6gnUc6RsMIqO3HyZGUnLmey9fHcG3Y8wwE9hNF/42HmGT0qzM0HCo
         rthdZ0TfXsxH8xXksmHEoJ7K/pM1CXUWmv+dME8IOzYGhVy+zzUtZR9Vg16QivIO4KTm
         JRWA==
X-Forwarded-Encrypted: i=1; AJvYcCWYEW7P5+fYjWcPVwJIZwQyqMPZfVL+8fUi6VaZzkULN0N5UIStmYdeObY7FhfC1oO9jyAwMHTmUBfTP/NtXlYbZW8rTYYakQkdNwCn
X-Gm-Message-State: AOJu0Yw2bn440MSNIHypEtkbV56Heks1D/xJmbaNt89MFcYDRlWS8Sjb
	uwx7VcTO+f9+MRuDGusl7bv/yCMocNAm8c2UX9ZpM9+/Z2VrXtSK
X-Google-Smtp-Source: AGHT+IFo365wIbaTyR5MvgPkQnOZIFxNKFkoeJy3PVoY4SbWu7nxToHLufTUlQJONnJUSagdq2ojaA==
X-Received: by 2002:a5d:6dc7:0:b0:360:7809:ff0b with SMTP id ffacd0b85a97d-360780a0073mr1253891f8f.51.1718291863156;
        Thu, 13 Jun 2024 08:17:43 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36076515a80sm1856978f8f.76.2024.06.13.08.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:17:42 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>
Subject: [PATCH 4/6] staging: rtl8192e: Capitalize constant RegC38_TH
Date: Thu, 13 Jun 2024 16:16:35 +0100
Message-Id: <5a64c076a932cd062587dae176418a39ccf8d19a.1718291024.git.engel.teddy@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1718291024.git.engel.teddy@gmail.com>
References: <cover.1718291024.git.engel.teddy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to kernel coding style, capitalize defined constant.

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 5392d2daf870..4863ced04916 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1752,7 +1752,7 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 
 		if (priv->rtllib->link_state == MAC80211_LINKED) {
 			if (priv->undecorated_smoothed_pwdb <=
-			    RegC38_TH) {
+			    REG_C38_TH) {
 				if (reg_c38_State !=
 				    RegC38_NonFsync_Other_AP) {
 					rtl92e_writeb(dev,
@@ -1763,7 +1763,7 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 					     RegC38_NonFsync_Other_AP;
 				}
 			} else if (priv->undecorated_smoothed_pwdb >=
-				   (RegC38_TH + 5)) {
+				   (REG_C38_TH + 5)) {
 				if (reg_c38_State) {
 					rtl92e_writeb(dev,
 						rOFDM0_RxDetector3,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index 863af8ef9f94..3add5aa933b8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -42,7 +42,7 @@
 #define		CURRENT_TX_RATE_REG		0x1e0
 #define		INITIAL_TX_RATE_REG		0x1e1
 #define		TX_RETRY_COUNT_REG		0x1ac
-#define		RegC38_TH				 20
+#define		REG_C38_TH				 20
 
 /*--------------------------Define Parameters-------------------------------*/
 
-- 
2.39.2


