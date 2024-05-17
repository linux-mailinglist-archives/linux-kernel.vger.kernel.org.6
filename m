Return-Path: <linux-kernel+bounces-181653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C48838C7F41
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 02:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D5D5B21C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 00:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AB0817;
	Fri, 17 May 2024 00:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMYTELw9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B95622;
	Fri, 17 May 2024 00:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715906084; cv=none; b=n2HDn/4+WoYnuZ9VD5OB0kRrEFaOc9oTBT7l/6fsyvtMO65kXrudK+Y/Hli2zzgBTnrWPqMGm5gII/obkuUYE6MAB+QwkwOZ1O3c8UO8s6K9+D+ZGsnvuZyaigZfxCR2hH5tzIfTU9+SOxnmr/O3fIFRPks/W09kWppr901amRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715906084; c=relaxed/simple;
	bh=NxT1fDiRetTAEkEf4wcSp/6bnfFWtJKyN4JFKJ+uVsQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=P9pD4nVdODyIOQy8cfnBhwxi1sOZHVIS9ZEnD+HI3huHtFng3gKkgF4oIVqLsd24uKL9IwhjcilDodSk9SDll2x6vdy0BartmNCOsH83hTcY/+MvZ8HQ0k8RzkUNu7nxz3Yr1STnCT5e5BB3anuYpwsI9mco7VTfoEyDBjVfk7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMYTELw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89E0C113CC;
	Fri, 17 May 2024 00:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715906083;
	bh=NxT1fDiRetTAEkEf4wcSp/6bnfFWtJKyN4JFKJ+uVsQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=cMYTELw96iYyprniezpbpuN/KS2c5FO38U+zmTtHpgblOFoyCiNRNBcSOhGhjUQFS
	 ctNi73VzlE0everJqBnmEk3TEmCu6VYJ9t8SN2FHznE2EiukRoJ5DMfIr0BfoGXJUd
	 q5e4CUJPLKDi8Q7saQp8twXSOdXNeBqS0VKgcZFo4x0S29QWycUy2OGmKrAYQ4JSLU
	 XADHeLPKRN+NCqZ3238XYjbI8PKK4Soj/CyzCQKOzF7r06OooC83rKsYl4JWc4Ramz
	 xkr5wtXVBiAH1BmybG5YhxdH3WEyMDKodfSPMtiHe7NtoYc4DsK+ZlxkZZeEbw52mF
	 f0D55NzEVZacw==
Message-ID: <5cceccdba7297d84e948a85f533f3189.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <73a9d56c-9e8d-4859-b3a2-dba1531b57e5@foss.st.com>
References: <20240419152723.570159-1-gabriel.fernandez@foss.st.com> <20240419152723.570159-3-gabriel.fernandez@foss.st.com> <332c845c17e24e2eb660e18680f2626f.sboyd@kernel.org> <73a9d56c-9e8d-4859-b3a2-dba1531b57e5@foss.st.com>
Subject: Re: [PATCH 2/4] clk: stm32mp2: use of STM32 access controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Date: Thu, 16 May 2024 17:34:41 -0700
User-Agent: alot/0.10

Quoting Gabriel FERNANDEZ (2024-05-14 23:41:17)
>=20
> On 5/8/24 00:02, Stephen Boyd wrote:
> > Quoting gabriel.fernandez@foss.st.com (2024-04-19 08:27:21)
> >> diff --git a/drivers/clk/stm32/clk-stm32mp25.c b/drivers/clk/stm32/clk=
-stm32mp25.c
> >> index 210b75b39e50..a37ee9f707e3 100644
> >> --- a/drivers/clk/stm32/clk-stm32mp25.c
> >> +++ b/drivers/clk/stm32/clk-stm32mp25.c
> >> @@ -4,7 +4,9 @@
> >>    * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STM=
icroelectronics.
> >>    */
> >>  =20
> >> +#include <linux/bus/stm32_firewall_device.h>
> > I don't have this include. I either need a signed tag or this needs to
> > wait until next merge window.
>=20
> Sorry for the delay, i was off.
>=20
> I was based on tag next-20240419
>=20
> >>   #include <linux/clk-provider.h>
> >> +#include <linux/of_address.h>
> > What is this include for?
>=20
> yes #include <linux/io.h> is more appropriate.
>=20

Ok. Please resend after the merge window.

