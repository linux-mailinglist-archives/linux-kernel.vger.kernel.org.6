Return-Path: <linux-kernel+bounces-190625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 189078D0097
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33DB285FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBBE15F321;
	Mon, 27 May 2024 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xRduAUbn"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB0215ECE4
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814608; cv=none; b=uDkKtASCNg9hYNqJtmst36PqOb0xj/NCqt20HD3foMnnjlq8xk5780IK5hsOaIRoRegKxKc7ekxIT6wm7T8M2cf1Kyc1UnuOI3okQqJC8hiOE+ax3BuscuHPq9IEDV/5T0IL+qpvwdevlRlbx8mh+H+aReufatJw/Ml8tTmj9Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814608; c=relaxed/simple;
	bh=PmL0knyiFwKjqefmONOyJvZ61yztGXVY3oaQIhEJ+f8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/ATFfdHorzit4C3FzbtWIBzex3i6LwuyIsieqdNKFrT2w/m3leTzLl2MqnEuSvl3K9jCQ1TRrVcIVNHpShupYlkkJCr3zMwCPbZ4GYwBAofPY5rilNjxRcZJ34KmARLCQHvtFsrAT6ipN60T7uhh3Cio31thGL5dNfQE2jn8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xRduAUbn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4202ca70287so32184545e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716814605; x=1717419405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSVtWnldnZQllmMbRum27BL7QtGmRA5VldXfXUSrfms=;
        b=xRduAUbnD8fVQlyKaI8HA7Aj387MkspIRTZJcW6yN159iUs11oceLRHHZEiZ2TDrIn
         T4r+aTzvZYyoHr7sMG3XunVUIQAOu6Kpn6ogB6xnujG5yuwlXMe6ZD8tojMTM2+TAAjo
         z6UCjWV7+CZgaA2xEwVxU+GGREUXtu8MQll4KJLwuelSErjAKb3cS3kkUjvqzaMEGtSB
         /HgR10kmUINxFY9QPStcCGSu16hTGC54T2PP+BZBJVH5RvMie3LiR7MMgwnOSDavPRHj
         5aaViZYigaNktnRtzmWKMdz1RjUQHwGvZWC48UBInnSE3SSnKSPweIztahQJNn6HW9Pf
         YMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716814605; x=1717419405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSVtWnldnZQllmMbRum27BL7QtGmRA5VldXfXUSrfms=;
        b=NBkOFxMy7LM2SPMsidW9PH8EmbzylTMKyTS7KZZ49ah5k7b1bxTj07ftxwgqKvIiHX
         uw/0csicsMvXY4yLsYP2vMFqUtftfIJWxRisRhMX9/qudZ57Ot0t6zzoU+OS8RlL8WU/
         ccU4NNAHXLAIelwt5c0otpirAT/JJkJ8pq+K1KMNE1DGBlsPlsPgV50Wlf1vL4fVIV2E
         H9EI7HInfP2eotg7b1kIcsUdvSpCmRi2+NJeO3Ol2Iyn3psCMuZGWc26cRojkM1pZfNz
         SK250Mx4TT7mXAFEqE+3TugoPXoyq3+fag8NvYVx2A2QpIKivtUG3poTZy6stBVEjAQG
         YY+g==
X-Forwarded-Encrypted: i=1; AJvYcCURlIIndONP6drCzxuX9eXj4ZXoVj4g86m+BPygldZDkHCAZCU1DlOjapfik9swBiPmpSGGyIZLcsu0t2g96j0wHtyLNYAwjGSY4s1D
X-Gm-Message-State: AOJu0YylVrcfqnBetvM9jxVqQmx+PIqrGjhx+XMqMjjZzLQPFk3DY5kL
	jmFKuu0paPVN42OgyzIlXU0ohNMJzvA1H4dedIOCDOYG5zwV3IQF1lhrgHZjiS8=
