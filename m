Return-Path: <linux-kernel+bounces-510968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E374A3243A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22653A844D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4485209F47;
	Wed, 12 Feb 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C8jZPP9O"
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBFF2AF19;
	Wed, 12 Feb 2025 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358303; cv=none; b=GZ8MVHICF9i58+3O4keChbgAtdO2pKvE48WGUgYSk8o4tVogXNalcLTlRPt9hgpFOZGRq/JER1f/QdRb8OU13sb8h3z46UyeNXnW9ZMEVEJyOSLwKBJ5WJjctou6CA/40OYtnKcPGMgnaWaRFdcewvIJsChqUscuXvzT5Kvsuwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358303; c=relaxed/simple;
	bh=LPAsGC/1kPwqJtEBVDKuR6kEkbgn6y+zm0h6s9vKkYg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pu5BWKnf2FsuHx2V78Rf1icQbYL4GQJKCQFme6I3gA0gsmnYN6crbbIKCOCqnCzeVHS2NhobhYewryWo+E22N7p7xcK7v0cXUBfZdoIHfAzTVGc2a62CmWjji03KqMLURUnTpsxsuBgz+95iCrrIzdgwWXhRyM1QM2ZXlja8TiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C8jZPP9O; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 23D48584D17;
	Wed, 12 Feb 2025 10:50:36 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A246F43191;
	Wed, 12 Feb 2025 10:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739357435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LPAsGC/1kPwqJtEBVDKuR6kEkbgn6y+zm0h6s9vKkYg=;
	b=C8jZPP9OENUbhih3cyMW9qDaXrAVLZ3AIGea6s0MLdCuHcdGqMlmHi8Owvu3fzToaIlRMl
	00fAiFL7m7Fo+dErGAhMaDZegjz1UbS7kL4tVp9hNpgL50LDXzMrGGC5qVuSpcnKWEwk7s
	+j018eD3QX4d7MsYwCeDcjklWy1yEREi5LEgR7UXNIqCCYU+vCHWZMiPpA7nz4uHKVFYDT
	r8Q2+8jaY1GRjHrNar8qHaXSeh7W7ugmz9CQGKQ6EFa6wlY216nVxoMtbPMbfjpIqX1mXU
	LqTb0BzoTYVZgD2vQtDB2sPRXRseS3DKdSEG101R+VZ0YzEtVEj+mjqqbzpKaA==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Conor Dooley <conor@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Robert Marko
 <robert.marko@sartura.hr>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] marvell: DT root compatible fixes
In-Reply-To: <20250204-headfirst-evergreen-ec92900ee782@spud>
References: <20250131-dt-marvell-fixes-v1-0-55f9f6acd4b1@kernel.org>
 <20250204-headfirst-evergreen-ec92900ee782@spud>
Date: Wed, 12 Feb 2025 11:50:34 +0100
Message-ID: <87wmdvsah1.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkgggtgfesthhqredttddtjeenucfhrhhomhepifhrvghgohhrhicuvefngffogffpvfcuoehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefghfegvdehgfdtjedvtefhvdeikefgteeuhfeukeettefgvdeuueettddtkeegveenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeguleegtgemheekuggvmegrtddtvgemvghftddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeguleegtgemheekuggvmegrtddtvgemvghftddupdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopegtohhnohhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhto
 hepshgvsggrshhtihgrnhdrhhgvshhsvghlsggrrhhthhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmrghrkhhosehsrghrthhurhgrrdhhrhdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: gregory.clement@bootlin.com

Conor Dooley <conor@kernel.org> writes:

> On Fri, Jan 31, 2025 at 03:08:24PM -0600, Rob Herring (Arm) wrote:
>> This series adds some missing root node compatibles and fixes some=20
>> errors in dts files for the root node compatibles.
>>=20
>> Signed-off-by: "Rob Herring (Arm)" <robh@kernel.org>
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied on mvebu/dt64

Thanks,

Gregory

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

