Return-Path: <linux-kernel+bounces-373825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F03B9A5D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6325281EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD72D1E0B9F;
	Mon, 21 Oct 2024 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MLXcKR5y"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE251E0B7E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496437; cv=none; b=G8IykIkylVjCq3+SuNf2lqDEev3p5g8wwBHPTsTvRF5ge/SYW/X9osm5rICTePnmCsyGGkNr0HqOauI/a3TLYfZF2Jwy9T12MSztFU/rcLmLAWkRAdoasYCwTZbuQZdv8TY9chTAZwSXDGnc8l/ZyZg4MdVs63xZwI8CpK/3zBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496437; c=relaxed/simple;
	bh=Asrwsm8zwlwMCiUP5EbChP1RzR2jVUK8/9CWZ0z+nHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hy+AS/ELTfz2017bO6S1xet/clZ5rG/m4SCQTukhHNRYqs05UKieIOAC5kac/tlBnmRxKrRUSQ0BRR/SBSSriFnXjG/VRweCH4r2Tf0PRDOiv0bASom/T5pGUIHJZQq+sZQEqlgEEzAV8Siw8XXSPJIBWGS0XjsEqb4OQNp3EzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MLXcKR5y; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A8FA3FF804;
	Mon, 21 Oct 2024 07:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729496427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Asrwsm8zwlwMCiUP5EbChP1RzR2jVUK8/9CWZ0z+nHQ=;
	b=MLXcKR5ykn3Ts0iXIMhSUAQDpw0ANk/IPcVQJityqPx1s4Xi6mOGpvGXKESMP/coO97yTO
	KLi/RuDHzUPasteHvAc9AejXVn/3T/FsCtfjAHqPWZkRmqiaCImK9rIlgzhnbERGjbh8j5
	Vl5NVcfJazP/23+BnxVlY9hwO3w/fL9V3iNRTzwjGLVWvkl95xO6Q2/pLY/0i9vy+a7169
	D6omHOZ2QM2BKahW2azpv1kbvbkHI9SVXsKJZqIECZP4RMnzJnXi7nzZo2buqaiSjN4Tc5
	Sbqu3faKUUfJEDVy/3tqmv5r5R1yN4KgZYCs9XRxic7h2OcWMea97z4yX6jN6w==
Date: Mon, 21 Oct 2024 09:40:24 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bastien Curutchet <bastien.curutchet@bootlin.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/3] mtd: rawnand: davinci: order headers alphabetically
Message-ID: <20241021094024.6855b93c@xps-13>
In-Reply-To: <CAMRc=MeVQVeXdMTk-ZjabkEv58VN=2vchcy3LZ24pEwwN1DTpw@mail.gmail.com>
References: <20241007122350.75285-1-brgl@bgdev.pl>
	<CAMRc=MeVQVeXdMTk-ZjabkEv58VN=2vchcy3LZ24pEwwN1DTpw@mail.gmail.com>
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

Hi Bartosz,

brgl@bgdev.pl wrote on Mon, 21 Oct 2024 09:25:48 +0200:

> On Mon, Oct 7, 2024 at 2:24=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > For better readability, put all includes in alphabetical order.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---

...

>=20
> It's been two weeks so gentle ping.

The patches are good, I didn't took the time to queue them yet but I
plan on collecting all the pending patches (including yours) this week.

Sorry for the delay!
Miqu=C3=A8l