X-Google-Smtp-Source: AGHT+IE2BMX0ptrnaHXWfVKJZpzP9Mk2ADilIQ8OTVQeSpBoDDR7X9tWYL6FLYCjkwvu7KQgee4WLg==
X-Received: by 2002:a05:600c:4f90:b0:41b:f979:e19b with SMTP id 5b1f17b1804b1-42108a18a20mr82816285e9.39.1716814605588;
        Mon, 27 May 2024 05:56:45 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:c322:131e:ff9d:ef41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f64f98sm138753635e9.24.2024.05.27.05.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 05:56:45 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 27 May 2024 14:54:51 +0200
Subject: [PATCH v10 01/15] dt-bindings: firmware: qcom,scm: add
 memory-region for sa8775p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-shm-bridge-v10-1-ce7afaa58d3a@linaro.org>
References: <20240527-shm-bridge-v10-0-ce7afaa58d3a@linaro.org>
In-Reply-To: <20240527-shm-bridge-v10-0-ce7afaa58d3a@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Arnd Bergmann <arnd@arndb.de>, Elliot Berman <quic_eberman@quicinc.com>, 
 Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@quicinc.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ImiNTKfKDCEq2Ei/PD7lBaqJ136fJAWHXhcyLN3vk+c=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmVIMHMxbQga0jenpeezcT1mcfHP3O2WFdrsXNk
 TEZx9DPVBSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlSDBwAKCRARpy6gFHHX
 clpRD/0aG7ylQh4jojsxziBkTqtk4v9MTFH/EBs6S4/0Gt7VqiXwXp7c4Ex8QSma6oUMTce68GH
 puCIl3MSyEhgTnJo3iso4WVwG+7BH8XKQ2rK8xF+iPo9jjgNpgaEMYywaw9C25BRpjDbYJqp9XM
 5tJWQH19IlXgf2w41Rnd163qjS7k6+x186xEonSfeE/+Aob8+tDi3tIh/SeHp8Z6U/bg1kUqqiT
 KUar9IfUwX+fv+V09sWWKxAF6vRyUGslRXDg2zyYAhjIcYhLuAipMRiQ39L9LDLSE3sxBNNqRUA
 hq2JQGfTc6YxnIVP47k3yYj4zkETHRuyT43331yFSp7QAJRllvXTh7O5/iOAwpQzapzc2kYWAqR
 dBmVjrCBktferBQkVWMLlreNTIU/6xAW7N1QNrhbG4T5pkWQK6deAMJ9CF7Wg5cH5vPOmJdkKsd
 OWgk8piBvK1CYIz8/S0h3/fseUq+CF4q0nZhLGnAVT76VfjEmkDi3VqCiT2x30Cl4tNlvBOotIK
 pVFEK9AmQRHdpNqX6ehIxGQeY8yHvOF/Nz6lrfqQAuy9ooJLMjKbU3dM77bq59Cv3nwg+sIEwUK
 iTrVmHHfBGuU3AKGCZstJGCBkSL4TaIJHi0hWd9dbC/X/uYOtFQQpZvr0dDXqYh+HscKuIFh7Vf
 b9DX3Pi3DKzJ5gw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Document a new property (currently only for sa8775p) that describes the
memory region reserved for communicating with the TrustZone.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 47d3d2d52acd..2cc83771d8e7 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -93,6 +93,11 @@ properties:
       protocol to handle sleeping SCM calls.
     maxItems: 1
 
+  memory-region:
+    description:
+      Phandle to the memory region reserved for the shared memory bridge to TZ.
+    maxItems: 1
+
   qcom,sdi-enabled:
     description:
       Indicates that the SDI (Secure Debug Image) has been enabled by TZ
@@ -193,6 +198,16 @@ allOf:
     then:
       properties:
         interrupts: false
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - qcom,scm-sa8775p
+    then:
+      properties:
+        memory-region: false
 
 required:
   - compatible

-- 
2.43.0


