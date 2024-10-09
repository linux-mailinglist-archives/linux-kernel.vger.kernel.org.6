Return-Path: <linux-kernel+bounces-356986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324AC9969EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52BF1F23BCD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16666192D98;
	Wed,  9 Oct 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nigIrqIn"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F083D193070
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476683; cv=none; b=CtwjPWuHGYGN+hoYY72f6KVwDEvaqjkaQ+bV6S8WkvA2FFGB+MHKvrjlY93mm65uuFkr83O0dh5xyPwm8I/Yg5s5hXw21FJirnLD8+OVCIlIAu4FtxDjEHr3ckuxpAJu0b5xQAFtjzHfJhUGhmpBu+G1c1EjCFOQn446Chxktjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476683; c=relaxed/simple;
	bh=yZhWSBJtmUTNXjyY2f7F7cFoIFKcQcQq1EsrXrxhduY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XX7lQ9v/4m09CsWD8FkeYEan0D7hmm6W314Qc9LF6KUMYe4/v5Iz7lTt+Ivyq9s3oud6HGfTWo338v7D+3HjaHhMFC6NhCVWw5LlnkFfbPgyn+giffZMf1UIwNyxj0SQ0ar0JRhc04avCVPH9AVgal4E4v7cEN66f4ndKcdSfLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nigIrqIn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e29555a1b2so943202a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 05:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728476681; x=1729081481; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pRO3w4YRlqmMfGpXpUyDIJ6SqFok++X3OxqH0iM6VD0=;
        b=nigIrqInokmMe7REnilGUwEdNeoJ7/1/nTioPqpzwAK09x4TccMEd52ahxJlko3Vvd
         d1ceusJmmgGA5wUrnPp+geBG2i+14ZeKAI+YPq8VW/fHo7NoopU9cxWxZj50RmucT4bK
         heZru+29KMMRt0JKYZAqyaJzbME+ve5a52ZRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728476681; x=1729081481;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pRO3w4YRlqmMfGpXpUyDIJ6SqFok++X3OxqH0iM6VD0=;
        b=QmSGMJYjacGbnnH9VOsUR4K6Pr7BMmTBQJ3f+vu5vIRZGM1jkWAD5DzYI/giU0kHeG
         oxyyVBKPmwQU0zZGDzH4YzSOyJPbXFZhN5gys/7ttaifZiJ9rnl/M6KOfhs6tGbVzKFu
         q1gNZ4VthKV2QdASC04WZSe41IjIZIXjaaLzoLiG7F3HrP1OWIY8qNU0Vh9AEsV5DBQ9
         JErum4iUufv6ad8aK5RSttnZma53y6fGlTlj3RZB6DfUswQYr8OrR1RdmMtlHSEGtCDg
         HMakG0ZKFVjS3coDilydxeufGKO1BegKQ0vOcyPEnfxz64bvZjr6ZRi3Q/CU+S+Z1Tc1
         gmQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU42aaeDHECe209lvjpcdGWbYDC9CxFBxtpwK3b4lSjuXJxMc1TMzTEqwxMULyarBt0plTZcBVsJC65Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAK8evrFySE/sEZdI8uuDcxib/U4PlboojTTEJuP0B9qvM06a
	WShNe8w581Ef6SbtSHg/TgUijOvH6YwtcbTqjnkNBR2aFEAuSGLrb1MEk+/CUw==
X-Google-Smtp-Source: AGHT+IFR4YCq8o1WMj3ffJCtaQfwQjZYacyrIHuI3arITE/z1DIhbz2Woh4iMhd4PpzwQxl9pH5Aog==
X-Received: by 2002:a17:90a:b10a:b0:2e2:bb32:73e0 with SMTP id 98e67ed59e1d1-2e2bb327553mr757104a91.12.1728476681282;
        Wed, 09 Oct 2024 05:24:41 -0700 (PDT)
Received: from yuanhsinte-p620-1.tpe.corp.google.com ([2401:fa00:1:10:bfd7:eb4:8571:b3f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a584ea82sm1515960a91.33.2024.10.09.05.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:24:40 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 09 Oct 2024 20:24:37 +0800
Subject: [PATCH v3] arm64: dts: mt8183: set DMIC one-wire mode on Damu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-damu-v3-1-1294c8e16829@chromium.org>
X-B4-Tracking: v=1; b=H4sIAAR2BmcC/z3MQQ6CMBCF4auQWTtmaGsEV9zDuCh0SmcBNYOgC
 eHuNi5cfsn73w4Lq/ACt2oH5U0WyXOBPVUwJD+PjBKKwZBxNVGLwU8rehtNtO7aOGqhTJ/KUT6
 /m/ujOGqe8JWU/T+mtibMM+NblHEzWKPpe0fh4u0Qm25IpZF1Omcd4Ti+yc870pkAAAA=
X-Change-ID: 20241009-damu-a3f2f3478409
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-2a633

From: Hsin-Yi Wang <hsinyi@chromium.org>

Sets DMIC one-wire mode on Damu.

Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Changes in v3:
- Add missing Sign-off-by tag
- Link to v2: https://lore.kernel.org/r/20240910-one-wire-v2-1-2bb40d5a3cf8@chromium.org

Changes in v2:
- Add fixes tag 
- Link to v1: https://lore.kernel.org/r/20240910-one-wire-v1-1-d25486a6ba6d@chromium.org
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
index 0b45aee2e29953b6117b462034a00dff2596b9ff..06a689feff52945d141d196d439cba034f25fdf6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
@@ -26,6 +26,10 @@ &touchscreen {
 	hid-descr-addr = <0x0001>;
 };
 
+&mt6358codec {
+	mediatek,dmic-mode = <1>; /* one-wire */
+};
+
 &qca_wifi {
 	qcom,ath10k-calibration-variant = "GO_DAMU";
 };

---
base-commit: 75b607fab38d149f232f01eae5e6392b394dd659
change-id: 20241009-damu-a3f2f3478409

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


