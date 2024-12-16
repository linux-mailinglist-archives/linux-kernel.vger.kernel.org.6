Return-Path: <linux-kernel+bounces-446968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863E49F2B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE355188A7BF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AC71FF615;
	Mon, 16 Dec 2024 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="OfUN9qq8"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A70171BB
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336420; cv=none; b=R1t+98yDPIXtdFxEuhtwSLDbfTjBnY98EFwNoYbMGbUUcxP4OVC7sTSR6ew+UWdHT9H9BCXyY7UpoU7a1oFIUC5m+1A1BqCV0/bYb90lyen6LmHJH2pAXqo7STaUpg8a8Jzpg/1K1ZG3Bcipe33fnUqupBFIUMzju6qv12IVNUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336420; c=relaxed/simple;
	bh=1OaS7UcTEA33TtpVR8+/noQ7tU4MtIpesSF97Z2/8tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHrDj4iJ6FlxPjBesn+8OEI7GfmysaZR5CmN27SVEL0p5/Iefscxudq75ZgqnieZiuwHRXBGBglpHd2Qv9TV4Q3jTuSt9WMp9/jGeWlntT4S/DlzMYqyHkP27VwkY9Dhxsy4b9VqcxK9PU2We/1DPmf0AStIyB5WNGBIwY75i8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=OfUN9qq8; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ykA8HuFeO2n9T33KOENfQTgct9xH6AMqa65lfTAavAs=; b=OfUN9qq8QBMIKqzkSTNA6oo+1w
	nyIpksqusAh8oyE7v1ko9vZ54cD4+HGcKA8JGaESkRP8ra9XuRRQW+H1sFc+Hp3EH7vJJnPrrF8L0
	1KO872C3v0n5Tcb7NFZSLH72RlzlU9ncumD+pKzRPIH16b2eK0JnOg1Qq+MVrTYfOjIpxr5NRiF6M
	ERCqI6ro/T9y/+RltH5UURIuw++KlPvzuHv8PxK/xt1FaoRC61Ljc8M197JbMhwwG2z54rp5eTeWC
	aW/npIjztmeG0Ppmo+Evw9djr8vzmIJWhxNE4S/cv9K9dThR2myxXBuepZirty5G+9k4r1xqJripN
	N1PE6M/Q==;
Received: from i5e86190a.versanet.de ([94.134.25.10] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tN67y-0002wV-1N; Mon, 16 Dec 2024 09:06:54 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: kishon@kernel.org, linux-phy@lists.infradead.org, vkoul@kernel.org,
 Andy Yan <andyshrk@163.com>
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 kever.yang@rock-chips.com, sebastian.reichel@collabora.com,
 Andy Yan <andy.yan@rock-chips.com>
Subject:
 Re: [PATCH] phy: rockchip: phy-rockchip-typec: Fix Copyright description
Date: Mon, 16 Dec 2024 09:06:53 +0100
Message-ID: <1813498.VLH7GnMWUR@diego>
In-Reply-To: <20241215092441.3447155-1-andyshrk@163.com>
References: <20241215092441.3447155-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Sonntag, 15. Dezember 2024, 10:24:40 CET schrieb Andy Yan:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> The company name has update to Rockchip Electronics Co., Ltd.
> since 2021.
> And change Co.Ltd to Co., Ltd. to fix mail server warning:
> DBL_SPAM(6.50)[co.ltd:url];
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>



