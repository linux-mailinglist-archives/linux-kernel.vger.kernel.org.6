Return-Path: <linux-kernel+bounces-374051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6EA9A612C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD96A2839BA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ED61E9062;
	Mon, 21 Oct 2024 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kRja9ykd"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54531E883D
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504980; cv=none; b=CmimRpALuLAItWknx0rq08QQxOJVx82zohtIwMh2z6MXRHGpflqOMcuw1hUfRBNqmC1VJXsza2AYhQSiLlfTMtzsYS07TMoLhKLe5B3jZl7jspSITAbvkN1tVr8ZYE8Rua+ql4a/ifv8kRU8pIvF3FSE93rYFnZr/JcCuqRrvRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504980; c=relaxed/simple;
	bh=ZmsvbknYlJuPvOXnF3QiE3GyCq5nadSL7dqnim41P4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKttsEJv3YCxpTgyYrTEcqC4z+AGrPeF7Fzzwf3PG02QziB2lbG3GeHb0WqcPznse3MXQp0JrPuPR0oXyj6YfmDoDtpB90axS2K96X4Rg5agqZbnWA+nRZ60vfo9AR9iYWJTwlyKE88tli8tfJhEmBSveGVDOWRbcJlyBHkGDqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kRja9ykd; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CBF6EE000B;
	Mon, 21 Oct 2024 10:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729504976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8hHCgpoOkTMwA30aYC+/MsqUIFcDcJbYYJ8xXVx8LI=;
	b=kRja9ykd6cIbvf6QthwtRvEHQaKfbfvmWw8WvqI6LyO+sbMQj9TRtgD5LyfLRPlhIzbq18
	PwNa9q94GbmGDXLh7L51Gg33NWGlBapWHaSJGka8wCmWmPf4zhzUC8UbrkpsEgc4RSfKaM
	T7XpI2nvSQRjiVfUf4tqIEUMlUF9kYWCpqttMAOdzrB/DwfJwz1WNHXUad/WiYjKRiMEVa
	csVJPCVfHScjgDi6lhpuM4HmcLfYM1w7LyZaqoVFYoBlnmjmWYWbX6RfUqgox48ozvQb1V
	fxZR9f7LjAKtLvcSiqFydU/1Fc1fWaHEMSZ1FkUWYZCp2oovaL87OX7oAX9uDA==
Date: Mon, 21 Oct 2024 12:02:54 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
 bbrezillon@kernel.org, boris.brezillon@collabora.com,
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev,
 pthombar@cadence.com, ravindra.yashvant.shinde@nxp.com
Subject: Re: [PATCH v7 2/3] i3c: master: Extend address status bit to 4 and
 add I3C_ADDR_SLOT_EXT_DESIRED
Message-ID: <20241021120254.76831170@xps-13>
In-Reply-To: <20241008-i3c_dts_assign-v7-2-96ec93d1f34c@nxp.com>
References: <20241008-i3c_dts_assign-v7-0-96ec93d1f34c@nxp.com>
	<20241008-i3c_dts_assign-v7-2-96ec93d1f34c@nxp.com>
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

Frank.Li@nxp.com wrote on Tue, 08 Oct 2024 11:18:25 -0400:

> Extend the address status bit to 4 and introduce the
> I3C_ADDR_SLOT_EXT_DESIRED macro to indicate that a device prefers a
> specific address. This is generally set by the 'assigned-address' in the
> device tree source (dts) file.
>=20
>  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>  =E2=94=82S/Sr=E2=94=82 7'h7E RnW=3D0 =E2=94=82ACK=E2=94=82 ENTDAA  =E2=
=94=82 T =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=98    =E2=94=82
>  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=98
>  =E2=94=82  =E2=94=8C=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>  =E2=94=94=E2=94=80=E2=96=BA=E2=94=82Sr=E2=94=827'h7E RnW=3D1  =E2=94=82A=
CK=E2=94=8248bit UID BCR DCR=E2=94=82Assign 7bit Addr=E2=94=82PAR=E2=94=82 =
ACK/NACK=E2=94=82
>     =E2=94=94=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=
=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>=20
> Some master controllers (such as HCI) need to prepare the entire above
> transaction before sending it out to the I3C bus. This means that a 7-bit
> dynamic address needs to be allocated before knowing the target device's
> UID information.
>=20
> However, some I3C targets may request specific addresses (called as
> "init_dyn_addr"), which is typically specified by the DT-'s
> assigned-address property. Lower addresses having higher IBI priority. If
> it is available, i3c_bus_get_free_addr() preferably return a free address
> that is not in the list of desired addresses (called as "init_dyn_addr").
> This allows the device with the "init_dyn_addr" to switch to its
> "init_dyn_addr" when it hot-joins the I3C bus. Otherwise, if the
> "init_dyn_addr" is already in use by another I3C device, the target device
> will not be able to switch to its desired address.
>=20
> If the previous step fails, fallback returning one of the remaining
> unassigned address, regardless of its state in the desired list.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

