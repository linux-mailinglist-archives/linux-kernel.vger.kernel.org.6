Return-Path: <linux-kernel+bounces-439176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E52D9EABEA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73ACA1887695
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A9A23497B;
	Tue, 10 Dec 2024 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LhFn3Y9d"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9B233D9C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822783; cv=none; b=PW1Ge2vtfxy0nNHigeloVqYjTlh2a7I+yiI5IRkJRA6yhp+J9ltp7A/8gC3FVTq1D8jBT+bnAWqh7S70Ih7FBuXE/6qm9UALIyhT3gjCre/tymB3KjwtbKYz4lXpSXyWgK6xvBoheQOAhTyqVrdr2lyvKROEIlCuhojL//EV+O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822783; c=relaxed/simple;
	bh=ND7nbSu15y+BqKA6VITHC0vli3cxNfnb8doilPIvVkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XW76xlK4Gpom7I30FOb4F1+nXtXb85L6nQkBgbI+ZIFmuWLXnsPf55AGY0bnNOlpy/X2kYhcLFQCJgdVCOxKwRfUkMTAzSOXntw5Da8wBKLcybzKHGTgEInYg8zrAdDxOFZMognHk1Jq+NvhqYaG6Y+HZ1wMvGFYLRKeV4s3A6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LhFn3Y9d; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21670dce0a7so7483925ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733822781; x=1734427581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7i5zNgyQQlrRDWh+0G6ogAAGEAyg0BmLGcSQLKBgfs=;
        b=LhFn3Y9d5s47kYQcv/etczjMVXMmMqOaTnUPWVKcsgtVSoQ5Phedz/loyNuHjwn02N
         /Pa7ey0knYiQxYM5HghM+Rez35bv52Act3iDRGQCt4SShsySaFjSho96sbxxYsp5F9WR
         A7LgfSoz27EEkbglIqZkOACoAGb9IGXZACIJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822781; x=1734427581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7i5zNgyQQlrRDWh+0G6ogAAGEAyg0BmLGcSQLKBgfs=;
        b=kI75FRE+NJF0/r+if1WPKAenaASIGOvKXNl+8ce68ebpQ7mQLAja9rHeFstuOOe2a1
         JlYVWMgywmoDS4vXPDWpO7m+ydvHyQ6pKHJQKyJ+2rKyglu0Nmy8gHLTTAqgxZCovNO5
         Bz2gqKrIYSclUqAf9hWd6rjqQWChJwOw+LnuJGi2IFCf6dMIxrT3LDJDdyZg3LuJNKXE
         KUExLPpO/x1PlU4fqczo4Wbqz8kq7awZ1k7N3owJF49A35n42zNJlPHmAXF4Q6zylweI
         j/rbQI9Wn1aw5rt3zHqN4ARaN6533ZT0bqHijTnHRHVos4+CVcoAECCcJL9zMdmvTeVb
         CnZw==
X-Forwarded-Encrypted: i=1; AJvYcCWgQujuFi5UCZ7HYGOTqv4to4ejUxy/auOJYu1IavNs3JIS5RNR7X9PlOhJOz0fvrmLRkjvZCUwjiDecoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdPL/ZdT0rXCVDh4S9ogM9MjUwlshNKSQyV0P3If74ZvslduVA
	WvGPdvNi+kXEP2PZEIlzJG7zPrRVnRyUEk/p/AlioaHbFEl3A6DOIW+Mgz8f9A==
X-Gm-Gg: ASbGnct4jg58q4/NgyOJuwOqscz5A+YgP1mqYn6Kl+ihKUnYP1HWxKh6S9SJ5bs/T0D
	n6he20i7LJrgDLuENMSvACqXFoIQDoCG8Us7IPfmkpiLHAskJ9BkgsjsVeBkNNa1Av3j7ck/3Ay
	J/Wl9r6vWeplrFOFzA5MT7stnFDuUGvkmbJbTpAWenWVKPjGgWH5BOD3cwifCIDcDemEtc2WVtl
	/Dnw/mfX+ExRbKul4WpiwG4dJU4rWQZjxt8tZ7vkPUZ2wza8TyI4H3ak0Tq7RWCnkCHNje1
X-Google-Smtp-Source: AGHT+IEbVN3vePe7Dj1LS50n6Z7qkx2DIp+ZHcNP48MQNc9h/O+CQoe/H6Q2j2soGp26ZPZFTYHuQg==
X-Received: by 2002:a17:902:ec92:b0:215:773a:c168 with SMTP id d9443c01a7336-21669fc68camr66076865ad.1.1733822781417;
        Tue, 10 Dec 2024 01:26:21 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:89ce:2db9:f7d5:156d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21632c4fc62sm49006905ad.194.2024.12.10.01.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:26:21 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: mediatek: mt8173-evb: Fix MT6397 PMIC sub-node names
Date: Tue, 10 Dec 2024 17:26:13 +0800
Message-ID: <20241210092614.3951748-2-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241210092614.3951748-1-wenst@chromium.org>
References: <20241210092614.3951748-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT6397 PMIC bindings specify exact names for its sub-nodes. The
names used in the current dts don't match, causing a validation error.

Fix up the names. Also drop the label for the regulators node, since
any reference should be against the individual regulator sub-nodes.

Fixes: 16ea61fc5614 ("arm64: dts: mt8173-evb: Add PMIC support")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 511c16cb1d59..9fffed0ef4bf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -307,7 +307,7 @@ pmic: pmic {
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
-		mt6397regulator: mt6397regulator {
+		regulators {
 			compatible = "mediatek,mt6397-regulator";
 
 			mt6397_vpca15_reg: buck_vpca15 {
-- 
2.47.0.338.g60cca15819-goog


