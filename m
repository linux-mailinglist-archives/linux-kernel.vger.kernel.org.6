Return-Path: <linux-kernel+bounces-419383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11419D6D27
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 09:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CFB2813E4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC3D188596;
	Sun, 24 Nov 2024 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KvlG8RPH"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC1915C14B
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732438763; cv=none; b=rCm1dsJBo0xR4b2fZxeGoesRgNf5RANz3u3iHnGGq3uQD41Le2SHxb1UzWZWZWoNWHRY1MIkMR0B8Z7HkXkq8izywXG6czILXOyjak+hTmwvTaUJIhaZJjYFPG+yj83k95D+6Rk6cVlfg825Ke7gA5TjC5+9aPXnHYCTwBW8wbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732438763; c=relaxed/simple;
	bh=sCFf8fnkrq9R7Lkd1c3bEfaiB1jb8kVcwtp3GOGOp0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVqcWdOrFt4MecFR58D27Lkh43BJ9lQruItKvINNebgtwpLgJQyOoLP9q71gDkrsZsgH33czoviV7GJoKpfyLRY4Vw6bCJ0qFDTYeU8mq7G/xhCHCDMfU04yAN1W+SQ3YivjjHc8mF7YwY1PKGckaKfadCa9b+zY1HXOKHKurf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KvlG8RPH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-724f1ce1732so748179b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 00:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732438760; x=1733043560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/IvUBcoipMDIe3/pYAHB/bcuEx/FUoQvLyB3GzlNVU=;
        b=KvlG8RPHN52xSXzJsiGpx9zW0hp+vqwzv5F9gojh8aNSHaeD3o8kmpukhAcW+37ovC
         W0RPEYAHvuFR6sKeJwUEL9tFYjfqwAu1yWTHppR12MefFzaQNvE+Igm/5relp38Kd1yV
         HkpxPL72DE7TMgXjBCYK/duN1r0OoH/RN3Ngs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732438760; x=1733043560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/IvUBcoipMDIe3/pYAHB/bcuEx/FUoQvLyB3GzlNVU=;
        b=VgBjmmr9LG4L8oKyabASIxeNuQJP9LYZtyQGN2nq50wBDsbgjr48M2MlBj/fKn6J2S
         FQo49iCjjhzgNorJZQJ444FcA/E9iGwhAwbL/Y9pvRKdFNMe+aiyR8lbqf+aFWYd1rec
         S+jYuSjlb3zvaqSOjKejlXpfFWfrUyhxxY9Ox+IEfeTDOeiyG9s2kLqQdmCAUEsNIenR
         9a84Bavmx6EJZ11cHQlPzVYW5hIw6vZqxyFJZpspQUtzPgVJ+m5STyc2NZUuXf5no0n4
         3O8EkLNTgh9ij6gq5E25I4coZV+/8CYkEi+U0W3qy70bQoWoPpjccL49vzPSf/k4CAm3
         qPdA==
X-Forwarded-Encrypted: i=1; AJvYcCUExXFRREbZHANCEm9KXPIwkWa7cZf17sid/4dGmAcUe3a0MjF14jm9wyD4580zviL4jBgeyuw8883nHB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgoKVfD2jMBgaZQFsLbZw2MyvY7bHrqbh38Wl717VS5yPNPIZ3
	I48CjJ7g+zaCir1MrXEehV1q+x/QKvJNPd+MKBcGphpZakha+zt3uN7eO2CcuQ==
X-Gm-Gg: ASbGncvWkEcYm6odbD8L4WTE1lDOWnsJgxtFcb3Xd8QDEd/feXtwcFoRyA7g68wNhlK
	0pXuDemqRUOtUP3lJyAnuDuBh7obe8+rOvIVSeF1d8ESIHmCBKi8mM9IQpl7INBtGqV3jOs6LPC
	IvmirLRWG3ylG/xLbNfg8E2sIyCoNGzgnMUmnL2UyDrv6m/9oq2eesESji1UPQZyZz2PGYXh+j7
	GyAMPlp65T8E1vvC/Q7XBuGlxJnZMlQL89PbKheDO3GvSvJua0Z49MSh+L7Ma9GG0TEJA==
X-Google-Smtp-Source: AGHT+IHfzR8ObvybrfM7pUctOZmJy+v/RQYyVAaGYmK6XbUOyVSBD4McBx6obvZbzN9dxMWFrAHZVg==
X-Received: by 2002:a05:6a20:9155:b0:1db:d932:ddcc with SMTP id adf61e73a8af0-1e09e452055mr9437889637.19.1732438760553;
        Sun, 24 Nov 2024 00:59:20 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:f699:9cb9:f928:9a14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcbfc4c28sm4465890a12.3.2024.11.24.00.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 00:59:20 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/2] dt-bindings: arm: mediatek: Add MT8188 Lenovo Chromebook Duet (11", 9)
Date: Sun, 24 Nov 2024 16:52:37 +0800
Message-ID: <20241124085739.290556-2-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
In-Reply-To: <20241124085739.290556-1-fshao@chromium.org>
References: <20241124085739.290556-1-fshao@chromium.org>
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
2.47.0.371.ga323438b13-goog


