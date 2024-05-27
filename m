Return-Path: <linux-kernel+bounces-190371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0EE8CFD62
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427081F20F41
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7358613AA4C;
	Mon, 27 May 2024 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+PQh7Fv"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD3E13AA36
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803155; cv=none; b=Q5mOoD2dY1PKXl3y7eNGQ7+aSDsWbeNYde71zOpisgGfCpdXZCbxkyU1BXYH+MwJNPsGYQi0tTerfbefgEIvLir7h97q1l5eDRZJ5MyH7JFLzOFnmYSFnwXQ1tf/XHRwIQgrizNwtAIiNiHZkXYmU5ogAR5jIBx0AFjW3ujDkSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803155; c=relaxed/simple;
	bh=WflIQoeUamn8PO2OKh5VSMS4KpxPJy/grFXhGMPOAe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4pajSo3G8nZ/B6iRaxqed+pE0Uf+6kc2c/PuW42BtsgfislA2t70RDyHSQW8qq3WBz2Uobh2mWfsHZ28qKPmIsIKSOfAMA8NMUmwMnvaVQH0uTistoijs1adhNAHKByTdwxlER1IDSYGDMe0Dy39ovVYnBNTu+1oiuIJFzQSrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+PQh7Fv; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57857e0f462so2989207a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716803152; x=1717407952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCU3XZH1xof6IMBlikDcCMM2jat2Zoq5blIFKcFiWcU=;
        b=h+PQh7FvQTiBmB2So33JNq3mU2XCOVoWw//KXdvgv7PlMzb7BZBjxd2BSbxePmfeHT
         mIvMIx9y7D1pakRQvefhuDqeCSdzI16NQLeiWQf0LVw3bl0xEawxyZlYZjXPg3ibfhIi
         +1v+OgXybHVQULnK4brzbbdSkUy6mKQhBzEK4QTggJIUcleZvP9Rp2uqjl9P3Y9fte4F
         5E88vNOosEXxmJ4vTxU10gqyI5JOMlOr8rSzWiDjn640H1xRCoYidIbTRmvl5HwUCxWf
         kDeI5XNsBlWa6nxreNZzGnNuM2tMsA33+/q58ASr8lHtN6Ce3juWnQwTXVAsugJMTN/5
         OLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716803152; x=1717407952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCU3XZH1xof6IMBlikDcCMM2jat2Zoq5blIFKcFiWcU=;
        b=q+3xbd+zuMlPHLXHpzrzyspSOQrRbAxT61WGUFWqkibQW7J9pGAhG2U9p2eM6Vyoo5
         57u1YzLeOCZeuPbQIWd3YPa69izVCrmaI+LgQBJa5kSSCGSLzHPWMvs0OafWbma76nnh
         cK/J62TN/KguGKc9CodTUQ31MFmvILs7GUCUrM387iBNgBn/MQYjZ3o6T5ZJWuofYtq/
         1OXJMqmIYJ18FQ9pEpVXZPBMX6RSUZOh1S/E6l5/XVUGHSZRbz9OjTCLjoLZJpM1tTFv
         LttyS+JFatwR+Ds5QEHG/1gHckRkWptC7pYk3CysyKAtZf2Xf5cIWEDCZ/Vtv4fUrUey
         HBjw==
X-Forwarded-Encrypted: i=1; AJvYcCU92Kedeap1Cc3Wf8/uklSNuD8SWyyvj5/kdM6nwB+cYkSss2DteBUTSRmWsxW43/wXEoeo2imfxX8mgVFp0skI3+2efg9+Q6r0djbi
X-Gm-Message-State: AOJu0YwE+AqYpxH6Biy/x+WLJCU12L+pyJUI5gVuYVffO5IDFMBRizCE
	jLiIrUqLKAsZTffxKnm9vg8M2mQ1odzWj6GOjH4KtqEGhueK2DDM
X-Google-Smtp-Source: AGHT+IFCyaJZWTGFtwyvFpUuoVfenu2rfxpVDS9Di1Q0IN+mizrFBCaT9vyhskDyjLy7ncb8AVoMEw==
X-Received: by 2002:a50:9514:0:b0:578:6c19:47fa with SMTP id 4fb4d7f45d1cf-5786c195f61mr4100819a12.22.1716803152358;
        Mon, 27 May 2024 02:45:52 -0700 (PDT)
Received: from localhost.localdomain (ip-77-25-34-87.web.vodafone.de. [77.25.34.87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579c6c72ed3sm2304178a12.87.2024.05.27.02.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:45:52 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	namcao@linutronix.de,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/2] staging: rtl8192e: remove unnecessary line breaks
Date: Mon, 27 May 2024 11:45:27 +0200
Message-ID: <20240527094527.2046-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527094527.2046-1-straube.linux@gmail.com>
References: <20240527094527.2046-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove some unnecessary line breaks after '=' and '==' to improve
readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
Reviewed-by: Nam Cao <namcao@linutronix.de>
---
v1 -> v2:
Added Nam Cao's reviewed-by tag from v1

 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 24 ++++++++--------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 2fda44c5a412..5392d2daf870 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1392,8 +1392,7 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 				continue;
 
 			rf_num++;
-			cur_cck_pwdb =
-					dm_rx_path_sel_table.cck_pwdb_sta[i];
+			cur_cck_pwdb = dm_rx_path_sel_table.cck_pwdb_sta[i];
 
 			if (rf_num == 1) {
 				cck_rx_ver2_max_index = i;
@@ -1412,27 +1411,20 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 				}
 			} else {
 				if (cur_cck_pwdb > tmp_cck_max_pwdb) {
-					tmp_cck_sec_pwdb =
-							tmp_cck_max_pwdb;
-					cck_rx_ver2_sec_index =
-							cck_rx_ver2_max_index;
+					tmp_cck_sec_pwdb = tmp_cck_max_pwdb;
+					cck_rx_ver2_sec_index = cck_rx_ver2_max_index;
 					tmp_cck_max_pwdb = cur_cck_pwdb;
 					cck_rx_ver2_max_index = i;
-				} else if (cur_cck_pwdb ==
-						tmp_cck_max_pwdb) {
+				} else if (cur_cck_pwdb == tmp_cck_max_pwdb) {
 					tmp_cck_sec_pwdb = cur_cck_pwdb;
 					cck_rx_ver2_sec_index = i;
 				} else if (PWDB_IN_RANGE) {
 					tmp_cck_sec_pwdb = cur_cck_pwdb;
 					cck_rx_ver2_sec_index = i;
-				} else if (cur_cck_pwdb ==
-						tmp_cck_sec_pwdb) {
-					if (tmp_cck_sec_pwdb ==
-						tmp_cck_min_pwdb) {
-						tmp_cck_sec_pwdb =
-								cur_cck_pwdb;
-						cck_rx_ver2_sec_index =
-								i;
+				} else if (cur_cck_pwdb == tmp_cck_sec_pwdb) {
+					if (tmp_cck_sec_pwdb == tmp_cck_min_pwdb) {
+						tmp_cck_sec_pwdb = cur_cck_pwdb;
+						cck_rx_ver2_sec_index = i;
 					}
 				} else if ((cur_cck_pwdb < tmp_cck_sec_pwdb) &&
 						(cur_cck_pwdb > tmp_cck_min_pwdb)) {
-- 
2.45.1


