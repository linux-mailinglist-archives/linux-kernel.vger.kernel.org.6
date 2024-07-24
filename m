Return-Path: <linux-kernel+bounces-260759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9701593ADD4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAFD91C20DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828481422D2;
	Wed, 24 Jul 2024 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gfXTLmFf"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6298210FB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721808857; cv=none; b=WE4TK8IbqvtZaKIRZSB3tZDvqi99EIMzkdCsKA2goGZlaEqJ/l6VOKfrcuWiW/7UgPkQQjyD0vaZkCSn/qL1GZSvZXpQ2lgX+X6NB12oMUfwZPfYJNXLjIG2xlTCgBAGWfOgatMpskO323Ga2CshLmT+TBOrey/Xmqw+hoWcnh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721808857; c=relaxed/simple;
	bh=9bYjwRn0+ChhY0NoWWMu3JyL2bXuzVTARsAm2d5lTKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukVV8rcA5VBOnkJcbUP9/U81uROLhjvbX4cF9fM1KXXmc9W+pADbo+f8srrIgHuohYqKwePw1z/1cEGZ+ZkQfys7hWm63jcelmrZGEpm97jA2xDS6XwGO2ZyfAimCRUz1ocQndhKnmwl+d5zRBh4zHTpZmPPA4ZwlUOT1c3xkWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gfXTLmFf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc3447fso5760655a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721808854; x=1722413654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jaRsVgfOKLFGoy0MVEb7glaoqqC1wwJGWAgYlCrETi0=;
        b=gfXTLmFf5w7ZOSUrEyuIzP8NcqHk60zGSatiuSxigCP+WQ6G/rjvKvIKeazP2axsU0
         RLcjCyRgxrAYWOW2tl5iXpZ+WfDF/p92PS1iqeyCHejwex/lnuoOyJKiAF7OoaaKRBzk
         QiA/iUyM8yhuLpDQLwgtVenULvEKQOmjOw2w8DWqjvkVhed71XCI5lkbhznXUgAnUjKk
         njs0X2AIlMWdCvK4LgsXSRqGokdUMhLe2MTS+qUj+qWkqGRR5X665wGJ5E7s4wf80bcP
         apSMNkz5I8dRTzC3ekrYwO5ibQ0wt3U7qbvoJ54RPGy3EnJdtTetT82kthevMgJIfcUC
         3i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721808854; x=1722413654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jaRsVgfOKLFGoy0MVEb7glaoqqC1wwJGWAgYlCrETi0=;
        b=E/JwaQJJbaQQ9c4htL40jxNXNjRK/7w1qTnxWgJdLcSuflXP18yx1IkqhwrNIvR2k4
         AJnfjsyf0DK6ie3i3mHtjvurXZSOaXjN+IpGP7BNjHOaM7hdX1BoOcAfuW7KF/5qVP4V
         9Qw9WEoWCBG+PR4CbhkcDPUBxGjB8ryqJcvGXfD1/cLfuzjP8YAVO55ug8Wbz2JX05Hk
         JKuPgvKbTfR5mK4N0odL1Kk/WqlHDMW5lQPt/hqtyxAUBxegQ4lHDTPbMnKFJuSrlqYK
         qi/U3Je/2r0W5qxF/OEMykn9BYMCfW7xKtVPgUL1HoI1Iixe13mG5XCMMnZBPjESxU+o
         E7uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOKo4+vMjj/ffVG0bNT5fzGPuasm4MbCkwHu9KdAgwrsfRkJ4W9dz18G8Prq752f7iebovpxOzf+eRMJbVs/0nbZEdZzNOtou9rQkj
X-Gm-Message-State: AOJu0YzPCdpP+5QlS8+KC5MvATvtWMNLaAONEph6tgZn7CY4/IWx8cTD
	QL2dCoyQD92EqznJD0/ZfibQKN6xZUEonGPTmUJ81QCexzr5V5Z6KnsCVm5Oar4=
