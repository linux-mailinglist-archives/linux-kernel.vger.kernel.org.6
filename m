Return-Path: <linux-kernel+bounces-169385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778CD8BC7E9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326A32815C7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE614F1FE;
	Mon,  6 May 2024 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="DR9HM8+v"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7941E64B
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714978692; cv=none; b=WXWGM7RjwX7uaeClYA0FPcCMGkEkPg55m/U/Jw4Ed8fCgKQgyAZxdvIZnyG21z9mzILDt39V26fsZ1ZxH42dSEV8YVW3VCd/cY2QnprOxCkHFxrN4rUGU3u3u/cPolsnjg72wCj65p7VhZhiD969MCwiDWseSHW/HeV9Nwy122s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714978692; c=relaxed/simple;
	bh=KTosghxQNHVYhSKYObdt0iokXKH5I5YpZAT4NGfcuWY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MK9HI+YO+vH11WHjHHa7b8TKtHWfgPHsup8hztWqjyinft4kwNzxmsViFJ8Q6KzgpOXdzEDvOUYPtbJhAox5sEEV8VzW2K8BvnkeaFJpfhTaYHKb8Kkidip2pSsLZuJJIR1eviy7mGhox8+FEvVxpma42u8OnZ3FeRpt6/Zyjtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=DR9HM8+v; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.2.60] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7529F2009E;
	Mon,  6 May 2024 14:58:06 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1714978688;
	bh=KTosghxQNHVYhSKYObdt0iokXKH5I5YpZAT4NGfcuWY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DR9HM8+v92MNauFrWh1860sTlDoPGOkJWnpTDMu4sq42e+tk0qS2L+XPrY6sO1WpW
	 s3InFERLo9hW6gzaAWD8uHnGpED+SvDGbSe2zVmy8NXrit/EdClZjqMfPG7OtxdZIl
	 Okepnll63+ceOd885C8G2Mm3YUVYjr+9og64HqAl0pNnQkkMPxW/eu5TEcp5HoPk44
	 X/QExCqrHcHm3/jTP5Au7gdkYGB9nmZFYynAp4cVCSRp1vFV7LlPKjAHplg7yGTRnV
	 y598eml+Y8afzY92VGj6vyluKBoEENuK/9K3uPQm2hIUudlUpMgyG9Aec+ZdzrfzF6
	 i3EM9qU4PWn+A==
Message-ID: <52f4e4afef87c336f054ca1c43eec58d2e44a5b1.camel@codeconstruct.com.au>
Subject: Re: [PATCH] i3c: dw: Disable IBI IRQ depends on hot-join and SIR
 enabling
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Dylan Hung <dylan_hung@aspeedtech.com>, "alexandre.belloni@bootlin.com"
 <alexandre.belloni@bootlin.com>, "joel@jms.id.au" <joel@jms.id.au>, 
 "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
 "zenghuchen@google.com" <zenghuchen@google.com>,
 "matt@codeconstruct.com.au" <matt@codeconstruct.com.au>, 
 "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: BMC-SW <BMC-SW@aspeedtech.com>
Date: Mon, 06 May 2024 14:58:06 +0800
In-Reply-To: <TYZPR06MB65678EE7611DDB825E5404C19C1C2@TYZPR06MB6567.apcprd06.prod.outlook.com>
References: <20240119054547.983693-1-dylan_hung@aspeedtech.com>
	 <563ad5613e9c5f0671e1f49f2d9ba71d8735799b.camel@codeconstruct.com.au>
	 <TYZPR06MB65675E5D43EE265DD702E5689C182@TYZPR06MB6567.apcprd06.prod.outlook.com>
	 <645d4f645b1296d54573c4fe734768adab160035.camel@codeconstruct.com.au>
	 <TYZPR06MB65678EE7611DDB825E5404C19C1C2@TYZPR06MB6567.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dylan,

> > The initial state would be to have all SIRs masked.
> >=20
>=20
> Yes, indeed. The "global" variable is also true because "reg =3D=3D
> 0xffffffff" is true.
> Therefore, the INTR_IBI_THLD_STAT bit will be set in the following
> code.

That's mainly my point - none of this code is ever run unless the
->enable_ibi or ->disable_ibi controller callback is invoked.

So we'll end up with the HJ interrupt only being enabled if some i3c
device driver enables IBIs, which is a bit of a weird side-effect.

It probably makes more sense when the rest of the HJ code is added, but
not so much as a standalone patch.

Cheers,


Jeremy

