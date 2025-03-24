Return-Path: <linux-kernel+bounces-574173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A68A6E17A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2BB1714EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6438B265CD9;
	Mon, 24 Mar 2025 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjXJ4MZB"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF95265CB7;
	Mon, 24 Mar 2025 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837824; cv=none; b=HxeD0f9fA+0EyztZDX3We5ycj5r/HGgnfjH7C/xuyxlwmofzCJxw1JGC16oYAwUQXch3FesoSRNE0R7LADoddw/8+SphXrpwwWq5tFrKuxiAo96e3emp0ZR6eitllPMeaLeqcLSDdYq4kLgmQEF74kdO8P0gkEft+FOQt4B73TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837824; c=relaxed/simple;
	bh=d9iNtNazP1RDoTpmr0lxnjvelUtrku/ls3fouKhWZXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYYtD7WPbb2L+t3pUybBqxcY1YH/lQK108qCMkG+iMsUkZEfif5j5jFd74O47eeL7gUZPTbaf3Q5KXswPE7G/Grdd9u3FIgUPvbN34642Dpao9tnuOT623NPaDmPvt7SxPuZlaPI5/evYuEh7SZULswb4scunHb+sqp40EdXEv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjXJ4MZB; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-301a8b7398cso1310614a91.1;
        Mon, 24 Mar 2025 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742837822; x=1743442622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69JJjcOX5eDVKLskijk4B2SQOSJ22teSjVBu6vFOVp8=;
        b=TjXJ4MZBd9nmqEyBERZy/3I37bINnAMAbzwi/xudsA5/Pndd8enbHp4HD7ZusBvsnT
         2uBk4JWAUXDcZ+MOY8FI3CDYwEmnoA+apgwKsbK1wh9un9d5uaP1inPijkCCXB/cu+Db
         mRMRSJlGdc0FD+RIWRoSaoitOaNPL4qVD9kcNveqvYeqULE5ycEFPo6OMTz57+Z3tbYs
         rL1Hi2MPtiCnv1zf0oZk9+yFRJzoz9rc5fI7q9a+PX/eYdZgtf4wAfPjwW6BZvDE0UjP
         5Ejs3ua4AYwdkaMYHQNZbbMZ4H8XDcsphnj4yGbCoaOZlyuFoYyEHiKwmKpAEaUhjtVH
         2uwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837822; x=1743442622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69JJjcOX5eDVKLskijk4B2SQOSJ22teSjVBu6vFOVp8=;
        b=e5C81uNtmhQJ+TW2mL0DG6Hbn5OcZ7e4oi7jmi1lvcx3AbqsI0kYYxdruhYsnypVAN
         ATwdPB6iLkLfXRSiCI7iSH7mmysEhrsamtqRQml3HDRY0byNWXFbHVGVfqD86bU9u1A2
         OXVuni7+4Fq1C2hgHhhEsibPHWjUziTjmzG5TTa+BcXdsHek4QieZ1h/qjgAKi59gKO5
         GDggMLHH3AwTEtPA5rMd2WGZL2vEZFMBl52FILsiaeUyMWxmYO6EdC0W52zRSyJDU/8Q
         zyhpalPjlak+ufKQAVocNo866+UVaDrHooj00QKu49wGXdgd9BauZuqfhmFSOW5CcjjS
         lgew==
X-Forwarded-Encrypted: i=1; AJvYcCUNRbx8tob4cOFGZeBQ9qPZMH28z4wppWOrJax6Og5gksFz1n299NhNNte06JD56O1cJZm3bPROLwA1vtUcpVY=@vger.kernel.org, AJvYcCUcXCmnIC0HoG7gGt9quLQhvucH/3nG66h0dFNXluTmp9ZblA0SRlr7Zpw8Hn3YIJoRfFM6rwAdv7v/0zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhMGAwOUkHYAZHdNhj/duPqAwrdhvA6RGf109fvkJKj1H4GpjX
	tXx/Ikey0i5uORiFyRnvsPdEle8t8ju+VXBKBas3fABZEgF9yckrTt9u1B5eQB+DaKHinauoS/t
	OwzxNgM2Pztx+QSnG+RzywCJ5RBI=
