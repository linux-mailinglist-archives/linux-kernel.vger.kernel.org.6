Return-Path: <linux-kernel+bounces-319720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72699970151
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 11:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B81B1C208A3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 09:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE5114B96B;
	Sat,  7 Sep 2024 09:18:01 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151343ACB
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725700680; cv=none; b=l8Twh/tX5Ph8qPlSeh+TnkoCdgWdUoeRm33xR4g8jSe0ZaEOcMmn8vit6+VA+v/KUG0bdtKnaqYvKYXZWELkIWDHlYXoGKppyZFt3wy8bvW6+q+ggUj20S4f2WrBl+gDOIJ/YfZnFBP9WwULGEtc6H5o8cPalJiZRYZsetVyFG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725700680; c=relaxed/simple;
	bh=w0coCENJbfWdTwt5oaRaKpY76vBuICJY77RJrmDb5Sg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=H/FKki9l2++QO6Z8TbmIuSAn0zQrOgUYqBtHLhxsx4k7fTTkuugmiaVPSY4mLOj4Zk1le+FQpnpsVcaVFyanbd8BpkhlQtQn2yl7jzwEZsbkotOg4oVaM1BjB5JYStpwovPF9OaGBdTz39rmgHwDdc/9QsB9MZGBW3NCwsfPLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 564EDA01;
	Sat,  7 Sep 2024 11:09:01 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Sep 2024 11:09:00 +0200
Message-Id: <D3ZXN8C7ABAT.SS2W1C409F4I@kernel.org>
To: "Renjun Wang" <renjunw0@foxmail.com>, <tudor.ambarus@linaro.org>,
 <pratyush@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
 <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: Add support for XM25Q series chips.
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <tencent_E68F624B67F256EA24115857B3DEB5E84907@qq.com>
In-Reply-To: <tencent_E68F624B67F256EA24115857B3DEB5E84907@qq.com>

Hi,

On Sat Sep 7, 2024 at 8:31 AM CEST, Renjun Wang wrote:
> Add support for XM25QH32A, XM25QH64C, XM25QU64C, XM25QH128B, XM25QH128C,
> XM25QU128C, XM25QH256C. These series chips are already tested on Orange
> Pi boards[1].

I've just checked a few but they all had SFDP. Thus they don't need
an entry in the database as it is covered by the generic driver.

Also please read https://docs.kernel.org/driver-api/mtd/spi-nor.html

> [1]https://github.com/orangepi-xunlong/linux-orangepi/blob/orange-pi-6.1-=
rk35xx/drivers/mtd/spi-nor/xmc.c

That's an ancient kernel.

-michael

