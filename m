Return-Path: <linux-kernel+bounces-233896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF5F91BEEC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A673B1F2431F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D85171657;
	Fri, 28 Jun 2024 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="twqjjH84"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0164757EB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578713; cv=none; b=Z8lBUEsdkitawOTY1b/WS4LQniPi+xvhTvQsEe2XGmUrS2h47HvDfbQkPiHFTQoTM5As1Hactu900aEp592t1jtVrxjdJPeM9o5D+GX+v56lus3ytfZAkhVVsRf8ZxiYc5uZjlgox3jJOqqzKdNtP9yFLH+3FSrc6piYKkQO+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578713; c=relaxed/simple;
	bh=LUhQ8DOjFI0nAVmPoRbYAZ6OVRmmrigAYi6Li9gLvYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=o9z1Sl4oscnME+1z/aBw3Rc5jOjgO4jleuSVfmLnwMuUtsOlZGM37sn4/+iTCQjhPINWDweyEc4/KdDR62uXPsppl51sUEI0ZyVJBo4WI0Vf/7wC5+wXdN4Hp6R+CWfF0blJW0MFML8HFO9f1WfkpYgknZNON7dHDx8OjhTNxcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=twqjjH84; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6e3741519d7so360476a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1719578709; x=1720183509; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rg3tdU7ppY8HgCadeya2IfmEx35gEyixCgdQukzslp8=;
        b=twqjjH84MR7/uErEEBpp8BvlE3/2BlAfgOd29awkoX+vXAMo8uzAtrtfOOM5qwzFzV
         TkCxYbUPIUmD4+zIqfnsH19yBDXAY4PzcgMkbpxQ0JI0i23us0vRaHIvvkbjB1j1ZpFg
         ikLHPlhLkC8aaOmZrtmiV9JtpMSfxF0JNXSZQLlVtYmMxLVetKInjxrGzWFg9qtD9V6g
         9UM+FqrgasWbafWtLsPYWYxz4wqHYZtTx6pPcfQpRga1vLWsVEmSqPXgup9sJPoG8Gt7
         1iqYUfoi5BB+Rmur1fs7d1INTao04Gjy7nQvu1FWci/VDAx9NpZ+7l+/7/u5w+9o5G9k
         z+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719578709; x=1720183509;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rg3tdU7ppY8HgCadeya2IfmEx35gEyixCgdQukzslp8=;
        b=cy7amW4Y/uptJPa+5b8HPlsy0A6VY0YYgOrDPZ1dpqht4w5gTkh3Iz2lxXR2UbhPsK
         2Ix95kHAv0+fx9KOK/UUwLu9cTBCLtTkBw4aNtuw7b7WOGygVdPCkbKgMDIoNevtrCLh
         uZ1eTz3fPh7pVEvoUh+yrZcODvdhDdqEAi4tiKzOjI2FzYO05AEhM3YGKA/kaXMo87F8
         jXiz1oHUCmv03XnQHGNwJYn2Sn+NMjvsYZN7U/whofOUJ76Pe1kMg6Ebh2wTKNcJljUP
         tFOZD5kpJofAjkcLxpyH/Crvd3X19WjahkpBdQwWtyfFCvdsjw6B0jl4JFF6heaLviB7
         jYjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCufArZEdaFg0yN6o0g+v2DNNozUFT5pCMbfHi52eGrctMsvxiRX8SPtXsdJBHZppqP2wkhkALl9aLaR2GiGqWEKCshoHXsU2Wpk5F
X-Gm-Message-State: AOJu0YzH1SUgM3F6S7Avgw2gIjGdMsENNyokhuYk1NaNlg41a3mZqhMd
	k+4zmlolUZBwB8lYPR2Udvm1F5meMQu513GmJwqVFrH5ErayX/nPwPgkKNzTcfw=
X-Google-Smtp-Source: AGHT+IGi1fGSVYxtAxmFf/MTdTm122/UI6yNXUDQyXrOEFT3f8SKiRbbUQL8tC6sqxHVlH4xLvD96Q==
X-Received: by 2002:a05:6a20:72a0:b0:1be:eae8:9975 with SMTP id adf61e73a8af0-1beeae89b72mr627357637.15.1719578709482;
        Fri, 28 Jun 2024 05:45:09 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15695b4sm14346255ad.225.2024.06.28.05.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:45:09 -0700 (PDT)
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
Subject: [PATCH v6 2/5] dt-bindings: display: panel: Add compatible for kingdisplay-kd101ne3
Date: Fri, 28 Jun 2024 20:44:41 +0800
Message-Id: <20240628124444.28152-3-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240628124444.28152-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240628124444.28152-1-lvzhaoxiong@huaqin.corp-partner.google.com>
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
Changes between V6 and V5:
- 1. No changes.
V5:https://lore.kernel.org/all/20240624141926.5250-3-lvzhaoxiong@huaqin.corp-partner.google.com/

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


