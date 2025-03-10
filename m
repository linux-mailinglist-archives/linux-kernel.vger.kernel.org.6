Return-Path: <linux-kernel+bounces-554074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF74A592A6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB5D3A64D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9AA21D5B2;
	Mon, 10 Mar 2025 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Kh9aIpwL"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66E42A80
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605751; cv=none; b=DtCm5TW1MYy1ZxHfKjSBS3Eu0mAsSm7j/q0qO7Ns5AxO249Cz/H/Kind2MKjv0Sh9Yj6QKpl8qSQ+ZSPPBnJIM/GkuHYtSM7JvIjKvtpEoUuWlWG9pL5mLzme2w7FF289J+onZ454a0qAEFAepWOZCvBcfMGbTNZmWbc5cM1IBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605751; c=relaxed/simple;
	bh=1D1D5wyVUAQ2OmzWtlxTmOPRxMs+FnWyaZKv9VdFC4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=efUh9yKksKU0uM8bmXGrT7euQl7QWSkaaCP3xIIvCcyZZT/wD9jRTjUeIFA3VQzqJvj2+3vjp+5HghNJ2rAlPa3FdiuE6jTTh6iKwVQnH2MY2HLCvZ6lSWQ+k0rEpAdJEZEm8Eg6W4h31CWRN9x6rbIOyhKAW7f2Vrexd6mp8mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Kh9aIpwL; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741605733; x=1742210533; i=spasswolf@web.de;
	bh=j37ypas+N8FkxTzRTEJoTVNpTJQUrTecvIrvPx59+Do=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Kh9aIpwLje/BX3+kqGGcoONSaR7hIRMxoB8fRduIq6SllNo1mhxELIHP+dCRSQ1D
	 eqtfTn8CWW8MLRgy3taBpC8zxqeM2h7o6leNugGLOV0Qmk/wePnOnH+MIDD/n6hR3
	 GYEKTvlRTj+pNQts1cZqnumZNa/7Lp37zu8xq9fmIk2fKBygGXt73FwreLPVh2iwX
	 7F7TmUHHQIqUrtK6WBg2Nx8TPiyXI3JxU7CVHjaVWHO21/cvJqN2nC2/ojicOOVK9
	 TkQ4QS5nOAE8+mDBcgMMXvgcjN0xIBOwxMlBPBLOVVSVyHsBJUp8l5qRLMdQFvtqj
	 8L4lcf3LuX+bvMB2vA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MLzin-1taCma0y9Z-00UQ5Q; Mon, 10 Mar 2025 12:22:13 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: commit 7ffb791423c7 breaks steam game
