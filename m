Return-Path: <linux-kernel+bounces-552657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A65A57C63
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 563F77A73A7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5041F7904;
	Sat,  8 Mar 2025 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="QN8MP1kH"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4E1EFFBC;
	Sat,  8 Mar 2025 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741455143; cv=none; b=cAlG+pS938gIyjIPjfGHXabMWudbfFdJ5XAODmcxbxldGhWh03YYI/oGW2iEm3twV8eksZ3JT69Xw272A0nE6WO8hscFLdYpw8Dqao5bUbioQkGOwmsvcY+bq6C4oRv40QTHNHlO6eA6v0vcGMvXp++LRdy5zfgPFo+P+GyMb0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741455143; c=relaxed/simple;
	bh=XeepW5paS/y1O2oU4gBJy5VEOdGDyTDTikjE3LWa918=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJCyoovk189/NJU3e1BTJC0G9wLAmNw47y6h7eke9PzsSE6/2A674D/geIneAdkwdYc1AqimqWMlAL1CNA0dw1EOUgKR5KvNwGMB7lLIYtf1LskKjTpvzBlrs5ZYnVMVy+sX5nK9e7hfgApEyKQH9dJIHZ4CqjM+QIXu3DXw7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=QN8MP1kH; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6KlOvnCgjUvf/hwOUGs49yrmKu6ncKhQnFDuHDtvwgQ=; b=QN8MP1kHxb0Np/W35RnQkOpic1
	WVCeb8wSEbrJ0Ca+YXMn8Jl5YmZZFMuP5euqnrCCvVUEVtgQ3UVRYW+0WbrIiJ3aFJMN9kscEduy/
	J9vLK02wJpOVs0Q008QPK15oYbhZv6SF5PnsMZ3OenbjMYdB9sb0tE3HELerPy/Y2y6pYMJu6DHRZ
	xb6oPg8CB+79apEeHdJIWbCiC/dbNZtn7tTKS7lWQALEv5/I8vdz3Hr8ADkmunoyO89tA1xcwIxCS
	oZ2odHXe0exZhHIQJyys5VKdlfkYV31hemzIkOFTb4ebpLjI6BrZicpot/rOwq/QXC0p+eR7CBHZP
	Ymzq2iGg==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tqy1z-0004Tx-4E; Sat, 08 Mar 2025 18:32:11 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexey Charkov <alchark@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Stephen Chen <stephen@radxa.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: Re: [PATCH 0/2] Add SPI support for Radxa ROCK 4D
Date: Sat,  8 Mar 2025 18:32:02 +0100
Message-ID: <174145503578.101861.6708020460490531029.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250228145304.581349-1-detlev.casanova@collabora.com>
References: <20250228145304.581349-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 28 Feb 2025 09:50:46 -0500, Detlev Casanova wrote:
> The board comes with a SPI NOR chip connected on the FSPI0 interface.
> 
> Add the SFC nodes for the rk3576 SoC and enable sfc0 for the Radxa ROCK
> 4D.
> 
> Detlev Casanova (2):
>   arm64: dts: rockchip: Add SFC nodes for rk3576
>   arm64: dts: rockchip: Add SPI NOR device on the ROCK 4D
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: Add SFC nodes for rk3576
      commit: 36299757129c897ef8c7ace6981070d367d89f89
[2/2] arm64: dts: rockchip: Add SPI NOR device on the ROCK 4D
      commit: ba82f56bbf20e4166c988621cd0507509872848e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

