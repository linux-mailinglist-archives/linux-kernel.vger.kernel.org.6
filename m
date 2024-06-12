Return-Path: <linux-kernel+bounces-210873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2F8904993
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770A1B2556B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4672208C3;
	Wed, 12 Jun 2024 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="dqc7/0yr"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5340F5A4C0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162567; cv=none; b=iKOV7q0pb+7bh0Qs2gisdM0qlnxh8v9oaL2JuGR1Mwr/m5i6oxdKihmjnEOhBS8Eq8Cq+1237M5z7obmalBTdV/G/Au/e+FjpdFRCkuFZ8YMYBJBYWXPWnmCVTdqp+a6HXkZdTckgUOfIytIGVwSLFnBSIufVQapofjWJMFYZWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162567; c=relaxed/simple;
	bh=zJhkNdPgm9Ule1PChKDhhPWqoRCFvb4zAD7FJ7GBYus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5cVEO8gtoclM9V6cemNVv2fzjU3+QCb1WvqHQmyOtsdqzXATSP9640q01aycKE5ljAh/7GJqEo01Jilh2cRFMj1eejx/I9lGI9DLdQkZjPZRkMhb9wDCMOInbvQhbn1vAjmGE0dnNDUpTw41xvHe/sXEXs1/ivL50cVD/67P7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=dqc7/0yr; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f9fbec4fd9so788203a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162564; x=1718767364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjAz9q75b4Ze8yKWVjcn/FNlgPRsBeKVRN/bGRj7ze4=;
        b=dqc7/0yrZEsf2SclgY/n9qvZryPZCB+ruOSnG5yh+CeC2u6HjGTd1zgqIGwt1dS7xu
         YXb83MFo+w0nxU9Nt/BKbkqVMb3lhaB/SSHPvvWZir6Gigl7pqFUyAhibZpV+wGOrIpE
         5m7sH6MeCaVOaO1bS2XlYkmtLuz4OOgwTgtJnTXENQg8mrctLhOZx87JJ9azHKPszZ2n
         HOVSBQ50kZrIBDvUoFN3RsIpG9XO3yuvnQxpxOWNcQ18X3nivGlsyyF2Zww6WxXy7Eq/
         N65vTGIEyqqu79w/zta2qIXr2svVPtcl1PTxj3P2V6uxJ/aS3md4XotIrvAYaTvhaCGj
         5FWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162564; x=1718767364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjAz9q75b4Ze8yKWVjcn/FNlgPRsBeKVRN/bGRj7ze4=;
        b=SmhzR08AM0ADrMRXoNLmqctF4zScTURm+yFIdL3IToHPpblMwVL0puUdKlYhJAkQAR
         0mIx7PelyaOh6AfdX33ns6HnH+2jAZKn/Zb/lPkP+h7R0TOn8otUiHhipH/zOc354f/W
         HHPjtYxsZWz7n7U7v58WghFg8K+s7GyjK08YTPvUS/TGMczrXtqnAnPhxUusA9nxB/ab
         AGqjgxZ0TMcF4zoL2xRz9h38a26p4HD5AfyZ7C0jqS/JPz9v2X5dyfhwtIVVc8J3tEey
         zVpOLkXMnoHqZFYkQEpsA9a24s5HoU6xIfMkec7hsiGKd2zi4RE8wxh4jarQaS/tuApG
         KU+g==
X-Forwarded-Encrypted: i=1; AJvYcCVfztls2kCRZeYh2+NtOvyDURDlL1tgjw6Ub8mOxkygJEmYaY8kb1kHfI9rvZqnBTp+5kr7sO3QP/4kYdTEgdPo8DbJ4kL6F10n4oeQ
X-Gm-Message-State: AOJu0Yz/u89aw23myEG30MK1OwOV0lA4h7NOXBtZkb426IuEPMfcQxuP
	vYQNpwAOOQCZJYAXqnTk3JhKVesixPTjrB0jXz8ZE910x4ObuaepU4+vFW2Jppo=
X-Google-Smtp-Source: AGHT+IHXzsUbD3hiUa31hFAFrbYvZNr5A8pj4kxldfs2e7njUiR6drW5I4rub3AOvwcD+2ZqiMa4fQ==
X-Received: by 2002:a05:6830:14cc:b0:6f9:76e8:15c1 with SMTP id 46e09a7af769-6fa1bf7ed24mr569978a34.16.1718162564380;
        Tue, 11 Jun 2024 20:22:44 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:43 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 14/24] Staging: rtl8192e: Rename function TsStartAddBaProcess()
Date: Tue, 11 Jun 2024 20:22:20 -0700
Message-Id: <20240612032230.9738-15-tdavies@darkphysics.net>
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

Rename variable TsStartAddBaProcess to
rtllib_ts_start_add_ba_process to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Change
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 7cdeca7ed8c2..ed6a488bc7ac 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -431,7 +431,7 @@ void remove_all_ts(struct rtllib_device *ieee)
 	}
 }
 
-void TsStartAddBaProcess(struct rtllib_device *ieee, struct tx_ts_record *pTxTS)
+void rtllib_ts_start_add_ba_process(struct rtllib_device *ieee, struct tx_ts_record *pTxTS)
 {
 	if (pTxTS->add_ba_req_in_progress == false) {
 		pTxTS->add_ba_req_in_progress = true;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 54cf5ee628f0..a35079f6dc65 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1770,7 +1770,7 @@ void rtllib_reset_ba_entry(struct ba_record *ba);
 bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8 *addr,
 	   u8 TID, enum tr_select tx_rx_select, bool bAddNewTs);
 void rtllib_ts_init(struct rtllib_device *ieee);
-void TsStartAddBaProcess(struct rtllib_device *ieee,
+void rtllib_ts_start_add_ba_process(struct rtllib_device *ieee,
 			 struct tx_ts_record *pTxTS);
 void remove_peer_ts(struct rtllib_device *ieee, u8 *addr);
 void remove_all_ts(struct rtllib_device *ieee);
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index d46963fe9bbc..6514d53c9679 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -301,7 +301,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 			} else if (tcb_desc->bdhcp == 1) {
 				;
 			} else if (!ts->disable_add_ba) {
-				TsStartAddBaProcess(ieee, ts);
+				rtllib_ts_start_add_ba_process(ieee, ts);
 			}
 			return;
 		} else if (!ts->using_ba) {
-- 
2.30.2


