Return-Path: <linux-kernel+bounces-535027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC46A46DED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BE91886D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0955D25C6EF;
	Wed, 26 Feb 2025 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="uD2QzNBN"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2B2253FD;
	Wed, 26 Feb 2025 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606669; cv=none; b=uxJuaKqFLBuZ0YPLsREKhh1n0UQdfDplaChV8jqp1OsoS6AVqiEPB/FXSvfh1qg66yYrwpQM2iluSrn6itocJeHpe1BwA5RDLx+q/PXp3aglWb02B+iOx+D4gJn6FJ1zMXzRgLewp4UkNPQfhCmmqdtOgl6ZShxv13Q3HX1LT1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606669; c=relaxed/simple;
	bh=KoXFM6Kx4ZCdYLrS7aPjyHnkyGmfjKFAsTss8A9bALU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOv6hfN6D2/yUufUBlWtTBaPrVfjnGknYcKwFMhX50/7rUvOVSUxBTqvNmiZq+LPj53j9KDBR+d8yYeAebA9eKKAnTcIlcuplQrGWTvBgOgPO+/392WLbwiOWZkJ61C6wk0hVl2J14jqjlxb9JAyih1G1LKzPprNs2tO9xtRyTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=uD2QzNBN; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Zep892YhHBeGu7ypgTlnqdKmeYJIyeAfXkPBma9xeg8=; b=uD2QzNBNUdgc+W5pUpIdlglnZz
	zhL3oa7szuzzcK1onL81vEN9qB2pSWeo8xMhSHV/5mGZG5OwkvbCSmBmJlgNAl0mtEd+l1CZXOTaK
	gPnlwd4j+tm8yaAk38y2+QtTi2XgcTdzJeijKCc7ihPRcu/H+IsaUHEsHr22nNs972E99dcBa3cX+
	/ZdtMlbplq14g6GXoGP9E2uCoLXcgrXuxxaC0DtQCp86OT4eC6teXQiqPBrXeq+WQUvXMRBx4a7tB
	6Prvnht3tJzYDNtc7YVkE1T8+Gu/2NwvIiFX1Wvlz2Fr4Pg/hshZsZC1ByULP3076QGPUcqQfNSjb
	HqPeCNbw==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnPIv-0003pQ-C1; Wed, 26 Feb 2025 22:50:57 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	krzk+dt@kernel.org,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Enable USB3 OTG on rk3588s Cool Pi 4B
Date: Wed, 26 Feb 2025 22:50:47 +0100
Message-ID: <174060663654.4032178.11014498458940806402.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250223100757.73531-1-andyshrk@163.com>
References: <20250223100757.73531-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 23 Feb 2025 18:07:46 +0800, Andy Yan wrote:
> Enable USB3 OTG and it's related PHY node. And the PHY will
> also be shared with the upcoming DisplayPort controller.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable USB3 OTG on rk3588s Cool Pi 4B
      commit: a3b3b57ec92f46237b2478973aec65270f457bc2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

