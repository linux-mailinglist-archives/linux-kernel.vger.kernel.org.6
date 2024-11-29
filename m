Return-Path: <linux-kernel+bounces-425598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2EF9DE787
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F31E281690
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C481A00C9;
	Fri, 29 Nov 2024 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i50Rd3XD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F0719C57C;
	Fri, 29 Nov 2024 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886923; cv=none; b=Vt4BgUoBh4NdphwSxObE2XOchC4/qofkMX8/qRW+x+jB1XWRitGT1d0OFqE/qF6K/94Bh2SoOLqs7Xu51PyogCPIvJsCgUsJL6ai7aU76Gv5cQXQzMRPA7NgiOW1kDUi66PA6ma6cBYVT2AvhpcwlCMncdByAOdkdFwf3S7fbsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886923; c=relaxed/simple;
	bh=1YvxV8C4GkKt1E6xAgYL7xkTCqRPwy3DRHYl12fL4dI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZEdpig4skoc3o1HvPiorAV9DFC4ZwQtY/5IXey3T7gkRK1Kodf5s7YuLt9cZmQnReny1MQtx4DdZGhHr++rpBkj4LZmy43NsnlrJoQkNuk/bC/M1C0Bp/s7Fe/fVL1t0KDOuwJvOxgFlYbMTAuHvdTmm/tlUsHuWBWXidXFUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i50Rd3XD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A078C4CED2;
	Fri, 29 Nov 2024 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732886923;
	bh=1YvxV8C4GkKt1E6xAgYL7xkTCqRPwy3DRHYl12fL4dI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=i50Rd3XDMEC6mHpbSMmqURZI9Tx4UyYP2bLtthY+OXkUJ9cxilnY2DSndo6dngTLa
	 3boNdVuYOVGXv3Or3QIdqPvs9Ljm/9MurEEvfU2UHnRVRxlHsR1MPZbGfTzzzzPxSI
	 KMNRjIJaOGpSKK8D0HR2ybBuaSxijAtvrxtznYPqtEFIQsQnqKV9BA3kPoS+OLdNgw
	 ximaIpFpe8/282OIZLeE49grZJ4CswZiYn0c0gHgpL6bVgHPx9SdAPBGpJMkiQx87y
	 OEkqYDeLK05ocAGwjBnzBKEvj1qbolHpEVbRGkVhx6jndzqsVh1dBrwLwyYFEd6kXv
	 dSGVqEZWtVC1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD42D6EC0A;
	Fri, 29 Nov 2024 13:28:42 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Fri, 29 Nov 2024 14:25:53 +0100
Subject: [PATCH v6 1/4] dt-bindings: w1: ds2482: Add vcc-supply property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241129-ds2482-add-reg-v6-1-bd95ad171e19@gmail.com>
References: <20241129-ds2482-add-reg-v6-0-bd95ad171e19@gmail.com>
In-Reply-To: <20241129-ds2482-add-reg-v6-0-bd95ad171e19@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732886921; l=796;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=WhOk1GuCMyF4Uqf/5Sr9VOiQAo2chWTloYZnv0gVBic=;
 b=51S0OcyVqUj81rp6pWj9Ift8o8hMmInJjnoc17JlHXbdjKu8iDlTmQBhnH9fMbJcHUOpLYE6P
 4PpyDMduPH1CNr15MqnjSdQfWdp94TopZl6owEPutuAF+K6Nygzv+U/
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com

From: Kryštof Černý <cleverline1mc@gmail.com>

ds2482 has a VCC pin, accepting 2.9-5.5 V.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/w1/maxim,ds2482.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml b/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
index 422becc6e1fa8d58665c5586ebdc611cd0b2c760..fe6b3f9a3f8bbd00366c3e36aad3ffa72ec1a31f 100644
--- a/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
+++ b/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
@@ -25,6 +25,8 @@ properties:
   reg:
     maxItems: 1
 
+  vcc-supply: true
+
 required:
   - compatible
   - reg

-- 
2.39.5



