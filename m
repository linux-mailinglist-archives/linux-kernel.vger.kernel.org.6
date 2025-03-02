Return-Path: <linux-kernel+bounces-540674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A543A4B39A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA231891C3D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEC01EB9F4;
	Sun,  2 Mar 2025 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjsVxN9U"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CEF1EA7F6;
	Sun,  2 Mar 2025 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740934587; cv=none; b=u6QQPKUdl3WGOcXObZuC0rcMInNWv37fYVpVLaeztlIoJN1KgQMKddKbUnJvtVUX133OyhTwm7gNCsoKNOSazVDirw+Jtm+9L+TkM6Ns4XErVmph92v28wzsw/Xth5BfrbxHqgNzdY+n5CskjXNd5vnnlHMDX2zdDlRWlvv+oRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740934587; c=relaxed/simple;
	bh=oqDPOn9PfAlEv4qL7Ae8YvlpjPZgISzpO+x/mO5VGd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnHnUgXYaOPY0C7rgIEM0Pvry12U2cc9cJkeqgw8KM6feWHLU4nkE2a/LdANJzoSFrmcp0M+GRmYYl5Lxgt6cWoRiDY0Kp5LivWQWKCTzDkaRDUi7lrx9mXw7430mY43ee0XGt+vEzoDQkM9r7Q1Kg3Gq5HpBclJluS/KXliqYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjsVxN9U; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e52c1c3599so1427806a12.2;
        Sun, 02 Mar 2025 08:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740934584; x=1741539384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7bUaWA3+rf3ETOGqkAJlZ0iVybSS+eyVOOdkG14icWU=;
        b=AjsVxN9Ut64BLxPu7NK9qeeISBscFyxG84DSjoBs3DyJ5L0cjl0nPTt+W5l/gt09r8
         fJf35IFYPS4aGQjFNM0N5P9bPAu4vtffeHCeCzv/M9f6EbTYZZqGau/nHbvNX0NejlOB
         jkMFJMXuUgNbF/QSUtvCSGU1wHhv6xHN50TXvSYnZxFUTiSHa4zBQ1l26zo0+DZGu/hY
         zt1e9V5CSgh0ML40EkAQ2DyWVaENZuEn5ucx+5OPPoxPXpZELZCDLDy4t2v52Efr8q1q
         +Ua6bR6b7HItSHwRPnSCULLwReOaAkw3sb1BjHC/3OPQE4Q6O8hSg0qsbLuGLoxWHN7K
         3POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740934584; x=1741539384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bUaWA3+rf3ETOGqkAJlZ0iVybSS+eyVOOdkG14icWU=;
        b=cieb/+rMX6ad6ka46QCF3J4pi/vp/2mEQh+Ny2yboXYL1UfVF1L8ENQ+3/cRbv5ji2
         zUHO+6E4qOxsC7i0imqlPdpDJ5kfqiUMAKVgGxKmdWjzSBanAgqfYy9XDnKIIHN6c52K
         0nTQSfCyTKdFWsrzWf82keCRJK1fO1fSfqyH2kyAYGwnJ5lpAqRJR7zhQI9Bt5eFPiJY
         /LCdjoxumAWsmjLLEfEWN7F1kd3o9Pl4OMZtQdFj3R32wFj0ovCz57nDhaldXXgmfsUk
         sFaMMQwzVSPy6/5jl7a1X6vaSLg80txQktbf1JDORhzS+3FrP6wkmboOKKunvw1w4yJP
         85Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUwCZ9wUPUNILVtl5vFKK0rX5CbMzcVZS3m+P5QlKsLM5Izaz/RtTk54fJaUAIslXJtboCr/txXqVVOKEQ=@vger.kernel.org, AJvYcCXgjJ/EpR4I7YVZUpUWT38t+afMO+OUwj+lDkYe+Y4fJnMf3D+JM17GyKGS+sqrsvNw2Qkc46JwE9vw+XN4zmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFGWqhQjQnw2GtEKIfC4nJaMy65YrJETgQ4Rk/GhuzN3kQSoVE
	cioQFIfBkDfq0jhP99SELHssPHbPXQ0qLhbhK1i64xLkLG9oxoOZ
