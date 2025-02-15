Return-Path: <linux-kernel+bounces-516185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40E7A36DD6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 12:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A38A3AE727
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 11:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757AC1C6FE4;
	Sat, 15 Feb 2025 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFR6ykqh"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF141B4F0E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739620087; cv=none; b=b4R0Qs5i0xuZGA0SDN7N5qMXbNA6D58mZjJF39MEh14mOE0NfS22588Thii6zk/71PRU7qrLg8u7ngnB/jzS4dlsp/z7mtnyEld5+pBP6tkHThHUCLrZN8RaddEC59e70g59FA5ev9qFvYHTP7yqUUPi811mJMPAGCbcfXsb/xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739620087; c=relaxed/simple;
	bh=9heQ1zUiZ05X1o9WKtbn8WbBRXPHecr6FUoihk1IyNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqunAzwrNmuOLLdZQSx+1UW3jDewlDKJR+XD8JQZ2JU2DE1L7Fx04ZobxH/YwDlmxdlkZpjmEIJNvhsuLF69wgn1jK0EfcqXlNxdW79ki1RiH4lM/YaafTiGzUf6evWdo4NUXZgbl6oTwwDuLjIPp2SJtPwOK5AOdv0z8rov3vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFR6ykqh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso19272335e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 03:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739620084; x=1740224884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQ/7+76o2RkF0Tl1UnQ8iR0C7JbSGtAyttTSJZXazLM=;
        b=WFR6ykqh45DSoHZbtkQq09+Ojga0No5DNMs8N86y0t/UAN6eGwmXAKq27soouddlzW
         XGrlcEqNihWa+mwNV7+j6jf3Na5EBdD0AE87TrdjttRcBP9RsJkyhXWf+IsKeBSx5iHz
         RxfcdMJbSEcMgTFH/VD3SeeEgGq4mlVHgZW1k1KyoSUSdzZKdmgwYmmu47nRLc4Ueune
         4gHDmvV56AgW+iOHk7yBmjgTa6/zgegXTYXPnHB0QD/qTe9M95o9eDWwNLhYP0Hq2IFO
         T3+5S4i9hoZZOFJKMm7LD0/nB6Z0+rqaDutQv6TQ3lWtyGuv3xoQ+BZmascZEnmGoGci
         6Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739620084; x=1740224884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQ/7+76o2RkF0Tl1UnQ8iR0C7JbSGtAyttTSJZXazLM=;
        b=a5R2HQTOc1FdluPJ9TTrBcVGKqpG6DW8yMX2LLPl1I3jQViBxNFngVRv4QPYTkP+aI
         XsRgPe/n/16F/wqDdlk4lWSRIfU34zq9xGjYIYEe8cxTaiUNAuyeCIJYvG/KXuQh74x6
         Gy+6IOPplPuvtQJ6p487Qxb6M+6o9QhmqSjITf8vi9Z8dBConKh/I4jcBSrGm+3Aek6A
         5f4gKK6VmkOunf4teU76ULcYaAlIDXsvocOg4sNbzaKzTaxuurVGM2EMiXE5dwAsugd9
         0ftNtnamLQ9hTqqHoP8Iph+YWAb7u1AVU6+al7RQ0iuL2+tyYRxqKLpf64/4L4vAjxhq
         /SJA==
X-Forwarded-Encrypted: i=1; AJvYcCWxCNVfMMCKXlLYg8Xa5Z0J28suSy6q9jm7Ok5omRjFi6wJB+pFe0nhWBSP5i3SkbUixkjwPqVt5DIW7C8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd5vnTqRm4ES8bX6UJc5m3+dRJDnNho6vu2zaFZGxAUFCWpJga
	ko6M6EFgV1SQikzqEI56eTPNwj66Nj1plSU0jxi0ojXDuyP4xyx0
X-Gm-Gg: ASbGncuMoSxACQXUvngj5w3OMXCJJT9F4ZOgw9tvRztzR0nO67nmH8ErWsYa2QU0/on
	fwjXAShih7qW9GPIJVfeVwb8REIP2fPFJmo2EjUvX8eaoltuFGIPalV8vP10KnIfnsD+iNicK46
	ZjCKwWi7linX0/8+5JtTRS65MZ4p+BJ4iFevZqmA8HLqz/9yJ9G9XWitnqvnvowM79+vnFdMTub
	yHSWWD4ZTeTv7EdcHPzLOdYv+dBVjsdhx+BV8uYRkUOdn/yOR9GjlYsEv9iQSqqONl0CTBbdMDJ
	UInM2CfRf5sC3eMed1XO6ja/8L3zfDBzbNXm5FBKOmypDxvjCv4Bxw==
X-Google-Smtp-Source: AGHT+IG9wAuFKj8al+/9GVnUsbtRcAxewKh3xIAG7tudThRlYZibB8RpchKc8FmJB8sL1EQNhWvqTg==
X-Received: by 2002:a05:600c:4711:b0:434:a315:19c with SMTP id 5b1f17b1804b1-4396e6ab01dmr31632435e9.3.1739620083758;
        Sat, 15 Feb 2025 03:48:03 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439618262d3sm68067885e9.22.2025.02.15.03.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 03:48:03 -0800 (PST)
