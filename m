Return-Path: <linux-kernel+bounces-421144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EDA9D874F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDC5284AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EC01AF0A1;
	Mon, 25 Nov 2024 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3DG7sp0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65212192B7F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543529; cv=none; b=Tpw0GSJOJB1+5s5AmTPy19HN873Y37eV/UTMXVU+v5zIapU3z7ZxGG6z869ooNjyoa4WILB/OWN7FnRCsEW9y68rtSXLVzi1gdFfaGiHPZqgWwcA3Vxd6kS8LBvyhfPtpIY7k/dWqDfjFWxKvaNxQ69YfPMa39joI2jiKYdHOJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543529; c=relaxed/simple;
	bh=7N6O5nyyAZXOnHOqqGJ5UhxAbpqm8gEQrH9VexcwMgc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dY7OH2at50M+sKEg9ggbBt0BCGmDHS1rmt/bjMt+v1fWfDAEYrUardmpG2cS2bfvMq5ifuUiUVwZr2zEFJOfku969BFL0cUCzDtqEGY8U6lvedrf+8x0jVEZ7mtbhVXFmxayAl46D8dTk7o9FqPPLdS6g898+uMV46lq82uMy+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3DG7sp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FFAC4CECE;
	Mon, 25 Nov 2024 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543528;
	bh=7N6O5nyyAZXOnHOqqGJ5UhxAbpqm8gEQrH9VexcwMgc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V3DG7sp0uA5XWqdPO4E37yrNAk0dGyGTDmVuoZVJPWxymXAG1waHXaCZx1vbAbljR
	 ONtbg4d6DVG6Y7NfMvw3OhVxTyj5MSWIHEI3qVFFDVDsCC34I/T0AydslnuzVkGArS
	 JYvf7GP8y9AeWr07hWk/5WRKjY2Ug1Wit9CJHhKZcJq2F30kDwLxkNVHHDhqL/1YjZ
	 3jbgCPPyCtxwKRPamW9KB8g7gHcQ0HDWwala8eGrlPtCFpEHtKMqC8XaXiSs7Xi/pO
	 M6LdzEP4zuNLTCJtshzoqoNUK+ix86oD4busyWRkBvEWKg7MYwqBrUA1yRKzsvn1zx
	 hQ9GGSES94nfQ==
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
Date: Mon, 25 Nov 2024 14:05:25 +0000
Message-ID: <mafs0ed2z5ryy.fsf@kernel.org>
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

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

