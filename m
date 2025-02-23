Return-Path: <linux-kernel+bounces-527625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DF4A40D6A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 09:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C053B671B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C9C1FCCFA;
	Sun, 23 Feb 2025 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TFlyGYS/"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CD01FCCF7
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740300039; cv=none; b=D28zIOHVZS02Bc9tbSEwOQksG4UTLCkFne7W9xpIqG+AK9IIENoAt8Kr3z6eynqxQe3pL0KUIee9raI8VOcRn/cOMSyk2hbIjm9awMo1MxCmq3lbGMeWTv2TVhS0SMPg7esK94I7tPLfWehI/MeOwqp7U+BGP0m+bmCo9ekL0G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740300039; c=relaxed/simple;
	bh=VMZP75rhMsZKP1h7w7GGsRJbBi7X8HJDlzKN8uf2Gog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgD9uFnF1Sm9l10HkEw2rWykzhGsGQiGo5d+cpZX3ZiBQgJDo4dzSgCoWJsj955dJpDlYH9YNyGRShtBU2hTr6SrZdBA+bhvp562ySXetYaiEXq/LDzuZpwYLWB3cFkOAj/MzjX1vZEspN60qL4/h8oHMXKgn6jglyspfMnaEec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TFlyGYS/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-221057b6ac4so64141775ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 00:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740300037; x=1740904837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9gpSGM5f9xtZjGEJveZ4GrzDJH1nRyp6hOrbTNY7Eg=;
        b=TFlyGYS/cq84tJNGn64sC1f7sOES00p4HxprGHbRt5UM8okRfDV/XbvYyBLP4v6cDN
         sMz+Uhs2cpC6Zgzcfjx7RYayAKPm4BuVUgZgne5GK+FX23wZmabtYhGrQTwg4LeDTOSJ
         bt9MTaIfB0fB5a/y/hUT9d66O1gLTVgtg3J9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740300037; x=1740904837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9gpSGM5f9xtZjGEJveZ4GrzDJH1nRyp6hOrbTNY7Eg=;
        b=tuMGUOsRc+ljiX4CKWGuGdFB27a9vUh5J1ipndivIu3oxi1Cz42ndYR8dM9cIFgPiS
         tb+xiT3W0v9XytpJlpbAKLeBTkYf/gbLXU0Sxz/yRLq6/3M5KW9+1OxHKKV9nXD86uT+
         Jyo+WxeGH8bCgn8l1RyxJ2bPc7wm5aH3zjbkGeoPOuBOAD8qtFKcKtCtDjgX9Rz2NSGq
         Cur06qahU6VX9x+jnxRUIJ8V8JXMezyGe4LcNjQW0CoymJtFlkQ0HWSfX6X2pXnYmJiV
         VqRYmBenwQyp4TKGl2s2QKYd0uK35Ym9BKa+k2hUrdBxSJOv2CQ27roQYva1UjZtPeuM
         qH9A==
X-Forwarded-Encrypted: i=1; AJvYcCUmjuYwpTKzrEDIfCNO2H1frJhr4ogMfVBmoXvx0NZGwTn+QjvfZ119u8n9CgIj64TKeh+fOBqFgZZ0iBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdPG1/WuAaJBsYAmYnCtrWudlBRjH9wdfEkj3UmQKxx50xDbMW
	3U25p/KVL77dUE9ThSTxSb6mrfWyS5/NGEPAPk1xrQQ+peeRmIeY0KNED64eKA==
X-Gm-Gg: ASbGncsVZjeQHgkjuB3T7hHJ6rqKQjoYPxjwwSxM04EjQgKokzJmFe2xVSh6ka8IR4K
	GwzjMmb6rqC2nax2ixy1DJZKzrZNppw931USbkXJ5P9fMiUYRXkXoSyVDdveSLPUpeDf2tP3q9d
	FqLKRvGwA9Njdju6k/IYkqVgVH34GJ1/N5LXDssayLDfNutHRkqZbDN2S0DufFmTVTuoUKOg1Sp
	WMFUNdbzd3sOaiP9bqZjVsUl1GpzSj9ZXuCvhY28v8lk8AaF3vkmG3M9/ZjvSx3eu6vrxLUJ5ij
	D/1Io8bweagWNQ55biY29amn4Gd/MA==
X-Google-Smtp-Source: AGHT+IHs2bEHHbTZeDzqZuSxzKMbqBVzBNfFwOrRXpSuEs7ai1npp6AoUs79mcwT90M7ZwcPaU4GMQ==
X-Received: by 2002:a05:6a00:c81:b0:725:9f02:489a with SMTP id d2e1a72fcca58-73426d72880mr13450744b3a.17.1740300037559;
        Sun, 23 Feb 2025 00:40:37 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:7eae:f032:eb08:bb00])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73266fd6438sm15247420b3a.142.2025.02.23.00.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 00:40:37 -0800 (PST)
Date: Sun, 23 Feb 2025 17:40:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nitin Gupta <nitingupta910@gmail.com>, 
	Richard Purdie <rpurdie@openedhand.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Markus F.X.J. Oberhumer" <markus@oberhumer.com>, Dave Rodgman <dave.rodgman@arm.com>
Subject: Re: [PATCH] lib/lzo: Avoid output overruns when compressing
Message-ID: <hymyvszwshcvqngjlomeyltmpghx6gges76muaz23a6cit5oe2@eas2xjgfynnu>
References: <Z7rGXJSX57gEfXPw@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7rGXJSX57gEfXPw@gondor.apana.org.au>

On (25/02/23 14:55), Herbert Xu wrote:
[..]
>  		} else if (m_off <= M3_MAX_OFFSET) {
>  			m_off -= 1;
> +			if (!HAVE_OP(1))
> +				return LZO_E_OUTPUT_OVERRUN;
>  			if (m_len <= M3_MAX_LEN)
>  				*op++ = (M3_MARKER | (m_len - 2));
>  			else {
[..]
>  		} else {
>  			m_off -= 0x4000;
> +			if (!HAVE_OP(1))
> +				return LZO_E_OUTPUT_OVERRUN;
>  			if (m_len <= M4_MAX_LEN)
>  				*op++ = (M4_MARKER | ((m_off >> 11) & 8)
>  						| (m_len - 2));

Made me wonder if HAVE_OP() in these two cases should have been
under if, but it covers both if and else branches, so it's all
right.

[..]
> +++ b/lib/lzo/lzo1x_decompress_safe.c
> @@ -21,7 +21,6 @@
>  #include "lzodefs.h"
>  
>  #define HAVE_IP(x)      ((size_t)(ip_end - ip) >= (size_t)(x))
> -#define HAVE_OP(x)      ((size_t)(op_end - op) >= (size_t)(x))
>  #define NEED_IP(x)      if (!HAVE_IP(x)) goto input_overrun
>  #define NEED_OP(x)      if (!HAVE_OP(x)) goto output_overrun

A bit of a pity that NEED_OP() with "goto output_overrun" is only
for decompression.  It looks equally relevant to the compression
path.  I'm not insisting on doing something similar in compression
tho.

Overall this look right, and kudos to Herbert for doing this.

I did some testing (using my usual zram test scripts, but modified
zram to allocate only one physical page for comp buf and to check
for overrun ret status).  Haven't noticed any problems.

FWIW
Reviewed-and-tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>

