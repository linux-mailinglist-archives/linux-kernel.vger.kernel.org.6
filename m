Return-Path: <linux-kernel+bounces-412550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D76839D0A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED7D282809
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3069149DF0;
	Mon, 18 Nov 2024 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZfzupOON"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E392907
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731915850; cv=none; b=dVCqwTpPQsZps/nNBDtFstGOVBsnkBMKVWzue2+cYfUT8bWClaeXPaGjhpboI4CwkdSKRzw7Rtav7nzy5Trrar8zGiRTjbuKOHsWQtXtaL3uR9eo+6oHkBPetWDJXLAHJrdTaTYi/hcKmSZ1H8oDt/rofYx+DAd4WTEID2VQ398=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731915850; c=relaxed/simple;
	bh=E3CMiUYu2bvv1tCd37NA4gHOkr2RtNbLkEOFHUdDTNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nsOwDPZZjrEFGVe4wAtMODRGfictJGO+7gZyu9Wr0lOIbeUfBhTtrM16RBh5y1lxTf1vVrTBInwQqpro3nvtPxhNQHgZ8xs4kDECtGPqSji8PvLIlhVp90GTOi9UXd80cIi6lVbRU6ySFmnAa8MJWXcM24yLL0RGRUufa4rywe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZfzupOON; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8B0740005;
	Mon, 18 Nov 2024 07:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731915839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3CMiUYu2bvv1tCd37NA4gHOkr2RtNbLkEOFHUdDTNc=;
	b=ZfzupOONtRGPTnZROD1WIjDGuDgAdDu2++Swv9aryXcoTtMho6B7ei2tplocpsR+XcWvJ8
	OoABZx4vHcdkU1h9KHAyCXAIyLLeC/YdED+4YR7EjyKc83WwKqbVJV9KN/C4Sf7Z3QJh+x
	o0xqXbXqrtEyTF0WhrXLjZa83mZ5Z0eEjDHuksHbeLPLtRGDt+hQ9c5Z91GVFvzSrmCdBH
	bufQqtJmgdOoS6CEsBWuoUDt7iX5OF1zuG4zIpjBAfuBsjqC6oIkMvW5xZ3/yF6rvii5Vz
	wxUDZayDchCyCaQfeNpxD2y6pHGtiVoHgyfpQt2TMUjifx4AQ/DGMXpijLaX+w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Chuanhong Guo <gch981213@gmail.com>
Cc: SkyLake Huang <SkyLake.Huang@mediatek.com>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "mmkurbanov@salutedevices.com" <mmkurbanov@salutedevices.com>,
  "kernel@sberdevices.ru" <kernel@sberdevices.ru>,  "d-gole@ti.com"
 <d-gole@ti.com>,  "dev@kicherer.org" <dev@kicherer.org>,
  "vigneshr@ti.com" <vigneshr@ti.com>,  "richard@nod.at" <richard@nod.at>
Subject: Re: [PATCH v2] mtd: spinand: add support for FORESEE F35SQA002G
In-Reply-To: <CAJsYDVLYE1=sAj5Pvni17xQ=4akFCA+UqtuB5RKq77HxL4ux9w@mail.gmail.com>
	(Chuanhong Guo's message of "Wed, 13 Nov 2024 18:10:20 +0800")
References: <20241108163455.885-1-SkyLake.Huang@mediatek.com>
	<20241108163455.885-4-SkyLake.Huang@mediatek.com>
	<dbdb45ed1135e73b4eebd76e6f61b96d48aaedc6.camel@mediatek.com>
	<87ikssu3qq.fsf@bootlin.com>
	<12f4d28f3efb7fe319ec919df92145c4ad24da01.camel@mediatek.com>
	<87h68bsdv6.fsf@bootlin.com>
	<CAJsYDVLYE1=sAj5Pvni17xQ=4akFCA+UqtuB5RKq77HxL4ux9w@mail.gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 18 Nov 2024 08:43:56 +0100
Message-ID: <87ttc5c7gj.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

> Several SPI-MEM controller don't allow software controlled CS, or for some
> other reasons are unable to execute a longer spi-mem op.
> spi_mem_dirmap_write returns the actual request size it's able to make,
> and spinand_write_to_cache_op use a while loop to split one update_cache
> request into multiple ones.
>
> This only works using the Random Program Load instruction (84h/34h)
> which preserves the previous written data in the flash data cache.
> All current supported flashes are exclusively using 84h/34h as the command
> to write the page cache.
>
> Load Program Data(02h/32h) will clear the entire page cache. As a
> result, when a request is split as described above, the previous written
> data will be cleared, breaking the page cache writing procedure.
>
> We can change write_to_cache_op to use Load Program Data on the
> first request. If that doesn't finish writing, use Random Program Load
> on subsequent data loading.

Sounds reasonable indeed, feel free to send a patch.

Thanks,
Miqu=C3=A8l

