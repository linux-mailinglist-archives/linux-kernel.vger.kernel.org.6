Return-Path: <linux-kernel+bounces-243740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5039299D7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 23:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8E41C20D33
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 21:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4EB73451;
	Sun,  7 Jul 2024 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="CfFoDAPL"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90165FBB1
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720388946; cv=none; b=gM7gMkUQfU1n/SPZTe7XFidT4JL46WXwStvQ+NytkRFiZVgw/GiCMeS9ZsThm72mZA0eoBKbKFOdTPrqPDi+4FKLaOU6rzwOW+BXT1TVn7vqi7DHZYyH448H/ErMe+fdqw8pNAsHajc+JA3borJOAZqI0rzDO8SEi2HBiQLwwcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720388946; c=relaxed/simple;
	bh=KhneZf6qQ4oQ7PsyNOV6bd9KOfaDfiA441VDHf9pd2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MNzTD8HIHt39gjrczKVQiNYHl4hPSocuMxQL4Ec5qmenMY0jDyNJnmSccGoIkTfA6VFxKWKzfTKnSzq7R3eg9fRIaV0Q1SMb8iOA/okNgiox51B7UvBOn+uHWyArz870OqQoVnWFZ17ZHAEYYNSYcg+OvSDSIRHtyqdnac0hR/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=CfFoDAPL; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720388934; x=1720993734; i=j.neuschaefer@gmx.net;
	bh=KhneZf6qQ4oQ7PsyNOV6bd9KOfaDfiA441VDHf9pd2c=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CfFoDAPLW+z3N4fiwjZEO2AfN9PHbGOT+NJffWU97QGHhyFLkDSAXLxcRphzAlVc
	 VgVvgkguKF78/42+p4PhJMrmb2fPGa3qin6zh81rqpvwsFHjE0OJvjMgB5elbXXxq
	 xH9h15a6RWVYK6mmv6g7PWDBHErYDVTPP1Y8qCZuVP1mo8Mk7S+eG0GSnHohxLMKz
	 epPSNvR9cQN2WhQ6wq1VOKbNQ20v/bJ8nLFWDygWMS/xs3yiXG2OF/4+dOAKt4dUo
	 3vB9eLkJdZfwszLG7LY7nxZ1YXzAMbTjmQMIompX02N23eYqp2HK/u8WNc7VRCWt7
	 3uLswrtceOnmlblXbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.46.161]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ygO-1sVXZA1xoM-004cWF; Sun, 07
 Jul 2024 23:48:54 +0200
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Sun, 07 Jul 2024 23:48:45 +0200
Subject: [PATCH 2/2] ARM: bcm2835_defconfig: Enable SMP support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240707-raspi-config-v1-2-3e122f2122e9@gmx.net>
References: <20240707-raspi-config-v1-0-3e122f2122e9@gmx.net>
In-Reply-To: <20240707-raspi-config-v1-0-3e122f2122e9@gmx.net>
To: Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720388929; l=1498;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=5/vPRCIWXNT75L/hwAqvbmyQXKrbHJyQ0YQwH3Uoo7g=;
 b=4KsWSY1DAsSUz9OUrN3L1JVzB2NbqjMGWetKfNX/vaQCI0ZxohEwIdaT2usz9RHJ9Yc2wr0S2
 Ur4FmtixGulDflKKv01IHXO/hw3iS+O0bkHFtONMm673bmS5Uj6FMmA
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:IUvmgMn/x+KVAKU8eN1NPMZIjqkXdESwg2H1qWT3TagatsLn1ha
 nlcfXW7pwhRnLmb5wkuYylQF53lWyq/3mt+fOo80wtR4fmDdon7qTBoBx26j3XcdQvOhdfw
 WqhwZobi7VAD0KXJf1bY0s6TjWz4zEnl2qEalpT6nvLG1DaAOAOL8AG9JCxRhaWDML/Leq/
 Na9rTrPWlP+sfOIs9bHOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0://NCBbJFXEE=;OAhoyy0JZjkhO178SNg+Bq9Q+AP
 SOXOhfdVwsVUJkbBtCmJTO1IPwXMhzFHuU2C9tYIItpbD7F0M814q2G339FXADz+GPxRxNZbZ
 OnMHq4NW0RzZdiRrkn4kcqG5YvCU0GCIMWwtfSKPgXcwsOfMXOZxdqe7nhgXPoKmRJkwLT6qp
 vBpNoyh1GQzqxLvQd7cIlJILyymteYfi0gVtWUscvpEFt+Pzdj3inKcRn2I8R/EyvAQoYg4yN
 yJDjmg3F+T5D0loyzog+DcAyR/giZVMJU/QIeXQPt9MTPLAVjKCqgqwXdm08vDcgmm7fqrDhE
 S7qeITkDOTNe1kjbZKs4XexGJ6OBBoJe9wopq6cwlp8Qtxgrz9CyODiFkozpiSF2LGR+1sZx8
 urPTQHrRjz+3Cz6THW2cgvbKGsRI7kr90zaz88C31jxJvFdUGRPZ8IrHCsFDuFYphqfUiNVZx
 HmnBBksFXXjBCV1JpUB255kqYmFL8vu4Z1S0XpYzctYQTVszvp3YSw96OwVBMOgFH4oA08Elc
 8LMmB5PEsLxOfy4dv50Seaew7t35Ztj72/2TnhjtOnsXPKOE0HPIik9C7xHzKnv718MXjSzWi
 PpTSXbRu3/s+dLflCEX//UT1WOofMiahrVodbAtYBbijc8Sct+7tUaFQskXhxJxWedVfKPM8z
 Xciyqa6cggEGLVuPniC4Ul31k8Fou99UuW4+4+UqBoxOSlUz2EyfPVlv0nc8nJhR3WsbEkXjo
 2rz1ZsFTY8leJiIfyJ/kwyY28+VoT4ojC2htusS9+4rJjN/aqSQ9ikQtxZ3bIRrZV/iJIQ3ua
 cRlNMN87VgKO6WFk/2sco2hk+aUL7QHlFIZfamD/jsXNQ=

