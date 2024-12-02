Return-Path: <linux-kernel+bounces-427920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 403769E0821
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88AFEB3D883
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B6C13B797;
	Mon,  2 Dec 2024 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OEhgyWGc"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F894C62B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154447; cv=none; b=b/2tAfEXHvHj1vPTrBnjHtMakf67vyPYRn+BFqLCRu+bjn8OR1g8G3YdqRJgey0QIiwFBfJiSRvHvJFlJY8sl75vKzPBMu3uR8x7+HR/cqgAyvC9WJ6G4WQRSHmwaEV6jHO334Fx/ksAOlB2DKQn+y3kGIMVPsTZmrF4SNUhU8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154447; c=relaxed/simple;
	bh=mtiQtlXyI3b6sJIsjA4TwpaNavz3zj9aF+MIz5P2kic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTKLhUuBhm0vNxuv3NG/PYOo9FS6j2ge8/CZrlepYQCxxstP3kebhF1mRjYXwAcCLyBmqLHOFyBp4S8PayDp0HnjlapewzEdq54vYDkIFEeYhPd9tiFOM2y4O7NIaf63akh5btOtpQE05Nv/FODCUHgfZJzZDArNtFBrYfnyq3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OEhgyWGc; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-85bc6a1a48cso750532241.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733154441; x=1733759241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RkEW/0Y6zT4/Atf/d+puMl0WcNDtT8U8UDsIe65uvgE=;
        b=OEhgyWGcKXzsgFxQ5qCx3Qve3IiYC8Tcdya5BUHVAlcLvExGxT4hLwlBAA53vHG+fc
         ICMI1w4R6nH4/27DtxQZEHDyqGmuS5/JEMHTy9w6Tvl4m5shGwUWY1X7Yf3LW+gN59dT
         F+gcfmO4Q2sBal5m7xgJ2aAo7b22Y1Y+itZuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733154441; x=1733759241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkEW/0Y6zT4/Atf/d+puMl0WcNDtT8U8UDsIe65uvgE=;
        b=nNjwWQs11fXjlBlucSsl2VXFHx2Dq61JrXa8PI77/jxcH3GIRLay1dwuA7O0wde3DG
         t+0GXAmlHMi19RYyXr0de+3IA/PKl0mK5s3Q8rAXcVQ0lmAc8RQaO2npvesWtXEt9ZfT
         FDaEO/z4puffoOGeV73aZMOe8Bnunw3x1O23FQ0i0WX4NU9C3V/sQmD4liMQQ8B1Bh/T
         rsjuZ07AqHN6BApeJumLQXlkAza9kXicKRQnmN58oAELib6XowSlRXdpqBfTH77W9CLA
         6CPoup8wsUmj39ZoFFX/fwjbTy0D1wpk3whcbgngkayu/1n69lhvt9dwTZSlpAD8Eswh
         avMA==
X-Forwarded-Encrypted: i=1; AJvYcCXruN9F1ZxD7G38S2QW9g4gmaPSE7jVLbIYl6ansXTDmlJv1YH4j8ruiAExBbOkNN6B29MjaicRexZOOm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCpRaxQcFhFJtvSoQD41AOeE+cbF59yK7Su+bFc8xW7jPV0J4i
	TsLlup2FGqVNdW1Exq0SoExdZnUTweWTyqNkzlDGZpp3P13EByba9yDMQxFx8A==
X-Gm-Gg: ASbGncv2DkOGape3Y2qfdZmM0RR66eysG2E4LxoTSzZT6MLs5q9Aa2dAeeko0+nwKty
	U48AeLwkdLeDCe+jX+72dH+sUPInt3FrAbLQ7qqtKWse/LEB+T4mQ+jAC9/2Gs8hdcbElxR4w8y
	6zyzhq2hAYCJ6j/F3ENNN2VL9OI1+BBgmCaU9IsBINsJsraeR9ccxqSnBTfdoIJRkXH+280iaw1
	hXmCF+y5qs0pEw7PzOctgivJy/yT64pkyPLFSnBBNVwJug9nmu5d8LuZzXR1q0YcXVFHYIcHSWw
	hsoGttERc/8iCD2cyPKr2Ju2
X-Google-Smtp-Source: AGHT+IGBHPCXG9TwBD4LE/oxUh/BqCKafbDdQlV9UV4NbH/ohrUS+/WPS+6wYQbT3toO5YK2KCH6Sw==
X-Received: by 2002:a05:6122:500e:10b0:515:20e6:7861 with SMTP id 71dfb90a1353d-5156a8069d4mr18897232e0c.2.1733154441340;
        Mon, 02 Dec 2024 07:47:21 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5156d0f8ad6sm1159729e0c.49.2024.12.02.07.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:47:20 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 02 Dec 2024 15:47:15 +0000
