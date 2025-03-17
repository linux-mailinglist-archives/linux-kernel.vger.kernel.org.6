Return-Path: <linux-kernel+bounces-563957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39408A64AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8992B174800
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A22E233127;
	Mon, 17 Mar 2025 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eW4txa4L"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224AA225A22
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208620; cv=none; b=h//YK3pa9fK0yJ26XRbDsF2i/P1a8M4lmpWjWst3O5MK7JLSEMxp7TDnH0YvZflIsA4lMAxka1H/OD3/SfEl0Yq4ayLkBmHlJM14Bq0wwU4V93IfY9NxMH4YeHmgD0QJe9zA7zGVvKrBk78HwKGKIRimnoyzr9JN9ivNr2YXPaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208620; c=relaxed/simple;
	bh=apPmjzBp15h6BuYlIx9rExk+T2+yeZP997KXyoYkzB8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QY0aMDXYs48XNGQcspfDoDgsr/ZDZiS1K0wLHox6LB6/nZJqzDKX5B8vIdwehUslLuLVakruBMDF55rRDCRdJuhG4PsYHU04hPzxXFxZv7sgwAlJwmFvp60/ww/lZF7qSMrvQ492lZVcmr5FxnpBAy7TCHW2TPfuhxh0bHKlmCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eW4txa4L; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4394c747c72so9338905e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742208617; x=1742813417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Up6B4MdDWj2/kfMDXbKASX6Gb+BsCApF2SDLkxZErAU=;
        b=eW4txa4L/DFmFPOhbq4NDINaMtF6ioqDelHNV792lyzp1BDzxFEEn7VrTZHLwRP3HU
         7w+Q6+ydGfhJTSDShFwYnkCqFoY99LQASx0Nr5hXAXav1PafsYX9LsnhH8Lw5TTOPvwi
         K+JfZMHWDzVi/dQxscRrhZZOSuObhZHTIcsXdS5UMjR+l8V8QXXH0pzw7uC0O2ZlNR9W
         9fP04x+xdXssO0JaDBlb29LIvo5Bi6Gtzo+2zrG8ZfnE2E44UnAZp0OgzDbL8chSnocX
         l8b/FG05DClaRFLbAs/Ifi35Hbc+Q76aK1DtytAi9lkev8Y50cQbChEL8+F+TkbS9sw/
         GP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208617; x=1742813417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Up6B4MdDWj2/kfMDXbKASX6Gb+BsCApF2SDLkxZErAU=;
        b=ds8IH1C4IYuRrrOmvcF+1XvprSTbDaZcm8NoofQhK+OPOMOPAg6IE9AfnVgmg7oo9k
         FcfsXF4Omm4uzOpbUMUeZt0aKjwO9IIJfBMZgqpy2W3sVhuG0n6mH+7K2Cz4EWj4k0hF
         tZ3H1fsDZildvfiIPzHD4wKnkKb7f+u2pwJ16mwewjofFzUHb89GtbVJIZLnSjktNkIv
         Mi8nZWAlDxBjSKFZZ/8SoUMdOKfYZH63Aj4jLT/Rt/K8oEncgQyYKXESd7jJUFifCMWR
         c+MYrOoLmAMEMBT2ObuvszPVOCzaG4SG8GO0AiQnbbRqt3Dgkt7tGSVVGD1R8mNVLK8s
         kHZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCgMlapMwmb5Q2QdfwBaEUJgHepLFe3EjB8BqG7m1bfyThQLrNvK5+f+H0/RwJlugi+gHy4Y5ajAJqquE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZn1fuWJ9JL3GpXSxl+C507P4zAuYBNi0DDnii0+GZLJrnL5zk
	2bMGlBFUHHU1KJ9esIkw4WAuhMOSLOJfeLxX7qR07jEY14D4WLUOUc0MPfb2b/c5v6l1cA9TajF
	8RqxiYJ3RSWjSYA==
X-Google-Smtp-Source: AGHT+IF6IFyAlhN/n6Py4z3zsZpntW/Ns0z5jtqY9dqdYnp9Rx4qA7n2aFjUa1uf7DGmwKc656C0SK+M4oDPlBk=
X-Received: from wmqd2.prod.google.com ([2002:a05:600c:34c2:b0:43c:f6c0:3375])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c86:b0:43c:fa0e:4713 with SMTP id 5b1f17b1804b1-43d1ec66826mr115790365e9.2.1742208617612;
 Mon, 17 Mar 2025 03:50:17 -0700 (PDT)
Date: Mon, 17 Mar 2025 10:50:15 +0000
In-Reply-To: <20250316-vec-set-len-v1-1-60f98a28723f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com> <20250316-vec-set-len-v1-1-60f98a28723f@gmail.com>
Message-ID: <Z9f-Z15bSh8MA1wJ@google.com>
Subject: Re: [PATCH 1/2] rust: alloc: replace `Vec::set_len` with `inc_len`
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Mar 16, 2025 at 06:32:00PM -0400, Tamir Duberstein wrote:
> Rename `set_len` to `inc_len` and simplify its safety contract.

You're missing a Signed-off-by tag.

>  rust/kernel/alloc/kvec.rs | 19 +++++++++----------
>  rust/kernel/str.rs        |  2 +-
>  rust/kernel/uaccess.rs    |  2 +-
>  3 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index ae9d072741ce..d43a1d609434 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -183,17 +183,16 @@ pub fn len(&self) -> usize {
>          self.len
>      }
>  
> -    /// Forcefully sets `self.len` to `new_len`.
> +    /// Increments `self.len` by `additional`.
>      ///
>      /// # Safety
>      ///
> -    /// - `new_len` must be less than or equal to [`Self::capacity`].
> -    /// - If `new_len` is greater than `self.len`, all elements within the interval
> -    ///   [`self.len`,`new_len`) must be initialized.
> +    /// - `self.len + additional` must be less than or equal to [`Self::capacity`].
> +    /// - All elements within the interval [`self.len`,`self.len + additional`) must be initialized.
>      #[inline]
> -    pub unsafe fn set_len(&mut self, new_len: usize) {
> -        debug_assert!(new_len <= self.capacity());
> -        self.len = new_len;
> +    pub unsafe fn inc_len(&mut self, additional: usize) {
> +        debug_assert!(self.len() + additional <= self.capacity());
> +        self.len += additional;

I guess we could use an INVARIANT: comment here.

Alice

