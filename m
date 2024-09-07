Return-Path: <linux-kernel+bounces-319718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1079B97014B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 11:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53021F233BF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 09:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D281414D6E1;
	Sat,  7 Sep 2024 09:11:33 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959452B9B1
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725700293; cv=none; b=lKO5y/WC4WiuOr/NfVm/6RBpsPQ8wRkVLC4OZBq4dGj0oK3Q68QElfJiec+f0DSVz2b1Jv/LGwnbwjz6g/N90/qNdxJn0SCafOdjf6itnaCgnkm5HTs77Pw+O6svRBeh85EYNKFOYd49Bwq2kylUNM/OAY9nn4N7wjphGHAsyBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725700293; c=relaxed/simple;
	bh=HoP0i/qKcvq6jcAclYtG+dnkMQLY1YNOHQHjECFzr2A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=ipVS4fG/Ucn3+Ea2aurdS3ZEG02Abf66UZYw5q66f/o0DjEP/ZsXhVZ237pctal5txwPDVjYecn9VahkrSC0MEYrpx4rXm9oALo1QSEmFfcb+Mc7GUfQFhigfpLeCs593XL2M1K0L0nwxVUNLj6Bb+Y8EE2RI1amQUZZdvwiSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id E909B236;
	Sat,  7 Sep 2024 11:11:28 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Sep 2024 11:11:28 +0200
Message-Id: <D3ZXP46U6RQK.331FLSMEHHKUU@kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Add support for gd25 and gd55 series
 chips.
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>, "Renjun Wang"
 <renjunw0@foxmail.com>, <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
 <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
X-Mailer: aerc 0.16.0
References: <tencent_983A0FB4662661C03E98E1AC214E32179F0A@qq.com>
 <47e0745c-e7a4-4201-b1bf-bb8e44e5911d@wanadoo.fr>
In-Reply-To: <47e0745c-e7a4-4201-b1bf-bb8e44e5911d@wanadoo.fr>

Hi,

On Sat Sep 7, 2024 at 9:04 AM CEST, Christophe JAILLET wrote:
> Le 07/09/2024 =C3=A0 08:32, Renjun Wang a =C3=A9crit=C2=A0:
> > Add support for gd25lq255, gd25lb256, gd25lb512m, gd25b512m, gd55b01ge
> > and gd55lb01ge. All these chips are tested on Rockchip boards[1].
> >=20
> > [1]https://github.com/rockchip-linux/kernel/blob/develop-5.10/drivers/m=
td/spi-nor/gigadevice.c

That's even older. Sorry but no.

Have you checked that these flashes doesn't have SFDP tables?

-michael

