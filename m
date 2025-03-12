Return-Path: <linux-kernel+bounces-557344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4735DA5D795
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 757317A4165
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3803922ACD1;
	Wed, 12 Mar 2025 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="IVTsrl6d"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4883A2253FF;
	Wed, 12 Mar 2025 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765629; cv=none; b=TfzLeu2o+pA2zYmrxw5zTycqLJlfTFcLyRjqrXj0yVe9H1X9i5sQPbDrABc4uCE8KjBlycJ45b93pRHQq/Bz+IDLVfRyQ2ZeqoaTNYIkZEnF04fS64ePIafqktYTDAsYPixwI5E8bBf+Qi3EpunjCJsJq9lECkVvLe3OckcqLkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765629; c=relaxed/simple;
	bh=kZIiFVdyQzukg8eh3MHgnrpX0CTyejK9d15cZFSkidw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRhs9suKKt4UJHWAOZoxSWxC3ABNXLUq0dDxtPxEY5dgu1rSuP0S4ZyRpD0JF3fGXdICjD+RhcCNkHVaLOBsRHnzyxJnAmvJsXr9vUyrkFpHIY3nT/+KrxVEXTZuEhZ+osAn1e6x+S/i46Rknogosk0J+QK45cY3OrRSYO1+MBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=IVTsrl6d; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4iuFv9NTEdWlywEFlXwkd3bL0Y09KiRC4OxelSCqZ9o=; b=IVTsrl6dBifOv06yiv0vyYfOX0
	R3kd/64HVhP9boypV2Wd80GVzOdP+IdKWse+rDLX90SfXRK6h34Byt/L25sruXGE/XNwq/rRUB4Rg
	iSrOfh44wjAGey8w9r0dU+WMp1PV9Dm9RC3gQoiDSyQRPFB3hv70XW6TvoKZ8nT4wG1RP/tYoN0n3
	BYRTbZoLPJQ2Hn715GwlXsH1QUdEzVSnMCe/QtpJYztH8n5OmszS03h9WyxpBzoskZLuFt8/j3VLz
	z4t/7E3FnzzoPU7pirQhdiNpjhrEXsM6jeglcwQcZnEF9I+FPuzFsHnbTzQSbZQT3a4x5iqMvFyiW
	1dC/IXEA==;
Received: from ip-185-104-138-79.ptr.icomera.net ([185.104.138.79] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tsGna-0005zY-MH; Wed, 12 Mar 2025 08:46:42 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Andy Yan <andyshrk@163.com>,
	Damon Ding <damon.ding@rock-chips.com>,
	Jing Luo <jing@jing.rocks>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Yao Zi <ziyao@disroot.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix PWM pinctrl names
Date: Wed, 12 Mar 2025 08:46:03 +0100
Message-ID: <174176555635.249409.12410081245956028439.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310140916.14384-2-ziyao@disroot.org>
References: <20250310140916.14384-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 10 Mar 2025 14:09:17 +0000, Yao Zi wrote:
> These Rockchip boards assign "active" as the pinctrl name for PWM
> controllers, which has never been supported in mainline Rockchip PWM
> driver. It seems the name used by downstream kernel is accidentally
> brought into maineline. Let's fix them.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix PWM pinctrl names
      commit: 96d8d325324639f03fcca12e4ea92265ebb24837

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

