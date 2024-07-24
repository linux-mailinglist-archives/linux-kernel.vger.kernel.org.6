Return-Path: <linux-kernel+bounces-260839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A8C93AF28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C336283853
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65C51514F0;
	Wed, 24 Jul 2024 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KKZ8bDMi"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98AD1442F7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814015; cv=none; b=XwkiAUncq+XfJQR8q2++YqDyBNtFe/EelMFXksciwXfD6OoPon9VsAHj3s7zQ18FJ/W3CbUsv8BasxCrFHqslxibC2ypCNp/Y8necfRt0NF67ZLw7KgqLejng+Mfpf3Er7hoiySwrNrpj8nD9z21JmtClnqPBbQaCc5w4Gm0lqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814015; c=relaxed/simple;
	bh=rNJ189vj7y5QSQWiHCLBSLSm8+kO4F4/+y4tLfDk2Rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqjYV9U7+av9y7s851rzclGRD8tUKX2In0JJHqZzqVkF1an/6e+wRVr3NhvvT6tJzmRZso1SMNxj/Cawgc1AvhuAurZieBmDTbCvQoTSijDN1PtNbqxY1/cKH7hbzlz+8WpEpl13En4FyX7L0+CO7hbSfD51v360rokStZ17cEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KKZ8bDMi; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3684bea9728so3902342f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721814009; x=1722418809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VbMbEnfMM83BKeL5xF8DO0bNfwt+gSUUC0MQPNjUR6o=;
        b=KKZ8bDMiKoubtJfHgh9dgyCfZCwQe3WWr70j0ZnWXTSJX+nRJEc07upHSF1FnvzoBr
         9eZr577uXmw88uNUUQCLb9+4C61aklkY4en4YMRtVTGmiKN0jNzlyzU/piz1JA+QiD4a
         ZwYLTikvzj924WIVEYYBXDqZSjFvR8K5pFnK7ywSCwLMTzJ5gKUG8AYP8yZaStUWTtdd
         3SzKnyikobMfCCmLTNFW5tg0AWt9ShNTv6BRjr9ggWSuRtuEQbW7t6eUs9952wH5fwRH
         1pjsnnya1Wm/aVl8kjqym533KzfryquJi7mM6ef1PbnqhKgIvSn00AHDHXuF9vhKDi0p
         H1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721814009; x=1722418809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbMbEnfMM83BKeL5xF8DO0bNfwt+gSUUC0MQPNjUR6o=;
        b=PkMjePZ4Hn1adCEbhq9yeqPWMdFGHv1sHVh69aHPX5O9vuvj8KFUPcm0eMdtFkWoak
         UtBdw5QzAuoBaN61eqYs5DqljcAgske05/89ai7Qta+p6QvPXRY0kpx4Ks9DSIpNCiYv
         oHd8yLNw9JWgwqdoDAnX0evfRDTwA2dITBhse5N9sVXkpx5L4y96zpW9rMA666MoVTtG
         2KmutfD+EQdvPMcFl0PV/59C+nj/DUBLWiXKLwEt4PmB7tdvQ4YiekYHTmDtu7waiTY/
         JcYh06uUj9uO73BGlpbfwO0gXNRhbcMVjiX/33oEK7WIVDyI7CaoMqo19KHx1kXosIIR
         usEw==
X-Forwarded-Encrypted: i=1; AJvYcCVFF5FJGdC2n6cIltV4lwqiU2h106eXNAKESahHd9z0G3n2IyHwxH5OUMreGo5zG/Bs1PHgl6UFInxS88fThNkwis4r8o+XSNhZTvg7
X-Gm-Message-State: AOJu0YzvKlhwA8ccaKm/W06rGl3lQs4bPCGot+jCk1goQeVpdr+P14L3
	4cUI5ia83cMbwyX4zckZP9YUOYkJ1MBaqeUxn2032ehMKDNGAtlWHMZTFUpRK6U=
X-Google-Smtp-Source: AGHT+IF+zj06oSZDaSBVWEWlQOWmVhFMHkEpldn6/IeeJVJnQbwGCnuo/2GWaKic8DPKuGM/8nw+Dw==
X-Received: by 2002:adf:f484:0:b0:35f:e0f:69a6 with SMTP id ffacd0b85a97d-369dec0cf92mr4139925f8f.27.1721814009111;
        Wed, 24 Jul 2024 02:40:09 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868477fsm13813827f8f.12.2024.07.24.02.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 02:40:08 -0700 (PDT)
Message-ID: <0b11e6c8-170d-4b95-ad14-76685d657643@suse.com>
Date: Wed, 24 Jul 2024 11:40:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build performance regressions originating from min()/max() macros
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david.laight@aculab.com,
 Arnd Bergmann <arnd@kernel.org>, willy@infradead.org,
 torvalds@linux-foundation.org, Jason@zx2c4.com, hch@infradead.org,
 andriy.shevchenko@linux.intel.com, pedro.falcato@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <c83c17bb-be75-4c67-979d-54eee38774c6@lucifer.local>
 <16f51077-f525-4d3c-92ad-8a1ccc02e4ff@suse.com>
 <9d62cd2d-a00b-4260-8ffb-0e0e4574f222@lucifer.local>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <9d62cd2d-a00b-4260-8ffb-0e0e4574f222@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.07.24 10:31, Lorenzo Stoakes wrote:
> On Wed, Jul 24, 2024 at 10:14:12AM GMT, Jürgen Groß wrote:
>> On 23.07.24 23:59, Lorenzo Stoakes wrote:
>>> Arnd reported a significant build slowdown [0], which was bisected to the
>>> series spanning commit 80fcac55385c ("minmax: relax check to allow
>>> comparison between unsigned arguments and signed constants") to commit
>>> 867046cc70277 ("minmax: relax check to allow comparison between unsigned
>>> arguments and signed constants"), originating from the series "minmax:
>>> Relax type checks in min() and max()." [1].
> 
> [snip]
> 
>> I can send a patch to simplify the problematic construct, but OTOH this
>> will avoid only one particularly bad example.
> 
> Thanks, appreciated but I am a little concerned that we might get stuck in
> whack-a-mole here a bit. I'm pretty sure we've had previous patches that
> have addressed invocation points, but obviously the underlying issue are
> these macros which will keep cropping up again and again.

The xen example seems to be one of the worst due to nesting of min3() and
min(), so being de facto a min4().

I think drivers/firmware/sysfb_simplefb.c has a similar problem, as it is
nesting max() with max3(). Same applies to arch/x86/kernel/cpu/cacheinfo.c
and multiple times to fs/xfs/libxfs/xfs_trans_resv.c.

There are probably more such extreme cases.


Juergen

