Return-Path: <linux-kernel+bounces-194793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDFB8D422E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F030A1F21F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEF38814;
	Thu, 30 May 2024 00:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lwh91/MA"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532044A09
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717027385; cv=none; b=U52CrF4yZmC4aWrbjgCLrfhzXcrvIiBEwZp1/CrldZ8vgw2ExhlDZ2rYY2kkovXu6KAjU+/lzxOIQfLUUV+ZWZz6mMeUnZ5A9UbCwkyNKO8UgYb6gsU/5ci9W35O/XwYyc07eKsHF9LiO4fQ3yDqyXGJgvNswen92bovgB1coWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717027385; c=relaxed/simple;
	bh=+//77i90X6MWdsSJq3OLw61xhJ25bRq5QV8ppVhQqtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzS1Glys1PGbXR1TawmTwBy3/yDb1vbfzgdeM0AxjUVElrnOwzRsg+a0ekcc9ZbKqr37/CYBc0TE9h4T9v0i4kFvanBzc4BRkcP6b/u/YkANnuP//Ig6P40GGQ0QlivjIGXbEWwnc6IMBKWoL+KA/qq23RH68aPvhGgVoJZFH/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lwh91/MA; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a62614b9ae1so20226866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 17:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717027383; x=1717632183; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXXZxCwdNAbS3hi1LwsxoI0rpYt2j5QqgkpvxC6L2tQ=;
        b=Lwh91/MAlOfS3Ig4mcXZgQT3JPrlBS+g4z1/AzZISmBiOPYRPxiHIuQzFXrgXanf5A
         LGkT2PKJNiRzrfWRFhx6vGWhwJERQCySQKi6JjHDvp68u8JwuWX97bADwrfVMV8uECom
         chO/bC5Jrufq9BspG8SBtJx9jkS7B5MIlmT23awwOvpD5pgeFXylONT0ppT5q8KMMgcW
         hHzVlTOMCFAfvKkIyzmXV/BMwYAWLW0PhkoEhd54zG8uE/QJgUeFDOFff9lM4U/KDJs5
         hKqoZ6WkzvNLZd7XEewZn5f7nA0HaSgCitUGcemhLJ/98jTESyiGJxMgJ7L7EmDesy6D
         GJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717027383; x=1717632183;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXXZxCwdNAbS3hi1LwsxoI0rpYt2j5QqgkpvxC6L2tQ=;
        b=DbAb5tvxwrQG0qa0ay2bvP3BSMmIjFa/OYfgNHvEnec/6eoLeuScSSGimHoRKY/eCE
         lfl6X1I+Z0k+LVE0fnBUWhWxvYwxBcC5VMr8Amhk+ejCfqJ6QM843ylxwoHM+gTNNN1i
         ZuU2WyM9sUse1P7ehBJpN2xLM9raTYG7jiMSJ1lyrOjfFyILgc//royRTZDd23keHFh7
         f+ltMms4GD7Z2AUOvl355Z1iO+/DhOo0YnjAFb01WN/V0cgTGoGlrhLkTtidEqxqICsz
         JeMQM+Ei+cGWYuQ2/SEynhoKa01dpAdCT8miwnTuzqVF7s0aaA3y/lg4y9cQP/Feb5FR
         LLRw==
X-Forwarded-Encrypted: i=1; AJvYcCWjYjmmujJ+SgvNXeO0qYJoob0kWdcwLni6AmPtrAbgC2BwdidjbvFSl6Yl5q1hsPgqA2Z4SAA8WFOK9WPPjCSH+Ljbrp/sEp63eP98
X-Gm-Message-State: AOJu0YxdaaVhzdSZhWcM21z+f75eB9v5Jxn9LN0WRcS0AsPw3l+1W1UT
	Woef71/gDawWBhmnZ3EOt7DdIwrjzGIpw8wYlh2M4OTpQXkFlSPO
