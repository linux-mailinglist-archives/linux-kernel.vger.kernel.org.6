Return-Path: <linux-kernel+bounces-196017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 275A78D561C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25A9287C45
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B26D1862BC;
	Thu, 30 May 2024 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5XRYHhB"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02E574042
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717110782; cv=none; b=OSwK7tvQF2++VQTzfJoP0Zba2aas2HIiKcdaNBLyKxN3AjWfsKPqyRkaPzaqtR33noqXjRHnG60cvLRREncSe0hYQu6NbaIs6YqPdr+OxvL8Jr8WSFBMR/hNThYRri22PZ84IVmz9Aw6csg2UHjghpX+vTiNlNifHsCG/2z+UTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717110782; c=relaxed/simple;
	bh=XBZ6fSg++oMZimfKiEFT9ckJ+C8xAqyph6b+iI0KMKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z0Hn+WBfwzSOIpJ828huI6vEhi0MNzx8GXqEOgeByq6H1eVQtBnX5O+ZTv8uaJMwD4F5M7tMi6Lix6VHWVFcif/2YhmkpZ+MwBxbdIr6Vw4qgxAEAJB5DIfuHOOnKP9IKCpWZqy0E8BulHLVyY7FgvIkL7IUBw/0MvvcGLMWuPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u5XRYHhB; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b86cfcbcaso490652e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717110779; x=1717715579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+qOoN0EVfQIJq5I0wkGIsN6OuhlGgSySEsUl1KmSJE=;
        b=u5XRYHhBOl05aLjMqOWVuH3SnQreyez47eCxsKZjwGh51DhULwgqR1hb3+rF9U0qDa
         LQgOmJ9Oat7NuquCD0I8HpIJ7X7W/el3K3ScQ0K7kN7mUc3UI0xIVq8QwFHauwlyZtav
         RpqXDzjNj8+1a3FxVV18BvCgdxGKLW+dC0UeNbD7HKVU2KtQ/iyJhPg9SAqJgQGgtmtx
         grCG6X4s81EvSJjcaUC6xWSQoXch4PU0JrDXVzHLAw4En52crJGHmuk3FIrElJNMMQay
         Wr/MnMwRXviRGc6SX8O8sOl2WwAxalbbk4/pnSnFC9GYO+IRWJ1LuUYo7PVyPTl5CeeM
         mT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717110779; x=1717715579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+qOoN0EVfQIJq5I0wkGIsN6OuhlGgSySEsUl1KmSJE=;
        b=J4lZ9Mk4p4gErCvFCNHt0dAPaqnJanhesQXy4GenhPidy2ZKK2XSXugd772LMYY+pr
         c4V4I2gsXM3s8LJl4XjHni9Cbh38INA7vEgpxfE9ff5L1bEz+KLiVDYr2816g4F800/7
         g9De9F1U+nuD9IrXX8RxO32c5r61CUbQYS3YFjbm8cEzAksAKYFk4vKdm2zLMRW36QA9
         Zn7OLLoeox5iXll98KBpAQln6Tm/4AneGqPK7qvNx+jlLWa1LilZ1+pao5dTVq/vs3rp
         j6o3Ao/DaIzcmcGceAm5Q+WzbAuUoO3M8FWIV//jfCOFvryG7AIn5NxU5bLBdzkK48cd
         cmfA==
X-Forwarded-Encrypted: i=1; AJvYcCUSWvsnoTQsVrmKHSwoCM88mbn1DnzGfI8LoDP82fJ/DuJIc47fug+3bvno6Um6doTHpAQKWxHQUuKMUAD/KadXeOnmcdlZ57Iefhbe
X-Gm-Message-State: AOJu0YzsYLUy7/LPIq3Ir1CM4mjOTqW9N2TF5ITnUcpbrkZodcTTZnaV
	Zl80srsEu1woCXW1Vxfk0qaD3b2rHKaS9jQxVknlaSYQZWhOpQ3sdJjJ+dOl9iU=
X-Google-Smtp-Source: AGHT+IEV/5BqrG4ACKM6rhd7dA3ytRF7wYyFY6D69GLmeOZ4hii09yG9fwmlf9CX59XVNOOJna1jFA==
X-Received: by 2002:a05:6512:3447:b0:51e:f79e:15d9 with SMTP id 2adb3069b0e04-52b8954e8ffmr60363e87.21.1717110778649;
        Thu, 30 May 2024 16:12:58 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d75d96sm119005e87.120.2024.05.30.16.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:12:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 31 May 2024 02:12:56 +0300
