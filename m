Return-Path: <linux-kernel+bounces-308790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB739661D3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A98FB2A988
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5AF19995A;
	Fri, 30 Aug 2024 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="f6Uu8AR1"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E18193085
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725021268; cv=none; b=Z9sPZs+2e4lRFm/deouHwmBTJ7qCjgP3pJt+aXyme/X2pjzv6LQl40r40ebJqKHc6Y/hktPo1xw7fN6KgrnK/4gvDCTk9qcrxJxDUokU4fSAHaFr8umqXMCF0Ci37Kpc8CsYOjhTJ18vrI/fFQvdQHb3d4dnivxm+qnKdl8PwTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725021268; c=relaxed/simple;
	bh=+E0HUsemRt30Ws+ESUAG4yBcIxRWEYy3IyCO1t1myE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRBih/k2zrW8J0G1pCeFfQHcPm1KD4BirHVDtDuSOpLexj/T83u2QvRX52JG2J+GjLcw5AVpetacfHPXhWrsGaNfS50ZAtytLCzqzgh70Wj+u4lwiF5szu9cASposdfnGGhZd97UTZT1XJWI4fqx4703HIPD/Ukef5WSy3fRGYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=f6Uu8AR1; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725021256; x=1725626056; i=spasswolf@web.de;
	bh=+E0HUsemRt30Ws+ESUAG4yBcIxRWEYy3IyCO1t1myE8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=f6Uu8AR1JEufUcFhkmGAqNxzLeQOymRMLXg+b+mxgoCpz5mnPypZOI9M8uyNjT4C
	 x+TPQ7XVIvZYtyGegqglqr1L40SsRK16xu7rrFxIwFVslU0YGQNQg0iO3pbYiTD6N
	 5k4xdLOTttCzE56ThuuqhYgNszhUxAHCla3Y8F3HfU8jBIMkvrXP3q7MP0eEr5nF+
	 gwcXh+n30mP5290zGgUajnzRoNYnQNWaE02RqwkYlCh+IwbXryN5At+cxQ2Cy45O1
	 gMkVDkxh4cyL5uPgbOG74efXFgVqU14sgiL5ChHx10vnn+oVoFQQ+/DldLyU93aZ/
	 G9zO1i5nUC9Ot2VeuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MYu16-1sWpXk2Bge-00Vmk5; Fri, 30 Aug 2024 14:34:16 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org
Subject: commit c2fe0480cd77 leads to hang on boot
Date: Fri, 30 Aug 2024 14:34:12 +0200
Message-ID: <20240830123414.3341-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:h3mUWIRZ7GzYthgzf3IJfrdvPQ4qVsWxxjwCcRGZ+v1/mwEE4M4
 /ulyNH9SdZTr2HQT6wUQBLPH3DvRqdBjwmfeBkiDSBblH95oP7KDpp56bfUSJ5K/pL51GUr
 mtsnLOLGg/6/H6ts1MqCtJGSKvoskjXByq6MnDtAobREqPsuMCtzp2yG25A/05ldh92b4I0
 q/cWVTG388FRM/RbnqCfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VJoOBcfSC1M=;IBcuB9rfGh2z/r45ZfdATeRCfgI
 HqSIxra8Xoj+poH5Yb8uxSJaWynoliHrBj85OapOT8xYUro5wrZsQc0zEmMqt6QmnXVB7/apj
 LU0XkYWk1JuMt2VZuA/A3omwTp/wYEMJCluYA3eUPrV8+0P1alNffvVbNPhyA9A4CaLfI2aPw
 WIL+CjEtBohPcJ3lVSltaSCNp/c7ftpVxQhylgxPUK88qYwsUBsgZXazQwnaoxbgIx6Z+Y5QY
 IlCoQQsZ4Je5Sa2Bf+GQCMgHQ+vdN1JGQG9sdPVkYeYmWSVia1BoQ1KjG78Wxdxag062oeGHN
 Pp4O3JNZiM1Y8Lwot7hE6piAaj4ClSM2EmOjS7a76VuIIXXnd318Zru691eiKzlFnC47CqbBd
 05snda27s9QazI8DP2z2mymLO0xuBLp3Xqm9RyXzpxqhgBvcLp5T1CFP3LTFiB6+SjxAhoZZD
 Xs5jnLWR1cdGTzgXugpg55PSAvUr67r67jbD8YtAPTF6Kv/8ms6j3PYl0tj3alG8bZpQcTPx3
 LM4AsZXSYNHE33hmaDZHgFxXPESAE2a9I0bIigcPk2ACaPRMlBg6ffwYn00KPwUhMfeIBZZ+M
 ad27kaLOf79GYRH8HJUcBWj9XwB8yFiEyvyEXRptneKKlh4cRjmwZzab/Oe6v1UlcCgErWpnK
 fwie7MTy8Szmapx9tN5d3UvP3PqBTATs3+nQMwSmcx+W60Kafqsn+mhKqOuErScM0GV6Qb17L
 GHfZPvvvHCh7ejhC48fszfnm7Mzp7+oEiw0sFRTgjRLDQWzlGxp34CxEjitwTUjHQq9Ls9Z2l
 E7stuA6qdhp+xEbkiol4xTLg==

Since linux next-20240829 my MSI Alpha 15 laptop hangs when booting.
After grub displays "Loading Linux 6.11.0-rc5-next-2024829" and
"Loading initial ramdisk" nothing happens.
I bisected this to commit c2fe0480cd77 and reverting this in
next-20240829 fixes the issue for me.

Hardware (OS is debian sid):
$ lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe GPP Bridge
00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe GPP Bridge
00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe GPP Bridge
00:02.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe GPP Bridge
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe GPP Bridge to Bus
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 51)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric; Function 7
01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Upstream Port of PCI Express Switch (rev c3)
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Downstream Port of PCI Express Switch
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23 [Radeon RX 6600/6600 XT/6600M] (rev c3)
03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 21/23 HDMI/DP Audio Controller
04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz
05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)
06:00.0 Non-Volatile memory controller: Kingston Technology Company, Inc. KC3000/FURY Renegade NVMe SSD E18 (rev 01)
07:00.0 Non-Volatile memory controller: Micron/Crucial Technology P1 NVMe PCIe SSD[Frampton] (rev 03)
08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
08:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Radeon High Definition Audio Controller
08:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) Platform Security Processor
08:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne USB 3.1
08:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne USB 3.1
08:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] ACP/ACP3X/ACP6x Audio Coprocessor (rev 01)
08:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h HD Audio Controller
08:00.7 Signal processing controller: Advanced Micro Devices, Inc. [AMD] Sensor Fusion Hub

Bert Karwatzki

