Return-Path: <linux-kernel+bounces-250437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FE192F7D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7AA1F243AC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6901419A9;
	Fri, 12 Jul 2024 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="WFJLOz1y"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA5E1F5FA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720776222; cv=none; b=uHlWIx7CyzWSDEp/O8B7gjL4DPNm76zUMg89Q1A2JoB3lC7YUVbmlZt3Lc4506Ugr0OknheFxUA+tJQ/NRPyG3Jz4LaaPNgT/DJs7+WovgcXV3sb8UDKHHvcy/mrmAo7E30Y7Sepz4cpcNGVuq/t81CaXmNQwvyCA2ILCf/s9IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720776222; c=relaxed/simple;
	bh=ZcLNkOxoJQC4Sqwhg4ZxEd3jB8s5EFgjfLvJ4CoyTEU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yc88fpFuH05WNlx9+6u7GpdCOYqdZ2Dzyu1vpg16tEYNOQYj0qF0bp3PRY6ArMI5hhWjG39R4J+ca3dr6WoGGoJ7JFOn4lBUyqa5qxf6o6HguMTspiXk56BVL5XaL1tSf5JVBikkzYh35pGSnCc6fwA8r6Yig+lcg1K+STp4vwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=WFJLOz1y; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=seUtUt8wtCgGSXRuO9f9GPjRFi6hmGW1WMrsIz6qVxU=; b=WFJLOz1yQ20NEyeLNqgA72tiOB
	6dxGB9k1aqHLI8c8KVeto+PtYNvWis27PowutcGqR3ID2PtB2b3xNYGjoxEDMKRmlrAyQTJxL+Pom
	AI8n2vYwDxJefTF2EB2OTmZXdF1hGkHJ9UomV0vty4mKhDOFZMMKPxxlwQbIqH673aDmk4RP6O6BJ
	wfDZuUvVn0db/4ENTgqh6tNVPt+7eVNB37NpOiuX20T3fAaBYYYJ4TAHaEPbEjCPQjqCy53WpoEer
	TXaf4OG9Kq0kD7xH4Q6cTsRq9m/VDk+AWFWwPMzx1LXSt2WkWnJlaFqpqdMNchsByF5cxpPKu4tSV
	Kh9BIz/w==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sSCV4-000C7z-Ie; Fri, 12 Jul 2024 11:23:34 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sSCV3-000MXE-2k;
	Fri, 12 Jul 2024 11:23:33 +0200
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
Subject: Re: [PATCH v3 14/15] mtd: spi-nor: Drop deprecated mechanism for
 optional SFDP parsing
In-Reply-To: <20240711-macronix-mx25l3205d-fixups-v3-14-99353461dd2d@geanix.com>
	(Esben Haabendal's message of "Thu, 11 Jul 2024 15:00:14 +0200")
References: <20240711-macronix-mx25l3205d-fixups-v3-0-99353461dd2d@geanix.com>
	<20240711-macronix-mx25l3205d-fixups-v3-14-99353461dd2d@geanix.com>
Date: Fri, 12 Jul 2024 11:23:33 +0200
Message-ID: <874j8vvu96.fsf@geanix.com>
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

> With all drivers converted to the new SPI_NOR_TRY_SFDP flag, we can remove
> the old deprecated mechanism for triggering optional SFDP parsing.
>
> New flashes must use SPI_NOR_TRY_SFDP to get this behavior. Hopefully, all
> new drivers will be fore pure SFDP flashes, so no or at least very few new
> users of this flag is expected.
>
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/mtd/spi-nor/core.h | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
>
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index dfc81716e068..f4a76f42051a 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -719,24 +719,7 @@ static inline bool spi_nor_needs_sfdp(const struct spi_nor *nor)
>   */
>  static inline bool spi_nor_try_sfdp(const struct spi_nor *nor)
>  {
> -	if (nor->info->no_sfdp_flags & SPI_NOR_SKIP_SFDP)
> -		return false;
> -	if (nor->info->no_sfdp_flags & SPI_NOR_TRY_SFDP)
> -		return true;
> -
> -	/* Deprecated/legacy way for triggering optional SFDP parsing.
> -	 * If one of the no_sfdp_flags indicating dual, quad or octal read is
> -	 * set, SFDP parsing will be tried.
> -	 * When all drivers have been converted to set SPI_NOR_TRY_SFDP where
> -	 * needed, this deprecated mechanism can be removed.
> -	 */
> -	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
> -					SPI_NOR_QUAD_READ |
> -					SPI_NOR_OCTAL_READ |
> -					SPI_NOR_OCTAL_DTR_READ))
> -		return true;
> -
> -	return false;
> +	return (nor->info->no_sfdp_flags & SPI_NOR_TRY_SFDP)

Sorry. Bad cherry-pick here. Due to other reasons, I am testing out of
tree :(  The missing semicolon will be added in v4.

I assume we can still discuss the idea here in this version.

/Esben

