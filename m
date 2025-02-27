Return-Path: <linux-kernel+bounces-536060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B59A47B16
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9298B18929B2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4772F215F44;
	Thu, 27 Feb 2025 11:00:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344571E1DEF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654022; cv=none; b=uOFCPIgyaTpTkptw/96KQ4DTIefQ0z7kV58bmIj1w7/ar13wNmpSqUJuETQJSvIug16/CK5cBXy7EBNU9IT5SBEu5kEQLbp1l0GsyGdEuBH6lzK2LkpEqU7px/HFYm/ZBJRFyKSFu5SpOk5F8gGvMu8wehg/t5aZ5/yPLHgSuFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654022; c=relaxed/simple;
	bh=WZpBvNTiF72CoGtzoTsdS/QN/xhPzaQrjim5IiJgJWc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VvLb9eUxti2ZrDivdi8OplAhi049cYbdbRX2/IT0IBVFW5d5ayk6v2ko24GMO4nFzAq28fMxfJPSv7Ia6utHEqm4gasDML0P/lPIxOZ9wYwC3W6BtB0RkJiW1V98vpZRwuB7Res5GgQyQV+6ceiqlmqA5SpoljPRbaAehop/bOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnbck-0000FI-RT; Thu, 27 Feb 2025 12:00:14 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnbck-0036wn-1o;
	Thu, 27 Feb 2025 12:00:14 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnbck-0005pz-1b;
	Thu, 27 Feb 2025 12:00:14 +0100
Message-ID: <4dbc990ae607404ce4288d884652b9143032023b.camel@pengutronix.de>
Subject: Re: [PATCH v4] reset: mchp: sparx5: Fix for lan966x
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com, 
	UNGLinuxDriver@microchip.com, herve.codina@bootlin.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 27 Feb 2025 12:00:14 +0100
In-Reply-To: <20250227105502.25125-1-horatiu.vultur@microchip.com>
References: <20250227105502.25125-1-horatiu.vultur@microchip.com>
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

On Do, 2025-02-27 at 11:55 +0100, Horatiu Vultur wrote:
> With the blamed commit it seems that lan966x doesn't seem to boot
> anymore when the internal CPU is used.
> The reason seems to be the usage of the devm_of_iomap, if we replace
> this with devm_ioremap, this seems to fix the issue as we use the same
> region also for other devices.
>=20
> Fixes: 0426a920d6269c ("reset: mchp: sparx5: Map cpu-syscon locally in ca=
se of LAN966x")
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Tested-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

