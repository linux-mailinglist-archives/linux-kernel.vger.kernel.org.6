Return-Path: <linux-kernel+bounces-403697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0C49C392E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0874282362
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED4B16D9B8;
	Mon, 11 Nov 2024 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="dlAFicXl"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EC01607B7;
	Mon, 11 Nov 2024 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731311282; cv=none; b=eNlJxjYy0j0uCpHAuImHUBshyrwaM5q7vcQPKotv768+e7R0dra1ROg8N8nz1AXNpJKGnniOyCI9nTyPWBQvKcz62Ohkca5UDnCyufNLxZjARZt7fMx1jGRkukUAoPGRynUNIdY9p7tq101WuSoW+na3VtjTVXyG3ImqxZOsAl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731311282; c=relaxed/simple;
	bh=Z1uGebRBkKkZtL1tFXiaL5apND2WmW9hxwaVDMMY2kY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ex51QPnfXUO37Y35D4GcGSIJtNjTFHt9jQ3tsBUzV7dOeogwv9e/DvU+cw0xCqZ5XEGV2NPd7Dtml3Dz/jCQQfN0msN73Xk6HbT8zJ3SG4gz4418QjzP6a8gCyrKtVK7y7CA/LaFPWhx+HJYGV+QkQV3qeghRZ7BS/qm25njVHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=dlAFicXl; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 78FE8A07D3;
	Mon, 11 Nov 2024 08:47:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=s7Qv8bFCt61AxHdLQqwm
	kNSey58feeSf0MIsETdNM+Y=; b=dlAFicXloL5u790zM40xO1OesOTs66mcjua6
	rwvgBphxq4k12rPKp17k7OCLiaQsTyNyEZ5vTXjuLwH1fahqKuiMZANRtnAo7r4p
	PmjcSH5/D2Mphq945/Q6M/xPKmIht6+uYlEhud1s40NXqdp9H/xCuppSNz7kaPpQ
	Y/xuHZ8f9qXIT/NVJ4ELRYubxc7VVX57JzcLtp7Bv7HVvVK/SORq56RYorCiZcRk
	zxADZUnkdqO5ujOLDYZ2lPJB5zkScVqL+ouJNVaWBVVJzkZYSZumgJnZTQA1YszB
	OvJ3Ii4siHdh4Luug19cL0svr8uASojUrXPW5OXkkuU0JFNtfM2S/vcIs2jM7HI0
	8S9BlRi7dEALrt0Q6/pgaZrmsjEyx9TIUDyqR80WA2W4IOfwQhu/XjAOUjZm5wzc
	BItIObdXk9fUJQ33yV/Vc/l8Xt7AB6NuUbWHyqioxEowde7KgyUwVDZorEt6M1LR
	2yVY6N75HEYqCyhxVX9hPfebjYyNQVJMM4zlPb6yM+5TaMTDfkg5dv19k+Wdw6PM
	nP+92qTkpuUzATRrR0v8KLnuIFx7FVcSGsWzDvZy0sqz9AoAU/06kXRuLC+LYxbz
	0T2tPUEMViU6luCgREQDh32/79UkPtPwjxAC6Z7WBMF297WEUSnuzNjFgP6WETYY
	+SVzQUc=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v4 6/7] dt-bindings: trivial-devices: Add Injoinic IP5306
Date: Mon, 11 Nov 2024 08:47:19 +0100
Message-ID: <20241111074720.1727163-6-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111074720.1727163-1-csokas.bence@prolan.hu>
References: <20241111074720.1727163-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1731311269;VERSION=7980;MC=1976759226;ID=287560;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485561716B

It is to be handled with the rest of the IP51xx/52xx family.

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 9bf0fb17a05e..1538f1ce3238 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -147,6 +147,8 @@ properties:
           - injoinic,ip5207
             # Injoinic IP5209 2.4A Power Bank IC with I2C
           - injoinic,ip5209
+            # Injoinic IP5306 2.1A Power Bank IC with I2C option
+          - injoinic,ip5306
             # Inspur Power System power supply unit version 1
           - inspur,ipsps1
             # Intersil ISL29028 Ambient Light and Proximity Sensor
-- 
2.34.1



