Return-Path: <linux-kernel+bounces-331298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5062997AB0C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F0A1C274AA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52C115B0F9;
	Tue, 17 Sep 2024 05:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="mo2pVwtr"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F6B156256
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551126; cv=none; b=MSXnBZ9xPMQzuOJ8jvmvoVP+9hx87d9NvZ/IMTm8URqDcSdbmhgsQ3yIDoYCYpr5BwEqgrj9xQsbbvWs1gPa+xLuqt2B3BaX6CVdRqISn8whDwWHFcCflGt71KLD3velSPPvxhOweKdfHMr03OGozSr0a2lZDRNQswwWW+NXqIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551126; c=relaxed/simple;
	bh=1ZpytcgFRiHzmjOy4J7+IdFtedWgkkFzLBa2U01mfyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fz54lsEd1noUhfebNkSnv9QUb3I1c4Htr7VBeXuXDhUUCobHRObzC4aXzE50cyw1n0x3klxi4qRdPvyfk6uYY3lTXU9cECuJYbQbaSp1cLVH1zTzBZ6JQYsVmmOT+KRcDynxyJ97ispd2WCWf96q/vdYxmZJRHgJU6CSG/iSN0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=mo2pVwtr; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718e2855479so3818890b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551124; x=1727155924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUB+JecfnYMNvmsR8/Vhr8yi67xfZjHyzFp0HKa0zfo=;
        b=mo2pVwtrb0DMeSiCgdE3NBAhXOtZC9u2sKiDpB/jkz6YoCHNtV2MWvxm+JaOjdpaGW
         0dcYCY9h43SWRrER8EoeW2HWnOT95WsXUTHKIs7Ma3mFsEsqRIebMjBmmYz9DbyLwWSh
         MoTvS1/VYQijAvPp359wt3MK+dftgVWq2Bf0uZu79uMqu/67qNvLeLqXZ/dzZKt7cALR
         bFKlJaMGX57sSd3M5tAXuh/Jrz0bSYD3hDYYMpdbAHbvNWJh12p8iyQqaN7puf3E3uSu
         B7ggEjjVTUH6JB7CIMuPYehCxc42iQe13AHK1gis4ki6TfzWRwMVSdusOgDzh0U91eEP
         bZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551124; x=1727155924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUB+JecfnYMNvmsR8/Vhr8yi67xfZjHyzFp0HKa0zfo=;
        b=WB9nJA20tiGa+grxdGoWwQ8lkUzYYfCSrmszNZ1apyQPM85ViqAof24AonyawORmDc
         fn0dUJYTBNSlVstsvhj/w7OqMEFagFtiG2LHvlUzrqXrUN/Ttu6pu8rkbMQZxHHtNpnL
         EIzD5nViHW8uvFHVq34EgeQZvk06I4kcapByEYkMQxXW80Prn2P6SPf8saUWYrVB/ihf
         d90k2RuzmO9pja2XcHaSL7lktzvJkTJjwV/NvYCTB8QPOwUo9gB6zounku3hfwtQP7oL
         evoxn/KVMjKK7VYrOdGD4fEefl4o5hkAqlZ+1Q0eH0OibsudUrQjqXF24IEkXmqfz+r3
         c4JA==
X-Forwarded-Encrypted: i=1; AJvYcCUH7Iu5t55wiip2UFJRCreTNnpFGGBco80/5a54wobKPsos1n+gs8iNwEA9yaQCrYJaBdq4AXeAPchTInk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuzQuLUoYebXYU2LlSU+Br3XZDghargcKsSeT9V0gKoRwH+M7w
	gp6sqzp3CLCjdNPFKkIEcslALnj1Shhum2QPKnt/Lp+fzO/xuUFRhDyXXkE7NuHcSg7WXh7i5MP
	0
X-Google-Smtp-Source: AGHT+IFXwqocyNmAaCmmv/b4UvuRab091Ae92HvkA1VA+sLkrdbpYsUsYApZGFVAr35aYhQMT52yrg==
X-Received: by 2002:a05:6a20:d80d:b0:1cf:215f:1055 with SMTP id adf61e73a8af0-1cf76238568mr25753544637.48.1726551123623;
        Mon, 16 Sep 2024 22:32:03 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:32:03 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 11/18] Staging: rtl8192e: Rename variable Rx_TS_Pending_List
Date: Mon, 16 Sep 2024 22:31:45 -0700
Message-Id: <20240917053152.575553-12-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240917053152.575553-1-tdavies@darkphysics.net>
References: <20240917053152.575553-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable Rx_TS_Pending_List to rx_ts_pending_list
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 6 +++---
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 89092cd434de..efadb2b778b1 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -144,7 +144,7 @@ void rtllib_ts_init(struct rtllib_device *ieee)
 	}
 
 	INIT_LIST_HEAD(&ieee->Rx_TS_Admit_List);
-	INIT_LIST_HEAD(&ieee->Rx_TS_Pending_List);
+	INIT_LIST_HEAD(&ieee->rx_ts_pending_list);
 	INIT_LIST_HEAD(&ieee->Rx_TS_Unused_List);
 	for (count = 0; count < TOTAL_TS_NUM; count++) {
 		rxts->num = count;
@@ -384,7 +384,7 @@ void remove_peer_ts(struct rtllib_device *ieee, u8 *addr)
 		}
 	}
 
-	list_for_each_entry_safe(ts, pTmpTS, &ieee->Rx_TS_Pending_List, list) {
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->rx_ts_pending_list, list) {
 		if (memcmp(ts->addr, addr, 6) == 0) {
 			RemoveTsEntry(ieee, ts, RX_DIR);
 			list_del_init(&ts->list);
@@ -418,7 +418,7 @@ void remove_all_ts(struct rtllib_device *ieee)
 		list_add_tail(&ts->list, &ieee->Tx_TS_Unused_List);
 	}
 
-	list_for_each_entry_safe(ts, pTmpTS, &ieee->Rx_TS_Pending_List, list) {
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->rx_ts_pending_list, list) {
 		RemoveTsEntry(ieee, ts, RX_DIR);
 		list_del_init(&ts->list);
 		list_add_tail(&ts->list, &ieee->Rx_TS_Unused_List);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b0f01d940efa..c43d5b8298f1 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1199,7 +1199,7 @@ struct rtllib_device {
 	struct list_head		Tx_TS_Unused_List;
 	struct tx_ts_record tx_ts_records[TOTAL_TS_NUM];
 	struct list_head		Rx_TS_Admit_List;
-	struct list_head		Rx_TS_Pending_List;
+	struct list_head		rx_ts_pending_list;
 	struct list_head		Rx_TS_Unused_List;
 	struct rx_ts_record rx_ts_records[TOTAL_TS_NUM];
 	struct rx_reorder_entry RxReorderEntry[128];
-- 
2.30.2


