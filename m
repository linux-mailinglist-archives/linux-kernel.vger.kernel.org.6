Return-Path: <linux-kernel+bounces-228798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB41916707
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B102833F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD1D153506;
	Tue, 25 Jun 2024 12:11:34 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5A14E2D6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317494; cv=none; b=btQi8qLGOydMobXSMq05vPaX6s9PEecNQOjSrVNxEfJlf9HJwHeU8vHyK/zNhRw0ZY4pq4yCXL1uzj+nymjlbNlyry6HD1f2Y5lxZcuzmOE7XNO9EmjNjgVD7qBd3VSTf8dzKAxBMk8uqQQM1/QQWy9vUQA6JoSOnHUMWzZtH3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317494; c=relaxed/simple;
	bh=dXPvzuAHdVyvfta2uzLyiKVYQS9Dreuhrq8dharWl5I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AJHBZ3YppLRDh8Qx4Mcy9NemQ8CkrNJnKmDt95TnIus4vlgzxWkcVVdxLXcHakv/BqP5g6tU3SgLSA4DV+4pmCasOsQR0hQ0ZJXgWV6o7UFpWUumL6I8XdOhRUmvL8uAHv6iQ2fkJLSXjBwMTYrFMTIrQRwDEszRV2WbKgUhCMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sM51F-0001L9-E8; Tue, 25 Jun 2024 14:11:29 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sM51E-004szK-Mf; Tue, 25 Jun 2024 14:11:28 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sM51E-0007v7-22;
	Tue, 25 Jun 2024 14:11:28 +0200
Message-ID: <10ab78d4a293afb5bc67c3db0fcb00a7e2669348.camel@pengutronix.de>
Subject: Re: [PATCH] reset: RESET_IMX8MP_AUDIOMIX should depend on ARCH_MXC
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Abel Vesa
 <abel.vesa@linaro.org>, Marco Felsch <m.felsch@pengutronix.de>, Shengjiu
 Wang <shengjiu.wang@nxp.com>
Cc: imx@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Tue, 25 Jun 2024 14:11:28 +0200
In-Reply-To: <6d8116a56186fbf468229e823c7c8dfcd9488959.1719316665.git.geert+renesas@glider.be>
References: 
	<6d8116a56186fbf468229e823c7c8dfcd9488959.1719316665.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2024-06-25 at 13:57 +0200, Geert Uytterhoeven wrote:
> The i.MX8MP AudioMix reset controller is only present on Freescale i.MX8
> SoCs.  Hence add a dependency on ARCH_MXC, to prevent asking the user
> about this driver when configuring a kernel without i.MX SoC support.
>=20
> Fixes: fe125601d17cc1ea ("reset: imx8mp-audiomix: Add AudioMix Block Cont=
rol reset driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

