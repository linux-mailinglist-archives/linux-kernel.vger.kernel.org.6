Return-Path: <linux-kernel+bounces-180773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 514738C72E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0EC7B23664
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AFD1411C8;
	Thu, 16 May 2024 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pboRvf7p"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6888FEAD7
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848414; cv=none; b=Rv8FliWbJ4so0ci3Yx8P4qxkwDSR5TeDeXNzC4V2vmZeiiTdhcy/es1TiuJ5fTpHrUo7MBUuaHB6ZXAhUBUJSyFuHfJeJVqRb5unJmwy8F39/HSzPIGQQYYXqb1UkhfKVDOa35fLy3YRdCydsNU/m3PnYBEYK2A2q068Zq5aGiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848414; c=relaxed/simple;
	bh=ODLQOu/zyz06Cszyocvh1VE4KNZojV2wsikA0IFDyTE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4FFwicR8naILVTMsKx1aCyFilvaHoKWULNt37g1M34woKTUI2lVHr89N6AHMDwU4d0a9bBWtDZ0cA8kDil8ADgcPD/5t7QyS9FG1nW9PiE612i7VtRbl7djFsjtNuNmgXJ0y2FMM6We9O0ZOmA3BFVh/80JaQph9bqUbtAwGps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pboRvf7p; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67DA62000A;
	Thu, 16 May 2024 08:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715848405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlCEWWB6cFyweBKAuWpYX1M2Skf3YxIZvcOY5o0N+rQ=;
	b=pboRvf7pkvdGdjXae92hHGo9tJTRMHWN9xy3c+Cz2JPV4eki+saN8Qs7fe92e4GhLWe7Ml
	s8DFAd3QtBYQC7V3WKAYSdHABuyXqD68XCtX02GulT0t2g4oIWL2JYbCrH7TjsVKALc9SE
	Lcdk3eJBSuVSAqFJmM1T+quTxBEJxBE8VfZG0T+gKhIWFbPkSnfwIZJx739gBV48xZd1oe
	YxrJPOjsgSrjncNRiXYS18WHiZeRCABkqz/Xso74kb3RJnDQg0GBQ1ZFKmHGbdymtksFDN
	4j5k/15QSBUvOWgKsWN7H9t/cHslvk0WStO4TROagBjHIB/ayPHf+ygcSopprA==
Date: Thu, 16 May 2024 10:33:21 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mtd: nand: mxc_nand: support software ECC
Message-ID: <20240516103321.25b49576@xps-13>
In-Reply-To: <ZkRyTT7FcDQ-5UeV@pengutronix.de>
References: <20240514-mtd-nand-mxc-nand-exec-op-v3-0-3e6f45fd3d82@pengutronix.de>
	<20240514-mtd-nand-mxc-nand-exec-op-v3-3-3e6f45fd3d82@pengutronix.de>
	<ZkRyTT7FcDQ-5UeV@pengutronix.de>
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

> > +	/*
> > +	 * During a page write the i.MX NAND controller will read 512b from
> > +	 * main_area0 SRAM, then oob_per_subpage bytes from spare0 SRAM, then
> > +	 * 512b from main_area1 SRAM and so on until the full page is written.
> > +	 * For software ECC we want to have a 1:1 mapping between the raw page
> > +	 * data on the NAND chip and the view of the NAND core. This is
> > +	 * necessary to make the NAND_CMD_RNDOUT read the data it expects.
> > +	 * To accomplish this we have to write the data in the order the cont=
roller
> > +	 * reads it. This is reversed in copy_page_from_sram() below.
> > +	 */
> > +	for (i =3D 0; i < no_subpages; i++) {
> > +		memcpy16_toio(host->main_area0 + i * 512, buf, 512);
> > +		buf +=3D 512;
> > +
> > +		memcpy16_toio(host->spare0 + i * host->devtype_data->spare_len, buf,
> > +			      oob_per_subpage);
> > +		buf +=3D oob_per_subpage;
> > +	}
> > +} =20
>=20
> I noticed the nandbiterr test won't work with this. It needs the following
> fixup. The problem is that the core wants to write only user data
> without OOB, so we have to make sure the remaining SRAM is filled up
> with 0xff.

Yes. I looked rapidly at the diff, looks ok.

Thanks,
Miqu=C3=A8l

