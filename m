Return-Path: <linux-kernel+bounces-247827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B9692D521
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03D51F2334E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7C2194ACB;
	Wed, 10 Jul 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipCQfKJm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFC0194A44
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625809; cv=none; b=qmD/s1RoMyJ7b/mUvipAVikWbDVM9l1T4U8AtWj5UOVWxu5TznQSt86LxA/mAHQ+4IUXHgYd/HC8jKRpCM/DPk8ZChV0Tqef0a43sgu6G+umuYmM3DP6xezfZrn4DYGSfVK8bc5B0x7LSsSWDXkkuyAhsq4opw0vm4HUBYhfw3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625809; c=relaxed/simple;
	bh=QOlGEjG6fe8bchNVtMBv9s4auVk1QxHifUB7L6evv18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jv/BXc2o6jOxK3wi8vvhKJQ7eTQAixL5KeZEca3aSDV9/STwcvRMEeSPeENnZTFQaRdA0m8YYnS9TRFcSW3GpJT0Vdr04eC5rVJn3j607DkuTogvhhkwZYXFvUUssSDkha9lQpv3D9kZ1XJ/yjASPckSZ56uHRWmjcu2FK3L974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipCQfKJm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720625807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s64RA7czZjoxKqdjU5coO4Q/NqOYJDpUbBArTWbAtjU=;
	b=ipCQfKJmzj4ctdkNsakV09y27ZWOKBxKdBFbG3KWShH7eoceZexsVtLqzYb04V4uSipTzH
	prlP7keG6oB86W6iFJtTPon7m/22HnUSD1saT2I7PKmhdeQJyf9N+03MEuqEDCsQZ2MbDm
	hYEizaYkr9d1WIqSd2gPkNfibs3GN9w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-lkt_SUP9OOix3Smfqddpkw-1; Wed, 10 Jul 2024 11:36:45 -0400
X-MC-Unique: lkt_SUP9OOix3Smfqddpkw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b61dbb0005so25811536d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720625804; x=1721230604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s64RA7czZjoxKqdjU5coO4Q/NqOYJDpUbBArTWbAtjU=;
        b=UcET//Tc6gXImBySnt1xZ9Tww+XhOycvDfEW0n2qv4kRlsAVM1LOtLYd1V8ndrmc2K
         UYSnXhhC89Njet/dCjfixNd5uJ9mcx9VRzGCxfMAQYIRMC6RUHwXWb0DfOOfbmjReDrx
         yAz12dHE2w5CgjXvDo47el258KFXXfcI8iv78qNwzLTPiJT7r9cZAJU7XW/3WstTPTi1
         f8yD0+aMcAmBy1ZXBYPVt9moqFJA4fzbmfyyjiZ0d99Ou5AE8cGmhuv6m9K8ow6M6rAV
         iHZlSE/wcB3dT4ZEOzNmfXpRTeBmYt7EuTr+cLO8ft1He1lCUJug/OlJ7Y2AWICts+eD
         vLgg==
X-Forwarded-Encrypted: i=1; AJvYcCXBl898JPD08YZ2HOvj1dcKNTBzg0ogPczeC4QeYVSFqpy6xIJbWi2Rb97secKIYxxHU6pWvgz7PiSIGVMS/Qx4Ic8nDdOWBumNU46Y
X-Gm-Message-State: AOJu0Yx5gePkVYVabcU4Qt6hJvaw96hSp7Wc77T5IBN65Mnx7CGean8F
	7fJUE07m2nk1OyT0jccnswm7p2o93/hQ87z5JsOqqPkED+MuI6+qg6Qwy9Qy48PZbzpl03irJ2i
	QB4Ua+iwpL7gpQFnmVnJq83DNaher6lfOs6Zjm+pwYdF/iOyoyFD0/19lQHEMD1oy8stdh++nmn
	jar+Yw4OzBxpPKYfpRMywWg2ojdgH29ptt166T9J4tmdyGxg==
X-Received: by 2002:a05:6214:1cc1:b0:6b5:dca9:675c with SMTP id 6a1803df08f44-6b61bc7ef93mr77770706d6.4.1720625803672;
        Wed, 10 Jul 2024 08:36:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB/GdF4nMtnZWIqpj1bOX+NMDeXUNW4j07PUySuL9OsO7VkDuRhctdh8i+I5JTRQjusLsnqA==
X-Received: by 2002:a05:6214:1cc1:b0:6b5:dca9:675c with SMTP id 6a1803df08f44-6b61bc7ef93mr77770346d6.4.1720625803239;
        Wed, 10 Jul 2024 08:36:43 -0700 (PDT)
Received: from [192.168.1.111] ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba74d8esm17970576d6.94.2024.07.10.08.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 08:36:42 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Wed, 10 Jul 2024 10:36:14 -0500
Subject: [PATCH 2/2] arm64: dts: ti: k3-j784s4-evm: Consolidate serdes0
 references
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-k3-j784s4-evm-serdes0-cleanup-v1-2-03850fe33922@redhat.com>
References: <20240710-k3-j784s4-evm-serdes0-cleanup-v1-0-03850fe33922@redhat.com>
In-Reply-To: <20240710-k3-j784s4-evm-serdes0-cleanup-v1-0-03850fe33922@redhat.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, mranostay@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.13.0

Subnodes were added to serdes0 in two different spots (due to independent
development of their consumer usage). Let's go ahead and combine those
into one reference for readability's sake.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index e54ccf4f37955..ffa38f41679d8 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -1262,6 +1262,14 @@ &dss {
 &serdes0 {
 	status = "okay";
 
+	serdes0_pcie1_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <2>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>;
+	};
+
 	serdes0_usb_link: phy@3 {
 		reg = <3>;
 		cdns,num-lanes = <1>;
@@ -1386,22 +1394,6 @@ &main_mcan4 {
 	phys = <&transceiver3>;
 };
 
-&serdes0 {
-	status = "okay";
-
-	serdes0_pcie1_link: phy@0 {
-		reg = <0>;
-		cdns,num-lanes = <2>;
-		#phy-cells = <0>;
-		cdns,phy-type = <PHY_TYPE_PCIE>;
-		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>;
-	};
-};
-
-&serdes_wiz0 {
-	status = "okay";
-};
-
 &pcie1_rc {
 	status = "okay";
 	num-lanes = <2>;

-- 
2.45.2


