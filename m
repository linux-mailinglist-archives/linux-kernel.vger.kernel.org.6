Return-Path: <linux-kernel+bounces-353424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A29992D94
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33C328169D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BC01D4326;
	Mon,  7 Oct 2024 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mUKv0TWD"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6201D27A5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308470; cv=none; b=r7u7/yiDD6v4NM2nLSB5KzizsGlky2meZnHKhfQ+5aW11xtzzt8Uywy8Vbrn4Wb4fg8LbkEzvC4Vut5xstcxRIX7lENSpMOUZZb0Km9ayWt9AnqI5ccq2HuvSOXeN9kN1KybjgJN4U7iF/71regENp3EAVcyMk3eEsej8cEX2KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308470; c=relaxed/simple;
	bh=PmL2xXE8BnzEt05PC++iV4GvglcxASXwdgQKwqxjv6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kukt0Lk09uUuQyIn2PmO7RHU3xgx+WeNc0rRGUlQrefAsyzfGt1vAGhDnySL15aXXAcQg3pXndZfvpUTNplsj5vmmW+P6sCPQCpR4PmqvcBdy7uOjwcuYAqtcNHECBNbCR0MYmCaeUyFjx3za9UsHRm+4gzNUPWiwc4qud7QbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mUKv0TWD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so38377135e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728308467; x=1728913267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=18IwUzJqtKG/CgmSwOnapNoHLokmBRx3kK5mOETO+Ss=;
        b=mUKv0TWDQWTnKCHNcSpMghXXqupaEfZ8UBWGpcnIAuJOEcCqEH/9n+UO2D0xScxhL0
         fJaT4OhpVtzFWd4wi5LfISYVWzdSEwEoQRtZZ3Ta6TkyXgucMpVzqDiSg5Sm9TwWVExp
         GFdFrJgBSWFJHPPZEKStQlbf9PObPGKBuHVPmkxFvtBaIJR5XvxtvYXLkHESse8omHQ/
         EzjCAHWEG3Z23iEO7vY0wAxPJx4DnHSG5WmvjL4C5pr2e8SvJhZjm58HeoLLPVnA3+vV
         oYSyBGi/GWOvRPHQlKl+lLGByB1xwIyxIauEwodXPP9n2x8/E2doam8Gd+sNL8/xdPZ7
         Jk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728308467; x=1728913267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18IwUzJqtKG/CgmSwOnapNoHLokmBRx3kK5mOETO+Ss=;
        b=JEwXAEU6oI7VsRVFZVJYAnP6HTq9VFIfbPWVMHJq31Izd8DUA/JcUYPTpiwnt9V1AB
         Z6wb1zerVz9pdgGUmTrWjoCbuBGK95N668nUm090H0AxktLB3cV0GRYTBM2hydFQUuu0
         MKc64TXSM2sBDxgfvyCK1WVlO200w8hHfONhhBoL5eGSSALD45ejgyv/u2KvONagHdfQ
         4Oj6J1mm63bhREBi10nJEF59ebnld/4Y1JyyV0E8Hr5MFyPOdi0LC7PNe7o5tog1t+pQ
         LNorqH0mNQreqkuUMVgXotlMLz+HDREk38H6VCouyHE/3xD0bif6lBxpJLkX6yHkhCn/
         aB2g==
X-Forwarded-Encrypted: i=1; AJvYcCUW0YBkTa9llGat2LBIfbNjsBx96kofHJZJ3GYeOHdCrAfKVYJtDybFJ7g6EyCoE+uPklMmRMukmev4EuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0IC/rsov3FEeD54yejrOU7w5qIZOv8yAjN/Fq6sjgN8H/mpp4
	Rln1fupSTqUVvHOLvybpKv0tOX3gb7ZIQ/2PJcgV/CS9lXTLEa6n1eeGxvAq9Uk=
X-Google-Smtp-Source: AGHT+IHn9j8gKlTyGUNL6SJnMg/6TE1OAWoRwNw/fMGqK5wfF55HTcD6FZceAL/RR9mRJBsXvzpTrw==
X-Received: by 2002:a05:600c:1546:b0:426:64a2:5362 with SMTP id 5b1f17b1804b1-42f85ab4746mr83561765e9.8.1728308466852;
        Mon, 07 Oct 2024 06:41:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f66csm5765373f8f.13.2024.10.07.06.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:41:06 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next] net: phy: smsc: use devm_clk_get_optional_enabled_with_rate()
Date: Mon,  7 Oct 2024 15:41:00 +0200
Message-ID: <20241007134100.107921-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Fold the separate call to clk_set_rate() into the clock getter.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/phy/smsc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index 150aea7c9c36..e1853599d9ba 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -627,12 +627,13 @@ int smsc_phy_probe(struct phy_device *phydev)
 	phydev->priv = priv;
 
 	/* Make clk optional to keep DTB backward compatibility. */
-	refclk = devm_clk_get_optional_enabled(dev, NULL);
+	refclk = devm_clk_get_optional_enabled_with_rate(dev, NULL,
+							 50 * 1000 * 1000);
 	if (IS_ERR(refclk))
 		return dev_err_probe(dev, PTR_ERR(refclk),
 				     "Failed to request clock\n");
 
-	return clk_set_rate(refclk, 50 * 1000 * 1000);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(smsc_phy_probe);
 
-- 
2.43.0


