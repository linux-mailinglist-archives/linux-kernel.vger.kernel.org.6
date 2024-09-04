Return-Path: <linux-kernel+bounces-315983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0401496C975
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A321F248D7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2A114F121;
	Wed,  4 Sep 2024 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dax5en7+"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5DC38DD1;
	Wed,  4 Sep 2024 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484600; cv=none; b=sFDUZYY0xgAihBU8+UmzfCiqSMcW4EmFp8yZe+Xxnem/WSKoUp8J0bSsaCkaHl7+MoyonxDIS/1k0W7cvWwJVRlcEfitVyKFvK9e5cbHoUBtEZgaaHfCoc058i6b3wQIjJL0O8yl+3kXG++DmCIz9Le+byF3BK8n7x7cH5TDV9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484600; c=relaxed/simple;
	bh=z/1GcMiLGE2rHSFEqhZvLGeKhghzMwgRmPxqcTBrj1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cI49bu8gevfgaHhxwKYTWmqJsy4uFkT7nwIzOafxP8uhrwhn3p+4+X89QEW0Ui3DIhO/cQZq39nI32HbNcVhKJSMz84hKW/TmjyW0NQ6oJxwhxyVqn+cH6NxMGwI2kKFvjLsT0tlHgV8P0/CSJSqZQw42lZ/fhWpKQfs6e9KjXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dax5en7+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71446767885so3568b3a.1;
        Wed, 04 Sep 2024 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725484597; x=1726089397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/1GcMiLGE2rHSFEqhZvLGeKhghzMwgRmPxqcTBrj1g=;
        b=dax5en7+vGdHYZk0Q1hcLRgHZgtenOJvJdR0izjD8xwbqq4x0sElMmRe+s2vB3dhcz
         pVF4lIZiIMjzva6hFqIyYwq64kwbf3LEEMK1B+6eTDiCMo31VmIwxFqqBBjadRcgiowM
         ota6rYkFwPBVbL4Rw3gWAwRIIGcgKyT4Q3Z3TpD+DSmK4z31oREfnLjneBEDihpmyZRY
         44tOtd1esmE5s8LuwoonRITOHzVl4Pp7kpknH/Bi7uVp+bm4TmuNFDfSJ2GpC7cfKt6/
         z9Ca36r2X90Nq+3J171HDOPbPlvOk9siLNLJhH7QuL2mXfxsZwTiZ6u47/2S50joAKQQ
         N4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725484597; x=1726089397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/1GcMiLGE2rHSFEqhZvLGeKhghzMwgRmPxqcTBrj1g=;
        b=ZIL/792E6wmbrbfrefXZdjT0gij0BzoYa/kdeJ60dVFYt8Ufn0Wtd/nFuSe/rgFWAL
         6kN0PKGWZN0kXGdUpiCE0Djwr5/tqbDNAQh7uaDkexsxaOaGJDEP+92QIxZ5Tni7FKbW
         5/BfOx9Gl2+59NEtiokH3kCqAlrRcFgzWBvLDNzCWEgeglk+Qzrl7+GE2asH4xt/UVOX
         VvKEs7/qaG9VAzy96iMA6aR+5qs/rHAEVslmn9iFZJ1Rw1zqOasrQOgeKYxoE7KTlVFg
         9tBXXWgaPIaFj+7G3HXU4k9R0TBXi843NHnOGaHI/kazMO3nkjVCjdomzQcmhK+nCr7v
         0exw==
X-Forwarded-Encrypted: i=1; AJvYcCUnIUl7hTji4ehlNcu8Be4BWyE8Ly/GthgKrad5G21L7sT12B+AKbBzG+/xHPjdlO/mFcpT5zcV7v7ShfE=@vger.kernel.org, AJvYcCV5oBF+uQ3cVHgvmyJWhOSPsAXylEPDW5RTe7PW/Hf+NOYBsnGy7Zp46ZJViQSu+6qpmDtaEu8llqTz2hlZinw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEVOZWKu7+Zb1HN4hnt7qkRoUxb7iNfLmVuUTknfhW1YoQILo5
	O0VO7k4jLxgZOhSAeRk8AF20EiAHJx6BUFeOh5uA+bEd0IVJhK7jlBhovB+pTD6mwENwBuT/RiV
	83BaxvUE/DhJ9C9fWpSHTpXJzaGDHuzf7fYkXfg==
X-Google-Smtp-Source: AGHT+IECOjX6+cc3J5pmZJ7COQWLiR4DxSa2AEtFoWMmYTEsU/aqmrfc/2G96Po35zcWza7gSUJgGY59zigAkoOgxo8=
X-Received: by 2002:a05:6a21:328d:b0:1c3:b106:d293 with SMTP id
 adf61e73a8af0-1ccee3cc4femr12176334637.3.1725484597426; Wed, 04 Sep 2024
 14:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904144229.18592-1-ojeda@kernel.org>
In-Reply-To: <20240904144229.18592-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 4 Sep 2024 23:16:24 +0200
Message-ID: <CANiq72k3Fs6Cj7mnhQaNdS4bAWjsvg_=0+EcH_hUhX97BMwUjw@mail.gmail.com>
Subject: Re: [PATCH] rust: avoid `box_uninit_write` feature
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Matt Gilbride <mattgilbride@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:43=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Like commit 0903b9e2a46c ("rust: alloc: eschew
> `Box<MaybeUninit<T>>::write`"), but for the new `rbtree` and `alloc` code=
.
>
> That is, `feature(new_uninit)` [1] got partially stabilized [2]
> for Rust 1.82.0 (expected to be released on 2024-10-17), but it
> did not include `Box<MaybeUninit<T>>::write`, which got split into
> `feature(box_uninit_write)` [3].
>
> To avoid relying on a new unstable feature, rewrite the `write` +
> `assume_init` pair manually.
>
> Link: https://github.com/rust-lang/rust/issues/63291 [1]
> Link: https://github.com/rust-lang/rust/pull/129401 [2]
> Link: https://github.com/rust-lang/rust/issues/129397 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks Alice and Matt for the quick reviews!

Cheers,
Miguel

