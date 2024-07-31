Return-Path: <linux-kernel+bounces-268677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DC89427BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CFB287179
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8FF1A71EB;
	Wed, 31 Jul 2024 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="AqX0cvza";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="I39Jr0B9"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9B434CDE;
	Wed, 31 Jul 2024 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410410; cv=none; b=Qq8U65/3dvoi3BglZFnIJmJ39CfKrBH21B66zdAdLGzCqUeLsOomkc0VOPj+k3xxfbOW5TIyU2GzNRqD2ALQfSpgsyBB6Dl48psNss5ALH6N4wCy3PH+2CkgTzXPEwt1az4c0qKpjLPdT3/nKt+5JMA+LGhM9Moh1c5WLGDWXGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410410; c=relaxed/simple;
	bh=QpL/YgxQJegTmDER58F2/t40tDGvdCMM9m02r8+UT1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gc5PP4BgzUmCabY7fD3/P2cO2EknYAITqhu2exEls4riZrmwCi+ZKggDAg2+Mox4UnoA2oLOihF9FKhOrNs+fpxVoU40xyDUPkHjjIT35ZmrZR28UlssPCwer6q4GRV16T4nJd7IG+5r/8E4TiWhSCoENO+X/bAKPbObnXFyPi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=AqX0cvza; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=I39Jr0B9 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1722410406; x=1753946406;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=32HV7F5x+LICt0dvmQbJ9jvBOdbWt13lmSd8DKdvO/M=;
  b=AqX0cvzaTlreMzvPvskpfX/fZfteNQcD7oNRQ7lt3MZwnq2RAPT/mnq8
   o7YiTxiigMIskBhJFu7iLwldn9Fg4oE4q9oOLXR1PyK1wZyRp1G8PxFyk
   FnYNLEmxrGcZT9FGIopeEfDfYbR54ybX+EtYRgm+4HIJSEELL9/FF1EYa
   VqGfZnumD3Qs4NVkGJWJCAVNCnuGPA1o7E3KrFIcF7ky40I2dfOAtl/we
   e5StQm0HLA+hwgbM/kh2iu8KLPd67qHUgVp5dJEb5kKFCB+bxiSJ/C0F5
   Fn6hJy1OIi9T6GrIKpgml1BcNTwrlFAQECMn37+6UiDXiW2aO4kdjYypt
   Q==;
X-CSE-ConnectionGUID: aadykCT/Qz+AieFWE9bmkA==
X-CSE-MsgGUID: t5uwBNypQxiiF2i0yOfV1Q==
X-IronPort-AV: E=Sophos;i="6.09,250,1716242400"; 
   d="scan'208";a="38163428"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 31 Jul 2024 09:20:03 +0200
X-CheckPoint: {66A9E5A3-2E-CA1431AC-CF855369}
X-MAIL-CPID: 5C52B82C244FACA95267ECB603E921C2_1
X-Control-Analysis: str=0001.0A782F18.66A9E5A3.017B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7F291654B3;
	Wed, 31 Jul 2024 09:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1722410399; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=32HV7F5x+LICt0dvmQbJ9jvBOdbWt13lmSd8DKdvO/M=;
	b=I39Jr0B93VCU8esj4X+3gTrCQ3fcwp3OeEwQpIppbb9HYzXKJ8XUaC2CuqPVobry+x+dJC
	RaWXbHfxiI5hvAWmUtghaRAC74aZFmUWIwsrBRRdv3m54TO3ygyvZpWtyqpA3jUaPHtcJZ
	fEGLdv5hlY89YupqijU/dfzXmIy3DjqLqQdLo8+7vL3dik0SAXAR2c4HvnO+qC/qgC5swx
	sKUTHrqIlMKsZSIT62JU+Qh9e1BzMqE3TbR0DTYh12qeVIy4OR1lLe8ZWfNPEQve3J/3gv
	AUBhiO7+ZndcDXtjyoVAB2DEJ2khvX5BV3nB+jD1PmJYnRbfa18Ywy3x+mrKtw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dt-bindings: usb: microchip,usb2514: Add USB2517 compatible
Date: Wed, 31 Jul 2024 09:19:50 +0200
Message-Id: <20240731071950.989113-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

USB2517 is a 7-port variant of this USB hub. Add an USB compatible
based on USB vendor & product ID.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 Documentation/devicetree/bindings/usb/microchip,usb2514.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
index 783c27591e564..245e8c3ce6699 100644
--- a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
+++ b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
@@ -18,6 +18,7 @@ properties:
       - usb424,2412
       - usb424,2417
       - usb424,2514
+      - usb424,2517
 
   reg: true
 
-- 
2.34.1


