Return-Path: <linux-kernel+bounces-553949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 697E7A5910A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B1B3AA1EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25934226CF0;
	Mon, 10 Mar 2025 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ny/JLlAt"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC69A22652E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602219; cv=none; b=nrGkUbA3KdRf6uCbHxZUZ5jMoOFPwPO5LOeGTmNoXXQGDeoO9qhrsMiFguGh5J/87lmezZMNxoLkkVdzHyQlSXz550ad5PdSSF07IvShP34DnXR73tjSnN/weeq3MddwdkzCAQy8FUnZiRpyEnGXbI0Oar3XlhDzmU50oZJjsmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602219; c=relaxed/simple;
	bh=2XwFGzjDpF0x1UFVmFTA6zIi2TOnyhJHi1l7XwZxEvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W60e4LI+fzgLm5mDHlMOXj02G33hqQdvIo1RKdzDkSR8bBR0q0wtZS/m1arGrfokc505qKZNAjGKL8ttvJCgDz9XJ71+PMN3Cu2YxKn2CxijLdRZm396ps07shebj4u4HLXHIXkKIM/HD97pD5256ZxRhh1hTbcys0kRlKKVr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ny/JLlAt; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39133f709f5so1315367f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741602215; x=1742207015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0xh3FQ2ooUNMv0G7MnOObNExBcu0B8GC8+9Yidwtis=;
        b=Ny/JLlAtIbwI9BEDXZTj3VisbPVe7d0AO3dFPgi1QMgtI130GsXybJFpRdRW41xczQ
         1UdfAwB9IY0hKCFfYtVZKsVYDWaaFdA4ooxtC0LWjlzkdxQSRdPg8UQeOw+OL/hO0N8a
         rA2U3DVObV2DizLsm8zu2UulCFbOE1ZZYAgDrZxeyeyPmwtOq5TkFM9RWvJqPLP1BQXT
         e61p2UUCZ9VWKASX8wIsdQ3GCWkHqBcDXbMuDzelGNAfHeF+ig8f0YmoeLZV5Xka4fW0
         Fq7/PgGma0VM9skuu0apA6EoYudNB+2DWGLVJUY0+Vit1LaeVaCvjK3tJo6mRiOWRmXX
         TFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741602215; x=1742207015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0xh3FQ2ooUNMv0G7MnOObNExBcu0B8GC8+9Yidwtis=;
        b=fPHN/proZL0bDqeBK0P2BqwfLomEGv+Q13YM14WKvv8TFQuf+UOWZjFLSWpOkGsshi
         ihE13lUPz3faFP/Mh+7gePghb+grgDvoxsZo51oHHSxknejT/w5wyN7Htk7SoVB1yCqX
         HdDNIuHsE9pB/0IpjatOzoVTIfzlAe1ypg1nP240XmdMnNthW0fdjy8ukN68vRmIqC5U
         cJRzYj3Rto/LG90SvlD2FJK2lu4DgSSk2JnVaLr4L9r9IHF3W7vxJHfvbI3fhvjTyBK/
         7Xk4T2Gy5LF4jx4eKrvr2FpPxNcZ0MdymMZnAM7tSwT66ShRBcGpV/wS3QftkXyc8IhX
         YXDg==
X-Forwarded-Encrypted: i=1; AJvYcCX4LV+/GTE2dESezkZ/XwS30guCfk8O33NFAJoEOOQlsefeacWpNhw4uYEX4b14UJBab4kpdB5MOCsL1eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtidSwnbvV8O8Xj9VJXb1xebbIypBc+CjtBFahE+eJoV2tqCHQ
	c+macLtnZAZLjBjqf+6L0JMLt76PqlI2i6iW/sDVyoG2UFKZUclKKm8UjHwRgFjnpssaXHGbBSR
	Cl4u17tm3lyJkrbXu985aohLwEVV+c0mDXxZK
X-Gm-Gg: ASbGnctgoAm2W9sKkMmpT+PsSyXyxNilIYJabRWedptYnA0RXy2QJdnRU/UN9hi9Bgj
	yZNCERnAyvY7rDwete5HemlQ6wnC7kMMngIwiyPPvrz8fZ4dUSmUafReZr9QRRVSNbPdFFHaZVr
	lCg2+6XaiVL4GJmNIAuEMrf3kj++yQ4ODpi1l6qDBnrQCn3ge0HvoiIA==
X-Google-Smtp-Source: AGHT+IG6hUDw4rYaXTIDcQ0LDrqHThCZrRr65SaZXB8OZtLA5fDQVnneu5xULnptFbYCv65le8nwb6KH/dSV9yt6n+0=
X-Received: by 2002:a5d:584f:0:b0:391:ffc:2413 with SMTP id
 ffacd0b85a97d-39132da08b4mr7510954f8f.40.1741602214935; Mon, 10 Mar 2025
 03:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-inline-c-wrappers-v1-1-d726415e6332@posteo.net>
