Return-Path: <linux-kernel+bounces-312202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5D8969383
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE731F23C17
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB6C1CFED5;
	Tue,  3 Sep 2024 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="I/+aDWb+"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C41CF2AF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725344181; cv=none; b=RNzXbjs8qP2AB3tqlnWtfe380EuF0vebOiyhqo6dBPoVKQ75AM419Iz0fIj3cKGd2pzim/r4YFkGOZ9y1L6npxb+xVGNTIrXIG79XV5HAO1azWawWFfy1ecCAA3HPDDx8jVYidwBONxPlFS37ztt0Y74g0UkagSwic1lLZcnvJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725344181; c=relaxed/simple;
	bh=FSNthSYGg/mTlF3NCel24I5a57tx9nphyh0ico4wjNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJdLNT7TBnePYW8vTpJCdlVMD3FZGQ5feqUcFvxuxBkKrOP14T5YSNzTnX6XRAmk4DUmJ07RVVrDiBODleRsPcdcJymoCY7NNFeHmrAnkcFImaiFI3qU07fOBYWZyMwarxSbQN9pY1Bnoi6ftKbUVmIecz8N15JOeSBtiPMMpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=I/+aDWb+; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39f51934f61so8986785ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 23:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1725344178; x=1725948978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPpt6ERaV9w0t5on/zQBb5NLjkmrrGxBn+wH2mAAexM=;
        b=I/+aDWb+SEiFtyhzEhzBmsgsUd6WuegFkK7N6D/JfOTQjBCEVLeB4pydDPaunF4OvW
         n7Tkwu2gUqqNksPmLhpqRr7hGR8aukVnlkCHgD/KdvXspPUEhTUUX3giu05WAMnsR0oE
         sixSrANqCSR7oetwkQpQaxnGQuUTBVcqPb5FvCLlXiIqtRCNkVxK4n795C7J+iOCzEex
         uPVBWlt9kzH3ibsAy5LOlYMLl4Y/yiVext+2HjSXx86eR2ZlRozaGhkuRrCiCIWH0n6Z
         0pL1SKgF49/oud3GROxO7nY7V6APNuOhKPOQv91/5F6Tbg84vm/TLihvqLTCor15du+a
         CIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725344178; x=1725948978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPpt6ERaV9w0t5on/zQBb5NLjkmrrGxBn+wH2mAAexM=;
        b=L/hnONjswM1o52RCC6phA7efkQuBREwJ+2YfG+JWeuNu7B6vZtiCDz4XSuMpJj7tXc
         BJGMBrudQd5YziTSnAFkM7j8rYyUoPI3bBDF8nJfxAog7l2pXDe9QTEv4k26jxkkNZ2r
         BAjIX1irIzs/4ULCFqnNoomFZMxumsk3Fqe+c1lCSkymQlTOardia0/lRKJUkb/g7QTX
         ir77vzOPBYLv5FiNxOJ5LxooM5LPjP37lMO5MEu7VyYaCWuhfYYsy9MLQAHHusOb94Kn
         g4Wb7fg95NWlqlzzZXdjnB0MvlDuC+GDdp/7fPutOdlYZHDA2fxjMmPWOnOogJLZA4n/
         4PXg==
X-Forwarded-Encrypted: i=1; AJvYcCUNHGcnhTJuOuCN1RzAnsvxaWkQDeLdc9xlrl56o8Yc4vQ9wu8ZWnNPKq3T6zVIrUFi//hcCu+PNGUk94s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyddJHok18N+qdI5eyr4ylW6b+Dw7zyMs9+SjmO4ktjioHuucPv
	eHT5vapMIP9Lr0foIqaGyk9zLaDuA7Qyj4nSUoMOSbocIjjn/2lEBUmRx4s+QLY=
X-Google-Smtp-Source: AGHT+IGI5yQXvnwD4tRUXqvvTUqVeA16Ja0c9xrooX0aIQV2flSQ+7+bD4+wQcSDniI3F3maZasMOA==
X-Received: by 2002:a05:6e02:1fed:b0:39e:78d9:ebfc with SMTP id e9e14a558f8ab-39f6a9f5455mr24768165ab.17.1725344178513;
        Mon, 02 Sep 2024 23:16:18 -0700 (PDT)
Received: from zjn.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9be1efsm7151415a12.62.2024.09.02.23.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 23:16:18 -0700 (PDT)
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
Subject: [PATCH v2 1/2] dt-bindings: arm: mediatek: Add MT8186 Ponyta Chromebook
Date: Tue,  3 Sep 2024 14:16:02 +0800
Message-Id: <20240903061603.3007289-2-cengjianeng@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com>
References: <20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com>
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
+      - description: Google Ponyta (Custom lable)
+        items:
+          - const: google,ponyta-sku0
+          - const: google,ponyta-sku2147483647
+          - const: google,ponyta
+          - const: mediatek,mt8186
+      - description: Google Ponyta (Custom lable)
+        items:
+          - const: google,ponyta-sku1
+          - const: google,ponyta
+          - const: mediatek,mt8186
       - description: Google Rusty (Lenovo 100e Chromebook Gen 4)
         items:
           - const: google,steelix-sku196609
-- 
2.34.1


