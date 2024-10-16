Return-Path: <linux-kernel+bounces-367613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 391129A0475
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA43284FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7861FE0F2;
	Wed, 16 Oct 2024 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vz2hSlhG"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2641FDFA9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067882; cv=none; b=VldGJOJXj1vMP6hjgk8hsSujFcnjir4k5O8Ha2ySn1q3U5+Sp6kXpIlLUXQjcjQLoGxASYJ7hH3Cg5I8pvvqop96J65G0XPLEZq2dtGd96/LI3oNc98jTpMIYkYr2qPP4SeC3qGwapLpHDCPeOgyXsKOWVSf51uck5tzT5Jywq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067882; c=relaxed/simple;
	bh=7mSyqukGBIpCmay8QT2V728qhVZnc5Gk5vx+ah5E968=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJQk/DC0InM7LX0uJ/yS+hD1mbXGXBTT6fh3tSSVz3YhkJesPl/+PCbE5Sag8e98baLVELOdYTMsmu+Hd/UBq97cg4XUdOb3nCzJbSWEhD59groO5PhbGDopx+dNoQIr8946wFugtNNLMjreMuSAanvxC/hNrVQ1BbQQoXQWR0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vz2hSlhG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d47eff9acso3728858f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729067879; x=1729672679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os7rW/WsJREBniJI2Ek1CEyJc60qK11pTVrWpv5Tjf4=;
        b=vz2hSlhGXMo7sq89w121E4otwC5bmH089st3UXKOekHf8YNoR4yzFcn0keh48cS4/B
         D2gE+91DM5RT1yqXH4Y2UHzCl+JHQt1s9FpKysf+NJD537e9FUkyMDjbqRTnQgoRcWh2
         o8NXOMfpr8dfVTMmVzw/Mbd54+Qkl4UELrY4NA3UG2PlsPB3FQ+YOIWP7d8hZD2zLhTS
         d8wPcaZpL4Njef87sQ1Iv09fM5ULcmOULfYcXB1zbUVKGpD39bb1TB8nqgomdDvtQumt
         XAHFioNzJW8sr3L+JdKEzIwAwiPlNhKNtck0MdFR1gfc6dYKvouXij9Rr+QhimtRi4qZ
         urZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067879; x=1729672679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=os7rW/WsJREBniJI2Ek1CEyJc60qK11pTVrWpv5Tjf4=;
        b=bBx9ObY1rFg8PWgIvX2ROV+88jFuLSg96SsFofPsg9iGc6cvAXuqjuiwlT3l2/XbqE
         jmmVA8y/VNe7uIiydbJ0kdrQ+VDi+VJneop1k8aQCeEFL6JSsgZB8NunlbYegg6OI83v
         jzkkNjxWICN5Rf5E3ZQZPJofch28sVtLnEuXlv0leXI56HoRCwu0UQ0XAMREOKS/fkb0
         qy12FB+Yh/R/SmNs0YybctGrBiTqksIFI6gWaVyyh7PjQc64DlOFG2xmIfxs6uy1SqQO
         pBbHhMfEVoEnQLLrtCRBHwV1BH/r4r3cp069y/1B6B0nWZNZq4jheJBNLLW/V1itM9FH
         WXcg==
X-Forwarded-Encrypted: i=1; AJvYcCUygq2FSyV0KejfpOnAC6mVT0e7h/i+YX1O4+vSp7l+FC81sgo5WTTRcxfQai7bUgJpAtCsbtqPLOrNmx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/1ggTqzOCOX1ogGaU1vz5H/x9Mw05ctCSfbWhKSrX+yIYoAM
	tcijjV3dZsUKnZw6Gwf94+sqql0yRgjvwc5oltkr9sCEqV8QkzS00fBz4bcGtcX+azw1eLp40Si
	0NWqXlo0SAEuSCasaqmqOavg8YR77vbY9+gLB
