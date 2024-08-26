Return-Path: <linux-kernel+bounces-300995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC4795EB5F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABCB2823DB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A3512CDAE;
	Mon, 26 Aug 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bYohC2yK"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFCE8837
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659551; cv=none; b=bZkISI5ssK1d15tU4q8MANZxsaQY5hfyS9jj9VvFx68GDVfQ5S+7dloTNAoh+TlMI5quNOiX53VXwKAEwHY2sEKL6st6wlGIqEhHXbPhccrnvtVCVruSkPg6oHez21J2kD0i+xakx8vPhUuVl0C3r96j1xK2FqNcE7pyS9x+ZtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659551; c=relaxed/simple;
	bh=CUfynww9JqKqKGzCXlxZMuLsQyJsqzi9oRVn77PikaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEX9ZnyNrEFIiq1USqI15r5JDPQVXQD+ztgjzXUfGlcEuhQGXqTrkxSkfGFH7547tqOLngN2NhyOXGNmLZ1P0cVS34Jkpbj9R1bhZuWx6yzeukF2t70w8grUrkdwqztIvEV7FmcdKI0XNG5K4UaAIw+yiOSeuJkDEuHdBDpujXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bYohC2yK; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D470C0005;
	Mon, 26 Aug 2024 08:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724659542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUfynww9JqKqKGzCXlxZMuLsQyJsqzi9oRVn77PikaQ=;
	b=bYohC2yKZ1VYQb5LTct07W1+fzs/2zjlzCi6uIJoDBmsBf/MISkSxNzErDxwEExxo9wotR
	LnLrP4smxQxp4r3i2QtIPswcdXKr1LoymeddrDX6ui8kIk48yZBeis4FHxJVZKLu26ksqA
	7DCPB/FW7QmlyKZcMNfsdY32D8GZyplRcd350vOoP8Wd9PSRF3Amn7CLogypaYUptT51qI
	ovFrvEZCSETg2GD0TN5xZaIWmm4oRCuXuF1LFSC2epjxTMZgg/Ms/UZmBES86jSCV7J25L
	cT5mlCdsxN/UATefV8KbNnZULfACCWACRSq7MPhNhBbUaj+GAS41McFI8CVMeg==
Date: Mon, 26 Aug 2024 10:05:39 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Parshuram Thombare <pthombar@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Boris Brezillon
 <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Conor Culhane
 <conor.culhane@silvaco.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 02/11] i3c: master: Replace hard code 2 with macro
 I3C_ADDR_SLOT_BITS
Message-ID: <20240826100539.7f93f8b9@xps-13>
In-Reply-To: <ZsjNi4RQ+GKxZpUH@lizhi-Precision-Tower-5810>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
	<20240819-i3c_fix-v3-2-7d69f7b0a05e@nxp.com>
	<20240823175502.3d518a69@xps-13>
	<ZsjNi4RQ+GKxZpUH@lizhi-Precision-Tower-5810>
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

Frank.li@nxp.com wrote on Fri, 23 Aug 2024 13:57:31 -0400:

> On Fri, Aug 23, 2024 at 05:55:02PM +0200, Miquel Raynal wrote:
> > Hi Frank,
> >
> > Frank.Li@nxp.com wrote on Mon, 19 Aug 2024 12:01:56 -0400:
> > =20
> > > Replace the hardcoded value 2, which indicates 2 bits for I3C address
> > > status, with the predefined macro I3C_ADDR_SLOT_BITS. =20
> >
> > I'm fine with the idea but I don't understand the macro name. You're
> > talking about status bits and yet the macro is named addr_slot?
> > =20
>=20
> How about I3C_ADDR_SLOT_STATUS_BITS ?
>=20
> > > Improve maintainability and extensibility of the code. =20

I'm a bit flaky on this concept, but let's try that. Perhaps with all
the changes requested (esp. rephrasing) it might become clearer in next
version.

Thanks,
Miqu=C3=A8l

