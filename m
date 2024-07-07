Return-Path: <linux-kernel+bounces-243751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD23929A1D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 01:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF96D1F212DE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 23:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E357346A;
	Sun,  7 Jul 2024 23:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="PdAgx+q4"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FCD1DA23;
	Sun,  7 Jul 2024 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720393720; cv=none; b=FnslvL7nh5Lrgm1Ycgu/pa8XohqGdmGNy9faEggKS6O3G66Xo9jLQL/UR4NJ2ERG4pPwA4TP3SsnzxK85/zPnOq+vFOf1zpSFFY8TwAQ/kc9Zre82gMnOYWbgjIs1uTA4gHEHnxhdlN10mcyKQMineliz96Dl8EMKdCYaER/IKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720393720; c=relaxed/simple;
	bh=yYNJVJXB0+uqZ8YcFzSNTuSP2LNmjGHV6759JNx97KE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fTCrvE6iOqPaodgcfP1Kyv4ZPiLKatVFh+rJAfCLx2CpX+kDJZidesiWDojC2BLU7rvc+ML2t46QoaynscQ0CzHz1NUnt3cANNqpLnEoeOEQ2E7bbQk4png26u8aFd9JZ5pW8f7N19/ni8XEgn5EqBs1IuFW1MtBqCf3vgaEUns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=PdAgx+q4; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720393702; x=1720998502; i=j.neuschaefer@gmx.net;
	bh=+S9OSUigqR1QELuwVzUa8jMQbpjpl/967lLxUHXmC8Q=;
	h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PdAgx+q4ctZegUNrzSbK3MYPETaBPNHLdHUeZ+Rv8ogocpESbbpP5dxh+YeaA9Gx
	 98y53xSJ3X0kmBo94UAPCymRgV9WzHWEbFUrFYi6JQCFVKujTQcBjyMH6+or7+cz8
	 the/Gu9RR2sqaX0kDewih578z4cIgijxZFw1B8ioUF112+yZvOAqVqyYpPxb0Fcd1
	 VKCcganQYismkdd1L5F3bx5PwBXj60OW47ni2CSX9Pm5Enj4zkAbsADgvgLd75+B0
	 tM689xXlSEZ9SilI+cy3mr+Zz+2Ela9vx6zE8AByFr855s8gMJcUxvDxr9Eg+XD6r
	 mEri7boRZVPawmMNeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.46.161]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNKhm-1sjsw33Gby-00MW0B; Mon, 08
 Jul 2024 01:08:21 +0200
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 0/2] ARM: Expose Raspberry Pi revision code in
 /proc/cpuinfo
Date: Mon, 08 Jul 2024 01:08:13 +0200
Message-Id: <20240708-raspi-revision-v1-0-66e7e403e0b5@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAN0fi2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwNz3aLE4oJMXZhSXQuTlLS0lLTE1KTkVCWgpoKi1LTMCrCB0bG1tQD
 mIKlfYAAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720393700; l=1042;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=ZyRsplzPA8fcdb9KWZGmC/Hoa7oi0rWcdebvqmwsbTk=;
 b=MRQTYxk8zF76z57f2Cdk/vS/yuiLxDW8LgKxLxpW5E1CZ0wNYLROBKNrQNzJY8t0r7zAL/YXl
 3ehdtEQohqfDdhF+2YeMNPvPpszKDM+naWfFC+01sZiS2fsHdoIWx5s
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:W4gI5CL2VMwpJHko+dxID0o9ybNVCzNUhdEH122PfIERrqHNiny
 N/iHVBcAKt+u6UiOPGMIs5Smfl0jEnH5toJhJygzp+cbwIuyEn6PapLY4QEv+BN5Z60GvMo
 PRAzbFR+QkfeUQuNrVFrSN1AcfO+JI+ShbWny5b4Nbsk6UHC4dNZ04uerGts4XcCLI+5MUk
 s0lzuQmrDWpygrTpiDUhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XTxmi9VUGs4=;0pjbm/ZvC4kZj/iX/eRzJneNMex
 dH1qPLK5aSGrbRk1IML2ZL4CEMesOAKi7f6Gb5PQ6VaZkECUaBeyUObsApUMNda98U2fGma6b
 0/pOjZk4fYek8LZLu91RvzEnun2WDcMsqvOt0wUF/4mJG2NYXZ1b4mYG4wD6euKMFoc3cdRW3
 sAT9oVP924rDh0oPUwEEmnOxq0EV87AeUxzhYMoGPZB6gmFZjczFo1Ldw3AtSbkbfs7IGz+H6
 015pkUyV1PkDVdz6akhhV4W5b8Y4Mol7h1jBCKqrNj2AM79A4G6o3aCtDZkbNaAC875CXqOCk
 fweq16PBmD2F2eEI3esxWNY0SZa1wTUqedB/0QDZQvUYbkAejbvornPWhAwIMsHsDeTxYjmjf
 yoHNTjHGiJV7w1SsAhRQ9o0/QQuSbuSdrefTqv9a8nZnEaV/R+t+/NUZJCqZ5lvFcmw1rXjnN
 +7DoVs6Yr4AGbS+gqiA2sVEr3RYAYAdFlJ4jiEgf8OQoOmMcw+1zm/Vvz6xc2PN5Pn1gNKt7l
 I1dEozLgL0el7BtX+WvvNIk+yd6l/PLqmixDXG/cXWnfYYygSU5UTiwFN0hJugngqM+BDc4vm
 8koCF/BB2aSM+cI9d5nYUSuyexFooVx+bPZZDTxzoxCVnuFKThOGNqJOnJYX/ess5zgzeX66U
 ml84OV8X+xH1VPyepQU9xoJk6k4RiJursWj+IEa1ueGISdtOuhtdYe7TPtjsoEVWujO3oDfzu
 IuqTPkbQrED0DQG34M2xZnZ+44bbmx60mVCmXmtYiP/SYywdD6MVnwMT8xQlL/WYMMZSP9NJO
 f0OSal6b0O+ATE/rE/1GAHGJGDGvQ6AwX2BC97NkWr6Tw=

Raspberry Pi boards have a "revision code", documented here:

  https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#ne=
w-style-revision-codes

This patch copies what the downstream kernel does and reads it from the
devicetree property /system/linux,revision. This enables some software
to work as intended on mainline kernels:

  https://github.com/hzeller/rpi-rgb-led-matrix/blob/a3eea997a9254b83ab2de=
97ae80d83588f696387/lib/gpio.cc#L247

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
Jonathan Neusch=C3=A4fer (2):
      dt-bindings: arm: bcm2835: Specify /system/linux,revision property
      ARM: bcm2835: Detect system revision

 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml | 12 ++++++++++++
 arch/arm/mach-bcm/board_bcm2835.c                      | 11 +++++++++++
 2 files changed, 23 insertions(+)
=2D--
base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
change-id: 20240707-raspi-revision-84dffdfaebce

Best regards,
=2D-
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


