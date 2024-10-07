Return-Path: <linux-kernel+bounces-352994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66852992709
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80E51F2313C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8424018BB83;
	Mon,  7 Oct 2024 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bktzmFqT"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D78238F97
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290016; cv=none; b=PIL0qsF97RWq9uIibeBogsL0KG1fCNXky/Qoyi8ZBdOO4rIYbncR9rivNN9Pz/shXXr5EuIYKskvuJY0OureO6JI64ris3GOgKwnOcx/47xfQHaAu5uOpw3ZTyVgEgQK+EMOJh51uKynE1Awgxydke2puUWkereJccXcr5fdgUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290016; c=relaxed/simple;
	bh=I3yOEZenWkVQVPnxoJZr6ij1cMZ6b0wzVjWF0WoH5T0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMXCstNpIBOfJEr8ycnublo/LYrRU6ngiLgVtpqrL11gvkv8rQQPNb4nOIgPaliStmOGtaDnxS8rfFrTE9PaOmc1UVRiE5d7d9KQA6GaAxFs6b/GWa31z70QBKLnUyoRPfuEOqmED8hOI9/uap10evwzt0TlzmlXuPj9c/gaeNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bktzmFqT; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC6F7C0011;
	Mon,  7 Oct 2024 08:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728290012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Hv+QF0dRJ2k6EVk0uFwLfeCUGUaSBoGwqxeMLRcXqM=;
	b=bktzmFqTG68wWf6m+vXzP+JSjNzZ+mXk5kzyTR/41+OPoM/mmSsY2JOvGZdaB9OxkRvv4m
	q6+oEHbiItdYhgZ/yzkPI9ylG9C4yUqxC7/ZLfN7b6nwB+ljdenrbQAdOX/CUlyNh4w/6M
	h981bvc416/DtUOP6iqlqdb4Ys3kXSFc+EXFpa8uWq+qd9Hwb+xK/SYIY1GTtHAaznFgRs
	i7alzKAiRiyQ7zffIhVdhhW3bzvxRQ/DTqd/MQSgx7mskRNriIGhRv3d2F1Yhh+maoM8Z0
	HP3hKDFCiRzQUuixdPFTNd1tsf1J5quizzhBFRu5oJbinmonMyPAI572XPVl4Q==
Date: Mon, 7 Oct 2024 10:33:31 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw,
 leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH 1/2] mtd: spi-nand: Add fixups for read retry
Message-ID: <20241007103331.55f37dcb@xps-13>
In-Reply-To: <CAAyq3SbP4kSW47ZaT7V9ZzeHauj_EwfU5GPipZjNK6j69qm7Vw@mail.gmail.com>
References: <20240905055333.2363358-1-linchengming884@gmail.com>
	<20240905055333.2363358-2-linchengming884@gmail.com>
	<20241001114039.67bab21e@xps-13>
	<CAAyq3SbP4kSW47ZaT7V9ZzeHauj_EwfU5GPipZjNK6j69qm7Vw@mail.gmail.com>
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

Hi Cheng Ming,

> > > @@ -325,7 +373,8 @@ static const struct spinand_info macronix_spinand=
_table[] =3D {
> > >                                             &update_cache_variants),
> > >                    SPINAND_HAS_QE_BIT,
> > >                    SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> > > -                                  mx35lf1ge4ab_ecc_get_status)),
> > > +                                  mx35lf1ge4ab_ecc_get_status),
> > > +                  SPINAND_FIXUPS(&read_retry_fixups)),
> > >       SPINAND_INFO("MX35UF1GE4AC",
> > >                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x9=
2, 0x01),
> > >                    NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1), =
=20
> >
> > I expect a patch targeting the core first, and then the changes in the
> > Macronix driver. =20
>=20
> Got it, so do you prefer that we switch to using flags instead?

Not necessarily, did I?

...

> > >       const struct spinand_manufacturer *manufacturer;
> > >       void *priv;
> > > +     int read_retries; =20
> >
> > Any reason to keep this variable signed? =20
>=20
> No, we can simply change from int to u8.

Just unsigned int is fine.

Thanks,
Miqu=C3=A8l

