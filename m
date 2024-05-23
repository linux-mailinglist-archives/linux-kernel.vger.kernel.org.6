Return-Path: <linux-kernel+bounces-187144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033898CCDB7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A041F22352
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31D413D51A;
	Thu, 23 May 2024 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I8nZmBuj"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5273713D28C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451362; cv=none; b=nZ1GZkPp1P2rEzHUQsAzCssOAzzZM7J+4PJPQHS+CBbxUGqCim0TFjlS64xIccIRFpECEjL+8qN76MI0t6phz1o8Ghduupto7km5HkXBHyzyRu54v2kMyle0Z1gLJWdbJjRmcpQs/WT73TS44CE4ztvbb7cYGv7d/Eitexhc6rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451362; c=relaxed/simple;
	bh=ouSbJlOZEY8GCBHVOJ6ME7OlvRUFtsDeo1y5EHXursA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E72wN1RxrLnBR4gmikVxX03glcGGuVEPNzKGW8X6JU8ev+6pbBaYtG/zO+8UkCpPBSUNNE+CuHCJ/cT8PAZ2lxIBbTZSFOghAH3ggKYleoWITTaNeQwN/hrrSOBm2N0BhkwdZXzWkwe/4x+HFOXXzpDwZJKlIsmBeX8WD91O4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I8nZmBuj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4202dd90dcfso16775675e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716451359; x=1717056159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xxaqeXNmd56fs7VILfOHspA8Y/nLG+qphjjlB9Ut0E=;
        b=I8nZmBujVwHIUw6xc5zAaRpMUynxu09GIN2UMSHBgXJ83AkLVaoQUMXZ9vArRDCoC/
         Rwz7+9m4WIJkeGzVB2nceoGaBRv9utJy0Z8rXP9tzXJScyKufyKgSWeFxVvGM6et/fWd
         015kf6qauKYZXbRA5rAWF0875RxU4UH9fQUC08RUSR67RZ2uFzM+rDCoYQMc6h8CgeD9
         kGyQ/1n3W4843u+TOzvVrCVOty8hkbA16TlNecDht2QApmcbmP7FnQ7qAZu7EQrjaUgj
         0WorCn1aUv606Pv3TLP/w/FF9e2tbmXLoN2fH2NQ/i5bs5E7uErfdZECSin+wdON2ksZ
         5scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451359; x=1717056159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xxaqeXNmd56fs7VILfOHspA8Y/nLG+qphjjlB9Ut0E=;
        b=cYmtQOVoIom/nMlBU1um3gDTWbEk7EYKFvVerG0tllnugP/uHHf+7u06LupOC0TWPs
         WEBnHWL6hUaDVwiCtLUmlk1wF9UucQIyMOAQvhXQejFm8U+e60cdPkCEnV/QNNw1js6S
         JWq7xoOMjGs8778bZEqgWXM9u7QZpVy9FdOZS1zux8EngRemPLSdZEbSQLkdaPeIofV2
         WzGO2ATwEW2qZ/zPCGMegb2yQy0Hkq7B2y5ClBfCteEUlv8HXo4sBAEN3Nq+sCiBCoV6
         wJoeHWKh6te1WJniW+uuW5xzIQgYO2kv8HJwnc4EvQk/rJJ/269sp/YITlxh2FsWOUEu
         H+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVnHPhA0/dCW9+ijEH7B13dMjmC5DjZjy7qD4VMzTSgphIbN3GrseoP9oMgNpPkLTUdSxFXqEkJmzWMfxc5iDHeiazhzezutBJWLStI
X-Gm-Message-State: AOJu0Yw3/TTQEVBcI+7k+SNHJ7qXJrLN8HdMVwjoF9de5b8bfPTEREmi
	R3EPvv3uduajJ6L6BIJfaCKm8xaiQ+/cSUjjlZRbEQPJIKW+StlQJHh8RpJhW+0=
X-Google-Smtp-Source: AGHT+IGkl2Vp85pLyfdv7MQfq/S/GF6HxNSjqay+owUe5sYi6UWuSKa4o4vJy6nD+5JPxVtRVaLkog==
X-Received: by 2002:a7b:c3d5:0:b0:41b:b07a:c54c with SMTP id 5b1f17b1804b1-420fd301f7emr33153235e9.9.1716451358550;
        Thu, 23 May 2024 01:02:38 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35501abfdddsm93637f8f.110.2024.05.23.01.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 01:02:37 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 6/6] arm64: dts: ti: k3-am62p: Add partial-io wakeup sources
Date: Thu, 23 May 2024 10:02:25 +0200
Message-ID: <20240523080225.1288617-7-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523080225.1288617-1-msp@baylibre.com>
References: <20240523080225.1288617-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vibhore Vardhan <vibhore@ti.com>

In Partial-IO mode there are a number of possible wakeup sources. Add
the list of phandles to these wakeup sources. Based on the patch for
AM62a.

Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62p.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index 94babc412575..4d43cc972056 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -123,3 +123,7 @@ cbass_wakeup: bus@b00000 {
 #include "k3-am62p-main.dtsi"
 #include "k3-am62p-mcu.dtsi"
 #include "k3-am62p-wakeup.dtsi"
+
+&dmsc {
+	ti,partial-io-wakeup-sources = <&mcu_mcan0>, <&mcu_mcan1>, <&mcu_uart0>, <&wkup_uart0>;
+};
-- 
2.43.0


