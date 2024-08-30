Return-Path: <linux-kernel+bounces-308792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7649661DE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC471C210D8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B10B19995B;
	Fri, 30 Aug 2024 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="E9h3ljOh"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7FB1898E5
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725021476; cv=none; b=diWI7skiblgKGQWrcZRGKuIQEVvOxE5L6uF6g2CDQXrck77DDg1aAFLZyMSjG8qqJWTf1X95I065MsKDmCV5M1/do/aX3QCyiB13pEcjthfctvsqBkm9And79vDHZji7UUZR283wyWtTomS9GwXrScpkjU1Cd5uxH8YXsl/Sk9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725021476; c=relaxed/simple;
	bh=xpanB0/kJfspPoCJky+oKGofM3KImGK43I6v4SwFEVg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rRorFupjZQHR7G6Vqx0en754UOR5PSPFc/tIMOtYHLT9Qfd3rIX5RguuK/3jXv7fWQYUI8e4u28Pc8usrveKJNhBLU+ZsYxSRfm3g6w5NsFxHA23+PhUTvJ3NPfQqSRgHQ+9JDTTD+qHb4aLJNEGUzs6rpSn4Bv6K3itJ3lkc0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=E9h3ljOh; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725021471; x=1725626271; i=spasswolf@web.de;
	bh=xpanB0/kJfspPoCJky+oKGofM3KImGK43I6v4SwFEVg=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E9h3ljOhlP2YeaNRAV/CjNBygFKApvNlkz+hEWah2vInlqCxjkxv+SdxR/scNUyI
	 Y7ANuDr2TxbIv1bDZmnl6dj0s2PoqH2wCUSDCmmUmgr0HoKtGogIk/EnP5KhVTDLU
	 knsr3qpfRIef9bfWlZhiWfSVgoUsLpjMKRKw6I436RGJBiuN75K5MnRCH8oKoLzGR
	 yiPl4BoiUkSYEOYbqLi137zWU6s6+4sHwva98UI28AhLskjSImtoV5QUVq3pubMDx
	 L3zlr6KEq/7W8Fspnr9Nhzn8D4Rot4gr6/2OpdTmeK0wcfTdIo2rhel4D9hvglSso
	 DWcEAnLkYSAEdKhJ1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjPU0-1sMBfB2cTS-00fFDC; Fri, 30
 Aug 2024 14:37:51 +0200
Message-ID: <c7526910a5416841b95822597e132a5a1fc1034e.camel@web.de>
Subject: Re: commit c2fe0480cd77 leads to hang on boot
From: Bert Karwatzki <spasswolf@web.de>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, spasswolf@web.de
Date: Fri, 30 Aug 2024 14:37:50 +0200
In-Reply-To: <20240830123414.3341-1-spasswolf@web.de>
References: <20240830123414.3341-1-spasswolf@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:evdYxzAQNdlEkUfTx8itcPg1oy8dGZmaRKL1My/XDnwnfVy9ztl
 E6aSEWlUd2hdKEiGtcF7vxlj2A8MASR6rI/vKDamJJ5/36yPj1cArnL9YB7eFCZRpDOQOE3
 Q3f9KyIcIlxdvR7GQ712cr6UmMTxGYdQMe0NALwgcH7ZgPL/BGhP0Ci1x2BEqQILvArVzo6
 6QdYC35Xln+KNM3HkicTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cv0xXKaVVXc=;03Z3gsxn91ZbY5D2lsnY+R5Plkd
 WmB+vgTxHGvt9H8zYJjk4TizZuSRlyXiyZxqiq2Ui7CvB3lsJM4oV9vIE8Ff/cKwAucnypAdw
 vXB5FnEvOp/QRmPLNL7P/YrL1SoFwSIj/oYscvezd21WWAQIUfhUkxoGfJcDxInQOz6vN6obG
 Exx9MEw3I8+www92hR3eRiL9zkqZbH/xFGU20rKddRh8wg6Zbga8hfhK/JO6EojW3+BTTQYL6
 bMJY3fNyF54HQ7FF+0ZmthH284jwtai0InIyqJ/tLS2PFDiclNyk0nvZXMuu88/4RvJ2/u5dK
 YrLpHXK4M5F7jJITRMPUmXMxXYXnENM/ACEpNMI9B+TkMpIyZ4F+o/BIh5dQLoum3Bskk3nvt
 jvttG9OpJK6OiApfzcNYkR8rPzlsGtow2oQRSEy+8nHsXu5wjhGDSOQE30zZBc3L3P7FY74D7
 olyOuAUSyi6x58Gm6IAsAOrdF5stZt7Hj+AM9L/vfC6MOQPeBlfPGS2/q3Tjr8nFi7IhmHDBn
 QEL86lX2jxjPfWy1YxZkn3FhcM55uZ1rYq55zNFihEtqxCxjT6sncTkvROdb5cKsSkzekln+x
 Wl7YTKrHCCCGu6WJvkQfS/LS1JTE3R4xWZC5gLynDivIZpITIdLMfG1+Q921odbJtyE3nXxvy
 3VD3QcQwQHvdmx9n7tEB++Z3unvHS730kLLcBiF6dAi9YyG+mgkAtqp2koVT3UCWaeto3AFHP
 9d/fYFcpn1CRcYlrenxvgwFNJf+wMn++m3IwN0OuGlQHyKITVyUW0XgF/K5VMye8pZxabJC9n
 1FZzRo3hfujSxWPwTei0Dq/w==

