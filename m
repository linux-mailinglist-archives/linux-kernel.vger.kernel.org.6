Return-Path: <linux-kernel+bounces-249261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C493A92E8F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F96128740E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A3516A959;
	Thu, 11 Jul 2024 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHnaBxNe"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B21684A7;
	Thu, 11 Jul 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703230; cv=none; b=tuijSfZvS9WsM620oEPEK/TeVmJ+5NpHxNQwhR+jlvvW9j59lV5IiqIRpilbDM4FuzybJEAPkKDC6eVOdMG9tlyqKYRgSEjeaUQ14kL3F51ym2iaH3HRfGnhJsApCslitIHDV/J0SyoduOqRzs4pEemusE8ZejapqfnvBvP0Llc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703230; c=relaxed/simple;
	bh=f+jxSNyhE10kPaWRusCsXbEE1RXBwIFmEXq7EkDieyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LRQpq/eOtUg+0HbMo2UgeBJpVGq32VyouFumMV3OAoTxPtUGDzR+A4ZtiIWlb47/5+7u9Z51lDqCSeFi1h5HXL2upi8apXrdekRs0eZ3NgNFKEOXErexjF5nMGVpmk26q8y9OHR1cwVmIM6OctgSOE0himTwNPA9cu9OadiR4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHnaBxNe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fbc0a1494dso5422325ad.3;
        Thu, 11 Jul 2024 06:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720703228; x=1721308028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jnve3iMfQ3N9VA7fI/ITJkN0F4YPFwznhKUmalCiOE=;
        b=ZHnaBxNed5jPpIuLihMtrQLgmSObQoGCePgOsaSGrJTadxaspnEOwS7I1mMrDR9ruF
         38AC/6N82VTNG3ufcnw0eUBIUJeMNyq0pj9eomL8CmFAlz0BpM+7b4uXI5seHpbHtjzo
         ncxK4KZJlmAm2YwFTSQipo0zXQ/46+/6tQtX0yWvnZZTCReGtkWfzKRnSstjj2DJKRnU
         fGa2KDWeGR+LOkD34UxDkJ9EOAPgxWeF8sJN1SkT/KrOfwPS+fzBEqnuOemoMX8VrFk9
         oHCDmCCP+SgOZoKkR7d62+rv5or03+xh0ByT1lVviMeOY20cl2MuZ0Xz89w2gtbvIcPW
         2UJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720703228; x=1721308028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jnve3iMfQ3N9VA7fI/ITJkN0F4YPFwznhKUmalCiOE=;
        b=UGEVauCZ3uNO9+AErzaVvRrnaAxLVN+nPLx1Ufm8/M+YUX5n67To6SPVxJgSWYBj6o
         wT1civyF51f/KDz3ldeKzzkA/zgmWmBB89rzNOcU0ytZnH91XNVVgMLgcLyIKW3whfvh
         Un0x2ckRrmq2DkdRwzcMihzvWubeMkyr1A4s0BVYv22U5NMkENtsGoTjuMWtZGFf0bGK
         CrQsojOSph8DO/wdsPgyklaAS/cIpbE2bqROaBfpZcqIJ/kz7PhZv9giG+p3tKqmwraX
         /hCpBMcr/iRN1LbpkHDV/PlZx1XsQ82Z7m630Gr6pu+7nK+mIjXE9GJBICgfsy5eO6VB
         cd9w==
X-Forwarded-Encrypted: i=1; AJvYcCX2UKej8aZoJ4PRgNxSBoF4fKS2PmVjOo6gOMqrFPTSWbCmIT8DYwzUmGT9ZNxQ/2m5QhJ3DYAoYN8ver8WuCIJgqrm1uQVJ53Wk0DyCGShckfRSIU/7u1NRZYK+mXzSMCvXHO0cy9QxA==
X-Gm-Message-State: AOJu0YxVpSnnSuIpJKw38VblR0EPEO0Zc7GHL7RHnTmA+undUlOYU+M3
	U5wEx1HiafGY7crc6ovVBMDteMMMlEIxytnvlJuuiR3o9Ihxrb67
X-Google-Smtp-Source: AGHT+IEmrIGHOBFSqXd81RIMGrfzoPUeUGC1m4BCECre0JDGSNlum8QRpsMZAkW8rPcHp3wUnUdxkw==
X-Received: by 2002:a17:903:2352:b0:1fa:47b7:2e41 with SMTP id d9443c01a7336-1fbb6ce5288mr74016295ad.1.1720703227962;
        Thu, 11 Jul 2024 06:07:07 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a10868sm50188305ad.9.2024.07.11.06.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:07:07 -0700 (PDT)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	amithash@meta.com,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Jerry.Lin@quantatw.com,
	yangchen.openbmc@gmail.com,
	yang.chen@quantatw.com
Subject: [PATCH v1 1/1] ARM: dts: aspeed: minerva: add host0-ready pin
Date: Thu, 11 Jul 2024 21:05:01 +0800
Message-Id: <20240711130501.2900301-2-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711130501.2900301-1-yangchen.openbmc@gmail.com>
References: <20240711130501.2900301-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add host0-ready pin for phosphor-state-manager.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index f5ac248097b4..41e2246cfbd1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -613,7 +613,7 @@ &gpio0 {
 	/*P0-P7*/	"","","","","","","","",
 	/*Q0-Q7*/	"","","","","","power-chassis-control","","",
 	/*R0-R7*/	"","","","","","","","",
-	/*S0-S7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","","","","","host0-ready",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","","",
 	/*V0-V7*/	"","","","","BAT_DETECT","","power-chassis-good","",
-- 
2.34.1