Since there is only one Raspberry Pi related defconfig in the mainline
kernel, it's useful to have to work well on all 32-bit Raspberry Pis.
To that end, this patch enables CONFIG_SMP and CONFIG_SMP_ON_UP, which
allows the kernel to run well on multi- and single-CPU systems.

PM and suspend support is necessary in order to keep KEXEC enabled.

Tested on:
- Raspberry Pi 2 Model B V1.1 (BCM2836, SMP)
- Raspberry Pi Model B (BCM2835, UP)

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/configs/bcm2835_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835=
_defconfig
index da49dcfd359050..d505058715b66f 100644
=2D-- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -24,6 +24,7 @@ CONFIG_KEXEC=3Dy
 CONFIG_ARCH_MULTI_V6=3Dy
 CONFIG_ARCH_BCM=3Dy
 CONFIG_ARCH_BCM2835=3Dy
+CONFIG_SMP=3Dy
 CONFIG_CPU_FREQ=3Dy
 CONFIG_CPU_FREQ_STAT=3Dy
 CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=3Dy
@@ -33,8 +34,6 @@ CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
 CONFIG_CPUFREQ_DT=3Dy
 CONFIG_ARM_RASPBERRYPI_CPUFREQ=3Dy
 CONFIG_VFP=3Dy
-# CONFIG_SUSPEND is not set
-CONFIG_PM=3Dy
 CONFIG_JUMP_LABEL=3Dy
 CONFIG_MODULES=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
@@ -175,6 +174,7 @@ CONFIG_DEBUG_FS=3Dy
 CONFIG_KGDB=3Dy
 CONFIG_KGDB_KDB=3Dy
 CONFIG_DEBUG_MEMORY_INIT=3Dy
+# CONFIG_RCU_TRACE is not set
 CONFIG_FUNCTION_PROFILER=3Dy
 CONFIG_STACK_TRACER=3Dy
 CONFIG_SCHED_TRACER=3Dy

=2D-
2.43.0


