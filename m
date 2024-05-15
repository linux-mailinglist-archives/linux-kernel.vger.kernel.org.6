Return-Path: <linux-kernel+bounces-179634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E6B8C6291
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313B2281CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FAF4F608;
	Wed, 15 May 2024 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="nLlIqFDJ"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0D74F20E
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715760711; cv=none; b=Snc8l3WNpn7WjTCRHN8iy2Fq/lXGa07wxeExmi14tvIKrTHNV1lzRpLzaynRsWwLThdcZH6yuiF2LzdlW89idN06xFnvU6V3OlOoYTrA+ImL7ywcMZnFzWYEtkPs0pikj49oIzCvjrDV5Bx3ybYaiDJ7hIu0GUGijrzJCZd+orc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715760711; c=relaxed/simple;
	bh=GXhxoHH8XfOYuQn5IxWFIkHAHYUmqB/vSPcBWIkKnjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/QfI1tzwR7riYo0Iy2Tol45sOGH1rspVD53PuZaUrks3Y/z2Hp1fjL2TZWJw2GAm5puzBnGAXsXlPJrQAaJctcICOTHQtvSE7YNEOIDkyyyzoK6WCvB7vlNesjWG/MEZNLIKeOsfhk/vMlmr1Edyk7Zub1GWWSAGb80XrjtjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=nLlIqFDJ; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A89DE148885E;
	Wed, 15 May 2024 10:11:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1715760700; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4BubNEfkOvTMW0pqXeyPLnMVtWNnuEC5YxCaM2+E75o=;
	b=nLlIqFDJtN5RT3rg2ftmmAD4TtJQvZ2V95Ryzp3zvfbBVrhQa8ntMuphgXryQWUAmovlZA
	yrkJRUzYd42aInplVVp/P4hNuag5n0OtEOgKW3dWoUXGxZoMCISPXSjPXaB5mhr//zbPiU
	Eij650wC8BMc5/Ku/nmOhXfqaofoW6YC+Q4t5sN+NKZi123jTjtztjvPbWTqccqauisY0a
	6hb8I4ZCidXemIPev7BCCq7rVL5oEE8ZpRElE2dESHMTz4FIiLwWyyIffesDiQGiC1EsWe
	OGk84+3koD7VToXED+ou+Mf8v7IXbv4PXFdqgfkk2Uvbf6CtkFB/0g3TDfxE2Q==
Date: Wed, 15 May 2024 10:11:37 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] mtd: rawnand: make
 rawnand_check_data_only_read_support() work
Message-ID: <20240515-sponge-yin-461a31d7811e@thorsis.com>
Mail-Followup-To: Sascha Hauer <s.hauer@pengutronix.de>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>
References: <20240514103355.817056-1-s.hauer@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240514103355.817056-1-s.hauer@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Sascha,

Am Tue, May 14, 2024 at 12:33:55PM +0200 schrieb Sascha Hauer:
> rawnand_check_data_only_read_support() calls nand_read_data_op() with a
> NULL pointer as buffer which will immediately return an error. Allow a
> NULL buffer pointer when check_only is requested. This should be safe to
> do as nand_read_data_op() has no business in touching the buffer in
> check_only mode.
> 
> Fixes: 9f820fc0651c ("mtd: rawnand: Check the data only read pattern only once")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index d7dbbd469b892..a5e7d8deafbbe 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -2173,7 +2173,7 @@ EXPORT_SYMBOL_GPL(nand_reset_op);
>  int nand_read_data_op(struct nand_chip *chip, void *buf, unsigned int len,
>  		      bool force_8bit, bool check_only)
>  {
> -	if (!len || !buf)
> +	if (!len || (!buf && !check_only))
>  		return -EINVAL;
>  
>  	if (nand_has_exec_op(chip)) {

A very similar patch has been proposed by Miquèl with
<20240507160546.130255-2-miquel.raynal@bootlin.com> recently. o.O

Greets
Alex

Link: https://lore.kernel.org/linux-mtd/20240507160546.130255-2-miquel.raynal@bootlin.com/

