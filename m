Return-Path: <linux-kernel+bounces-376376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A68A9AB08F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECF8284347
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3071A1A0715;
	Tue, 22 Oct 2024 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="JXJdiNI2"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3BF1A254E;
	Tue, 22 Oct 2024 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606369; cv=none; b=jtHpj19xaZ6WYOIKa0xwVvLYAT5vSgv2P1hbi49hGvaNj+Byq6mA5jt+vxiiwL4jIahTYymFt2Vc7NiWan07d4oPKtnpq7GVhu+i6cqlnIPaQbVxjHTm6UHi7DV9g7RRtfGbOGDwk+i4twmmlcdoco7VCpbMLpraJeOgZQwGzbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606369; c=relaxed/simple;
	bh=ukwBhYBAAKhIR6/yPX8LrgNrHHvJO02TkgEHoIYKB6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jeyHDaySZ6EeCm51Uo6msg1DINqAL63VoynXVWHWZl70WlfaNfx90O5WGMJ8qA++3kqiGVYxfY21iGSoQu/O2IGxLxHceSQN1gGZvurXuNc1CGWxKKKntMF0Aiq4KOd9fM3Ym2bjO3N3HLQJnzNqf44pvEZKI7rDDt5z6Inzn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=JXJdiNI2; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d/zGrPtBECfUn9Wxr74oIUe8eBmH+ZAAzMoPX4DpgiU=; b=JXJdiNI2wuQdoiGf5sMJ16a76m
	2nZj0BQ81sYF0+L4PPq8a7qW/Oyh4YKWJrj4WDNv6wDHba6XvCREFyBraJzPB5ONupiNpK3y1MXyi
	faxyhbqsdnLFel4szgxVQu0V/p7yYPwE+9mZInnFw09R5n3IsF8vXSzT7K4cfona7Oj0QCdaxy33O
	d3HKvsOkGS4McdZvYiPqphPdLssCCvLoaWcs+IA2YVhQGlU930hkTNR1Fh+xUTGJmqO0CVX6GK108
	l29UkInWIeC/gNmrGRwod+ef/d2hYWJbtJ1vMfmpbs44rbj1NTvUz/76Oi8HLx6Q339pEX41cMkbX
	baNcbsFg==;
Received: from [213.70.40.217] (helo=phil.sntech)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t3Fck-0005eb-L4; Tue, 22 Oct 2024 16:12:38 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Jagan Teki <jagan@edgeble.ai>,
	Rob Herring <robh@kernel.org>,
	Andy Yan <andyshrk@163.com>,
	Tianling Shen <cnsztl@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Add FriendlyARM NanoPi R3S
Date: Tue, 22 Oct 2024 16:12:25 +0200
Message-ID: <172960632903.1476617.9941592027677995572.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241020173946.225960-1-cnsztl@gmail.com>
References: <20241020173946.225960-1-cnsztl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 21 Oct 2024 01:39:45 +0800, Tianling Shen wrote:
> Add devicetree binding for FriendlyARM NanoPi R3S.
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add FriendlyARM NanoPi R3S
      commit: 1e94bfea52bee081c42ab922c19156dd3d2bade8
[2/2] arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board
      commit: 50decd493c8394c52d04561fe4ede34df27a46ba

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

