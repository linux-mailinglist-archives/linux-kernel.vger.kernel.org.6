Return-Path: <linux-kernel+bounces-396195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3059BC935
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5043F282250
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168851D1739;
	Tue,  5 Nov 2024 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iOkrEqeW"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092A91D0DCE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799160; cv=none; b=q04yZhY6Bp5rz4dHXxMeSAmUrNoxim/T1CGf6Y5L/mN4cSbT4XjQDzQH4uxAKWTj8fi0be5RY/U2Mr7dKCq7gWJdnY2zXwYDG84AWytJ4/GGezi18D8v40uvIqSUikIoSKoCAFt4rHshTsnnTdor9s4HPT9fYYI1wiqRRw2/pRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799160; c=relaxed/simple;
	bh=dHHENdAfWTL+hOQ/FOqsDHimnTtrHZj1mFbutWtnio4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAAj9JTMe7wSgoipJk+MdKyuSA3rV6rqMPzwRcA6rVvrFpLNqyzxzfEIxkRQLPkVNEn9JH48OYHVB25wqRsrqcqM/PqxzQuERVAY9vRTgUDuFKFlgwSnniVqDTn8ZNgIhNmIkula2UixnntWI0cj9NZd5ZZTrcWJ9GLBYcwIA9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iOkrEqeW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21145812538so18530225ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 01:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730799157; x=1731403957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nnqa2pPYuuC5Cap6gt5UkBzeNS3a7p0T+6rmPXsBpW4=;
        b=iOkrEqeWvyhMZD4m28n5qyLKCKe2CqNkAAaKC82mILpVSomOIJcYFI67wee+ifF/E9
         mk723zjSG0/xP/DmI5Gl/Lq6mq+awdpznn7Q6B9t//bIQ3PwDWQP1vpiaw/MTJ5S23rd
         chCoWe+CCY0OyAhNFWXUtzcfFhYm7EJ4ZeU28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799157; x=1731403957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nnqa2pPYuuC5Cap6gt5UkBzeNS3a7p0T+6rmPXsBpW4=;
        b=c/r5Dg0CXWE+9xSqkyGkoNQAlDTx0aSe6/h0tUwa6J98Kc5MNW4INLUhfoH8jVAepd
         Bdd5T5XCb91ezIGs6Xlraq2+nprieF7p7dPGHQywb6DXq9zLWkIYlO12Y78z3oj6an8P
         pFFr1ikDRxKWsa38rt7Ahf44jihsEAhbj4of7209F8kJYXex9+mGJ/6x8WWNIB2bOV4Z
         KZdOuspOG0homClTaIYM77FUgllsrkhPNYmdwofSdlkHZkbvrZsafjEwzKQBpaPWHSD2
         WDpxzXKLEd39vgFhUOV/jg3YReQN3rTDoszZ94O0/a4WnZHANcNjbmZgLFobkDz17g9U
         AnPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXpJ1YM3V0UMudrT4gRzi1R3OOfscazA2drdgJoVlx8VhEWC3mfSduOtL2toShaOVGvBDZsY9dIYA0lDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/DKTkOe/h1hco6+RQLCxRdrdVGzkp49TKCu0tTzST5xmxboBo
	IPIblMxvYJh4GYgNkPeSXyf643U1DCaPb5UMpYiTNuPrCcZvawT8ej3r71pouRXgBuKhsI8Sr84
	=
X-Google-Smtp-Source: AGHT+IGOGQ1HZ0I0tBq/EN9OnU8jHABvUHtmvm4AuXTRezpGH+/Gkd1vzZSmZS+YuGC8dwHeP6ckbA==
X-Received: by 2002:a17:902:d50a:b0:20b:57f0:b38b with SMTP id d9443c01a7336-210c68d748amr489451335ad.19.1730799157354;
        Tue, 05 Nov 2024 01:32:37 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:20ee:3712:ce0b:1ed7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed8fbsm74149565ad.6.2024.11.05.01.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 01:32:37 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: arm: mediatek: Add MT8188 Lenovo Chromebook Duet (11", 9)
Date: Tue,  5 Nov 2024 17:30:12 +0800
Message-ID: <20241105093222.4055774-2-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
In-Reply-To: <20241105093222.4055774-1-fshao@chromium.org>
References: <20241105093222.4055774-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add entries for the MT8188-based Chromebook "Ciri", also known as
Lenovo Chromebook Duet (11", 9).

This device features a detachable design with touchscreen, detachable
keyboard and USI 2.0 Stylus support, and has 8 SKUs to accommodate the
combinations of second-source components.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 Documentation/devicetree/bindings/arm/mediatek.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d..4b68f0baf010 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -307,6 +307,19 @@ properties:
           - enum:
               - mediatek,mt8186-evb
           - const: mediatek,mt8186
+      - description: Google Ciri (Lenovo Chromebook Duet (11", 9))
+        items:
+          - enum:
+              - google,ciri-sku0
+              - google,ciri-sku1
+              - google,ciri-sku2
+              - google,ciri-sku3
+              - google,ciri-sku4
+              - google,ciri-sku5
+              - google,ciri-sku6
+              - google,ciri-sku7
+          - const: google,ciri
+          - const: mediatek,mt8188
       - items:
           - enum:
               - mediatek,mt8188-evb
-- 
2.47.0.277.g8800431eea-goog


