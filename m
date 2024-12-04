Return-Path: <linux-kernel+bounces-431660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A469E433A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67356B2E83E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CD720CCEB;
	Wed,  4 Dec 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AzGw0k57"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488F20C473
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331022; cv=none; b=pErNT48dnXVb80tzk0WWysCLrGZPKqQ16jUHJYzZA0RcEfggnuIyw27du6vzy9v2m/c1MmkJuYAT43DScfSxyg8+bQOfd4XuGW2EIoAp8cZxzKO2P7pQcmfz3sRIvDoWygnVPYYUAJAPaFK2QMOKpw99bTHg4QwJJ3VyTEkuOJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331022; c=relaxed/simple;
	bh=d5JXng/rH+AlgdezfxEVPJAE2HYdoyLwl/eNJIOiK6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b63VGSkXKvwGJDnhZSEsl+uwERXTQDGROd0XsE9IqbvUGAVkiDmf76VPVU37ZePA/dLV7pYiX13MegL+ACnV0puZisb/tBaUNps/Ot5WUEVM1HrEKVtYjOwQi3/GjanmTSEzG87p8IRNreDglE4YjafiAQc0ZYi8BJJUh+R0wD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AzGw0k57; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa531a70416so453939566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733331019; x=1733935819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AmuAP6kL2PgtMtMb788SmKyfSh/8+gR/zM5UDhGblwo=;
        b=AzGw0k57m8qS6IYUWC0MhKbZWHScYQR3LGfQhM9zumUPtxr5PYE2iZyIpEuxquZMjD
         EL9o5WCX37GljKHgDce6tbWsTKR0/cIjrVsMT72unqF7qtFxNQEeFmouvmg92PlNngAV
         AAi7GUlfv1Gh3h882kb1nMd47FG9wXm/t1Ox3vHRyL0bW7xCKBdO1ARFxcCJNrGQbl/5
         X9j5zIuWVp5UtZHL9rm+K4GZhFtpKFTtTSo/CXv9rMCS7hD0BN+ces61lxDwXGZeu/2Y
         5y0SBVJjx6RD6Lh9s/u0TcyawsZulp/1EpyZ9ZwPxmi7AmUMNT9Hp9iBeP0WqebdCGgA
         UAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733331019; x=1733935819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmuAP6kL2PgtMtMb788SmKyfSh/8+gR/zM5UDhGblwo=;
        b=cmTDJTWhl2U2uos1u92LWF4qdq7CgPvoPSMShmEt4spaCn7I+ctcle0EN/ewaeXdQk
         ICsk4UcPPAUP0GprqujyABchbChdoR7UbbDx4TYitAGssyg0Y7l/r1qUSj57dMKpjHAa
         oxTR/B7fBZa44LvlGy+IBeFceGwu6LXjdI0JyWnIf5MR8pW5Bo2rX5AP9SqK3u+3eyet
         YlzcHNm1XsKzNUNbEHLQnHv1m9ypvKRC9j3IS0OgdUOfBey7YxldzEI503hYpJwrm5cV
         OdQeg01nkDxwjDS620zW8ZBViICQt43p52N7sRWPSWlI7QvbY8cG+GXAivDZjhv6QuEv
         diWw==
X-Forwarded-Encrypted: i=1; AJvYcCWlddXdKDqzx2KuxIX+1L8Cmiq7GD5DR03nG7SXFYa+u4xtuIllWms8YXuU1i5EIrJlxcqEPriInFhZrZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMdxvObALX4vBhOsyyh2KHUblWl9ig6+lwR9bQ7NhBhbATAF8d
	Zq88jMoNjhTk4E7cYPyHwbViBNdz6/A8P1NTu+x+y3jPt07tGmhsHUiGgT3ReNQ=
X-Gm-Gg: ASbGncuxLCPZukZ123rvwpVMF7pbJ74Vwd8C0ld8NZRyZOw2bzlsLUPuwCsggGFxu7e
	uu+UXLuWiuWyb71w4Y4gUI0BwqFmh2kW3clP8jr3M8I1huZsikMlkzisEQeX6rgbPHqFoDAbRdU
	M98JKMs6ni3/T0eYqAwe+OsRDw9hxg46hbUTuaAUGLT6U/tFVRGveZ9PSALhfWn88k53BWtz06b
	vD2erRvc1Hlb9cUoRvAxjVw+UeCcckn8bp9sfw+5A5nQGkS3wC2FFyDMNIUKCnzXG/vIDkUKQ==
