Return-Path: <linux-kernel+bounces-526099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0FDA3F9F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3045188F215
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D49211480;
	Fri, 21 Feb 2025 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=denx.de header.i=@denx.de header.b="iWTuug6Q"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39D920FAAC;
	Fri, 21 Feb 2025 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153295; cv=none; b=S/+7xrx8jsDjOH15iYcjydssyEyZeVLZhL4KHLGu7/qSFkmiw6mzxD/q1zOpzc/edmfhGzN8Tf35wOP1df+0rhnXMEG1OxvuGug4rQOJrgfiry9KSeqFGnX7brv0gHfFwB4Qw+ZUlyOYGpMO4vNrdCK7kqlqU8CHHgLvsknTefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153295; c=relaxed/simple;
	bh=x0BhWl/XGa0eCjf2xd9Q9Sf3A7THwh85OBqQMQrv1KU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AVp4RqU/fxBZewtKkM1zQJ9YgchHJdxKdmeXr0zX5wuYngOwgs2auE4jN14XHw63clMyVgCmaiYLStSCL4lJWVqF4uyFpLzg0GOuJVFmWK0vxYwXgwj8sskVYT1ia0LPh+owuGDt8yf3LLftWNcVFUe53CM3cp7CJZmP0ASkW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=iWTuug6Q; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 702091034EAF6;
	Fri, 21 Feb 2025 16:54:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740153285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNc55uWXBq2CDe26PN6TZH3LTiWbpWVuLcLwZfaCHlQ=;
	b=iWTuug6Qa5akS6lrgnfypMdTXLM6wvqeRXw3SNrjaR7CYUgRXfZJa6EASzo25K3QWY6OcD
	6ZWbxcX4sKSUDrUDGZWrKIfy6bQ4JmaU+wvtNbya2uZfL+V1wLxcoN+6q0BU153YulLj34
	gq9ARa/MnRT5s7r1/P51hzO4nLCKuuqO2Oe0kNZRh1BsHZUfQormQCw6jYVGMCiXBn6GP4
	kOM04xAARoTx2JA6CKJnPTh/Lv3gQ0zfXtNNUR5m8PFWWcmyt500HqkU2rPiv9g0TFfe0F
	HnttV5YsmKzBVfYBPaFvLYJUKLlUBJqvQoZq5hi2werTdqMhN+QPhqmv+zjyhQ==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>, Krzysztof@web.codeaurora.org,
	Kozlowski@web.codeaurora.org, Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia <a-bhatia1@ti.com>
Cc: rafal@milecki.pl,
	devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Noah Wang <noahwang.wang@outlook.com>,
	linux-kernel@vger.kernel.org,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Alex Vdovydchenko <xzeol@yahoo.com>,
	Grant Peltier <grantpeltier93@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 2/2] dt-bindings: trivial-devices: Document SPI measurement on LWE boards
Date: Fri, 21 Feb 2025 16:54:18 +0100
Message-Id: <20250221155418.1167670-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221155418.1167670-1-lukma@denx.de>
References: <20250221155418.1167670-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The measurement device on Liebherr's (LWE) boards is used to monitor
the overall state of the device. It does have SPI interface to
communicate with Linux host via spidev driver. Document the SPI DT
binding as trivial SPI device.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index fadbd3c041c8..5d736a9792c2 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -161,6 +161,8 @@ properties:
           - jedec,spd5118
             # Linear Technology LTC2488
           - lineartechnology,ltc2488
+            # Liebherr on-board measurement SPI device
+          - lwe,btt
             # 5 Bit Programmable, Pulse-Width Modulator
           - maxim,ds1050
             # 10 kOhm digital potentiometer with I2C interface
-- 
2.39.5


