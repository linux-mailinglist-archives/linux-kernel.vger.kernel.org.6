Return-Path: <linux-kernel+bounces-412791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D46169D0F09
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D884282C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84FD19884C;
	Mon, 18 Nov 2024 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c+jy871s"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AE9194A5A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927346; cv=none; b=FeBmcC+QLL1AdopzOsbhZUcphbWmg9zaS/+RoBXilkurTlZDvjfNqjofrRgJDMLbdSzYn2IMI0nSV+ZaA0aSBVeqFn89SRgzuNN52XOm9C4go+kYjTDlIMmPlY//y48uS7VF3x/iPg5p+PEh2TdM8iGBoh0HLTxAKoscflatfpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927346; c=relaxed/simple;
	bh=Zzh7nhip7P2NRDANsFNZDjlxnLfwoqac2YOb0mHrdHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WKot3BymfX9z8/p2+m/zujtKzCInR+RET8nkc41Y0O0SYQaIOF5P/ZJ2N8B+UsmLP0iaVh2A0Jg/MGRwaaRPqQI8octl8uhej8uVYmJy22p+CkvBluT/TY17AUAElHshWbMOU4ILW8IjoLONI+yUJ6VBLGViO1oDgApX6iqy8g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c+jy871s; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30A776000A;
	Mon, 18 Nov 2024 10:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731927341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zzh7nhip7P2NRDANsFNZDjlxnLfwoqac2YOb0mHrdHE=;
	b=c+jy871sogY634JgCb022cxm3ui6nnQ+VW/olbgb8aXdgl/d4PenzcP8SjJImE+H2rCp94
	qhmv2swkL2b7rdpqSEntQaEs1jzIbpsyx7URkUek3or0FUBckUKuTVxTCRkg5XrEVjOPnE
	dXNXvLy3wnoIKgNi9mbnYYlxOSg8uyUN8QpETTxHTzc+A6lYfk5p3bSk0/oAuv/SM/8tSx
	lZp6Q8r8m2Idpk/WKr/vHf+J50DGAcOJyby0dKd2em3ATkN7rqnTEozLpEIktf2D3DtycP
	KpR5bTCFxAjv0lkkDITe6G1kOb4WbOzmXgp/r3g+yyJaI3IpXhvc1cNBvjWoAA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,  Daniel Golle
 <daniel@makrotopia.org>,  Chia-Lin Kao <acelan.kao@canonical.com>,  "Mika
 Westerberg" <mika.westerberg@linux.intel.com>,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <linux-arm-kernel@lists.infradead.org>,
  <linux-mediatek@lists.infradead.org>,  Steven Liu
 <Steven.Liu@mediatek.com>
Subject: Re: [RFC PATCH nand/next 1/4] mtd: nand: Create param.c to do CRC
 check and bitwise majority for Parameter & CASN page
In-Reply-To: <20241020132722.20565-2-SkyLake.Huang@mediatek.com> (Sky Huang's
	message of "Sun, 20 Oct 2024 21:27:19 +0800")
References: <20241020132722.20565-1-SkyLake.Huang@mediatek.com>
	<20241020132722.20565-2-SkyLake.Huang@mediatek.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 18 Nov 2024 11:55:39 +0100
Message-ID: <87bjyczu8k.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 20/10/2024 at 21:27:19 +08, Sky Huang <SkyLake.Huang@mediatek.com> wrote:

> From: "Sky.Huang" <skylake.huang@mediatek.com>
>
> Create drivers/mtd/nand/param.c so ONFI parameter page & CASN page
> can both use nanddev_crc16() and nanddev_bit_wise_majority() directly
> like this:
> * For ONFI Parameter page:
> onfi_crc16() -> nanddev_crc16()
> * For CASN page: nanddev_crc16()
>
> nanddev_bit_wise_majority() is same as nand_bit_wise_majority().

Please use the same nanddev_ prefix.

> nanddev_crc16() is same as onfi_crc16(). But there are lots of
> onfi_crc16() call, so keep onfi_crc16() there and hook it to
> nanddev_crc16().
>
> Signed-off-by: Sky Huang <skylake.huang@mediatek.com>

Thanks,
Miqu=C3=A8l

