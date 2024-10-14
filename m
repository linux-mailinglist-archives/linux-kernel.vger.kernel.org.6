Return-Path: <linux-kernel+bounces-363737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B169299C661
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4F128456B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072B7158531;
	Mon, 14 Oct 2024 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V7CXkB+e"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33800156C5E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899392; cv=none; b=Cpr9gMyzZ9JOZgkoHD4T1FvWADyDvPR80w1YsT85QcAFoDR+OnLJd63Kv9GMK9rAOY4mcrhHURz+F41rX/sjvXEs/3sCX5PB3YU2j/JVsbfmz2b0KWwKyFQqHybP1zoC3QqAxtEp+3Je7YKCnZmSMtk1Ruk6/h8gVXxd4UTZOKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899392; c=relaxed/simple;
	bh=itMazNT5IeHaWiGMC76BKTAnxUDQZPiJp1MX6wqPgUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vBxfaFabzBscq67piW4fajhMKxaD4QzpIOcGOV1wWEXBNzFAdXFP5vtgr5Ar4SK9LQviVP8fOvojui4PjLrqxCihagLfgYDpS2LgCxs0i5l56IfVElxjI+st0KPjL0Ysn4iVTU88l0Z6xvUYP4+9Xh14S33Dzb85m7Us4VEJ6Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V7CXkB+e; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97457E0003;
	Mon, 14 Oct 2024 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728899383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9aFx25tuhpkab3VLe5pFlLF4S8kUqB2ME9LU6u6s7R8=;
	b=V7CXkB+eoiNjHEDAlFMYvE1Wf7ibLqhDoUAlDMSZsgjtW/NtkHTUA6C86J3INKIL+h24ue
	qwow9vaMF3+v8cyneRgveqE5v5GaiqyYfQP+PzwK/VPR0cSNB92zhORabBtYcXqXKQPsHz
	k7k0Qt+9hooTinTU2U4mZkIT1qeoXivhWt3uj5PUAK9FvMNwJDuilksTtZP3aI2vp++z4I
	QkdLLNCg932dVc3EGOroHYb7M/0pWvDF/eEaCT4zW2GwLvh002SpUZ6X9Ux+4MNI6kUH0t
	43wdgGYNs4sZ7jOBcME7oMN8dgSU+Ub7XpvULJI5GyX1+PdYLr1U+gVIzPg4sQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Andrew Davis <afd@ti.com>, Andre Przywara <andre.przywara@arm.com>,
 Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Daniel Mack
 <daniel@zonque.org>, Haojian
 Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v3 0/6] Switch more ARM plats to sys-off handler API
In-Reply-To: <20241011201645.797394-1-afd@ti.com>
References: <20241011201645.797394-1-afd@ti.com>
Date: Mon, 14 Oct 2024 11:49:41 +0200
Message-ID: <87cyk3c8ui.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Hello Andrew,

> Hello all,
>
> Continuing the quest to remove the legacy pm_power_off() global
> function handler. Remove uses from arch/arm/ using the helper
> register_platform_power_off().

I am in CC of this series, however, I am not the maintainer of any of
these platforms, and I don't remember making any changes related to your
series recently. Could you tell me what you expect from me?

Thanks,

Gregory

>
> Thanks,
> Andrew
>
> Changes for v3:
>  - Rebase on v6.12-rc1
>
> Changes for v2:
>  - Collect Reviewed/Acked-bys
>  - Rebase on v6.11-rc1
>
> Andrew Davis (6):
>   ARM: highbank: Switch to new sys-off handler API
>   ARM: imx: Switch to new sys-off handler API
>   ARM: pxa: Switch to new sys-off handler API
>   ARM: sa1100: Switch to new sys-off handler API
>   ARM: vt8500: Switch to new sys-off handler API
>   arm/xen: Switch to new sys-off handler API
>
>  arch/arm/mach-highbank/highbank.c | 2 +-
>  arch/arm/mach-imx/pm-imx6.c       | 6 ++----
>  arch/arm/mach-pxa/spitz.c         | 2 +-
>  arch/arm/mach-sa1100/generic.c    | 2 +-
>  arch/arm/mach-vt8500/vt8500.c     | 2 +-
>  arch/arm/xen/enlighten.c          | 2 +-
>  6 files changed, 7 insertions(+), 9 deletions(-)
>
> -- 
> 2.39.2

