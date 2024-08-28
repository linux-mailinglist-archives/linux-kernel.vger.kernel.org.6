Return-Path: <linux-kernel+bounces-305249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6E0962BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D110A1C234B8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6C61A76A3;
	Wed, 28 Aug 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="PvkpVozl"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106001A7052;
	Wed, 28 Aug 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858065; cv=none; b=P6NQlSgvrTNpoDioegcyuk9dTlrRdBuAGur/G55dW3qiyqIaW8GlQV2A4xPSrLcj2W1gyhnLnxp/1Ywqmz27zAFns8X1pllpuLSrcxN9/cU8Ku4WluQA3+8VEegz3pZEr6/AhgFxjGhVD4ApSD20oNmdVF9Ryfj/pDwycalcdBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858065; c=relaxed/simple;
	bh=ojl5P9pD81OHEHRG5/dz28JfvnQisQW7vvGaIczgoW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAQBC6nv10oR78Q5vhkMZLQqzSlh4G6Pko6gkRtnC/NKFxMBhz7/8f2PlCEh6m+PgolFKCY0yDU+FPOi8iDiTh7wg2Z+mFYUnR6xs6q+Z9AVIIgMqtUkSu45UWQXzNsXp3b6oJdv2nbWX7OFveW0TD/qNP6RTcZKcCbadJA+zT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=PvkpVozl; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fmPhsEB6ZpuNYb7DYotRMghZKcme6b8yJFJs6bD4xMA=; b=PvkpVozlfJxWCFiUvr3fCFIDqn
	yl5GRP0kxn+TX4rBKF+ofKGaaWqZMiZ7EMkS51dWdQZ9Qku81c8ymhPUp6vSvQ4SaOPJ4S6FNCfY6
	5iBRjVCV2DHEDymXt7/is1/lXHx0jOvisMsOjciKR3HGGvbECe/2Irhl5A9jGSaNEmPGNxYXUtEoS
	VCuB5hw0N0UfNdH9A61bkX5FaCuOROnk5J7f/WSFm0uKHW4faBkvLGSgO0906B5mdnhUFzW+7fy4m
	aypaWQ4oJSMFlw1qBg+LUQW1CZ0WrKsmC2M7USyTcj/LIxO813NSmlcV6T2bPTe4W1SkqVYxJ1Zee
	QfOxrLCA==;
Received: from i5e8616cd.versanet.de ([94.134.22.205] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjKNG-00065f-EY; Wed, 28 Aug 2024 17:14:18 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Junhao Xie <bigfoot@classfun.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rockchip@lists.infradead.org
Subject: Re: [v2,3/3] arm64: dts: rockchip: add dts for LCKFB Taishan Pi RK3566
Date: Wed, 28 Aug 2024 17:14:11 +0200
Message-ID: <172485421376.1511809.16668781813371034474.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826110300.735350-1-bigfoot@classfun.cn>
References: <20240826110300.735350-1-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 26 Aug 2024 19:02:26 +0800, Junhao Xie wrote:
> Add dts for LCKFB Taishan Pi.
> Working IO:
> * UART
> * RGB LED
> * AP6212 WiFi
> * AP6212 Bluetooth
> * SD Card
> * eMMC
> * HDMI
> * USB Type-C
> * USB Type-A
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: add dts for LCKFB Taishan Pi RK3566
      commit: 251e5ade9ba43f44f60713310f89e0f4495a2088


It is customary to re-send the whole series when doing a v2.
Replacing only single patches confuses both people and tooling.

But no worries for this time, I found and picked the correct version
I hope ;-) .

I did sort some more properties and nodes [0], so maybe take a look to
make sure I did not break anything.


[0] There are sorting guidelines in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

