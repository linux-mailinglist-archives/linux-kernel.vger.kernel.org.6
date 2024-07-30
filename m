Return-Path: <linux-kernel+bounces-267141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C68940D42
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871A21C23535
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015A2194ADF;
	Tue, 30 Jul 2024 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nOH/Hr3m"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21FA1667FA;
	Tue, 30 Jul 2024 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331279; cv=none; b=bbJvX/s1WJ2b3epw483PgTryNSRvoCBtuTqDmKkX9h/1Yf9RkcyvqBeOLb3xAdwqdDEY9omSsEe3KPWg3AdmWn6dDoNF6oEmnAMYEZmHgwbubWuGfFo0gDRnLniGFP+G2Zjt4cqfcMRgVLouxrqM0WN1tKp/k1VbmgLdIr11zbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331279; c=relaxed/simple;
	bh=o4tOgYmx9IHZXKqcTaeAPkWXB0TNxC4dHpxp0ch94Cw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=St3mo6ywHwZW6yjJPqh1wHpuWUUefMf+BJbOfuAVoQINgNZ75XhC6LjYjm3EEkmqhddZ6QUVyF53QciQSkVlqgm6lBLJee56DaodDHa+Q6rfAbTb99O+44xosMjLI6HedhwmDnR5fQolCVMTTfIkmst87BOcTihaMuKkZsAnAxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nOH/Hr3m; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722331276;
	bh=o4tOgYmx9IHZXKqcTaeAPkWXB0TNxC4dHpxp0ch94Cw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nOH/Hr3mnG3TX5BHt8NrsOxsq/xpuhlHzT+VqI9QWKzQxUFEt69g8ySrP4uN3IC8G
	 GWVYoeQJ+6tpoheISRYFNumC5ATlh5y4hfe+fLCT/z7QOpwVAnKCLkgcW7Svu2pzKg
	 yf2EzmX4at+3xtiloyIkgW0bBSGsvp30UhMzJDM5mF8NQLWbbUqDiUWPTwgGdvrwPv
	 gz31q/VPWGuHQQK95beOkaVNV1J/9R6+K8xLgFUlcFwRlaDI2kyMMnam3OQZkMXAmu
	 qm/Klwh6tGsKGV3ijKU4yffJPtg/NplWBcQEBzwrgQNzBqmHx3o34g3snxqObOmPpV
	 W5xFNx0zVoakQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 790D93780521;
	Tue, 30 Jul 2024 09:21:15 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20240531-tomato-rsel-gpio34-35-fix-v1-1-64ab2545f182@collabora.com>
References: <20240531-tomato-rsel-gpio34-35-fix-v1-1-64ab2545f182@collabora.com>
Subject: Re: [PATCH] arm64: dts: mediatek: cherry: Specify pull resistance
 for RSEL GPIOs
Message-Id: <172233127541.66997.11462154822766150179.b4-ty@collabora.com>
Date: Tue, 30 Jul 2024 11:21:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Fri, 31 May 2024 17:51:09 -0400, Nícolas F. R. A. Prado wrote:
> GPIOs 34 and 35 on MT8195 are of type MTK_PULL_PU_PD_RSEL_TYPE, meaning
> not only can they be configured as pull-up or pull-down, but the pull
> resistance can also be configured.
> 
> The current bias setting however doesn't specify a resistance value,
> resulting on the following errors:
> 
> [...]

Applied to v6.11-next/dts64, thanks!

[1/1] arm64: dts: mediatek: cherry: Specify pull resistance for RSEL GPIOs
      commit: d92fd0cc01b31d59a0e95f44e3f08921fd74fb87

Cheers,
Angelo