X-Google-Smtp-Source: AGHT+IFtqFr8sAA3n5PIT0gMS+hHwcyB4XYLtQMFXrhL+hF2dIVZULC0RiaS0vkrRZOcXCMWIFMbLLtpWE9aZ8l4Hkc=
X-Received: by 2002:a05:6000:b03:b0:37d:4cee:55b with SMTP id
 ffacd0b85a97d-37d600c927bmr9358470f8f.59.1729067878806; Wed, 16 Oct 2024
 01:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com> <20241016035214.2229-8-fujita.tomonori@gmail.com>
In-Reply-To: <20241016035214.2229-8-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 16 Oct 2024 10:37:46 +0200
Message-ID: <CAH5fLgg1G4++B+AoXrDc-QxiNL8T4zRV3ChbwN1LsG=urcMJmw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/8] rust: Add read_poll_timeout functions
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, 
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 5:54=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add read_poll_timeout functions which poll periodically until a
> condition is met or a timeout is reached.
>
> C's read_poll_timeout (include/linux/iopoll.h) is a complicated macro
> and a simple wrapper for Rust doesn't work. So this implements the
> same functionality in Rust.
>
> The C version uses usleep_range() while the Rust version uses
> fsleep(), which uses the best sleep method so it works with spans that
> usleep_range() doesn't work nicely with.
>
> Unlike the C version, __might_sleep() is used instead of might_sleep()
> to show proper debug info; the file name and line
> number. might_resched() could be added to match what the C version
> does but this function works without it.
>
> For the proper debug info, readx_poll_timeout() is implemented as a
> macro.
>
> readx_poll_timeout() can only be used in a nonatomic context. This
> requirement is not checked by these abstractions, but it is
> intended that klint [1] or a similar tool will be used to check it
> in the future.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Link: https://rust-for-linux.com/klint [1]
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Duplicated SOB? This should just be:

Link: https://rust-for-linux.com/klint [1]
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

> +/// Polls periodically until a condition is met or a timeout is reached.
> +///
> +/// Public but hidden since it should only be used from public macros.
> +#[doc(hidden)]
> +pub fn read_poll_timeout<Op, Cond, T: Copy>(
> +    mut op: Op,
> +    cond: Cond,
> +    sleep_delta: Delta,
> +    timeout_delta: Delta,
> +    sleep_before_read: bool,
> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: Fn(T) -> bool,
> +{
> +    let timeout =3D Ktime::ktime_get() + timeout_delta;
> +    let sleep =3D !sleep_delta.is_zero();
> +
> +    if sleep_before_read && sleep {
> +        fsleep(sleep_delta);
> +    }

You always pass `false` for `sleep_before_read` so perhaps just remove
this and the argument entirely?

> +        if cond(val) {
> +            break val;
> +        }

This breaks out to another cond(val) check below. Perhaps just `return
Ok(val)` here to avoid the double condition check?

> +        if !timeout_delta.is_zero() && Ktime::ktime_get() > timeout {
> +            break op()?;
> +        }

Shouldn't you just return `Err(ETIMEDOUT)` here? I don't think you're
supposed to call `op` twice without a sleep in between.

> +        if sleep {
> +            fsleep(sleep_delta);
> +        }
> +        // SAFETY: FFI call.
> +        unsafe { bindings::cpu_relax() }

Should cpu_relax() be in an else branch? Also, please add a safe
wrapper function around cpu_relax.

> +macro_rules! readx_poll_timeout {
> +    ($op:expr, $cond:expr, $sleep_delta:expr, $timeout_delta:expr) =3D> =
{{
> +        #[cfg(CONFIG_DEBUG_ATOMIC_SLEEP)]
> +        if !$sleep_delta.is_zero() {
> +            // SAFETY: FFI call.
> +            unsafe {
> +                $crate::bindings::__might_sleep(
> +                    ::core::file!().as_ptr() as *const i8,
> +                    ::core::line!() as i32,
> +                )
> +            }
> +        }

It could be nice to introduce a might_sleep macro that does this
internally? Then we can reuse this logic in other places.

Alice

