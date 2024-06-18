Return-Path: <linux-kernel+bounces-219136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0FD90CA4A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7422905FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC6877624;
	Tue, 18 Jun 2024 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcILezf3"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463273479
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709848; cv=none; b=crjbguKRtRWMKRKdAixDH/ZOFkvYCCb3pwzVddQFlidf2fMJPfabZYEvNweF6iWP0AI2d77bSenbJTxm4LFplhR2snBoDUw3fuKKRfTdz1SPJYGYqBWmV8mj8w3ABAC0BATlzIdqXJflFnPIogiX+TnUhrrjdWujXCSs0N8OqSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709848; c=relaxed/simple;
	bh=S2KR4WsW3KdZmG6Ga1oOUBTEfs+YEYDZDizHajneDOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDPGDgGtufaVb7AnXnEJzpFKd7Of4rgZYs89MXAsGS30y01Oht5DEwFjWI1QpsVYn9ASHNo6C3jyBYD+oYu3AWnvQZ8LGLQ+k2t4xNM0NsaIxHy1pwDbF5M/9+fUqCSSKgJPkfv36/6EE74Ly/8bSv0EpJmFaKxyibxrpPxL2oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xcILezf3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so41899155e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718709845; x=1719314645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mFH18NIhf3ZcM3sdNRq21TZRW10Sfb4fyAJ0AtyRcpY=;
        b=xcILezf3/Iy7JsSbycoLBV2Hu5DDbHwBz2TWegacNsICAfVUqCA1yQSLG4Ew7IoKJ+
         9dEg/dM3o2shl4N6d4ohKRvAbC5C8TMjQ1IwuZPy2SKgsmzOYwaceB1Urnn77+EozjJj
         wQgP5iF7RNASdaxnaATRQKIDZtFDstytrUSIx5m582Eu+vqWR7EPoAg1/0M0+6xOGOTR
         s3WTyPMmaelm47A4u8+8NI9UTE1XeEIdYWDlPrHA4uMA2KKgqtDRuSwVBjOORJF1EpIh
         1FK81LhlleK+gIKRtgIwuObvfnEIEGBO0L/D/bQ4+aKvxpV5SQqFSmtVBtwpvEggzF66
         kWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718709845; x=1719314645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFH18NIhf3ZcM3sdNRq21TZRW10Sfb4fyAJ0AtyRcpY=;
        b=T8rP8K1OspRX7RmdgkO8PrfRds7jYqVHca8EtQkRu2+bQG/Hk+1FU0h21RzRAkoOwB
         dhQpq0+fY9h0DhYD1t+PYLVf//RfQNAAY6sDCswDsgK1FAfhx/22CgUHSQXSstXf9QVL
         0m41jGRInQiaOMYRzahVvBPgfPKRxO/LVSlewkReOvZEqO5T4rz4E/cffQEL5OpocyN5
         O2Vx0dRWwD/Ubn7CyI7Ada6gnbTLVIu9w4DkH6zmqgTrwjAMuJ/AdTVd/kT+ZN0jMqMX
         yStL/2il+K7W/QH7A8c7GEnGOuVlPIxyiKMLGh4yrqJ/Tx/VJvkhbaw9JCNC49G5+D8H
         16MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxJNrcyxQ0Sl+VO5BO36hscdxxp+vKEeYdl9VIb0Doz4oaKUpQgw5ht+4qgpthKddDgBIo+wQzowFlsqPkDhFheko7bEugFk0GJR18
X-Gm-Message-State: AOJu0YzXcOB1CMP1vXAKMZf9wGmhbseXxVhLHvU79AiF3LFVlVu3UOdl
	MFnGxLPfJ+jflAJA+iElTL4K4L1LfYrMsqLNMqM6yqIvHx76S/M4bIWq+ZQ8r6Y=
X-Google-Smtp-Source: AGHT+IEIjwDGscRJNKduj5I1aPEJR6P9X82YrmJGStHP0EnDSdfzeVNf/Hhz3/n6J5Z6St3suQXC3Q==
X-Received: by 2002:a05:600c:468d:b0:421:2ddf:aec4 with SMTP id 5b1f17b1804b1-42304844f6dmr101885995e9.30.1718709844764;
        Tue, 18 Jun 2024 04:24:04 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320c2csm185772695e9.36.2024.06.18.04.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 04:24:04 -0700 (PDT)
