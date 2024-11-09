Return-Path: <linux-kernel+bounces-402968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0FF9C2F18
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689E81F219D2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 18:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF1B1A255A;
	Sat,  9 Nov 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="0+nvDSCD"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3355619FA93;
	Sat,  9 Nov 2024 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731176857; cv=none; b=HM5tIKksD6mJAY0SIae05SsnYFlQW8ri4gVNBSGRV4mAkYL2F65aQ+onFC3E01JUlATGIl5xYTePCcV+V36wuybfbox0v7g8+r3YSsP9AJbu1yYy3BhochFSaTEdB37juYRd0sFJs4P2ig5RB7TOY5vGFw4ZAc8NuL/0U8gZffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731176857; c=relaxed/simple;
	bh=X8hWyY5w85KZT8T9ahNLCTojiS3+9mmDhBLZt1ERgxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAGgSlzu0KCxpUVJtDTBxH7XHIV6JdE1DcXtpsrFb+67DTV1osbXJ27pXtoy8rcpYS93NBceW53iyz23TeL9GtQZuRUyj9q/tifHaXS8E1q+KF1MMgsxQhXLcTZmrMvh54BVX15iVoPvZpymKU2Ij4jri73ELm9wmi5fTxJyhr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=0+nvDSCD; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nXT6QzvZKFkWm+65cSnJhI8KPPDBdvN3VCzrV8WIxWU=; b=0+nvDSCDc8B2s1LDXV9u6vPQbz
	8EMEWJHF31eVfqezZCq0NzfQkzZHnbNYl4m5jpXYFIVnZq3dsnmBgwoHJU3Is4BIPBc42EsIfTD1I
	KemBi5W1aa2LOD3M9qiv449hN1LCj8ra0D/IfNkFvA6i6Erljk9IZLbseKTyWLA4gpMnJ2nNjrsA/
	kZx7fOPhPCP8dljOVs4s3fV0jZ0uQFu146aVShwAr2tGwrLBgeiRkxRCumr8wycwRmHbEktXqa7zA
	ysI9RpzoFHiqSTgEbyPJ97VxKx9xe7bdnjpMDa7RzoP7w6XKJPsFwnCjJzEMfSz2hsg+8r6VyHAoF
	YAEnuSPA==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9qBG-0007Km-Lv; Sat, 09 Nov 2024 19:27:30 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Yashin <dmt.yashin@gmail.com>,
	Rob Herring <robh@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: rockchip: add Banana Pi P2 Pro board
Date: Sat,  9 Nov 2024 19:27:10 +0100
Message-ID: <173117675957.1131306.53694028790039821.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030202144.629956-1-dmt.yashin@gmail.com>
References: <20241030202144.629956-1-dmt.yashin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 31 Oct 2024 01:21:42 +0500, Dmitry Yashin wrote:
> This series add support for Banana Pi P2 Pro based on Rockchip RK3308
> (RK3308B-S variant) made by Shenzhen SINOVOIP.
> 
> v1 Link: https://lore.kernel.org/all/20241028213314.476776-1-dmt.yashin@gmail.com/
> 
> Changes in v2:
> - Drop ASoC dt-bindings patch (applied)
> - Fix excessive board naming by matching to other Banana Pi boards (Heiko)
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: add Banana Pi P2 Pro board
      commit: 8068f5939569127ee3fb73a677cc2fe73103697e
[2/2] arm64: dts: rockchip: add Banana Pi P2 Pro board
      commit: cdf360b13afc9212a83e76d0f3897d0388a82621

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

