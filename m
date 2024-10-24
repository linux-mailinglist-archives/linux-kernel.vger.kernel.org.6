Return-Path: <linux-kernel+bounces-379114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5612B9ADA33
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854231C216CB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25742155CB0;
	Thu, 24 Oct 2024 03:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPTDhvK+"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9D2E630;
	Thu, 24 Oct 2024 03:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729738967; cv=none; b=BFXAVbRgGw1i8czXoet23Amzz2JAdZM9B9UkReMfRmJk4ePX+jdK6BtA7uZ24i+f2qUFTcyPkVTfPXjUx9Dv+iNQzyx+2X6pZQcy+pT0fOh+oS2VgXdJ4sDu81Tg989Bler1DKJWnAlHPq061kTTeS2Em9ojpf2ZK0xg6WkiEMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729738967; c=relaxed/simple;
	bh=eZz8qi/lk0vuQ0JD9LDB4gmMp5okDKHCHmVJlkeHqNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXOB4MJ4k/Yron2b28yeAC5XHgD0ozw/dOymLZM3GcfTafR+nFCuBv/anHiVWrVHS1K9FZBpul4cv6u3MI64tQD4yIcN5chvIMSPiWurL7Em3iKQWa7W313Pg1orKdhA1RJcPtQGbZudiHHuCoUUA6U90g/oZWho0DlOLJV4NGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPTDhvK+; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e290d6d286eso396623276.3;
        Wed, 23 Oct 2024 20:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729738965; x=1730343765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=urQisYN08SbFdgusjdU5j7nsJH7wIPpsrHy/F5fggw4=;
        b=ZPTDhvK+op3cbN+H6+DqlSV09hy9iFRiFS8mqONhjbVXE8ddV+LAZvy3BDGOVSzOEF
         xWMP1irkKq1qn/tGtsxcFgrpa/UxmB+SQmU5/j+vQNfcKwh/kwFzJ7NbOt+Ja17ndX4E
         r4NX8ExhJ77xFqaRnfhsbwjQgecibyV9bosnouR+D/0GFj6OIFOcnKPvDqvMPMVnXZKV
         IY9aFGrnxctkvOytW0ZvZoEbu0DVaXnR0hpw0VYFKvTSVE2B8C/mh/wFmL/TN94mX8Vy
         FH2H2plY493O7qYv55dBRSszGobyW5JmQI0NHarKB5xSPOPCWGbeoq9cKbfQQJqRceVK
         X9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729738965; x=1730343765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urQisYN08SbFdgusjdU5j7nsJH7wIPpsrHy/F5fggw4=;
        b=B4yswVlM7qCZMbuf5b+CUDenXz8yYzLzwHQ3RcfqEhs3s+HuMgTFXdPDOgiCjyXqsB
         IXzAZJrnb48Xgd1ymZ83kQo41XHO8meVpC3N04gObQdpp8ZYAwOzDwfRzduyJycXW9yS
         sSTbFKJsJEEm7xsVenx075qm5oRX4fnQUgfL2rKBljelfSNuwrDuv3JudidDnaBvUhfK
         JQAxCc/MnlJJKhFpycImXVrCMYpEBpgg7ZZMUm9xEKxPVufWwF1hI8aObxo/xbPzwEoG
         EU2Yh3J2AHYEeUoGqh2WRo0zWYiAb8j0VSE9+HYHBvwgpUahAJbvsoNoz7IQO3bBAwVS
         7I6g==
X-Forwarded-Encrypted: i=1; AJvYcCVUCZF+AQZic8UHpP7ppFHy6tkdzVpTVGJIU2gvi6ASRf8rJLJ+viJfOhgv+m/TMXOeoZ98Sgfkv49I1sDn@vger.kernel.org, AJvYcCVodLyoLvHSCj2Mm+Bfjzucz1bCBKXDgqhi1WR3rubQlBq7t0/YehaE+gmtYZtIiYX1gIS08151pfzrPzt0ZaM=@vger.kernel.org, AJvYcCWFs7r3etQmYcHS8af3kSmjPyud3XFSf3hgzQRElu4Ocp87WLBBr2mh0y/FtTY9eknhan+BjBESVV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/c/DZjNmp9czPH5goUOts4HjjTceAKUalgmi9HUnsD5E91V3
	T67jvBN5Twql/rULEnYNF24AAZuyeowUtRZTT9wqxbHjD9yxcGaD
X-Google-Smtp-Source: AGHT+IHB3lKeYXZA+fZYYgAWG/OglEclq8ocXv2DM48o507wdfYI6apamkGkrD3OMV93qeeSAypdyg==
X-Received: by 2002:a05:6902:e08:b0:e1a:e74a:d910 with SMTP id 3f1490d57ef6-e2e3a64fbffmr4594403276.30.1729738964744;
        Wed, 23 Oct 2024 20:02:44 -0700 (PDT)
Received: from [192.168.2.226] ([107.175.133.150])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdc9b2820sm1704959276.31.2024.10.23.20.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 20:02:43 -0700 (PDT)
Message-ID: <8a8fdd5a-44e6-42b9-a920-ff00ac7dc57d@gmail.com>
Date: Thu, 24 Oct 2024 11:02:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs/zh_CN: update the translation of
 process/programming-language.rst
To: Dongliang Mu <mudongliangabcd@gmail.com>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev,
 Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 llvm@lists.linux.dev
References: <20241023062750.849951-1-dzm91@hust.edu.cn>
 <46e54088-ad96-4387-8a39-2e4686c842bd@gmail.com>
 <345e8f10-fe1a-4736-9468-7c92ac55d62e@hust.edu.cn>
 <e0c34a1b-6801-4ae3-b04f-56dbce5c76d8@gmail.com>
 <CAD-N9QV-EBbSkrZ5TSUt7j3MhsAHMozY59gFOEnSQ1HB9cUsZg@mail.gmail.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <CAD-N9QV-EBbSkrZ5TSUt7j3MhsAHMozY59gFOEnSQ1HB9cUsZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/24/24 10:51, Dongliang Mu wrote:
>>>> Hi Dongliang,
>>>>
>>>> Good job! Most of translation are good.
>>>> Just the above doc seems still English version, give them a zh_cn name may cause misunderstand?
>>> Oh, I see. However, you cannot use gcc or rustc since it already exists in the English documents. We need another name to make sphinx happy. Therefore, why do not we directly use the final version of name? :)
>>>
>> Uh, is it possible to use English version 'gcc' links in this doc? Otherwise,it make sense too.
>>
> https://lore.kernel.org/all/bae3c59c-39a5-4daa-b37e-bbf077d57643@hust.edu.cn/T/#m8a948b24401404806f53e086f57856cf3a56a490
> 
> v2 patch triggers a warning due to duplicate links. So I crafted a v3
> version to use zh_cn prefix before each link

OK. That's fine for this patch. But for long term view, it's better to find a way for duplicate links.

Reviewed-by: Alex Shi <alexs@kernel.org> 

