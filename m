Return-Path: <linux-kernel+bounces-180916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE398C74C6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D971F24A83
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6F6145346;
	Thu, 16 May 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hTqTdi7Q"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A7A143887
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715856253; cv=none; b=i0CsB3uugfT4qntIWTvJ+RdfVng/AN79UX3LorU4LR24JLVhN5t8mhEcYnqWpcyex2f1MaUwJL6kNChMEjy2Nl0yuCJuaNU//Om9y2n9yrme624hjDD/ed+ytHbNft2BcUX7Crkiw5JBBGw3lXXzLlXgUSVJBYzFkqwpmUgwFyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715856253; c=relaxed/simple;
	bh=g/yESgsrRvAbvwdU/jMz8g/5rzF9A1K3upemEo28IrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+j2eYTy7eXQVrzgZ0gaqWKIF+hpW4LYMxbWl95bop/7Q724X1r8cqQin71xc1NJy1tqOrZ/RBt9n9Facms8JKeyiaOv41AmykrUFJVR6kma2OB4MR9/VNk/FJ7nRV1hueX6OzOmjEf29dNux7up1LpvkSW1O+oL3gZYOHbmZg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hTqTdi7Q; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C21BA2000C;
	Thu, 16 May 2024 10:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715856247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZxMRCr3U247a7pzMzNRUdfjSJgipOrsTt2uVfBhf68=;
	b=hTqTdi7QxnvGDshjF8nWfXQNLwDQmsGSL1oITzxcohjcutOMjL9tOqCc8LbCkoI77zLpRW
	TH3MqQ1siOOJ42oiSxkjZPINO9M4WcKIdXjlFBalLKIm96+7Nh170n17WJiBaNXq/u9AMv
	ilPCD9YqK5KWOioBu9eHkJhrQslVSvlslx0eUB7nXeYN/2vYOUrboTpbwvq/quIQOCfp5n
	geB9kozgnFUIhGejHyquYAGoOvJRpcUYe0d7fOr7szFMjX87Qtn6yXO7amIiCq7L808xlM
	ne3Gx10WLUWcdVH1n+O+lf/+8OE/NE2qrZb210fBO6wNV2L1YbzAR85AHxONRQ==
Date: Thu, 16 May 2024 12:44:05 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mtd: nand: mxc_nand: implement exec_op
Message-ID: <20240516124405.2da1aa23@xps-13>
In-Reply-To: <ZkXfJ6n-06YqOr39@pengutronix.de>
References: <20240514-mtd-nand-mxc-nand-exec-op-v3-0-3e6f45fd3d82@pengutronix.de>
	<20240514-mtd-nand-mxc-nand-exec-op-v3-2-3e6f45fd3d82@pengutronix.de>
	<20240516103214.57a8ce33@xps-13>
	<ZkXfJ6n-06YqOr39@pengutronix.de>
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

Hi Sascha,

s.hauer@pengutronix.de wrote on Thu, 16 May 2024 12:25:43 +0200:

> On Thu, May 16, 2024 at 10:32:14AM +0200, Miquel Raynal wrote:
> > Hi Sascha,
> >  =20
> > > +static const struct nand_op_parser mxcnd_op_parser =3D NAND_OP_PARSE=
R(
> > > +	NAND_OP_PARSER_PATTERN(mxcnd_do_exec_op,
> > > +			       NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > > +			       NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
> > > +			       NAND_OP_PARSER_PAT_CMD_ELEM(true),
> > > +			       NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
> > > +			       NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, MAX_DATA_SIZE)), =20
> >=20
> > CMD, ADDR, CMD, DATA is the RNDOUT pattern. So it is now working fine? =
=20
>=20
> Yes, RNDOUT is working now.

Excellent!

> > Or did you forget to adapt the patterns to your use case? =20
>=20
> Although it looks like the patterns from the pl35x-nand-controller.c,
> there is one slight difference. The 'false' in the NAND_OP_PARSER_PAT_CMD=
_ELEM
> above has the effect that a plain NAND_OP_PARSER_PAT_DATA_IN_ELEM is
> disallowed.

I'm not sure I follow, the above pattern means: a single command cycle
is supported, no?

Miqu=C3=A8l