X-Google-Smtp-Source: AGHT+IErFz6fk4k4pDS53bVIdpr3Cmi7kyuKzcJkJAFzrVycMLPuZ4ETQuR0kvj/epfBBRSJC5/Cqw==
X-Received: by 2002:a50:9b5d:0:b0:5a3:b866:eaee with SMTP id 4fb4d7f45d1cf-5a47848532fmr7897510a12.7.1721808853815;
        Wed, 24 Jul 2024 01:14:13 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30a4d7127sm8662732a12.3.2024.07.24.01.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 01:14:13 -0700 (PDT)
Message-ID: <16f51077-f525-4d3c-92ad-8a1ccc02e4ff@suse.com>
Date: Wed, 24 Jul 2024 10:14:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build performance regressions originating from min()/max() macros
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, david.laight@aculab.com
Cc: Arnd Bergmann <arnd@kernel.org>, willy@infradead.org,
 torvalds@linux-foundation.org, Jason@zx2c4.com, hch@infradead.org,
 andriy.shevchenko@linux.intel.com, pedro.falcato@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <c83c17bb-be75-4c67-979d-54eee38774c6@lucifer.local>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <c83c17bb-be75-4c67-979d-54eee38774c6@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.07.24 23:59, Lorenzo Stoakes wrote:
> Arnd reported a significant build slowdown [0], which was bisected to the
> series spanning commit 80fcac55385c ("minmax: relax check to allow
> comparison between unsigned arguments and signed constants") to commit
> 867046cc70277 ("minmax: relax check to allow comparison between unsigned
> arguments and signed constants"), originating from the series "minmax:
> Relax type checks in min() and max()." [1].
> 
> I have reproduced this locally, reverting this series and manually fixing
> up all call sites that invoke min()/max() for a simple x86-64 defconfig (+
> some other debug flags I use for debug kernels, I can provide the .config
> if needed).
> 
> Arnd noted that the arch/x86/xen/setup.c file was particularly problematic,
> taking 15 (!) seconds to pre-process on his machine, so I also enabled
> CONFIG_XEN to test this and obtained performance numbers with this set/not
> set.
> 
> I was able to reproduce this very significant pre-processor time on this
> file, noting that with the series reverted compile time for the file is
> 0.79s, with it in place, it takes 6.90s for a 873.4% slowdown.
> 
> I also checked total build times (32-core intel i9-14900KF box):
> 
> ## With CONFIG_XEN
> 
> ### Reverted minmax code
> 
> make 1588.46s user 92.33s system 2430% cpu 1:09.16 total
> make 1598.57s user 93.49s system 2419% cpu 1:09.94 total
> make 1598.99s user 92.49s system 2419% cpu 1:09.91 total
> 
> ### Not reverted
> 
> make 1639.25s user 96.34s system 2433% cpu 1:11.32 total
> make 1640.34s user 96.01s system 2427% cpu 1:11.54 total
> make 1639.98s user 96.76s system 2436% cpu 1:11.27 total
> 
> ## Without CONFIG_XEN
> 
> ### Reverted minmax code
> 
> make 1524.97s user 89.84s system 2399% cpu 1:07.31 total
> make 1521.01s user 88.99s system 2391% cpu 1:07.32 total
> make 1530.75s user 89.65s system 2389% cpu 1:07.83 total
> 
> ### Not reverted
> 
> make 1570.64s user 94.09s system 2398% cpu 1:09.41 total
> make 1571.25s user 94.36s system 2401% cpu 1:09.36 total
> make 1568.25s user 93.83s system 2396% cpu 1:09.35 total
> 
> Which suggests a worryingly significant slowdown of ~45s with CONFIG_XEN
> enabled and ~35s even without it.
> 
> The underlying problems seems to be very large macro expansions, which Arnd
> noted in the xen case originated from the line:
> 
> extra_pages = min3(EXTRA_MEM_RATIO * min(max_pfn, PFN_DOWN(MAXMEM)),
> 		extra_pages, max_pages - max_pfn);
> 
> And resulted in the generation of 47 MB (!) of pre-processor output.
> 
> It seems a lot of code now relies on the relaxed conditions of the newly
> changed min/max() macros, so the question is - what can we do to address
> these regressions?

I can send a patch to simplify the problematic construct, but OTOH this
will avoid only one particularly bad example.


Juergen

