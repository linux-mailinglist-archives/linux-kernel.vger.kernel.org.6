Return-Path: <linux-kernel+bounces-420217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D242E9D77D5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 20:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A83B36847
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8E31547F0;
	Sun, 24 Nov 2024 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="sLe1+FO0"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9823A13A88A;
	Sun, 24 Nov 2024 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471037; cv=none; b=JlNu+48WRkdiQz+crorAfl8YkSaqexceBvbEQhttX1OoVwzZqqj8fG7GGPjqQixC0+tMu3fhmB77Y0gQyQmZrnDLFgfNIp5OAzLmYjCgxPnxLMhgsFEkp7bbL/3kH407e9Aw+mB3CZ5F76gd9Q38xeSGM4eaLr5eKJ98LeCkduo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471037; c=relaxed/simple;
	bh=kIYnn2IzSJmvPLrK5pTh+LsC/BnqqWEMG15Zd8OS2WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayiGHVPamQuZCBD/Fcr6+CmmGsvrFvTj/V5VpAoBNAgkgVfvl+gsLkLrCMkF3wPSk5vRqx6n0RKU/t8wcjm17v5Wxf+vFxWwXJG0oZtE4SnFAOxAq59ktFOLX02z8youD3CtVaRMzzEXRg9ihelnmaOba8XB/wtU4rR/cYOhR8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=sLe1+FO0; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9C130C0005C6;
	Sun, 24 Nov 2024 09:57:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9C130C0005C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1732471033;
	bh=kIYnn2IzSJmvPLrK5pTh+LsC/BnqqWEMG15Zd8OS2WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLe1+FO0EsVKy0VGXugmce2xefdYj4FvLkt67puwCWXAO7JIWIGHQ2KccbqrWzXNE
	 EEw3hzepH9TVr3YihzdtMxlIHM5S5k5FlF+qhrwPBmKMEhXQabW0gCwYwazGA4v/H0
	 JLr0r5DsQw+8uZbgMPnkg/q87uvLYXAHfnRAhNaM=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 3F76618041CAC6;
	Sun, 24 Nov 2024 09:57:13 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Sam Edwards <cfsworks@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: broadcom: bcmbca: bcm4908: Add DT for Zyxel EX3510-B
Date: Sun, 24 Nov 2024 09:57:12 -0800
Message-ID: <20241124175713.718830-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009215454.1449508-3-CFSworks@gmail.com>
References: <20241009215454.1449508-1-CFSworks@gmail.com> <20241009215454.1449508-3-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Wed,  9 Oct 2024 14:54:54 -0700, Sam Edwards <cfsworks@gmail.com> wrote:
> Zyxel EX3510-B is a WiFi 6 capable home gateway (family) based on the
> BCM4906 SoC, with 512MiB of RAM and 512MiB of NAND flash. WiFi support
> consists of a BCM6710 and a BCM6715 attached to separate PCIe buses.
> 
> Add an initial devicetree for this system, with support for:
> - Onboard UART (per base dtsi)
> - USB (2.0 only; superspeed devices are treated as high-speed due to an
>     unknown cause)
> - Both buttons (rear reset, front WPS)
> - Almost all LEDs:
>   - Power (red/green)
>   - Internet (red/green)
>   - WAN (green)
>   - LAN (green; anode is connected to GPIO 13 so currently
>       nonfunctioning)
>   - USB (green)
>   - WPS button (red/green)
>   - Absent in DT: There are 2.4GHz/5.0GHz WiFi status LEDs connected to
>       the WiFi chips instead of the SoC.
> - NAND flash
> - Embedded Ethernet switch
> - Factory-programmed Ethernet MAC address
> 
> WiFi cannot be enabled at this time due to Linux lacking drivers for
> both the PCIe controllers and the PCIe WiFi peripherals.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian

