Return-Path: <linux-kernel+bounces-569241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B54A6A076
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CFC19C0046
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85318205AA5;
	Thu, 20 Mar 2025 07:30:55 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EE61F8BB0;
	Thu, 20 Mar 2025 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742455855; cv=none; b=ihegXo5sv02w+1ddNWRhlFzMdcbr8MBql3p6sUA+fa75/h6H4s+f8dXRl0aCLuMCM6+6eqOf+z6t0WeeslpcOQ7MN6EpCt/mLQpZUhtbcMCkHwsCvwGyDbwEOWA46GCVjNOS9pAGSlpVeYZGiA+iHud+ec6yhlYyBmrN4NNNfE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742455855; c=relaxed/simple;
	bh=pHRzPPRF92ifNzxT1chuCpbsLDvpubwleyIpH/7GGTw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=XVGCu1FGhvdqnc/H3bWrJaype3lJrvZPpAKvwCzHUikzv94a2w2b/kDkLubcIvKuKvAAjakV4CGgH0dek1sIIU8G+FyEfianqv7B5bNaUbHML8YK54qMuq4YacdImil1tjVS7wfkQOO8MGb9s/4uPgBCVBOiz9K+PohmWYuuICo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 97CDB14B;
	Thu, 20 Mar 2025 08:30:43 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Mar 2025 08:30:43 +0100
Message-Id: <D8KX1NO755U3.2HC0O2OX5MJUL@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Rob Herring" <robh@kernel.org>, "Takahiro Kuwano"
 <tkuw584924@gmail.com>
Subject: Re: [PATCH 2/3] mtd: spi-nor: use rdid-dummy-ncycles DT property
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, <linux-mtd@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Bacem
 Daassi" <Bacem.Daassi@infineon.com>, "Takahiro Kuwano"
 <Takahiro.Kuwano@infineon.com>
X-Mailer: aerc 0.16.0
References: <20250319-snor-rdid-dummy-ncycles-v1-0-fbf64e4c226a@infineon.com> <20250319-snor-rdid-dummy-ncycles-v1-2-fbf64e4c226a@infineon.com> <20250319233024.GA2625856-robh@kernel.org>
In-Reply-To: <20250319233024.GA2625856-robh@kernel.org>

On Thu Mar 20, 2025 at 12:30 AM CET, Rob Herring wrote:
> On Wed, Mar 19, 2025 at 06:47:44PM +0900, Takahiro Kuwano wrote:
> > There are infineon flashes [1] that require 8 dummy cycles for the
> > 1-1-1 Read ID command. Since the command is not covered by JESD216
> > or any other standard, get the number of dummy cycles from DT and use
> > them to correctly identify the flash.
>
> If Read ID fails, then couldn't you just retry with dummy cycles? Or=20
> would unconditionally adding dummy cycles adversely affect other chips?

Yes exactly. IIUC, the first byte of the auto discovery (RDID
command) would return random data, because the output driver of the
flash is disabled. The second byte would then return the
manufacturer id and third and fourth the device id. This makes auto
discovery fundamentally broken with this chip as the first byte
might randomly match any manufacturer within our database.

Takahiro, if you can reach designer of this chip, you might tell
them, that this was not the greatest idea :o

> Otherwise, add a specific compatible to imply this requirement. Adding=20
> quirk properties doesn't scale.

Since auto discovery doesn't work at all, you might just add,
"infineon,cyrs17b512" *instead of* "jedec,spi-nor" (because it doesn't
support the usual RDID command").

Alternatively, we could introduce a "generic" compatible which just
uses the standard RDSFDP command instead of RDID for discovery. Rob?
Then we'd need some SFDP fingerprinting mechanism to match the SFDP
to a particular flash type.

-michael

