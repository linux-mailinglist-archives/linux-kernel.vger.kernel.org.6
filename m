Return-Path: <linux-kernel+bounces-225019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE04912AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAB71C20D21
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2C15D5D0;
	Fri, 21 Jun 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/gOhkq5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A9B15B99B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718985048; cv=none; b=jNhjVVnahIBSURvi3JgEcyPM3bFK5ashGi/uaMUw46zzkwkm7Casa4+Aa5+9EOspLGhL52gg7YJoSSsEIP6z705cqs1/7G98XH0fNvl/op88vr7onIF0tQbfcUiIzmsXfhE176J5D1GQY3h0pMyETIpxvbjvPViiofVJypmgQRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718985048; c=relaxed/simple;
	bh=QQyDYatsQrlwi7QwFF8CDCr7I6jryJgPpAG3vTbM6l8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JNkYzgFd6xdg+mb0nhHUsFYb3bVD17+g6x1OadDz9ncaB5s+H8WshFsc5jekCv6a/Q2oK4e9K33OBnXLuB57lTE5ikvXtE/LXUzpN0ORQvAB8En3dzrzagokr/IsijnRXqSZNu+0j3PZT3KHVIlfGEdjuOJfSB9gK7/qLkjA5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/gOhkq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1521CC3277B;
	Fri, 21 Jun 2024 15:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718985048;
	bh=QQyDYatsQrlwi7QwFF8CDCr7I6jryJgPpAG3vTbM6l8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=b/gOhkq5Wi+QUt0i18sgThFmrL/duhin+v9G1m1FL7ii4LXPgSKbRHtJbzVbbQ0kq
	 n2XtG6yXTK5UAfDIt2cfrUEKGlzxcKKNNxqiuSAQEpGj7ZBvwv7tKhBguGlKr9+Rjl
	 mEm2l8FT0D7RYpHqPXOFedGbMLl0zpiWy1vJm/kS1rlwUfegYhXvhajOlqICS2fFp5
	 H61AvSWT8/Py/utVPFmsh8gFmXufJ9n+pi/gRGX2NDdKIluLbU48T3py6G4hvFbAZ/
	 HwEBwA5Kh2Q07orS6rEB+fmFtHbBi2epLNorzT0u0zZU8/3QKkuN5KV5plpvvZnfLq
	 xjXcGO6Ln1NYA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Linus Walleij <linus.walleij@linaro.org>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,  Esben
 Haabendal <esben@geanix.com>,  Hartmut Birr <e9hack@gmail.com>
Subject: Re: [PATCH v2] mtd: spi-nor: winbond: fix w25q128 regression
In-Reply-To: <20240621120929.2670185-1-mwalle@kernel.org> (Michael Walle's
	message of "Fri, 21 Jun 2024 14:09:29 +0200")
References: <20240621120929.2670185-1-mwalle@kernel.org>
Date: Fri, 21 Jun 2024 17:50:45 +0200
Message-ID: <mafs0v822e1m2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jun 21 2024, Michael Walle wrote:

> Commit 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
> removed the flags for non-SFDP devices. It was assumed that it wasn't in
> use anymore. This wasn't true. Add the no_sfdp_flags as well as the size
> again.
>
> We add the additional flags for dual and quad read because they have
> been reported to work properly by Hartmut using both older and newer
> versions of this flash, the similar flashes with 64Mbit and 256Mbit
> already have these flags and because it will (luckily) trigger our
> legacy SFDP parsing, so newer versions with SFDP support will still get
> the parameters from the SFDP tables.
>
> Reported-by: Hartmut Birr <e9hack@gmail.com>
> Closes: https://lore.kernel.org/r/CALxbwRo_-9CaJmt7r7ELgu+vOcgk=xZcGHobnKf=oT2=u4d4aA@mail.gmail.com/
> Fixes: 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Applied to spi-nor/next. Thanks!

-- 
Regards,
Pratyush Yadav

