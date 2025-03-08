Return-Path: <linux-kernel+bounces-552642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271A7A57C2C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206D9167910
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0BF1EB5C7;
	Sat,  8 Mar 2025 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="EZ1vdrVV"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10807464
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452721; cv=none; b=pJGUfwmi7lNqNw39Y+l4/liYRGga5T1jIQiex2UAAnOR1qvgbZNc8YgTUT+sm4d7Ajx2+hghGCRN3VlIVWX3wWfPSq+0v8uyFI4kCSc6yM2GbNoIghsbkNC9SYicLh8iTTpDwtImfpadoN3wUk3l+bjTsiTTHiMQV8v0+q+6zMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452721; c=relaxed/simple;
	bh=H2BsNafZeYvp9wbkGN2qGL99O0ortwb9hsZ0gqUcIdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/yAONZ99W7TGsnNa1v/SkrhKHOSRHss9b/m/egpp0DmnIaqxGtQkHZFObSXNPemedjySZ/9m5A0yGJzQ4i1OawR0VoWPbtMYd0BWvyFYZ6HM2rUxu8MaLeUTJYXwXUs2WUMH92BB/Y58Kw+RxD/8DGteTOMOEvCzJkSgH2MAqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=EZ1vdrVV; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H2BsNafZeYvp9wbkGN2qGL99O0ortwb9hsZ0gqUcIdA=; b=EZ1vdrVVdILyYK9dTDvtM7OoD3
	+qArpJvcSeElp9yPV81y5wQCiFYrtzFh4jIwIPPbd6kNm0oYAfywwQHxioFHDr4yRgXKaR5ALGwjX
	dWHgcLVL3kaRYIDyjT+zmCjLyOsukR/DtVn2w+3Tti8XIb/qFTCG+LMSftEPjWJYXp9HhkEjt5pg0
	qUFZEsG7r3zj3E6PLaJI9HmBpPVt32OM4Q0yw7keWSjLVCfudBHVtOmS+Mqv3N8asn/rA5B/exSz8
	YARA9KImzZKKEtHtbCxfmSdeLgkPIC1dWkkTg+UNRzk6dG4iFZMBGCpgywcb0QvmYolvJnOFsTSlR
	97cq09TQ==;
Received: from [194.95.143.137] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tqxOw-000463-O9; Sat, 08 Mar 2025 17:51:50 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Andy Yan <andyshrk@163.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH] phy: phy-rockchip-samsung-hdptx: Add support for RK3576
Date: Sat, 08 Mar 2025 17:51:50 +0100
Message-ID: <5069079.31r3eYUQgx@phil>
In-Reply-To: <20250306-rk3576-hdptx-phy-v1-1-288cc4b0611a@collabora.com>
References: <20250306-rk3576-hdptx-phy-v1-1-288cc4b0611a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 6. M=C3=A4rz 2025, 20:29:23 MEZ schrieb Nicolas Frattaroli:
> Despite the compatible already being listed in the bindings, the PHY
> driver never gained explicit support for it. This is especially a
> problem because the explicitly listed PHY addresses need to be specified
> for each SoC.
>=20
> To solve this, add the compatible, and a PHY config, with the address
> gleaned from rk3576.dtsi.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



