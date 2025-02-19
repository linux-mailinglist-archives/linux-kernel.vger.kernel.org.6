Return-Path: <linux-kernel+bounces-520745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9AAA3AEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEC33B63AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD2F57C93;
	Wed, 19 Feb 2025 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZzO8HcK"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90B25761
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739927430; cv=none; b=HkwxRH4wNbPTj/KMmWtQ9kbwziO4Y9ydA28LSpSoSXD2rG/ZH4Ifm/NKUW4W16hziC8/XbF7F3R14nOOJxX00fGwFZPQZzEx6XN0vZdIGGFqidow9/VCQzIGTFWB4UVvRbaOY654tXmkFfjWKsKT1zRjoepS5f5WqQ4wF0QXp1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739927430; c=relaxed/simple;
	bh=bThHOLoDYNCT/c3Kd8PD/U/zp8na1Juu36KQmkq1IDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aQMICSOrSNrAwmbc+B3uBUnUYYj46fxdFfnRHwm6uDrLD6Xg/kbFUkMBU3cmkM5EznA6o38uowQ2U6rpnLsxJLWDGiL4XnN9jgxfOKzNzEhsglBt6vR75EzJB7G15gR2rLxDS5MTLjC6LVFz6lB5qrxzJBD4geoccg1j97C1gSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZzO8HcK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220ca204d04so84541985ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739927428; x=1740532228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeVTXMfIDDovR3x4Ig+1s3A5xB2XDG1KMxZlkZxO9T8=;
        b=nZzO8HcKTB8avZx0ONa3eIC3fxNWj5FYQrAOBvjGLXtNkVsTR6486GWMewwkTAbxgE
         Tryl0uN3JBzPlRSBkJ0cU/C2C5PwXAhKRMb4JpUu8sTu/VMsnznjqu8e6+ZF2nJWKZtx
         LYI5BGSHxAmT5UU1yLV1DeWqpDOJO5Oh9XQkMzCxAb+5k3g1p0l5WH7CEi9lqxrGqok5
         7aAk03tTizBckDQoKKEC7/jXQH1x+36TyERs21ASQYqRM/ORQZodVpOhg7cVTSu0iM21
         9NDDNT8Xr1wFI6CF2MwFY8lC/08kwXXRTrSh37fi5/4ty39qkCbC4EwvcfopF/bFtWla
         mKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739927428; x=1740532228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeVTXMfIDDovR3x4Ig+1s3A5xB2XDG1KMxZlkZxO9T8=;
        b=O4Nq1fZ5FmWW4hSaOJ7RACKR5LVNFi6an38zuHncOzB04LQJmxLnQH0Mc94WnMxCDp
         1IeC0aYILGWVOVhOv/odKv2gSZMcq06LtheYmWH+Lal95oUVpgxTh4BrFVhLHyaMPKkX
         ClOxdkppWHbZd/v+KRzSdeiYdGUzUt4mLllasLzVsIAdMcL/9TDbez1Mj4ykda8a2Jcc
         YJ6dm2b9iDRCzevO6xOpWri6Ot8o82QQpvoxIoYbp/9Eu4eZzoiTTq3V2+Wy38b4pmaj
         eSvVIwMaXPWLKttmb9MHaa+WVLLK38Z3bB03awg55vodSVLdJ/I7+GGQX+dPOC54KZTd
         zQ7w==
X-Gm-Message-State: AOJu0YxIsr4SOurPWMajEHro/1QoPywcTe1paFTj3XwFADORCYLjbKFS
	XzOkWySwIn7ShSsPEE8WXz1+Ws0fQRVDT2WAJBs7h3EZhz8o2AU3
X-Gm-Gg: ASbGncuH1hKhVTCApFW/kTlU0jipCRRqOTpRoY0hVgmYy3F/Ec0FIXPX3GgfTqZb0dJ
	bMcRMBm0Bf7jzVY0cDiRcizvDgRXmhK/NwlqROshzS0kRn+J/4kHCkKWNGD6jfnLuKsGdqrsqUT
	Spg1EN+F865gX7P9P5T+byvJimV7MDWFNXeYH0VN44cOMYF2DIJVzEVZQn9VqaN9agLBFhWJ9tW
	VOEZbZRYIXnH/8e7KgTC2jACuQQHIpz+19uo7ww6zznkQel6CyJwOItBSUJxfDGX7Y9CCiS4BDR
	UDh9FQ/rMp1BPhDoEbsWYIOzAA==
X-Google-Smtp-Source: AGHT+IGEy3Kh6gL34D+bhWUQUiTH6OPIOsHN0rcxloy4L6e99McE1rH+dwDpAVZD6Ph9M3ku+CTBzQ==
X-Received: by 2002:a17:903:2f8d:b0:21f:85af:4bbf with SMTP id d9443c01a7336-22170968d0amr22211755ad.20.1739927427950;
        Tue, 18 Feb 2025 17:10:27 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5348f05sm96080315ad.2.2025.02.18.17.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 17:10:27 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v1 1/3] i3c: master: svc: add support for Nuvoton npcm845 i3c
Date: Wed, 19 Feb 2025 09:10:17 +0800
Message-Id: <20250219011019.1600058-2-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219011019.1600058-1-yschu@nuvoton.com>
References: <20250219011019.1600058-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nuvoton npcm845 SoC uses the same Silvico IP but an older version.
Add a new comptaible string to distinguish between different
hardware versions.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index d6057d8c7dec..813839498b2b 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1960,6 +1960,7 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
 
 static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
 	{ .compatible = "silvaco,i3c-master-v1"},
+	{ .compatible = "nuvoton,npcm845-i3c" },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
-- 
2.34.1


