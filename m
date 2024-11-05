Return-Path: <linux-kernel+bounces-396284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9AA9BCAC4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B31E0B229AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580B91D2B10;
	Tue,  5 Nov 2024 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7ha7Wju"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A01D174E;
	Tue,  5 Nov 2024 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803558; cv=none; b=s5+8LpXea7/3cB6pvbkWc3a5KLsoKQm85t3hzNpf63lc48IEeWi439vo2kfQPdAndknvBLxNIEC+9+UPZBxI4ddi043w6bG3ifpmRmV3ZvMCQzEJFf+rf/3FNdcptRhdDVropubmah+1ATwdZ7acPexP199T6jYsfEyqC98Kyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803558; c=relaxed/simple;
	bh=YAhFFdDBrQJySjuAGSSqaiwvhx73d4kURkImckkyLYw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lIOtAaZD+wX70kOc7xzg03mlUqYJtUVVbSQ5JCxdpEaH93/4u3vE8CvvMGjXVf8tfG6TgY2kKXKyaag6WpOgGTktOHCG35Fr3Qa84OJ2ii/N83wsXORIVc2Fh6f1wRg4jAMOImtlFqD/hCue4yn21ak7WYYlLI11ird0wNo77TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7ha7Wju; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso3597648a12.1;
        Tue, 05 Nov 2024 02:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730803556; x=1731408356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2nqCzdAinTSs6r9LINYA0htJIpUUCl9grAyzKQ3FNXw=;
        b=f7ha7WjuWSXWzazIHOETpNuuqMc1ouumFx/c544BWjKbnubUSJ1y2WSPvjdoW7Xgh7
         kXVTr7cHI+qMb3HVu/1Vzys/2FdIyCdzDiVe7nF7OtQ7R0ZYpACTcaYJokJhJ1qNLUYl
         37Cqwsulpl1Exw1l80Uro1lSG3Rd8ScbfvwLbW3u+8gplL1V6kPMl6j4POSnLOpzESkK
         nbzWCJ3E9wjDBlOEUaigEhVs4L4rRJYoXIQ/yLKPc5VzZSrCGdeIRoKq0JkAmGjEBIxu
         NIYIXiaHJ875S1VAeXfRheFLaeqRSPet7IRTWZ1pP+xMUw9JRBbl4PxVi4hi9eKJYE52
         PzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730803556; x=1731408356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nqCzdAinTSs6r9LINYA0htJIpUUCl9grAyzKQ3FNXw=;
        b=bEls3wX1KQ6gIoKK613qhaHjGN2ggEcSRN5JPpVUO60hrFzZH+dbKPQwG0dhHxr7zN
         itCylmOY81aQeE5iIRBgfUCKgPzPouoDbaA8PkQTpfQd2vry26LmjKTcYvICBk1wZNEH
         DMDoRt80Akve+rZ5YXxhOgD/Hi0a55DODaXyqgzp6a4EbjXfbsRYg2SC4BFIvI+q8O4w
         /p5f1TOp1cl2RS97+r8jEcP6MuqiAHVkZoX5/Te7HCLKIOHg0h/oJFNd/pW4pe2GggeD
         2kk3bjRQQeSUBl9gqWpYJs7uYQfrdNXLhGE5qbqRfaa1rhncdSnJV34tynGpxJHgasDo
         cnlg==
X-Forwarded-Encrypted: i=1; AJvYcCU1ZGiXJ9HZQH5qQh0ITqnXWNYGxmduImSwgBUdaSXGeIbPwnKypdQybu68j6TpWALOaum1EDBdeeXK@vger.kernel.org, AJvYcCUz3bcBgB1NoyBPv2BGverDGt3es6TVJNldHFxXLrMPjoGuhYcAekxzbKsbDsVSq96M3+LDqggpqklk9E4=@vger.kernel.org, AJvYcCX08BH4JpV52qiTTeWKeQRBboDu0O+tXCoktwbS4at3bV3QkrUOFPmLNXycAyarY49MSn5kxwz1Z0RA6WW3@vger.kernel.org
X-Gm-Message-State: AOJu0YwNNT4aBsVeSe9zBaI3VtDU68Y1ME2Wilv7nB6sD9VMBPaKingD
	Yf0Y1Qbi/40DCF3v/7+xxJIwy0l/LX0GpmoFUmCEkWkAjZoF1kf2
X-Google-Smtp-Source: AGHT+IFuMzmSrFyNbomcXyCKZcD5Ptda87WpuI1YNIlIu2eTML/Qcm8QIBq7OYbQ0MNRnPuijz8Y+w==
X-Received: by 2002:a17:902:ec88:b0:20c:6bff:fcb1 with SMTP id d9443c01a7336-21105692ebfmr310242945ad.1.1730803556481;
        Tue, 05 Nov 2024 02:45:56 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:cbc5:8de0:c558:652c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c0ec7sm75358565ad.202.2024.11.05.02.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 02:45:55 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shengjiu.wang@nxp.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 RESEND] ASoC: dt-bindings: fsl_spdif: Document imx6sl/sx compatible fallback
Date: Tue,  5 Nov 2024 07:45:47 -0300
Message-Id: <20241105104547.947128-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

i.MX6SL and i.MX6SX SPDIF blocks are compatible with i.MX35.

Document 'fsl,imx35-spdif' as a fallback compatible for these two
chip variants.

This fixes the following dt-schema warnings:

compatible: ['fsl,imx6sl-spdif', 'fsl,imx35-spdif'] is too long
compatible: ['fsl,imx6sx-spdif', 'fsl,imx35-spdif'] is too long

Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes since v1:
- Keep the entries as one enum. (Rob)

 .../devicetree/bindings/sound/fsl,spdif.yaml  | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
index 204f361cea27..5654e9f61aba 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
@@ -16,16 +16,23 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - fsl,imx35-spdif
-      - fsl,vf610-spdif
-      - fsl,imx6sx-spdif
-      - fsl,imx8qm-spdif
-      - fsl,imx8qxp-spdif
-      - fsl,imx8mq-spdif
-      - fsl,imx8mm-spdif
-      - fsl,imx8mn-spdif
-      - fsl,imx8ulp-spdif
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx35-spdif
+              - fsl,imx6sx-spdif
+              - fsl,imx8mm-spdif
+              - fsl,imx8mn-spdif
+              - fsl,imx8mq-spdif
+              - fsl,imx8qm-spdif
+              - fsl,imx8qxp-spdif
+              - fsl,imx8ulp-spdif
+              - fsl,vf610-spdif
+      - items:
+          - enum:
+              - fsl,imx6sl-spdif
+              - fsl,imx6sx-spdif
+          - const: fsl,imx35-spdif
 
   reg:
     maxItems: 1
-- 
2.34.1


