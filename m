Return-Path: <linux-kernel+bounces-539524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7E1A4A580
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B62357A9B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138FD1D9663;
	Fri, 28 Feb 2025 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="zZFpBdj3"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0218623F368;
	Fri, 28 Feb 2025 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780105; cv=none; b=gvmWfZVguU5RHs4uSCMEBzVCyvgwR3whLuBuz9BorvtVUzlgbPy+4Jxp4Iq8sXBpmzjdSF/gassm9qpn6GXgKrjhYX/Ye5yd/ha6p6hAd4I5AkXB84g2peeMRY8EBJB3n/Da9sFJd/UidhcsZhL9GQwnV9suziQLvBvWH9abC7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780105; c=relaxed/simple;
	bh=N6xBAActN4xoK2F3TbYfwRlYXNzM8tVoRboKiOYpvPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1DWBOaBfyNQzyYM7uiMXErjYaK5Y8ebfiNFfu6M5GkA4Mwu/gcaJnpuL7XKDIMnQ7SvrNnV/+1vBOVu8JwX7SJeDNzaeWYrHwqMWKXe/weXhhHS2UwJr80UdvcqsDvHr9Mk7nKeXDhoBDiMNA4MCAEaz2ILIilHjxevpiwfz2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=zZFpBdj3; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xk2zYtXp4iFJHcP/Qhn8mpCV+H+S+uHHYbsnZTGXr80=; b=zZFpBdj3jP+VFXqjYasjuI2NW3
	yzcaqeYovFrHBY6kDmatbcRNVplUkXbLF9WUQwAkRcihNOygBSiECLkWvehFJkCn+5FJ7RK2aYZok
	fMtK3LL69+vvmjGo0ksZM/XUNHEE3J9jsM7/AfiQfSdBLc9ym3mFHf0RK/IYWIdkkDCAz8VajKyoK
	+SwrW7WV4HId4aAwU06zjRBDPh2S3hghrNNAjUPciWB0wS4ZXvon/8P9zf+/YLC4lMshNFOztL8BN
	oZci4jbpa+EtTR1DpIQ/iH7gjGKtekAYxS49YsFf1ics4LLRLRNYIJ9ZkLhX0TUuXm/FdEnMEyo9D
	kkHYgLzg==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1to8QO-0003wY-8l; Fri, 28 Feb 2025 23:01:40 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dse@thaumatec.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v4] arm64: dts: rockchip: add usb typec host support to rk3588-jaguar
Date: Fri, 28 Feb 2025 23:01:27 +0100
Message-ID: <174078008218.501190.3886529459427107122.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250228150853.329175-1-heiko@sntech.de>
References: <20250228150853.329175-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 28 Feb 2025 16:08:53 +0100, Heiko Stuebner wrote:
> Jaguar has two type-c ports connected to fusb302 controllers that can
> work both in host and device mode and can also run in display-port
> altmode.
> 
> While these ports can work in dual-role data mode, they do not support
> powering the device itself as power-sink. This causes issues because
> the current infrastructure does not cope well with dual-role data
> without dual-role power.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: add usb typec host support to rk3588-jaguar
      commit: c55c9e91d1643493d0434f246917aea7a2653e0f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

