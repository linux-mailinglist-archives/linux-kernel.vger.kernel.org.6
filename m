Return-Path: <linux-kernel+bounces-312422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F4196966A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468AB285C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2EC200117;
	Tue,  3 Sep 2024 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vre6geOl"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A0415573A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350497; cv=none; b=KWqe7o0bk4q2+76/akStHcwP1kkrDCppg61c0PoKLPXPrKHRH/SQ+jLcTH+2mbUAM1GbTHDssCORxST4svVANiB7Us/26JIpg1uozHjsfRzJvH1JzUVqyH3uqbxk83Ac6WFJxaNHH+TzgHz2mRWpF7O+16JlOIosjV1ZaagiAvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350497; c=relaxed/simple;
	bh=F04lCZWgOjn2P6w1wPYdYRDjfnAadaYcw+gAm4MGpU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ufnty0ey5sD1XppsbwkR8JJqoEIOPBMMwgNj3wI42LEKr8msqn8Mref9K9I1rTgZU4g/mXp11JX0j6//BnidR967uyW9VdIbNR/++CCyw7nvbX4UGuJlwZIKPPqY9FhEYr65ZbX9SOLOgvsLGhMVEBYRn+371O/UukDBpwm4POU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vre6geOl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-715abede256so3691916b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725350495; x=1725955295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xDeynKssdN1XfK/xQnAB2rnokmkSXiG53xB8wusPu+Y=;
        b=Vre6geOlEQKFAoocKURC28IRM4i3emQGdbjQAGOpYHp2plWmrfTyErW8ZcSwJ8tzXZ
         fXdfEL32dkATonjYIEooN75U0yzK+JQXYKUYa16Sur30RorjhKvRvFJ/5hSEoN4KCrrG
         +AOvkxvcQ17lW9RMJHQU2bbJfOBPf2NCnaag4lbgd4UGoSrLTL/IPet0xfXvwylw1t9X
         D5E5y5sZwNCBORlu/jAEyZ0SzEZ57RhpRlZM9kK5tB6DMeUqatZmduLAbCSze3dDvILM
         KYdXCGiFSuS4OUEyxq1YyJpj7bOPJ927xdvMATR4+K5HLbj72lVmB9k8Wk13pwa9Tpqi
         IOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725350495; x=1725955295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDeynKssdN1XfK/xQnAB2rnokmkSXiG53xB8wusPu+Y=;
        b=XjPkt+gV3IMT5S12L1IEuTv1PDQfw0F9N71F2nXD2Gq53uRAgjInAmq1qLn3Ut1xjU
         T1IiFxhZnSKd7tETcsUcUH0jW7mFxuUfESf30qmvDvx4asxpB6b09Ke9gXLNnB8bB1V5
         AneyThAdsfSkr9QIzE9nSscYXlTupqbk2qEzWBDGvoXquEDAUGm6NsB02riCZGGaZc30
         lHXSHmVFUe5mwM/QGls29NFOe9gLOa0XVmlOTLJgqRQqGE7Sp3eUcy4ezGBwZtAgSKtD
         FsicUi9ivXxFsV0BkWw9h4hWAyhYiOl5+y9Uzf2hRb/nLw6NX3Rv5LFhRqX8aP6Q5h+f
         Ug1w==
X-Forwarded-Encrypted: i=1; AJvYcCUJVqVJCLMrZScLGoTMU3qQeCGpwu+7oH/yLi2XFY9AXVYZrtHsCL6m4GueohM/04W3msDqHirsVfJBvs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4cxOEopk+F/JiS2k12ywLVJ4zZ8tb60n5IXYR7RSM26Ec7yL
	7IegS4Z+AcEhWjrjF4jM434YVHKCC9FrYwmq69pC/K/7QyvjoxNW
X-Google-Smtp-Source: AGHT+IHtSPGhKPKwuY26xN3mhxwFZhhUm++ETeppT2ZLuysOpkGc03XxPvITNNRc19bO3k39mZU0fg==
X-Received: by 2002:a05:6a21:3213:b0:1c4:a8a6:a85f with SMTP id adf61e73a8af0-1ced62a2b24mr8148849637.30.1725350494668;
        Tue, 03 Sep 2024 01:01:34 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a5c71sm7953269b3a.79.2024.09.03.01.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 01:01:34 -0700 (PDT)
Message-ID: <1ec2f951-8ce8-485a-9f51-e3b9f4eba73e@gmail.com>
Date: Tue, 3 Sep 2024 16:01:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org,
 david@redhat.com, 42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>,
 nphamcs@gmail.com
References: <20240902072136.578720-1-alexs@kernel.org>
 <20240903033558.GC9738@google.com> <20240903034542.GD9738@google.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240903034542.GD9738@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/3/24 11:45 AM, Sergey Senozhatsky wrote:
> On (24/09/03 12:35), Sergey Senozhatsky wrote:
>> On (24/09/02 15:21), alexs@kernel.org wrote:
>>> The descriptor still overlays the struct page; nothing has changed
>>> in that regard.
>>> [..]
>>> This patachset does not increase the descriptor size nor introduce any
>>> functional changes, and could save about 122Kbytes zsmalloc.o size.
>>
>> Is this number accurate?  Where does such a large saving come from?

Hi Sergey,

Thanks for asking, I collected some data on Aug 2, before the patchset,
zsmalloc.o is 1200960 bytes, after patched, it's 1076144 bytes. At that
time it's saved about 124KB, about 10%, with some debug option enabled.

Just test again with x86defconfig + ZSMALLOC + ZSMALLOC_STAT, 
on mm-unstable tree, zsmalloc.o reduces to 34960 bytes from 37328 bytes,
that's 6.3% saved.

The bloat-o-meter show in machine:
$ ./scripts/bloat-o-meter x86def/mm/zsmalloc.o x86def/mm/zsmalloc-patched.o 
add/remove: 1/1 grow/shrink: 1/5 up/down: 100/-1068 (-968)
Function                                     old     new   delta
create_zpdesc_chain                            -      92     +92
zs_compact                                  2352    2360      +8
zs_malloc                                   1334    1277     -57
__free_zspage                                291     223     -68
free_zspage                                  289     211     -78
create_page_chain                             95       -     -95
zs_page_migrate                              950     807    -143
async_free_zspage                           1252     625    -627
Total: Before=11868, After=10900, chg -8.16%

> 
> ./scripts/bloat-o-meter mm/zsmalloc.o-base mm/zsmalloc.o-patched
> add/remove: 0/0 grow/shrink: 2/6 up/down: 7/-843 (-836)
> Function                                     old     new   delta
> obj_free                                     211     215      +4
> zs_unmap_object                              568     571      +3
> zs_map_object                                661     633     -28
> SetZsPageMovable                             135      86     -49
> free_zspage                                  310     253     -57
> __free_zspage                                284     226     -58
> zs_page_migrate                             1304    1136    -168
> async_free_zspage                           1099     616    -483

Many thanks for detailed data here!

Thanks
Alex

