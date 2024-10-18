Return-Path: <linux-kernel+bounces-371729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FF69A3F48
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC421F226B9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F171F429B;
	Fri, 18 Oct 2024 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYZ3jHr8"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AD31E0DF2
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729257241; cv=none; b=NDFlqlfZRrtkmso04smesoeCXJCtQw2gM9zVk9B8FINnB8d/tMa42w4qt6XyvhRUhUytfisYQTvoQ3kpT0vox6eygB30Y4qwy4MulBCf8sh05h6Zfuincl/ryNqozUfk7tXysauKmSmuUn5w+HUt4FX5thFSdYgdGd1uUU8I6Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729257241; c=relaxed/simple;
	bh=ug5jCdtMI0+B4bUF/QGKMlM43w7o11eBByOdR2+MeSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fa5I/KxnSAwOzGDzy1OHmllVN3LE6wU0PQPjqJyNc+6EhDpAwFaeX+tlyRQYI/xTrBQKS5GyPYuK/z5WcdJDxQhUJVF9WPDD/v1GKpZwZPKEupCXEzEaSEZLGY8pSRwzh5gvGEQZ7cgulEnUjJH0KudaSK+7fnwJWc+96vWCRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LYZ3jHr8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314c452180so21768285e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729257238; x=1729862038; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=slJkaosW6XMQOpTqyPk6rQj2FnZm8OhDSZzBFstpf7g=;
        b=LYZ3jHr8LovtvZ8sFTVTrvoRaXWKgbHN2vTGep4ej8Fs+eQ4Z1Fa/mK3ix/h+o9Aa5
         6xhGMyaNrH2dL3sxJHKqI8B7lg31N9Z0BtGXIaNBg5/IWMVim8awKJBUc3biwuDerCFt
         GHCbIfC3CV0tb/cJXOmZadPaJsotYhkA3zPedoEhrGgDzroqoLBtpLeR5C3TK2519KyM
         6fvF7PgJVOO5T3hdZLhVLkBzz1OPt35NJn8mlZNFkNC0p8tnsOjUrbTkXPjNfJHzm+uE
         Luhlgdiy2H3JbFZJQ2NDNriP026DDsVjw3CZmY0GT17mbThUgfu5xtCBHwc5ig7B04PF
         Zqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729257238; x=1729862038;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=slJkaosW6XMQOpTqyPk6rQj2FnZm8OhDSZzBFstpf7g=;
        b=NQpoQ80HQhlUEtCuG+wX4VwJfMhC9kATPyDWwyD18zxonWN9cbjFW7PQjrSZqoD5XH
         fNCQp3C1TdowWwt7gdMnBac434A2vfVdCduSZAHpIAHsSAXsyqzSoUnRf5fT9O2bAtOm
         XdIoCVPe1aR9EkQtg8r9CkQfGGQj0tF3KehiHULAgG9JnVYmLNe/o5lwWco4M0BlTmEs
         J0O8RCsOlfHRtRsU/RpilIcRJqFh8+Fh+1cCI+eIO4knCN0dJJ9VA/bPskJOQUP4RYYB
         Xd2oLKmeiP2uxPZMWAvB1a1z8+F2b7RAphLZiPGmuUgF6Zq+FJKuzKrnRRTO56LQO3m4
         63kg==
X-Forwarded-Encrypted: i=1; AJvYcCWkvqZTW/qaGEFDLMMyjADjKjP0eU6PIy+TtD2QQKpD8qMsTpu+vlGxoy7ehDfLEi7TahQBu9TmQZ/u/Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPjW22ZYOwSMKgD+hQnYFVzBiVSz1agTn18jmHM+WsLsqOAqHl
	GI5edoEtVFI0KzkvMxTzpEjgAICRhAZh2vLYACwkWtb2mbkFTnDq/sFuL8IfGi8=
X-Google-Smtp-Source: AGHT+IHTaWCjtMZo2yvANXCpoAT6BwaQPtKmWGyPC3YgUVT4hU9B4bthUkDj2W6aDK83oYueMqn31Q==
X-Received: by 2002:a05:600c:5489:b0:42c:b8c9:16c8 with SMTP id 5b1f17b1804b1-431616415f4mr15802505e9.10.1729257236139;
        Fri, 18 Oct 2024 06:13:56 -0700 (PDT)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf027e3csm1948418f8f.4.2024.10.18.06.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:13:55 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 18 Oct 2024 16:13:47 +0300