Date: Mon, 10 Mar 2025 12:22:04 +0100
Message-ID: <20250310112206.4168-1-spasswolf@web.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vehwg9gJojuWPO1SveeN/8l49i5hQLSVYog1Qpj/6fE9jXH8rPe
 3NyScvgVAnvIpqQ/5FtElR18N6rHKPGLpvnTLhQg7cNBZJDdt7GdIpKY+uqK0hiDA4FlYS6
 zLvUN/wOLCYAYCetp5OqeBQ09sncrwP8rRXzp8CpuJhyUwbuJ6+iLqwznfAnuPvF4yV/xYi
 O836KgS13szEt/ujXa5/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kTiLBe98hUE=;RG+FAN0WhJmYsuEW3XID1qt5Z+x
 l2E1AVfxrvMP48deVmmXAGRDsuJXOvOCBIJFfr/yV8LKO4XiGynnSM1kPMsY3dJbT8BLy32rl
 G4O5mEuWZ7VGOew/niF/YncEk+qRDdOlJwSlb+kalopWdxfK1lw+FKRxpZ0ISj/eZPICDXknw
 TW8KEwHFU7o22bYwqLSgYv0YQ1XRS6/SM5BfjxMh8FuxGdkMhGLMSCfCwrCj70NSDmrOuHhA1
 YJ44MUlEir1a3nj4Dq2AVLogBvEAXTbfc5sthYX4F6fLD9erjdoacgp7INtaFe2yKBPQ8wrcL
 JOyhY7ZZkO99yVx3mgEHEWglXE3GpE5AnWdVFiLDmIVTHCN8fqNJZL8gLGt/n0MGbUg3gOnvG
 j7by60Ytkcon/+k6dEc5lsR84CbuDee7quF0hBqchWu+AKqWhgt3JOGU3vK1GQARhwU8iQvxB
 UGjSZIDr3/BN54Hk2QkDp5uHaq0W//07sb+/LYDYyW39XnyJcmHjQk27Nmln8eWVCPkbpeYtO
 mMkBO/6yyf+qI0l42mNqQo5vTZdLEAMGVHwNyJp1CV30bKSPc6+EGhxxtIr/Mic9RyrEALPII
 B0ANCmA2KzUSN7pADKxBHU/bZ6HLVk+fTMxXtLyoV8XN6pvKzerarxKRfRsRKPYlNaqOx6j5I
 GPZZIDWCqghMSGGakVloWgzn4Ga41bBmI3MD29x6g93cDMBQ2vXlZ25Kl/f6Y/Zr4Dlg0y61F
 j8+y9gZSf1QVtayKJCuj5HDrElDx+hyy8u15h0tnZRxT/Vvd380Arx253CeUHTkVfVBVbLMjG
 +sZvim3uVH3PI0FHOSKBsAzj0j++7CFNC6rt93955G9MFph+HKYDzySKm8stpNRC7Xvx3L3pO
 SGwUBYQ0bAPq4O63m19zbVfPCsBEhY/hZm9pu/VeQCC2mq7r4BaAHZD/CsNNXuwo+ZvLJZuBl
 8YaaEpsbQ+kZKhP6OzIvwccnsfhnReOwL7NbzkpKvUIE+J6BZ959Jh1yZEVtDH8JiwOCc0eGR
 enNXkEYGRSeF+XOkeyGmPXSvn1/fPOKEvdQk7G8EcOzEqBPuZoiVujB+WJ0r1LMXJOujHKyl3
 81tXHm2TeUhNj0dRHqXQ050yweX2g+H3kTQEZE8reXD8xUQ2mWnchwy1oT9x9bf1YWQtoIEkI
 x7KiWvYYbXeMt2TBDG2pY0TM+wvw2pXlhyZRulb1c8kcIauWTVnbw1OJ9m2zzmY1SN0UBJvLk
 ownQtmMv6ZKkQrrjSWNjhHOooCtd/+h1QTOWr1NHoqTrIbiUV5AKpzJGc7NDY1nQGFdkorVeg
 ebMUftkqwNrogLyysIbpRRm/aDToFqEsctbhgguq/QgrJRCG2ToJCHqadaPXzXg5ZraX/OXur
 3jFNpEKOsaW6Cqj0ytzv1vRbAZhLR05UKiqD2OpzqdMk61I7qUaD1UuUjj

Using linux next-20250307 to play the game stellaris via steam I noticed that
loading the game gets sluggish with the progress bar getting stuck at 100%.
In this situation mouse and keyboard inputs don't work properly anymore.
Switching to a VT and killing stellaris somewhat fixes the situation though in
one instance the touchpad did not work after that. I bisected this between
v6.14-rc5 and next-20250307 and got this as the first bad commit:

7ffb791423c7c518269a9aad35039ef824a40adb is the first bad commit
commit 7ffb791423c7c518269a9aad35039ef824a40adb (HEAD)
Author: Balbir Singh <balbirs@nvidia.com>
Date:   Fri Feb 7 10:42:34 2025 +1100

    x86/kaslr: Reduce KASLR entropy on most x86 systems

Reverting commit 7ffb791423c7 in next-20250307 fixes the issue for me.

The OS is debian sid (last updated 20250309) and this is the hardware
is an MSI Alpha 15 Laptop:
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
06:00.0 Non-Volatile memory controller: Kingston Technology Company, Inc. KC3000/FURY Renegade NVMe SSD [E18] (rev 01)
07:00.0 Non-Volatile memory controller: Micron/Crucial Technology P1 NVMe PCIe SSD[Frampton] (rev 03)
08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
08:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Radeon High Definition Audio Controller
08:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) Platform Security Processor
08:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne USB 3.1
08:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne USB 3.1
08:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] ACP/ACP3X/ACP6x Audio Coprocessor (rev 01)
08:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h/1ah HD Audio Controller
08:00.7 Signal processing controller: Advanced Micro Devices, Inc. [AMD] Sensor Fusion Hub

Bert Karwatzki

