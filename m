Return-Path: <linux-kernel+bounces-435993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321409E7F7E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 11:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026321883B90
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 10:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7A3145FE8;
	Sat,  7 Dec 2024 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b="jJ3cLZmm"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A418126C0D
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733566508; cv=none; b=kHUnzAJ3Mis8jxaG+qwNUmAFETpEFCNwxn0+2VUYzOHmJb6dhOIJKt4+NiTPvl2M+hey3gummyMG5TozXPxD+KHadRV2Y7xSJclJBbxGzfdTL5htfnDennCw8rTj8oIFgAzdcp/QlVKn2CE056hMitzrSTbR5MvPjNG0BXcxqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733566508; c=relaxed/simple;
	bh=N7PAAdcZXi4j4vcHrnM2RRLxkONJyCqaRZbhJPQCyhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mu/t0iZ22k3zLzC4bbBjQy0pMTF2VxGngXpQ/J9AJHNRvVaR55gFBQdwGq0px7L6ac42fxDaI9q9E/gXD+ez+UhLKGcwxeGTpvnqayCfmxmHkTQCwpPs+awahqG43lsjFM2EiMDUxIJ0LIg9Hk4uUP+uMqUf7U8w+LtcNchSpHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev; spf=none smtp.mailfrom=sedlak.dev; dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b=jJ3cLZmm; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sedlak.dev
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3ab136821so2534316a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 02:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sedlak-dev.20230601.gappssmtp.com; s=20230601; t=1733566504; x=1734171304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ObfMZ37SmD1QbR1Jv5JuQm+mGo6MMRPDunc4/bEgt70=;
        b=jJ3cLZmm1a4D/hudmsPWOIwFAtD0912TaAmuxfrf2Kl/bAD4EuWPP+S3juXxse208Q
         it6w0N0+SapjJHHHd23aR8KMLg373vXeBurhJBl8MHU0jl6qt7RKP3UkrPgaKvDQAA7d
         NY97a3VG/NzV1D77MlnR3Whoxi+f9AxLUcmAN16DtFprRO2uNzU3CMugpOhYmOZY4CbH
         XMovwRRe2EUDBaV1VAT8paOS0eKGse7hPF6JgkY9k0ty2LGklzwompAmZJr5yp6Wcql/
         qJWONrMZFbzH/7kjt1JMCKO766SMVxBjPjjd22NT+hMCnKt1iWQyPC/hhSg7QCM7L7OC
         rcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733566504; x=1734171304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObfMZ37SmD1QbR1Jv5JuQm+mGo6MMRPDunc4/bEgt70=;
        b=vSeSaBIjFimakfTnnf2/EUxod4x2MLNLCKFljnhgSHzmRtaRGGE0MeOxxQdUgu4a2u
         9rdGh8ci/f3pvh7kv0PuaYUDDbbHAty2CTImxp9/M2MBkF+hW9/WT82FuS1GSQuf5wS1
         DZAu2PbonEd1DXXFlE6H/4aYNWK8m3OLiP9ywk9adtdsvNwHZTnezz7Xfiv8UUI2YOyD
         +VqQVkHAGHPxH0CDFnnJ1GwJErk0zcWmICT5znZ2Qfk505ChtsW6DevIhZig87SWSmDC
         I/3qkXTkL/6id5c0jF5J7o5mVIX4dqqwC8iuwnynvBxmr/XkPJe9gs+ZQw+V9Db5PAMG
         4O2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrYnRzDKZGJzrzm1/4skqifzWLTgXBDEMEfO9oyK8xqBlG0IcJMwj5/kIs5jxsXYS8blYyiCAc7c7Lwp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOW6auyByiAVqsCzojBN35ICx896TWo6oF4oZk/8eEE3OadvTP
	FSPZh8TbVihNeDN51dkYWvZsaEyWpF8VUZ7E+fTyvSKMsRx4RyGzKc/u41CAzcQ=
X-Gm-Gg: ASbGncvj9YtAiQJd2Fb5ITmSRd7PspYo5Hsic08DmSjOtjlidb5F7MJT4Zxu3SnBaVv
	atODzC/GFnPXrQ56xEo1wHqd9Cd1a5Jp/Pmy6nPwRLW5+RUZNehyjTRAyONTyYu3TRlVsZkxvqG
	WjNRF5+mk0z3fST7l7fyXpKrfDhCwG8ykntUQrcC/1SFBVX3W4TY4WwJBiYl8HAVwoilu8zPOrq
	wqyxGpNWUMQeDBCZgV+gLO7h1236V4Wm2J4xapUXjlyKeX7Ic4=
X-Google-Smtp-Source: AGHT+IEqrtuo9wLe8auYpHiND4zw6vEIDKTZXy8pZhJR+nf10wlmcqvAIubi8QS9wcA5sqCFHiMvlQ==
X-Received: by 2002:a05:6402:2350:b0:5d0:c9e6:30bc with SMTP id 4fb4d7f45d1cf-5d3be688a3amr5792105a12.10.1733566504084;
        Sat, 07 Dec 2024 02:15:04 -0800 (PST)
Received: from [192.168.88.249] ([95.85.217.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3d51c3c4fsm1212169a12.64.2024.12.07.02.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 02:15:02 -0800 (PST)
Message-ID: <30ddfc7f-4b13-4caf-8859-2cd2e72ef878@sedlak.dev>
Date: Sat, 7 Dec 2024 11:14:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH] rust: macros: add authors
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 guilherme giacomo simoes <trintaeoitogc@gmail.com>,
 Wayne Campbell <wcampbell1995@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 walmeida@microsoft.com, fujita.tomonori@gmail.com,
 tahbertschinger@gmail.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241206192244.443486-1-trintaeoitogc@gmail.com>
 <CANiq72neo_RtANWJu_GW5LxsR5KWxriS1L8nsXkNn7ioiaEQKQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Sedlak <daniel@sedlak.dev>
In-Reply-To: <CANiq72neo_RtANWJu_GW5LxsR5KWxriS1L8nsXkNn7ioiaEQKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/6/24 9:17 PM, Miguel Ojeda wrote:
> There are several ways we could do this:
> 
>    - A single field, that only accepts a list.
> 
>    - A single field that accepts both a string or a list.

Since module is a macro, if we would allow syntax in the macro like:

	authors: ["author1", "author2", ...]

I think we could fight with the code formatting, because when it comes 
to the rust macros, rustfmt is often very confused and we could end up 
with variations like:

	authors: ["author1", "author2",
			"author3"]

or

	authors: [
		   "author1",
		   "author2",
		  ]

and rustfmt would be totally ok with both of them.

> 
>    - Two fields like this (that cannot coexist).
> 
>    - Accepting several "author" fields and append them all into a list.
> 

I think accepting several "author" fields is the best one because it 
mirrors the C API, where in C when you want to specify more authors you 
just repeat the MODULE_AUTHOR("author<N>") macro.