In-Reply-To: <20250310-inline-c-wrappers-v1-1-d726415e6332@posteo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 10 Mar 2025 11:23:22 +0100
X-Gm-Features: AQ5f1JrcfSdFN8DKHXryu_jbKmLUDqV8puN-y6GO6BW9VxRHHXfINkGlFd0wh8s
Message-ID: <CAH5fLgi1YOP9gbXEmYfBtjWeMaqsYpNrrC1fd2rGABCKWYVcbg@mail.gmail.com>
Subject: Re: [PATCH] rust: task: mark Task methods inline
To: Panagiotis Foliadis <pfoliadis@posteo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 10:40=E2=80=AFAM Panagiotis Foliadis
<pfoliadis@posteo.net> wrote:
>
> When you build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> toolchain provided by kernel.org, the following symbols are generated:
>
> $ nm vmlinux | grep ' _R'.*Task | rustfilt
> ffffffff817b2d30 T <kernel::task::Task>::get_pid_ns
> ffffffff817b2d50 T <kernel::task::Task>::tgid_nr_ns
> ffffffff817b2c90 T <kernel::task::Task>::current_pid_ns
> ffffffff817b2d00 T <kernel::task::Task>::signal_pending
> ffffffff817b2cc0 T <kernel::task::Task>::uid
> ffffffff817b2ce0 T <kernel::task::Task>::euid
> ffffffff817b2c70 T <kernel::task::Task>::current
> ffffffff817b2d70 T <kernel::task::Task>::wake_up
> ffffffff817b2db0 T <kernel::task::Task as kernel::types::AlwaysRefCounted=
>::dec_ref
> ffffffff817b2d90 T <kernel::task::Task as kernel::types::AlwaysRefCounted=
>::inc_ref
>
> Most of these Rust symbols are trivial wrappers around the C functions
> signal_pending, uid, euid, wake_up, dec_ref and inc_ref.It doesn't
> make sense to go through a trivial wrapper for these functions, so
> mark them inline.

There's no C function called dec_ref or inc_ref? Please use the C
function names instead of the Rust ones.

> After applying this patch, the above command will produce this output:
>
> ffff8000805aa004 T <kernel::task::Task>::get_pid_ns
> ffff8000805aa01c T <kernel::task::Task>::tgid_nr_ns
> ffff8000805a9fe8 T <kernel::task::Task>::current_pid_ns
> ffff8000805a9fd0 T <kernel::task::Task>::current

I think it'd be nice with an explanation of why you did not mark these
#[inline].

> Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>
> Link: https://github.com/Rust-for-Linux/linux/issues/1145

The SoB usually goes at the bottom of the tags.

>  rust/kernel/task.rs | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 07bc22a7645c0c7d792a0a163dd55b8ff0fe5f92..996d7c96e48689a5752817f9c=
a196c021865291d 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -273,18 +273,21 @@ pub fn pid(&self) -> Pid {
>      }
>
>      /// Returns the UID of the given task.
> +    #[inline]
>      pub fn uid(&self) -> Kuid {
>          // SAFETY: It's always safe to call `task_uid` on a valid task.
>          Kuid::from_raw(unsafe { bindings::task_uid(self.as_ptr()) })
>      }
>
>      /// Returns the effective UID of the given task.
> +    #[inline]
>      pub fn euid(&self) -> Kuid {
>          // SAFETY: It's always safe to call `task_euid` on a valid task.
>          Kuid::from_raw(unsafe { bindings::task_euid(self.as_ptr()) })
>      }
>
>      /// Determines whether the given task has pending signals.
> +    #[inline]
>      pub fn signal_pending(&self) -> bool {
>          // SAFETY: It's always safe to call `signal_pending` on a valid =
task.
>          unsafe { bindings::signal_pending(self.as_ptr()) !=3D 0 }
> @@ -319,6 +322,7 @@ pub fn tgid_nr_ns(&self, pidns: Option<&PidNamespace>=
) -> Pid {
>      }
>
>      /// Wakes up the task.
> +    #[inline]
>      pub fn wake_up(&self) {
>          // SAFETY: It's always safe to call `signal_pending` on a valid =
task, even if the task
>          // running.
> @@ -328,11 +332,13 @@ pub fn wake_up(&self) {
>
>  // SAFETY: The type invariants guarantee that `Task` is always refcounte=
d.
>  unsafe impl crate::types::AlwaysRefCounted for Task {
> +    #[inline]
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the re=
fcount is nonzero.
>          unsafe { bindings::get_task_struct(self.as_ptr()) };
>      }
>
> +    #[inline]
>      unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>          // SAFETY: The safety requirements guarantee that the refcount i=
s nonzero.
>          unsafe { bindings::put_task_struct(obj.cast().as_ptr()) }
>
> ---
> base-commit: 7f0e9ee5e44887272627d0fcde0b19a675daf597
> change-id: 20250308-inline-c-wrappers-da83ec1c2a77
>
> Best regards,
> --
> Panagiotis Foliadis <pfoliadis@posteo.net>
>