Subject: [PATCH v3 2/3] dt-bindings: display: panel-simple: drop several
 eDP panels
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-edp-panel-drop-v3-2-4c98b2b95e3a@linaro.org>
References: <20240531-edp-panel-drop-v3-0-4c98b2b95e3a@linaro.org>
In-Reply-To: <20240531-edp-panel-drop-v3-0-4c98b2b95e3a@linaro.org>
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2746;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=XBZ6fSg++oMZimfKiEFT9ckJ+C8xAqyph6b+iI0KMKk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmWQf4cuAqciw3f/0F3C1tf9A7KINZ9JPXqdn3p
 YO10u953OiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlkH+AAKCRCLPIo+Aiko
 1bdNB/9oeC31aBN0EKZTkF+/ih9KAMVShpEp7KjdxBoSJbJItjSwt6o6FBbFlv1NlAgxGUFl+0n
 4KWeXZHdQhzi2cfB30K0+oVQOEoBbqnanqT+4kmUhdiB09rvzDlZQzdQ2B5su4DwgoAFprBzhPl
 RwYWjW0iwP4VfWLfsuOH05fXLCmELpXi83PpLslolrZJhnc59BRcJDb4/rWBXi6m8UBm6vQ5EE8
 lkJWfJd0OACREKHyVI3Teow1+1SNcKf+dbDlIyy2jmK3W0WqN24qym1ttA2zm5wq2ckLwVWe7sD
 Gg1TRRMU9QUJpt3nArfOx2aGui4dfySrA3cu1m++io6m47Xg
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The panel-simple.yaml includes legacy bindings for several eDP panels
which were never used in DT files present in Linux tree and most likely
have never been used with the upstream kernel. Drop compatibles for
these panels in favour of using a generic "edp-panel" device on the AUX
bus.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml        | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 5067f5c0a272..e5ed51226433 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -50,13 +50,9 @@ properties:
         # AU Optronics Corporation 11.6" HD (1366x768) color TFT-LCD panel
       - auo,b116xw03
         # AU Optronics Corporation 13.3" FHD (1920x1080) color TFT-LCD panel
-      - auo,b133han05
-        # AU Optronics Corporation 13.3" FHD (1920x1080) color TFT-LCD panel
       - auo,b133htn01
         # AU Optronics Corporation 13.3" WXGA (1366x768) TFT LCD panel
       - auo,b133xtn01
-        # AU Optronics Corporation 14.0" FHD (1920x1080) color TFT-LCD panel
-      - auo,b140han06
         # AU Optronics Corporation 7.0" FHD (800 x 480) TFT LCD panel
       - auo,g070vvn01
         # AU Optronics Corporation 10.1" (1280x800) color TFT LCD panel
@@ -172,8 +168,6 @@ properties:
       - hannstar,hsd100pxn1
         # Hitachi Ltd. Corporation 9" WVGA (800x480) TFT LCD panel
       - hit,tx23d38vm0caa
-        # InfoVision Optoelectronics M133NWF4 R0 13.3" FHD (1920x1080) TFT LCD panel
-      - ivo,m133nwf4-r0
         # Innolux AT043TN24 4.3" WQVGA TFT LCD panel
       - innolux,at043tn24
         # Innolux AT070TN92 7.0" WQVGA TFT LCD panel
@@ -310,16 +304,12 @@ properties:
       - sharp,lq101k1ly04
         # Sharp 12.3" (2400x1600 pixels) TFT LCD panel
       - sharp,lq123p1jx31
-        # Sharp 14" (1920x1080 pixels) TFT LCD panel
-      - sharp,lq140m1jw46
         # Sharp LS020B1DD01D 2.0" HQVGA TFT LCD panel
       - sharp,ls020b1dd01d
         # Shelly SCA07010-BFN-LNN 7.0" WVGA TFT LCD panel
       - shelly,sca07010-bfn-lnn
         # Starry KR070PE2T 7" WVGA TFT LCD panel
       - starry,kr070pe2t
-        # Starry 12.2" (1920x1200 pixels) TFT LCD panel
-      - starry,kr122ea0sra
         # Startek KD070WVFPA043-C069A 7" TFT LCD panel
       - startek,kd070wvfpa
         # Team Source Display Technology TST043015CMHX 4.3" WQVGA TFT LCD panel

-- 
2.39.2


