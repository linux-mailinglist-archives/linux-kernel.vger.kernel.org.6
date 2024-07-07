Return-Path: <linux-kernel+bounces-243738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C7A9299D5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 23:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2B11C20C5C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 21:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366FA6D1C1;
	Sun,  7 Jul 2024 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="c8ZE2TPl"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980158814
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720388945; cv=none; b=jZq4hyTnwiRbe7heK6fiNAnVfjLTO8J1ZzfZlvwJPt9IuAyCVhHimldE5esoWw4fawVdBa0iV1yDQMWtwbg+MvQu7eWjgEMrugKBzsYhBKZO1Nf04BqEHPdsEj3XPvb5c8vYjPNCxKyOv1cvCVr4RxFp02/3wbgPuWSBYqH2hzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720388945; c=relaxed/simple;
	bh=RQ9Ms1D7ItYVq4fpRtvLUI4/JIXIrojXhMNARPLalO4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZbC4uX5pHmxgCUpglARan3NJbjDsoyVUJ1oIVTqhvj7WrzpK6AqNER8JoQmmnA5Fbo6R2TsEWFgv8JOC7bxmys93Bz8QltLw4+ewwC3ngjdKUhqGCTXtZJ1c9sdRVbesJhMeCsElM9RwqDv9BMWtDxKi/Os6GjoQAeAIsff1Gtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=c8ZE2TPl; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720388931; x=1720993731; i=j.neuschaefer@gmx.net;
	bh=3F1vWQB9OiTMgAlbfij7fsPDvtZqaCjFHHXZ2oftcQY=;
	h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c8ZE2TPlqFhSTXGBkjtoNt5JZ6MIyhko18AoRy/35R4HZAdJ94U2CwtguItScH0P
	 O8Y9NW0ex0ZCfsdldCINGhvcXY1WQIoAxQIgixPNEqFRXiilqyXYsnaNip948YQ8s
	 p+hGEfsOMvrDfGEfVgEU7hkILL2r5qlNTd6HMRC2O7U63HcVOrfiYr03teOeksIhr
	 /QmjT7DD+TlvUo5YP9prEVLnbbVrm17LEY+ZN9M+p7ChTcbbfiAX7idCFLpjPhj/n
	 dyXVOgCYC/CJrklhW3BuOzLSH09Fl57NlcUoj1WOsDKXYwm3eG3a757mDPFqT5aJ0
	 ALXBSWGDN1VvY9Tw/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.46.161]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O2W-1sOunE3flW-002QZB; Sun, 07
 Jul 2024 23:48:50 +0200
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 0/2] ARM: Refresh Raspberry Pi defconfig and enable SMP
 support
Date: Sun, 07 Jul 2024 23:48:43 +0200
Message-Id: <20240707-raspi-config-v1-0-3e122f2122e9@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIADsNi2YC/x3MQQqAIBBA0avErBNGM4quEi1ER5uNikIE4t2Tl
 m/xf4NKhanCMTUo9HDlFAfkPIG9TQwk2A2DQqVxQy2KqZmFTdFzEPuiJDpCv3qEkeRCnt9/d16
 9fxKvuXNeAAAA
To: Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720388929; l=585;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=orLXBj+wTDs0/dTBQkS+CElOxj7TosEJTbnV1wAk50g=;
 b=HotHWsRKTJHVFJL3RdoesxtpKhU716H9uka6rqzPyxVFwSTINWI0lw7+G1UmJxHjNUOsieh5L
 Mm5BwRBgWdUCKy8d9Pl7rhQ91FlpJ0kAggVQfwuUR5+LnXXjNl3AWbG
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:U4ZtKGRt+knfdoW1+Bkx6bQsIyfZyNgiZnhetOjqxdOY1NObPTG
 RpX7GxsV52CR8cl/nLx8K262aApP2Zvdgcz7iDox+15amFyyD6g3L+qLeBnLyPQccNCOWsI
 yJPJ5kY76HK7GrcSBFyfWZFZbfXfFRyAGNhP3jYRA4xIa/TGm/w+S2/Sdb3IerGKf9cI7hM
 l6VVmwkRYjD41cDe8hbEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0tRcFsdeiKo=;HMTtuMVNvR3I/FM2H+70JPTmRD2
 WKQaB9d3iEfnJSUjKeok3EpvQWIc7R8THpSJZlrL5/JKPOrYfkaX7ecLrjfEAE1ZBJuDiqvRE
 ZweitIq5VKOuW/tSGaI9uIWXR00Sh31Ij60p5lmPhOMUIcc7oFKjGukZQeO8sNtofhJXmPvGb
 jpWAtA38xnzksdSt0nHM3p7kv1+o6A/kdAhn13kF8oqhp+t7AZEiDjRW8vidiKG7LoKndeE1n
 qsUXfbZEc38lx1Ga00wqg4a8DylCfwEAs58NbLdKVGp3a8esw1dc3dWDbrLVoBVF6uO1ZHC/u
 2ljpFy9KFdc6VKVU1lTiYdVbq1BF+AKsCpNL2+gwxFYw/VoKTplqouYnPkY9+wbNvHuLxoJ5c
 hWBMJ4d1aW6UpCYKNVGcYHC0dGQNgPhbxvggYXdPB7Ng3RuC1yedqywAJm19QmXHFrwTI/WSf
 01vViWRcs7D+GRtCMvp7K9XRsxZirC0oxB7NMct35BJkzvq/QpeucrxLOuS/L0P++2/5ZKmJk
 qRc1H35uYIfohS8nbDAkb1gIFMAto4KOX+JQCGhw4lJNJNQ/dx4LR32afE5i+UO9jhtogeHoI
 IbpF5XfbvFrJm+kuBYHdZwIck0QbNoqdlQNinljPdV0Go4OqSjhu+qNzDCHsQccG5YCdznH4K
 w4suTCKNPeAj3uFm7xgzTvL1+6vd6Sb0Se+CFuXmVj0Hk8v39ngTylSyXTeYjpNZnX2GM55Ap
 NoHLJtB0OmpoehekZCwOSLvcUwnFAtdpD226RT3U++Q6eFFk+K6Ca9WscskclEV2TaKgL3XpV
 zBqbjODE5kspJ2TFkjKBZOcFxolJgkqwG3TVp/XccN3fc=

This series enables SMP support in bcm2835_defconfig, so that Linux can
use all cores of later Raspberry Pi SoCs.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
Jonathan Neusch=C3=A4fer (2):
      ARM: Refresh bcm2835_defconfig
      ARM: bcm2835_defconfig: Enable SMP support

 arch/arm/configs/bcm2835_defconfig | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)
=2D--
base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
change-id: 20240704-raspi-config-83210de0f5f0

Best regards,
=2D-
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


