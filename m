Return-Path: <linux-kernel+bounces-373800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238249A5CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89AF280C05
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696B61DDC10;
	Mon, 21 Oct 2024 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="wP0KFTQn"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBAE1D1735
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495655; cv=none; b=OfhgC7nLPt7RpJO+91qlCqEvRsGiNQWyXqETqoyAMfmdElXfMN1Nce21svHjnE8InwhR6HFpzoWQyjgVAlZiUXrH5l4Cxg6R6NXVxvNBEJ1dvZ1bKlLjvOFGbUKJCqu1Hm0RFlL750LLxekDwnfLsKf1akud9r6Xohdh4HFpIi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495655; c=relaxed/simple;
	bh=tG6YhzlTGIreNbErkabD4IDbbTrsSViWd67RLxSnw0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ox11qnjhhQs0SJfbNqpBgKvjyB1paMqT0SKyebLJP1wV0ye7j2GQoYeHAodHg23Ne+b7OFA47bfFBt8x6CSKQRz2f8yr7OP3A1fPNnyPcXjq3VPrrpZvnb/AnXv9ygMrfQvebzX7l7toSMkcReBBigNkhjNgcAnEimFLx1o4L7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=wP0KFTQn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c78a10eb3so3524315ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 00:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1729495653; x=1730100453; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iEsUo4lrwpljoR0FPBQuFvw1WkkxvZeqCHqf7QaSpZM=;
        b=wP0KFTQnwAxASehqBIxbQKFBMXmfGgsVH7/ZI3Bj0+7/Kctzx6NPCN04SLglgBABHB
         rzgr72WpkWI4qMU1iqnxKbK7wB4IQS+jdiizNjcTNifAwdIDI7vDmNwKFLxmb1VTSCM4
         LKEyG/YvmlOlAXEL2g5VitYW4/+20jDCSFj/05iIoxHcLg5bWUWLNfc2+lIHXfudrFzC
         Jp3W2R/c7lbwT5hT+5XjeeUh+/vNHGev9EMLX9piYNFdVs/TB5h7I3IFdumy63BT9O5l
         4JZCZ5CsHdEhzG92SUXn995sYPrpBu58d4mDkuPEtSv1g2fqjJ0GSUF2QSkqDPBHLFVa
         2dXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495653; x=1730100453;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEsUo4lrwpljoR0FPBQuFvw1WkkxvZeqCHqf7QaSpZM=;
        b=jpxfp29gL02HjKDP9oDidpSMWaY7ZhyP3jtsD/IwZAxITd3UMXkFpqQp/eRJV+P2IO
         bpelFO09ssJcZkeDtKzQbgwV513mEro5Avnpj4GnyV0cAn6Z0pLGfBHB7f141z9XOmSH
         MBNh2cF7lA9qkWguiO+rjQRLljXnQurJjc495VRxOhpXucYkfVLqPoa2VGdfRgl+j8KG
         CwEiD80R26OlLbT13L/s10PVOoU88CDgRFamNTSHhMG1/UzR7L8zeFIHHtuGfnbHqU4Q
         9NvomOrZiXjdLFLEbSgOtKciHzjJEcEoJ8EkVPn2lCOWW2IGcUdd0aS1f7RYyW4rKr0X
         bk3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0MJ3/LtEaYXaV+jlkovmqMj1uQjh2KPsbpO0gP3zsc4wjp9LfER2nn6p6dyDW6eyo2HDdQ+zXnSA50bE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg8Im5CIJxvAi72t1Fe+25iTybDbQsKRbN0hCr9B8mz8jWA9MS
	Zonvg4Dq4ntlliIXXRqhEELFLJvGJedkbwQaCSBicH/QC5JygRqTqAASbkLHc2w=
X-Google-Smtp-Source: AGHT+IHVWdo9DzZe9CvJAnnR5Nm6etKX28vGhiPfuoocslDk2019rofbtIMsNYuZn74vbuM1Sbeinw==
X-Received: by 2002:a17:902:e807:b0:20b:a2b8:1863 with SMTP id d9443c01a7336-20e5a7a3339mr57169335ad.3.1729495652874;
        Mon, 21 Oct 2024 00:27:32 -0700 (PDT)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0db2desm19749595ad.203.2024.10.21.00.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:27:32 -0700 (PDT)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	sean.wang@mediatek.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v3 RESEND 1/4] dt-bindings: arm: mediatek: Add MT8186 Chinchou Chromebook
Date: Mon, 21 Oct 2024 15:26:23 +0800
Message-Id: <20241021072626.15102-2-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241021072626.15102-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20241021072626.15102-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add an entry for the MT8186 based Chinchou Chromebook, also known as the
ASUS Chromebook CZ12 Flip (CZ1204F) and CZ12(CZ1204C).

Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/arm/mediatek.yaml     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d..3efab59b8a73 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -239,6 +239,34 @@ properties:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - description: Google Chinchou (Asus Chromebook CZ1104CM2A/CZ1204CM2A)
+        items:
+          - const: google,chinchou-sku0
+          - const: google,chinchou-sku2
+          - const: google,chinchou-sku4
+          - const: google,chinchou-sku5
+          - const: google,chinchou
+          - const: mediatek,mt8186
+      - description: Google Chinchou (Asus Chromebook CZ1104FM2A/CZ1204FM2A/CZ1104CM2A/CZ1204CM2A)
+        items:
+          - const: google,chinchou-sku1
+          - const: google,chinchou-sku17
+          - const: google,chinchou-sku3
+          - const: google,chinchou-sku6
+          - const: google,chinchou-sku7
+          - const: google,chinchou-sku20
+          - const: google,chinchou-sku22
+          - const: google,chinchou-sku23
+          - const: google,chinchou
+          - const: mediatek,mt8186
+      - description: Google Chinchou360 (Asus Chromebook CZ1104FM2A/CZ1204FM2A Flip)
+        items:
+          - const: google,chinchou-sku16
+          - const: google,chinchou-sku18
+          - const: google,chinchou-sku19
+          - const: google,chinchou-sku21
+          - const: google,chinchou
+          - const: mediatek,mt8186
       - description: Google Magneton (Lenovo IdeaPad Slim 3 Chromebook (14M868))
         items:
           - const: google,steelix-sku393219
-- 
2.17.1