X-Google-Smtp-Source: AGHT+IHqX/+Zty5Ma/Nlh51kwKlztyLyx7whsZ+rNdU0Yc8VNs6fPYsusfPcia/ZhLlLrEDpUtW9gA==
X-Received: by 2002:a05:6402:34d5:b0:5d0:e9b7:170c with SMTP id 4fb4d7f45d1cf-5d10cb5c39fmr7475475a12.18.1733331018931;
        Wed, 04 Dec 2024 08:50:18 -0800 (PST)
Received: from localhost (hdeb.n1.ips.mtn.co.ug. [41.210.141.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e63a2sm749122666b.113.2024.12.04.08.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:50:18 -0800 (PST)
Date: Wed, 4 Dec 2024 19:50:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Laight <David.Laight@aculab.com>, Tejun Heo <tj@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	linux-block <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: s390: block/blk-iocost.c:1101:11: error: call to
 '__compiletime_assert_557' declared with 'error' attribute: clamp() low
 limit 1 greater than high limit active
Message-ID: <c795c090-430a-45a6-88b2-94033d50dea2@stanley.mountain>
References: <CA+G9fYsD7mw13wredcZn0L-KBA3yeoVSTuxnss-AEWMN3ha0cA@mail.gmail.com>
 <5ffa868f-cbf0-42ae-ae10-5c39b0de05e7@stanley.mountain>
 <7920126775c74fa5915afbeedcfe2058@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7920126775c74fa5915afbeedcfe2058@AcuMS.aculab.com>

Tejun probably reads everything to linux-block, but let's CC him explicitly.

block/blk-iocost.c
  2222                          TRACE_IOCG_PATH(iocg_idle, iocg, now,
  2223                                          atomic64_read(&iocg->active_period),
  2224                                          atomic64_read(&ioc->cur_period), vtime);
  2225                          __propagate_weights(iocg, 0, 0, false, now);
                                                          ^
Why is "active" zero?  __propagate_weights() does a clamp() to 1 as minimum and
we've added new build time asserts so this breaks the build.

  2226                          list_del_init(&iocg->active_list);

The other way to solve this would be to something stupid like:

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 384aa15e8260..551edd2f661f 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1094,7 +1094,7 @@ static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse,
         * @active. An active internal node's inuse is solely determined by the
         * inuse to active ratio of its children regardless of @inuse.
         */
-       if (list_empty(&iocg->active_list) && iocg->child_active_sum) {
+       if ((list_empty(&iocg->active_list) && iocg->child_active_sum) || active == 0) {
                inuse = DIV64_U64_ROUND_UP(active * iocg->child_inuse_sum,
                                           iocg->child_active_sum);
        } else {

But that seems really stupid.

regards,
dan carpenter

On Wed, Dec 04, 2024 at 04:11:33PM +0000, David Laight wrote:
> From: Dan Carpenter <dan.carpenter@linaro.org>
> > Sent: 04 December 2024 14:39
> > 
> > Let's add David to the Cc list because he's the expert on clamp().
> 
> The traceback info misses the important point.
> I can't see the 'inlined from line 2225' message.
> 
> We have (line 1084):
> static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse,
> 				bool save, struct ioc_now *now)
> followed by:
> 		inuse = clamp_t(u32, inuse, 1, active);
> 
> But line 2225 has:
> 	__propagate_weights(iocg, 0, 0, false, now);
> 
> With aggressive inlining the compiler sees 'active == 0'
> and the lo > hi test correctly triggers.
> 
> The previous version only verified 'lo <= hi' if it was a constant
> integer expression - which it isn't here.
> 
> No idea what the code is trying to do, nor what value it expects
> clamp(val, 1, 0) to generate - likely to be 0 or 1 depending on
> the order of the comparisons.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

