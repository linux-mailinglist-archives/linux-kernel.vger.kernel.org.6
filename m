Return-Path: <linux-kernel+bounces-299301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B11195D281
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A5B1F21A83
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0182618BBB3;
	Fri, 23 Aug 2024 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EG86GZU8"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CBD18B48B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429375; cv=none; b=asABBI2T09XXXF+A3vg9ibJXS6HaUU6FOPM31jDEEukGQ7qZG5jMKc8NwJhNUn9/ofdQdN43X444W+GcsLSqXEpkO5sYarVS+8l9a9SLJ49mAgFZimLCCZZRiNQz2fd3XKrsjsg+x0/fe1+EuO9R4MEt+zjY0QFRfDRK6xngROk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429375; c=relaxed/simple;
	bh=z64FZ1j6OPEPeiiKB25Vf7H+lP4DOc3L3uQzIF5cTKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szLaSbB79QsSXI27zFVgqTDQX0J1FFj7Rg2tMynojk6oaR7ji+0nfTwAjlH9Q1kOcSqfjx3JxLy0RyzPPJFSs2a1zrHdj7Ph9/kMwA4YqJyLF2K1pIXB1oJ+rIq7iaDFiEqTjyh3BJEFrlWj+UhsU2NJya7rTzG7haTttQsdI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EG86GZU8; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5AFFA240002;
	Fri, 23 Aug 2024 16:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724429372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeuSl37/iApskwDoU0vPraEr6H3pZSJWvsWyeFNba0c=;
	b=EG86GZU8KwY56glgKC1utITAiLHpseyVvs34JehlRrbSq72hqbXW3n0MVPCqMaPwNYuDRV
	dDUFBWyBVj1+3L3adUCmnhfme39XyOelSc7E6MQQuqxCpn0vNoRC+5wixafg95xzlnnxM3
	DcFsfy8vh9I7tVLHMsYeevn3wdBHB+x0S6Vnzb3Qzez0kbYwHEFOtuul/fo8ToECmk2k4q
	NY0TGt5HnCMWZiOJfAeikyHMD1WSHCfz8JN4AFFe1qRkaGO4vS4yIyZuVNNglb3hsTOuzL
	bkjlmgDnZY412nfYzrIUiIzWlX9lmTdF4RY2vh9laWz6CHN3vZNtlp5Eo0+WcQ==
Date: Fri, 23 Aug 2024 18:09:30 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Parshuram Thombare <pthombar@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Boris Brezillon
 <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Conor Culhane
 <conor.culhane@silvaco.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 06/11] i3c: master: svc: use repeat start when IBI
 WIN happens
Message-ID: <20240823180930.5fa341d3@xps-13>
In-Reply-To: <20240819-i3c_fix-v3-6-7d69f7b0a05e@nxp.com>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
	<20240819-i3c_fix-v3-6-7d69f7b0a05e@nxp.com>
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

Frank.Li@nxp.com wrote on Mon, 19 Aug 2024 12:02:00 -0400:

> There is a possibility of an IBI WIN occurring when addressing issues, ev=
en
> when sending CCC commands. Most of the time, returning -EAGAIN is
> acceptable, but the case below becomes highly complex.
>=20
> When a Hotjoin event occurs:
> - i3c_master_do_daa()
>   - i3c_master_add_i3c_dev_locked()
>     - A dynamic address (e.g., 0x9) is already set during DAA.
>     - i3c_master_getpid_locked()
>       - Another device issues HJ or IBI here. Returning -EAGAIN causes
>         failure in adding the new device. However, the dynamic address(0x=
9)
>         has already been assigned to this device. If another device issues
>         HJ, it will get this address 0x9 again, causing two devices on the
>         bus to use the same dynamic address 0x9.
>       - Attempting to send RSTDAA when the first device fails at
>         i3c_master_getpid_locked() could also fail when sending RSTDAA for
>         the same reason.
>=20
> According to the I3C spec, address arbitration only happens at START, nev=
er
> at REPEAT start. Using repeat start when an IBI WIN occurs simplifies this
> case, as i3c_master_getpid_locked() will not return an error when another
> device tries to send HJ or IBI.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Feels sensible.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

