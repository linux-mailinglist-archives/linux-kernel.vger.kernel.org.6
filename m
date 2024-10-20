Return-Path: <linux-kernel+bounces-373399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5157D9A5648
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0648B1F2239C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC941199FDD;
	Sun, 20 Oct 2024 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGw4FQhb"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64644199E84;
	Sun, 20 Oct 2024 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453248; cv=none; b=TYDtRFZgSxRI86T15XToBvky0Nys4cGStgNNEGSrqsEKp97AtSe7Pv8Qwke5okcIaxPpwjDubcE5vm8H+2ahcZj+kAQCJaq84XeA9A3ldZKw6MtVjeO4VnImWV1v6hM0s17dEl7IfG7/qHK4oy5V0oGTaiyIdRTkCzRYPbttbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453248; c=relaxed/simple;
	bh=Ek3f9IntqkTVZaMM5+9uMLvwBlmFC1g5tii851ibiMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/bMgh+anLtaJMcExE4dN1LGZUj8P13oxERtLfw4YVmRnXhMQfXT8beC9VKXdYyminIFfjjdqPmfJIzK8KAEOtAXD8WPPgys/LLforAtrH9hhs4UPfUKP38BkyPIQ/COf7kmcgCkwoTpwOcgq8cGWeIbILKOldWVmvSP1YiWfwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGw4FQhb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99f9fa66fdso41532266b.0;
        Sun, 20 Oct 2024 12:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453245; x=1730058045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxrWAGvbebnl7bShJIljz1Nm6dGXiAY6T1E3WWpWzg0=;
        b=RGw4FQhbRUjOfTj7IvNwmBVAwzwJBuOYCRE1EHMWbmFwVXAwAP7EH01YId0w/Mv5iG
         lKqswTwS2+w6Wnx/j5K0jIFMa4IdJinvfWvTRIrVIDDeeY2roV1XZmyEe98MXrQWD5b7
         kfEb2ndg82gIa9LG5r9+FdlumOjljE7Njza9G3PJErpUs+OLkObdGcvbTPHWl3ngdKFx
         aotl8qcWKzMFpDlpTJdEBz3qTib6op8NnMNQNQRB8tqDmCG7Sd3H949ouPgQo1l2OWxF
         Ed6s2rG9pUJ/fo1vtCSOKkiNlvSvyhSIuxcCYr+fhooPiL+V54ZjUM7i0EjgRga1anzL
         2e9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453245; x=1730058045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxrWAGvbebnl7bShJIljz1Nm6dGXiAY6T1E3WWpWzg0=;
        b=tKpVPGLB3GALu0SnwaeZFSoMx34LAdRLR0vCtNDxOtABzQWnuAJU1HdMDq32wXowDZ
         6bAo3b6NqLcr31m0s+0MsIdAnhdrjbZb6n2eI58brTwpeIMUWy4lSYNXYQXrI2Ine210
         Y9RGebO1SeaasQB8G5WbmfUvQtd6p20R9Ts6n2n+iJam829q0FMGPaH7rNGZ0yLPezH0
         f09Od6oiXJHIogB41UiSwNaeN4JvSbom3bYOLwBvZ3QkzCaK0z5xFJoOxGa6LacgEHXN
         GmvL9G8uNKQsdfzxq7qcQhSO5CnG+kjUAcfTbcz7PLhznW3DCLXIT3Ac+9yr1MPElxm7
         qFJA==
X-Forwarded-Encrypted: i=1; AJvYcCV8IknSx6QMX70XpEYAWWBE1c1nBI7AKxKoycMl23sO2sT8DWRbc8mqILg/lB6u55aCBvFQpiD4q9Hc2iop@vger.kernel.org, AJvYcCW9Nz1a5FQJLD2jtHBa6+hG+50k4VAHNaXVp3fX55y63ce6aPgrLZ8ybok+R2v/irXfHdmTpFvr+8kq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwsgldw9TYIS4jnQVWliSW2nH4JF7Tz6jEyQ0P8Nf83KipzJgO
	FxTfCwN6EZoGoG+AaWaGW4gFHgCzIOwHAI4cQAWw/GnvW2tv5Wlp
X-Google-Smtp-Source: AGHT+IFCZ6BJIUyBnORr0mBO7BasiZrlFliRi4/7kBie7xUahDtQZwEAY2svoJaIho4w3E2UALcNBw==
X-Received: by 2002:a17:907:a47:b0:a9a:2a56:b54 with SMTP id a640c23a62f3a-a9a69a6aa6emr501922166b.5.1729453244416;
        Sun, 20 Oct 2024 12:40:44 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:44 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de
Cc: l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 09/23] ARM: dts: socfpga: add ranges property to sram
Date: Sun, 20 Oct 2024 19:40:14 +0000
Message-Id: <20241020194028.2272371-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241020194028.2272371-1-l.rubusch@gmail.com>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'ranges' to the SRAM node as it is a required property by the
dtschema.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 5f4bed187..6a2ecc7ed 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -691,6 +691,7 @@ ocram: sram@ffe00000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			reg = <0xffe00000 0x40000>;
+			ranges;
 		};
 
 		eccmgr: eccmgr {
-- 
2.25.1


