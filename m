Return-Path: <linux-kernel+bounces-373401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153EE9A564C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73641B25BA2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF67619AD87;
	Sun, 20 Oct 2024 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9mEFBT3"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C61519A28D;
	Sun, 20 Oct 2024 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453251; cv=none; b=qasvYAxfULRDSS6dlaB4WQxyN0YDXwTEmP7X4SG8f757/3zTvFQxOKBh0OJO86PmNNeOLLHRjUyvNGXX2mdr5uBfTUSDvO+d+4snCdlBjv0/s9kA5BICk9GBb5pH74F4EMEzT2xO9NCoPwe3qq0upd/c6xE5Yf4YbzuArDmJb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453251; c=relaxed/simple;
	bh=joZpyHR+Wlhxfb0H3wceSV97QyNAa8BZ7J+53GB6yVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QbmtOe62qRS0ZfPuk81db6aIuyemyRV1TLjSyAxW1qZ4pGQ8tBfCsu99btAeqhpGmix2+qvLZ8Jx7Qg63ThYD6TSjHjxnnjo6oiSeAAEQJ+5ArfoC0n99fHroXplQbFDyqhrpT3ClEJPlE3j3L0neP/Vaq4fuA1uD3gpwv/YblY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9mEFBT3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a19bf0a1dso45058166b.1;
        Sun, 20 Oct 2024 12:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453247; x=1730058047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUbFYGdzkYflwPdV3aLLlq949mh5hJ4f6+ogO5vfLWI=;
        b=P9mEFBT3C9eOsh/STmhVRIdtoplxKrOGK3Rf/ZOU4iSzRLNZllHdoXIV8RlC4lOQNA
         0hfzZNlFwTaR1bpJZL/eC9p77tJoHIeKX/3FWWUQ6G7kXo5eSNlpoW6dbKgc/7+KTwL+
         VXH4quHajIUQ3VCk5LtDULqGP2papEVA2QgRfc0Vk1H6E8qFdXSl1k0L7xH0KndIvphs
         Ynz2drrNSHDRbUO4Wx2fG4XsneKffQRb5vJMM02MfuODroHqOWrOV8Lp7RSYfchSIo2Y
         lnZ/m8aVh1/bOxcVYIJjAlU9blDCfUna4uuqK53FTuA/YdarVE4Mqz1LCVe6k0gNhdSZ
         PFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453247; x=1730058047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUbFYGdzkYflwPdV3aLLlq949mh5hJ4f6+ogO5vfLWI=;
        b=Gch7e/v/keuVEcJC8ezEPY7fwklgqPEKwqcR9+fMgKoo9pX27Hpn+KgRHrGdN/sML0
         AD11nfq6gM+IDEd2ixc5NkW8EgjkT2mzdZym6gxo28/Md3ohxeBE65ZsBkm8OJVQAu3W
         Ii/snP/PWdgFoOVyQ3k6PPiZkQ4c5Xc/NIJV3RPLJYKnGVNd88WCNXPcKMg65I606iYs
         H6MkjPxUQ/wFcus+Hleg9pfZM1PGx5gJNFBizcoctD1Elh4ul3LTAc6m/RvblfDEfZNA
         ouQJRTmFskYL+xP1m2nC3GZ9Pksnz1r+b7qEwqMOSv8a7aCwX3opJmdzMFBLD6hzcW3A
         UYrw==
X-Forwarded-Encrypted: i=1; AJvYcCW8+q5jBGmcujm482LQdZ/RkJ/AMGH20Dnjgo0pQZqtYE+vkU1PAMFlnevs2BOCAKgRix6OjDLOvnV5@vger.kernel.org, AJvYcCXEyZQCAIXzbvaOxFrVaWyPOAJ42N4AOxUdRvcJ4FEsMwzSxmb4PqZrXvbPHT+u4RNXWu24gfihshb0eAqL@vger.kernel.org
X-Gm-Message-State: AOJu0YwkBzNONwHM08HV82qyli+XHUXeZRD8WKVGqatMZIyePeFuiFNk
	C2NZeCiMgppm1oXP2cjrO+Tdxw4W/102b8+IlQk37sHHajPo91cq
X-Google-Smtp-Source: AGHT+IHo9J+fsgTkUliM9SpJfVh662ZEMDrTO+snyS2PoxnvmpVUoo2ALVlOIMRC/fYgqFWU/+9LPw==
X-Received: by 2002:a17:907:9725:b0:a9a:a55:1e6 with SMTP id a640c23a62f3a-a9a6996ac53mr405151166b.3.1729453247166;
        Sun, 20 Oct 2024 12:40:47 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:46 -0700 (PDT)
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
Subject: [PATCHv2 11/23] ARM: socfpga: dts: add compatibility for arria10
Date: Sun, 20 Oct 2024 19:40:16 +0000
Message-Id: <20241020194028.2272371-12-l.rubusch@gmail.com>
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

Add compatibility to the arria10 platform. This fixes the dtschema issue
'dwmac: failed to match any schema with compatible'.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 15073627c..d26bb77eb 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -26,6 +26,7 @@ select:
           - snps,dwmac-3.610
           - snps,dwmac-3.70a
           - snps,dwmac-3.710
+          - snps,dwmac-3.72a
           - snps,dwmac-4.00
           - snps,dwmac-4.10a
           - snps,dwmac-4.20a
@@ -88,6 +89,7 @@ properties:
         - snps,dwmac-3.610
         - snps,dwmac-3.70a
         - snps,dwmac-3.710
+        - snps,dwmac-3.72a
         - snps,dwmac-4.00
         - snps,dwmac-4.10a
         - snps,dwmac-4.20a
-- 
2.25.1


