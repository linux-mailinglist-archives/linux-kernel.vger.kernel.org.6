Return-Path: <linux-kernel+bounces-433541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B559E59C0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182A216B3BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718F621882B;
	Thu,  5 Dec 2024 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BxWdMtw3"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE94521D58E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412758; cv=none; b=TYAYrRTx0K8LquyfoLXAMf3G/nbFrhfRnnCd/8JN3/mPwDXcHku6KjgGNoL72/MF/geZbnEYaT21Nl7L8F7Afp9KmOx7uWIETXMLFwF1olehDcBm7Xwh6tSLEjt+L3THcQ3M98GaBmnhDKk8weONB73dtuVupUyM6l8Jvg6ZxQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412758; c=relaxed/simple;
	bh=uuq3D5vtaiOASKyhR3s1nZgneWFh7sE/qKAj2Zq+UvU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cy7oj+sGNOS3cN462PJeDGRMg/ubhXVWOdIf4N3i6iVYoGBaSRSpuecmRLb4vbUn4XhBlBMly55XtzJB1E3oDshIeL5ia4R9hF9PQaF9OueK+JHI38dIylyz9YBxLqVrxRTZsOL5jCGfLXaZbQ7SuXLF4NxVa7B3F9L7vgu/Diw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BxWdMtw3; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DEFFAE0007;
	Thu,  5 Dec 2024 15:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733412754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sReBoPT1JSJ1DA3ZC1WbbChZ9fR0cPQ03s/2GbhiFr4=;
	b=BxWdMtw3m+YnkiJOTIyp6NWDPWfOSmQBU/jDdKrUhI55GR1DYIc1Y8A2X3REOlx+dEWSCD
	wnK/fWZGVJjO6vz3W2BWQUgp2ktCB9cvIkO0PzNzDPYA4k9aDMD6Q+0ld5bw531AQ5iSQ1
	Ix5riO1K25mRWOu8wCmomoNmD5pFWZ/reWDzycTd9b3M6oXnN7T2Tifhs+sEX1zCuaF5UD
	Ed3g5vJYFRQQkLXoj+QXOm1Xypddh3dqjYXaXprEu4YD8g4JT7wAKEm5gPT0LeQzx7bPGN
	LEgglkTdIpLES2SmsVdk9aBeDQTuoIgsQllstJIqD7pJ0MSYy+rd08wN6eFn+w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,  Daniel Golle
 <daniel@makrotopia.org>,  Chia-Lin Kao <acelan.kao@canonical.com>,  "Cheng
 Ming Lin" <chengminglin@mxic.com.tw>,  Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>,  Pratyush Yadav <pratyush@kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <linux-arm-kernel@lists.infradead.org>,
  <linux-mediatek@lists.infradead.org>,  Steven Liu
 <Steven.Liu@mediatek.com>
Subject: Re: [PATCH nand/next] mtd: nand: spi: Use write_cache first and
 then update_cache in write operation
In-Reply-To: <20241119093949.3014-1-SkyLake.Huang@mediatek.com> (Sky Huang's
	message of "Tue, 19 Nov 2024 17:39:49 +0800")
References: <20241119093949.3014-1-SkyLake.Huang@mediatek.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 05 Dec 2024 16:32:32 +0100
Message-ID: <871pymtab3.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

On 19/11/2024 at 17:39:49 +08, Sky Huang <SkyLake.Huang@mediatek.com> wrote:

> From: Sky Huang <skylake.huang@mediatek.com>
>
> According to discussion with Miquel Raynal <miquel.raynal@bootlin.com>
> and Chuanhong Guo <gch981213@gmail.com> on FORESEE F35SQA002G patch,
> Chuanhong recommmends that we can use the following sequence in
> spinand_write_to_cache_op():
>
> x1 mode:
> 02H(program data load) -> 84H(random program data load) -> 84H ...
>
> x4 mode:
> 32H(program data load x4) -> 34H(random program data load x4) -> 34H ...
>
> 02H or 32H commands will clear cache buffer on SPI-NAND and load
> data to it. For those SPI controllers which can't finish transmission
> in single step, 84H or 34H will be triggered for the rest data.
>
> We observe that some current SPI-NANDs, including FORESEE F35SQA001G and
> F35SQA002G, must use 02H or 32H to reset cache buffer in flash before
> using 84H or 34H. Or users may encounter program failure issue. This issue
> is not always reproducible, but it may occur and cause system instability.
>
> This sequence should work on all SPI-NANDs nowadays. I also check with
> Foresee that the sequence can solve the above program failure issue.
>
> On my test platform (MT7988), SPI driver is drivers/spi/spi-mt65xx.c.
> And I limit MTK_SPI_IPM_PACKET_SIZE to SZ_1K to simulate lightweight SPI
> controller which can only transmit 1024 bytes.
>
> The test step is the following:
> - mtd erase /dev/mtd2
> - dd if=3D/dev/zero bs=3D2048 count=3D1 | tr '\0' '\xA5' > output.bin
> - mtd write output.bin /dev/mtd2
>
> Before applying this patch, write operation uses only 34H(update_cache):
> [78.937720] OP code: 0x34, addr val: 0x0, data nbytes: 1020, data 1st byt=
e: 0xa5
> [78.945297] OP code: 0x34, addr val: 0x3fc, data nbytes: 1020, data 1st b=
yte: 0xa5
> [78.954251] OP code: 0x34, addr val: 0x7f8, data nbytes: 72, data 1st byt=
e: 0xa5
> [78.962966] OP code: 0x10, addr val: 0x300
> [78.968816] OP code: 0x34, addr val: 0x0, data nbytes: 1020, data 1st byt=
e: 0xff
> [78.977233] OP code: 0x34, addr val: 0x3fc, data nbytes: 1020, data 1st b=
yte: 0xff
> [78.985124] OP code: 0x34, addr val: 0x7f8, data nbytes: 72, data 1st byt=
e: 0xff
> [78.992527] OP code: 0x10, addr val: 0x301
> [78.996981] OP code: 0x34, addr val: 0x0, data nbytes: 1020, data 1st byt=
e: 0xff
> [79.004416] OP code: 0x34, addr val: 0x3fc, data nbytes: 1020, data 1st b=
yte: 0xff
> [79.012031] OP code: 0x34, addr val: 0x7f8, data nbytes: 72, data 1st byt=
e: 0xff
> [79.019435] OP code: 0x10, addr val: 0x302

I am sorry but above you said that we should not perform:

    0x32, 0x32, 0x32...

because the second time it would clear the cache again. And here
you tell us that actually the core already handles that by performing
instead:

    0x34, 0x34, 0x34...

So what is the problem?

Or maybe I misunderstood the issue, but I think Chuanhong raised an
issue that is already solved? Isn't it?

Thanks,
Miqu=C3=A8l

