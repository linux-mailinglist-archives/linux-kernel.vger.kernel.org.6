Return-Path: <linux-kernel+bounces-243739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2AF9299D6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 23:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270C21C20834
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 21:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923D96F30F;
	Sun,  7 Jul 2024 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="sjhaLm+Q"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43612E85E
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720388945; cv=none; b=KEqksDsFkT+sSd/ByqKeOVts16f+5R1Xpj8d8rbzy22kS8i6AgR5EPQKbBvJp9FwejlIfvhrIbOc7OsvVVUKgiz6emodxf0ahuhK6CK8abiX3lhyQt0p6maVzoTXmnDt6WCInP06gbUFbZC5IcVMLzEQePVoSXkS8wsoDj4P/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720388945; c=relaxed/simple;
	bh=PO7/2/tzLNB78+f9AErF4IDaniyiZvOKAl3APkubwQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Re9p/chc3DWBFM3uRB9Zs4zxA64jOLMXgGluQuNPTv2jPpBuUCeId1VIN1PhZ/saZTIoDZbKTPQPc8Q9SHJq85KqvMJtHH98YKuUjDfgJLUYDqCAbodgYHU87/5PpK04njIqTqJFtQ/8dA1OPSBY5siaJOZiV4SmFU0EHsZLPio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=sjhaLm+Q; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720388934; x=1720993734; i=j.neuschaefer@gmx.net;
	bh=PO7/2/tzLNB78+f9AErF4IDaniyiZvOKAl3APkubwQA=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sjhaLm+QmlLvtTbho0+zVKq0SJ3T8H/FXpcSrIBTexcxlZAnG4HDX8CjHDj6VGLn
	 OTj8BABFu2AjPqHtJhX5QCDPHGmyybXAIk1LdiIR0xMlsx2cLGwbJnfIYMqkSLcVx
	 rjNruEUVlwlvzPqK99jK/Xl/Q/5H7aw45Dt9OIhHzkeuqbQcX6eOpYJUZp/PdiB7n
	 hIfMrUuX9Q8CqO6f8F5PvJrf6BMM92Lc87JH6CuYI56TClDNXPCGH+/6n0WCOWfqP
	 AjJTYw8x7M395HW3DYiJtqe3IVnmctG7h2hyE1xLMp2nDpXkzTalcdKKO4aODgQIT
	 /fs6cLP1YBEAPrmuNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.46.161]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbkv-1sjcyc3XnH-00QkON; Sun, 07
 Jul 2024 23:48:54 +0200
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Sun, 07 Jul 2024 23:48:44 +0200
Subject: [PATCH 1/2] ARM: Refresh bcm2835_defconfig
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240707-raspi-config-v1-1-3e122f2122e9@gmx.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720388929; l=1746;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=gG5aeJ1NV5YQ25Ok5T862TRdfJDv4oCr3nhRsaJBQ1E=;
 b=3P4mgQzdEOBeVnDDKqHUQLNbK0XOh800UTz2M7sPM87kztu4sZ+g8oWu3VHjNpgSODd/2mwcr
 oL0vvjT2vRzBDq8bw4hAh79ZzPSOaUYRwQY6gb7/Ma5e+fjzwg+9y3f
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:YaKCBD4hZvns7M7BoXE1wDC1zgv/VHJqNOAlnPLIuxeZ69oDyHC
 DdL1Fh1zLi6G+GgwwF6pxlhf2kvkLXeC0/WfaY3NqBNHj30P2/9iY7HnYUW6PislWa8H+X6
 nRTcp3a+OQ9ZD2gcP3kex4efAeVQmcImf2TVAWgXaSneR3G2Fn9eaIMfHPyOORMk+ldqyjy
 LoIH7yAyWcAQZ6MxM6Oqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+YaD78GVmuA=;YoOaUWJz9Ctn1PGHi6Fv6+uEVYH
 HSK3FNquGeZItvN9tMWKzoKwm0FGWQGAURd0vrvbIxRClb1ZsLKW5P0JSOnTXiup0qCPTrJmf
 J0iaCvYo4v+DPkcFC4OcVc4dw6+kEIvrdHixFfAF7kQfeb6CPNBAiSOXZI561ZzGJfAdHpNmS
 ZPLXS5UsSN4IwAGdj1CTIEZjdYucB/IIDwW4milBuVB+4lIPP7jCAwUqxoRoHPBb7S0BjEe19
 pBy8IOD67WWQXOFStLUASvVqSDnYz1o1pOALJRABj1Lg+d/hddG+qVXl20d6fkklpH0y2+SE0
 QoW2fwRUZR3msA9pQzoiJz7IzUN33bIWmoIxfZ68CWLSDHxI7TN3ftvrsuH9yoEnUL8vQk/3t
 cwdJRq7uMJpDdNsiT5ilwd8QC2CACvATxSfPIuGZi9GjHrhI5JjVs4xL+d4RiL7Gjvt25M6sx
 6hBAotq/NrUYuJtoccig0GkStbeaYD00TsFXfcWJ0uyT540PhWeAOiAwngEX6yXDrcjbgIpez
 F7hGiF0itlMJyYvd2HupC8Qj0IG9z5+6vkaQESm0oAiSYpLvJbOooqT9Orcfugnfc7Q8XIlUi
 fXHc/xLiUzXXQqpORHiNoioB0/fhAuRSIv9anp5iq0r6Fvzx2gd2o14+KyYolaLT2eAwe1FHw
 mWNy+xGTTM2XzOQ6/oOKzplWtDmuMngzF0ZHoAKxlcJWiPXyAnpTlqTFw2tR0s2MTjd20K7zs
 BxVEMZciR5aCwKB8Zqftud5MLp7sJRT8RYnHxC8hMYdLKbmEYZxGPMPv+C2Lb60Q/VGtMKa0a
 s2gUFS0+XW3POEBbptyNqB0aqv2LiZ5Q8HqgocOZlRECY=

