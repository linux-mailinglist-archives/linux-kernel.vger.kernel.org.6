Return-Path: <linux-kernel+bounces-566490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5946BA678B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B244E179994
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27AF20E33E;
	Tue, 18 Mar 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqBAGtqK"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF971DC9AB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313992; cv=none; b=HuGvfmLivnTTjqq3k+AuQn4N52o0ApCUmEEQuhAS3DUEncGHYfuBHOyzq8/jiLKp5W9RxLWcTctAzA5p/xtIyNy1au5CyWQaDth7VHVQ9cb1Ee0eoG+aHxmkGSg1H1OdZ+dYOSaaDtuLAin5ZcudlrLHyxwjOlskkMmphN0c1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313992; c=relaxed/simple;
	bh=/QbQBuMIoaF13YEOBiyC5HL0Eyg4ljyM+9P9IW7At3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPlh0RAHEDr2F2M2PbkPPBTsK0G6Ll+/9c4cqYruQwUXFH0cDarGXc1NmbzmYGBdUr19BEpFEJp8x3zYzJz/wDz/ePb+TjelNDp5v+bVMgbJJvpcYQDimbDa5BSfvSQLGI2f5PQv/lOBwBNvrBxL3EPYKyo5EllJalcOvjQXvbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqBAGtqK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22423adf751so102504165ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742313986; x=1742918786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z6e2c0Qk/BdFEUgDNlLPZ7gWsKGT2P7lxLRmr+kXCn0=;
        b=TqBAGtqKyGna7d4UNiLKaOJt/9+z0JKnHRbc1s4U2obYS7S0DoDX8IoDK/yrUmppS0
         7CaCe+7w2KvGF4tJHCmHLX2thWNy1k9h9oHdLmM4UhZY40VnhLxNS9f/eatqNPdWygF+
         YsNN7dnUDdYCacvnT0HL8TH9mUPdcSEsFjNMZVgh+NrDjbD0v9NGG7BXLyXHgQz0Nrbr
         yr4hq3M/7qiC5F2EjG2IgW0EbkA2szO4Jiq75DabIAvs7Z5zZ9GvGurlCjre+v9pXC0v
         5qI4p4wBdfQiv2zNk5DqzoE2/RBN0YwUaKT0i5nfTWlp0gRISmgieBNTydFT+n1LrNWK
         92iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742313986; x=1742918786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6e2c0Qk/BdFEUgDNlLPZ7gWsKGT2P7lxLRmr+kXCn0=;
        b=POUEaUKoE7rnwLxzbANV/Tkiv5OHHX3f8uRt9c5s90wzRBiTNq+iY8i7MfpVQ6JAbf
         5ruTY4rzUVzePpDtRI5OZPgF7kIdvsnu2HCJkNrLlX8yDUIattyZ0VheB354suSTnNp2
         w8iVcfcKvGbaRdciNhRQy06fxFid0sMjz+XnULyad9s3T+6gTATbtSC0Ml3F7jqFOqMP
         hiQi0+gOgE6MsxRStyiRPGbirhu/LjCIzqJg+3pmID0cdJgcxBuU3AWAvLY6iFh+BFps
         2sJh6Q7WQ/9KFvmyXOHW6H8zslJr/B8msiFsFvc7RSiJIPL5rveKR1I7LvdLezFssA+s
         tzCw==
X-Forwarded-Encrypted: i=1; AJvYcCVJSYpB9lHnby6Jn09+P9BzLpNdER9g+TC1cTJaYvA+N7QbjjVEQxk/5LVPa+7n6TMP/fiOOi7Ua3zqhW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH7y/GnjJ2am8uKbz2snQjjx25rVgaAWv1CbhhxczZr7/Dat/5
	UV0ffBH2cfF6s5i9B8zOLFBSxxbkh4ckN058bze4UlNoB4r/3LWD
X-Gm-Gg: ASbGncukeXsxpOi/8oMomO23xYKzOONIMywcIJq0///CTmsoX5UNSJFciaEHNYjp1Cs
	U+wUVxuWEbco+1+CYGJeoLzTXc4urJEafKoe9ZQvq5jA6iFMTbeNXa1vkXH8FeLF/whYU6RUzN+
	d3pO1yyaUbqcmZPxa2mulbTgU91zM9c0xUpIXGQNqJdHLxikDolh+qfqXdFFt0zCrywqUF3B5if
	D1JqO/kgPKtKTX+B3rTKeouWofT5PGszVFRbfHUJkw0E88sXUsdE8krIQbfnC8P3RyHHdVWsVjq
	D/syyaGeosrO/WvHVgqcqxKcH//7RYnKSB3oqozLAqAKy4aAMR2ThMTWX3KRsi+SMF7v
X-Google-Smtp-Source: AGHT+IGW5/tNqjQ0xTitfPIj7GeM/eN4Wy3Jsl0PgukZG9i0xnTDK3BvONiq3fuytb5V/HKrSq4TFQ==
X-Received: by 2002:a05:6a21:9006:b0:1f3:40a9:2c36 with SMTP id adf61e73a8af0-1f5c118107emr24562658637.10.1742313986538;
        Tue, 18 Mar 2025 09:06:26 -0700 (PDT)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b102fsm9758563b3a.166.2025.03.18.09.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 09:06:25 -0700 (PDT)
Date: Tue, 18 Mar 2025 12:06:23 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
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
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v6 1/7] bits: split the definition of the asm and non-asm
 GENMASK()
Message-ID: <Z9mZ_xIMyqUg2Vs9@thinkpad>
References: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
 <20250308-fixed-type-genmasks-v6-1-f59315e73c29@wanadoo.fr>
 <Z8swIt7fqpVAp2P8@smile.fi.intel.com>
 <85639227-68ed-4a8a-8084-1ae0ffcaa638@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85639227-68ed-4a8a-8084-1ae0ffcaa638@wanadoo.fr>

On Sat, Mar 08, 2025 at 06:10:25PM +0900, Vincent Mailhol wrote:
> On 08/03/2025 at 02:42, Andy Shevchenko wrote:
> > On Sat, Mar 08, 2025 at 01:48:48AM +0900, Vincent Mailhol via B4 Relay wrote:
> >> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >>
> >> In an upcoming change, GENMASK() and its friends will indirectly
> >> depend on sizeof() which is not available in asm.
> >>
> >> Instead of adding further complexity to __GENMASK() to make it work
> >> for both asm and non asm, just split the definition of the two
> >> variants.
> > 
> > ...
> > 
> >> -/*
> >> - * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> >> - * disable the input check if that is the case.
> >> - */
> > 
> >> +/*
> >> + * BUILD_BUG_ON_ZERO() is not available in h files included from asm files, so
> >> + * no input checks in assembly.
> >> + */
> > 
> > In case of a new version I would reformat this as
> > 
> > /*
> >  * BUILD_BUG_ON_ZERO() is not available in h files included from asm files,
> >  * so no input checks in assembly.
> >  */
> > 
> > It makes easier to review the changes and see that the first line is kept
> > the same.
> 
> Not fully convinced, but why not. I staged this change locally, it will
> be in v7.

I don't understand why this change is needed at all. The comment
states the same thing before and after, but the history gets wiped.
Maybe just don't touch it?

