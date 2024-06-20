Return-Path: <linux-kernel+bounces-222210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB9890FE46
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613191F241CE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F9716F8F2;
	Thu, 20 Jun 2024 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="S3qPcCle"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358DE15EFCF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870739; cv=none; b=rmLyyzrjTt9jenAvyFmyAiAjgodrrCWsJDnut1ohIdOeoB8Q+rw+FojKZbn1eiekGVefsW9L+PqRPaJaMA1JCb4v8JkyaF0hvId6+FADSakq3UUQ0VBygCua9q5FzBmfQ90eAL6jAqRnX2X8b/LlIs+lVHOrwaCvRzxFtpT/mjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870739; c=relaxed/simple;
	bh=UFGisn03v9yhYedeo/3KyA9pLmLDEAPEB+tRgkSWm+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lQBhKxZyH816N7gEyFdimn86gkVC69eJlnyIjUblRcXhkUxPbSgkAlEsByqWl9wNXwe+46NKAEsjJ2WQWgPHbJowIQv/viNspzlTAUc4mz8z24miuPkwsEXZcfi2U7r6nQWVa2a02Cpi2uSvFhSgBbIDnAQ+TySODyQxe/eQdxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=S3qPcCle; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-704090c11easo498459b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1718870736; x=1719475536; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Y8D7obmprqKPMpE+xyGcQQXo6scFeZnMh+CrPUj1ro=;
        b=S3qPcCleYLAfk377aD6UUw5mBflqxiNePc7Gl7RfBAR23nlqfBeafemARzbrYnpjYb
         L7AKVu10hd+VIYtUDrb42D2At9zMlEc4/wmIS5XOJixccp/cklKnl7MCn1TzQoXWMRFj
         xzKnuoRxoyDoKkMThNEqPsOJsmyFb0w4Pga3cFGZVwr6k7qtrcS86Hv5KXSMfaXDLiFa
         JhmLmUzgKcBBVF7OactTJgbUgt3+Xoa79Mj08/m/Zhp+9nB5aYKFCl5Q4yFqJMAV0Q30
         deLDjFoKpUIeoaRNDi9LBDp8cceMwxRRGZlBW+HwS9H5rlIPLaRAfmGiIvOmXkfzHc42
         hZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718870736; x=1719475536;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Y8D7obmprqKPMpE+xyGcQQXo6scFeZnMh+CrPUj1ro=;
        b=phWpsUrtv41igxu/6F88pY+53i1OBS0LF8M3jvKf2SlMtXBgEgsKlzjZkulF7/37j/
         yFxF3UbMImObGLmVlmS+H5ZEQ8PLwoIIcPIaV9xyZ59T/dH/mExYMQyEPJUjfXyEa1G5
         MjWWNPu0uKKJaHpGfwMwdGmzFRKT18IHlXfW8cvdVlpooltznfga0jez4scNiJzUh5vc
         6BVa8N0t7p/zvRRKaIHkInvjZEj4W6aWIKhiUjsoW4nTZFPECaz8D6HM6MlEh9DN19p2
         EnYGUym5sDE9G9dVGykdPW+qfTJvh65TymZ4WpJsMhShBPtsbQ+Kj37qXZFW4dCqFIMC
         I6rw==
X-Forwarded-Encrypted: i=1; AJvYcCVTlxEZkiF4e7bQJC6VS6bno96mUacOI0/s9Suna4Fftx1sZvYJiIrNDd9Z5q4fFLOFG+xDt+uWutuaZiUfvevYgxpRBTTNyrlJ2J2n
X-Gm-Message-State: AOJu0YzKaauM7AvdChh7qPiudSp/mQUh/jzJpyixEm5PRIVI5GaXrgFP
	6qzwUHPmNjFw8tJf/hVrvUc9IauBYr6UezTBYXV5ua77og0JvUwk80R17wUm45E=
X-Google-Smtp-Source: AGHT+IEWX7tMPhLCy+EIc3J3GNxEI9rtrbsuhv+fhFcIU85LqU78MlejcJmdCThiVyNmkHK565rXEg==
X-Received: by 2002:aa7:9e8f:0:b0:706:3405:fef7 with SMTP id d2e1a72fcca58-7063406032fmr4114904b3a.24.1718870736448;
        Thu, 20 Jun 2024 01:05:36 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96c8c5sm11805889b3a.58.2024.06.20.01.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:05:36 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v4 2/4] dt-bindings: display: panel: Add compatible for kingdisplay-kd101ne3
Date: Thu, 20 Jun 2024 16:05:07 +0800
Message-Id: <20240620080509.18504-3-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240620080509.18504-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240620080509.18504-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kingdisplay-kd101ne3 is a 10.1" WXGA TFT-LCD panel with
jadard-jd9365da controller. Hence, we add a new compatible
with panel specific config.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---

Changes between V4 and V3:
- 1. Move positions to keep the list sorted.

V2:https://lore.kernel.org/all/20240614145510.22965-3-lvzhaoxiong@huaqin.corp-partner.google.com/

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