Date: Sat, 15 Feb 2025 11:48:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Noralf =?UTF-8?B?VHI=?=
 =?UTF-8?B?w7hubmVz?= <noralf@tronnes.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] drm/repaper: fix integer overflows in repeat functions
Message-ID: <20250215114800.5c8d8d2b@pumpkin>
In-Reply-To: <cx4efp5kx3hahymdtgrjwu64373du4vg2v7errm3t34exrgezn@weo6exjuq2fu>
References: <20250116134801.22067-1-n.zhandarovich@fintech.ru>
	<ejsf4dwcyg7j4wdpdtbs56lbwokzlq65fxn2gxio4l5xg6di2r@pmnpafv3nwxz>
	<20250214132910.2611f9cd@pumpkin>
	<cx4efp5kx3hahymdtgrjwu64373du4vg2v7errm3t34exrgezn@weo6exjuq2fu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 20:02:01 -0500
Alex Lanzano <lanzano.alex@gmail.com> wrote:

> On Fri, Feb 14, 2025 at 01:29:10PM +0000, David Laight wrote:
> > On Thu, 13 Feb 2025 20:54:59 -0500
> > Alex Lanzano <lanzano.alex@gmail.com> wrote:
> >   
> > > On Thu, Jan 16, 2025 at 05:48:01AM -0800, Nikita Zhandarovich wrote:  
> > > > There are conditions, albeit somewhat unlikely, under which right hand
> > > > expressions, calculating the end of time period in functions like
> > > > repaper_frame_fixed_repeat(), may overflow.
> > > > 
> > > > For instance, if 'factor10x' in repaper_get_temperature() is high
> > > > enough (170), as is 'epd->stage_time' in repaper_probe(), then the
> > > > resulting value of 'end' will not fit in unsigned int expression.
> > > > 
> > > > Mitigate this by casting 'epd->factored_stage_time' to wider type before
> > > > any multiplication is done.
> > > > 
> > > > Found by Linux Verification Center (linuxtesting.org) with static
> > > > analysis tool SVACE.
> > > > 
> > > > Fixes: 3589211e9b03 ("drm/tinydrm: Add RePaper e-ink driver")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> > > > ---
> > > >  drivers/gpu/drm/tiny/repaper.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
> > > > index 77944eb17b3c..d76c0e8e05f5 100644
> > > > --- a/drivers/gpu/drm/tiny/repaper.c
> > > > +++ b/drivers/gpu/drm/tiny/repaper.c
> > > > @@ -456,7 +456,7 @@ static void repaper_frame_fixed_repeat(struct repaper_epd *epd, u8 fixed_value,
> > > >  				       enum repaper_stage stage)
> > > >  {
> > > >  	u64 start = local_clock();
> > > > -	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
> > > > +	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
> > > >  
> > > >  	do {
> > > >  		repaper_frame_fixed(epd, fixed_value, stage);
> > > > @@ -467,7 +467,7 @@ static void repaper_frame_data_repeat(struct repaper_epd *epd, const u8 *image,
> > > >  				      const u8 *mask, enum repaper_stage stage)
> > > >  {
> > > >  	u64 start = local_clock();
> > > > -	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
> > > > +	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
> > > >  
> > > >  	do {
> > > >  		repaper_frame_data(epd, image, mask, stage);    
> > > 
> > > It might be best to change the underlying type in the struct instead of
> > > type casting  
> > 
> > That'll just make people think there is a different overflow.  
> The commit message should describe which overflow this applies to regardless.
> 
> > It'd also force the compiler to use a wider multiply.
> > 
> > A more subtle approach is to change the type of the first 1000 to 1000ull.
> >   
> My reasoning for favoring the type change route is as follows:
> 
> 1. I'm not a big fan of using the standard C integer types especially
> mixing them with the fixed sized kernel integer types for these kinds of
> overflow scenarios

I'm not sure whether the code is converting seconds to us or ms to ns.
But in either case 32bit is plenty for the configured timeout.
Whether that is 'unsigned int' or 'u32' doesn't really matter.
If you change the type to u64 someone is going to decide that the
multiply needs an overflow check.

OTOH use of 'unsigned long' is often an 'accident waiting to happen'.
There are far too many of them used for clock frequencies and similar.
I'm sure 'long' has been used because of worries that 'int' might be 16bit.
Even when Linux was started that was never going to be true.

	David

> 
> 2. It would remove the chances of this field causing the same overflow
> issues in future development
> 
> > Personally I like to see the units on variables containing times (x_s, _ms, _ns)
> > since it makes off-by-1000 errors less likely and you can more easily tell
> > whether overflow if likely.  
> Agreed but this is out of scope of this patch
> 
> Best regards,
> Alex


