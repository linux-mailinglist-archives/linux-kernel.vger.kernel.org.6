Return-Path: <linux-kernel+bounces-349608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B0298F8F7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D877B281669
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C571BE223;
	Thu,  3 Oct 2024 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDAQmOi5"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C83748D;
	Thu,  3 Oct 2024 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991108; cv=none; b=ZkTGjU3toO5D9jdHcHGeu+rksrSbbjP8YXML8ArhwUKDg9MzW6lj6Ohi/jGUZMBQPbHiXLg2o14sI6RolvfxiMjAyx07fFmuUCq5LEUU8Q8JKcG+r7djYIxsMzIy0cuU0DOjsj3g2X2ysCzhfnVAZKOCNNUjovd04V7Nn5nCH24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991108; c=relaxed/simple;
	bh=cvX0A3a40Mnpksld/xBD8CG9V5mVi81O++2s6b83X1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=amiAhLzzu/EjoQKA+vZLtmwWLedG0hqW4e7jtzs0N0fT0q2FYk59uKapcrE1MaOVdfwe2Cp4pje8TsyPFSrL+pwGsrhZKuUdfqJqA01ZEth6v7nf1ZNEIx0daMnWkOrVR0WrPfXBzscAG/lsd2NiqSdZ9AjDHD/z8rhGHF+JUcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDAQmOi5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b58f2e1f4so9907525ad.2;
        Thu, 03 Oct 2024 14:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727991106; x=1728595906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tlJnuYudkQcvSiXcbuQHiiS8kjmsY5u12FD20Oi4f1w=;
        b=LDAQmOi5WsKhYvQ0LC90sXM8LZyCS240KozSXvIS43uNa7hPs0xcKMSvYcrereqnh9
         pBypRcnpqUqlRkMZQHNorxBdDdYY0EuvBac1l3RTjKdDj7a02ZqzH7wOL/C87bcEgD+6
         dCBUabakxS4m/6wZw+qhJCUkYXs0la2WFK+LyHnYd2Gwm+Irag5fQu8fCT+RWKr0ti0z
         lcQ/9GqnpuNo+EYaJoI32H4pPkVrHKU1rdz/x+UVfQmqGMloarOeujR0fiksv9K9FJWu
         nl6GObHkwOJqr1yczqWahcklgqHjomnCRR2CWq/fbBlGWhC19yQ53+ILaChXPySfUDcZ
         AA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727991106; x=1728595906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlJnuYudkQcvSiXcbuQHiiS8kjmsY5u12FD20Oi4f1w=;
        b=Y0vUGjet5H37AOE2k8XM5xnjBnpi3cWdoXZ6fE6Y8v7FGmCAPeWNSXnbz3xrc6gcW9
         1CBo5g2kQmzYs+4iVOsRxjuq8Ky0UOEWjN7AHcpupF0UMw2OZce3cwfmUQSQJs6bF9x4
         VlCXH0/DuTuN70xjzuNRiupPa/UJeIAERLFDXNn44/tnqivvUWykdZac3//eTJ236QlO
         ZY3v4HZe/zalx5BxellzUqC61yBFd2P3PvlyGr9lLwxe/fXsVWhfI3vi7qzUA84/mxwH
         1LmLPNNadp1oy53toKKPQuFWz50TKtUqnUollzPHzyW/Ey+i7fS17l8uHmSi1ib33Od2
         skIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHQwb3fk0vZHvvxqA6EFLEk/PG8kUHPpvV/+pOpc3F7O9K5tf1e+y3RjOi5maUV65f9xjtVvXj0aH3113P@vger.kernel.org, AJvYcCXweb/zUtmYa82WH8C8k2u5EsAchhzPA8GA2WWynIhQ2rHvRPc8PT22ZEem/XAy6VcPZbZExFILaZdb@vger.kernel.org
X-Gm-Message-State: AOJu0YySFsP3FZda3LMJG9krmxUXarJMnY/5qIyiezRpN0GD5SYtPgGK
	T26PTmkDDTPDO0uUvV0yD6R00ExB994sCcVONXrvuosrp2oXnG4Y5B2S2LHTXHo=
X-Google-Smtp-Source: AGHT+IFiGdM+VQCNhgt4ZlgEkjHdFnPd8See17dNt2UuFCVzLRXPiZrBh0yv9L4vN8l521dlZfBxfw==
X-Received: by 2002:a17:903:32cd:b0:20b:af36:ead with SMTP id d9443c01a7336-20bff194fd0mr7661645ad.44.1727991106195;
        Thu, 03 Oct 2024 14:31:46 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00:b8ac:3fa:437b:85fa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca2fbfsm13285795ad.102.2024.10.03.14.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:31:45 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH] arm64: dts: broadcom: bcmbca: bcm4908: Reserve CFE stub area
Date: Thu,  3 Oct 2024 14:30:07 -0700
Message-ID: <20241003213007.1339811-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CFE bootloader places a stub program at 0x0000-0xFFFF to hold the
secondary CPUs until the boot CPU writes the release address. If Linux
overwrites this program before execution reaches smp_prepare_cpus(), the
secondary CPUs may become inaccessible.

This is only a problem with CFE, and then only until the secondary CPUs
are brought online. However, since it is such a small amount of memory,
it is easiest to reserve it unconditionally.

Therefore, add a /reserved-memory node to bcm4908.dtsi to protect this
critical memory region.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
index 8b924812322c..326f84f746cb 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
@@ -68,6 +68,16 @@ l2: l2-cache0 {
 		};
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cfe-stub@0 {
+			reg = <0 0 0 0x10000>;
+		};
+	};
+
 	axi@81000000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.44.2


