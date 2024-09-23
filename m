Return-Path: <linux-kernel+bounces-335749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E77B97EA17
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFAFF1C21286
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D53197559;
	Mon, 23 Sep 2024 10:46:25 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5719841C77;
	Mon, 23 Sep 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727088385; cv=none; b=NoYcAUAh3LQwBkGTxuV2IYauljJPQhl2wHv3Ox8xHosdUTS4OGq/07Dymhg0nTNC5zfREVwSbP6N6qNDrCtZ61fnwghIDZ0xgTKHm7L75rrSNQDwT9WBcB7A/BjR3F2/w0wPGxNHMkgxLU8XX39j5X92hQdQW7UqD4Sb80NVDpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727088385; c=relaxed/simple;
	bh=uXUXgnx25r8aS3tCDx/lcw2Qd5SFfMtKH9rCu2OCZds=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=EZo/RsQvP5uazGLQbmX9dgjF3R64B9vUn/Mu/y3+E1IFlOx3tt157uP7ocepQoN5bV4m0QJKqSOtQscMc8qA1OOmqQzasaY7Sz8rAfEHCDRxeqyzCfT9Us9BDJ2XLrnJnQjTDnu1Aomi8oKqjM210lW4NspkXeTn8nIg+ZK7PHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 5BF0D67;
	Mon, 23 Sep 2024 12:46:20 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Sep 2024 12:46:20 +0200
Message-Id: <D4DLQGLJSKPB.3OOW4RU9Q3K5O@kernel.org>
Subject: Re: [PATCH v5 1/5] mtd: spi-nor: core: add manufacturer flags
Cc: "Erez Geva" <erezgeva@nwtime.org>, <linux-mtd@lists.infradead.org>,
 "Pratyush Yadav" <pratyush@kernel.org>, <linux-kernel@vger.kernel.org>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger"
 <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 <devicetree@vger.kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Esben Haabendal" <esben@geanix.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Erez" <erezgeva2@gmail.com>, "Tudor Ambarus" <tudor.ambarus@linaro.org>
X-Mailer: aerc 0.16.0
References: <20240920181231.20542-1-erezgeva@nwtime.org>
 <20240920181231.20542-2-erezgeva@nwtime.org>
 <4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org>
 <CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>
In-Reply-To: <CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>

Hi,

> I would gladly remove the obsolete mx25l12805d.

Why? I don't see any need for that.

> > If there isn't any way to distinguish the flashes at runtime (which I
> > doubt/challenge btw), then as a last resort we introduce a dedicated
> > compatible for the flash in cause and specify all needed parameters in =
a
> > dedicated flash entry. This shall be more generic as further flash
> > parameters can be statically specified in the dedicated flash entry,
> > less invasive for dt, and less confusing for people when they decide
> > whether to use OTP or not. OTP params in device tree is a no-go.
> >
> > But again, you have to prove why you can't distinguish the flash at
> > runtime before introducing a new flash compatible. So don't go this pat=
h
> > before sharing with us what you're trying to achieve.
>
> You keep sending me contradictory messages.
>
> I told you we can not "guess" OTP settings based on JEDEC ID and
> SFDP existence.

What are you trying to achieve here? I've told you we are trying
hard to figure out everything out at runtime. I'd suggest you start
with one particular device where you want OTP support for. If the
flash id is already in our database, find a way to distinguish
between the old and the new one; probably by looking at some SFDP
parameters. No need for any new compatible. Don't try to solve the
problem for all the chips out there.

Again, the reason why we are trying hard to determine that at
runtime is that these flashes are usually second source devices and
a manufacturer might just replace it with a (more or less)
compatible one. Therefore, the less information we put into the
devicetree the better. So before you are sending a new version with
the flash compatibles, you actually have to convince us that there
is no other way of knowing what kind of flash there is on your
board except for providing the name by the firmware.

-michael

