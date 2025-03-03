Return-Path: <linux-kernel+bounces-542785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D8FA4CDA9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6102A3A9AC4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C441EFFA2;
	Mon,  3 Mar 2025 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="KMTGTLTs"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC0D1C54AA;
	Mon,  3 Mar 2025 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741038497; cv=none; b=r0fJQRYkx2fbupwcJcc4tMcTCb2eS32Vuzjo79N+bBdr9OV23ROejQyaa2DlxHWbv6qyB4ePnRSH2ehhk7doYuYG4l9glMvEvd6GHs3D/HYuRGoHIiQCFhu2jpz/edD5cqM+30SHi2Yeo/ZeR9TbamD0zDttWqE/GgdCk/2cxFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741038497; c=relaxed/simple;
	bh=p+tn/31l6e3gJKu8df9MrkepDamPBNGOPVuQC0MkQ0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSFdT1n118pejSYNHpuDq8eIAbcdHaiGSu7PDsmcuyfgnJDvFk6ogp++8Lg5dqGFT49sHN5vny/qS7RtC0jwAzow15NE+6UoaD4lxbqNibubEASdcGa4v152DWeg9nbUlvTX40L/6LnISCWKv8gW2YOLGKq6Xzy4MNgQJqufqoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=KMTGTLTs; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oZS9W6LWueZRel5mHElMEY/qHM3otop7VBPbgcAUBlI=; b=KMTGTLTs3m3xBOfDSyeVo65kNA
	MklFXt7AU/oF3hgMY6RFmAOYW2t1GIy9Ofz7UVoHICWq4Yeiq4FK/shpr8o7RN0rWk7SKrAyRAWco
	hGzvO/A6wC4QkmCHbR4SIEaB4bn1f2VxirBb3Uf+g9yiTQfUJjR0c1oZa5pzVY3F3JabsN+v/fsHk
	7B+pwn0gUgEZpjMUF9fWXUY5deuoJDOq/Wv/eaDs5bDNdeou33NQSYnL8IFQEW7NJtFnLkqzoenKt
	syTwCcY4WwL+RfwU4fIL5bAuqGZ3Jw3euggXx9Uyfr8NGHg3GreoV+WW3Q6XhhQpOiFcgi83bhyO1
	79V4oveg==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpDdl-0005hg-LD; Mon, 03 Mar 2025 22:47:57 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	hjc@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v16 0/7] VOP Support for rk3576
Date: Mon,  3 Mar 2025 22:47:47 +0100
Message-ID: <174103845739.1823374.12191535922821188431.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250303034436.192400-1-andyshrk@163.com>
References: <20250303034436.192400-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 03 Mar 2025 11:44:14 +0800, Andy Yan wrote:
> Here is the v16
> Patches that have already been merged in drm-misc-next are dropped.
> 
> I test it with a 1080P/4K HDMI output with modetest and weston
> output.
> 
> If there are some one want to have a try, I have a tree based on
> Linux 6.14-rc1 here[0]
> 
> [...]

Applied, thanks!

[1/7] drm/rockchip: vop2: Register the primary plane and overlay plane separately
      commit: 6fd4f8a26a21dd2075cfcc7eae3b9d440d886571
[2/7] drm/rockchip: vop2: Set plane possible crtcs by possible vp mask
      commit: b90fa71a11600276c993e620abea8ca9f2045401
[3/7] drm/rockchip: vop2: Add uv swap for cluster window
      commit: e7aae9f6d762139f8d2b86db03793ae0ab3dd802
[4/7] dt-bindings: display: vop2: describe constraint SoC by SoC
      commit: 1803bfb59656d41c4f9f7e5f23188248b649e1a4
[5/7] dt-bindings: display: vop2: Add missing rockchip,grf property for rk3566/8
      commit: 47d31e6598e4fda1433e747ef031cb972c57c5ae
[6/7] dt-bindings: display: vop2: Add rk3576 support
      commit: c3b7c5a4d7c17afb158ba5a41222e95a32886ada
[7/7] drm/rockchip: vop2: Add support for rk3576
      commit: 944757a4cba62b1b50fb51933d0608117599db71

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