Regenerate bcm2835_defconfig with "make savedefconfig" in order to pick
up Kconfig changes that happened since the last refresh.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/configs/bcm2835_defconfig | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835=
_defconfig
index b5f0bd8dd53699..da49dcfd359050 100644
=2D-- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -9,7 +9,6 @@ CONFIG_LOG_BUF_SHIFT=3D18
 CONFIG_CFS_BANDWIDTH=3Dy
 CONFIG_RT_GROUP_SCHED=3Dy
 CONFIG_CGROUP_FREEZER=3Dy
-CONFIG_CPUSETS=3Dy
 CONFIG_CGROUP_DEVICE=3Dy
 CONFIG_CGROUP_CPUACCT=3Dy
 CONFIG_CGROUP_PERF=3Dy
@@ -21,14 +20,10 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
 CONFIG_EXPERT=3Dy
 CONFIG_KALLSYMS_ALL=3Dy
 CONFIG_PROFILING=3Dy
-CONFIG_CC_STACKPROTECTOR_REGULAR=3Dy
-CONFIG_CRASH_DUMP=3Dy
+CONFIG_KEXEC=3Dy
 CONFIG_ARCH_MULTI_V6=3Dy
 CONFIG_ARCH_BCM=3Dy
 CONFIG_ARCH_BCM2835=3Dy
-CONFIG_AEABI=3Dy
-CONFIG_SECCOMP=3Dy
-CONFIG_KEXEC=3Dy
 CONFIG_CPU_FREQ=3Dy
 CONFIG_CPU_FREQ_STAT=3Dy
 CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=3Dy
@@ -103,13 +98,11 @@ CONFIG_REGULATOR=3Dy
 CONFIG_REGULATOR_FIXED_VOLTAGE=3Dy
 CONFIG_REGULATOR_GPIO=3Dy
 CONFIG_MEDIA_SUPPORT=3Dy
-CONFIG_MEDIA_CAMERA_SUPPORT=3Dy
 CONFIG_DRM=3Dy
 CONFIG_DRM_V3D=3Dy
 CONFIG_DRM_VC4=3Dy
 CONFIG_DRM_SIMPLEDRM=3Dy
 CONFIG_FB=3Dy
-CONFIG_FRAMEBUFFER_CONSOLE=3Dy
 CONFIG_SOUND=3Dy
 CONFIG_SND=3Dy
 CONFIG_SND_SOC=3Dy
@@ -178,8 +171,6 @@ CONFIG_PRINTK_TIME=3Dy
 CONFIG_BOOT_PRINTK_DELAY=3Dy
 CONFIG_DYNAMIC_DEBUG=3Dy
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_LOCKUP_DETECTOR=3Dy
 CONFIG_DEBUG_FS=3Dy
 CONFIG_KGDB=3Dy
 CONFIG_KGDB_KDB=3Dy

=2D-
2.43.0


