Return-Path: <linux-kernel+bounces-250633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE17892FA40
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AB77B20F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A20B16E86B;
	Fri, 12 Jul 2024 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="V5PMfiYd"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743ED15B96F;
	Fri, 12 Jul 2024 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720787236; cv=none; b=tHJvSsDdim2kuE6TcdEEi1iq7WV7FrjuOdCJJGap73pw5XI/8BHbicrmyoAMgi6VE0KdkfaAQT7wrSpkquvpyRfeUgyERN8rH8Zs3OJKtKcdpK0wktRR9KNoAdLMSO9DijaxPqXxpOm5gpGy4i06vGvQoBnsGDbh5KxGDqfLLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720787236; c=relaxed/simple;
	bh=VFfujqGL4wmufeMpy4TXsgO2rW52SRPoW3j+ev/iI60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JvhSUY9gOCPPMk6g1cZkoBPwOUyaVGZX8R2rp0RO009yHUl0+j4Oa+6vPhBDiZVjItOo0UzMQl46cOkSXrDu/MZyRj/s0GiF3RLyNyN7ZPD6LGGYxHH+a4ftzoZG0Wp5/guuNoXZt+kGAj2tp18srVEPQ38KIuUytFpCkm+oXvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=V5PMfiYd; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1720787233;
	bh=4Vofh3nmGXbIRlscqKm0va6vapnmleNLgiTWfYE/btk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V5PMfiYdHjm+q2zhG//PSDhbZxYuVaB/yWMCbKSb7YOZfB+YWffV8XUiFqmdJ+g+g
	 /c6au7q5mVyEiJqj/pof4+FidWHw+Du77hF2RZBUglRFE//ThOFJQoTQqe6IUDIms0
	 EJtVxRE/YpKncLPLY3tEkgutqHapFx9r3ZbshogxWBeGW6TCDCrXR4R0Buv6MKHije
	 KTpMYbXdOCztwkqQk6lsuRJIWQqLg3eSog71GgUac4/5NigrRoqMUh20HyBAIopkIP
	 3nRohakxnY0DT2cFAWUh7IiAjkavAFL6SZk+7SHz47UD7rpIBs0rGhqqwLOIEu+Cdo
	 m8oeN6kVZK6ZA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WL9p73qQHz4x1V;
	Fri, 12 Jul 2024 22:27:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>, Mark Brown
 <broonie@kernel.org>, Herve Codina <herve.codina@bootlin.com>, Arnd
 Bergmann <arnd@arndb.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin
 Chen <nicoleotsuka@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 07/10] soc: fsl: cpm1: qmc: Introduce functions to
 get a channel from a phandle list
In-Reply-To: <9423930f-8cb8-4b31-927f-a93b1006fb18@cs-soprasteria.com>
References: <20240701113038.55144-1-herve.codina@bootlin.com>
 <20240701113038.55144-8-herve.codina@bootlin.com>
 <a8c44188-d5d8-445d-9d64-bbfce6b1b628@sirena.org.uk>
 <87a5ixkghq.fsf@mail.lhotse>
 <9423930f-8cb8-4b31-927f-a93b1006fb18@cs-soprasteria.com>
Date: Fri, 12 Jul 2024 22:27:11 +1000
Message-ID: <87v81a4wyo.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

LEROY Christophe <christophe.leroy2@cs-soprasteria.com> writes:
> Le 04/07/2024 =C3=A0 05:01, Michael Ellerman a =C3=A9crit=C2=A0:
>> Mark Brown <broonie@kernel.org> writes:
>>> On Mon, Jul 01, 2024 at 01:30:34PM +0200, Herve Codina wrote:
>>>> qmc_chan_get_byphandle() and the resource managed version retrieve a
>>>> channel from a simple phandle.
>>>>
>>>> Extend the API and introduce qmc_chan_get_byphandles_index() and the
>>>> resource managed version in order to retrieve a channel from a phandle
>>>> list using the provided index to identify the phandle in the list.
>>>
>>> These two PowerPC patches seem trivial enough and have got no response,
>>> unless someone objects I'll go ahead and apply them.
>>=20
>> Ack.
>>=20
>> MAINTAINERS says:
>>=20
>> FREESCALE QUICC ENGINE LIBRARY
>> M:      Qiang Zhao <qiang.zhao@nxp.com>
>> L:      linuxppc-dev@lists.ozlabs.org
>> S:      Maintained
>> F:      drivers/soc/fsl/qe/
>> F:      include/soc/fsl/qe/
>>=20
>> But I see no email from that address since January 2021:
>>=20
>>    https://lore.kernel.org/all/?q=3Df%3Aqiang.zhao%40nxp.com
>>=20
>> And actually drivers/soc/fsl was marked orphan in April, maybe this
>> should be also.
>>=20
>> Or does Herve want to take over maintaining it?
>
> We had some discussion about that in April, see=20
> https://lore.kernel.org/linuxppc-dev/20240219153016.ntltc76bphwrv6hn@skbu=
f/T/#mf6d4a5eef79e8eae7ae0456a2794c01e630a6756
>
> Herv=C3=A9 has some of our hardware for a limited period of time because =
he=20
> is doing some implementation for us, but he won't keep that hardware on=20
> the long run.
>
> I will send a patch to take over maintaining drivers/soc/fsl/

Thanks.

cheers