X-Gm-Gg: ASbGncsWPmKlC5JGLmwVQWbEDOGVXpmbVnzED0I0dEbSulu9QDDxlreQ9AwOkBR38W0
	2kgo1I6ZHMSEQN6Kg+JIQwcacqc2muFYXPpCDZedpIez27N6ax9CSvOmjRgsFkQJahgoCbgmSnL
	tt0WacwilrDjbBgq19NIUD5osrlQ==
X-Google-Smtp-Source: AGHT+IFUfJRzqAlcwqRGIR42C+MQ4CQtkFiLwS/ECZRB5538auZlyErsfsZGQdT1VlP88qOFuiR1vK3EzFkLShjtobw=
X-Received: by 2002:a17:90b:1d91:b0:2ff:78dd:2875 with SMTP id
 98e67ed59e1d1-3030fefb123mr8424394a91.5.1742837822154; Mon, 24 Mar 2025
 10:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-gpuvm-v1-0-7f8213eebb56@collabora.com> <20250324-gpuvm-v1-2-7f8213eebb56@collabora.com>
In-Reply-To: <20250324-gpuvm-v1-2-7f8213eebb56@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Mar 2025 18:36:49 +0100
X-Gm-Features: AQ5f1JqKEQjEOH0hQER9UoxLXyyw9kL-VoZN7He3uxMUqnP5eeVyZ20eChjJehw
Message-ID: <CANiq72mQ3zuYmsq1PD-49kKLNji8OJwuvxK5QWkNaBMuC-PHQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: drm: Add GPUVM abstraction
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Asahi Lina <lina@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

A few quick notes for future versions on style/docs to try to keep
things consistent upstream -- not an actual review.

On Mon, Mar 24, 2025 at 4:14=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> +#[allow(type_alias_bounds)]

The documentation says this is highly discouraged -- it may be good to
mention why it is OK in this instance in a comment or similar.

Also, could this be `expect`? (e.g. if it triggers in all compiler
versions we support)

> +// A convenience type for the driver's GEM object.

Should this be a `///` comment, i.e. docs?

> +/// Trait that must be implemented by DRM drivers to represent a DRM Gpu=
Vm (a GPU address space).

(Throughout the file) Markdown in documentation, e.g. `GpuVm`.

(Throughout the file) Intra-doc links where they work, e.g. [`GpuVm`]
(assuming it works this one).

> +        // - Ok(()) is always returned.

(Throughout the file) Markdown in normal comments too.

> +/// A transparent wrapper over `drm_gpuva_op_map`.

(Throughout the file) A link to C definitions is always nice if there
is a good one, e.g.

    [`drm_gpuva_op_map`]:
https://docs.kernel.org/gpu/drm-mm.html#c.drm_gpuva_op_map

Ideally we will eventually have a better way to link these
automatically, but for the time being, this helps (and later we can do
a replace easier).

> +/// `None`.
> +
> +/// Note: the reason for a dedicated remap operation, rather than arbitr=
ary

Missing `///` (?).

> +#[repr(C)]
> +#[pin_data]
> +/// A GPU VA range.
> +///
> +/// Drivers can use `inner` to store additional data.

(Throughout the file) We typically place attributes go below the
documentation -- or is there a reason to do it like this?

We had cases with e.g. Clippy bugs regarding safety comments that
could be workarounded with "attribute movement", but it does not seem
to be the case here.

> +        if p.is_null() {
> +            Err(ENOMEM)

For error cases, we typically try to do early returns instead.

> +    /// Iterates the given range of the GPU VA space. It utilizes
> +    /// [`DriverGpuVm`] to call back into the driver providing the split=
 and
> +    /// merge steps.

This title (and the next one) may be a bit too long (or not -- please
check in the rendered docs), i.e. the first paragraph is the "title",
which is used differently in the rendered docs. If there is a way to
have a shorter title that still differentiates between the two
methods, that would be nice.

> +    /// # Arguments
> +    ///
> +    /// - `ctx`: A driver-specific context.
> +    /// - `req_obj`: The GEM object to map.
> +    /// - `req_addr`: The start address of the new mapping.
> +    /// - `req_range`: The range of the mapping.
> +    /// - `req_offset`: The offset into the GEM object.

Normally we try to avoid this kind of sections and instead reference
the arguments from the text (e.g. "...the range of the mapping
(`req_range`)...") -- but if there is no good way to do it, then it is
OK.

> +// SAFETY: All our trait methods take locks

(Throughout the file) Period at the end.

Thanks!

Cheers,
Miguel

