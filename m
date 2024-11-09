Return-Path: <linux-kernel+bounces-403025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 758D29C2FBF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 23:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B498281E94
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 22:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783C51A0BF2;
	Sat,  9 Nov 2024 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="b7TmA8P+"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E0B19F47E
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 22:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731190403; cv=none; b=pA6+Nl7Oaf6F1f5TDhxhVIXKbJ0LoV2UwWxjcESsZJuvZF77SPRPo4f7j3h8ztCqyRmUiAFnoA4qJ5+qXhxNihEusXnW9ke2i/eScLlyI/zA/bKN3FgzDwB1o5KPHFwrizFdgkgSSXvncRNRFaN6VW81Efl28DwBqHy8Hd0iS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731190403; c=relaxed/simple;
	bh=gtlhRbp5BLQkGZJwbdIAtwAwrxQXi+gu6HtQ5GXK5+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLwx9YEcX3d2ZRlIW2WwGpvQ0QQ4OVwIQjdBrS/0ouTe7w+zmduGHNVwiHTiCuVjJ9YwVb/ADOZtET99CGtusbUv3+Nnmcl8Gt4C6rCnKa/77jRvU+/JMVoeaaiJdIW0y8T3MOVJDKGskcEK15xspqOLXNmj2gNUnW6Idf7pZP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=b7TmA8P+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YAHRAxJSwzztjtgUr/pm/xjqAckdpHljo3U56gQulB4=; b=b7TmA8P+zt9VVlbT2CbrQ4yO/i
	iyWxPoOmYtOwbclzs8HBS5o68gZ8o4VPcQpd1EY3ctT/uXvME2u/hwlPfliGg/etMRE9167Y76CNB
	1JBKRxzjnsSVYSkbfYu1V8+haNISofv4oaacnXdMgnUu90rHTPVR3r+1eNIauR7UF7vtl8hyphT3P
	4BUH5/mJ/1pp0STTyUbctw8EnOW6jfd1/ixLgOUElr97+XLfBHOaNA6hOsRSLvYUjbzQ4qVWvFjZN
	5YkTeZVrINI5F0MrtgWyAFqbHnhXlkPBLS9HUwdDf64yTL/P3TffVrRg9Kj+Gq4sW9ISHAek1eR1X
	9AnBu1Mg==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9thh-0000Br-5E; Sat, 09 Nov 2024 23:13:13 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Algea Cao <algea.cao@rock-chips.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject:
 Re: [PATCH] phy: rockchip: samsung-hdptx: Set drvdata before enabling runtime
 PM
Date: Sat, 09 Nov 2024 23:13:12 +0100
Message-ID: <1876958.atdPhlSkOF@diego>
In-Reply-To: <20241023-phy-sam-hdptx-rpm-fix-v1-1-87f4c994e346@collabora.com>
References: <20241023-phy-sam-hdptx-rpm-fix-v1-1-87f4c994e346@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 23. Oktober 2024, 19:29:54 CET schrieb Cristian Ciocaltea:
> In some cases, rk_hdptx_phy_runtime_resume() may be invoked before
> platform_set_drvdata() is executed in ->probe(), leading to a NULL
> pointer dereference when using the return of dev_get_drvdata().
> 
> Ensure platform_set_drvdata() is called before devm_pm_runtime_enable().
> 
> Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Fixes: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



