Return-Path: <linux-kernel+bounces-171771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 915A58BE85C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398F41F2E07B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B4316C69A;
	Tue,  7 May 2024 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ny2YCMEu"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C881200D2
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098094; cv=none; b=MepRZ/PhzHvvTutsbaQsm8Fn0AxzhkjZBCxuZY6dqsxsvdK6XDPklKiUTT8UA973zry11xp32BUQytGcoa3q96M0h3Uu1/qQLDYlHdYOTC4PsAlWKU3/f6XAteYTTawBoD0rbomAEdCq4s2raICAz7jpS/UENQmJlbzilNnBKUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098094; c=relaxed/simple;
	bh=f05afKsITrpp3cnBSANKiXBY8zvpItYl08IudmMacyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6mrmWawLGT0RRWJMabhCgMVDlDamzCQo/Ge7G+4r5YVbkVok6lhM0m3eWGx9SWQPzc1aueCoDa/lfRRmq9DGxX2uSBi+sx7mzKVrQe6L9njuHmNtVBinMS+R/Xp18pvVvCfQVOQ0+yUXw00fnLN3mDoYGvN+tOKIKAok44/k5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ny2YCMEu; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E60E240005;
	Tue,  7 May 2024 16:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715098090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fAJH7dRylBLnvkV617G2uaFst1GpsCSemSBMzD0bvWo=;
	b=ny2YCMEunzaVbC9LA/DcWNyi6dmZ8jSL0cDIbnvdyl4YxLnDJdnkkKm5Fx0omiVqfMfJ1D
	rX4gGpT8ymBi/q0Dqprfbz+p0Pktlm8q9nApEck6zqGlq1VPgyyOAoAsn7HxQ2L/wdqlEc
	vlEMaIu7vfJs8BwLLDFecpyC2ycebtGXLKh/b11dRVHmUqWKxA+rM9iIdV60ziSOJt4Pjo
	ivfHkcl1Auwb6jBTm13aYs2x12H7rTOnYKs5liFit/gtQGF9f+8IQBg0hK7LwHy/JS+00M
	2GCYjPkHrJ7wGnUlpQTQve60QmvJuOXq2eeDuGcC0rJnoK251lAzYvI1QgDyjg==
Date: Tue, 7 May 2024 18:08:08 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: mtd: nand: raw: Possible bug in nand_onfi_detect()?
Message-ID: <20240507180808.7f252532@xps-13>
In-Reply-To: <20240306-shaky-bunion-d28b65ea97d7@thorsis.com>
References: <20240306-shaky-bunion-d28b65ea97d7@thorsis.com>
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

Hello,

ada@thorsis.com wrote on Wed, 6 Mar 2024 15:36:04 +0100:

> Hello everyone,
>=20
> I think I found a bug in nand_onfi_detect() which was introduced with
> commit c27842e7e11f ("mtd: rawnand: onfi: Adapt the parameter page
> read to constraint controllers") back in 2020.
>=20
> Background on how I found this: I'm currently struggling getting raw
> nand flash access to fly with an at91 sam9x60 SoC and a S34ML02G1
> Spansion SLC raw NAND flash on a custom board.  The setup is
> comparable to the sam9x60 curiosity board and can be reproduced with
> that one.
>=20
> NAND flash on sam9x60 curiosity board works fine with what is in
> mainline Linux kernel.  However after removing the line 'rb-gpios =3D
> <&pioD 5 GPIO_ACTIVE_HIGH>;' from at91-sam9x60_curiosity.dts all data
> read from the flash appears to be zeros only.  (I did not add that
> line to the dts of my custom board first, this is how I stumbled over
> this.)
>=20
> I have no explanation for that behaviour, it should work without R/B#
> by reading the status register, maybe we investigate that
> in depth later.  However those all zeros data reads happens when
> reading the ONFI param page as well es data read from OOB/spare area
> later and I bet it's the same with usual data.
>=20
> This read error reveals a bug in nand_onfi_detect().  After setting
> up some things there's this for loop:
>=20
>     for (i =3D 0; i < ONFI_PARAM_PAGES; i++) {
>=20
> For i =3D 0 nand_read_param_page_op() is called and in my case all zeros
> are returned and thus the CRC calculated does not match the all zeros
> CRC read.  So the usual break on successful reading the first page is
> skipped and for reading the second page nand_change_read_column_op()
> is called.  I think that one always fails on this line:
>=20
>     if (offset_in_page + len > mtd->writesize + mtd->oobsize) {
>=20
> Those variables contain the following values:
>=20
>     offset_in_page: 256
>     len: 256
>     mtd->writesize: 0
>     mtd->oobsize: 0
>=20
> The condition is true and nand_change_read_column_op() returns with
> -EINVAL, because mtd->writesize and mtd->oobsize are not set yet in
> that code path.  Those are probably initialized later, maybe with
> parameters read from that ONFI param page?
>=20
> Returning with error from nand_change_read_column_op() leads to
> jumping out of nand_onfi_detect() early, and no ONFI param page is
> evaluated at all, although the second or third page could be intact.
>=20
> I guess this would also fail with any other reason for not matching
> CRCs in the first page, but I have not faulty NAND flash chip to
> confirm that.

Sorry for the time it took on my side.

Here is a link to another similar report:
https://lore.kernel.org/linux-mtd/DM6PR05MB4506554457CF95191A670BDEF7062@DM=
6PR05MB4506.namprd05.prod.outlook.com/
And here is a link to the series attempting to fix this:
https://lore.kernel.org/linux-mtd/20240507160546.130255-1-miquel.raynal@boo=
tlin.com/T/#t

Thanks,
Miqu=C3=A8l

