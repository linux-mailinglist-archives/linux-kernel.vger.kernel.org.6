Return-Path: <linux-kernel+bounces-547034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2D7A50203
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8827D1888B30
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C62221F29;
	Wed,  5 Mar 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXbTG01J"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568CD248886
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185025; cv=none; b=otLk+iTIxxZy7S18O4mvRiBSDGlNf64nnqp4MNK3Uvqm7Cdj7R2uYEx/UyvdsbSFTefWvy6nuqsLuXFBts7jmagg8kk6S6ryWKTlzFmBCa465WLRnDGsp6s/By8iGKlwypZRC8xYsll26vqe61vqwpTJmAJDXdaWzL18ZYWe7xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185025; c=relaxed/simple;
	bh=uXqdJWInzp4b/tyNcB0XmY0lIx79KLmi40HUS6Ev0KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bILIum51/jEkiTxEjr/2CBOHJB2dOyy1U+NrkAjVViGc0KJ92hQk/UQ021sq7ICpDPZbixk/3MDSA7rvRnbJ+HYP2vALUROOu1tE9Rqwzh5FJx8+ju0xRqcE7Gwd8tG8GWV+iRXzkzFcT7oEMVtcL8u5KUtDJyqXioIX5+XXtk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXbTG01J; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2238e884f72so73214245ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741185023; x=1741789823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IlwlCKrm1BqwlFcITao3/COM3kL1lolnoHqB6b1uB4E=;
        b=kXbTG01JAICssA7a1ElNDncjAgN8fiTvfcNw1VAzIys5fGN0oCzANAeogmP6ozZzzu
         cnMlijuS82SWaOu/qiXA9M+FK4njCd/wEbHiB5mfAhEjM457bXxo2a9xEbTqUuGgN8e8
         1gwBzyVRSrU6t91Ing0aSo3Hh6A/g2hWzvRYIA3Nmf8yKyxlF+xlsI19hhFLwyAmQ66K
         7PxoBBdaWR3XoCP1R3QhvQPolU7e8/uqNgtNiryCpDp3UZCdMa47642tEm0oOl2+pZsd
         ip7NVNhMK5FMTFgwo6zLx1Q8Z8zWkgNoGJ42f27y3sL6674H6WOLwt41W+B7PTW+L7Yb
         AwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185023; x=1741789823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlwlCKrm1BqwlFcITao3/COM3kL1lolnoHqB6b1uB4E=;
        b=VYT8CKdPRqrXIocx6RGBlsiremG5iSItiXr0xLRoCSODIioipozBbq2Itki6mDb/Z6
         fcMvO1SSB8wITMYeUqM+kKXl1NrfxK59XmApUkWdX63umcKV4VzqVj6ODkn+vXCqD5SE
         l2Gh5ixNMHX8tYoWvoGrE73Ghli458EkBqO0CrRGKe3eECYqOZQokBlInwcB+8Ul64UN
         wW8tIVcKvocFTqCJSXatEgvq0eBhH9HcfNIk1exKAQQBBEhSa5NT/oRcG9jPtM3SG5F7
         CxEGWlC1/NZHcd6isByUU4YJV0f3eti2I5ku/RhOUgaHQppG39Wqjn331IRb0K/mhejf
         pZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAGx2JHxmDXycROLUslLpQtYSEHN1QeOZTTFYngkMhSbMN/zPRLBZ73DmP2foNrnnYlpXe3lzRdlvLddQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh0aqs8Bg4HOJmztyTejmRBDfnc8QUpOiDXltiA7gdNbKTLG/y
	zdK0D8nMiAn627V30fl5L4Oebmqqud7e2yylVJvJsAC9tVOsZH64
X-Gm-Gg: ASbGnctLzO/jk1OXeY+YyBY3ZD17dE2u51wZ6kb2+/iSF15JqrEMudRJc918kPh6hFO
	xM+7ySDBrGYAPEC7PE+hfMBVRmeLDvouPfwllSyFIEEOqZbBd5MjHWSTNtXW9ViN9xUqPZdl3XI
	Pf2qxETIKgwLxEQgS+VhPvNthkEh/FLY/vhGUjVC8F3Er4AqloOBKt0ok+khxH46XqzDTLZxCrl
	oK415o+N73dzjC42cv2bfSsMsIQTuuSQ7RSkAlLSbfxwLS8qBvZkSzMGHUkNPLyJPjF22owQVx8
	IwOGIINfSZsVwg9aHssNZIqLGaINlu9/IBKeqcDseKm2
X-Google-Smtp-Source: AGHT+IGOw7ho1UUAoxDldP562F3+Ghc7uXtkeFsOxJJC2qch+UBSxhGnmdxoaMccdDcCbb1p7rm4RQ==
X-Received: by 2002:aa7:88c1:0:b0:730:d5ca:aee with SMTP id d2e1a72fcca58-73682cd83c7mr5625290b3a.23.1741185023345;
        Wed, 05 Mar 2025 06:30:23 -0800 (PST)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2a64bsm13411865b3a.11.2025.03.05.06.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:30:22 -0800 (PST)
Date: Wed, 5 Mar 2025 09:30:20 -0500
From: Yury Norov <yury.norov@gmail.com>
To: mailhol.vincent@wanadoo.fr
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 1/8] bits: fix typo 'unsigned __init128' -> 'unsigned
 __int128'
Message-ID: <Z8hf_MNL3MeoXW5O@thinkpad>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-1-1873dcdf6723@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-fixed-type-genmasks-v4-1-1873dcdf6723@wanadoo.fr>

Hi Vincent!

On Wed, Mar 05, 2025 at 10:00:13PM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> "int" was misspelled as "init" in GENMASK_U128() comments. Fix the typo.
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Thanks for respinning the series. I'll take this fix in bitmap-for-next, so
if you need v2, you'll not have to bear this thing too.

Thanks,
Yury

> ---
>  include/linux/bits.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 61a75d3f294bfa96267383b5e2fd2a5d4593fcee..14fd0ca9a6cd17339dd2f69e449558312a8a001b 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -40,7 +40,7 @@
>   * Missing asm support
>   *
>   * __GENMASK_U128() depends on _BIT128() which would not work
> - * in the asm code, as it shifts an 'unsigned __init128' data
> + * in the asm code, as it shifts an 'unsigned __int128' data
>   * type instead of direct representation of 128 bit constants
>   * such as long and unsigned long. The fundamental problem is
>   * that a 128 bit constant will get silently truncated by the
> 
> -- 
> 2.45.3
> 

