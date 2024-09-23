Return-Path: <linux-kernel+bounces-335645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 484D097E87D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3401F21AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357B4194AF3;
	Mon, 23 Sep 2024 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNwNw13U"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF99188918
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083275; cv=none; b=q6YCgIy+YRicxpQUNSgNz3PsduuS3VaPueokAlO2YOwhbADNY1RyGEfIio6S4kkhL5ZPOVbfphuhpiFAZO0/h2i33iDGtKLYjtjFh46IjVub19xctkIiM8Df0jj5tYEypg3/rHoI/2XWrQCSrqpsfztrM/Cy/XBlafCJULTT9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083275; c=relaxed/simple;
	bh=LxBrHlISO2kuKwfwhNISskZakbzDD+oYAmZ0sQhWXSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bohqlZx00VFDnIISPxQCP0ASsYi/urDWyrHEwHDffB6L/DuQx6nKS/tbYKtS5wn+ugIRMPehy3caAFiz/rHe8INkHWZLyn7phWWilSIBTtXdsB2lRoJ+3RhtJw18+SYKMffpyoDd/c58VEyA+p/9yUVEWjloUkWyYXC5maaXRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mNwNw13U; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso36979715e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727083271; x=1727688071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxBrHlISO2kuKwfwhNISskZakbzDD+oYAmZ0sQhWXSk=;
        b=mNwNw13Ug5Wp6+t/7QPVFfm8Q30+to8CA5bW8ZcotTkYb2ViF+QVRwzay3UWpPcl60
         Q0Roitjfh6EQuLLO3CK+TYtziI0FMZ2VtgTPOXUyixcaAepkTD6gBATFG5fgwhHgKZOV
         7RBGT/aevVSq1r0/lFdgWPj3r4HqQ6R98JyvHKoP8GzHrR7lNX/hsq81waNy2aYnOY7j
         RKI4vg+hqRspf6jkZY8xNV2Ri72pwsZcFQp0GyeIzeHNOLdnwx2MiKbGO3mhP4ogYG/2
         oVn+SvXIoZYbie/Fgyb6ZANalMakaS29ph+JYMtSKnDLWTrAJGQVmjq/wcQ8nRsmC13S
         xmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727083271; x=1727688071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxBrHlISO2kuKwfwhNISskZakbzDD+oYAmZ0sQhWXSk=;
        b=VScXN4s2M2KcYJ+ap6ff7veW9k5IATtsVNhz9vK6q3cIpw18MdnFv0dzW6tUlmixBg
         4t+6ezvTdgdRP0+GPfsrrLEH4Jw9gpLl5+hHMGkZ0fSs8djyrOb54wXwvFRq0OcqTq1W
         fT0wy5QW7ptcvrxMAfqudQCg5mD7jGJdRJw3iRVr/bpxK2N2+50PHEcqLtAHsHaIIR4+
         VpJBOdytnIawEKxjSWCKDsBMH6fLv3SMWGR13EcskDO3B7hLnaUPpvb6cLYWsBDTDICN
         9si3/+H2fziXrHFWPOOn6NJzvyb21AZ4kn4tZUFrmlHJDo33mlZ9eTkSvdGWa0txehmp
         T0GA==
X-Forwarded-Encrypted: i=1; AJvYcCW3ygJktEH9ps0ABiN5uuuUEtmNRF3MUwi6WKEGgYsUxKu3XAQbe2g3S8Lql3opu9cSG0PjtPtoAfsU7wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAZDIIpUsx4j227dnnrRyLa00+sqDC1QzMeKZRcCgSXleWRAV0
	cwZUf4QNa9qlEL3mjcYqB6czirv2omWJmT2D0oiuYJ3s5ClYpJqq6M2hAaA06v0Q2MWjNX8S4RT
	lxnfyI8Av1JOB6Rt2PLsQwmk54uprtpIuV9HR
X-Google-Smtp-Source: AGHT+IGh2uBO6Az6rd0NWhkmsH/KJ87sqR0Cr2RIfdO607udILgzlAHK22VzSdBn8SUe6CW8/XLjmFFf2HRoND8uD6o=
X-Received: by 2002:a05:600c:6b18:b0:42c:cd7c:a196 with SMTP id
 5b1f17b1804b1-42e7d5c8614mr87512705e9.17.1727083270926; Mon, 23 Sep 2024
 02:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913213041.395655-1-gary@garyguo.net> <20240913213041.395655-3-gary@garyguo.net>
In-Reply-To: <20240913213041.395655-3-gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 23 Sep 2024 11:20:59 +0200
Message-ID: <CAH5fLggVa-qOtZuB7XHtW-BfhWqjFD9qTt7_U6aajzK2Xo4BPg@mail.gmail.com>
Subject: Re: [PATCH 2/5] rust: map `__kernel_size_t` and friends also to usize/isize
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, Finn Behrens <me@kloenk.dev>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 11:32=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Currently bindgen has special logic to recognise `size_t` and `ssize_t`
> and map them to Rust `usize` and `isize`. Similarly, `ptrdiff_t` is
> mapped to `isize`.
>
> However this falls short for `__kernel_size_t`, `__kernel_ssize_t` and
> `__kernel_ptrdiff_t`. To ensure that they are mapped to usize/isize
> rather than 32/64 integers depending on platform, blocklist them in
> bindgen parameters and manually provide their definition.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

