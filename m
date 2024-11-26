Return-Path: <linux-kernel+bounces-422019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 075659D9372
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1965283942
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B547719FA7C;
	Tue, 26 Nov 2024 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wicxh9TF"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ED214A85;
	Tue, 26 Nov 2024 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732610441; cv=none; b=tegaoJRlVFyQq+jfS4GJvkQC1oZYzudWJ1dE3/bzExCg+EHvj840IbU4Ys48t1b5qVjzJX5XBYge/HRVrecZHUqZ/INyK1nGDA1qiSOrvxqequcmsxq/BgEqRONZ1sQkKtL/TyyyT0dBaphxntmNajGvt2EyPTCjF38vaFxqNUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732610441; c=relaxed/simple;
	bh=im52ofJfMaEa36gxw2xW6upHKS6nnOluxIW11cB8dLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=idXwZW+gwOxe0dv6sg4aQ+FU0ASaHV87lRywPWejU9ohm/l0jgw9EPE+TtzGENqNtiHkqE83i78jUbj2U4AG0KCTxK4vVose9rG60K/+848Pc6kmp3DTL3ZGc58abDERbP+vZVA7cupX5KU5jikPRc1Y3Reg9KImi6uiFoKge3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wicxh9TF; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa52edbcb63so520612166b.1;
        Tue, 26 Nov 2024 00:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732610438; x=1733215238; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/Bw+2PlRnIQwQ+iTO27k1p9AWte1NAJ6PMnq9S4pJM=;
        b=Wicxh9TFXABjoun7c/C6EOnrdcvFSvz0IMGyIxDRtWJJlVLeuLyqXNljqFBrOYFqvy
         +RJO4rwl46wj3zQzwkbN4NReqA+bkpUJCijxyYFu2bvBCElZGaK1j8sBHogcUDHfM+HH
         nhrT80hqEWDkE6U0yKo1dW7sWYVgSdLLNnZHjNOlB6RBun2PjfZhDLkOys7tAT8y8MBR
         d0vji6OwTVt9QbeSWGaqamrE6Oq7eB+2DzhNLL4FCcex6gp6uN5zlYm1103c43jPDH1N
         QkEu5KTstlI6FFRVllL0t75cAhgAopjT8hvbS+pKS1sFLCn34zg+xAZtQK527EfMjrpS
         OpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732610438; x=1733215238;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/Bw+2PlRnIQwQ+iTO27k1p9AWte1NAJ6PMnq9S4pJM=;
        b=GCx2UtCRytqNGR4XyQxsk0hu4L1BF/nH6zyQNqGnVsJbLL9wj5xHBypaP83yQQcIf5
         cp1wZmMk+Tgq6jbcLtFCllgMMoIrINdy9XCS/UhaKWP352S3elTSEExVkrv69enA7Yhn
         GiNKbR+z2wcoLYL7iBpX4BBD0msAgfU2iP6fYD6AViDmsXtswKqYaKyJsDlDiDM7ZiGs
         c1t3/byrNgO1yZjegrBb/ztjYPRCUbI9jiGSKJ4BTr7xOpnwEVwsnqeaHUdkOhs82Y68
         o8JQs+8AGKIoOvenCXFs+5ZZRzuju66ngudJCXZnSbwKfcjnLJ88VE1dd8XQD5GhrJt2
         d7oQ==
X-Forwarded-Encrypted: i=1; AJvYcCULBReQitW2WpdDxDmf0bFt+pO05+uInj6s91730Bg3f8xv7mSg5nWXnz+ypwcudRHPgfwagPlVxludAns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkWVOHQGfzA/b4DrRSb6jqEMM+4id2n183EPKd6+/iQ4L9AEEw
	zQJmTn/x4ZkBZqT5KhluNkmihLzqGZPKFDlsBq5nXroLYHt1gTs/
X-Gm-Gg: ASbGncvu93ysn4OlTePVHA+ux5MFnmJUxkTjs78rx1zfM3wrAFk9D/ZYMfhk59AS5gS
	EKzY3FIbiyv7Go7ryIgrjCODoTxrIDC69PiaFk2sm/Y+Yo8xxqT1kvFDyQ7efNt2/BpATNTvE03
	vSubq+k8o7whpmgFuj4uVVuMdlizPCs1tejiNqSoaWDz94m/eZY28QrM3uqzX1RGYzTk2IZzv5G
	ca56OfTgojqgxWPR34MaGydxJyPE9gJ+AuKZT+ZBSQeTlzNdwcd/1lRuctQ6DhRq/3pL1ZEA3jj
	XG7uEsW9Zylcbg==
X-Google-Smtp-Source: AGHT+IG37AI1V3RV/fjUGE5+JBNM56JmpXjP3kYc3TpUpIn3l8yD++PJ/2k7LGMOCq4DC2MlLRuTHQ==
X-Received: by 2002:a17:907:7213:b0:a9e:e1a5:755f with SMTP id a640c23a62f3a-aa564869b53mr205286266b.1.1732610437440;
        Tue, 26 Nov 2024 00:40:37 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fd3dsm567865766b.130.2024.11.26.00.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 00:40:37 -0800 (PST)
Date: Tue, 26 Nov 2024 09:40:35 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH] hwmon: (tmp108) Add basic regulator support
Message-ID: <Z0WJg5MMu_1AFYog@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

TMP108/P3T1085 are powered by the V+/VCC regulator, add support for it.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 drivers/hwmon/tmp108.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 1f36af2cd2d9..85e4466259a3 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #define	DRIVER_NAME "tmp108"
@@ -331,6 +332,10 @@ static int tmp108_common_probe(struct device *dev, struct regmap *regmap, char *
 	u32 config;
 	int err;
 
+	err = devm_regulator_get_enable(dev, "vcc");
+	if (err)
+		return dev_err_probe(dev, err, "Failed to enable regulator\n");
+
 	tmp108 = devm_kzalloc(dev, sizeof(*tmp108), GFP_KERNEL);
 	if (!tmp108)
 		return -ENOMEM;
-- 
2.43.0


