Return-Path: <linux-kernel+bounces-242434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA8F928800
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88E13B22148
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2C3149DF4;
	Fri,  5 Jul 2024 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cOBxOY8+"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86616A039
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179133; cv=none; b=Wd2xukt2DuXkdc38Y+i+DDXR3t5GSBO9/+LaRifZIiTIlh4HXEondUw3glhT7zMfJglo5J1TRyHFHcnphTSFqQrjdGQPXk/71i3XHnMJMY7buDTVY3o1m6vTX1c2DysHpWPvMgv6swVjKuBdHYr+AUCYCtqUumVrVKwYG69ZKTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179133; c=relaxed/simple;
	bh=BiQR0pNXalU4Cz3nZtG+0m3JqCJnGGU3j8qUXAiG1sM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVR9pvuSI3SVYqww95xHEWc8j5SZ5xensNKpMxHA/tT/L6QefyydKl9+S6u41FIbpkTxhGA3wzxzI5DlRV7eirziqkr0u3osAqCxMNfd3eYGNiFg/LgPb2pgYe7KJbUp6vZ+WGMFS9YNpY46Obb7gCRUEGNSELkiFKzicJwHoqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cOBxOY8+; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C2832000C;
	Fri,  5 Jul 2024 11:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720179123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsViN59W6qMf/mS+MNMH3PMMvUGwpG61clKEaWdUd48=;
	b=cOBxOY8+JvnXcaqpYardXjxv6JGoZAAHi9BSk1DJMLh6OtxUT0QiBTMYviE8ISc3OA+TTt
	KHR4DmAeL0da+lyIAqpKcaLX15mbFKCA31+avHflmhs9KzOiRhhnDwzuyFbbsyI1dJK7uO
	wxj3/0Ubx4/U11lKDTqddlIXJqttq7BEzdrm5KWB0BdAM8JnPgGlJVU01prpy6XJCnac+F
	aOM9uMdr6Y1j+gr9OwZDCvnt++THPMJZlPIjZDjmfLvq35h4CP4g31qU2KTXAqk1yebEz9
	AP58NYmPCFsOCMykZU2rWvo9/1MrDX7/DtpvBNWy/q1j0sFnqLvMDsMlNa6y7g==
Date: Fri, 5 Jul 2024 13:32:01 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: dan.carpenter@linaro.org, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Vladimir Zapolskiy <vz@mleia.com>, Arnd
 Bergmann <arnd@arndb.de>, Yangtao Li <frank.li@vivo.com>, Li Zetao
 <lizetao1@huawei.com>, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: lpx32xx: Fix dma_request_chan() error
 checks
Message-ID: <20240705133201.023cf3c7@xps-13>
In-Reply-To: <20240705093851.18107-1-piotr.wojtaszczyk@timesys.com>
References: <20240705093851.18107-1-piotr.wojtaszczyk@timesys.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Piotr,

piotr.wojtaszczyk@timesys.com wrote on Fri,  5 Jul 2024 11:38:47 +0200:

> The dma_request_chan() returns error pointer in case of error, while
> dma_request_channel() returns NULL in case of error therefore different
> error checks are needed for the two.
>=20
> Fixes: 7326d3fb1ee3 ("mtd: rawnand: lpx32xx: Request DMA channels
> using DT entries")

Pleae don't split the commit title over two lines.

Missing: Cc: stable.

> Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>

Thanks,
Miqu=C3=A8l

