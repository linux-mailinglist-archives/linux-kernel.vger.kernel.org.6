Return-Path: <linux-kernel+bounces-274934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55698947E6F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D95B21130
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363A0156F4A;
	Mon,  5 Aug 2024 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptogams.org header.i=@cryptogams.org header.b="f2hew9p2"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988963CF5E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872739; cv=none; b=m46TJ7RRu3ekdgtEKEGPoYG0euyCBqlkDFlqMRZeTLGjbFPOPQhZ5AwzKhVEppCimnT2eo+xP9dBFwoJJeO0kfbeGPzXp8cDGfOCNwcUiNkOiHQYvLDLoptH6yxvUEiIy8Q1B+BAyU77qbxrP/dBYzeGRH2FIHFPaU7w4EF24AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872739; c=relaxed/simple;
	bh=vEB+f0GhXn2Y1GL8VFX5EXsjwXKCJGMgjh2WoM2OcHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTyrVAU2Wk9vF6aT3xZMFjeZk3ZMJTnzjVD5LnGOYJhVXnCni7TGlnjxZEeu6Ox2ZUei0MoZRvWUunTI3hCTQ+jzJ99gTcQ8Vnw6NO6XhQEuLl+pl/SRufSw4yymR3rsBga9mf3o5eTcNoY1a9UpIsEGK9o0WQrWnEITnJiQ0KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptogams.org; spf=pass smtp.mailfrom=cryptogams.org; dkim=pass (2048-bit key) header.d=cryptogams.org header.i=@cryptogams.org header.b=f2hew9p2; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptogams.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptogams.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f024f468bso14545444e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cryptogams.org; s=gmail; t=1722872736; x=1723477536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lgwj/PCY5l3ttsTnYpQqhQu4YQpCRA34f5cZ+qu+J4w=;
        b=f2hew9p2JEDUafLlH3+Q6AgCnQLjyrnO7Sg8PGlJXHt1sV1iRYm3eqaCpYsK3uu8rW
         qrZZYJTfxQOQkaux74SB8hRw2cerKUdWqxsdv/bRYrFvBfArC/fJQKJi3dkJY6nwQXrz
         761N1Nd3xIyxH33cE0FmgBi/EmNgiPzbveI9CTN1XCi/+nNKzlDvbdBjDuI5HFr9HxJO
         h+rAM41zd743O/e4kTEZjCOLBb2OcEc0BBnlv2NTPe/37IOTjAuBaGc0xobBd7GciPdz
         20eJRNo18VFmLqsyib/FLzqDIbDhYEaUEg0eHzSrtX/X7osM1PkSCsBYLjfKHMJF5hU0
         54MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722872736; x=1723477536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgwj/PCY5l3ttsTnYpQqhQu4YQpCRA34f5cZ+qu+J4w=;
        b=SbQciDorh3FxWX0MGkOIkY7LMnfApfh2YFZuBH4WHhtucJB9maJ1Y4fzXUvdqtDuDf
         ElqXSVc3hDFUdVdKjONaaq3HR3hu3cAbZcRhbftyA6KR1Gg/4ZzJcoMmxBCoXuHF4014
         tENADa3KOFrm4v5ShbQeuLN8ay8+EvRiVaUK2DE7d31CYLuQCWFd345geM2VCEZ8RVhs
         Ba5X/HV/OnFi4xWJRSHf3LaxYLIWDbadlIP3HenFAmNM6nfYKkS0tKv8RJRWEvuaGM/k
         dIHcZhj9gd0WM9ktwRWRgde0Lf4UlvWKFaByKDoRNcpoxn+PTQIb9KU4tYKO4AmRGfeT
         aWmA==
X-Forwarded-Encrypted: i=1; AJvYcCVEp1r7HLw1fMo4w2VpzGLNyOkfqyxnK2vFs3/GWtqd2tTjeuQXErczz9c+lLYJfy3TPdaLbzrIymRNmyYkf8x4mdcrqIBlu5kfCjdR
X-Gm-Message-State: AOJu0YzvgoEPt9I1Puwo0Vy+fUkmHqIeCBoYS9+S8zrFD38faHUsuYnq
	wqoeXdndg444A/1elGvD1VdaIJQ6KCMoy7cqWT4UwLCF8EqypJydgtxNqEJCGfo=
