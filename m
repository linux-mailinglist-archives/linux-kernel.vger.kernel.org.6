Return-Path: <linux-kernel+bounces-311360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5781A968805
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9801F231F3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F341D6180;
	Mon,  2 Sep 2024 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="TC6XCvdT"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CFA20124A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281724; cv=none; b=IMaZ1GTE7klcFVBI31hhj/95OLy3abp/T+bJCRVBvKUfpd2VY1ID8IurQMkhvOttpuN5AldVZC9GjMLaPjnIjR4meAixGM2AENvIVRMbT9Mr0Hk8jTj97/hVWQusjyMObYxF4K/inhL/ZknO3ozBGe9Cm+BvmFVCgjLMSGFOHMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281724; c=relaxed/simple;
	bh=FSNthSYGg/mTlF3NCel24I5a57tx9nphyh0ico4wjNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TrNcYOC9Mpe/lbITFQAw9EkdSznYQu6sBgNuqRxYlWPPSYvf5yLbNvq2D4on/cvpmOPEWMqRTzrvWOWujRqfkAuuGiTybAbr949XHhkx9h0tEeGr0at3acDgA0qvnkIMsoAt84JcRC/2AYD0UyxfkLtl40Z2PXGNkm5+SBurcmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=TC6XCvdT; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5de8647f0d5so2709867eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1725281722; x=1725886522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPpt6ERaV9w0t5on/zQBb5NLjkmrrGxBn+wH2mAAexM=;
        b=TC6XCvdTEbgZqPQrP6oQJUdt+4Nnd/c0FESdMUmscX2XaJjrbh7iFBpOJ1QS/IT3ni
         VOac4XAAWMg39P9Q9nQkSQAFDn/ENUoQoa1oU8XWoiCykHApBvYru3LMnCL95uG2Vvnq
         c5a71Ji+biqadZtzvRZCa3Zq96U1bXQ1HMm4rCDEgFAabC5hZRA+1ooEHtFRpu/lAIVi
         avax+W8mIPiLOLph14HWXRo02e9E+E0kL0AWO9Z3U6nH/oeDtuUETe9aM30OOMkXfw5n
         20m6ZTZCMByy9fqiA0Ksgzb3ro/1Ub8hBj6bJFHPX7ID/aTkoJN6V7rvmFvodqbNIW1O
         PhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725281722; x=1725886522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPpt6ERaV9w0t5on/zQBb5NLjkmrrGxBn+wH2mAAexM=;
        b=SyEERhbF8ab+ei6j6p1QWnfvSAOHPpXtLF7gN8aO7WBURDK0OR8Dhw5soUriDuEfCf
         JxXuJBT3Vckfglmvpjej9Y+5HnGTD5BSXclf5VFR3NWYh1I41QxKyOWWXLkuNsTP8aIS
         xQXhhReZnJHlQSFc4ZgL7bz480nAGg/PG6NsE4xK8pqK56ukVUl7g5YMgPdn2AZMwPYt
         OfVwZcuXvK6wZcjVQ+2qsM6ZqmGyQl4JFseuVMaxQ1+aEWO8GnIQM58ozVodJMH24XvP
         +UH+GXEMahK/plwCNo7wwM4ncVw/21UmAsKd7TL/A28wKbg4Jyz40nqeczNlyBSm6hZb
         yBxA==
X-Forwarded-Encrypted: i=1; AJvYcCX0VoGyUQk7cUwiPQUK+IQQcm9PPlJZWcadkol00oN0zQK45IH7kulgUeRsLn8K9tatIP954S7xrVwhgCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjcXzIl3q5K/BzwlCd4YgOWOavdZMXs3shq7jOVV0rjmjylfhU
	RVDsWFc6j4UhuTuf16p1JU6b/EAqhpU0F83z2zSlHPm7i0HKuTpP3mWm5x9J+f8=
X-Google-Smtp-Source: AGHT+IGr00NuDQhakxmJAzU0K4ojhOQayR1MHWGLdctFGDN+ZUiOb8N4gaCw9OaVLmU7bGwt9lpj8Q==
X-Received: by 2002:a05:6870:808c:b0:261:21e9:1f0f with SMTP id 586e51a60fabf-277c81eceb5mr7979247fac.36.1725281721745;
        Mon, 02 Sep 2024 05:55:21 -0700 (PDT)
Received: from zjn.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a99eesm6773955b3a.50.2024.09.02.05.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:55:21 -0700 (PDT)
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
Subject: [PATCH v1 1/2] dt-bindings: arm: mediatek: Add MT8186 Ponyta Chromebook
Date: Mon,  2 Sep 2024 20:55:01 +0800
Message-Id: <20240902125502.1844374-2-cengjianeng@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902125502.1844374-1-cengjianeng@huaqin.corp-partner.google.com>
References: <20240902125502.1844374-1-cengjianeng@huaqin.corp-partner.google.com>
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


