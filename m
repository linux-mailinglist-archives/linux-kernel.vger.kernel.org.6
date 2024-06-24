Return-Path: <linux-kernel+bounces-227339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DB7914FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF4B1C20E98
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3D417C230;
	Mon, 24 Jun 2024 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="ARosYojM"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BFB16F90F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238851; cv=none; b=U5Symm48HX0k7RAVtHyC7bsT0qvJh7MwTk84MGfcfH20dJDCNjQ8cMEZNzteY6BNmIF25rebV9+beh5oCsO5HqGmrFItn9g+xm40siaif36sd1989ETlLvYhi9cxQqONHHW5kmmggarwnAYd72oBzV+wktj3FZwzekEcdSuRRsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238851; c=relaxed/simple;
	bh=8arzML0IG2sFbgXDqCLu6LPEnziu0B32300+4u9bdHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IhSOA3ULMt5tdHNsPybhUFD0fjKz67ngRjRgJTki0vSyL111T8FAnmJUmEe33luGlu0sXukLRKa2fj+KfGATN4Azs7hpGryUJQHXlI2YXkFXPSvkexHRp9n0OvgIVY4fHSqer9bdhOqqM7RumCeR+LhjWXH2LmUuTXB1iwTThRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=ARosYojM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f480624d10so36360045ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1719238847; x=1719843647; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M3QDpDGSiXVB6sCJx/S75ptPOlykstEPjTXSR09Xt04=;
        b=ARosYojMEVHzEN+6Wlo/6NVOi9967RBTltHDI6vZWoKvGA7ZINg5SLpS/iTSLXw0OF
         VGFoV/I96RHKy7cDiA+Q8tL3jaZyo2enMjc/VOCWRXNlfLiUsIiPDRgeW7bP5tb3HgkS
         pDpV7ckJLrKlTS84pu04WdrPUY+Zm91WAx9ymTWrZNNsg3nBfGDts0LyYqPrtclgq62E
         mWbPQaLOxm+uczo37lo5ixrDyMaWoRBgCSxy6QMuF49ZCrpk7xPQp8D5AvrsV4r8B5yJ
         Vmr1LYsh+pyrS0+7yS9Pzldo5gPz+n+Z02qoNUewDdmVDW+k/uApMNeCfzcCE3jTkMwe
         o+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719238847; x=1719843647;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3QDpDGSiXVB6sCJx/S75ptPOlykstEPjTXSR09Xt04=;
        b=NpokiSLPJU73VyRSjzOjxnqNbHrSVewdDosBn+pBbkfCEs1iSOY7eKmx0SUXy12qkZ
         xNJtzKl/Hv1XHfbjIrBye5fWmRfmkVfVFaaCe8pApE/K38GAa8U1NBRQ9f8JiquF3t6x
         K45hNy7n+KW1E8SPKvyTlNXKN0YHlFKc2o/HuVZV8ynMt01o8bf6ogX3qTde06alOPEz
         71yO51l2UYvc+i88OPGo3Yjmz+9DPGtJyQZdIgnqRDiRwSrDT1tcniwgNjU1THnbZGsW
         xAGEN9JVZHw1JqylBvhzwe4uqc+uRtZ5LuB8AvH2JjOiF16WFInXneRmXGhNZk/iYoXD
         du5g==
X-Forwarded-Encrypted: i=1; AJvYcCX4oaAIglL5DSfWyybbnZl+YTsepZWL8TtzpIZUaDPaKS1estP+M5gEv7ai5WIEQ1+iQ5laefLCLZLql68ntO1Z4c/TVv/ePqemNpXa
X-Gm-Message-State: AOJu0YzBzaX/HesIcyAcepjnqKiSV2F7uXyxAEC636yYMJ6ZeC0aeCSm
	oTJ9rwV0XMLtk7wq9gKGQZUdvntavEB2L7leGgvckxWM+WsNJ+IND+Vn+O6mpyY=
X-Google-Smtp-Source: AGHT+IHz4Xp/LpklfhUfQXhOMNMuea5mCAmDWme6R/bx8xDnAu6GJ4Ix+irnGQPPp/6YUn4bmuc0BQ==
X-Received: by 2002:a17:902:c086:b0:1f8:393e:8b88 with SMTP id d9443c01a7336-1fa1d6acb3fmr49875875ad.67.1719238846980;
        Mon, 24 Jun 2024 07:20:46 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5fa9sm63243855ad.206.2024.06.24.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 07:20:46 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com,
	jagan@edgeble.ai,
	neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v5 2/5] dt-bindings: display: panel: Add compatible for kingdisplay-kd101ne3
Date: Mon, 24 Jun 2024 22:19:23 +0800
Message-Id: <20240624141926.5250-3-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kingdisplay-kd101ne3 is a 10.1" WXGA TFT-LCD panel with
jadard-jd9365da controller. Hence, we add a new compatible
with panel specific config.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes between V5 and V4:
- 1. No changes.
V4:https://lore.kernel.org/all/20240620080509.18504-3-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V4 and V3:
- 1. Move positions to keep the list sorted.

V3:https://lore.kernel.org/all/20240614145510.22965-3-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V3 and V2:
- 1. Abandon the V2 patch and add kingdisplay kd101ne3-40ti binding to 
-    jadard,jd9365da-h3.yaml again.

V2:https://lore.kernel.org/all/20240601084528.22502-2-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
-  Drop some properties that have already been defined in panel-common.
-  The header file 'dt-bindings/gpio/gpio.h' is not used, delete it

V1: https://lore.kernel.org/all/20240418081548.12160-2-lvzhaoxiong@huaqin.corp-partner.google.com/

---
 .../devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
index 41eb7fbf7715..2b977292dc48 100644
--- a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
+++ b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - chongzhou,cz101b4001
+          - kingdisplay,kd101ne3-40ti
           - radxa,display-10hd-ad001
           - radxa,display-8hd-ad002
       - const: jadard,jd9365da-h3
-- 
2.17.1


