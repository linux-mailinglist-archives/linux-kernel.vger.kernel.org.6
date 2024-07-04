Return-Path: <linux-kernel+bounces-240448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CFD926DC8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913B9281D73
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A991862F;
	Thu,  4 Jul 2024 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="qEQFNE4Z"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC121BC4E;
	Thu,  4 Jul 2024 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062096; cv=none; b=DnpqS3wobaceYytWgxkl1ShHiv1mW7WuU+WypCmc6qaYe9fA2z162RSxNBDoMMdBdJ5Swh0PbdD5fid8HewyKt7V+6HjTpgarG8ou13hy2kHUiVjxTsdgRdxrWoHnxifJFwnetCQy+zG8ENMwW70onJz0MeN//wYM8xNc5FellM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062096; c=relaxed/simple;
	bh=OIA5yriB8wNlAP+DgoZyr3J7vXU9nqssuvqToMPG4J8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tK1k50TciwT2T2aXPHieyvYuPIpzdCyNJB4rkfsvhy7OEV9S1mwqrT2WhDHw7+vv7evAV1SIo1683pkN6vIXLiTu/MAnw1wKkd8gIczvNZmM6Qok1i2Rwkwn7pqemAS3QInVlrVkm/yCvwC3Xg7Dxgr2GLiQ7hMgJROdCnM2+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=qEQFNE4Z; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1720062084;
	bh=08bw283wAwwr7luwSNsiMYD2RxYSDrVcyBFIdCUHTU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qEQFNE4ZqbatHG2jCgJfbvRT5U3MXjSgFcHdWNSExucDaO+xTC6ajCfjBQBEh473K
	 o2ZiYZJ8Rcl7M4mmZMjT060YP63n6pT9gAQqS1a+3tAhMZBvcofU1I3XfJRyQ8Kr06
	 VwakH1YG7yl/sE3O39PqgWemBmuNi1Ri3bJt6JUUElW1MniL3EZlOh/qb1GFPOLAVf
	 CSUZLFfMv9B8v2EyPWKYQ9Il5h4kVXOjojbGmLowuHzTqJSr59FalJWTAirwvAaOPt
	 pshF6wQSVXuv9T6y0efx70UDLkYWE5Lzg0I3wSVzCH8MiY3/ZPDRMlIxHmAm+1dai+
	 CfurPAaIQYHKw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WF1cy0mGQz4wxs;
	Thu,  4 Jul 2024 13:01:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mark Brown <broonie@kernel.org>, Herve Codina <herve.codina@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 07/10] soc: fsl: cpm1: qmc: Introduce functions to
 get a channel from a phandle list
In-Reply-To: <a8c44188-d5d8-445d-9d64-bbfce6b1b628@sirena.org.uk>
References: <20240701113038.55144-1-herve.codina@bootlin.com>
 <20240701113038.55144-8-herve.codina@bootlin.com>
 <a8c44188-d5d8-445d-9d64-bbfce6b1b628@sirena.org.uk>
Date: Thu, 04 Jul 2024 13:01:21 +1000
Message-ID: <87a5ixkghq.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Brown <broonie@kernel.org> writes:
> On Mon, Jul 01, 2024 at 01:30:34PM +0200, Herve Codina wrote:
>> qmc_chan_get_byphandle() and the resource managed version retrieve a
>> channel from a simple phandle.
>> 
>> Extend the API and introduce qmc_chan_get_byphandles_index() and the
>> resource managed version in order to retrieve a channel from a phandle
>> list using the provided index to identify the phandle in the list.
>
> These two PowerPC patches seem trivial enough and have got no response,
> unless someone objects I'll go ahead and apply them.

Ack.

MAINTAINERS says:

FREESCALE QUICC ENGINE LIBRARY
M:      Qiang Zhao <qiang.zhao@nxp.com>
L:      linuxppc-dev@lists.ozlabs.org
S:      Maintained
F:      drivers/soc/fsl/qe/
F:      include/soc/fsl/qe/

But I see no email from that address since January 2021:

  https://lore.kernel.org/all/?q=f%3Aqiang.zhao%40nxp.com

And actually drivers/soc/fsl was marked orphan in April, maybe this
should be also.

Or does Herve want to take over maintaining it?

cheers