Subject: [PATCH 1/3] media: cx231xx: Convert enum into a define
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-fix-llvm9-v1-1-2a50f5acfd0b@chromium.org>
References: <20241202-fix-llvm9-v1-0-2a50f5acfd0b@chromium.org>
In-Reply-To: <20241202-fix-llvm9-v1-0-2a50f5acfd0b@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-staging@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The code is running arithmentics with the enum, which when not done with
care makes the compiler a bit nervous.

Because those enums are only used as defines (no argument or variable
from that enumeration type), convert it into a define and move on.

It is required to build with llvm 9 without these warnings:
drivers/media/usb/cx231xx/cx231xx-pcb-cfg.c:673:17: warning: bitwise operation between different enumeration types ('enum TS_PORT' and 'enum POWE_TYPE') [-Wenum-enum-conversion]
drivers/media/usb/cx231xx/cx231xx-pcb-cfg.c:680:21: warning: bitwise operation between different enumeration types ('enum AVDEC_STATUS' and 'enum POWE_TYPE') [-Wenum-enum-conversion]
drivers/media/usb/cx231xx/cx231xx-pcb-cfg.c:687:21: warning: bitwise operation between different enumeration types ('enum AVDEC_STATUS' and 'enum POWE_TYPE') [-Wenum-enum-conversion]
drivers/media/usb/cx231xx/cx231xx-pcb-cfg.c:702:17: warning: bitwise operation between different enumeration types ('enum TS_PORT' and 'enum POWE_TYPE') [-Wenum-enum-conversion]
drivers/media/usb/cx231xx/cx231xx-pcb-cfg.c:709:21: warning: bitwise operation between different enumeration types ('enum TS_PORT' and 'enum POWE_TYPE') [-Wenum-enum-conversion]
drivers/media/usb/cx231xx/cx231xx-pcb-cfg.c:718:21: warning: bitwise operation between different enumeration types ('enum AVDEC_STATUS' and 'enum POWE_TYPE') [-Wenum-enum-conversion]
drivers/media/usb/cx231xx/cx231xx-pcb-cfg.c:727:21: warning: bitwise operation between different enumeration types ('enum AVDEC_STATUS' and 'enum TS_PORT') [-Wenum-enum-conversion]
drivers/media/usb/cx231xx/cx231xx-pcb-cfg.c:737:21: warning: bitwise operation between different enumeration types ('enum AVDEC_STATUS' and 'enum TS_PORT') [-Wenum-enum-conversion]
drivers/media/usb/cx231xx/cx231xx-pcb-cfg.c:749:21: warning: bitwise operation between different enumeration types ('enum AVDEC_STATUS' and 'enum TS_PORT') [-Wenum-enum-conversion]

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/cx231xx/cx231xx-pcb-cfg.h | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-pcb-cfg.h b/drivers/media/usb/cx231xx/cx231xx-pcb-cfg.h
index 5bc44f194d0a..62ffa16bb82c 100644
--- a/drivers/media/usb/cx231xx/cx231xx-pcb-cfg.h
+++ b/drivers/media/usb/cx231xx/cx231xx-pcb-cfg.h
@@ -57,19 +57,17 @@ enum USB_SPEED{
 };
 
 #define TS_MASK         0x6
-enum TS_PORT{
-	NO_TS_PORT = 0x0,	/* 2'b00: Neither port used. PCB not a Hybrid,
+#define NO_TS_PORT	0x0	/* 2'b00: Neither port used. PCB not a Hybrid,
 				   only offers Analog TV or Video */
-	TS1_PORT = 0x4,		/* 2'b10: TS1 Input (Hybrid mode :
+#define TS1_PORT	0x4	/* 2'b10: TS1 Input (Hybrid mode :
 				Digital or External Analog/Compressed source) */
-	TS1_TS2_PORT = 0x6,	/* 2'b11: TS1 & TS2 Inputs
+#define TS1_TS2_PORT	0x6	/* 2'b11: TS1 & TS2 Inputs
 				(Dual inputs from Digital and/or
 				External Analog/Compressed sources) */
-	TS1_EXT_CLOCK = 0x6,	/* 2'b11: TS1 & TS2 as selector
+#define TS1_EXT_CLOCK	0x6	/* 2'b11: TS1 & TS2 as selector
 						to external clock */
-	TS1VIP_TS2_PORT = 0x2	/* 2'b01: TS1 used as 656/VIP Output,
+#define TS1VIP_TS2_PORT 0x2	/* 2'b01: TS1 used as 656/VIP Output,
 				   TS2 Input (from Compressor) */
-};
 
 #define EAVP_MASK       0x8
 enum EAV_PRESENT{
@@ -89,10 +87,8 @@ enum AT_MODE{
 };
 
 #define PWR_SEL_MASK    0x40
-enum POWE_TYPE{
-	SELF_POWER = 0x0,	/* 0: self power */
-	BUS_POWER = 0x40	/* 1: bus power */
-};
+#define SELF_POWER	0x0	/* 0: self power */
+#define BUS_POWER	0x40	/* 1: bus power */
 
 enum USB_POWE_TYPE{
 	USB_SELF_POWER = 0,

-- 
2.47.0.338.g60cca15819-goog


