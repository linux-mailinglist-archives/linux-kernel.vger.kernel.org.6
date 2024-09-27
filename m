Return-Path: <linux-kernel+bounces-341725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FF59884AC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AFF281727
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E550018BC1F;
	Fri, 27 Sep 2024 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zlydlwCj"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB7518A6C3
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440195; cv=none; b=XZFed92Z4e9JfpNuNQOF0m7nnFdU8MxC2jd2hHQvPJW/j8P2HeVEugkhPkPfyM9QE7/IR4omcDhbbQdgJW1FSC9C1yf/VYMa+V8MXHkfMZDyOBB7q5n1fej6rWP5yQG9HRkjRnnt8PZNaTno9MuC8x8N61iITtaYc2A1aRmaaeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440195; c=relaxed/simple;
	bh=dtX7p43c9EfWKtIYreh2ZNsXHQpGNGn8sWnAnM61D6s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QDyT1wOeBzMt7Fml8eVCg5aoUreMnuSM7Ed6/s53BDb/YdjseBVQk0bjOGDoXMbRtyUg/lawaUIzVjdu2Wu1/LyOMT2cnDl7cXxt8nx3VHuwWWxs0XeMFS9oXqoIuiWQdD7XV3arq2Zct8EIJab4lcB0UpkXGSKdfth8Gp1E/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jakiela.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zlydlwCj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jakiela.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e25d53bd322so2236752276.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 05:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727440193; x=1728044993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELDmQtxXpVLogwubqzTMS3LPGqaX3x3eR2JGyzb/QuM=;
        b=zlydlwCjimeZGPTrgKEigG03NiiuRHusquK93fUEWNPDXjEYpuRDuuwGQsc6CZj9DT
         I62rsfXlTNNMy8QPCR06EjEpH9X4AhyyChWdaXId80uVwYbnGzZ6/kFHHT0OcRnIa7hm
         cU9wUeuSrgAe8WOgd0Pbo4uRITC5JLnjzzlTImynFWQ4b/emdAc+cDHHqyMZoAj8zSBE
         /6tqPxnZoxO1H8vN6mlzpY1l+JPWTYpeKjGyseRJJs5irJ/0ocmZBldFC4DysYsFwnls
         M7L+zZ7jarnPYj7od0eexcRV0MNWNIT9zr4N45cai4kjSsDjkX9i4xCASKMy/wtD9QYm
         vTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727440193; x=1728044993;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELDmQtxXpVLogwubqzTMS3LPGqaX3x3eR2JGyzb/QuM=;
        b=Yv/kLPKdPyxaOhYxSfPHtQgzZJPCiBlRYYflgQOzH/FRv8OJWjzX8ryCCa3LWVOg1i
         iD5ikfAfI5syYFWLaCUTXN6QNkNazlfWw7eNHhh6iNmRzvJcHIG0kv9ZON5uvFn9Bn2h
         o2HLaDWcngGUpx+jg8Om/g4lCQpGMqxP0LVxDDlCyRjGAI+5H1YDnW43YMKgEB+2wobR
         L1+So0PwlqX91k4XUNok3E+Z1W+ZC2iH6OTK2rqErs+lRRWmeDN01JhEwbNvNYRlQUeZ
         WuLDhcHetExa/o57cBfp6TFzQhT/tSppx5B8Jk8h0Vv9VqRdNKAcZBNW7MQvW2MpzOgb
         1mKA==
X-Forwarded-Encrypted: i=1; AJvYcCXwCsduVTnVKGF9Px6FodnlKHzxR+rEDeRcJINR3WjydsPMoe08hXbzmf01UIfjBtwlRQbVkcOl4BCsp0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu8RaXwWgQoIoFwpdACCUkFuZqrK/PFe/2yG+31GR4ZVr/eFZk
	0MMv40vxPlANHn8Lmf3vY+Try8uVAWEbeUmjtn5uz0B5eBCgHebDarhjzDKXOENicMbmKhiGvDr
	yD3UxGA==
X-Google-Smtp-Source: AGHT+IHZik69z17s2hBKu9wHoeUjvGVk4W9fpiUC+n6n/gHu9NjuNOw0HQ5rbO8Oy/pIhvjVChUHz6q1p2mz
X-Received: from malysz.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:a1e])
 (user=jakiela job=sendgmr) by 2002:a5b:14c:0:b0:e25:2491:d005 with SMTP id
 3f1490d57ef6-e2604b84f89mr2516276.8.1727440192899; Fri, 27 Sep 2024 05:29:52
 -0700 (PDT)
Date: Fri, 27 Sep 2024 12:29:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240927122940.4190949-1-jakiela@google.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: mediatek: Add MT8186
 Chinchou/Chinchou360 Chromebooks
From: "=?UTF-8?q?Albert=20Jakie=C5=82a?=" <jakiela@google.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	wenst@chromium.org, rafal@milecki.pl, hsinyi@chromium.org, 
	nfraprado@collabora.com, sean.wang@mediatek.com
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

Changes since v1:
- PATCH 1/2: Delete sku2147483647
- Link to v1: https://lore.kernel.org/all/20240925080353.2362879-1-jakiela@=
google.com/

---
 .../devicetree/bindings/arm/mediatek.yaml     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Document=
ation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d..47efd96e5659 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -239,6 +239,28 @@ properties:
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
2.46.1.824.gd892dcdcdd-goog


