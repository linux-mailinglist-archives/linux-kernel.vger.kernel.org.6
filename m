Return-Path: <linux-kernel+bounces-257852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE79937FC3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 09:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEEA6282110
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 07:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646A527471;
	Sat, 20 Jul 2024 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcwLmjhj"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F981803D;
	Sat, 20 Jul 2024 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721461524; cv=none; b=prEyN9xQFNN/BiYSH2pKcisLJ431PEYOpPluYYJD/ldlqVzFstInc58pEN4LWcLd7/h2U5DRHIjR/ewnuHBYC9VpiFXgGyaPDESg/CaAZuasDV0JGWP7yyJTt3zBFbJon7YsLNQ2lLYKMHwWpkXU02UzL/xe4yzsfAGsHyTJF44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721461524; c=relaxed/simple;
	bh=8XW/4jDCJCDtE1xXESYvd0/J50ZJZ0+gnWMSeQm0LPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIKj/b6WKPRc+jPjXiuutEPhuZ4tqcRdBeGo8k4ADkRSQEVk7QK92EPyy9i9cspomdiPH+ZnKyc011OKH9bGgLwBEtuQDdD0wqFREINlYgg4OIXm/XJcpAQBXRsYDNfh8zZxVgjCi4s1BtsVDfqXFceqAwE9RRsGErDwX4dKRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcwLmjhj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6fd513f18bso269535366b.3;
        Sat, 20 Jul 2024 00:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721461521; x=1722066321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qN6YI/mufEzKuPLBazpeYZo/dW8SXxQZjAJtniz+IpA=;
        b=KcwLmjhjrBtC5pFXGeB6av9oWz9cb5PvMzczsGxeAgfUMrJ60F9XKKyc8DTb/zvMcL
         VQCm5FJjUD3Cc3Dpxo7jT6IAMrtxh8P43Zrc5hm/TfS8+2yY3YxAJ+sCBm9lYLwWJAb6
         6dGu3Qx/7TfDiIM1ZJu6ioSo4X8mNvOl44dF4N0NLXQ008lb9auj9XxD3BeZwwumxiZP
         zFOqGHLM8qpOLn4XJbNtIwyXwRdL1D5oAos7iQi9wol6Mpwe3f+0KEXJwF8ZKN5Tgjw7
         /zcRuvWdDWtIizlyugzNSr6iawKLs02+J3BGaCFbXOOfD74/Db3HGetbvyItvUspaXAP
         8dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721461521; x=1722066321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qN6YI/mufEzKuPLBazpeYZo/dW8SXxQZjAJtniz+IpA=;
        b=U2V3d7Gzm7u+R5InxPN6OnfGFd7KIBC/xGO6Yo5+GWwdce4etPMJhv8ZbY0YOaZj7N
         +bL9/952scHsjHTRGh6PgDcN93tPnHKGAkLC+CH8YGQ7wRt1MpuwTGNi4nH6gw1I1/+O
         jcRLhn6k5O0dfQRn1/kAm1YE5iIjv1BYX1Qr6WPaegeW8svKaHJsAbWB1nfLJL9OT4hv
         d2LF1WN49DHTRjArWtYCK6bH8cTK9ZZp1WQs5BbT2mEu9n3OE9hTpppFKpF7jAdbfpE2
         t51HOcpUAc2OPUpP+zdOrrQ62CTJw/JiHMo4clvWZ7pyY+1D3LOfCqGy9Jjob9HaCKwb
         Y+ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/xiBk1DPV6lQqCUuUR78ALxaQ4m1mTa4MZ7HDbe6PU5gLs6LcrRw+NOg0YMz4gvMMj7VaVzPpFsOzSt5+zMOhUkDUf+EvHd5Mhusmxw4yB0HScIM0TH9a33KbAr2fwHXcz/I9jcJ2ayVgxjc=
X-Gm-Message-State: AOJu0YyxLT3IUhLB5e9QsPSTax/dbuNL2l0efuRexg2t3iGb4DEFVVJc
	mhaRlUjw7+EQ9kzlpoZmOLN15yIyYWXO3HSD8T8xyIV1Juw1V0oV
X-Google-Smtp-Source: AGHT+IGabo+bK6dL8EdeNMO/dvceqTDyfjXr1xvifW3j+MUVt690CTNjcvjc+ty08SL16KjFjVvDZQ==
X-Received: by 2002:a17:906:ad6:b0:a75:4723:b3b8 with SMTP id a640c23a62f3a-a7a01192d03mr631833966b.29.1721461521301;
        Sat, 20 Jul 2024 00:45:21 -0700 (PDT)
Received: from ?IPV6:2003:df:bf21:aa00:8a2b:1fe0:49c5:d2e5? (p200300dfbf21aa008a2b1fe049c5d2e5.dip0.t-ipconnect.de. [2003:df:bf21:aa00:8a2b:1fe0:49c5:d2e5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c7b6bb3sm124882466b.56.2024.07.20.00.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jul 2024 00:45:20 -0700 (PDT)
Message-ID: <81473f82-0c7d-4f0a-85cb-fae4ef2013df@gmail.com>
Date: Sat, 20 Jul 2024 09:45:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] doc: rust: create safety standard
To: Benno Lossin <benno.lossin@proton.me>, Jonathan Corbet <corbet@lwn.net>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20240717221133.459589-1-benno.lossin@proton.me>
 <20240717221133.459589-2-benno.lossin@proton.me>
Content-Language: de-AT-frami, en-US
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20240717221133.459589-2-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Benno,

Am 18.07.24 um 00:12 schrieb Benno Lossin:
...
> +to undefined behavior even in safe code! The term undefined behavior in Rust has a lot stricter
> +meaning than in C or C++: UB in Rust is totally forbidden. In C one might rely on the compiler

Just a minor formal thing: An abbreviation should be introduced (in 
brackets) before using it the first time. So I would propose:

"... undefined behavior (UB)  ..."

Dirk

