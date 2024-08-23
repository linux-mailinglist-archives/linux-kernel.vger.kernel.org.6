Return-Path: <linux-kernel+bounces-299298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EFF95D274
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9854C1C22904
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E677C1898F4;
	Fri, 23 Aug 2024 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Dgm5Cm6x"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF1E18A94F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429279; cv=none; b=GNM00ZAWhGs9cOpvj9gwy79vYEdbwmooYsby9Yy1qJkUAhWrxYyOdWw3djmMWabsKEfA+lexoHBP+qDPnsASjMNopS5ltbNBSu0xVY28JNNInVfslPXG8MlZ2SpgSmONh04JXQpXJhCQMxe5u+URiVvatCyeyHcUpEwqgUQ1ySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429279; c=relaxed/simple;
	bh=sNaaNQ/c24bdVJagTjKVRWg9WZYK/I0wxHYag+EjGmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfXEUTARJNEpruWCXJRuBCstmKAUzDY+4kdCZBlXNydnyCJ0iwN9jeT4lwRK/hmmOjGP1yaI2OuHLqoN3xoMy1Sl2QX8L8IvArS4jPKx3H0ZKCi/e0NLxdL+/Uk4zbknQcswt9fkY287JRvGlGANOMu5LhsxxJwZK1EF5y1qaC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Dgm5Cm6x; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C0CD20002;
	Fri, 23 Aug 2024 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724429270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkpQSxHJZJqJ2ia8bscC51GsZfukDOspvZw0hSmkj7I=;
	b=Dgm5Cm6xNKaLcZIvGyNCJhLF3wwiZDgbr0yXlLVcfEZHkHrNa25qhugDv0x9LBZYKpUxnr
	j3hRqCfc6lMgl4OY4sv/xsVxJ/Qnu9D9zaqYBawxOuvnCkZbQeOIKk8ubHGkjoFkblYCqS
	x0qPeutSq8kx96v5k1pK7sL6pqBZzY6LbOjk1vLT11l+j9YPDM4w5o3lL4jrzwaLqymzTG
	/xdmC2SodHqICI4m3hUrCtdN6vS+DyRFHElxCfkeCUkZws4neHG7nav3i5bNjueZYbTm6u
	qmMr/C01ePFjDfCZcDnT69g47EXny67hKBiKn45oOnsQgpcFw5ZMiZ0fCoId0w==
Date: Fri, 23 Aug 2024 18:07:47 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Parshuram Thombare <pthombar@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Boris Brezillon
 <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Conor Culhane
 <conor.culhane@silvaco.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, stable@kernel.org
Subject: Re: [PATCH v3 05/11] i3c: master: Fix miss free init_dyn_addr at
 i3c_master_put_i3c_addrs()
Message-ID: <20240823180747.44fd0ec8@xps-13>
In-Reply-To: <20240819-i3c_fix-v3-5-7d69f7b0a05e@nxp.com>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
	<20240819-i3c_fix-v3-5-7d69f7b0a05e@nxp.com>
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

Frank.Li@nxp.com wrote on Mon, 19 Aug 2024 12:01:59 -0400:

> if (dev->boardinfo && dev->boardinfo->init_dyn_addr)
>                                       ^^^ here check "init_dyn_addr"
> 	i3c_bus_set_addr_slot_status(&master->bus, dev->info.dyn_addr, ...)
> 						             ^^^^
> 							free "dyn_addr"
> Fix typo "dyn_addr" by replacing it with "init_dyn_addr".

Maybe you can mention it's a copy/paste error, which makes the diff
-when looking at the previous lines- obvious.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

