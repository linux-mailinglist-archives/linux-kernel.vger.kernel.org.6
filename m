Return-Path: <linux-kernel+bounces-395929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE49BC515
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF911C211DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960751FEFCB;
	Tue,  5 Nov 2024 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W65A0xJU"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8631FE0F9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786133; cv=none; b=PLij6DXIu904R4p8p90rtTy9Q36QnsuAulXgUVvLu+GZ/UWPj/D6sqAMhBEzQ5W8k2f+dMiBpX+JhE5vBixlnv7jMaox1OL9nx9p5twhGdQgC54EWIIJNLuQaowsH8I+DUbMseoe9a4pHRkqWxc1Y23V8F1wcWzao+w9voAuZ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786133; c=relaxed/simple;
	bh=iZIgD4kf+Ww1++LYU44CC20JiDSdN10U4Ssr9cbPSMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlqGm+YmsCXuTw3OOKmVriTb5Aj3KaXSkmDN3yr2wKyLY49Zy3qz8Ldi49MF413oH/a/49WO7npYU6Ti7Ng4TFaS+gMRl65nSrbz07DzByQx440lLjqL5y6V4fbq3JavuhhTY+HKIanzmjTjMlpPnU+7vGdJfkOcChdRkf7VZo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W65A0xJU; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c957d8bce2so2568547a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786130; x=1731390930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6DCAV762f4pW99ALqAJAaS4UQZ7p3HFWxh9RdFODKg=;
        b=W65A0xJUo+pezcmcaqn+RHeE7MDgAoMo9vv8KVEtp3hYUxK8fncJO4WyaBI24Jm4ev
         TeNqKE0roHQwFkdTyZeGwC6IjGCZm2C44v0JJSdl/i9MdkxQfvCWmQ9pNd8BqFobdMj+
         HKzFHgHZiMI+Hiv3bRtQf2G2QDTXu+Me1mkVJY1ZK4lEM2SFszVlUIBXGAmzYTNCJJI7
         c9KC2wpp3aCGdy+UjBcjg8ZCZ3Ks+ozth6EXnRY0S5b6wzg+hBDoLNxWUoeoYM46x9Kw
         Mks7SMhXBO2Nl7Oj3jXkBmnCnQn5oFeCS+/ZWbqcDc2+RfiA7RlYLhnNp4X62T0aaPlI
         aE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786130; x=1731390930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6DCAV762f4pW99ALqAJAaS4UQZ7p3HFWxh9RdFODKg=;
        b=J6NFcjQ4Sj0FUILkVlp2c+8nLC3Ukig/Ks1kXcBj4JEc0yqnNTSq0m7W7ABlWZxBcn
         cVIjgj0It5WOlh7b9NSkHB/CJVsaebVeeF19byCgnGFmomeYjDs7AyQUm04vlvqVMH/r
         cAWq3N5T/w67/SlqruUeEIkWgMKXru6vgjQsORott/faWfUqBoQ/aFKkGrbBGLrQfjcM
         /NYANqumu9xf2eABaCbeiIFHKpmrBXbtxxOKtPgEd7gfz0jehsBm6W7DLAgOpvpI2gff
         l5GA6iZMVjIA0ovUzUEhc1RbnWELhp8YD64WJpi5dztRAqRvqyhR+dAKKD3vymgVqw1V
         79Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVMmQ/jwfGHV8AbOVVb/A1ckSH3X1fetBsNyJYep45xMfv70H5cpbrGT1y6+CTO6QbJnM0IO09MzwlPo3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiHZmSvuaQ4Fjngq24WcuOZRuithhx4Vr7lFOdqG05Ni0nNy3U
	wjvKA4S1BXR3X98gjLLTDXvZj7mSUqr9G/YUEvmWfDpZyYlVg/1H
X-Google-Smtp-Source: AGHT+IH/YeS/+k+7hcyK/7k8TRLFjq3T5fB/gu7B9YmbPIExkIN5JfU8g+Hyym43UCBxdmN4QRemiA==
X-Received: by 2002:a05:6402:1ed1:b0:5ce:df98:c080 with SMTP id 4fb4d7f45d1cf-5cedf98c179mr3143428a12.3.1730786129739;
        Mon, 04 Nov 2024 21:55:29 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb181451bsm78775466b.201.2024.11.04.21.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:55:29 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 04/16] staging: rtl8723bs: Remove function pointer set_tx_power_level_handler
Date: Tue,  5 Nov 2024 06:54:51 +0100
Message-ID: <e120c858d268eaae822ca0b582e453af06ef0891.1730749680.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730749680.git.philipp.g.hortmann@gmail.com>
References: <cover.1730749680.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointer set_tx_power_level_handler as it is not in use.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 --
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 283208e1de5d..f742a82d1e35 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1744,8 +1744,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->set_tx_power_level_handler = &PHY_SetTxPowerLevel8723B;
-
 	pHalFunc->hal_dm_watchdog = &rtl8723b_HalDmWatchDog;
 	pHalFunc->hal_dm_watchdog_in_lps = &rtl8723b_HalDmWatchDog_in_LPS;
 
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 2b3eaabf0774..ddc4c41605d2 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,8 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*set_tx_power_level_handler)(struct adapter *padapter, u8 channel);
-
 	void (*hal_dm_watchdog)(struct adapter *padapter);
 	void (*hal_dm_watchdog_in_lps)(struct adapter *padapter);
 
-- 
2.43.0


