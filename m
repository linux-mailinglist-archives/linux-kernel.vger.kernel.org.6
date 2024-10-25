Return-Path: <linux-kernel+bounces-381840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C57F9B052D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068E31F24582
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95981859;
	Fri, 25 Oct 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VHLjaCFA"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA1E18E76C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865433; cv=none; b=kvsfkuEuoCNQaqRkGx98oFJSS4nElYr3LG0V6uBxBNDAAoq6QXj3vJD0hH2e2VxnXiunuHS8nxpIXcW3FPkWOZuueBRrtlLmt87xsMMDPwEBmeOtn0rL1kkZKyWckQJH3P3fq5cSR799ecJkI83YzZTyT9CiTW/UsNNDTT4T00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865433; c=relaxed/simple;
	bh=UNZphZRiAU7HwBE54GXF6AQmf4CgwHYIZ6gfOVxLRws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXlD0YBDpJequJOIITWOHNVraAc6/8LFoMsfh42FvmFOL1pTiwAhkHGW4hNQ0KvIXHj8p2nU6ZlTSGcSvZUs9ysVDzjiDTS9R5AEzYlBWir5+LVUcyghbw4R0w8gQnFUuIsLYJPhaCu4gOXvMpLJK5SqjvaQ9SekyV2B1OYWM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VHLjaCFA; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B29924000A;
	Fri, 25 Oct 2024 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729865423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNZphZRiAU7HwBE54GXF6AQmf4CgwHYIZ6gfOVxLRws=;
	b=VHLjaCFAEFG+cxatoXyaUlHYx/dlKo12fKFbWCMcrp4s8PokLQddoLf19eKvZcG1GfpjDD
	JHkqYksUil83JkRe6MVgJTa35SRjUPk9c463407JhjNbfY8dMhjHujIRT7AdOYWCVZWEJV
	uKpdRvFtqNHjsiSdZSmYKaN2Xc61fKdDHD8CmqTDENoszI2ZHTe4iXkVw4KlCU9prPeUyS
	nsWZ3OHPNfHApIv6cbgsD72uwNOxfCWyf0x/MWEHpXa1v/pVLXH/wq3hbVx69ILhanfEHU
	DPK4I3q/pTlNEFjo4PzYG2eMP7biMBhtTDW8OG/U4VqIs6DX7Sfkze3ORNB2RQ==
Date: Fri, 25 Oct 2024 16:10:20 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Conor Culhane <conor.culhane@silvaco.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Clark Wang <xiaoning.wang@nxp.com>,
 "moderated list:SILVACO I3C DUAL-ROLE MASTER"
 <linux-i3c@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>,
 imx@lists.linux.dev
Subject: Re: [PATCH 1/1] i3c: master: svc: Modify enabled_events bit 7:0 to
 act as IBI enable counter
Message-ID: <20241025161020.11765f79@xps-13>
In-Reply-To: <ZxukksXwyWN2HQ3I@lizhi-Precision-Tower-5810>
References: <20241024203855.1584416-1-Frank.Li@nxp.com>
	<20241025095318.4785df2c@xps-13>
	<ZxukksXwyWN2HQ3I@lizhi-Precision-Tower-5810>
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

Hi Frank,

Frank.li@nxp.com wrote on Fri, 25 Oct 2024 10:00:50 -0400:

> On Fri, Oct 25, 2024 at 09:53:18AM +0200, Miquel Raynal wrote:
> > Hi Frank,
> >
> > Frank.Li@nxp.com wrote on Thu, 24 Oct 2024 16:38:55 -0400:
> > =20
> > > Fix issue where disabling IBI on one device disables the entire IBI
> > > interrupt. Modify bit 7:0 of enabled_events to serve as an IBI enable=
 =20
> >
> > Is this bitfield arbitrary?
> >
> > Is there a rationale behind it? =20
>=20
> Max devices number under a I3C bus is 128 because dynamic address is 7 bi=
t.
> So 8 bits for it should be enough.
>=20
> Bit31 as hotjoin, Bit30 reserved as control switch request.

Makes sense.

Thanks,
Miqu=C3=A8l

