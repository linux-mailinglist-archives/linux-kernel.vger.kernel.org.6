Return-Path: <linux-kernel+bounces-254046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA83F932C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6992EB20D74
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B4A19E7E5;
	Tue, 16 Jul 2024 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qXYpRqfZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E67617A93F;
	Tue, 16 Jul 2024 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145069; cv=none; b=VxyDKXr9ahZ+50DRjcQM51Tx3OTmCAmYrAo5Ngx3/fmHzmB5Me1YMGAThq/1P6npIa+O4p5Gmpt7zVlUHnc8VDp7qS9vukt5HOjW6h0UcTwMaYd62BB65ze1VpBVn8woI5mfeAlk3y2r8csLcuKYA1ZIluFEC4ixwXekrFRcntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145069; c=relaxed/simple;
	bh=0IoHM52eYXC69oR92ftsA6l6BJnmsUgO4mcEkrsQtwM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s4qhnGfgu3Jo8tO02K/b2DzuB6PMh+W7VuGm4z6XDoW2uGCA6eOzepwcQChTCaPFuMvCy9+mSF1JfNGOuTVDHPNSHD/ZtpCsMePk2B5V5YOgMVPbR5o3ZaxNZVHewXYMq5tEfCz4by/MeG8iIBGFWbPDla8efNFexZ7NHL3xkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qXYpRqfZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721145065;
	bh=0IoHM52eYXC69oR92ftsA6l6BJnmsUgO4mcEkrsQtwM=;
	h=From:Subject:Date:To:Cc:From;
	b=qXYpRqfZLzi9kDNUXdszd457BmV3pjld3SAQpXV7Hw3ar23Pf6wiNuuCv9Z7V6jBt
	 JTqzkc/nHJpQRSrwXDMbu7oZdSg6cCJQsjp+7Ed3YfxHH2aO5I8VdUiJgYT/YJQiMq
	 E+oTGqPFy//ouqptqY3kcZHu2zR6QDL1hI/Xj4nV6qCLonShKZcOYvDzPI09Vd1Q/i
	 9ey0Lmcq3utl7YwEWjv2ylLCM14tgvUjEM267Do5zfx7jO/O3lEW+pYWcfZk+JaNZi
	 esAo54gpWF6nfR6auBY8RWMssDPVk+TGt9QmgavzJoXSsbY3cAkOCdygpZzH00EhQl
	 fO9xSrcMOq6IQ==
Received: from [127.0.1.1] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E35F037821CA;
	Tue, 16 Jul 2024 15:51:04 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH 0/2] Add support for Firefly CORE PX30 JD4
Date: Tue, 16 Jul 2024 16:51:03 +0100
Message-Id: <20240716-rockchip-px30-firefly-v1-0-60cdad3023a3@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOeWlmYC/x2MWwqAIBAAryL73YLau6tEH2FrLYWJQhTS3ZM+Z
 2AmQaTAFGEQCQJdHPl0GVQhwGyzWwl5yQxa6kq2qsFwmt1s7NHfpUTLgezxYN2TNX25NG1XQW5
 91nz/33F63w+rZLD0ZwAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Christopher Obbard <chris.obbard@collabora.com>
X-Mailer: b4 0.13.0

The Firefly CORE PX30 JD4 board is a SOM and motherboard bundle from
Firefly containing the Rockchip PX30 SOC. This series adds support for it.
    

---
Christopher Obbard (2):
      dt-bindings: arm: rockchip: add Firefly CORE PX30 JD4
      arm64: dts: rockchip: add Firefly CORE PX30 JD4

 .../devicetree/bindings/arm/rockchip.yaml          |   5 +
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 .../dts/rockchip/px30-firefly-core-px30-jd4.dts    | 562 +++++++++++++++++++++
 3 files changed, 568 insertions(+)
---
base-commit: d67978318827d06f1c0fa4c31343a279e9df6fde
change-id: 20240716-rockchip-px30-firefly-59efc93d6784

Best regards,
-- 
Christopher Obbard <chris.obbard@collabora.com>