Date: Tue, 18 Jun 2024 12:24:02 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] kdb: Document the various "md" commands better
Message-ID: <20240618112402.GB11330@aspen.lan>
References: <20240618003546.4144638-1-dianders@chromium.org>
 <20240617173426.2.I5621f286f5131c84ac71a212508ba1467ac443f2@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617173426.2.I5621f286f5131c84ac71a212508ba1467ac443f2@changeid>

On Mon, Jun 17, 2024 at 05:34:36PM -0700, Douglas Anderson wrote:
> The documentation for the variouis "md" commands was inconsistent
> about documenting the command arguments. It was also hard to figure
> out what the differences between the "phys", "raw", and "symbolic"
> versions was.
>
> Update the help strings to make things more obvious.
>
> As part of this, add "bogus" commands to the table for "mdW" and
> "mdWcN" so we don't have to obscurely reference them in the normal
> "md" help. These bogus commands don't really hurt since kdb_md()
> validates argv[0] enough.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  kernel/debug/kdb/kdb_main.c | 39 ++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index cbeb203785b4..47e037c3c002 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -1516,14 +1516,9 @@ static int kdb_mdr(unsigned long addr, unsigned int count)
>  }
>
>  /*
> - * kdb_md - This function implements the 'md', 'md1', 'md2', 'md4',
> - *	'md8' 'mdr' and 'mds' commands.
> + * kdb_md - This function implements the guts of the various 'md' commands.
>   *
> - *	md|mds  [<addr arg> [<line count> [<radix>]]]
> - *	mdWcN	[<addr arg> [<line count> [<radix>]]]
> - *		where W = is the width (1, 2, 4 or 8) and N is the count.
> - *		for eg., md1c20 reads 20 bytes, 1 at a time.
> - *	mdr  <addr arg>,<byte count>
> + * See the kdb help for syntax.
>   */
>  static void kdb_md_line(const char *fmtstr, unsigned long addr,
>  			int symbolic, int nosect, int bytesperword,
> @@ -2677,26 +2672,38 @@ EXPORT_SYMBOL_GPL(kdb_unregister);
>  static kdbtab_t maintab[] = {
>  	{	.name = "md",
>  		.func = kdb_md,
> -		.usage = "<vaddr>",
> -		.help = "Display Memory Contents, also mdWcN, e.g. md8c1",
> +		.usage = "<vaddr> [<lines> [<radix>]]",
> +		.help = "Display RAM using BYTESPERWORD; show MDCOUNT lines",

I'd prefer "memory" over "RAM" because it's what the mnemonic is
abbreviating. This applies to all of the below but I won't be adding a
"same here" for all of them.

Where we have to crush something to fit into one line we'd than have to
break the pattern and choose from thing like:

1. Show memory
2. Display RAM
3. Display mem

Personally I prefer #1 but could probably cope with #2.


>  		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
>  	},
> -	{	.name = "mdr",
> +	{	.name = "mdW",
>  		.func = kdb_md,
> -		.usage = "<vaddr> <bytes>",
> -		.help = "Display Raw Memory",
> +		.usage = "<vaddr> [<lines> [<radix>]]",
> +		.help = "Display RAM using word size (W) of 1, 2, 4, or 8",

We need an "e.g. md8" in here somewhere. Otherwise it is not at all
obvious that W is a wildcard.

I guess that alternatively you could also try naming the command with
hint that W is a wild card (what happens if you register a command
called md<W>?).


> +		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
> +	},
> +	{	.name = "mdWcN",
> +		.func = kdb_md,
> +		.usage = "<vaddr> [<lines> [<radix>]]",
> +		.help = "Display RAM using word size (W); show N words",

Same here.


>  		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
>  	},
>  	{	.name = "mdp",
>  		.func = kdb_md,
> -		.usage = "<paddr> <bytes>",
> -		.help = "Display Physical Memory",
> +		.usage = "<paddr> [<lines> [<radix>]]",
> +		.help = "Display RAM given a physical address",
> +		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
> +	},
> +	{	.name = "mdr",
> +		.func = kdb_md,
> +		.usage = "<vaddr> <bytes>",
> +		.help = "Display RAM as a stream of raw bytes",
>  		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
>  	},
>  	{	.name = "mds",
>  		.func = kdb_md,
> -		.usage = "<vaddr>",
> -		.help = "Display Memory Symbolically",
> +		.usage = "<vaddr> [<lines>]",
> +		.help = "Display RAM 1 native word/line; find words in kallsyms",
>  		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
>  	},
>  	{	.name = "mm",
> --
> 2.45.2.627.g7a2c4fd464-goog
>