Subject: [PATCH] dt-bindings: cache: qcom,llcc: Fix X1E80100 reg entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-qcom-llcc-bindings-reg-ranges-fix-v1-1-88693cb7723b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAApfEmcC/x2NywqDQAxFf0WybsDRoT5+pXShMTMGdNQEiiD+e
 6ddnsvhnguMVdigLy5Q/ojJljK4RwE0DykyypQZqrLyrnQtHrStuCxEOEqaJEVD5Yj6cw2DnNg
 8fd2E4KnrAuSfXTnP/8brfd9fNsYd03MAAAA=
X-Change-ID: 20241018-qcom-llcc-bindings-reg-ranges-fix-76437ff4c99f
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3002; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=ug5jCdtMI0+B4bUF/QGKMlM43w7o11eBByOdR2+MeSY=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnEl8OTxusoEVgjXaF4HSD/+24Ni900zRicjnpp
 9BaNgYZg7qJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZxJfDgAKCRAbX0TJAJUV
 VpG/D/9f1kLhKvYULAvtFAeBM0q3KXExs1O3l5xUFcS7l+r8LEhtC0hxzlIKicZjSErMUO9QQUI
 fmuOQJS9k2dEux0opox0LujHxyxEVyYjyH+JGI0UsQg+r8d9gN1Pl0zqMbusY/Cpbgv6dhTJTYU
 ZbOGFyK1QyRt6WjgUhShsNxi3OUmKefMir5uMo69+1Q+Ac7BXfhXQoGwQy0uMtgQzBk74EQvmcH
 gYZp10I/wpWdTfjfKCLpW4rDVzym0czeyXASkK+4nnkRKSZphdZgL0XpM0TryyALg/mDHDs8GYt
 3Xl8GO3izqo1sKvz4E/KgPjXeJVxlGpCedNHGZ9+cljKpBY/2dfAwrzx6fhCHRhjPwt1VfPBMca
 d7/Rs9UCC+m4oC5oxcd3rnKIft8Yb5BJQe04WkXu5xyATg80j8zjJQjY9ozkP9LdDsS3Cp5dNyL
 9GUz01O0ust3L+C5K/xKar54khJVM3sV3NSYj/dlXjIbpPo/SB89v64tHVa5REHP68A1uGxqdfU
 3814dohqLlGXy5YVN8uU+wu3ws1I8JcAKCCu86sjYVjey008jYWPg6szNVrWyKTJYPu8X+zbn+/
 u3puwoPS90tZRYtwnTbAXdZbZuOt3Bz+S/+wzwYMJD/7xMRrMrfrHGup85szuQlcLnhC7FSKesb
 hiDJSQd7PTzIRow==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Document the missing Broadcast_AND region for x1e80100.

Fixes: e9ceb595c2d3 ("dt-bindings: cache: qcom,llcc: Add X1E80100 compatible")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410181235.L7MF7z48-lkp@intel.com/
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/cache/qcom,llcc.yaml       | 36 ++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
index 68ea5f70b75f031cd8b23cf48d566c3a760dab77..ee7edc6f60e2b4bf39ddc7c7ba8a8447c990c7bb 100644
--- a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
@@ -39,11 +39,11 @@ properties:
 
   reg:
     minItems: 2
-    maxItems: 9
+    maxItems: 10
 
   reg-names:
     minItems: 2
-    maxItems: 9
+    maxItems: 10
 
   interrupts:
     maxItems: 1
@@ -134,6 +134,36 @@ allOf:
               - qcom,qdu1000-llcc
               - qcom,sc8180x-llcc
               - qcom,sc8280xp-llcc
+    then:
+      properties:
+        reg:
+          items:
+            - description: LLCC0 base register region
+            - description: LLCC1 base register region
+            - description: LLCC2 base register region
+            - description: LLCC3 base register region
+            - description: LLCC4 base register region
+            - description: LLCC5 base register region
+            - description: LLCC6 base register region
+            - description: LLCC7 base register region
+            - description: LLCC broadcast base register region
+        reg-names:
+          items:
+            - const: llcc0_base
+            - const: llcc1_base
+            - const: llcc2_base
+            - const: llcc3_base
+            - const: llcc4_base
+            - const: llcc5_base
+            - const: llcc6_base
+            - const: llcc7_base
+            - const: llcc_broadcast_base
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
               - qcom,x1e80100-llcc
     then:
       properties:
@@ -148,6 +178,7 @@ allOf:
             - description: LLCC6 base register region
             - description: LLCC7 base register region
             - description: LLCC broadcast base register region
+            - description: LLCC broadcast AND register region
         reg-names:
           items:
             - const: llcc0_base
@@ -159,6 +190,7 @@ allOf:
             - const: llcc6_base
             - const: llcc7_base
             - const: llcc_broadcast_base
+            - const: llcc_broadcast_and_base
 
   - if:
       properties:

---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241018-qcom-llcc-bindings-reg-ranges-fix-76437ff4c99f

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


