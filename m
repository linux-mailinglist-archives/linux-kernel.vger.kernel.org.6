Return-Path: <linux-kernel+bounces-571694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6579A6C0D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445AB3B3889
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA22322C339;
	Fri, 21 Mar 2025 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO72Ecno"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1051D5ADC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576724; cv=none; b=GT44GIfMY1yd9wgqLNlGBr4ar/i9AerCronVR9VZH9zzcmLUWkpq0IZoL0DPJLKzr6nlndvNNoRbpIzyy/a98qp9o+O8nI2Q5WtFKnHiFcuhCmrEmrbDYQOmRVX5fRVadsKh7jt330vBONXutlMNcKdIilxpHuFQk2wwA+6aWlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576724; c=relaxed/simple;
	bh=+xYOirQubQos5ZLcSBS4iZFqd8vhK3UxEfjeEwAcsMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCW+B9+OX17Gso67XaxoLnZZbcz8nGZ6etEoWbD9iqTgY3pwvwmlB4ERE6ZbWrc2W4ddKPM+hL+wl+s2Zd3KiKGxHytrCJaYaNq4qrRm3QseECDpvRg9pcJLXTiS3Jhw+yunrSCuIsHG6ucn6wIIHo3yO5jdI35+uM++j8bEH50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DO72Ecno; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223f4c06e9fso38303635ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742576722; x=1743181522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFJmlO/iB6/7i2e30laD/4rk/wX+i4QVOj1nk+xkAog=;
        b=DO72EcnoGf6vPNH9yhu3FhdRudTvG1QBr8mPAS6YD4aYs+9lobrLkMlK5gMRzPKcxb
         t5msC0E4GzGUxs/TLVujcvILnnN+geaIwiqqxsR3SBvxjwL7aikYd0k9kGIt08PqwHDu
         5vjrGZ60CJhoqCc9IWYlUtenOMqM4olIyigW/+ouSF6Em2T5T7Vwy07EDwJPRI6PT2sL
         mzYQhU11OU1E6QYT7T0e5QhOlLMV2WrQyCW6ImIvQJnfkQz59QOjc8V4H7RGVzWdtSSy
         5/FRgguAFKzCvhW/jG1OHe+EaYfI5TiMJCydSBKI/hCx9HahXe7TPU8dIHz3xT9Rk2cn
         dxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742576722; x=1743181522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFJmlO/iB6/7i2e30laD/4rk/wX+i4QVOj1nk+xkAog=;
        b=DwCPuzz9AGYctwdtCLtEfiF+MVq66hSsRFUJpmv/AzjBCLpX2pzMHgTkwU9SCIzI5p
         fUI2mZshx1sLdMwqief/4fvO+tP7110eVQE9G9mOd6AGl6udeUXahbPzL3pkBPx3Ebsk
         G5/Z21C9BKXAg5iFCqhNP2NcK7NJLaITL+Xtxb3vfP6h22BMnAV0qdTsdgQJSU6//akD
         HrjkYOddLlUnI7qT3SC9k7wTKaRYDzjYUO2d+XhPj6vYXkED0LYpPrYSdiSMBIwyup1B
         Er+p1FuKBwJ5oYUSMN1YyJAaJW1jKMYBouvQr7ZhGkupdB/7wqEH/6/ap5mQPvIfqU26
         cj/w==
X-Forwarded-Encrypted: i=1; AJvYcCUsp/mbjCnC8uDegp1uRrlUGjPV4+P0DwEh/QNwF8OQuO1hO5+Xf2bN5uFOvKh+dF8PkeC4Ah3GIc2AtO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/yt1vjbENLKz67sHPLF/h99z3jgrDC/5XupeRfK/mw7Kz+faH
	GIeSPosUawIsNfFV+iGS+21zj78RnBIQObZyU+G2CAQmDUwt12DC
X-Gm-Gg: ASbGncs4joB6pHXoSJcPsRaDFjRHmTPnsXPvnfttQcxh2JJNKZLZ+vvBr2Wn/VEq4g0
	gokEv3uhsVY2clhN6AWL/NADyh515e506HORyyPmkZgu3wYAeq+YPFZ1It1Vw4O2AROiV2rOdh3
	mY+RsigzyV9H/IkDAESVy9d8pem46gHPBpw+6MeTe/u0Mx7jE2e0GHfjzcKo17iXwjBSoYlVURf
	PAWdge73RKwHQMXGwZOu2sR4jqQlmmyJXfSJugRhbhOGhSl5CUIJl/C+Q6A4QbgD7egFQcHR82R
	T9SppZFRwqibCvZ2Fv4mEX8666+7tQEtwapszOjkbWJl
X-Google-Smtp-Source: AGHT+IH7UrSBOupRRVjrb3wtNzf50EusSmn8NacmvaKZuKRlw8NkIWXeCKo1ec3bmF+7vhQTLnjYjQ==
X-Received: by 2002:a17:902:f684:b0:215:58be:3349 with SMTP id d9443c01a7336-227806d072amr73177805ad.14.1742576721585;
        Fri, 21 Mar 2025 10:05:21 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3bbedsm19697085ad.3.2025.03.21.10.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 10:05:20 -0700 (PDT)
