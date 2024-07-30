Return-Path: <linux-kernel+bounces-268207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6F89421A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03BCCB2117A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF06C18DF7F;
	Tue, 30 Jul 2024 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuaWIpk3"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F201518C91B;
	Tue, 30 Jul 2024 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722371791; cv=none; b=ozDX4PIIGQ+TZk5s7bJCOgUIxWOPvwH6ui9bvEmA/SU/RMSOKJzjeq3/8fVawqVwwkBrYWMdWGHVKAm3YXiQSOjWa1n428BJ2evYVK2BdOdAXFyQNhKTLS0u/q/ftsb5+rFioeejlXygIIr94SfK20h5coLhODT57ovhONhOUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722371791; c=relaxed/simple;
	bh=qdHVnfTVo3nO7tmMxskdGFwLlxMv/CAQsC4rHemx2xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZHypqyDXdxuHfgHpPIBW9I1lPygXhYsOFmu86xlPdTO4vofBhjX5nlnxp8QjtZtC6BmASOqJ4E+AX9jXmlCJ5bxCre+PS0cS3xubfarJO7PQckSWEYBc+v2AFyfLpf72r4Hx3iGOxD2KFKXCLpm0vCgnMTu1A3OyoPJKBXXQp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuaWIpk3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efa16aad9so7518638e87.0;
        Tue, 30 Jul 2024 13:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722371786; x=1722976586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/XjNzJXCdNL6KqxYNrTp89XVp9cZX4iiagSBchs6TI=;
        b=IuaWIpk3d3ANSIAM9zvr3z76TCa88Q9MByIlZtmGxOblaX2ta6z4FcD4I+DOnSY0Bc
         AzhEfVaSSyo3Vsl2BNgaNpPnlDrqZ6lwTSCkyyFLiNNQnbzBkuRCywjHWG9Cbj8BPALp
         JrYg/m2oekGEWnqpFGXb/80Q6qk+wWQtNyJuyaWolLcK2meezX0Sklv6RKw0dKSds8e6
         NZbw02/XPzjG9GIENIIJkVbnbqYNWEALthl4CA2aHeCQvEs2McV1MBSj/vPCl6pwj4pV
         f2Te63d1R4bl8tEnszv47MUF7bhZdMEHVfDrpEOKnY6a+Y19ONT2fVz9objUuci9L2xj
         +Cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722371786; x=1722976586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/XjNzJXCdNL6KqxYNrTp89XVp9cZX4iiagSBchs6TI=;
        b=E6b+d+xNV6A+JH1207kh0hhmXDuNrPaGj7TA8ffVK0rvLulTa23xWveEX1d8z9DkO3
         u8QFU8iUa7PyMTJCF5kdu11OL0lEXyR0SAO6DchsQcl4MeoqfGBRvqRedynjkf3L2rEN
         rS7Q/s7Z8IXGoAlNSuBMVi53ZLd5svw3+6Kc8pqorwQSQCcHFzPEpA9IUh6LX9Ze1DM8
         T+pbQRjE25sNCZVn1ravT+34Rl+ANE4mOdV+upkCm6NVK7r6DP8cw0lSrByGy4dYm2WT
         ArQDU7uYMINezJiJAI+nr5O15I2IGie3Zfnl8NdpnIMxx6JuD4XUjwMb7RCvFt/fm5hu
         kYQg==
X-Forwarded-Encrypted: i=1; AJvYcCX1grBrQHVpyxp3mGzBpmU0C81NtOqhUP7SUhaCjLC2pcJa5oDc7ZqP2IlK6P8VKSyvX6gQ7w+SaRA7nTNbDnc=@vger.kernel.org, AJvYcCXiU+Qkpq4WNvO1Tl8TeRahdCxhMKPQ2DBYkjNOdM2FFjlbYxSP3Ib3B75fNXuiR6cVbCOwWxuCEX9leow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZSWk5gfTpsn+f9SDU7X8HsTU7ARJ0oBFhAZ0H6iBEyQ9T/eUP
	PeoY5JA2zink5x0K4CPPKWfhOFZtf3372tFhckACMKxIjkBrpx0a
X-Google-Smtp-Source: AGHT+IGjxqEwMyxNk7pArNZMq5rayC8VDXVdhCT5ysxA8xd9d9WxB01PKTakbhgRZbhikgwYVzY5YA==
X-Received: by 2002:a05:6512:340e:b0:530:aeea:27e1 with SMTP id 2adb3069b0e04-530aeea2b52mr407616e87.50.1722371785722;
        Tue, 30 Jul 2024 13:36:25 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:50e2::1ad1? ([2001:871:22a:50e2::1ad1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3ab8sm7769941a12.71.2024.07.30.13.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 13:36:25 -0700 (PDT)
Message-ID: <14053c9c-0318-4422-bfa4-739966f8e214@gmail.com>
Date: Tue, 30 Jul 2024 22:36:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: error: allow `useless_conversion` for 32-bit builds
To: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
 Sven Van Asbroeck <thesven73@gmail.com>,
 linux-arm-kernel@lists.infradead.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20240730155702.1110144-1-ojeda@kernel.org>
Content-Language: en-US
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20240730155702.1110144-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.07.24 5:57 PM, Miguel Ojeda wrote:
> For the new Rust support for 32-bit arm [1], Clippy warns:
> 
>     error: useless conversion to the same type: `i32`
>        --> rust/kernel/error.rs:139:36
>         |
>     139 |         unsafe { bindings::ERR_PTR(self.0.into()) as *mut _ }
>         |                                    ^^^^^^^^^^^^^ help: consider removing `.into()`: `self.0`
>         |
>         = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#useless_conversion
>         = note: `-D clippy::useless-conversion` implied by `-D warnings`
>         = help: to override `-D warnings` add `#[allow(clippy::useless_conversion)]`
> 
> The `self.0.into()` converts an `c_int` into `ERR_PTR`'s parameter
> which is a `c_long`. Thus, both types are `i32` in 32-bit. Therefore,
> allow it for those architectures.
> 
> Link: https://lore.kernel.org/rust-for-linux/2dbd1491-149d-443c-9802-75786a6a3b73@gmail.com/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/error.rs | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 145f5c397009..6f1587a2524e 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -135,8 +135,11 @@ pub(crate) fn to_blk_status(self) -> bindings::blk_status_t {
>      /// Returns the error encoded as a pointer.
>      #[allow(dead_code)]
>      pub(crate) fn to_ptr<T>(self) -> *mut T {
> +        #[cfg_attr(target_pointer_width = "32", allow(clippy::useless_conversion))]
>          // SAFETY: `self.0` is a valid error due to its invariant.
> -        unsafe { bindings::ERR_PTR(self.0.into()) as *mut _ }
> +        unsafe {
> +            bindings::ERR_PTR(self.0.into()) as *mut _
> +        }
>      }
>  
>      /// Returns a string representing the error, if one exists.
> 
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
Seems good to me.

If I create another version of the arm support I'll include this there, otherwise:

Reviewd-by: Christian Schrefl <chrisi.schrefl@gmail.com>

