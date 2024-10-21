Return-Path: <linux-kernel+bounces-374688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056429A6E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1542824BE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF0F1C6880;
	Mon, 21 Oct 2024 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="J45pCSWo"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA291C4603;
	Mon, 21 Oct 2024 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525496; cv=none; b=F04XRAqfZdA9ykKbOMPR5OkITDVCB4K+EuTl2QE60e/Yg7mNN95mLE7uYzuWy6hhvqg/boqQ+cRCWMn0Ad8RiFG0lQRTm6n53ZqXLRehNBl23r72ks/4EtezQMjtlpFTeU5AOtP4Up7ZoQRP7scOsjVdAzMTyAAgQ88bp4k7cD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525496; c=relaxed/simple;
	bh=KtfmJPWnrcbXSiJE0Kaw1+diIhh4RBqz9OKHdfGI5R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJRxaNgmOhdZ3bxrBVMiX+MvbE/ZYb3W8/wEsbwPaeC1Zq3bEX894qAPsJlLe1Skt48blMfhhbsbQ9aOGbPsBBDK8Y866wMmhKDLA/PTFcxXoDRpiGnyaZK6ZwqtXXCMT0awRidWtj0nxuiAaGGI6r2K8qFsIhGVH9UTX+eX2pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=J45pCSWo; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xDCNswJHdW1wcr7CUV4vOH+mR7TSmuOCdCXWRnBHbDc=; b=J45pCSWoGzrGV2fskzmr6i2tWI
	f48wcvIrVhi55k4hst9H8RBHd9xMHoZgZcqJLHwmeqJmsOtO5tNGkIqne2SYK8ugbuq18rixOAfxM
	650QBw3xlDrfhGCgIBCiIVwVgqHfVe7gIk5H04IrDXdLfPTf1bwZHhdVmE2FyYuyC4oj7D+xU1WTR
	rAqr9iyQi3A8f0vKK+v3zGpp8n6eBbdxjWBLBP2m0+mxGFgfCpOg8TMyMmxHdlhDMPXr85bh3nF1h
	lARDT2ovIOPdm774vZBzLLzNnyhrW4lhm9/Tp6ilkH8nvZnr+Wc8tsA2mr6+PgNOzWJaUARtsQnO/
	psPXw2jQ==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t2uaJ-0005jR-4m; Mon, 21 Oct 2024 17:44:43 +0200
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
	tim.chen@rock-chips.com
Subject: Re: (subset) [PATCH v6 1/4] phy: rockchip: inno-usb2: convert clock management to bulk
Date: Mon, 21 Oct 2024 17:44:36 +0200
Message-ID: <172952545664.1342338.17900988548616491240.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241016073713.14133-1-frawang.cn@gmail.com>
References: <20241016073713.14133-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 16 Oct 2024 15:37:10 +0800, Frank Wang wrote:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> Since some Rockchip SoCs (e.g RK3576) have more than one clock,
> this converts the clock management from single to bulk method to
> make the driver more flexible.
> 
> 
> [...]

Applied, thanks!

[2/4] dt-bindings: soc: rockchip: add rk3576 usb2phy syscon
      commit: 3b8a7753131a9db25e81dd3f5c0ecae96400f334

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

