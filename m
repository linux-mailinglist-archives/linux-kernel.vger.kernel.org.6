Return-Path: <linux-kernel+bounces-357719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE269974B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00251F21CBB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40001DFE2B;
	Wed,  9 Oct 2024 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J06lsB21"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15A18C92A;
	Wed,  9 Oct 2024 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497640; cv=none; b=bjIDxsSi03D766/CtFQtf8mgLwMilNphMMCtpZvfHhbPp1NK8sXVH4IAKdqwtVu+ykWY8P5yPulzLS31n41z8ZKjCGk18rSijYWWvheN+k4kjXFVTXqQAd12bCEgjoB/A7UB6VtmMu3xCWmxAzUVsocFCgdL25enCDhb8RHaqyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497640; c=relaxed/simple;
	bh=XfC3SkocWVRtVo+920XQl5KyZGqj5i5w72C2PreHj9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTNIoa4ubYWyJIh2O25cyRWDpd+gn/BL11R6D78wNHmXW6NSEfasmjWiW+qK/n8DGHnPbdvmkzmQQySPbC5k5hqo3BxeOnscP/drWEWtvVq9YHgfrRCb+4fTK5DXxkw+W8gVgaLNRuM0vqCLfSlGdjtoJTMCspzyfxX7bYhFXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J06lsB21; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43056d99a5aso7657435e9.0;
        Wed, 09 Oct 2024 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728497637; x=1729102437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SkU1AqV1gWitBzfFdvaQ66uFkN//U4RnOTV0fzFYwUQ=;
        b=J06lsB21ihS4h9a8o8oOPct94G+L4vBLXxfzjY45ElKmyRWSRkplovERfbvYmS/XpT
         UzjQX6KO/orVfZyqvqxmYHEUOwsSP8ZnnrO9QPpj1ypOVvbUCc5AzIQ8cv9rD0e9DMI2
         XXZiRhVZhtrKvFHeC/Om780x/MkOrRYh0t2Q8pi+AFkcQJdh67G7L4ljaqhK/aHAj0ki
         9oVNUhzlWZRLyS06mCcukiHrSjtxv5uYFHXH6sVoSYUG4hbu1AeipvyW1ns9WcodGjZI
         tjvFigawlNFrnN7vnrDSd36KI3ad7pUFDvxzp/LE3XMZk0WvmqvrrMKxizGAwAx7J262
         IypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728497637; x=1729102437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SkU1AqV1gWitBzfFdvaQ66uFkN//U4RnOTV0fzFYwUQ=;
        b=pnsj3j3HufJfF8IK2FbbO5TJ4nWd5vIMWuBc0l71VQcNxXjaCGJZRWrLiSGVVH7eRv
         EzxV7n0HJukTK6cq9HWyAcS78I95Es5Aw/V1152DFcUScj1KUTxkGaMJb/coCnmsXcIB
         eZnA7M2gEzDicuvZKk87fhpc3T7ppW7UTSWfmJcO51NEiHtwvkcq3GbklfyNwf7zCIzd
         YqLTCBa4ZJUjwZu3tecFwIwr3LRe5AqZYxXBI1RZDQGGOTuZb3A+x9QTatdWkMZuM43X
         k4BznvryVvYoW99hhAxDDPmmva9/m2ThRHRy4PyYHJGp91BEJXC0SoJDfWoQ86b556ET
         MmXg==
X-Forwarded-Encrypted: i=1; AJvYcCU/t2QDvzFk+wFWEHrVvHRMZbM27g/5TfqnKRvlvpn8Oc7jNCo4+N2GfC8bBwBPsqvLEns0wziR7WPKvspA264=@vger.kernel.org, AJvYcCWAZwIeqJ0JXJMemRpb9jrmOI72Qobj2UaE77cO644BBV/qgsJHv8u36s9YuCieCeNJw/RbHA+9Crp2VLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+L/lIU108dsyOz5owtGf6zpTYU34YxTERtrohlJbvRAc8/GU
	0mnFdziMO2y7I2bvgE+5QXVxb6Sp6o8VQvtZW5Qlwf1aEKQkg2Qd
X-Google-Smtp-Source: AGHT+IHkx6nurrfAJxD0sWxHtBCoalNuyzqQnbaU9uU02qcU+aVZrJV/lXjVE+HXw5FLJ3ogS575kA==
X-Received: by 2002:a05:6000:12c7:b0:374:c33d:377d with SMTP id ffacd0b85a97d-37d481d2de3mr439256f8f.28.1728497636719;
        Wed, 09 Oct 2024 11:13:56 -0700 (PDT)
Received: from ?IPV6:2003:df:bf2f:2200:1a63:5a2f:b369:2dac? (p200300dfbf2f22001a635a2fb3692dac.dip0.t-ipconnect.de. [2003:df:bf2f:2200:1a63:5a2f:b369:2dac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d748d450sm27283945e9.39.2024.10.09.11.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 11:13:56 -0700 (PDT)
Message-ID: <e028afbc-b65f-4633-b33d-74769509f267@gmail.com>
Date: Wed, 9 Oct 2024 20:13:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: improve grammar in commentary
To: Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org
References: <20241009162358.27735-1-tamird@gmail.com>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20241009162358.27735-1-tamird@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 09.10.24 um 18:23 schrieb Tamir Duberstein:
> Commit e26fa546042a ("rust: kbuild: auto generate helper exports")
> added an errant "the" where one was not needed; remove it.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Dirk Behme <dirk.behme@gmail.com>

Thanks

Dirk

> ---
>   rust/exports.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/exports.c b/rust/exports.c
> index e5695f3b45b7..fd278e272751 100644
> --- a/rust/exports.c
> +++ b/rust/exports.c
> @@ -3,9 +3,9 @@
>    * A hack to export Rust symbols for loadable modules without having to redo
>    * the entire `include/linux/export.h` logic in Rust.
>    *
> - * This requires the Rust's new/future `v0` mangling scheme because the default
> - * one ("legacy") uses invalid characters for C identifiers (thus we cannot use
> - * the `EXPORT_SYMBOL_*` macros).
> + * This requires Rust's new/future `v0` mangling scheme because the default one
> + * ("legacy") uses invalid characters for C identifiers (thus we cannot use the
> + * `EXPORT_SYMBOL_*` macros).
>    *
>    * All symbols are exported as GPL-only to guarantee no GPL-only feature is
>    * accidentally exposed.