X-Google-Smtp-Source: AGHT+IFhHFjmWGoDB9H51c2IPL5yCBn7vA265Ma7mTCoX6o1wOoZj6MQCb7OTojuBIUL5S9rjQKI9w==
X-Received: by 2002:a05:6512:3b8c:b0:52d:b150:b9b3 with SMTP id 2adb3069b0e04-530bb3b6fb7mr7704753e87.32.1722872735336;
        Mon, 05 Aug 2024 08:45:35 -0700 (PDT)
Received: from [10.0.1.129] (c-a9fa205c.012-252-67626723.bbcust.telenor.se. [92.32.250.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba353c2sm1195003e87.212.2024.08.05.08.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 08:45:35 -0700 (PDT)
Message-ID: <7a288592-4793-4743-b8ef-c76de1dcca5b@cryptogams.org>
Date: Mon, 5 Aug 2024 17:45:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [herbertx/cryptodev] crypto: arm64/poly1305 - move data to rodata
 section (47d9625)
To: Justin He <Justin.He@arm.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 herbertx/cryptodev
 <reply+AAIFISMST74UQEQBJUWW7J6EXDLZNEVBMPHARJBRSY@reply.github.com>
Cc: herbertx/cryptodev <cryptodev@noreply.github.com>,
 Author <author@noreply.github.com>, "David S. Miller" <davem@davemloft.net>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Will Deacon <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>
References: <herbertx/cryptodev/commit/47d96252099a7184b4bad852fcfa3c233c1d2f71@github.com>
 <herbertx/cryptodev/commit/47d96252099a7184b4bad852fcfa3c233c1d2f71/144978326@github.com>
 <Zq18V66ufraB_1-T@gondor.apana.org.au>
 <GV2PR08MB92062BC06FFCFD28B8707592F7BE2@GV2PR08MB9206.eurprd08.prod.outlook.com>
Content-Language: en-US
From: Andy Polyakov <appro@cryptogams.org>
In-Reply-To: <GV2PR08MB92062BC06FFCFD28B8707592F7BE2@GV2PR08MB9206.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>> -----Original Message-----
>> From: Herbert Xu <herbert@gondor.apana.org.au>
>> Sent: Saturday, August 3, 2024 8:40 AM
>> To: herbertx/cryptodev
>> <reply+AAIFISMST74UQEQBJUWW7J6EXDLZNEVBMPHARJBRSY@reply.github.c
>> om>
>> Cc: herbertx/cryptodev <cryptodev@noreply.github.com>; Author
>> <author@noreply.github.com>; Justin He <Justin.He@arm.com>; David S. Miller
>> <davem@davemloft.net>; Catalin Marinas <Catalin.Marinas@arm.com>;
>> linux-crypto@vger.kernel.org; Will Deacon <will@kernel.org>;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Ard
>> Biesheuvel <ardb@kernel.org>; Andy Polyakov <appro@cryptogams.org>
>> Subject: Re: [herbertx/cryptodev] crypto: arm64/poly1305 - move data to
>> rodata section (47d9625)
>>
>> On Fri, Aug 02, 2024 at 08:09:10AM -0700, Andy Polyakov wrote:
>>> Formally speaking this is error prone, because there is no guarantee that linker
>> will be able to resolve it as argument to `adr` instruction above. I mean since the
>> address is resolved with `adr` instruction alone, there is a limit on how far the
>> label can be from the instruction in question. On a practical level, if/since it's
>> compiled as part of a kernel module, it won't be a problem, because the module
>> won't be large enough to break the limit, but it **is** a problem in general case.
> Thanks,
> Can this problem be resolved by changing "adr" to "adrp"?

Not by adrp alone, it has to be complemented with addition. I mean addrp 
gives you the label's page address and you need to add the offset within 
the page.

>>> But why would objtool attempt to disassemble it? Does it actually attempt to
>> disassemble unreferenced spaces between functions? Note that the .Lzeros label
>> doesn't make it into .o file, so there won't be anything in the symbol table to
>> discover as potential entry point..
> There is a similar patch (1253cab8a352) for x86. I guess that objtool/stacktool can be improved in this regard.

objtool is weird and arguably inconsistent. It does look at the symbol 
table(*), and detects the return instructions(**), yet insists on 
disassemble-ability of the whole .text segment... Oh well...

Cheers.

(*) For example it refuses to generated ORC metadata for the following 
snippet

.text
foo: ret

It insists on foo being complemented with '.type foo,@function' as well 
as meaningful .size.

(**) Since it does mark the region[s] past 'ret' as type:(und)




