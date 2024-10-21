Return-Path: <linux-kernel+bounces-374686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6169A6E89
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6C41F22F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8F01C5794;
	Mon, 21 Oct 2024 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rj0MLLsG"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06351C3F38;
	Mon, 21 Oct 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525496; cv=none; b=Doqb7ceeG+GzCSJctjJJ2fmNctBt0X1qAP2iUUG/VScMAtzJFlXUvOsWduRhp6ytBqGCXU9YuyypFgIdLmqeXfrf9co/OBhZ97xrSXO098vFyzCw30f/TEj6q/Jz/gJEPIWsywLj5PSB1VyjxZmketlsCygXIb/68vVKH8qAYWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525496; c=relaxed/simple;
	bh=3MX6htkIo2JF4+n+qZCA1R5yhgTPPDLUwDUx4yTJ4F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlfTobaztYDCS+kQZfDcRdeWJHS0oo5skOhc4tkcUmJbUsNU51Vxhk+4GiuRqtySSx1uT2Ek+YGMcYixkN1BlCkO43sGYbLjYXmI6EXczjVylfYL0FvkX/iTF/kLaqKv+nNvtLy9RM2x8Bt2uMswocRd0mB7n+D/zn1vq1wycd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rj0MLLsG; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c0W2ng9Yj925A0G4lxtdQaaSAaFVmMai1E17frApkOI=; b=rj0MLLsGhI1GQyyd87PpczRJS2
	pU+dyi0xR+SNT3ibRIItrvJ51t8km+LX0LE5sqxWBDV5lPNTXzkCzoqMIFsGlSiB6obq4HGb68XeZ
	dXT4HHYO60kwIFZX5/9KhaEvmQDLFc7hTq//xQJ0UmrMO0RQ7gT/fhskRUEPxdeHrjo/3WdiLCv+C
	SL9oODhT5wvIXG06x61D50kDiIkM/x4KhuYtda/ZXamoJqsgwCx2fWy1nb9jm5rAaSvImL/LjvQbT
	ZdgG1DqRp6oewJjQvTJGSoxV3jjneyoQ3tF3C+8hy85VjOb5dLg67IhnIZ1usp6muMOC9jStGMiMQ
	xlYHyVnQ==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t2uaI-0005jR-HL; Mon, 21 Oct 2024 17:44:42 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org,
	Frank Wang <frawang.cn@gmail.com>,
	kishon@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-phy@lists.infradead.org,
	Frank Wang <frank.wang@rock-chips.com>,
	linux-rockchip@lists.infradead.org,
	william.wu@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tim.chen@rock-chips.com,
	yubing.zhang@rock-chips.com
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: soc: rockchip: add rk3576 vo1-grf syscon
Date: Mon, 21 Oct 2024 17:44:35 +0200
Message-ID: <172952545664.1342338.6248295314780049545.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241017025230.28752-1-frawang.cn@gmail.com>
References: <20241017025230.28752-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 17 Oct 2024 10:52:28 +0800, Frank Wang wrote:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> Add rockchip,rk3576-vo1-grf syscon compatible, the vo1-grf is
> configured in usbdp phy driver.
> 
> 

Applied, thanks!

[1/3] dt-bindings: soc: rockchip: add rk3576 vo1-grf syscon
      commit: ab79914808df7163564bffbc9f79801898fa906d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

