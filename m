Return-Path: <linux-kernel+bounces-540902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104D3A4B644
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338E5165632
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D945C19ADA4;
	Mon,  3 Mar 2025 02:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="X3I5luRb"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6662AD0C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740970305; cv=none; b=EZ8gZRSF7K9o3N/6qQh4ZyZi1xPdBs5apmLR7Az571Eol+Xx5rHt65p9rCOdREDjTAxK/tR4JR1+/FzDGXjH60SF6JzmnXCr22SRKu+WN/8GgQJHovgxE6npOPhrsjGi73twuGR/WSPbY2QWb+IN2cyz2HmzpWKZk1rduKen76A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740970305; c=relaxed/simple;
	bh=5PfTjr7Of8JSrEuHzOKpURr/JrhdiygIEGa16K1uDxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5F1KjZvdcXs8Q/Yezz5vPLyVei4NavE0ss3b5yj5dvKYiSiQxnmnWe87cidBkNYNEo8g3Zc+QbHackrJjneg657diBV2X9yaFBUklw1GWKJ2sUipAC9GiQ5jdhi/4rc35CpVWA+P4ix+wK1sEzRsODPkvS6ZfqFpyJcAKzN6x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=X3I5luRb; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1gV/0dVWD3TNzrKf3ge0SqivMXc1yRW+V7Hh7VDw6f0=; b=X3I5luRbVpO44hEUgsVlTofKnR
	8oxzBVZtQfQJd1+emxSiSp0f56Zv2m0PwuW4t4VubcuX1Hz09YePVAGhiUA2b71Br/XmQGKub5BwN
	TUXVxtZXZk987IRik4wr9yyFuEb4nzfcJY5PWH9FsR1DFFgBOsaSVgQc7+kvWTRiogPA5Ab7Irr3N
	o5xwmXXDeBuXHib7rXhnQFbQxung6ju1FO01Ws4mATwGa28MmprWOD01dgQLZZSL7wmigMk2A+7+u
	e9HNqXsoltVHdeGIIrKvnNt5xi1UpFaxyfrrThhM2CqzgWDuZanrBrvXuFupgvVuOkpXBxBFatBhu
	owNmeeaA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tovtb-003ARn-2V;
	Mon, 03 Mar 2025 10:51:08 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 03 Mar 2025 10:51:07 +0800
Date: Mon, 3 Mar 2025 10:51:07 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, yosry.ahmed@linux.dev,
	hdanton@sina.com, ryncsn@gmail.com, bigeasy@linutronix.de,
	minchan@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 14/19] zsmalloc: introduce new object mapping API
Message-ID: <Z8UZG1V4ywk7989y@gondor.apana.org.au>
References: <20250227043618.88380-15-senozhatsky@chromium.org>
 <Z8K10w-6fIpDhYc6@gondor.apana.org.au>
 <jupqosjamzyft2vqknquppeozs57xkgfy5pnr6v2qrh4duf5ik@6mwtww5yl6tu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jupqosjamzyft2vqknquppeozs57xkgfy5pnr6v2qrh4duf5ik@6mwtww5yl6tu>

On Mon, Mar 03, 2025 at 11:42:28AM +0900, Sergey Senozhatsky wrote:
>
> Discussed with Herbert privately, we will look into SG-list API
> later (future dev cycles).

Yes let's proceed with this and hopefully we can remove all the
complexity caused by linearising the compressed data later.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

