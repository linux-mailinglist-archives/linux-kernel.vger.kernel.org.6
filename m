Return-Path: <linux-kernel+bounces-539525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23C6A4A583
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C526B3B38F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1E21DE4EA;
	Fri, 28 Feb 2025 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="OppOjBCY"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB26E1DE3A3;
	Fri, 28 Feb 2025 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780109; cv=none; b=IzrMrIny3vFSp5bQO8QiGmGzU2skplpM9wmg72GXr+qjLHoNKvZ1aGoJYsBJGCU93jChPyJNab6uX2XlztiD6EW7BCxCdBL9A7Obd88uz+nkVa/ZbfbkffqMw0UGn50h+QsGHR3paadgsQT1csXSTIodn5byPWmLcabwMtAqtvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780109; c=relaxed/simple;
	bh=hMLqk512AwPiYZK3MG93mT9n6hPJsJtr57KncyYLlL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJ55E30BspyvFzx5tNA5geTZT+ZItgVj1+pV6yjnZY9mF96NfnW2Q2KsLXuxC0tH/hmLo4pOkxBrqGFI9WfWWD1M4Kluuamk2uZdIMRoI0FVKpZ7JO8bRxCSebJTy/n8xRALF5TAr4crzG0dDmIZntR1eweVLP4xeG+MhQI5JcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=OppOjBCY; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kP66OtCoIAUGOwrPrVYAUZoLwNYK7xEkiY4rtScu8+0=; b=OppOjBCY5py8iBMgECLQ+fLWj9
	W3CxMi4DVZlXB7ryZCKQEpyalTPDuw1mGTdnIKbpGDR7l8/yCnUfr8cO8XT1kt3+o7rLBK/MVvi0v
	DZY2w0imaGVyMPCQq+SLudvjdmo/+RVmL0BnpuYWcbn/Kpwx2EuG8LY8cS1ZO5Iy9GZ54YzrYk2JE
	T3d21GMZ4LsX0ithJtJvYtRpSocbIX4D/6q7zKpvZcwbL6C6eBnH3a2/UAywGI4+ohD1KS0a8AAz0
	94W2ZVnUHIMhq1g+KksKmOL1TxexyHsYD4jVbVm4DRHJ3uJATbFbvencphBWuZUtT4vega7CWupkC
	kvOwWFvg==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1to8QO-0003wY-T5; Fri, 28 Feb 2025 23:01:40 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/2] rockchip: Add rk3562 clock support
Date: Fri, 28 Feb 2025 23:01:28 +0100
Message-ID: <174078008226.501190.7368829300747006853.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227105916.2340856-1-kever.yang@rock-chips.com>
References: <20250227105916.2340856-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 27 Feb 2025 18:59:13 +0800, Kever Yang wrote:
> This patch set add cru driver for a new SoC rk3562, the SoC DT will be sent as
> a separate patch set and the new compatible will be used in the DT.
> 
> Changes in v3:
> - remove rk3562_cru_base and MODULE_ALIAS
> 
> Changes in v2:
> - remove rockchip,grf info
> - Update file license
> - Update the reset ID with rst-rk3562.c
> - remove CLK_NR_CLKS
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: clock: Add RK3562 cru
      commit: dd113c4fefc8df6ebf6486cb1dce1707d5d677b4
[2/2] clk: rockchip: Add clock controller for the RK3562
      commit: 36c7fdc8f585acbf11c8e5bc112fa9d8ef75146a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

