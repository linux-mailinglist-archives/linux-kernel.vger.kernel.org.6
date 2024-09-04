Return-Path: <linux-kernel+bounces-314513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2B896B457
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622171C21AA4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6E0188901;
	Wed,  4 Sep 2024 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="ZZq3uuZj"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE818893B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437721; cv=none; b=J7I8+z+0fzao2PuZvEgiBXXaIPE8XNMGLDeyNWJZ3gBdzRxuRV1cmzWBhKwl9qxRQ0+1ldjDa4GXmkK4iGVcKlX80vKuZ/ziVitwAlPp4MLhPjHILxyALi3534keuzN/N1bzx7q10SKBpfLmGxfSOEkqv2+nUq1oKMggfrxBhVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437721; c=relaxed/simple;
	bh=m+LvTPkx8a1x603LYdhFRWIHDroPR3WoWfKtD0wglow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HXntiRpWf/UHBAgYkFT/PgZCa1nSK2IIWkjZBswGdGvAVi0lQWx+L46TXhGddvcYkilQ3vMJQxprNyuTg2Lm+1MXRFA/HaiRWmCGCxdOzLcZEAAvnjtiPPN3Em8I8I+wA5PHfPJ2ObhQHRz9Fc/YjTGBNI66O2rJIOea5iYh2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=ZZq3uuZj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20696938f86so13291615ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1725437717; x=1726042517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRdc5AMdvByd9qcj2i6Loyq3HdJpcgiM3X+j1Pvdni0=;
        b=ZZq3uuZjZGpUHdsGlpAe6zvcY0+y4vDXgQOVBK3smkFYwWH/s9s9Brs4j3esHmafQK
         cicYhlsFNNrfbs5c/fylWa9iyrQBPFWIaXZq4f976FnXrVQGOrCK6G0BuS53/ZThHubU
         qDZrEbkZDejt6pS5wpF3mJTMl87cOElY51/VJ9FMWTbaePOGc1Brxo9yIP0Mw+BLXSal
         HIb7H5Zi+u+D93rxr4ysa+QeaRps8VfqxC7UmeR9TpzNKUVsdGKq1fNjMHfXczT/iAZ4
         VgDuJxYcpZFaeK7cDxTAEuFQKjxRyrM+3+0EIyXg533hgEGVIXSJYIv7lvnH6WeMinG8
         Qurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725437717; x=1726042517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRdc5AMdvByd9qcj2i6Loyq3HdJpcgiM3X+j1Pvdni0=;
        b=n9xAccQmDkbOd1pjB2ZFgu6wEJTKUOlMWk/lSU2wezwMk1oQX8KmCbT5jlPYW8aoL0
         uz/knKOqS6fEUF+RqOW1FU4oQA7Je9Nj1OM071gOcvDZGbaO7ymo/I0nj4gBeP1sPyFB
         b4sjTSifVPhrRdkUHen2Z0VzHlkDjDQNK3Ho91jIlpH7MOFXNvRFd5wIBge9DCvUkUBs
         +SyTMvb4O3aC/8ohIpP8oonvb4XR0xw/Hh99HhA6RsPXLkmkynFYehJc3DuKibctsr9x
         OeXusQBZ4hMvCQhavAaEP3gYTHhyHqMxyGp9eMmfLqzi56N8aa/2MJcDsV4iOarX2iio
         4efw==
X-Forwarded-Encrypted: i=1; AJvYcCUxTdSNkYzjZDEN1kHb9cW7X1eOPGqBpK4C+ONZuewmx2i6o8WK27s63OHYLByIHif6wgP8FV9FQygozcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfAm9f0ur+3alus/A6XSJ3lWKs6qYWzFf1kOSG961JhOwt1PWa
	MhA9Y/uRC8BDGJ+YTFOlcCFDZxQbgyHRaYRHF6L8UaVRDAL2wmB63aSWfHgK9Qk=
X-Google-Smtp-Source: AGHT+IGK31//3XeAKFe13krwGEqRfNEJwm77L/z7hDQXuWi5CgOKPXqq/SoD9LyOe4vl6AmOSRsoGQ==
X-Received: by 2002:a17:902:db08:b0:205:8b9e:964b with SMTP id d9443c01a7336-2058b9e9afamr104785765ad.39.1725437717314;
        Wed, 04 Sep 2024 01:15:17 -0700 (PDT)
Received: from zjn.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae94980esm9024145ad.84.2024.09.04.01.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:15:17 -0700 (PDT)
From: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
To: angelogioacchino.delregno@collabora.com,
	matthias.bgg@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	knoxchiou@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: mediatek: Add MT8186 Ponyta Chromebook
Date: Wed,  4 Sep 2024 16:15:00 +0800
Message-Id: <20240904081501.2060933-2-cengjianeng@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904081501.2060933-1-cengjianeng@huaqin.corp-partner.google.com>
References: <20240904081501.2060933-1-cengjianeng@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for the MT8186 based Ponyta Chromebook (custom lable).

Signed-off-by: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
---
Changes in v3:
- PATCH 1/2: Modify lable to label.
- Link to v2:https://lore.kernel.org/all/20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com/

Chage since V2:
- No change.

---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d..410145976272 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -257,6 +257,17 @@ properties:
           - const: google,steelix-sku393218
           - const: google,steelix
           - const: mediatek,mt8186
+      - description: Google Ponyta (Custom label)
+        items:
+          - const: google,ponyta-sku0
+          - const: google,ponyta-sku2147483647
+          - const: google,ponyta
+          - const: mediatek,mt8186
+      - description: Google Ponyta (Custom label)
+        items:
+          - const: google,ponyta-sku1
+          - const: google,ponyta
+          - const: mediatek,mt8186
       - description: Google Rusty (Lenovo 100e Chromebook Gen 4)
         items:
           - const: google,steelix-sku196609
-- 
2.34.1


