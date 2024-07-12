Return-Path: <linux-kernel+bounces-250456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 264CC92F80B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8141F212BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3865316E873;
	Fri, 12 Jul 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="x458Hlnl"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F56143C51
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720776398; cv=none; b=QNcQfUVD1BCg2DSf0xmTEdX2Wjh8Jt2sN6UuKTDxaoksbQhi0NFe9bbtYKuTWjwdQNA3BvD1OLY+CgEaG2LDqVuSmSXq3Br9yEmFvcBre5/NGwejTD6JCPhopblq74bSkbGGiyZjdZuECAdmiGWpEhwtcALyB64GM1lnBCkv0LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720776398; c=relaxed/simple;
	bh=XTHhkNfW6DjDt9wKWePcdKsctLMF24Lq3kjl0NCYTl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aE9/DERGmBAKb85D1DVd7nCbkbNWT5xrqveHPYqWKJccmfUiNrGeiNmk3b0DEhRZcff6SpKbbyZ9On/oCVfwdlhIKDvdIRAFV5pRvG62GgR7TfAHpWsUtmq/Pzjpvi7VAPMsnNJh7zfHtdSxc5eB/a76MMmKgz+rnoxT5bxrZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=x458Hlnl; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Mr/oLSebsAjrIhR//GSxa555Ns9T6USHYiGG2DRTKnM=; b=x458Hlnls9sQkvci39L51g2Oej
	21LoK3PM7sE9QmB2meixSowq0mOeFojd4kxI/Ea+DdLWktGZW5LClgC/L+OLPkHISp56Kf0pPIPv/
	YltrOgtC1nyTYPiZ1JWBD/BxoHBVECAKqY4RG6g03Hi5/JU0nHO6w0YNvIUa5dhIRNf3ypq5hSiOy
	8cEQs3ZYms+XzQTi9RJp1JlXJFSTxcIuUGkjlaI56cnpl3x0qGadsPQHiV46K+xcKb/C33whJ1Mfj
	xsTvhkcOnkf465yS8dR6TXdqKuhYkOTOsvIeUX4KFgopTjt41W6oTd0Y4vBzKl/l/oiDCctJUZ5N/
	uArKweyw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sSCXv-000CeK-MD; Fri, 12 Jul 2024 11:26:31 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sSCXv-000I8s-00;
	Fri, 12 Jul 2024 11:26:31 +0200
From: Esben Haabendal <esben@geanix.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  Nicolas Ferre <nicolas.ferre@microchip.com>,  Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 15/15] mtd: spi-nor: spansion: Drop redundant
 SPI_NOR_SKIP_SFDP flag
In-Reply-To: <20240711-macronix-mx25l3205d-fixups-v3-15-99353461dd2d@geanix.com>
	(Esben Haabendal's message of "Thu, 11 Jul 2024 15:00:15 +0200")
References: <20240711-macronix-mx25l3205d-fixups-v3-0-99353461dd2d@geanix.com>
	<20240711-macronix-mx25l3205d-fixups-v3-15-99353461dd2d@geanix.com>
Date: Fri, 12 Jul 2024 11:26:30 +0200
Message-ID: <87zfqnufjt.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27333/Thu Jul 11 10:35:59 2024)

Esben Haabendal <esben@geanix.com> writes:

> With the implementation of SPI_NOR_TRY_SFDP flag, the removal of the
> deprecated mechanism for trying SFDP parsing, and the alignment of
> ->default_init() hooks handling, the SPI_NOR_SKIP_SFDP flag has become a
> no-op, so it can safely be removed.
>
> Signed-off-by: Esben Haabendal <esben@geanix.com>

Should I split this into a commit for the spansion change, and one for
the core change?

/Esben

> ---
>  drivers/mtd/spi-nor/core.c     | 2 +-
>  drivers/mtd/spi-nor/core.h     | 5 +----
>  drivers/mtd/spi-nor/spansion.c | 2 +-
>  3 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index d58f107f62ec..518b2707ce80 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3024,7 +3024,7 @@ static int spi_nor_init_params(struct spi_nor *nor)
>  	if (spi_nor_needs_sfdp(nor)) {
>  		ret = spi_nor_parse_sfdp(nor);
>  		if (ret) {
> -			dev_err(nor->dev, "BFPT parsing failed. Please consider using SPI_NOR_SKIP_SFDP or SPI_NOR_TRY_SFDP when declaring the flash\n");
> +			dev_err(nor->dev, "BFPT parsing failed. Please consider using SPI_NOR_TRY_SFDP when declaring the flash\n");
>  			return ret;
>  		}
>  	} else {
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index f4a76f42051a..ae10e12e9078 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -485,9 +485,7 @@ struct spi_nor_id {
>   *
>   * @no_sfdp_flags:  flags that indicate support that can be discovered via SFDP.
>   *                  Used when SFDP tables are not defined in the flash. These
> - *                  flags are used together with the SPI_NOR_SKIP_SFDP or
> - *                  SPI_NOR_TRY_SFDP flag.
> - *   SPI_NOR_SKIP_SFDP:       skip parsing of SFDP tables.
> + *                  flags are used together with the SPI_NOR_TRY_SFDP flag.
>   *   SECT_4K:                 SPINOR_OP_BE_4K works uniformly.
>   *   SPI_NOR_TRY_SFDP:        try parsing SFDP tables before using the
>   *                            parameters specified in this struct.
> @@ -536,7 +534,6 @@ struct flash_info {
>  #define SPI_NOR_RWW			BIT(9)
>  
>  	u8 no_sfdp_flags;
> -#define SPI_NOR_SKIP_SFDP		BIT(0)
>  #define SECT_4K				BIT(1)
>  #define SPI_NOR_TRY_SFDP		BIT(2)
>  #define SPI_NOR_DUAL_READ		BIT(3)
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index a58c0229003d..afcb684ffe4d 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -793,7 +793,7 @@ static const struct flash_info spansion_nor_parts[] = {
>  		.name = "s25fl256s0",
>  		.size = SZ_32M,
>  		.sector_size = SZ_256K,
> -		.no_sfdp_flags = SPI_NOR_SKIP_SFDP | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  		.mfr_flags = USE_CLSR,
>  	}, {
>  		.id = SNOR_ID(0x01, 0x02, 0x19, 0x4d, 0x00, 0x81),

