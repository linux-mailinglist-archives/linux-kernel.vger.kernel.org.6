Return-Path: <linux-kernel+bounces-311511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE2A9689F8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D261B222C9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66CA21C19F;
	Mon,  2 Sep 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nensxHRT"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33621C169
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287412; cv=none; b=Lwuo0zc6v+hiiTfDp4pWTmReHFU7E9Z/cp41PczmXonGEkkBnI5OHllJH6F02IllmhQ0PuNBKrJXjipsIk1X3hDqqOjhNqd6VO0GyEkjUYUd2HEFj6F8XgAzsSv6vkdObJxqecMVgfKYfcBEP1+z1oqYP/EcFY5QPsnlv/pUcCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287412; c=relaxed/simple;
	bh=bI+WqXBj8mdD34T8H6SBusG/4OZyISmGynfKyGUb94w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e59vn6lAabDejRcjNM5gx8Ss54vbdlTelcRkr1LkBAwmJ5J1Wjv04SRt7c3UnLkwbZmdzPeNW1YSlhdeAeYO1cU2eGzhIr5fHvZoBI3oN8nicCX0O1PN5cxXr+tbhzL2/450bHUuSCCxPV6eEzjedpzEuQV8GNf1/Ax47eFtoQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nensxHRT; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53343bf5eddso5668589e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725287408; x=1725892208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5IdT/cwgTs/gFfwZd0Ne8SwBMrtn3NphjoJjOx+PJQ=;
        b=nensxHRTBiSuCnXeDm4Smk4HdbPy14m/jJBTZjAdIr0NfASWGlDUrcPI/tw/FkjAq4
         5yBvCG4TCzEfmp7TYdAnGvexH/1QFuZoimWBMZ6T6ePcaWUDE/3EoDb29IBmLv60pjHm
         cigNXmjzcEzd/hzaXQYSaqe4D2/cu08NnRyIWTxH8aEeUPgf1ybGntpx4+FfA5YZqEDq
         wKsq5+Qc6H+clWCC0lu4WWJ259VQg49Pot3edfQbUk5XL5bNWNr2o7my+2+7IwZv8qYF
         /jUjxKaD46im2n34vnj7lJPubtK/1lZcsfTBbjTay5vdVhcVJIpuSSHnZfMp6TgqqhBy
         aBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287408; x=1725892208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5IdT/cwgTs/gFfwZd0Ne8SwBMrtn3NphjoJjOx+PJQ=;
        b=p1AtEt6DlY1tCwuFcqNylRP3LUr06X6oTA0SytaHBwOwduad+w+9VojmdnyQAxfw0j
         KiEY/TGMrMHd4VHt8qoOXE5i66VGGFJ6EKbCDErqeaF48C+plVavC4hndMUkGc5K3gGz
         V9PgR52Duv7qJthhPdjquo4IsenZ1BkJvoCtEj01Vh5KdvfPDm1vANC12FzgOAZocbrJ
         C8u1gstU1rzzDdNL2NpgNlBc3yBPnKuWIcSsrcTTO7Mmx/yHoQPWmnj0C6DImlOWKSx5
         P6CvW/J97yhzrab//CBMblkWHnh+Fa9zV3roc8r181TEi0ixrICvmnqdA0z7ImlGN0Rt
         Z0ug==
X-Gm-Message-State: AOJu0YyQ448SYKCvXWV77BoEOo6MgV+ShxJ4AzKJEPd6NM2iJewPKIUO
	9xaalw49XuDKmZHiRtzw7WgDOFq7pGYsWG1wnmGrXhIVbh3I3Edotz/K2pZ7hIw=
X-Google-Smtp-Source: AGHT+IFK+qDjRZcra7g9gZD7vtf3xQyREu7W8TUUKvn21lu9+aXHWmO6jXkyB89oK3lLxPuDiesHAw==
X-Received: by 2002:a05:6512:ea7:b0:533:44d7:c055 with SMTP id 2adb3069b0e04-53546b19184mr6727359e87.5.1725287408218;
        Mon, 02 Sep 2024 07:30:08 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d80fcsm566011666b.181.2024.09.02.07.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:30:07 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/9] dt-bindings: nvmem: st,stm32-romem: add missing "unevaluatedProperties" on child nodes
Date: Mon,  2 Sep 2024 15:29:49 +0100
Message-Id: <20240902142952.71639-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
References: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

All nodes need an explicit additionalProperties or unevaluatedProperties
unless a $ref has one that's false.  Fixing this for STM32
Factory-programmed data binding needs referencing fixed layout schema
for children.  Add reference to the NVMEM deprecated cells for the
schema to be complete.

This fixes dt_binding_check warning:

  st,stm32-romem.yaml: ^.*@[0-9a-f]+$: Missing additionalProperties/unevaluatedProperties constraint

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
index 92bfe25f0571..3b2aa605a551 100644
--- a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
@@ -17,6 +17,7 @@ maintainers:
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
 
 properties:
   compatible:
@@ -32,6 +33,8 @@ properties:
 patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
+    $ref: layouts/fixed-cell.yaml
+    unevaluatedProperties: false
 
     properties:
       st,non-secure-otp:
-- 
2.25.1


