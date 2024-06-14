Return-Path: <linux-kernel+bounces-215058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2A5908DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70796B27F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5228E28DC7;
	Fri, 14 Jun 2024 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="bVChjnLq"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AA22575A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376933; cv=none; b=msrgque8WM4NgPvKF3lZxPKSwythWu7gEBtEge5F6Tgv5W30AJ4V01WWF8UgJfFbOr76E3rW/TM0iYXxEYZ3aUAIntwKteBXf5E5J5U4FtGo8dU1yRdJg6oM5gPFgXGV0esNBRyEOTg7udrl1jKZ8AKsOlWqp/kH+k+9+06eNBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376933; c=relaxed/simple;
	bh=j7C9ndRbv2cuR6g3h/5nj0s71A1LC5LA+DFYILC5I6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MtikKqMGuPx8kRruveu4Zph5UjKnX96QHAy3OWCy5Dh4v5i/np8sZ/p84VKwibtEhysxSROr0n49B+Es7V5qmgoNXHKdG6g0fufE0WlQbiVfLeuujeBnA61dBMCNRYU5ajV6nt0Z9Xfqdf9JkgshW0NWO+w5IjwExM4BbiKySZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=bVChjnLq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f47f07aceaso19773475ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1718376931; x=1718981731; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N/AP/1V40+BXRCtoO+lC+4Br3T26yIArvUV1nzkpXog=;
        b=bVChjnLqGUQ9cMqPhhitild93hHbC0ytbwLCFa7M1Bggvp4PT+aPQGOwrd94IuQLwP
         CgI7HkVDBKDwx4WFccuku+XwlmsMQDPxWyBr0ypiwo/sYA47Hsf1k32Hnu3I6CBpCiqj
         Cwu/idhKkhvMZO3YO7usdBhj4HjxS3rZtHyfWSpq0Ij+5LElH/q3Y8FyGr8cGW/flaJi
         viBZerqR0c1EpMGo+RUFnm6YHEuyXjJxyolI8dIraEdHVbKWOk/n5NJQZpjFMfagP6hm
         0p4c4ikryAMobEOw6EGZjXFx5/CvmhfGtRIfVwAwxUt4ZsFlqshGlIOQqyxGrhIJAQD/
         0Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718376931; x=1718981731;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/AP/1V40+BXRCtoO+lC+4Br3T26yIArvUV1nzkpXog=;
        b=RF0wfJS9YQFuhtoh8z4TbI/VTK32a3gTRDTcIZL8cw/ZJ79aSs9eDC+pIcO34vcZFv
         /Sr/Vcy+zR5JCsWAwYEln+G5su0/v8+YXVJxx+3JDufOM7fpePKH06FRQAVpZlHDb5nl
         ZbRui8QvWnH6XktK/qZhGCoz8Bf0LtxfLuP29B7lnHkk3xZPTTYFNRfIf6+fQwzPWHkk
         lJMYvYQFCgh7lmCSaWdnjC76GWxLH+mqKNRKSMzayskHK0JbvI9Xi3O5cLYDyIwDFU07
         USHSSy1rlUPwnHMnHM98pC1R2JbpOHZLjDCyhRtl2g5FYi9mLDdef+XOvFXWTyLCH5Lg
         p8YA==
X-Forwarded-Encrypted: i=1; AJvYcCX20fVJizDTo3/j/cp/mRAqvd0Tk8MiFE0b7HqkkhbcMoWnQ0fit+PNdbgPoB1JYzIErjZwXcWhUMLqrTkWHStP6rpCNC6CBe7uATYL
X-Gm-Message-State: AOJu0YzjilbaPEuhl1E6C4VtJzm3Jct9XGa/wbw7No/Ya3bRweNGbQ0n
	U37EvhvVtR6JjdtyXEm1abRFXXZwtOEbfomoblP+2j8mmOFRdGAe9kKkh/XtWzo=
X-Google-Smtp-Source: AGHT+IF2LhG6H8q2Mm/Niu37KRm24BCPEwk6H9tjmqhMSFmBKJ18yVkB6S4FTD6erB7IdCv2lO6EhA==
X-Received: by 2002:a17:902:ec90:b0:1f8:69ed:cfe1 with SMTP id d9443c01a7336-1f869edd7c5mr19731945ad.53.1718376931373;
        Fri, 14 Jun 2024 07:55:31 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e739b7sm32914495ad.93.2024.06.14.07.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:55:30 -0700 (PDT)
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
Subject: [PATCH v3 2/4] dt-bindings: display: panel: Add compatible for kingdisplay-kd101ne3
Date: Fri, 14 Jun 2024 22:55:08 +0800
Message-Id: <20240614145510.22965-3-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614145510.22965-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240614145510.22965-1-lvzhaoxiong@huaqin.corp-partner.google.com>
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
Chage since V3:

- 1. Abandon the V2 patch and add kingdisplay kd101ne3-40ti binding to 
-    jadard,jd9365da-h3.yaml again.

V2:https://lore.kernel.org/all/20240601084528.22502-2-lvzhaoxiong@huaqin.corp-partner.google.com/

Chage since V2:

-  Drop some properties that have already been defined in panel-common.
-  The header file 'dt-bindings/gpio/gpio.h' is not used, delete it

V1: https://lore.kernel.org/all/20240418081548.12160-2-lvzhaoxiong@huaqin.corp-partner.google.com/

---
 .../devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
index 41eb7fbf7715..6138d853a15b 100644
--- a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
+++ b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
@@ -19,6 +19,7 @@ properties:
           - chongzhou,cz101b4001
           - radxa,display-10hd-ad001
           - radxa,display-8hd-ad002
+          - kingdisplay,kd101ne3-40ti
       - const: jadard,jd9365da-h3
 
   reg: true
-- 
2.17.1


