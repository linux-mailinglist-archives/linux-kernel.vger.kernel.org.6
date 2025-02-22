Return-Path: <linux-kernel+bounces-527515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC630A40C36
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2EFF7019D8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 23:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18439204C3D;
	Sat, 22 Feb 2025 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="s5Hgk1Za"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE07204594;
	Sat, 22 Feb 2025 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740268127; cv=none; b=CW47QN2lhdZqd90b81xOjv9cnX3h1Pkr9YMGUKidwfAYa8PsCBI7Hp4dw587V8cUwPxS5KyPp/sYhKNGcOmUraAfSlZlbP20ylujASJYU1J8Fak0fchDsGDNIxSuXxwZZM9bDwSB8s6O0HdiiQD8arAf/E0Kj5C2p4o3Jr48sE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740268127; c=relaxed/simple;
	bh=xF0ox/74UjRXraUThum9vQmu1wwYLfV5VLUVBmCwffw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFwlPW8Q+89AQQ5i7Bnux21y8XbXWKGqyRKxkjREbAM+vta4pq7CTSzp+GHZ7sYKXSbYQUp1MccTrjc1S6L/LAuFMtJoQuIa+5UgAQL6f7VL2yJ874jvAb7SQ6q7cxgwBMN56iNmqhCHfYCjaseus0uf6Qmf57U71dSIghG6UyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=s5Hgk1Za; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tzYj2SBwZYdiAHJqAPsKe/dFQvpKAGWUcio6ju4eMVk=; b=s5Hgk1ZaHT8uyo1V0KFNKBG13Q
	zjV6RXP84BOVzBXJEm+GgJgVWSEmzBLzu9mogqDdbrgilm0MVthYje9q9/mJnYBATkiHYTiX3w8wQ
	fuAE7X0bFIvpqsz5uZfs7TSHF6fulhi5E94SMS26d6w3HSfO8M4vKtVTE6kAEBRY/CMblw8OyJ1u1
	ACKVx9wTemKktI+imsrHU0umpqVfWHZl3c6jo72DeDdsln+qZgZPO0B0ya3QOihMhNFK18sLfcVR+
	Fg6Q62ms02VS5GXU4Gquz2fj8JzZGD5axR3ZFMvWIPEwL9JZH6m152GRYj+ygcchPIPID8xgbJgs8
	LT1kRlQg==;
Received: from i53875a10.versanet.de ([83.135.90.16] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tlzEN-0004TL-OW; Sun, 23 Feb 2025 00:48:23 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chris Morgan <macromorgan@hotmail.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Tim Lunn <tim@feathertop.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Alexey Charkov <alchark@gmail.com>,
	Stephen Chen <stephen@radxa.com>,
	Elon Zhang <zhangzj@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: Re: [PATCH v5 0/2] Add Radxa Rock 4D support
Date: Sun, 23 Feb 2025 00:48:16 +0100
Message-ID: <174026756680.3008209.2974583864870803696.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250218160714.140709-1-detlev.casanova@collabora.com>
References: <20250218160714.140709-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 18 Feb 2025 11:04:17 -0500, Detlev Casanova wrote:
> Add the basic support for the board. (Not officially released yet)
> It is based on the Rockchip rk3576 SoC, so I haven't added the
> following devices yet:
>  - VOP/HDMI
>  - UFS
> as the support for those has not been merged yet, but are close to be
> and I already validated that they work.
> It will come with another patch set.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add Radxa ROCK 4D board
[2/2] arm64: dts: rockchip: Add Radxa ROCK 4D device tree

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

