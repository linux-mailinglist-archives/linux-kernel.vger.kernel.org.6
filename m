Return-Path: <linux-kernel+bounces-350767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C5F990952
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47AB2281FB4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1E41CACD6;
	Fri,  4 Oct 2024 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgWuawTm"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B39F1C879A;
	Fri,  4 Oct 2024 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059696; cv=none; b=G7+g1Za89vzb+A2/hQZSC6J/yvsTipfbz0h6MOPaiF9PkdfLgjr5/eCkKfTzjA0T/6AQEIEm++qyI5KgwIChPTTTykvdp+UlrvwCgyK3hw8liD1RNz8ZI5OdDolEkbYjiNLKc8a9CpIDiSL1xOh65ZNA/xmz+0cvWxShbfzAW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059696; c=relaxed/simple;
	bh=9ENwwudg030fJgcl+vjTcgyu268HFLjrYWuJYFeIkq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhWxoonjfhVYBbkhANTegaTLBTyqCzsqPWAo/oxonD8jre7nbxzP4XQxsHD19urO2rEcMZvM+FVkA1dhBUiyD8vnoqaPyOczrPbVfxtLR+Tmmgjml7BQrm0jXOxepb7Ubv3AvReFrc/z99O4jpR8wEOTYaMhUZ5a3DgyZs/z+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgWuawTm; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c88e4a7c53so2522208a12.0;
        Fri, 04 Oct 2024 09:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728059693; x=1728664493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQbOO5HC+JdFXp1E+CQRNx6GHpoeDUgITIDDOfrGswE=;
        b=lgWuawTmTeLtx087NcKBBSEivZJbNkcvDNljGtn14pjtewTyjFSuBSn4OKYFkPI8BK
         vAT8giEX81K2UAlL8DbxibSCE+CYFXgccyyx93byt01NF4A1OOdGfuFdQAgsJW7o4rLe
         L4KhjcHSuA2Ku/T3i0E64n/0G0BbPoj0WEwdRO3FKvg3Ncgm3TLUSnfcBz7mUEGUeToH
         A+daJp+XXo+3+YghPN+vfkUqUzJkopoLGIUgHf3zlQzhGCgcya/VbU+qdsosDqylpoyb
         lzKcIBD8ySxXLpR64BkWkmJ8+TRtqtz2YavRWdaAxXLFvYLPbA/7+bzef4xp0nOA6yeP
         gMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728059693; x=1728664493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQbOO5HC+JdFXp1E+CQRNx6GHpoeDUgITIDDOfrGswE=;
        b=w2JzP46nFGJu5lUF4YAgauq/aeRRxshWVQ4/oxDWZLNbeHbv18azngNP5v7NU/ocdd
         /nhWSi+ZZDwTN2nOiuqa2kHguwy+l/Ujhoww7EjdRMkscWbRyVkG4Oq4g3VAbSLwKWnU
         mx4kFDPS92dU6/gyQJRkBSkCwsXKzcRxehWGNb9aLzOhK6WU5Lubcm6nIkOQnV93v8eY
         EBz+fwKxg1k0vzZ+Y4mYtTvoB4l7z94XaPVjniCS7CJtEzpKrye11jevdFKHzoBsSpG4
         4C45kxilwtVYQXq0Cq5YOET85q2ZB/sxiMJiSAYlHFkRP0nWDdUcvRatBZZAULywx8yW
         SdzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2KAkClUfAnN7dJgECja2VCk2cDgoUAwuMZUNCPLDpVxW+1J3VcFAdNwP1M6iG+QyK5HEaSDCjvTRp/jo=@vger.kernel.org, AJvYcCWqDtX1EkArVOZqsGEZI5AG9o2W5lxu0hGEFAVktSt1eFeoZ5c0sDNUK5zNdol7cCf5nyPESBh7E82QeMjfy40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIvHaECHD7uQCvdWdbSl6xCiI5CMWuSYsmthJ0Ec2B+NlF9WEJ
	gxp3XrBP41lN2Hfa6l5RuRLSs0RYt/AkYxe1zzz0f0f8WSpm8TNSRkK3zYX6
X-Google-Smtp-Source: AGHT+IFnO3CnbUWAx6MepKKGtrtp4DIUPORykSnQ8CpAB7o51PU61NixeMkOLusO1NA+TquR9dW5FQ==
X-Received: by 2002:a05:6402:13cd:b0:5c8:9548:f28b with SMTP id 4fb4d7f45d1cf-5c8d2e0ff65mr2307139a12.11.1728059692442;
        Fri, 04 Oct 2024 09:34:52 -0700 (PDT)
Received: from ?IPV6:2003:df:bf2f:2200:c8eb:5450:fddc:5d96? (p200300dfbf2f2200c8eb5450fddc5d96.dip0.t-ipconnect.de. [2003:df:bf2f:2200:c8eb:5450:fddc:5d96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e0597824sm49663a12.15.2024.10.04.09.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 09:34:52 -0700 (PDT)
Message-ID: <55e1fdeb-97f8-40e4-b3a8-bc7ce8271b9a@gmail.com>
Date: Fri, 4 Oct 2024 18:34:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rust: implement `kernel::sync::Refcount`
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, Dirk Behme <dirk.behme@de.bosch.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20241004155247.2210469-1-gary@garyguo.net>
 <20241004155247.2210469-2-gary@garyguo.net>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20241004155247.2210469-2-gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 04.10.24 um 17:52 schrieb Gary Guo:
> This is a wrapping layer of `include/linux/refcount.h`. Currently only
> the most basic operations (read/set/inc/dec/dec_and_test) are implemented,
> additional methods can be implemented when they are needed.
> 
> Currently the kernel refcount has already been used in `Arc`, however it
> calls into FFI directly.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>   rust/helpers/refcount.c      | 15 ++++++
...
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 0ab20975a3b5..534f098a44eb 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -11,12 +11,14 @@
>   mod condvar;
>   pub mod lock;
>   mod locked_by;
> +mod refcount;
>   
>   pub use arc::{Arc, ArcBorrow, UniqueArc};
>   pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
>   pub use lock::mutex::{new_mutex, Mutex};
>   pub use lock::spinlock::{new_spinlock, SpinLock};
>   pub use locked_by::LockedBy;
> +pub use refcount::Refcount;
>   
>   /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
>   #[repr(transparent)]
> diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
> new file mode 100644
> index 000000000000..4a5b815adc05
> --- /dev/null
> +++ b/rust/kernel/sync/refcount.rs
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Atomic reference counting.
> +//!
> +//! C header: [`include/linux/refcount.h`](srctree/include/linux/refcount.h)
> +
> +use crate::types::Opaque;
> +use core::sync::atomic::AtomicI32;
> +
> +/// Atomic reference counter.
> +///
> +/// This type is conceptually an atomic integer, but provides a saturation semantics compared to

"a ... samantics": Do you like to check that? Either "a ... semantic" 
(without 's')? Or if it shall be plural drop the 'a'?

...
> +    /// Increment a refcount.
> +    ///
> +    /// It will saturate if overflows and `WARN`. It will also `WARN` is the refcount is 0, as this

WARN if ? Not "is" ?

Best regards

Dirk