Date: Fri, 21 Mar 2025 13:05:18 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v4 3/8] bits: introduce fixed-type genmasks
Message-ID: <Z92cThxAyXu9JJdk@thinkpad>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-3-1873dcdf6723@wanadoo.fr>
 <Z8hsRJvpjYoqh9RG@thinkpad>
 <Z9oiEkQEcHhA0a80@thinkpad>
 <5cbaefa8-e51f-415f-a9b3-4841e69bb3fa@arm.com>
 <1aba17f1-0cd2-429c-8338-28387ec16314@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aba17f1-0cd2-429c-8338-28387ec16314@arm.com>

On Wed, Mar 19, 2025 at 09:43:06AM +0530, Anshuman Khandual wrote:
> 
> 
> On 3/19/25 09:04, Anshuman Khandual wrote:
> > On 3/19/25 07:16, Yury Norov wrote:
> >> + Catalin Marinas, ARM maillist
> >>
> >> Hi Catalin and everyone,
> > 
> > Hello Yury,
> > 
> >>
> >> Anshuman Khandual asked me to merge GENMASK_U128() saying it's
> >> important for ARM to stabilize API. While it's a dead code, I
> >> accepted his patch as he promised to add users shortly.
> >>
> >> Now it's more than half a year since that. There's no users,
> >> and no feedback from Anshuman.
> > 
> > My apologies to have missed your email earlier. Please find response
> > for the earlier email below as well.
> > 
> >>
> >> Can you please tell if you still need the macro? I don't want to
> >> undercut your development, but if you don't need 128-bit genmasks
> >> there's no reason to have a dead code in the uapi.
> > 
> > The code base specifically using GENMASK_U128() has not been posted
> > upstream (probably in next couple of months or so) till now, except
> > the following patch which has been not been merged and still under
> > review and development.
> > 
> > https://lore.kernel.org/lkml/20240801054436.612024-1-anshuman.khandual@arm.com/
> > 
> >>
> >> Thanks,
> >> Yury
> >>
> >> On Wed, Mar 05, 2025 at 10:22:47AM -0500, Yury Norov wrote:
> >>> + Anshuman Khandual <anshuman.khandual@arm.com>
> >>>
> >>> Anshuman,
> >>>
> >>> I merged your GENMASK_U128() because you said it's important for your
> >>> projects, and that it will get used in the kernel soon.
> >>>
> >>> Now it's in the kernel for more than 6 month, but no users were added.
> >>> Can you clarify if you still need it, and if so why it's not used?
> > 
> > We would need it but although the code using GENMASK_U128() has not been
> > posted upstream.
> > 
> >>>
> >>> As you see, people add another fixed-types GENMASK() macros, and their
> >>> implementation differ from GENMASK_U128().
> > 
> > I will take a look. Is GENMASK_U128() being problematic for the this new
> > scheme ?
> > 
> >>>
> >>> My second concern is that __GENMASK_U128() is declared in uapi, while
> >>> the general understanding for other fixed-type genmasks is that they
> >>> are not exported to users. Do you need this macro to be exported to
> >>> userspace? Can you show how and where it is used there?
> > 
> > No, not atleast right now.

Ok, thanks.

> > These were moved into uapi subsequently via the following commit.
> > 
> > 21a3a3d015aee ("tools headers: Synchronize {uapi/}linux/bits.h with the kernel sources")
> > 
> > But in general GENMASK_U128() is needed for generating 128 bit page table
> > entries, related flags and masks whether in kernel or in user space for
> > writing kernel test cases etc.
> 
> In the commit 947697c6f0f7 ("uapi: Define GENMASK_U128"), GENMASK_U128() gets defined
> using __GENMASK_U128() which in turn calls __BIT128() - both of which are defined in
> UAPI headers inside (include/uapi/linux/). 
> 
> Just wondering - are you suggesting to move these helpers from include/uapi/linux/ to
> include/linux/bits.h instead ?

Vincent is working on fixed-width GENMASK_Uxx() based on GENMASK_TYPE().

https://lore.kernel.org/lkml/20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr/T/

The series adds a general GENMASK_TYPE() in the linux/bits.h. I'd like
all fixed-widh genmasks to be based on it. The implementation doesn't
allow to move GENMASK_TYPE() the to uapi easily.

There was a discussion regarding that, and for now the general understanding
is that userspace doesn't need GENMASK_Uxx().

Are your proposed tests based on the in-kernel tools/ ? If so, linux/bits.h
will be available for you.

Vincent,

Can you please experiment with moving GENMASK_U128() to linux/bits.h
and switching it to GENMASK_TYPE()-based implementation?

If it works, we can do it after merging of GENMASK_TYPE() and
ancestors.

Thanks,
Yury

