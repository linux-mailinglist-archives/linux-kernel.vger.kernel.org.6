Return-Path: <linux-kernel+bounces-379635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28D29AE162
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A951E1F2481E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CC91B0F17;
	Thu, 24 Oct 2024 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx1NMQAj"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233515886D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763326; cv=none; b=hAtt2xvTwkW9g8vAnalDiqp4gVb/88y6usTU4QqXwhYhg8v9irlybdVG38DaAqYqrAWL7NYQ8Mlf80BPfJlB57yeo8npcTYWaCBpYEvNK4TsphS3kGRgiPHwCmWu1A6xbt/Zt+5q/1l0H25iOQaIeX3E02M5LZqRCrp2xgYh57c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763326; c=relaxed/simple;
	bh=XKOD2jBG5q8LDXkECHMtUDCYx4eK/rFol9l1QGTiXGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKctf1874ZWCEs2ps/j7e4OKyQxf2pkTjk6oBMngkX1xLVvK86Q1qN1fZHtOs3vaYdIz/OvQka2299Q2+ycr4mqe1VkWMkYCvDp3iYqAgiPL3Omn+9Zics9PUZ0nEtpF8Vf9Olbz+mujp6NOg2bBAybyXuG5G5NB4FCJpl2KHhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cx1NMQAj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d8901cb98so1200020f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729763322; x=1730368122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8BZO8UMhk9f5gARVSgM1x6fEmct9HcXbugVM0Zv/jE=;
        b=Cx1NMQAjzWpa+2w3TcRIqWdoFH3JT7ClU4R7OP9lLg/RRi8piUAgZzi5qnvQqoeV4e
         DMZF41TypZyL/9fPgqwUYlUR8j7oq4SUbLkaax+GcZ/v5bcCbkgEnM3rfQSpAhXknh1t
         +Agc908AcWY8ZSkwGWO2ipjr30roNq62CDvTgR4Uo5uNJ0FoL7P7syuKAgg4DDeTl2Yv
         aqrO2nCx8j8rv6gjMyBYfS1FmIsXyIFQRm8QDKdpAwygLLMBwAwC2gkLGiE537E2flGC
         FiYKBvzkGH6dD1BV3DBVo/TvyEQXVWnpxYy73YYxNjpWbkrzP6wNbd5iv+/1J2vUMpc1
         ay2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729763322; x=1730368122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F8BZO8UMhk9f5gARVSgM1x6fEmct9HcXbugVM0Zv/jE=;
        b=mD0swQ7rSuTC+mwGF4agT3/pzjkpgwz7GiJr3N5uln/Itb0/SeInNmym/glEOVcp/g
         81u2vjz1SGhX10TWGJ/XjBNuldS5yfwssGcDeXotfXj/5D8Dy8V015WCOAd9ki0Nu9Ou
         2f5kIuEwIq+JnPZqFRss6h7f/Gl+/SIzISTG4l8ge0GvHIOVEQvYB0Dt61l7Pele+TbL
         ns4fm7aEkGojSunDJNw5HXhKlP+RY829jSBsMuNiw6fvjyMesPAOfoQ7qdEB6aRsKS+A
         VOSlygKwzwMExRJUiCuQBma7FOxG7WYKGX8NwjLFrBMO7vgdpfN0UMqz1B6LuoDKDLjI
         +Zhw==
X-Forwarded-Encrypted: i=1; AJvYcCXCs31dHO0yb3tByTa897u5RBhxzYZvVPxg8yb2K4qQzpb7EvgaD7d4GvKEOPdrjKs6p1cI7YmPHKPG4Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGoQWX26RNdyMfb8mw7+wxRMRJdibTAfV4ksgX6E31/giW4lbN
	H5k0Z6UVP40rxCzbsGVlpi6EgwUX4WTkYukINjF0hM5LXqPlUK78Lbta1Ophw3Y=
X-Google-Smtp-Source: AGHT+IHN5AR8ffhQUJ/Cu2oVbvyYCcnPaticb9PKfFa56t66E7hCSKpQWG+wuvvIeJs/NxAsAsrt0Q==
X-Received: by 2002:adf:e602:0:b0:37d:43a8:dee0 with SMTP id ffacd0b85a97d-3803ac7d59bmr942850f8f.17.1729763322146;
        Thu, 24 Oct 2024 02:48:42 -0700 (PDT)
Received: from [192.168.2.39] (ip-109-192-223-157.um38.pools.vodafone-ip.de. [109.192.223.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b566f11sm12048495e9.20.2024.10.24.02.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 02:48:41 -0700 (PDT)
Message-ID: <25ca154e-d960-49f7-9e5f-3a4233a0396b@gmail.com>
Date: Thu, 24 Oct 2024 11:48:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/mm: -Werror fixes in page-types/slabinfo
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Vlastimil Babka <vbabka@suse.cz>
References: <c1ceb507-94bc-461c-934d-c19b77edd825@gmail.com>
 <20241023165115.b524c51e80c36e120edabb36@linux-foundation.org>
From: Wladislav Wiebe <wladislav.kw@gmail.com>
In-Reply-To: <20241023165115.b524c51e80c36e120edabb36@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 24/10/2024 01:51, Andrew Morton wrote:
> On Tue, 22 Oct 2024 19:21:13 +0200 Wladislav Wiebe <wladislav.kw@gmail.com> wrote:
>
>> Commit e6d2c436ff693 ("tools/mm: allow users to provide
>> additional cflags/ldflags") passes now CFLAGS to Makefile.
>> With this, build systems with default -Werror enabled found:
>>
>> slabinfo.c:1300:25: error: ignoring return value of 'chdir'
>> declared with attribute 'warn_unused_result' [-Werror=unused-result]
>>                          chdir("..");
>>                          ^~~~~~~~~~~
>> page-types.c:397:35: error: format '%lu' expects argument of type
>> 'long unsigned int', but argument 2 has type 'uint64_t'
>> {aka 'long long unsigned int'} [-Werror=format=]
>>                          printf("%lu\t", mapcnt0);
>>                                  ~~^     ~~~~~~~
>> ..
>>
>> Fix page-types by using PRIu64 for uint64_t prints and check
>> in slabinfo for return code on chdir("..").
>>
> Thanks.
>
> Your email client messed this up in strange ways, so I basically typed
> it in again.  I added the Fixes: target and a cc:stable.

thanks for the feedback, seems something went wrong after updating my mail client, I will fix it.


