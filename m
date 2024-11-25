Return-Path: <linux-kernel+bounces-421309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C79499D89E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44957B3F50D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0C01B4122;
	Mon, 25 Nov 2024 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu7UO2hA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ADC17C61;
	Mon, 25 Nov 2024 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548927; cv=none; b=gFbiWa5e48VbbT1L0GA48KXhgPcWSoj9Ou5mO2mYg1ZT2FkccDkZolsxzGVpW4wpPFHakagepJaO790WVxuuU4zgk6L6AE6Lk6Y18NnKXHSN/jGT/1GLxvOen/+JnxKvpZM9PA8r2bsKHjToOppXr8q5ciAeF+Jy5Evg9j09ETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548927; c=relaxed/simple;
	bh=RO4UaaG86ysoQ5kt3jhvQ9LY+rvkNSghUUtEW4dO6Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWoVDN5I5fWbKfmAeloIxLz0OcWwkOql/xCTQS0DPoicCftGrZxHs/fyJJTT+NnUUJzrVGCfVSeHHpkdoVeWPDfAJ3nyJLJNfokCo4IfAbzt+kRK/dHWrPr2pOAStjicpaei1buyDmLSzn7z+/FAJvGbYFoNE25536CzNj0QgMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu7UO2hA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA39C4CED2;
	Mon, 25 Nov 2024 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548927;
	bh=RO4UaaG86ysoQ5kt3jhvQ9LY+rvkNSghUUtEW4dO6Uk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cu7UO2hAawAMgys63vgxFqvid8CGxnOBpeF5zqKD75ipm9RcCqYqmBDyA3y1yzWz2
	 uBza/TgQE2eqDF0awEJtm2AuvC062SXKc2Hf27ofhX2Qk8n1YtKi0foL0SKy3orWZ/
	 T8ad0EHHPc+O1t+HyuauUNW5PIw192wjZpKkraVyIOF6zDkgyNkeGC5VEs/WW0jfTD
	 zPF6tX3AnE3rJH4fLaNj/ti/2toHJjA53y2n3cV9qU0Yn9M0o//oeguMk4g9W3Lp5z
	 mSmCJ8OtACimP0Qugy7spgEXJIvB4vIOt0SKJPuuN4VvtGFLjbicfMa53rCD4EiiJM
	 x4bPJedrBpPug==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e34339d41bso39746607b3.0;
        Mon, 25 Nov 2024 07:35:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrlHJAkZbfcRJxkBYKEelQv7VKVZhZ3c3PRpF4hedI4UZoOMHn5kkozizFRjTRXFI60k8ItzeNtavXtSFf@vger.kernel.org, AJvYcCWIOrmm8CprTfM9BCbVi3i4bimtqzl62OdSeFQcf/izt7ZygJz1aSmWJpBktwveKV4vyYSmSBBX6NTmk0mLY0w=@vger.kernel.org, AJvYcCWeV+T9r2VqgtjBaYL28D8yDZkrkxgrSBaIgu94fQBcBKoVy9ZXvdcgs2br1ETrmWvRmRb4Oda1Cp+f@vger.kernel.org
X-Gm-Message-State: AOJu0YzHyUetUWWxMnJpsNoEBwztLqs0Vgk3WSO71aatw6cW6SIepx2U
	2fbYgIq1P+gRI22n7QXJ5AqP/Gw2LGSlBp6n+5aoOr5cGr3kCxesAxegKuUVjKT7Xjc6vo6uDoR
	kRGKr6ZgDOoqIlYsyxTLGCCOlBQ==
X-Google-Smtp-Source: AGHT+IG1igmpPYF9DcvPDDPoOxl+MozNJNta0jFl1JCIDe3nLaC6Vt7Jsy5B39O9iWSNcHNPGUQQ2POfxwG9o9AvSmU=
X-Received: by 2002:a05:6902:2b8f:b0:e28:f3e7:d92b with SMTP id
 3f1490d57ef6-e38f8b4eec1mr11115382276.24.1732548926321; Mon, 25 Nov 2024
 07:35:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122081257.1776925-1-dirk.behme@de.bosch.com>
In-Reply-To: <20241122081257.1776925-1-dirk.behme@de.bosch.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 25 Nov 2024 09:35:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ-cFq4jyFDnCWKy1b+7pNt8Tb11QF8vGoMb2G_4=dpBw@mail.gmail.com>
Message-ID: <CAL_JsqJ-cFq4jyFDnCWKy1b+7pNt8Tb11QF8vGoMb2G_4=dpBw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/1] rust: Add bindings for device properties
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 2:13=E2=80=AFAM Dirk Behme <dirk.behme@de.bosch.com=
> wrote:
>
> From: "Rob Herring (Arm)" <robh@kernel.org>
>
> The device property API is a firmware agnostic API for reading
> properties from firmware (DT/ACPI) devices nodes and swnodes.
>
> While the C API takes a pointer to a caller allocated variable/buffer,
> the rust API is designed to return a value and can be used in struct
> initialization. Rust generics are also utilized to support different
> sizes of properties (e.g. u8, u16, u32).
>
> To build and run the Examples as `rustdoc` tests the kernel Kconfig
> options `CONFIG_OF` and `CONFIG_OF_UNITTEST` need to be enabled
> additionally. Besides the default `rustdoc` test options
> `CONFIG_KUNIT` and `CONFIG_RUST_KERNEL_DOCTESTS`. This even works
> on non-ARM architectures as a test device tree is built into the
> kernel, then.
>
> The Integer trait is proposed by Alic Ryhl [1].
>
> Link: https://lore.kernel.org/rust-for-linux/CAH5fLgiXPZqKpWSSNdx-Ww-E9h2=
tOLcF3_8Y4C_JQ0eU8EMwFw@mail.gmail.com/ [1]
> Co-developed-by: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>
> This is an update of Rob's initial patch

I have my own updates on it based on the discussion. It's a bit
different because I've reworked the C API to better mesh with Rust
needs. I just haven't sent it out because I've been busy with other
things and it's the merge window.

You asked me if I was going to work on this and I did. If you want to
do it, just say so. I'm always happy for less work.

Rob

