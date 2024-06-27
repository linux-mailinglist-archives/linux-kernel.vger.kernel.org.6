Return-Path: <linux-kernel+bounces-231886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A37B3919FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42131C22141
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D771133439;
	Thu, 27 Jun 2024 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0Bktxhr"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956B4482FF;
	Thu, 27 Jun 2024 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471649; cv=none; b=j40LYe5aXQNUnyDtypSowsRG61Kxqdg71E8YwfPCAWViWlUi4HsuPjNF0VCmX/NId1DjhN+mzvPPs+4fQPUUMySV9R+n7Wfiy6FdsxrBBJqdUIKMd+GcIIThb7/DZ7mvuR9SuR0rS1mG9MaB0xpuBp6KfYXoDCn7tOIEhtbeGx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471649; c=relaxed/simple;
	bh=deTe5yBj/aIe1eSH9PAeVb4xbfDI+OExfQQ2xqBivwQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cD6eXLP6mDSSCQQjLqbimB4yDvQhEK+4XQRbnOZC91SkfUmdTwIisdsGUtNP/SxgNU8pkL3zGu8sDkVarLmxPQoDEFkRVcsEzGVHKNesq6bjdgbMokQ7UeeoASuZ+bJePNx7zSdYkBptrmoFNERUF5rXF2+LYpBE+dvAXEP+Sww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0Bktxhr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fa9f540f45so8454305ad.1;
        Thu, 27 Jun 2024 00:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719471648; x=1720076448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9MVRVw78cAnGxBai+z1t3GEr8C1bFmf/TOYviQnigs=;
        b=b0Bktxhr/SJufWrDAFtmeMQacUKInFdFLyuk8t4feeWWyPh5XiXe3+Ug/58c1A5urI
         BulF8etzwJwchLB5ODHXKTbXQ/awrZUHQZXATSttYlynbdqw8XXqDIegbmcdUGPZwzoZ
         Bd3KH4U4FivqZ+6K6OOazIdcJDoQWc/yYmzBHmTyAbEko3gAsXXAPzOjxDjkL6o9tUY0
         YGgsYwgVPi50gJR7+WCFR0lHibySxBW2iULxJCvqQssSEgJybQNt4eKFbfN+xtQtRfAj
         J5vxkAoe+zDoKBAwWJ5iI+RoOM2mfF5jicRBJQUIJ/B9H+MM4epj0E2r+jweBaDstnap
         7QHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719471648; x=1720076448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9MVRVw78cAnGxBai+z1t3GEr8C1bFmf/TOYviQnigs=;
        b=hb5ZAoGaG4L1RH527mAqniOQN9/ftXnIZ/8f6V9/S2FqghPxTfTbNB4FpLkrBYBiZW
         Gsg3bIYqgSYdRTUHJXIgN+h7INWmsuaZwMzDYkQTbJ3ehSQYKpLr1lYzvLrJ7VAEXCMU
         SBrNSb2o/7leVKt8+4b26w6wdhicGpGylh+HKDAp8eNpgXYRNXfYP0JPXbOKH+zlvPR5
         EgpdSP6ts5nq/OUHjFaTq3i1uVVvef+5/C8VIa2e31nqRjM9KPpdg9AiAD42a6X9cs1n
         8XulW4XJJ+SB8EgVM71ZPRAfqQnjQq0ck5jBiHKhGg6yd40uiNY5onKoY+HqxsJ4ed5a
         CRmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqJYgPILMq71SQsmcmamoeKEQrkinIYzgSGXgo1L0cAOlf5sa7jjjZdlEbBKJiotjAgjF4V/UsMZfcWV9kVGrWXKl5Q89MwpLLv25RzcWQfGNSs01a6IKIptraPc3nT9Ju7Ni20RNrGg==
X-Gm-Message-State: AOJu0Yy3XtfOjk/nNcls+o8DTv7iJQljcmSC5/lz9jWKNUvnOMkM1BAq
	GVlwysSCFvIso2MqoUIDe3R14T7n2S4fp/dQQBQWrq7YYaAlZ880
X-Google-Smtp-Source: AGHT+IGXmY3tDD4kOoK590b8I1gWP513ZKXgFYDLyB6WZ9qTeS1eg//qn2jcgZjuPF1yVeQ0Bm3g2Q==
X-Received: by 2002:a17:903:32c4:b0:1f7:2a95:f2d7 with SMTP id d9443c01a7336-1fa15943813mr148693425ad.59.1719471647926;
        Thu, 27 Jun 2024 00:00:47 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e306-713d-05da-7754-dfb7-477a.emome-ip6.hinet.net. [2001:b400:e306:713d:5da:7754:dfb7:477a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac997ed1sm5962145ad.211.2024.06.27.00.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:00:47 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	amithash@meta.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] ARM: dts: aspeed: Harma: enable mctp controller
Date: Thu, 27 Jun 2024 15:00:11 +0800
Message-Id: <20240627070013.2509150-10-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
References: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the mctp controller in i2c9.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 0455475fbcff..0dd0566bbf27 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -382,6 +382,14 @@ &i2c8 {
 &i2c9 {
 	status = "okay";
 
+	mctp-controller;
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
 	gpio@30 {
 		compatible = "nxp,pca9555";
 		reg = <0x30>;
-- 
2.25.1


