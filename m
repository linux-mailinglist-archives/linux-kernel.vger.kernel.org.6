Return-Path: <linux-kernel+bounces-557338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EEBA5D788
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FAE2189E82E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A709D22B585;
	Wed, 12 Mar 2025 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="KWcpXCKn"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A9F22A7E6;
	Wed, 12 Mar 2025 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765586; cv=none; b=B2Cu3jeflG+fHqk/snCrzVgOFGhf39rseE3wlMnc/n+YAmQObkzPsSh+8Dj/om1oail6L1hiUIp3n+cHObR5CoicqJYocoQrnw+XQJMTtE6wzazS2Nd0BouYuGq4I41pC7xbJCorGx1IWO8Z/nj+E/KYcCyLpLzQ8woJp0hWgBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765586; c=relaxed/simple;
	bh=Y/7M0n/AZh9D2qiF7it1jTNxragdg4TofvvC0tU7jCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+sDK37lmfbfIUuOFlJHdOVkvRCAu3g/y1yyG1PYThhIa8WVB4H0p67c5X3GAy7ZoCPVSkft0Cg/F9fj/IInOW4VjmZHO7kPaXIWGbAUN/qbmsqZo5jpc+c3Hj1/Ii/C6rNRJg+v4D1qBO7310n+XZbQH8G08rQz0YI8WX+2jNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=KWcpXCKn; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=H3G+SIxKPBbyfBHRdfeHBZIIG3bjmVBlSkXauQhl1CU=; b=KWcpXCKn/kiJdVrdsT8Ce8qO8r
	TkotSHwgoDh5X6j/lkqW5gztcLvgf42GMn5/ugHqLuntJkHECxA4qFsnhztFVkRNlK0nP0LaNc6kT
	dS+NnwEjARovvQpBlzoD3OpfDNNnXvPibKDBMXF6+b6Rjwy5AgCFKfx2WH0ywLWSXNsct89J1DeWK
	jpPDD1roPEGtFIvdA8nGMYXhsW7QOJOtkCcudRqzh2KCZw+Ys+KOGRWaLBbopbBNU6xeXGXP0Z/2s
	6U0ICCfj7F7SSmJH2kB6BYNtrMpk3XOBXR3IXVvHfKFdU6wXwpzbxzb3zohhGAKVeKe25OVHgvJdX
	OjuU3cjg==;
Received: from ip-185-104-138-79.ptr.icomera.net ([185.104.138.79] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tsGn6-0005zY-8M; Wed, 12 Mar 2025 08:46:12 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Rob Herring <robh@kernel.org>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: rk356x: Move SHMEM memory to reserved memory
Date: Wed, 12 Mar 2025 08:45:57 +0100
Message-ID: <174176555638.249409.3786119315566916178.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250308100001.572657-2-amadeus@jmu.edu.cn>
References: <20250308100001.572657-1-amadeus@jmu.edu.cn> <20250308100001.572657-2-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 08 Mar 2025 18:00:01 +0800, Chukun Pan wrote:
> 0x0 to 0xf0000000 are SDRAM memory areas where 0x10f000 is located.
> So move the SHMEM memory of arm_scmi to the reserved memory node.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: rk356x: Move SHMEM memory to reserved memory
      commit: 19f48b687566b0f52c9ca833fa1f0c27ce44e1ba

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

