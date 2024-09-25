Return-Path: <linux-kernel+bounces-338221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BDB985502
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17A91C23631
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AA1158DCA;
	Wed, 25 Sep 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1JO5XepW"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5541158D63
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251455; cv=none; b=Fj1J0mpxB/wHILHplUUwZXpwRGqqYcT673O+e6Lp3k1EwJRA1tspmPxtXri2iQ4Lbppk2AgmMEgBMYCMZwqFrD3QfIqlAE85/3N8nNGNUqNDp3WfbYHte/GQGn3vQsqmIgQDGfTDupCYCgUzI6jsNJ6eXlSiWThZlwPk4bIwR/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251455; c=relaxed/simple;
	bh=T8wQGLQbROu2UjEMV5tTMSwRI/WmSUT1QouVCIQlt78=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Jhw0toqT8unOZTgkHRbThJnd5we9kyEACRNhUTvUJzAFvN/UQSPtTa4VbLlMShv01hfxNNau8tCARbfA2GYJO70FCuYtwzvVVCoKaIpCMmBfIwwMpoKYBQ/czonFT6nz9+G0UpHZSNBs8W0836VEPbJs9J6t6mvpHEVHKTyWEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jakiela.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1JO5XepW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jakiela.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035949cc4eso10135615276.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727251452; x=1727856252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RpI+72pqCUKa6Ph4QBKiGKr7w0qM8RBrdylhoit18tM=;
        b=1JO5XepWfOS+Iiflh9ZxW+6qj8NfSHtcUUl0aYn3Mx2oioOsU9FMr6T0NotVNeOB1b
         xLIQJ38UFjNHO7CsK7ABWhdK8khcNoYe1nJ1gREpikjgAd+kWxpAGSIosEgSla7uR9h4
         9x2HyrPfLE8YkWyU9aMH6IZoNWboTU3tpbvegIj2GYFyoqnP0Ac1r59Q1nAwcoR/DMnJ
         H/81iBzqi0nKIh7o0bkVaNy0Wuv0Nbdj5rHJqUQ0gQu6CppDtinP174twp3uFzUSHzVd
         0KKwgc4GeMKOQOusokJPd2uzut0ApO9edK7JSgUXi7hM2wYPk3WeXzy5oUD9pmi0M9/n
         O+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727251452; x=1727856252;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpI+72pqCUKa6Ph4QBKiGKr7w0qM8RBrdylhoit18tM=;
        b=ViR1QwlAFKObTZYOkwsJbXOpJ1asF5FOiA19Y9Era2MM4Bv+wbxuqwSBelRYg3KOqT
         OnR744hXIIeC02eo+Hah52gdYLCJ6sohlnb89QpV7jmah9vi5nps2mob+2c8JSX9YfLa
         GtbaVAm7uUVzNFqfOLbrQ7HYna3ur7+NGQ7dkDnmFY2JJL3cepN1VYbZfXj8dPm4DajJ
         i1hNm1+fteQCITCKZSPCzShdGkuKK8H4G5JWhAWE1E2JT3qCBLYXXJuWIz4/08kFGkuB
         J2b8lIu2IKby5mqdylujvEkO28NkspOPEHuB2rDf1Pq3rIPaotiRK6yg6S7Ijm+Sl5oy
         Efww==
X-Forwarded-Encrypted: i=1; AJvYcCVLvwyI5+WbN9HhQgtgEgKbRBwqQf4EJxzsfIQZH27gjfJd6TSvZ8l3ikiA+TYZ298PuAT2f4o5HAVvyI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpcnb9APM+cTq9h6xLgG59ybpzDd0BNqTTFt+zKLV4lP+pVcVL
	ELMg+WN99olYv48JlxEglbjxaKA1amYLuE9SdmijyeC7qxJu/FZ4MgPcN9F2syIyUKfiS3X/pXL
	o3bI90w==
X-Google-Smtp-Source: AGHT+IFw0bYPHUqMq0e7EqXrAe/PmOO/o9gXTmryzs8osv8xXCpAe3duc1gxJ6QGosYWIIQYVmnDKsUKdHGX
X-Received: from malysz.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:a1e])
 (user=jakiela job=sendgmr) by 2002:a05:6902:1782:b0:e0b:958a:3344 with SMTP
 id 3f1490d57ef6-e24da39b0c3mr15148276.10.1727251452579; Wed, 25 Sep 2024
 01:04:12 -0700 (PDT)
Date: Wed, 25 Sep 2024 08:03:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925080353.2362879-1-jakiela@google.com>
Subject: [PATCH 1/2] dt-bindings: arm: mediatek: Add MT8186
 Chinchou/Chinchou360 Chromebooks
From: "=?UTF-8?q?Albert=20Jakie=C5=82a?=" <jakiela@google.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	wenst@chromium.org, rafal@milecki.pl, hsinyi@chromium.org, 
	nfraprado@collabora.com, macpaul.lin@mediatek.com, sean.wang@mediatek.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	"=?UTF-8?q?Albert=20Jakie=C5=82a?=" <jakiela@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add entries for MT8186 based Chinchou/Chinchou360 Chromebooks.
These two are clamshell or convertible with touchscreen, stylus
and extra buttons.

Signed-off-by: Albert Jakie=C5=82a <jakiela@google.com>
---
 .../devicetree/bindings/arm/mediatek.yaml     | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Document=
ation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d..110149f5d748 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -239,6 +239,29 @@ properties:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - description: Google Chinchou360 (Asus Chromebook CZ11 Flip CZ1104F=
)
+        items:
+          - const: google,chinchou-sku16
+          - const: google,chinchou-sku18
+          - const: google,chinchou-sku19
+          - const: google,chinchou-sku21
+          - const: google,chinchou-sku2147483647
+          - const: mediatek,mt8186
+      - description: Google Chinchou (Asus Chromebook CZ12 Flip CZ1204C)
+        items:
+          - const: google,chinchou-sku0
+          - const: google,chinchou-sku1
+          - const: google,chinchou-sku2
+          - const: google,chinchou-sku3
+          - const: google,chinchou-sku4
+          - const: google,chinchou-sku5
+          - const: google,chinchou-sku6
+          - const: google,chinchou-sku7
+          - const: google,chinchou-sku17
+          - const: google,chinchou-sku22
+          - const: google,chinchou-sku23
+          - const: google,chinchou
+          - const: mediatek,mt8186
       - description: Google Magneton (Lenovo IdeaPad Slim 3 Chromebook (14=
M868))
         items:
           - const: google,steelix-sku393219
--=20
2.46.0.792.g87dc391469-goog