X-Gm-Gg: ASbGncvVDgv5wSb5II8D730HOq+dK1P9+vmsHZ7TMboCH/0PMls8zc7WZ/9NnLrxecU
	1d8hbzVMUzQcgb2RvwMbiwOjOeq6SyMYpbiVsnKlpRXDfsnd7BokgnussY7bnH0P6xfUuMPtR2O
	K4MFpDExE0ZuQzaSwC9O1++CkqQkFmvwvcDrzzX9/3K4uHr3a32yZrPHS7+6YiGCaFEDbvFMDZZ
	oIBEer5WTDldPMzlXMk5qUHXQg0BF0YopoG4XLnIfY0MoXa5zKxzEJyfqjC4KwqMuF6qgdfA0rU
	6ff74eB7JRm6K1nB9GsfmyaT0UnXm7ctYQ6N2oF25yUubvQOeKUh4+0OWSK8hlZFPxVQ87aJvM9
	RW/FiwRmCWX10DO+3JNqkvJgKn8A/c+3OZPjtBWJbDdMQu9NrkYngo7jV//Gz5GY6VTUE7dVmBz
	Gd
X-Google-Smtp-Source: AGHT+IG5tgOrH70ZH30Vx5gQRasCfasKK/oH0hb091aO0YOkuKhwhi9iH/CWb2TEnII8qc3FEzNwUQ==
X-Received: by 2002:a17:906:fd86:b0:ab7:8d23:1fef with SMTP id a640c23a62f3a-abf261fae62mr1420672866b.9.1740934583397;
        Sun, 02 Mar 2025 08:56:23 -0800 (PST)
Received: from ?IPV6:2003:df:bf03:a200:eeb1:4cf6:acf1:a130? (p200300dfbf03a200eeb14cf6acf1a130.dip0.t-ipconnect.de. [2003:df:bf03:a200:eeb1:4cf6:acf1:a130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c7bf82fsm671238266b.173.2025.03.02.08.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 08:56:22 -0800 (PST)
Message-ID: <04f71cbe-7521-460e-a104-9c2a6b80614e@gmail.com>
Date: Sun, 2 Mar 2025 17:56:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/9] rust: Introduce interrupt module
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Christian Brauner <brauner@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Xiangfei Ding <dingxiangfei2009@gmail.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20250227221924.265259-1-lyude@redhat.com>
 <20250227221924.265259-5-lyude@redhat.com>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20250227221924.265259-5-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27.02.25 23:10, Lyude Paul wrote:
> This introduces a module for dealing with interrupt-disabled contexts,
> including the ability to enable and disable interrupts along with the
> ability to annotate functions as expecting that IRQs are already
> disabled on the local CPU.
> 
> [Boqun: This is based on Lyude's work on interrupt disable abstraction,
> I port to the new local_interrupt_disable() mechanism to make it work
> as a guard type. I cannot even take the credit of this design, since
> Lyude also brought up the same idea in zulip. Anyway, this is only for
> POC purpose, and of course all bugs are mine]
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Co-Developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/helpers/helpers.c   |  1 +
>  rust/helpers/interrupt.c | 18 +++++++++
>  rust/kernel/interrupt.rs | 83 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs       |  1 +
>  4 files changed, 103 insertions(+)
>  create mode 100644 rust/helpers/interrupt.c
>  create mode 100644 rust/kernel/interrupt.rs
> 
....
> diff --git a/rust/kernel/interrupt.rs b/rust/kernel/interrupt.rs
> new file mode 100644
> index 0000000000000..c0a4b182fd9e7
> --- /dev/null
> +++ b/rust/kernel/interrupt.rs
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Interrupt controls
> +//!
> +//! This module allows Rust code to annotate areas of code where local processor interrupts should
> +//! be disabled, along with actually disabling local processor interrupts.
> +//!
> +//! # ⚠️ Warning! ⚠️
> +//!
> +//! The usage of this module can be more complicated then meets the eye, especially surrounding

Typo? then -> than?

Dirk


