Return-Path: <linux-kernel+bounces-523012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A020AA3D0F9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743A11683FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F431E47AE;
	Thu, 20 Feb 2025 05:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRNvR0cS"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2681E3780;
	Thu, 20 Feb 2025 05:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740030227; cv=none; b=mXbvQudyLnucoNpQvGJcW41J6l7NOP3J1EExKMS02J7s5FZp1VRy+M/9KCRE8Or4PXY7Js+5YeZyI6ggTpFIqNQCo5zHjLvEgGZHsG8W0oLLcSl49nrHW2orbaml9BaA0BuD1YD+fNdoj6X8u1RTOTdgmSXf2oX4Vwz0PddW2cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740030227; c=relaxed/simple;
	bh=Th8MI4OmisAx0MAtndb0Fm8nMgDfRbjqWBipmtFbJ2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rvzmZqOGcnzl4RH7z6+t2wlGocA3sLnhlaoHJ7VQ9nVhwerYq563SIdRVW4AgN9/bmBKJeBV2Ga/pToPzA0QrM7L+vVOvy6ckBKSjanHSK7sZGvCv9Ga2l906SyXGobYKJeyRIzsDd3EKEkFTvxB9A2ZkOkFCYAVyU53yEAU/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRNvR0cS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f8263ae0so10247835ad.0;
        Wed, 19 Feb 2025 21:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740030225; x=1740635025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IMohSeK8gkqwGyZxC38NO7B7vZzY5EIwZHxDi6wbmo=;
        b=SRNvR0cSrMUgPuX79U0AueNpyjOxqLWxQAIfQd5UVRyW8N42GT2OtFgeWEOdzjr6No
         TdrXAYlIqjjNYoGsLqRR+bKsVWCg/jm678yXp65C+Ja2aXRNtkhW5hHgKzRw/TaVNb70
         VhEMkS8zqNNKZtm382OG0d9IdlFvzifKl5IcH75NSaKunCu0mfnKmLMfwunjGyhjpeYE
         AGJVu0oVTALhKnfTBt//f3+kjqQBHIYw9mUy+0GDBNqh263B7nQ54s58FabA0oOtuxd5
         P8Ewz1OVHO1TN6tJDxlEuL8MPrA8r5NTB6hji+iMm0a/gR/PWNUbfLpNnRCz9ZifNhWF
         mo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740030225; x=1740635025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IMohSeK8gkqwGyZxC38NO7B7vZzY5EIwZHxDi6wbmo=;
        b=gqqHHMHwA7wjRt4/bkvA2uzX5fSRA0HpcVbiEe4+IFU+Z++URPwJbcU35S57KQ3V4w
         5tLk1NqzRcET4fClm/ii/8AqZpQHFeJjTFJTvc9bqvOq5FiFBu3OwOoZp5U/U7m+p/rB
         eSpN0BtZIEeyp0F1V9u8VOSwbdDs7ax3nv/FaD3Cdm+wVglSgdSU+0cL6UNV0X1Iis7X
         7V9HKqUrOs5lA5Z/yvc+nq5AqfT1GDmjDFiGXD4H25YEBzvtR/BE9P/ICZEb5I7b+Zjx
         EM3S7V2rh9k9pO7ae+khecGs/HFYDhG5FHrpuybs59zxKxRMPuc3XrT5CaoBBWspkNhs
         DUxg==
X-Forwarded-Encrypted: i=1; AJvYcCX9c0dJi7ysZCPPndiTszgg8VAyerTOiU75EnBVpwGOJre7GXdywQ0mb4MNK+KXm59TUssmI6eKYm2J@vger.kernel.org
X-Gm-Message-State: AOJu0YwjA7sqjeopTIhfxgHkiWJ/vdGmSCSv1+N5YICjf5zbfQR2zVgG
	nBqq/kTBcR+zzzTgLBpHDJJG7hL0SrIYVivFbvsPqRp4aaRx4NSKdQXLXw==
X-Gm-Gg: ASbGncsvUtJkf2qucHbOV33nwv6Lt3+8TfETBi3GqLNkbipIqqXI/Juk7sT75DqJj7S
	1NWv3cQEDdYElw8XNUTjwy2e0ZJj66tU7Gm7/Ynf0OpP1Sz1C24TasU3tpi7Dep6EM/84MOHbKm
	7nupXFeqBtFwVyCXpqNO5c4CnXXspT2j3QZr618QcVlLS1U7kEgJyVuuuKTovlrZlUXVJlE0TUP
	uRxvr3frm5ID8NdaFhPHmtUmJzdVb/VXf9EIL2gW0RKK4s1Ychq+qsST1g5uqIEIbSuqEAtNbWP
	uU9uZcfT98myZnZWQs874GOcfw==
X-Google-Smtp-Source: AGHT+IGBXepTc9P17+2mR0kT1gPNO4iTdvt0WTXULVcNdkEoHownFPvxNPEmpScIh0GvM1j1L9uplg==
X-Received: by 2002:a17:902:e88d:b0:215:bb50:6a05 with SMTP id d9443c01a7336-22103efc0c7mr317994265ad.9.1740030224974;
        Wed, 19 Feb 2025 21:43:44 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534951fsm114415335ad.25.2025.02.19.21.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 21:43:44 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v2 1/4] dt-bindings: i3c: silvaco: Add npcm845 compatible string
Date: Thu, 20 Feb 2025 13:43:27 +0800
Message-Id: <20250220054330.1711979-2-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220054330.1711979-1-yschu@nuvoton.com>
References: <20250220054330.1711979-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible string for Nuvoton BMC NPCM845 i3c controller.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index c56ff77677f1..9be4bc4cc482 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: silvaco,i3c-master-v1
+    enum:
+      - silvaco,i3c-master-v1
+      - nuvoton,npcm845-i3c
 
   reg:
     maxItems: 1
-- 
2.34.1