X-Google-Smtp-Source: AGHT+IFbI6VvfNKlbzoVh0+60FyeSJFj5XowYUjGq2PbZVoAMwdo0+F3B8iiBtmxWi2S6WXUu2uLYg==
X-Received: by 2002:a17:906:c18f:b0:a63:49a5:9390 with SMTP id a640c23a62f3a-a65e8f74d3dmr31749066b.41.1717027382462;
        Wed, 29 May 2024 17:03:02 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c97a41esm764532666b.96.2024.05.29.17.03.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2024 17:03:01 -0700 (PDT)
Date: Thu, 30 May 2024 00:03:01 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Jaewon Kim <jaewon31.kim@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Jaewon Kim <jaewon31.kim@samsung.com>,
	Mike Rapoport <rppt@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tkjos@google.com" <tkjos@google.com>,
	Pintu Agarwal <pintu.ping@gmail.com>
Subject: Re: (2) [RESEND PATCH 00/10] memblock: introduce memsize showing
 reserved memory
Message-ID: <20240530000301.zvirmigx3pdw474w@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <ZkxN0yQ7Fb0X26hT@kernel.org>
 <20240521023957.2587005-1-jaewon31.kim@samsung.com>
 <20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
 <20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
 <20240524090715epcms1p274939a1d5954be3423f6ce14a3df6f92@epcms1p2>
 <20240527013504epcms1p22bec7b83f2a42e76877b97ed0d769009@epcms1p2>
 <CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p7>
 <20240529095119epcms1p73f0e9ff756bcb2ee6a14db459128a644@epcms1p7>
 <20240529113519.jupuazcf754zjxzy@master>
 <CAJrd-UuiDq-o=r7tK=CG6Q3yeARQBEAtaov2yqO6e6tBwJZoqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJrd-UuiDq-o=r7tK=CG6Q3yeARQBEAtaov2yqO6e6tBwJZoqQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, May 29, 2024 at 10:10:29PM +0900, Jaewon Kim wrote:
>(Sorry I might forget to change to be plain text)
>
>Oh good thing, I did not know this patch. Thanks.
>
>By the way, I've tried to get memblock/memory and kernel log from a
>device based on
>v6.6.17 kernel device, to see upstream patches above.
>memblok/memory does not show region for

memblock/memory only shows ranges put in "memory".
memblock/reserved shows ranges put in "reserved".

If we just put them in "reserved", it will not displayed in "memory".

>0x00000000_80000000..0x0x00000000_8195ffff.
>
>   0: 0x0000000081960000..0x00000000819fffff    0 NONE
>
>The kernel log shows information for 0x0000000080000000..0x00000000813fffff, but
>we don't see information for 0x0000000081400000..0x000000008195ffff
>from kernel log.
>
>(I removed the name.)
><6>[    0.000000][    T0] OF: reserved mem:
>0x0000000080000000..0x0000000080dfffff (14336 KiB) nomap non-reusable
>AAA
><6>[    0.000000][    T0] OF: reserved mem:
>0x0000000080e00000..0x00000000811fffff (4096 KiB) nomap non-reusable
>BBB
><6>[    0.000000][    T0] OF: reserved mem:
>0x0000000081200000..0x00000000813fffff (2048 KiB) nomap non-reusable
>CCC
><6>[    0.000000][    T0] OF: reserved mem:
>0x0000000081a00000..0x0000000081a3ffff (256 KiB) nomap non-reusable DD
>

I guess those ranges are only put into "reserved"? Have those ranges put in
"memory"? Would you mind point the code where those messages are printed?

>A smart parser should gather these kernel log and memblock/memory log
>and should show
>log like my memsize logic shows below.
>0x0000000081400000-0x0000000081960000 0x00560000 (    5504 KB ) nomap
>unusable unknown
>
>Thank you
>Jaewon
>
>On Wed, May 29, 2024 at 8:35 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>>
>> On Wed, May 29, 2024 at 06:51:19PM +0900, Jaewon Kim wrote:
>> ><!DOCTYPE html>
>> ><html>
>> ><head>
>> ...
>>
>> Would you mind sending it in pure text again?
>>
>> --
>> Wei Yang
>> Help you, Help me

-- 
Wei Yang
Help you, Help me

