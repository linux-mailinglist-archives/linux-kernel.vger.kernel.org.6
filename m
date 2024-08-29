Return-Path: <linux-kernel+bounces-306518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DAB964007
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46ABA2817B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CE318EFC3;
	Thu, 29 Aug 2024 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sm1luPX7"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1E18DF7A;
	Thu, 29 Aug 2024 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923638; cv=none; b=osi0s/Fslv8viEY9V/ogjpJ0+U+Q9GfZX3PK1qNXASt/hpHwG5vIayI3/2LFdkZkxQjbGl7Bzy+O3U1jXhbtKm4haH//RWgszPWttgwl/cujJPK6wSf/mnKIIvJGRlS0os6cMZcBNCnbnm2ov+VBoqc1Df5VaYscnryuYD/GMaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923638; c=relaxed/simple;
	bh=uT/olKuIlcr3QC6mwRur4wcEv7An/PaeW6enq2v+qoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvDtceMqfLUYbbgozUcOCwNmb+qQVouGIkPH2Fu7uB2UhIK78oL9M8uQzdsbGZqKWUZYkfAuNWHuIsccnKnzs2wiGnpII0BW87Zg2xTZWUNWbHPlxwRo/RJJYmentNroErIIY84v68JeWlCax4Fg6TxpKSSex+bL99MGxu2LRIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sm1luPX7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2025031eb60so3544195ad.3;
        Thu, 29 Aug 2024 02:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724923636; x=1725528436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egoeKFBc4uhrvcZ8Ktzuy2NXVWTzG66ZP4Z1nx7Pk4U=;
        b=Sm1luPX7fCDNeUR9308KsDJBEq8B+uU+hrVcFveeSMEicHmaT0Q0nvno/IOs+eYVMM
         Kt+SoF1PcOwKH6sOUxAzLk37C1zxS/9U7oAtaTCSmy9HjEbDTm8RGIMAKgATNqofBdOP
         HAwyUT0LAHKZq8S+/zMCRqDPpXmO0sZyl7/QLggfMybYQqCqL3U2QFBuRkCtWeoORCM4
         Pyh5x/fY4QhNSRPE9q8GUuCXN7YiXUmjjB7uRP5DNeKLIsW/wxpGSaRaLzPfzD75/24/
         /VLdROJIuYz7Ove1BBtFsoo0r19uBl1OnJPqaVDKD+CF/Wy5KgxpbroHP5V/AbnKcuC3
         ounw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724923636; x=1725528436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egoeKFBc4uhrvcZ8Ktzuy2NXVWTzG66ZP4Z1nx7Pk4U=;
        b=jLfj44XAiW5DgSml/FxLYdVkyUMPaOoXLKnCrUHOe6EDOsEZ1SQMPvLsHgxDmPIr9j
         28W5lhyHTIkO0zoD+wETWit+RDAgMeCVlc2N4+3ZoSqM7j3ZnkmTB0QY1fRUI4Y/hGKx
         4RWdD9PctV/EsnxnB4Bhm29339uVKu7op1psfc8qpUJTxBDZfqH//TwrXFihnYwqbJEw
         yM88Px0vynrbHvlgQi49Ncg8FF4xIwFfqM2QjCA66N0N2sAykBeJAmpfjY3Q7GNKl3fi
         Riz0OJK0VYs3BLr8hJ37bm4BYsjw31ZvAh9AcdsMEAOpgZgnvEjnHS4df7HUnmBGc3OK
         1SLA==
X-Forwarded-Encrypted: i=1; AJvYcCU8P2efIE6AcG1x3h1sc+e442xxt+SC2gpi/QFxapGRSTgfG/ZCDlRLNUXRY6e7ASjsu1GOPmHQOBvH01fy@vger.kernel.org, AJvYcCUwBewjnTUij7Gk/uwHaCkEHs8eoGTCvB0/Few5vRd+JOdh+qaEdGeZH7Uwo0tmGXfu2WRgQetpECWx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7aB8xzl166MSKpalXVJcKTEkzOxhEpZhn67Na09lHbYxSVj1b
	Hd+apVS5gvSWu3r1fQfHQ5v7dSLXfHxyA6k+huSAKrSia0HygXlr
X-Google-Smtp-Source: AGHT+IE9a3/PA7Hcwin2yUXCWfoh1SSkESId1pC/M9tB8Z80zr6jplNAzD80CEsYGdj0Bz74E/IN/w==
X-Received: by 2002:a17:902:e848:b0:203:a20a:a596 with SMTP id d9443c01a7336-2050c21a680mr23635065ad.7.1724923635850;
        Thu, 29 Aug 2024 02:27:15 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20515552b6dsm7469245ad.249.2024.08.29.02.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:27:15 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 1/3] dt-bindings: apple,aic: Document A7-A11 compatibles
Date: Thu, 29 Aug 2024 17:03:11 +0800
Message-ID: <20240829092610.89731-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829092610.89731-1-towinchenmi@gmail.com>
References: <20240829092610.89731-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatibles for Apple A7-A11 SoCs.

There are three feature levels:
- A7-A10: No fast IPI
- A11: fast IPI, global only
- M1: fast IPI with local and global support

Each feature level is an extension of the previous. For example, M1 will
also work with the A7 feature level.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../bindings/interrupt-controller/apple,aic.yaml  | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index 698588e9aa86..28e09b933087 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -36,9 +36,18 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - const: apple,t8103-aic
-      - const: apple,aic
+    oneOf:
+      - const: apple,s5l8960x-aic
+      - items:
+          - enum:
+              - apple,s8000-aic
+              - apple,t7000-aic
+              - apple,t8010-aic
+          - const: apple,s5l8960x-aic
+      - items:
+          - const: apple,t8103-aic
+          - const: apple,t8015-aic
+          - const: apple,aic
 
   interrupt-controller: true
 
-- 
2.46.0


