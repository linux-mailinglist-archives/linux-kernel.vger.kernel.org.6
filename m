Return-Path: <linux-kernel+bounces-448641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A809F4355
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78EB168C18
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71B1581E0;
	Tue, 17 Dec 2024 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cs3YAkGS"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C1155CBD
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734415953; cv=none; b=hSRPNa8Ft4hCy2ocgN3s8jDUWq0xxYJKFsA1CokcRosEh3jK/wt/gxPIeegxv1QNFHx/0s5B8z6qBtOO+Rw60l819UsgRN8wTxfv/rmyQ6AHIgz0JUDfJk+1nPlAo2cB1hKToG3wDnexrYCuOTuipIxx3u4DX7F5whDT79k/eHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734415953; c=relaxed/simple;
	bh=l+CmowjLxxDDjlc+kWV/o6CeswngsGm7D9h42LzE05I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ewDhpAj1XKaQDUdfbwptJAkMgm/cIac1eTzQiUV4MhiiYhKs93LHlfiDLfvQWREwgsLf5NZ+gDvO/21BWYBPhf6ATwSI1PmmMS45/f9TQrMKUEc/upiVv/tg9upCbgkv5UsQglcY6zcydk9m83witCZZtXFNoVLV+FEaCmu3+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cs3YAkGS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862e2c9bb5so198735f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734415950; x=1735020750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PTHJDPcDpPl/b/u84+C0bmCrPy6/IfhaBvYT/oexWi8=;
        b=Cs3YAkGSsTAKiPg/nwKq75Te1qiaoE0lnGi73znYtfS515QjJnETm0EnUFQunF+ZEd
         Y1PEitEZ0nubd7oUXX3yZhOq12yF5yP8kJ8o+mHEOmavES6JQHBhK6/4Ryd+imsrCtX9
         yLD7ADKQhVVqKM/XcB20yCVxgSpIRkRgzNZllHn1FIAUV7XmMVg0sz45SE7hnu4r64Mi
         MkwI0Pp6CEMD4IKKn6UAqD1lYvvTaR6+LP9CagsrraJkrntQFmSh5K0WJTHQbHZVMI+q
         BGeY1aa8sYIUX3DvV7k8Y+m63iBt2gE24RM3bb2Q2exkLXJrwx5L6yvtvhhWF8rRVywv
         /hpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734415950; x=1735020750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTHJDPcDpPl/b/u84+C0bmCrPy6/IfhaBvYT/oexWi8=;
        b=taV2iXWrtjRHKGZiN/j6a9cb2e7Ein+0oniLRR2CqP7LG6f1I/z3NOVKRaSJxTKKpr
         05FzNrjIpqhCDGg9Rk45KT3gNZXzF0IOHMqx/GaeP2O1ewIIrdywcNMGjZ1+63s6S5ny
         UfJGYHB8Mu4+qndMya5rnMPsgVkfZWWNcNJ3mpkHIMM9Jj2x7RDvQB2df3XV29rUiPgk
         RUCTcZgnyuq9LCpHD6hnDwRV5YsJVyZpwov7Y3tocKOv7Q3yYur1JpXwml92a3nUe1nK
         a4Pi//zc6x7pnO21yYma5/I73EPKCgaHUy+7vIcj8AAczQ1cVUAyKYnKrVjAtE5ov21n
         Grdg==
X-Forwarded-Encrypted: i=1; AJvYcCWgd7u6eHnHtcAK+A2kdavTAy2Rqr0TnWpZbT2CTgFaATmTNjYjKGSfRTbnLkNGZC95obaeg86u1qrWNIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP9YCzsJkuIMCapGyFppc5Tu5zebEJcYaTjm+lDPXSoZEDKJ5Z
	MoOptKD+X7/TvgUXdJiYkJufJXPhmX3I1Aikk1uX199EX3yfhpj25kI3oEbLA3E=
X-Gm-Gg: ASbGncvHNcVsKA+t/nlc32yle6UsxsqkliBmeLyQ6tELBm8occABBnyqXJBjzAxUs1g
	Hq0ctcGgQ3RnQ0NXb3jhG3YHd3RZp4yztTXSfv62wG5aTp8EHAouELB008NbzeBytCDLYfz8dhF
	+ujLKuV2ic+lXj/+Fkul4vIxTQfNc8FrP4EoMXwYj6I63wjlzbi85yBllqBkXCs7bsyO93tzdqV
	H3odaS3j1tVN33nQB5UiXjschEIDrvC3nNwlFs6fJTPdyHbl1Z0KCs6kU/YkG5CD6nXD0Y=
X-Google-Smtp-Source: AGHT+IFI+p0M1btx225eSEUt1sd3VfrnBfaQ6XC/nOx5Rt+MMlZSNPlHzmh9nMcVTJ+lBXANYx6cnQ==
X-Received: by 2002:a05:6000:4607:b0:385:ea11:dd8f with SMTP id ffacd0b85a97d-38880ad88e7mr4026927f8f.7.1734415950172;
        Mon, 16 Dec 2024 22:12:30 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80120bcsm10401852f8f.5.2024.12.16.22.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 22:12:29 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: interrupt-controller: arm,gic: Correct VGIC interrupt description
Date: Tue, 17 Dec 2024 07:12:26 +0100
Message-ID: <20241217061226.14139-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The description of VGIC interrupt referenced obsolete "see below" after
converting TXT to DT Schema in commit 66ed144f147a ("dt-bindings:
interrupt-controller: Convert ARM GIC to json-schema"), because there is
no dedicated "VGIC" chapter anymore below.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/interrupt-controller/arm,gic.yaml     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
index a2846e493497..7173c4b5a228 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
@@ -110,8 +110,8 @@ properties:
 
   interrupts:
     description: Interrupt source of the parent interrupt controller on
-      secondary GICs, or VGIC maintenance interrupt on primary GIC (see
-      below).
+      secondary GICs, or VGIC maintenance interrupt on primary GIC (see "GICv2
+      with virtualization extensions" paragraph in the "reg" property).
     maxItems: 1
 
   cpu-offset:
-- 
2.43.0


