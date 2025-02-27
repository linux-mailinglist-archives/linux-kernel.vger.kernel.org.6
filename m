Return-Path: <linux-kernel+bounces-535955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE7BA479BD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01EB81891D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC29522A1CD;
	Thu, 27 Feb 2025 10:04:43 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE1B225A47;
	Thu, 27 Feb 2025 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740650683; cv=none; b=pR/uudF8Ed3mctynxY9wQjzF9f6Msy8g2JQEkQoqGmzaADjxqfNRZFTGEuP83SsYY2UlDGmJ3FmvN8z5GhWjw1WiScT2XzDH1T4apu0OdT1IxFXkkgU0/DcZRfHtchOAmu3X/RUr4WLwBJg41+98ufCUBG/Z7vZ5ejMPBSAPJGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740650683; c=relaxed/simple;
	bh=dcwpo0WfdhAJFEVKxmgTcIJcESYPSNa5UHbw/pELZRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foRjINglBmGnUrLr2mJGjkfhdlWNL8Y7YZkBsC6E+hvQFwjkR7LvhqkTGoz/4bxsyuKoh7pP7wN4EeePMqDjV/F8ms/TNv49QhV+NK3zAO6SxMPSUzivEpesNwSD1tUDOGvK+pJgFa/ygbD1Pc6mcwLeMf1yFQDJoUYinpVd334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1tnakv-0007xY-00; Thu, 27 Feb 2025 11:04:37 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id D2924C0135; Thu, 27 Feb 2025 11:00:18 +0100 (CET)
Date: Thu, 27 Feb 2025 11:00:18 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: WangYuli <wangyuli@uniontech.com>
Cc: chenlinxuan@uniontech.com, guanwentao@uniontech.com,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	macro@orcam.me.uk, niecheng1@uniontech.com, zhanjun@uniontech.com
Subject: Re: [PATCH 1/7] MIPS: dec: Declare which_prom() as static
Message-ID: <Z8A3sucKlB5i0zd9@alpha.franken.de>
References: <487CE8AA937621E2+20250218125101.663980-1-wangyuli@uniontech.com>
 <22CF8506E42636AF+20250218125431.665670-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22CF8506E42636AF+20250218125431.665670-1-wangyuli@uniontech.com>

On Tue, Feb 18, 2025 at 08:54:31PM +0800, WangYuli wrote:
> Declare which_prom() as static to suppress gcc compiler warning that
> 'missing-prototypes'. This function is not intended to be called
> from other parts.
> 
> Fix follow error with gcc-14 when -Werror:
> 
> arch/mips/dec/prom/init.c:45:13: error: no previous prototype for ‘which_prom’ [-Werror=missing-prototypes]
>    45 | void __init which_prom(s32 magic, s32 *prom_vec)
>       |             ^~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [scripts/Makefile.build:207: arch/mips/dec/prom/init.o] Error 1
> make[5]: *** [scripts/Makefile.build:465: arch/mips/dec/prom] Error 2
> make[5]: *** Waiting for unfinished jobs....
> 
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  arch/mips/dec/prom/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/dec/prom/init.c b/arch/mips/dec/prom/init.c
> index cb12eb211a49..8d74d7d6c05b 100644
> --- a/arch/mips/dec/prom/init.c
> +++ b/arch/mips/dec/prom/init.c
> @@ -42,7 +42,7 @@ int (*__pmax_close)(int);
>   * Detect which PROM the DECSTATION has, and set the callback vectors
>   * appropriately.
>   */
> -void __init which_prom(s32 magic, s32 *prom_vec)
> +static void __init which_prom(s32 magic, s32 *prom_vec)
>  {
>  	/*
>  	 * No sign of the REX PROM's magic number means we assume a non-REX
> -- 
> 2.47.2

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

