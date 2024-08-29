Return-Path: <linux-kernel+bounces-307797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61516965316
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C863B1F22506
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F5E18E745;
	Thu, 29 Aug 2024 22:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="dp4fkeYQ"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD0C18A927
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971310; cv=none; b=LD00Ieplz3BpkzhnNHUoArCSBQKf48LPUb+BMOBk221yLQ9iTIohG9XxVdy/3kLc7QSRIm3q6tNOrTTvkg/u1wjx9aJuqRYYwKq32BFee3ukrEe+CQtu2yaWHRqeKurjt9ZnPp42vvUHerZBFh7y9rChLnDgPpysit9TOSJUhuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971310; c=relaxed/simple;
	bh=+E0HUsemRt30Ws+ESUAG4yBcIxRWEYy3IyCO1t1myE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YfacaSJ5kbps3zdgYT0M29MVu8HUZCzUWmbvpYNy6DwNmyeTWZgLYe7sjzVJ7F8SH42i1fpQub8effnEnCvygvO1TUQZzbDW2btIPY1PuJlBeskXY2RfyF+cqlx2IilLVHwsX8LH1JTKC853V2H5RynMaBDrOh+0vvCWz/S4P+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=dp4fkeYQ; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1724971296; x=1725576096; i=spasswolf@web.de;
	bh=+E0HUsemRt30Ws+ESUAG4yBcIxRWEYy3IyCO1t1myE8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=dp4fkeYQWywUUNLc7/xElahZoULzcYpAAVBrOrhtBRQC8U4E+Q+sWMF1kMiQo4iW
	 a3eQSNAdSuDr4bXhNFAr0bxx67jv292zQhxqB8mYFUjC/6S3N53M1hE1X/pdJVewf
	 53yftPY45sft6+G/2ejMu8YsFCuCmFDJlosC4/hx1ccgzyddvhYz8HWvz8CUwCLjp
	 ATbhTtq76PEmbtaVsQc1w4bVDhAZcliQFa2ly4mEMj+2EBA/9nvVFSB71GGgvu2vm
	 sF+Nm7n+ZoeHNBjVipD++HB+xIE6feUIme7sQ/W/ZH63w66DvfDhedMuRuWDdDnmZ
	 e9Z9rM/2Ky0HcKz5/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MDMv4-1suDx80QeE-00DP4M; Fri, 30 Aug 2024 00:41:36 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org
Subject: commit c2fe0480cd77 leads to hang on boot
Date: Fri, 30 Aug 2024 00:41:23 +0200
Message-ID: <20240829224124.2978-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:kORydblWPzl2EAPTDh0N4Qa7OrzkhbhUjKSuQHjkqXI+z5o9j+t
 R4v3SwbfGtBEpN43pwQwGJ/ziQceSz2kH+PLu9Xtgmh/qTFEZVzUtzr1diWAZWUts5cK9fm
 9vgxNU4EgFDLsyIWO0ccDBRdRpZhz2Mr028Wa1OAUq8jy8RO1zXvRd6OuMWt+/lxX984mcD
 uAP/uYiThCC9ikWwu82QQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9c4/uwGrKKw=;FZLUszydBEDCX0Wz6vWcDaLVPOT
 HA4HOMW9d5e69ZHRQl3q8pK0ZXTzCUR2mmVGotHsVd5cz2SHMRvf0PvZ59U1AG3+98H77hkB0
 /7BxRBJiVjGHMTGiQJjFcKyMdMP1FfXRrTXvz59Pn0KCZ++sA9PYEu7pU0WEjbAFOpq89GKcN
 mav5nYcGocDlsz1M7wKTalsXrLoMzvojOu+Oh0imE/DpqC4gsE6gb0zfHG5FnGoPh6ukV6kwi
 VXxCJun5QuJZ1Y5/Igv2YoxQr/AROyw7LNQKM2uV5xnKcIjomNnNDZigzgBO88aXq8+B3OGEN
 iwWGCgp1i5LgC2nqnD9EJJ0qzF85paVtvDUoHVPyUB1B5Py5Ra67Fu4noHshe3/JPv+8PB81K
 TSYqH1HvteoXQw8cQC7n6uZBRGB92kl/egI/AC3q/x41tFArpu1My1UVHE2YRrb5ZP7vpZocc
 9vU+SHmj63QOYzgJ4zGYH9piTiUZBYiDOdqO/XR6wsk80Msn4DPmDTFqjVtvAuNzj+zTZ+nFr
 TW9p7JCxplc1KeON4kcCtsdK7b1BI40Y/SENfAPgYzsC6v9p/ZMNEJTYK/sxT3yoTKLbyrbpY
 y2UnKLYINa/yQ//4so03JBGk8N1wZVcW+ZtAU7fAz6XrY+NLjuCsy+qq1cSQHeQPJKzfcSrO/
 B1FV1Q/IYM3k6uEGIncyEkQ7fsFKaDQQaAAyDBBXcsuiSXmWwb7fSRZ2H+SsYs0R9GRQRmLpM
 zNqDgUqW4L/d5e614nnmgrF71WZdZqJSYVAInsRgLCMzwyVxAMzJl4dXDagIUkqNw8JBm/Poe
 oMxzDUmVU8v91285A47IlYQw==

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

