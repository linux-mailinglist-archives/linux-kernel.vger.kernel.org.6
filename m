Return-Path: <linux-kernel+bounces-357932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C479977F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A7E282BEA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04341E283D;
	Wed,  9 Oct 2024 21:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcFQXMjZ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D62183CD9;
	Wed,  9 Oct 2024 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728511007; cv=none; b=CoFz/o/eXaJLgKJaKZXoDN3D0XHg0Oj0T+8eMEhzkCkHAxYz4XhAjYCDKsVrcDKBgsuUO37p/0wcxDb01oDkWqDK4wgfd56Y22U/U7VWKZVPMjV3OfwUisaz+D5CstOieXm/D+mkPZgHpdD440ldnE6705lSjvlX6bMW1XgGtds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728511007; c=relaxed/simple;
	bh=hKBvF7aVl369N1LMdWPFSaqSEPC42/B7x29k/guZb4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4wi1t/bObl683CcrKaVtkAjPPjt1pTbI19N9EG/+Tfzrve+FXD6FRCK9DUdqgHUdW8J5SGGDNFU+3d5gBpYDAgjeikpw2y1yBP0l2SrFb9tPDPitUoih98qxRxdWmu1nzfDEi2zQJgFsKGEsMDmmZbkLl8oMu5YJoFUn5T8azc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcFQXMjZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e0c3e85c5so253237b3a.2;
        Wed, 09 Oct 2024 14:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728511005; x=1729115805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SGAxTreCbsGFlOTTE3BOCBJp/69hyZC6sLc49Fka8o=;
        b=DcFQXMjZcQpoi7BBM6Vin4FXH5Od5y0mlJJcfr9vfTaSm53gjFwHaKJzyjv5drNvr7
         E3BZw47jeQyvC+5FzTtE5VIek0pA/zwG9ANuvWbNpqYgNEW2y7P7b1WQZIWbT+wTIDoA
         rQnml1Ulwm/A44KDuH4mbW5GbpMBr9SQl2D1SXHMbFO5XqCb3uNKoOy85YW06gxHAcBk
         XI1686SBtisx+NYwzjbVYY9gOlUiCfkqpm8O7+Wgsgo5FOIDiG4MWGdozPcUNYZrgObq
         M1jLyFxqtxKY2duSoIm127RGUYsmN4S4aL7kJVXvAp3xNtXCfTpUbjwSOAGjbB9DJq+s
         c1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728511005; x=1729115805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SGAxTreCbsGFlOTTE3BOCBJp/69hyZC6sLc49Fka8o=;
        b=rDUnT4BDa3LMr+CNGIT1GxQQkDJ3FxeHXswbUBsMuF0K2yffTemcXZRy7d0r7rhqGx
         G6FfuK8Z0ERMpF+Rl1oGxwlUyyEwLMLb39gp1DFOi9dO5/ebqqfYgcvRIR4Ly4TkMuz3
         hvGf3p4UHXkBFKIbrdnxV4kZMSxtc7PbD6VfDFFHcF0q9E/M7hTWcuulVZE83OjgfplY
         gGJrkbNx0QxoSp8Q+9NgDtA87awuSpCCzjOU0O0mqyuKOsNVDIHJfMJa7q40Eg2ZRITL
         amLdMWVYzz1krc5bpGL7f7NY7Jm7rmTX3LmKEM/ApwBUi/E/c7yuSNOD2VPK3W6Hll/8
         myiA==
X-Forwarded-Encrypted: i=1; AJvYcCU4Q1zKzEb/iq0DG94SykLD28y1YCpW8hIGEmmmfDgBHVeZCse1RgIuFDsgJG+l5AKFAGd/54W6vfHY@vger.kernel.org, AJvYcCXy6qRPjdeMF3UH3uICj98GUCSF/m9+jMmhx4Lkkq2Uvb5q5E1pAYHEA2+QkraiszL5ngAO96fspV+75Eyj@vger.kernel.org
X-Gm-Message-State: AOJu0YyOR9SgHKsCKhxGLPXXMojne4gBdzSmEaU7lnIGARiz1KxrWPss
	HB7RBvgXbmS5o2TV2eg3OYl9DVpGAIe9H6GojK0siIP75YfewEOw
X-Google-Smtp-Source: AGHT+IFd7QS07/9s9F8MqCkhV+goz1SkBt+8EtolQ6YwafT/zh65S+z5PhJOcRHIzw7EIROIr/qVMg==
X-Received: by 2002:a05:6a00:4fc1:b0:71e:ed6:1cb2 with SMTP id d2e1a72fcca58-71e1dbb54c6mr5773236b3a.20.1728511005180;
        Wed, 09 Oct 2024 14:56:45 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00::315])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6833ce7sm7726646a12.48.2024.10.09.14.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:56:44 -0700 (PDT)
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
	Sam Edwards <CFSworks@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm64: bcmbca: Add Zyxel EX3510-B based on BCM4906
Date: Wed,  9 Oct 2024 14:54:53 -0700
Message-ID: <20241009215454.1449508-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20241009215454.1449508-1-CFSworks@gmail.com>
References: <20241009215454.1449508-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a series (EX3510-B0 and EX3510-B1) of residential gateways based
on BCM4906, a stripped-down version of the BCM4908 SoC. Although Zyxel's
marketing materials call this a "series," the EX3510-B1 appears to be a
very minor revision of the EX3510-B0, with only changes that are
transparent to software. As far as Linux is concerned, this "series"
effectively represents a single model.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
index 07892cbdd23c..4999568225f1 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
@@ -34,6 +34,7 @@ properties:
           - enum:
               - netgear,r8000p
               - tplink,archer-c2300-v1
+              - zyxel,ex3510b
           - const: brcm,bcm4906
           - const: brcm,bcm4908
           - const: brcm,bcmbca
-- 
2.44.2


