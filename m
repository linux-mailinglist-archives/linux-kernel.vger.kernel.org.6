Return-Path: <linux-kernel+bounces-304697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B312D9623A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA68281F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11298169AC5;
	Wed, 28 Aug 2024 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaiN0Cd8"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A01161901;
	Wed, 28 Aug 2024 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837879; cv=none; b=eRPfTVCZ8XptPQRkO7tX+DB35GxTOLWXiDrCXvIQMh84z+xwyvLKmbNliHSKyBSOm4xIeIDPzkXqdqOiBrXwTCkc5oYlfSelb8izdTJemT59RTHjTRzbPPVd+I0KJjOp4gD+YPaqANkjjTo+xGxSSK1Z0ZDvwq1h3v/6Mw93EyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837879; c=relaxed/simple;
	bh=FrPNVe6vV0PD6DzTPdsLu6eL0AIVsqdr+LIcQQhA0Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBWmiY3lIOyN5mEHnGLOh6tI8r8jOWVK4kNR7hpgte5oKSPNFCH+xTALMLdDEnPSQPQRs0LKlrF7GFUlghi3Um3qM0kGyNdkioaks3K8PQ3gg/pYCMCMUo+fBiPWGC3L7vPiZMYbYpEQP33oQNqJf45J0ogC5d1DBvg+9PAWn1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaiN0Cd8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d42c59df79so1205967a91.1;
        Wed, 28 Aug 2024 02:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724837877; x=1725442677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Fs9j294+O1jjH4pbcsVDPgWnkTmMJtYpoqY1Ck1hV0=;
        b=UaiN0Cd8b+JAS/MaPk6FLdYR2FoGfcOJlmmckcOyW37P9wMfq9F1Kea9idmNZrJ+Cv
         gRhZqGcsxp/5fOrS7AlZIH5y7KFkj5o/oep9btPZudPTSEPfC/+W2rPr/VUEiOvjZnTA
         bso4aaHpD1ExEuNSz5B9YqUyhTiCO/SY2XJzJSIM+Bi4xOoElXDn144rm6SsFS6037Uq
         NPj5bO9paQ3Uaz3wYDVshE2tgY276wd+fLj8DOmcWABUG11yE2zPkdidgTHPesPxd8Ik
         7y2DYAW9GpDsPRFoUieh6hdu2aFg8ceCgSuAJws7k1NqcNSojNttu/mmzxBdpqY7ojkM
         kAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724837877; x=1725442677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Fs9j294+O1jjH4pbcsVDPgWnkTmMJtYpoqY1Ck1hV0=;
        b=sJiuQcCjdycTB1uGg+TbTieFK6n+vfBNIuiumxYjLBH64A29alO7j5nbaSYgSAcsJr
         bhhLLmeqXciNFxvnQcCC1ETuS/o+V/0QBXndhm0Ao6qXXoNvhuk/liyd1oSkVT047F5C
         efftSSqyTp89tYpEmwmNqXU8QUkgWOO8IDibxFy0kvMjjHqWTVifGvte6U1Y8/XM/YeI
         vL01PuVAU17KhzL1+WsHSwakkmTEx3SuI6mmZkjBnc0qbsdHjap8dFLkBaOFISIIlHnD
         IlUOtJ80R2HgFk3IiOFpH+b47xgGDfVLfaJevsNBbRP5WOwKW5XGmi/MK1fBgR1VnzPb
         UfSg==
X-Forwarded-Encrypted: i=1; AJvYcCUAfiXcrDIOhDujuKEwy7sZS3sv2KARSz89XfrSrlyvnCHQP4K5XxsFhw9kCcaqZfWPQZKC/6neHsYqMI69imk=@vger.kernel.org, AJvYcCUL73u9H5i/6q9sQXyxu5GDGKOIVaUVifqVugeP11tcofBQY+Md3chGiLj/C+rHSSYpVZDJs7SKWeQ7uXaI@vger.kernel.org, AJvYcCWxFrrX4t++tIbzhQaAR7NMsRLkOMscJnBjFQhTf46CAz5nAAFWzW+PR7FkqJOZAtuWyzKBRgsg1ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIsxkp5DDf0GVdVbXqXY4ZqeGzUr2ZBF5dvnUkHd8/ndv5YL/a
	kzT4TjMzh6VCAWl3kdH1PbSZvq4ai5xGPgMsNmLwNQYR9VQ+81lWak2E9KMlvKK/sIA1jfF1N5J
	ZO73Pw0MLtzgyEj3lqEhP+Qt+KwE=
X-Google-Smtp-Source: AGHT+IGgBqKI/V3LF34hltV36DNPloiJpYu3y6SSvWCYVzSiwEZN8x14POkJPVQX2rNgIO/x9TnBUvVwjJcZ0lrE/Q0=
X-Received: by 2002:a17:90b:1d8b:b0:2cd:8fcd:8474 with SMTP id
 98e67ed59e1d1-2d646d92b1emr10897621a91.5.1724837877391; Wed, 28 Aug 2024
 02:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826-pr-docs-rust-remove-quickstart-blockquote-v1-1-c51317d8d71a@gmail.com>
In-Reply-To: <20240826-pr-docs-rust-remove-quickstart-blockquote-v1-1-c51317d8d71a@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 28 Aug 2024 11:37:45 +0200
Message-ID: <CANiq72kj4aVPvt0zm4og9TkZMb6KF303gAf__1R=fo7QtOXUjA@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: fix formatting of Hacking quick-start list
To: Jon Mulder <jon.e.mulder@gmail.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 11:11=E2=80=AFPM Jon Mulder <jon.e.mulder@gmail.com=
> wrote:
>
> Patch to remove indentation within the "hacking" section of the Rust
> quick-start guide. This removes a `<blockquote>` HTML element from the
> rendered documentation.
>
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1103
> Signed-off-by: Jon Mulder <jon.e.mulder@gmail.com>

Applied to `rust-fixes` -- thanks!

    [ Added Fixes tag, reworded slightly and matched title to a previous,
      similar commit. - Miguel ]

Cheers,
Miguel

