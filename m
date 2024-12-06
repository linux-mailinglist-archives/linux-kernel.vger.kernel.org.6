Return-Path: <linux-kernel+bounces-435187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2149E7417
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF391885432
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DCD203710;
	Fri,  6 Dec 2024 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUmrYELU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3396148318
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498926; cv=none; b=hECB24+ZeaqxFi74z6hysbxjEjSeMkhyS/SkSt1upUZL62Ztz8GiubZkdcFZJZbU3vDWICj34gcwlYrW+KByopVgxwBgZ8RtNulmKD9HVSq6BGE3QE9k5xR8wmSMILvv8DFW08Kfe4UyDbSv4yTricLSfvaBN6S6EAPkR5SxCUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498926; c=relaxed/simple;
	bh=75VoOWoRJIKu6T8F6k92wIh/D91+NMx6NbfhF3/ourI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pXrySFnyeQtpyx2ETzOR/ygJuW6Cr49tCO7nkMDLVUkWsnuGUeD7gMWwS9CKXUVWodjwmriCGFkDP6INGXE0dC+93ITs6ZgiNn+PJp3p7QbMibqUD3mvq+SPGhZQXlIKfHqfKOH4QPp/xNSDKIMq+wngFZtGG8Myq63/pRH5hq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUmrYELU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1952C4CEDE;
	Fri,  6 Dec 2024 15:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733498925;
	bh=75VoOWoRJIKu6T8F6k92wIh/D91+NMx6NbfhF3/ourI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LUmrYELUfO1OT9T4glnELW2f/9s2IjjaLgsD+dEv2yWustyBnzzjT9UTwUBrsVplB
	 yptbdtXbHmThJHdqGYYQFYWtxyBkrAlD+icDzvMu1d3S/b1LlOgrPIeu2PXQBI4A9W
	 kJ45I2OWzm/uzhm8y30Yc+hPoyDSi1vy08bvQ1Jwm1qpzEduJVyXYyxlkr3gP0JHOR
	 74eoDuMyAiJSFtb5cO8Mv8/DS4/7IZOLDSB67cui57yuV4G9ZLKaztdB00PrY5jKI1
	 bHw4U8kJ4YfNoxCexzErJu9sBfs3hrI+tk//9h7fODwQqDQwsdfCaXcF4kzwhadEgB
	 C526D4ovWRTCA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Nicolas Ferre
 <nicolas.ferre@microchip.com>,  Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,  linux-mtd@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mtd: spi-nor: atmel: add at25sf321 entry
In-Reply-To: <20241116-spi-nor-v4-1-3de8ac6fd0be@gmail.com> (Marcus
	Folkesson's message of "Sat, 16 Nov 2024 11:55:55 +0100")
References: <20241116-spi-nor-v4-1-3de8ac6fd0be@gmail.com>
Date: Fri, 06 Dec 2024 15:28:42 +0000
Message-ID: <mafs0bjxo4yqd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 16 2024, Marcus Folkesson wrote:

> Add entry for the at25sf321 32Mbit SPI flash.
>
> This flash is populated on a custom board and was tested at
> 10MHz frequency using the "ti,da830-spi" SPI controller.
>
> Link: https://www.renesas.com/en/document/dst/at25sf321-datasheet?r=1608801
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Applied to spi-nor/next. Thanks!

-- 
Regards,
Pratyush Yadav

