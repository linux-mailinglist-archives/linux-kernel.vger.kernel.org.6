Return-Path: <linux-kernel+bounces-282297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C5C94E1C8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 17:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4591C208CF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E1414A619;
	Sun, 11 Aug 2024 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cn0u8nF2"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C40DD29E
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723389466; cv=none; b=LqolL3XiE8dyZneDJlfv5lUL7bf03MeYeXZZbpZq+YG2Oa11P8K/r8Z4b6GDcrPBav/2FfDdx+W1XLFcxGXlsrLnlGdsfn9fYmvrms+J3CyORLyiOyRmj0YTKxyJg33adWUQHZPJFSvmdIq9QP6okojSYhD3XBcGe7UVlJZ473o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723389466; c=relaxed/simple;
	bh=hwPVKIVNZucKk3ZL8dP72AoDLjFo65gMygfi6XUsnZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9Vn0EtCEn6BFkX1VC9Ax68iTIYvpmPkzStmOLnYSl6nDjg5zQQocl4QyWYJFKxHeavRLzpBkC+rEvBLQTcwnj76Vv72Qa9+OGq9h70uZB3htVMOS9I5+zx4k9Q3+EG4OI0JgJdwkVymTuV6zQfNkZzDKcNToAmnB39Ql/apqDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cn0u8nF2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso393978766b.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 08:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723389462; x=1723994262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nOrrFPO2+Eu1RsdiiDnsQDZT+Eoua4cGMzFbuz7CsgI=;
        b=cn0u8nF2/2gjkOdcS86nBOr3ItfYkB/OFuhfrasmu4/1gygfCPC469Zm1pnLE/0M7h
         nP/Z5tTVCHeMKhlcq+V6gmFW9konu7NUWO882ifVBlBsqr4zTGyD1cRKcaJRVCT4DE0C
         6m8iw+Ot6NVH+dZvRoAGhh19d38n0rpznqM/HvvjzUDxpRAYdcWrx/EiRz/wE8L05FKF
         NgigCRvAE3eCjHIMCA5JJTUV6dWbHwOkgidq5mkXCcTRRB1m3lOO80b3T2SGMTX1UN6a
         jdVmbZKqYrRKobN/8h1URxXOOw3HYiECZmlsj1l4YEJbbpH+L+fUlTAxX9A38qNkaTm9
         fMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723389462; x=1723994262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOrrFPO2+Eu1RsdiiDnsQDZT+Eoua4cGMzFbuz7CsgI=;
        b=Jg2Am4iX782lXn32ZJkZfWb8UxfzYDENG335JaWuV+f4HIhhFD7JIdV2bd/4glVUXC
         aH56pqlVGMy0pgGC5hcJhtHQ6X6KT8tYUOAuWip2jRCv5U6KyCNERsMvsCuU7Ayqujr8
         mZ3Qp99CGmf5/VHjbsLDvDaZqnOrDzWpiz6k3DGkT8qnFF5Xzao3E6pkb1+DlTlqZCCv
         wp12H49kTa7J8iPtUsGbD9k6HAE2zgYQPLVEusk7SVVPUAWjE3hde9kD88lWwl5+qBmX
         /Gi8fYAZiCOC2Ns15BNvOI59JhVAVVb80q9QbW3O6mUzExa4l+oTi2YTCxBr9Wa9wlqS
         m/7w==
X-Forwarded-Encrypted: i=1; AJvYcCVJDG5YelEyJqmmZTT99gkiuoLJDKO2kA/UPX7bvx6Tt+BPkVxtWsjoGM6tSt1pAFm5h5NQsQKbLdkTRddEmCp9vhljkGRCSpC9IUup
X-Gm-Message-State: AOJu0YxA/LlgW6l5yGxgfX8hmBlQ4wGbT4QxfHXZfSVW3e1Z1gCUFJ3e
	TyaHSXfJIBrDeYu3WJh6zvWbDYaZ0g4TOoWffdJw5HQlzh1C9dEmvZtJ91+tx7VnGh2GyKW2KJw
	L
X-Google-Smtp-Source: AGHT+IFMkuh2pshcMEllN4JDzZBehDboH1YV/ev7+K4CsgIw5JNm3uxhpSKfKT45jnx67W0QXEExTw==
X-Received: by 2002:a17:907:6d11:b0:a7d:3672:a594 with SMTP id a640c23a62f3a-a80aa67acbamr477098766b.61.1723389462194;
        Sun, 11 Aug 2024 08:17:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb0904f5sm157030666b.18.2024.08.11.08.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 08:17:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: nvmem: st,stm32-romem: add missing "unevaluatedProperties" on child nodes
Date: Sun, 11 Aug 2024 17:17:37 +0200
Message-ID: <20240811151737.106194-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All nodes need an explicit additionalProperties or unevaluatedProperties
unless a $ref has one that's false.  Fixing this for STM32
Factory-programmed data binding needs referencing fixed layout schema
for children.  Add reference to the NVMEM deprecated cells for the
schema to be complete.

This fixes dt_binding_check warning:

  st,stm32-romem.yaml: ^.*@[0-9a-f]+$: Missing additionalProperties/unevaluatedProperties constraint

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.43.0


