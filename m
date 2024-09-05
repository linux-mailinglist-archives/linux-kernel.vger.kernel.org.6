Return-Path: <linux-kernel+bounces-316585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD59696D193
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49BD2B21B0E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1F6198A0C;
	Thu,  5 Sep 2024 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NiFipsIJ"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8121946A0
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523801; cv=none; b=Gma2oJcUfjKIhXHx37OZt2wskWRgE+4bafVqyqHxX/d9LmlJptyIU0XvzV7f+u0jQG5wz4W8xAoz7NkYFqZmkxt7n4mOhHr1FXFSlTAVrLldZ/e7jpyH9UKQrRNS97SRM6+kjfFDhaoF3pl0CafR7DVnlwDohHorktczSlwfuQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523801; c=relaxed/simple;
	bh=tySEusZ4FVsvRHMC8dzgnyRnOLSB1ruPGBu0iAoTrG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odqcFQsRUaxtdx1Em0foDutTvP10nZVsMz7Xz7ZflTciVaPjrBYpuXVKwgHOtX3mw9gnQH+hO8hRajqIyNv1dXzMylE/XUMR6152Mn8Eyj7ZmHCfZNAEcH++RSwqG1NtqfwR152FRVGKuKljXTSGIGPzii0uX+k6mHxR7LFcHXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NiFipsIJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374c7e64b60so240970f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725523798; x=1726128598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n/3Nx3QiIN/O2j0qCpOzIrPKFXDE9gLIjro9H442WQ=;
        b=NiFipsIJD+IQv0J7h0WoIgxlCxIabSIIJWGsfY3ummX+IzcDCJbwTSWdlSNgFaHEEQ
         T7wrLc27s6XMiF/UNAoQQ+BICzCehWTxqmeCaLklvP4t7NKRtwgyB/JAUW+Q4Ipuoz2O
         KqH55wQiR1X/tzSGCjduuSK1n+S3yaheLS7xY/DdFALYXmwR8+TJ2d56AKsiS6K6GsGn
         xeaN4m16ix8Mul0+1icYMyoqOE7lDjjI0N7DkDBtn7u3pbsmRkp0oOv1AfuZOTIG20m0
         POKi3WUwJrc/8WS4fbgt6Nn/f9niAAnVvrQP7xSt38LpD9u3bk4TjOL8/K9qlSvwWi+L
         Saaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523798; x=1726128598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6n/3Nx3QiIN/O2j0qCpOzIrPKFXDE9gLIjro9H442WQ=;
        b=SZhK0COsI7MQ3Kbc4iTjHo7f5ffuc/hwMpiDdzRbH7vXj52BtVpYKSZOGJN0S1mPLK
         ZIZRb0iHk1FnxZSgwGEGuV/P3/Slhq3wVPUGZoK6Be5yCLIuhrHXucE2j8762WYDNviu
         81r+jLrJ8b57QC0onOv1cRrc7TLi1VGsI7P16GkdaKotZTDu8ud1rClf+/9lOT6oESQ6
         PDkDLaHgUtnLPsVqqFJNdc5qdbFPy/IFIuECHrtSniFGPC2g0NlfcnUJ+W+ZTtH/tCjk
         EHHNIp7hwqHi7h1KIsjqyZjQkq9HT3Itry+g1lU5rLHNmLYh8kaMHUiS8kcZ/QRqw0YZ
         2SeA==
X-Forwarded-Encrypted: i=1; AJvYcCUrkL1ZAf0+HMKWSxvwAmm/HoYUdVHr4kn1NJ1kNVLSbI+Efd6f58gmeS8TeKojxIheGKqGsCtAnXq2YGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Kz7pVPG0Uf3imdc/NK5PaCt9aMSI51p13iroJL6QlMgmXKU/
	JdbbyO+xiQcsUf5O29A6U6hrGJSxLxFw/rBPTuN4J9MZfYe5iH30YLmKPYr8w12RQN/bs71XAyh
	HhRLo2SCNMTlEEflq0kdjwkWdMZpxOJp5lx++
X-Google-Smtp-Source: AGHT+IFD+VhaVe30caoIouMe2WUcx/xOWXVjE0LRfp5/b0qYljHoevwRDg/MOcmEHwV7hYCpWSrPr1zFvGm/2eAJAlE=
X-Received: by 2002:a05:6000:2c8:b0:374:ccb0:66c7 with SMTP id
 ffacd0b85a97d-374ecc8f350mr8137862f8f.16.1725523797494; Thu, 05 Sep 2024
 01:09:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-9-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-9-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Sep 2024 10:09:45 +0200
Message-ID: <CAH5fLgheU9ZSZzRF3RzG3AvW_h1E+UVb-PG9d3VnDUDjfLSoLQ@mail.gmail.com>
Subject: Re: [PATCH 08/19] rust: enable `rustdoc::unescaped_backticks` lint
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> In Rust 1.71.0, `rustdoc` added the `unescaped_backticks` lint, which
> detects what are typically typos in Markdown formatting regarding inline
> code [1], e.g. from the Rust standard library:
>
>     /// ... to `deref`/`deref_mut`` must ...
>
>     /// ... use [`from_mut`]`. Specifically, ...
>
> It does not seem to have almost any false positives, from the experience
> of enabling it in the Rust standard library [2], which will be checked
> starting with Rust 1.82.0. The maintainers also confirmed it is ready
> to be used.
>
> Thus enable it.
>
> Link: https://doc.rust-lang.org/rustdoc/lints.html#unescaped_backticks [1=
]
> Link: https://github.com/rust-lang/rust/pull/128307 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

