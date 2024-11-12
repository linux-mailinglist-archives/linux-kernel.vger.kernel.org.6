Return-Path: <linux-kernel+bounces-405698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5609C55F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1E71F24DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C8221CFBA;
	Tue, 12 Nov 2024 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KcfKcMXb"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B61A21CFA9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408531; cv=none; b=klHuNgIla2V2I+UiSNySA4SDAjRUFHWJlfme6mjYRt2oBTTuykDyZrP0qyaV+LAFCp304l1pDhO6rCfk/5tueGIfk6SV9WsRfGGVNli0J3/0F7OCeMTWXg7ex5OIEKBM5Td2Ds75BLwFWzqgS2I9btYB8DTlEGQY1+6eEYVzjwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408531; c=relaxed/simple;
	bh=mlVwLQCWy24Cb/sNaSGUN5XV3+kGewbUdR+Bx7uYdlM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a+73oh7CwqjPZ2zgQNr9kdwAhuRm0dAOweyA08b9baPbSmU6BIG8a3HPUH03atxPsa6z/aM5NtaPj+M4e04szTn8Tt+YbPTyPrwjzd5HZTp86S3FFHXOaFbYcBCf5uuIwu5PoI9TeiLxajBS4MgX5T7iEX3nJe30ahDAy74KJdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KcfKcMXb; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C7DDE0003;
	Tue, 12 Nov 2024 10:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731408527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mlVwLQCWy24Cb/sNaSGUN5XV3+kGewbUdR+Bx7uYdlM=;
	b=KcfKcMXbPi2VOK8LbaLSQSLr+CG5JNTDTqmQ1mXvmbswz/W4GicAOjOtUczHOJbBUw6r/6
	wAFCz6HjglSKRY+ZVhUoC5eWV5kLq4vsHXCNv+hwMl2yF8T9KBKN+CWtoVsssGdPScFZeW
	mnW9omVWNkwP1vTovuljDEQMSsJ4/O+2H/jDTsVOqQnPYExHLBmN+A7mdpI3WcWHqO2SLN
	VcrwVprYlOXOlcakn/rYOHFvvJ0iJuuwX8sLt8kKbGQLt+2nfvp2PjvBwVsGoipiCx+eZ3
	iE0fHHhOX2ZCdqeO2l6C0hGepKntAcahlF4dpm2n6iWEdGOzsqTS5YAd/c+zLA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: SkyLake Huang (=?utf-8?B?6buD5ZWf5r6k?=) <SkyLake.Huang@mediatek.com>
Cc: "dev@kicherer.org" <dev@kicherer.org>,  "d-gole@ti.com" <d-gole@ti.com>,
  "vigneshr@ti.com" <vigneshr@ti.com>,  "gch981213@gmail.com"
 <gch981213@gmail.com>,  "mmkurbanov@salutedevices.com"
 <mmkurbanov@salutedevices.com>,  "richard@nod.at" <richard@nod.at>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "kernel@sberdevices.ru" <kernel@sberdevices.ru>
Subject: Re: [PATCH v2] mtd: spinand: add support for FORESEE F35SQA002G
In-Reply-To: <dbdb45ed1135e73b4eebd76e6f61b96d48aaedc6.camel@mediatek.com>
	("SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCkiJ3M=?= message of "Tue, 12 Nov
 2024 10:08:31
	+0000")
References: <20241108163455.885-1-SkyLake.Huang@mediatek.com>
	<20241108163455.885-4-SkyLake.Huang@mediatek.com>
	<dbdb45ed1135e73b4eebd76e6f61b96d48aaedc6.camel@mediatek.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 12 Nov 2024 11:48:45 +0100
Message-ID: <87ikssu3qq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Sky,

On 12/11/2024 at 10:08:31 GMT, SkyLake Huang (=E9=BB=83=E5=95=9F=E6=BE=A4) =
<SkyLake.Huang@mediatek.com> wrote:

> Hi Miquel/Martin,
> About this driver, including F35SQA001G/F35SQA002G parts, I'm concerned
> that the driver will always use 32H for update_cache operations, which
> means it's not compitable with those SPI controller who can't transmit
> 2048 bytes (most small-density SPI-NAND's page size nowadays) at one
> time.
>
> The following controller's driver seems that they can't transmit 2048
> bytes in one transmission:
> - spi-amd.c: 64 bytes (AMD_SPI_MAX_DATA)
> - spi-amlogic-spifc-a1.c: 512 bytes (SPIFC_A1_BUFFER_SIZE)
> - spi-fsl-qspi.c: 1KB
> - spi-hisi-sfc-v3xx.c: 64*6 bytes
> - spi-intel.c: 64 bytes (INTEL_SPI_FIFO_SZ)
> - spi-microchip-core-qspi.c: 256 bytesc (MAX_DATA_CMD_LEN)
> - spi-nxp-fspi.c: TX:1KB, RX: 512B in FIFO mode
> - spi-wpcm-fiu.c: 4B

I believe most of these drivers are still able to send one page of data
without toggling the CS (which is what actually matters, I believe). If
they were broken, they would be broken with all spi memory devices, not
only Foresee's.

> I guess we need to add some check to make sure that F35SQA series work
> only with those SPI controllers who can transmit more than 2048
> bytes(NAND page size) at one time?

There is already a supports_op() hook for that, I believe we are
fine. If however you experience errors, please report them and we'll
look for a solution.

Thanks,
Miqu=C3=A8l

