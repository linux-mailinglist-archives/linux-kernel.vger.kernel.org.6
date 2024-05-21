Return-Path: <linux-kernel+bounces-184432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8962F8CA6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F4ACB2253F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE64D5381B;
	Tue, 21 May 2024 03:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="R6Hb/Fx/"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEC64C3C3
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261450; cv=none; b=HmJHXQlS16uDA2/sbHe63wXAUY0ojTqfgmV8RfZLdytw8JM/DAvXaY6+1JU2yLwRrF64ofIerKntbvPq0Qwm2nUS3Ll2UdZc45XuHCu2wEYnbh1kMckZr/ohvBx9V/DQzTa48gSEM9skSQWk1tF68X+x64P4ZEAkXnDN2jrHK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261450; c=relaxed/simple;
	bh=y4YjY+AojbIRMjK164jPJmgD6gUrucFooh+ClOh/re4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=howXy4l/v5GpvaT4d6H5+K/z1FO17irdKdia4asGi9ktw8cQYgs5Tor8FTjjApSDgefNa4q95IK6lWpJlAQeQXytEhpkJKP1R7gWpSkV2uOI/my/Cjy4gj5EOjq/eaH8033eNYthzmM4sgmA8tvsgdajX50GjzxpLz4Z3di4JFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=R6Hb/Fx/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f05b669b6cso92908065ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261448; x=1716866248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEthYODi4I2R9YSYx+IY/meHc3WazGs4QoUP4G2Bq/A=;
        b=R6Hb/Fx/e9uQgbbdCv9chBTeexgajxFA12hk8ewRjtkIois65R8Rm5Uo0wPI6ORGQE
         aSpoHdZOv8bFG5pNe+08GMC5gnf2AF6vBRvwophP3UNbQdHqps3mUSId21LZWzgeaKml
         IruaKWMoHfPJOZJy7YnsBPhXFs3LQu83tPI/2CN9I01BFtKLyOYboOhgaIQYdYSnaQJd
         MD8xq2uWiCwrD7ynTwBrNEPoMR6gsflfjpDAxnM1LSQPcEIskodNmRMRHupF1d3yeWOm
         SepAHKJEn/827tvgugfObLwBwrNAm9dV6UBzJro10XcWTR4A5z9PnHgwdm/T4uDaS/eC
         LrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261448; x=1716866248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEthYODi4I2R9YSYx+IY/meHc3WazGs4QoUP4G2Bq/A=;
        b=b/mpTB8lqdyQ0t2ZcPNPKBv3UWnnpg4rCxTAMhycVtLedxEVEwWeY8IMWj0+WHnxwU
         Gc5RDQRjSmKj92pG2ayAqjb8jgYuObPE4rPduHqJH3ZfWS4mqf5XFdnwtn12UhU5pKhU
         h9++QqWP9Vv7zfpPxyUzvmzjjU5sxuDuHedXYJxCuzxmPzyMz6gKSZx3peaOOCMTwhba
         8wCETftgpxvcB4COi15UCA9MIyc0Nl1vlZ42M4XZoooA2i+ziUZAVWV6Wkr8sqZfRqLs
         6Nv9AP0PKyyP8IrXeus2uEZ+3mS3H+M3fkOI0APAIv1KPVUO8N1EhKj7Lb3xF66h+6ve
         odBA==
X-Forwarded-Encrypted: i=1; AJvYcCXJE8vHnD8bFjRi5Mo3cebDIJPAdG18fu+aJayQGDJY9c5GRKbx7w+E40vszExUVnRfvtxjXgyNJ7RXG89UpFks75zZbhjbZP+iBM2l
X-Gm-Message-State: AOJu0YxXstn1KD0Vk9K1yafXDX+C3TQtYh4aGQd6xp3oevYczC6oSiyf
	FjsHXAovNQu0ua/JJDYPHVS4GBgkTiRmOl5Mk/ilVLXRkhP+o5qr3bN0v+2QFc4=
X-Google-Smtp-Source: AGHT+IE5In+DU67hMeJ+W7Cqy83Za6bcsr34N7BNepHTaCmbzXqcBBJbdgHcQWECMG9sAETxWRQbKQ==
X-Received: by 2002:a17:902:d488:b0:1f2:f566:8908 with SMTP id d9443c01a7336-1f2f566a562mr77412435ad.52.1716261447741;
        Mon, 20 May 2024 20:17:27 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:27 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 08/31] Staging: rtl8192e: Rename variable elementID
Date: Mon, 20 May 2024 20:16:55 -0700
Message-Id: <20240521031718.17852-9-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240521031718.17852-1-tdavies@darkphysics.net>
References: <20240521031718.17852-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable elementID to element_id
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 3722fc0cae1d..4645fe803a15 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -728,7 +728,7 @@ union frameqos {
 #define QOS_VERSION_1		   1
 
 struct rtllib_qos_information_element {
-	u8 elementID;
+	u8 element_id;
 	u8 length;
 	u8 qui[QOS_OUI_LEN];
 	u8 qui_type;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 19cb717df3bb..76389aef53ee 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1456,7 +1456,7 @@ static u8 qos_oui[QOS_OUI_LEN] = { 0x00, 0x50, 0xF2 };
 static int rtllib_verify_qos_info(struct rtllib_qos_information_element
 				     *info_element, int sub_type)
 {
-	if (info_element->elementID != QOS_ELEMENT_ID)
+	if (info_element->element_id != QOS_ELEMENT_ID)
 		return -1;
 	if (info_element->qui_subtype != sub_type)
 		return -1;
-- 
2.30.2


