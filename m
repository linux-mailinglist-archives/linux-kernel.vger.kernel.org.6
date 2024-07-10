Return-Path: <linux-kernel+bounces-248272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C883892DB14
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29CC1C211D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5BA135A65;
	Wed, 10 Jul 2024 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzZV56Er"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201C0D535
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647368; cv=none; b=VzB5xcmsjFG+wa4Rbl17/fc8jnD4jx6VYbFodxPamNKXljeV4Ox2fXo9N4alMbHKuHJhdun4lSJEXFuRLYB0ArnveQtm3BepHGsksY50dAEvazgbCyZs4DJfEGnpOygq+xkjUvArjkLvBBYRfsMW0n6HFr77wQxvr66uW1Zezao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647368; c=relaxed/simple;
	bh=n/m9HkSOMmRaMGMms2bR9C366NqARG97kbpDgVzcgfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXDww4eantbTyY7530WMnO4XBrGKUgNoJj0OJTFKGJjAG/VCQyNuUI5lhX4sFE8tEHVMyU5uUSZW5XIX6CfS8iHDliFW4mu++dXKJtGapw8USZeGkH8uOEbP1AMbsRC68nhcHfzNh2uvILvapSBcB4CJuPeBXnhlPXmdFCSndBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzZV56Er; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb4a332622so992045ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720647366; x=1721252166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=neoSmIQD9fiLUW0JU5eiOnLcyT1Su7MFLG8PD6ZE0Sg=;
        b=kzZV56ErUXITElErwIfZL4SxK93rqGhtBEt+QC3WxSiPQqU0yBURDWKUv2i9JRnD1m
         RFjdWPhhbZl5e7GfgMycVgFSz+yFLlE7mK/nj+cF5WqYkL900ErVEA8u4FP33jqQP3Dq
         YoMOGCvnnenUUSd4B2/Uf4RuU7IlojQzwWhRSGC6Aeqk4SvYzFRsRO3Lc1WLRrJ2MXMs
         kFkzqmxp7rS27bL+SBv0bcCU7j+KIhxmJUmzm3N65ppRfwJK+esTsXmIFLVZAL3AkQ5K
         ZM3HKdO8Phcxd+fjlFc4cG1gpoAfOj6xuhyBL1dazDCczqktPaGCQv4AhQSMySDwrcBj
         FczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720647366; x=1721252166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neoSmIQD9fiLUW0JU5eiOnLcyT1Su7MFLG8PD6ZE0Sg=;
        b=uVVd8vbyfx2Gp9Sxy2ZItl+phEW6PcWcT8B1lbZN4UN5bZQo/vCik3ho38GsBs43g4
         m4LZ3WMVHHl9MJ1wR+kHEc1JIZbook/XzfxXH9JI8dGo7FtFuRdrZy0aH6bKTrOYfcAz
         mGvKEIrk855RfwJSEPg2SrShXLzk0g3SDwD0sEBOVBCJumxOnvDk75mFwU+fF871R0gy
         5k9SO5gyTau6DED4vMljx2ihtyHnD0n3fXAB+R3rBYQnv5OO7hy04vKwirjX0S2zlesJ
         MCTdg80dUG+oRgkRccUfK6SH2zBs/ZunYxYRA1IHGavqAGZY/rasFk2C2pHcFEORUnrO
         nE6w==
X-Forwarded-Encrypted: i=1; AJvYcCXF/GWQnZqF+ir7i17Y75hVhhgWyTBeo1LEiY18brbbWtLl5cDHd6mEDXLRFPG8Gee3oobnvEsFzAvbesUYsJLIT8r2fe1lpD2Rzd7t
X-Gm-Message-State: AOJu0YzFKzD761O+AkQL4Bvb+wHJdcs+OrsKN/ZGL6DuWsPzbpQBIztz
	JdRA9CC0Nc3eV/n5ifGxW+31Eb9AR5CcpOJ4X8Jd3tku3anPCQiS
X-Google-Smtp-Source: AGHT+IE6MKZr+hsRKsCdU1IHNJ855fgshln8OWlyyfh4JG7Ez2Z5JXXJsHZr5fmgGpaCN6UcLT558w==
X-Received: by 2002:a17:902:cec4:b0:1fb:58e3:7197 with SMTP id d9443c01a7336-1fbb6ee1dd5mr59821215ad.66.1720647366316;
        Wed, 10 Jul 2024 14:36:06 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a0fb67sm38228865ad.4.2024.07.10.14.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:36:05 -0700 (PDT)
Date: Wed, 10 Jul 2024 14:36:04 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: linux@rasmusvillemoes.dk, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Remove unnecessary int cast in variable_fls()
Message-ID: <Zo7-xDMFXVpIqyuR@yury-ThinkPad>
References: <20240710202416.710880-3-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710202416.710880-3-thorsten.blum@toblux.com>

On Wed, Jul 10, 2024 at 10:24:18PM +0200, Thorsten Blum wrote:
> __builtin_clz() returns an int and casting the whole expression to int
> is unnecessary. Remove it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Added in bitmap-for-next for testing.

Thanks,
Yury

> ---
>  arch/riscv/include/asm/bitops.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> index 880606b0469a..71af9ecfcfcb 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -170,7 +170,7 @@ static __always_inline int variable_fls(unsigned int x)
>  ({								\
>  	typeof(x) x_ = (x);					\
>  	__builtin_constant_p(x_) ?				\
> -	 (int)((x_ != 0) ? (32 - __builtin_clz(x_)) : 0)	\
> +	 ((x_ != 0) ? (32 - __builtin_clz(x_)) : 0)		\
>  	 :							\
>  	 variable_fls(x_);					\
>  })
> -- 
> 2.45.2

