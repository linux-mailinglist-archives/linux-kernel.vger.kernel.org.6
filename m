Return-Path: <linux-kernel+bounces-367634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0529A04B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B78DB24ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D566204F64;
	Wed, 16 Oct 2024 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grwYDZXy"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631A71D2709
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068752; cv=none; b=Z8qBjxmM80gXtsSv1ad1WgK8hJNWEOYZUQHKc7cw0KNLinG7RPlpwLxxx3vB6uKhKrHphgB/OTi2qvdUIztnHqVR1oQx9B8KkfTW9V221167owY5FRiOd/8h4+wDdREDBAb7UwkKClI3DaY5kGcrUb4TtrMZqZOb/kTTb8afNIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068752; c=relaxed/simple;
	bh=cbpI01CorBSlhvSPRQMFhdScSdtWFnn1JWE+g2X3uiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4XXKhZ8CrhUlUKTwzLv3WjSXbnXM5Ap4EibZN/5Xtx+q9MFUJLaqHJuzOnXz62yHY5yZX8nSbY57iv7d0PaSji7n2LivsRya5mbOI1p7InaoNTUKbPe4VLzHxWo9AJXQhIB486EQLK8rB9W+LzrzsNNiBjes4kQ+1zGzs5pt0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=grwYDZXy; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so3652809f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729068750; x=1729673550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g93+jT/AcpHh66whjFnNI262tYol3GRMYyQ7fABKQ1E=;
        b=grwYDZXyXyJFLUnCQ07Aox/z9kTXey557+hUWkCBeLB2fC1NZhRo8ueRPOzeiw/bu1
         SPSX72aMok8dBVOKfOOEm27LZpyhMmapgTO8r6TixlF0/VNCZOBu9V1PD8+wrcavL3u+
         bZR1Ji7li76AjR51HyapJ3b5PQw5m/KrFJq5ImfFjRSBtIK2r1CoK75OvP7Hbs7ioiF0
         xhvftHtRiaFEQkffkprpZzl84ggrT+xQHSq5XxshAJTd75U5PZtKsD/9jwsIZGZAuP2A
         /RvVTAZagsrIkJ922ttm62X/koBDMNl0Wc8dXSFOxpRgyoh05R8PASy+d8ju/HWInywv
         HRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729068750; x=1729673550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g93+jT/AcpHh66whjFnNI262tYol3GRMYyQ7fABKQ1E=;
        b=mftpofWey+2xJgcgXxJZfm6AxyOM+mZae2vbOAcMHt1zaNUJMq+LwmwhnemiRtB/sk
         XOIQqK7ncG8bt0WcnqWrpu2BBQ1d1qE/cbgqG603XgZljbEPLcgjGw0p/APToFiaNf0r
         UOwzo5rkLDRVnFodfvAfJUc7Mg6qCnsdCo66kKrpae1eNKlz5JgunivB7eW+oLis2tyA
         TFYq9kYNUGHqVhYVulc2Uq/DOajR6+Q51nfLiOGVjq0YvflFt9Os3Qd2rOYE2ylLQRRp
         0XYCi4nIvjCtt0hQt+66hdzZ+4Ovoop5ObhovoSw6LX+gfi1XUz4x1ycpqCgNocsODVg
         of2w==
X-Forwarded-Encrypted: i=1; AJvYcCVD/IEGw5GXH5fRtUMcyUV5cjkXcr5YgsamkRr7ZiFw6Qi0gaLVPVf/0upnyrsUJeKu7/ThzgV/I5lKjzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlxkH+cQISh1vWZx2lWt7TE3Z9rwWcJcjeEWr4ZnkkXAGYkDxH
	lHeZxjMe9KWYLNrPArxACHTy7fv3cBfiY4TiPAlPkVSaC8fzv2QMP0B3n9N7Bt56xp1dv4H9xVr
	MlqPlQd9KnixBmsanX/XCiTPn/cOHZCFYAj+i
X-Google-Smtp-Source: AGHT+IGe4kv4L/EwUbCN/hDA83kADcD5XSTi2TLDBLcssrpynXzxO8MPXSc9nT4Dq1wix/vP8NV8PattQBIw+5GpyQI=
X-Received: by 2002:a05:6000:bd1:b0:37d:f4b:b6ab with SMTP id
 ffacd0b85a97d-37d5530a534mr11465247f8f.59.1729068749519; Wed, 16 Oct 2024
 01:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-8-fujita.tomonori@gmail.com> <CAH5fLgjk5koTwMOcdsnQjTVWQehjCDPoD2M3KboGZsxigKdMfA@mail.gmail.com>
In-Reply-To: <CAH5fLgjk5koTwMOcdsnQjTVWQehjCDPoD2M3KboGZsxigKdMfA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 16 Oct 2024 10:52:17 +0200
Message-ID: <CAH5fLgi0dN+hkTb0a29XWaGO1xsmyyJMAQyFJDH+geWZwsfAHw@mail.gmail.com>
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

On Wed, Oct 16, 2024 at 10:45=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On Wed, Oct 16, 2024 at 5:54=E2=80=AFAM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
> > +/// Polls periodically until a condition is met or a timeout is reache=
d.
> > +///
> > +/// `op` is called repeatedly until `cond` returns `true` or the timeo=
ut is
> > +///  reached. The return value of `op` is passed to `cond`.
> > +///
> > +/// `sleep_delta` is the duration to sleep between calls to `op`.
> > +/// If `sleep_delta` is less than one microsecond, the function will b=
usy-wait.
> > +///
> > +/// `timeout_delta` is the maximum time to wait for `cond` to return `=
true`.
> > +///
> > +/// This macro can only be used in a nonatomic context.
> > +#[macro_export]
> > +macro_rules! readx_poll_timeout {
> > +    ($op:expr, $cond:expr, $sleep_delta:expr, $timeout_delta:expr) =3D=
> {{
> > +        #[cfg(CONFIG_DEBUG_ATOMIC_SLEEP)]
> > +        if !$sleep_delta.is_zero() {
> > +            // SAFETY: FFI call.
> > +            unsafe {
> > +                $crate::bindings::__might_sleep(
> > +                    ::core::file!().as_ptr() as *const i8,
> > +                    ::core::line!() as i32,
> > +                )
> > +            }
> > +        }
>
> I wonder if we can use #[track_caller] and
> core::panic::Location::caller [1] to do this without having to use a
> macro? I don't know whether it would work, but if it does, that would
> be super cool.
>
> #[track_caller]
> fn might_sleep() {
>     let location =3D core::panic::Location::caller();
>     // SAFETY: FFI call.
>     unsafe {
>         $crate::bindings::__might_sleep(
>             location.file().as_char_ptr(),
>             location.line() as i32,
>         )
>     }
> }

Actually, this raises a problem ... core::panic::Location doesn't give
us a nul-terminated string, so we probably can't pass it to
`__might_sleep`. The thing is, `::core::file!()` doesn't give us a
nul-terminated string either, so this code is probably incorrect
as-is.

Alice

