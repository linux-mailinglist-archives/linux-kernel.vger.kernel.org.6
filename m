Return-Path: <linux-kernel+bounces-193242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDDF8D28F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 01:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FBBDB20DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCC31411C6;
	Tue, 28 May 2024 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1sIicGx"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984413F450
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 23:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716940381; cv=none; b=A+Ooz9haFGZRhorWwAB44QF4j8rQ1ig/quhj3OKpRw1720jWB7Kt/wXD3NNW3QzY4GevQ9UUy2lQMQAeVmx9lTl664j+6OR2fBz5q/dIruCLqRpFQ1HtoJWF+AtsxeMYMX7PjJ1ybOWumCHnYw0Nf9fcxXqzlR+qw0GYUqKbiNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716940381; c=relaxed/simple;
	bh=DdrfEnSvoeRW1E2r/WH6/wGMDZXUBm6mjy8uD45GQWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+5OuO0IaekiRwOwOl3WiF7D8TzbkBPilhOUJ06ke2Exi02hVXlGnh/wpoHRRkYygEzm4OzBDgqYvuLAyaJNQRfRAziWl8ICC3NVVKf62KiVkE8RbPgjwWltFGibhugUrBUB06n1a/doV6Ei4f1oObAQ8/wyT+5gAW2nHLAfiqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S1sIicGx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-523b017a5c6so1961033e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716940378; x=1717545178; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epU7ofKFUVORXm5Zp3LH/iJERgxS72joIk8yaDqIF6g=;
        b=S1sIicGxuAr8VutaznGQP3SCfVXMALQ0ORGuatuXJH0htY83kSCPiQk03f09kfkAsK
         5cNgoqBoUB2C4vQHYABD4jHm9jKTurLm+CBNXteuEpIUC3UpBQf57eA0WpkKtxzahmhp
         uhFSBy7sIy8KCcGs/hUJOYt1/aOz+hHHLLkxOUZJR3oTGrr5wGx+Eef0sEM9YhqvUPwn
         JpgxEV64cGfzk1LVtgvtegEF21JgG3Y9KPreg4pzQ4b28DhAuI2nSyIgnAMNw0oKZqK9
         AkcySo3GeqUckZjOs+WfK9Weucnoucv9KJ2+KiIH2Ch+044XmpF3j0LJDKPwEjBD+s+9
         F+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716940378; x=1717545178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epU7ofKFUVORXm5Zp3LH/iJERgxS72joIk8yaDqIF6g=;
        b=I5Uul9GZOiZmE62W11zTbUDRtpdbQUs0aq+BpZ7qjizFS3++Tgv/91qrGKc/j9mB6L
         7lOStWxdETbNmkzifr/y7x92tGtfUHeFu/3JWt22+bPriFnyXuj1w447nzbcoitxFoqw
         wy4NjIPSq6BKyuoMyY4DeqhGwUNqLNIDQgKALb8Nwhg/g1QGYCgB5H8Dpi6eEuKTsiFs
         y85rhjly43aTVO73Ud/XTtpjN3JS8hJi4fSIhdFeG9U6RiRPjNnUmGhz5ymamTgdwqy3
         cDeCl67pPMYA45aurjJUFwWB0xOThNlLm9C2z4hk4FeiFtWyyBFQp1R2R1It3h0bkHJp
         A9BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmISX1b61jR9xPkhPxiBDLtzd0SqH7gLDqvjqj+gRa6pSEM64dyOEKtz+H9lwHFSN+jAMRepnR1uQ0qU4GrC1hX4Eq8wEEi2ejJNvl
X-Gm-Message-State: AOJu0YwTQQCR8IuYczsCDJc9koLYzaiLOYJDvj2yazfIbbRPUMFKz2O4
	gw69sJplKvAz0AZA3ALYT/HSm0yKy1/39iUEl0aABYMGBBCyyLfSJMkGAl5iXqjNdKowtkhUKxQ
	x
X-Google-Smtp-Source: AGHT+IF7uwaZgGb+yrWIOcUgI06JtcHOSDj/jnR7jimtQ12vuH4mIz1Vlkr4CD0g2/t5KduQ//gZ5g==
X-Received: by 2002:a19:2d5d:0:b0:52a:e7c7:4ce6 with SMTP id 2adb3069b0e04-52ae7c74dc6mr80914e87.39.1716940377383;
        Tue, 28 May 2024 16:52:57 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066bd0bsm1099869e87.165.2024.05.28.16.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 16:52:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 29 May 2024 02:52:55 +0300
Subject: [PATCH v2 2/3] dt-bindings: display: panel-simple: drop several
 eDP panels
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-edp-panel-drop-v2-2-fcfc457fc8dd@linaro.org>
References: <20240529-edp-panel-drop-v2-0-fcfc457fc8dd@linaro.org>
In-Reply-To: <20240529-edp-panel-drop-v2-0-fcfc457fc8dd@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2691;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=DdrfEnSvoeRW1E2r/WH6/wGMDZXUBm6mjy8uD45GQWQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVm5WY3yuKK2fQT+EbUmK8+P5TRcjqhHWqwSbS
 Z01hMfGKEeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlZuVgAKCRCLPIo+Aiko
 1eMRCACqLWRAzCgQAAIxGTwJ0u8YzGQCPZ3qN1HasotTwLUL35ficmtV5M6mL3J0NV5Q0E0fvyp
 6zHSZCfHRospwVgWkajrmaH/s+e4hEeBWvquC7k7JfXAA5U25rt8/E2jspVca65nSo/UbGkvI4F
 10Zul/rRkDoiyY1QVtpkPbX0gMSPt/xbU/cXSnFq/Xp8PQq3y73FAre/O8zchrJIX0kO6kuzr9w
 GBikOcttFJrNQziQstd8LuW1ITRwwMlE2lkDoBYSnwQoa9VrL8sPMmpuf8ybonypU5eFpkVL/EW
 8fDZF7tt4Znz/9RV2hXKZlora4vva+EsjNus+HBTM3aHP1+6
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The panel-simple.yaml includes legacy bindings for several eDP panels
which were never used in DT files present in Linux tree and most likely
have never been used with the upstream kernel. Drop compatibles for
these panels in favour of using a generic "edp-panel" device on the AUX
bus.

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


