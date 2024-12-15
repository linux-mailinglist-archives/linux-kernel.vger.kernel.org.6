Return-Path: <linux-kernel+bounces-446558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A879F2620
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 21:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1859116530E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 20:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9E61BD4FD;
	Sun, 15 Dec 2024 20:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOeg7ZjD"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A462110E;
	Sun, 15 Dec 2024 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734296216; cv=none; b=S5GKcQOgABLDULBJgq/ZCA8/jlCNYP50EU08IHAcq/Zs4+mtJL9w7TlIYdgIBiO3NfSyWlGOQFIcRFGuzCBMFk52bCtIocKzhE4gj1b2IEHdBgDSmdXgpmlPWWWQvgv8oX+mkqomgVRFZeaDygWVs+XWxOpPHQ0SxBuuOl48xFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734296216; c=relaxed/simple;
	bh=+Kg6BzgzbsVo1OYLi1Dlcmcc8Wvc1Y2H09vcVAIn0iA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=i0zyuOVpBNggFAvtRtgyZe5puBjA4J4X5wWsoj+WJJUUfsaf138480oZHjj0TqS0pRVUy2zo/77adEXwQfyET4tWH/CgIAZl+O46qyfR0ZUARcL5upCz6oLNxdBVsudNpxmoMb4tuRHow1739xXr812tP7t6AYO62qI+cDvU4VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOeg7ZjD; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a81a0277d3so10331415ab.3;
        Sun, 15 Dec 2024 12:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734296214; x=1734901014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mEZLQyQdl+5EdF/MAe4Nb6pKW7WliN/z4DBX2J62784=;
        b=TOeg7ZjDIiKAd5h9V42UxfnngUOn9/aR7fg1C7Gvg6NFMB8MfuqtJ5sU1z9/WLZPvM
         e1PTJ91sxPvEurE+Z10nmN9Wvg0sE0Pu4XCMUp/OSuP85bPJPc34hJ1AC95JFmDwbRy8
         NdXOtG0UM2/JaP13j7h5JT5R0NqzvL5OWIs7JWKoj3XSpZ5PAohI9DKnGhi1dZcC3j4o
         uCZfPHyq6b0EHS++jvN4HkSETVKipv65mDlDIU46gmPUJg1TpqzSeEZB6wyR6tZgZQag
         oNf+OJRaQSvUSbP56XQfXgVUB+1guvdjXttbg9uywOPQ7mh07JNyTTnBX2jyNR0vlBna
         M+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734296214; x=1734901014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEZLQyQdl+5EdF/MAe4Nb6pKW7WliN/z4DBX2J62784=;
        b=GxPQcZrOEMkGnASerKat3MRTOaffSz1gFKgdHu43iowC8+07m61cHJDmp/V/QGvqQ0
         q/QDKAqh1IfgpPkI365A+rD+jvZzX2dpy9KfbkuGV3fJT6nKOy26HhQpL/iBMDRgc1L9
         sj6U+NtBcA40yO856PwyRhxAh3ct75+hUbtfgxDchVLF5rRrGUaWsBI1rmQUcZjeCZMP
         LUoM1rxDBMG702Ed8lAdXvACd1S468Ma7lD62kuJXo5QxklLEIzdLuB6kw0H25CuMBTu
         QxuxdLpJOWRmjvjKRHH+CQrzKIIk2cwQUPr8ZTDj38HwphNzF6H+KgVYzoOWxaFegAdi
         qAyg==
X-Forwarded-Encrypted: i=1; AJvYcCWNn+Bu+cXLzizU8HhxNuX1ZVyAc448kn1Tmy+6yy++GANyQvaw9/E6HDc9LOyo3KtA4is55ONY5IgPz4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYK/tsB3j0gXfKVlH7XagHsY1/rpG8Y0Z8JV29jzg/0Imv6P85
	bVGDqamUdu0H3ZkdgRINy6i8hkW9qz3MrsGj2ztevEjv/wPr3pjh
X-Gm-Gg: ASbGncs/J3t9diCvtWtpAHXZTk87JRK/KOmb9wI1o4rOElL+Vstvo58M+8AI0ZGiMGM
	x+AeZbNPIA6/E2c1uJBfnuzlIzvRkvW3EXuPrGVOJVQkDiXuhFepMpmf+dM4WPaAGFZG9KJayXl
	8+N+gdVLA9FyF2IGpYUJQub10mxEp7zpCtSwV4P4CEhT45EXwjkW+UpamLAbgkikGxpw0m36BqT
	dt7KH9BIKq3Gh0r73DrU+45UP5IPAFFiPbaKLXE2izIqmkcg8UqJTEiacTyiWL19PKJ
X-Google-Smtp-Source: AGHT+IFQ8JpfQXantovgVbZyd3xPALNR7j8aoYAFRIyEb+Hfojj+09O8rNIMYJmuQJuTFSQLUEcFNA==
X-Received: by 2002:a05:6e02:12:b0:3a7:e539:c272 with SMTP id e9e14a558f8ab-3aff9257b10mr148768835ab.23.1734296214090;
        Sun, 15 Dec 2024 12:56:54 -0800 (PST)
Received: from localhost.localdomain ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b24cf3add9sm11739165ab.62.2024.12.15.12.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 12:56:52 -0800 (PST)
From: Mingwei Zheng <zmw12306@gmail.com>
To: gregkh@linuxfoundation.org,
	u.kleine-koenig@baylibre.com,
	aaro.koskinen@iki.fi,
	balbi@ti.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingwei Zheng <zmw12306@gmail.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] USB: phy: tahvo: Add check for clk_enable()
Date: Sun, 15 Dec 2024 16:00:06 -0500
Message-Id: <20241215210006.4114454-1-zmw12306@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add check for the return value of clk_enable() to catch the potential
error.

Fixes: 9ba96ae5074c ("usb: omap1: Tahvo USB transceiver driver")
Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 drivers/usb/phy/phy-tahvo.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
index ae7bf3ff89ee..0b8801318cd2 100644
--- a/drivers/usb/phy/phy-tahvo.c
+++ b/drivers/usb/phy/phy-tahvo.c
@@ -342,8 +342,11 @@ static int tahvo_usb_probe(struct platform_device *pdev)
 	mutex_init(&tu->serialize);
 
 	tu->ick = devm_clk_get(&pdev->dev, "usb_l4_ick");
-	if (!IS_ERR(tu->ick))
-		clk_enable(tu->ick);
+	if (!IS_ERR(tu->ick)) {
+		ret = clk_enable(tu->ick);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * Set initial state, so that we generate kevents only on state changes.
-- 
2.34.1


