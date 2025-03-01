Return-Path: <linux-kernel+bounces-539825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C78A4A96B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 08:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C385D16C690
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 07:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423611C3C07;
	Sat,  1 Mar 2025 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="KP8jZ2J7"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411371B87D1
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740813820; cv=none; b=h8Bml5hG5lPOdweZ4jQBWG0QUTHWBJVlIiP0/yYzOdVcvypuxN11RAzx9TrlFzgz/Bt0DxvPpxcaUCiC6gwhg5sGKIXusppa9l9CeY4MHyIS4/CbUvizirK1QOvYSGl/isAgGB3PnIXZk6bGjaKm46heY8Zie2F3Dx4+v7RPpq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740813820; c=relaxed/simple;
	bh=TvCTkJjTsZMufM1VvmoUTa6oWgntzd5uJIiigMNn8Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=u67xlNNJKpgmV9RCz+yb2GRfzbAyw4d/UbseO7YIBSetAUEztenzZ85o9xRrstb6D1M/dMIN34ujXs+QeYKUl7sPjUmo4fwgn7jxA0yyhiItuHbppd4Di0RbbL8XMU6l11wkSzo9uIN9QFGAcrvuG/Kbof5/5UPTVgeO/Wsql0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=KP8jZ2J7; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i3O1YgRzMdiitsQCPUd24V+zejMicSG8nLoWS1cKp7o=; b=KP8jZ2J7rbMFNsnCE16HS6sZvR
	akjk0wMn6+cInfa4AeL1fuMiLkiiEkYDUdcmC7XS2PalBzfUvhIysIIHVH6COtoLO2xNaVHhJv++/
	tE+ClaHJuAkS0vSlzMeJ4wWOGXVcqW53Jf1jFUbTib4H/yDK6KvZ01EO2g4yMvADrGqYvOXwrMRv9
	VA8dytU8aBLLI2koJ7Yw1T5Y4mST3ZRMexLvflqsTGDzIvQZnKMUHwXtxUoSBV7WegwpsyKuPH7HG
	K1jf09BHSPDS1ocovawuIxsAONwmxLoGud6xeTeoP3k2U3IHXv4xWLFh0d5EwZ+EgV3y2XQVOfqac
	yFK+DMcg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1toHBb-002mVr-0E;
	Sat, 01 Mar 2025 15:23:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 01 Mar 2025 15:22:59 +0800
Date: Sat, 1 Mar 2025 15:22:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: akpm@linux-foundation.org, yosry.ahmed@linux.dev, hdanton@sina.com,
	ryncsn@gmail.com, bigeasy@linutronix.de, minchan@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	senozhatsky@chromium.org
Subject: Re: [PATCH v9 14/19] zsmalloc: introduce new object mapping API
Message-ID: <Z8K10w-6fIpDhYc6@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227043618.88380-15-senozhatsky@chromium.org>
X-Newsgroups: apana.lists.os.linux.kernel

Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>
> New API splits functions by access mode:
> - zs_obj_read_begin(handle, local_copy)
>  Returns a pointer to handle memory.  For objects that span two
>  physical pages a local_copy buffer is used to store object's
>  data before the address is returned to the caller.  Otherwise
>  the object's page is kmap_local mapped directly.

I presume this buffer is always given to the compression algorithm
to decompress? In that case there should be no need to linearise
them at all.

Just return a two-entry SG list, and give it to the Crypto API
to deal with.  Both software and hardware algorithms can handle
non-linear input.  Yes software decompression is currently
linearising all input with a copy, but that is no different
to the copy that you're making in zsmalloc.

So please change this API to create an SG list instead of copying.
That way we can then optimise the software decompression to read
non-linear input directly and skip the copying altogether.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

