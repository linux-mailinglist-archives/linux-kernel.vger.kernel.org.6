Return-Path: <linux-kernel+bounces-282823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C01A694E903
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C515B23A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AB416BE2D;
	Mon, 12 Aug 2024 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l0pdecR3"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B94F74C14
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452996; cv=none; b=JYwuNNeiMi5DLQNAEMRm0bL3crtlyrUvKrzBfkdHFloJGXkYQrIZyu5KTd3vljxO12flWk+NZwOk8g+/zCXGAuptgrMeypYgYbAhUUJEgM4PmvRtlaD5Dj7Vx+fbWAazF9X+j/GCNcumXWRmNpJurkuq9CQAFhZh0m/4bTNqM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452996; c=relaxed/simple;
	bh=wclZ3TxtabAtjYtXzCk85gIwo/S6NWdu9cJw8amEt4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSy0ktJL4TSu7/+6ofxIQC4Z2uHL4LzVC7ptsER0NRiC+VphevvbzgVrkjUjE9IKIMTk46XXqzNseGIxdfo3WSElMm1g/jXTbN+L7N3lJTHpLdfSuYl5qZCXjx2cffWhKA3Ku6Hpetkp+FciHsceywx2TMPcujUY9HxqMUqRGS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l0pdecR3; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E074C000F;
	Mon, 12 Aug 2024 08:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723452992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElaYv5EFcS4qx0+W9y9TrVOp03MbKNX4bj9TdrCX//s=;
	b=l0pdecR3K/faB/eH1Bvsg0H7j9FsAESWgceRwwtx7nUHrmTgY9LdtkeXoMx40fkOd8kZFG
	+8GoxAyqS41ZnBr0Qrw2EqeyGDMOh62Vcy3sArH0W41M0/vXvx7WpPvxCbwKhb1MmVpcK+
	ShIwUsPbvIDOmFuO09T0hf/+646G/2hP0gkHTBilJOBmEQE6qbZ8yO5zWhN9nVPZk6UsAI
	P1pV6JtwGwk8N3ChDTFT7chxCpP+zJTCtb7evYS6CEYLfcGlbm6+kkxqCTeNHqQ5mVmfkv
	B2Aaj2DmBRwly9d8f2w7uro+zdObfqypxWrty5uxrmUZJYAAuyhlxNFVLA6ofA==
Date: Mon, 12 Aug 2024 10:56:30 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw,
 leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v2 0/2] Add fixups for two-plane serial NAND flash
Message-ID: <20240812105630.2b71ed19@xps-13>
In-Reply-To: <20240718075356.488253-1-linchengming884@gmail.com>
References: <20240718075356.488253-1-linchengming884@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Cheng,

linchengming884@gmail.com wrote on Thu, 18 Jul 2024 15:53:54 +0800:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>=20
> Macronix serial NAND flash with a two-plane structure
> requires insertion of Plane Select bit into the column
> address during the write_to_cache operation.
>=20
> Additionally, for MX35{U,F}2G14AC, insertion of Plane
> Select bit into the column address is required during
> the read_from_cache operation.

I guess if the plane bit is needed for your chips, it is also needed
for other whips with two planes? Could it be possible that we never had
support for devices with more than one plane and you just fall into a
common issue? Maybe we should always add the plane information when
there is more than one plane to address? Can you check whether this is
specific to Macronix or not?

In this case we wouldn't need a specific fixup.

>=20
> These flashes have been validated on Xilinx zynq-picozed
> board which included Macronix SPI Host.
>=20
> Cheng Ming Lin (2):
>   mtd: spinand: Add fixups for spinand
>   mtd: spinand: macronix: Fixups for Plane Select bit
>=20
>  drivers/mtd/nand/spi/core.c     |  7 ++++
>  drivers/mtd/nand/spi/macronix.c | 66 ++++++++++++++++++++++++++++++---
>  include/linux/mtd/spinand.h     | 17 +++++++++
>  3 files changed, 84 insertions(+), 6 deletions(-)
>=20


Thanks,
Miqu=C3=A8l