Am Freitag, dem 30.08.2024 um 14:34 +0200 schrieb Bert Karwatzki:
> Since linux next-20240829 my MSI Alpha 15 laptop hangs when booting.
> After grub displays "Loading Linux 6.11.0-rc5-next-2024829" and
> "Loading initial ramdisk" nothing happens.
> I bisected this to commit c2fe0480cd77 and reverting this in
> next-20240829 fixes the issue for me.
>
> Hardware (OS is debian sid):
> $ lspci
> 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne R=
oot Complex
> 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
> 00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dumm=
y Host Bridge
> 00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP B=
ridge
> 00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dumm=
y Host Bridge
> 00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PC=
Ie GPP Bridge
> 00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PC=
Ie GPP Bridge
> 00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PC=
Ie GPP Bridge
> 00:02.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PC=
Ie GPP Bridge
> 00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dumm=
y Host Bridge
> 00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal P=
CIe GPP Bridge to Bus
> 00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (=
rev 51)
> 00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (r=
ev 51)
> 00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fab=
ric; Function 0
> 00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fab=
ric; Function 1
> 00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fab=
ric; Function 2
> 00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fab=
ric; Function 3
> 00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fab=
ric; Function 4
> 00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fab=
ric; Function 5
> 00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fab=
ric; Function 6
> 00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fab=
ric; Function 7
> 01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Up=
stream Port of PCI Express Switch (rev c3)
> 02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Do=
wnstream Port of PCI Express Switch
> 03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi =
23 [Radeon RX 6600/6600 XT/6600M] (rev c3)
> 03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 21/23 =
HDMI/DP Audio Controller
> 04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MH=
z
> 05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/816=
8/8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)
> 06:00.0 Non-Volatile memory controller: Kingston Technology Company, Inc=
. KC3000/FURY Renegade NVMe SSD E18 (rev 01)
> 07:00.0 Non-Volatile memory controller: Micron/Crucial Technology P1 NVM=
e PCIe SSD[Frampton] (rev 03)
> 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI=
] Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
> 08:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Rade=
on High Definition Audio Controller
> 08:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family=
 17h (Models 10h-1fh) Platform Security Processor
> 08:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezann=
e USB 3.1
> 08:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezann=
e USB 3.1
> 08:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] ACP/AC=
P3X/ACP6x Audio Coprocessor (rev 01)
> 08:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h =
HD Audio Controller
> 08:00.7 Signal processing controller: Advanced Micro Devices, Inc. [AMD]=
 Sensor Fusion Hub
>
> Bert Karwatzki

Please ignore this, this is was sent because I misused git send-email.

Bert Karwatzki


