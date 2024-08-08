Return-Path: <linux-kernel+bounces-279692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC72C94C08F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679FD285585
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C3418F2C0;
	Thu,  8 Aug 2024 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B49yBpcr"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D462D4A33;
	Thu,  8 Aug 2024 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129686; cv=none; b=g9rbm3oL9Ak7zbCdP7HwEKlRzZjlvcl22vHufZYWv3XG71ygEO1pQL1KIcGTsDH97MmKMPnObMkzF409i5a3vAZ6xlAMHhyEpMhsk0K44b7IH+7sjAwdHup5MtnTbHp/ojNCQenD7FFbvkN+oTKWLdupyv5abpK2pwnkpcnd1mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129686; c=relaxed/simple;
	bh=mMf/r/w4DzuOC9KV0Qrw+cXuVcK9blVquF0Rk4Wb44s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7e+yCgwwKB9bqXc8A86T3DYcCQmcwpE+NZxUqdCR+zawAgr3LmFqbyeXO8vHUk0HVqb3xX6JWCtYoGirPCanzd2PaFe0IELBg30xccVkUJMENrqsdrPXrbZd2VtbvoAmEWSnkSajMxpfGUDYKLqtwuEFTFLEDbgjCiN4fGvbUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B49yBpcr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cf78366187so878897a91.3;
        Thu, 08 Aug 2024 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723129684; x=1723734484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMf/r/w4DzuOC9KV0Qrw+cXuVcK9blVquF0Rk4Wb44s=;
        b=B49yBpcrGzEHlehtUXhorSpElK4ABh/+J3errss5bBbzd6TIjdocSoY/LP3xpMjH4z
         KLH5qX7pWJRzpBoPNwX/v8wdrUybtfTRgrN84if5imhZORWrTBvgLSlurn+Qjdmqba8h
         bTgYXPU8irhGyJ9Fhgx2y8icU3Dnc1j/2WKJ8K0Rsp6cN8S69L2XOwbJ/GxeIbqx1BcY
         xu0XEmbiUF4zHSlXFyIEMKjY2lSzcqSPADpmfqrwEZVsfVwzpy4E6phMlnmdAqgdiR7y
         RmlJg7PRgT5StROeea1jaL4pvGyXc14r69zhSQqa9CDWgftEhYZ4B8UjUQfLeBTj5k+H
         t9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723129684; x=1723734484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMf/r/w4DzuOC9KV0Qrw+cXuVcK9blVquF0Rk4Wb44s=;
        b=qx8QdRHN0kvZfTWhdO0xsLEn/WGWOn2A7wB0BkQG1bhsck63vLxPr5EMTJL9DWauLg
         vlDSfWWWAXU9fd7z/BDapMIfu7PnsIKPRSU8t7JwYBJq9/7f7fdiK0SK0/IoQhn6YFUX
         VvBQ6MVRdS/Cs4EqGtD859vMr+uHbrUjW21rByAe8IBRs1iXsIHukU4L9GDqgjwZcbcL
         pObmyxwFlFW8YR3snfvrOht8xy3OA97mBMtbQ/7PQ9k9FmdVIhtV0bU4C+xjfhPiOLN6
         tGshhozGSUKfJJ+KiS7zmwQFgqHFL9PdNo8bAJKF04dHps2cZcgBWIApSlGR/L9AzLy6
         LGlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUxHI5aTO3QRCgxEHLGBoYgRmf5ggDhKsOb4v2StLn9FnyN/XoTiqbeYCq580g6ql8jmhI1WxO7wYyiaozPkjHgTuuixdLcx9hh29bWsk2ZF8FctW3o0Hx8KLwTnGGOv7yO36jQOqFmc9eacg=
X-Gm-Message-State: AOJu0YylksR0Qz9Hr2zKy1Hi2/8POlp3aIHNUtZh+OjAHzR27hRl5yqK
	aTZeuGIDRmBM9kiSoQqg0x7LLgDkmJxy3vlRT2ksZvU8w6g7K+JseOU5QMRKzt2bUbd8bxHRpk9
	TCZDv7x9T+mnsk6b94tg6gP2ZZO0=
X-Google-Smtp-Source: AGHT+IH608F1d9487XRhV9631qqF/0rEQTdfCWf0KCSugE+PaHzrIoGqNfYkBYPKJJwhtols9tsoTJLOVsrvwS0bBLQ=
X-Received: by 2002:a17:90b:4ac9:b0:2cb:55f9:b7c5 with SMTP id
 98e67ed59e1d1-2d1c3397088mr2638037a91.12.1723129684048; Thu, 08 Aug 2024
 08:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134346.10630-1-zehuixu@whu.edu.cn> <20240807115708.394a8eb3@eugeo>
In-Reply-To: <20240807115708.394a8eb3@eugeo>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 8 Aug 2024 17:07:51 +0200
Message-ID: <CANiq72=UeYXi35PNTAtHd5UGt4rgyMjpfLbG3xYxpdcvY3mZYQ@mail.gmail.com>
Subject: Re: [PATCH v3] rust: Kbuild: Skip -fmin-function-alignment in bindgen flags
To: Gary Guo <gary@garyguo.net>
Cc: Zehui Xu <zehuixu@whu.edu.cn>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 12:57=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> This patch itself looks fine to me, so
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
>
> We use -fmin-function-alignment for GCC and use -falign-functions for
> clang. These options affect codegen only so it's fine to ignore them
> for bindgen.

Thanks Gary.

> Although it appears to me that we currently don't set function
> alignments for Rust codegen. Maybe that's worth considering adding?

Yeah, agreed. I think currently there is no way for that in `rustc`
(apart from `fn_align`) -- I have created an issue about it and a few
others and linked them all at
https://github.com/Rust-for-Linux/linux/issues/355.

Cheers,
Miguel

