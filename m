Return-Path: <linux-kernel+bounces-267196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4778940E42
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702321F247DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2295F196D8D;
	Tue, 30 Jul 2024 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SOSD2aEI"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF241196D8E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333079; cv=none; b=pNzyUB6zZasKe/UJzHlV1JsHqzPRxVD8klLj3bw4mhKkeR+7JGs56Ok1iDJVOWMI9ytd8uCstWyft4eYVe7i2FHLx3Qj8X6HpYBWbDfHKePq7bBLAQbcPzgZplmvZ+dHGCmAQurAPetBrRs6SV7T4yHey2VL1a79gAjh998w8fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333079; c=relaxed/simple;
	bh=pG0/q22Jl93ehcd5L6RcUyPD4cxH1wdOucz6oiQ7oEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PS/RlpKiirCtq6tp6AOTw8RousVonCyF0WIiQZjp5SFEMjHjHo+upHrVL4vrIK9e4GJP0Il8Q7aUnaJ1ee/rTob2OQXhvWGlRqmATSQBnqheJEJT1uHNZn7FAiDAEAa8Wu1/Vhr9QslCAzYxo93yJ++iQIzKrnYQfIA8UEK2L2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SOSD2aEI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so21931635e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722333076; x=1722937876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG0/q22Jl93ehcd5L6RcUyPD4cxH1wdOucz6oiQ7oEY=;
        b=SOSD2aEI9Y6QCL8OQZuej2rMi0QGlDnHJnIpWyz+DkoLPq1LzWL2FL5XzV0CE+TRad
         iz3wg4WSo4yCn2LlwtTfZUuVj8FmUChJwWixd/oOoudRjDGGUzC6PJd+YK0xQ2mU3qhJ
         4+G/rd99VAi4RE7KBVCdEYOPIv1hd5r2woo9THGWX0sATBTMF8xUg3wpIDSjU8gSRegn
         ilQk/LWTOtviuKP6r7K7f3yIJ1qw5x7iMj0fzuDhemtyiw0Yz/P9F36Aw8mkkXAmtSxJ
         OzSkTW9OGBTENv7l90jVF68NMK61EvRnb8eQnq/pYAh0CW4aQRKZXmDkAk95S2CCp4tK
         uc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722333076; x=1722937876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pG0/q22Jl93ehcd5L6RcUyPD4cxH1wdOucz6oiQ7oEY=;
        b=vhaqXPHIWjnjYFgnszDJcIV5HGJoW6Gvuflnfczu4f11g2KhoyN2aBwrR5nbuTlYfa
         T1ZIyEdSo2zaZhI1TSvjyKzjOS2/cG4ZQOTjLK0qKawYH7vS95JHASFgzkDQ+nPbrTdQ
         HdhkxKhFTnGaVt/6zl2XKIGr+bbV+dXnMcvKTyzob3jZ8V95Q0ulSarZzHCGRe43SXq4
         qBu2+8NGt2uDsh1OoUgnOeBaH3yYZT9LlwGTLsAUlX2tqttEtFF653eqQp0g/7R38Y5v
         Gvmr2/ptE3AgR78JHgo8qs58MyPVlxESXkZEG62raHczVl0kk31kTtPNEh2qn0AIWtJY
         ymnw==
X-Forwarded-Encrypted: i=1; AJvYcCXqmxXpZZFAED/A/c0nEHeGshrWg4dixfeG/LEBkk7wTHo+OJetRCu3Pc1a2nhHBIswY8xkl1rcSe+DYRcj5ezIR0rddtcW136NGEAo
X-Gm-Message-State: AOJu0YzKXrzrbokprqhPBzXwS90TmDlg/MEiP2sZJPMeuUQp0u9UA9N+
	mwKTHuTRQPxi9HixDPdB4neqzBeGAD1UVsZeUGeRiGbk59ipPs6hY5oku7kEykge8fZqw7GGaDa
	MBsIRDsVQtKoUz0A9dxHJoTYfhu3bi7Y3bytQ
X-Google-Smtp-Source: AGHT+IFP5k+X/a8etFEgTfWg0cxDTZKAXEQzGf1YY1CabSPV9fG2FeY05fu9q7Y4QTzlK3SCKS05MTgrpT9lmBurHNk=
X-Received: by 2002:adf:f7c1:0:b0:368:31c7:19d3 with SMTP id
 ffacd0b85a97d-36b5cee3060mr7555279f8f.9.1722333075916; Tue, 30 Jul 2024
 02:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-kcfi-v1-0-bbb948752a30@google.com> <20240730-kcfi-v1-1-bbb948752a30@google.com>
In-Reply-To: <20240730-kcfi-v1-1-bbb948752a30@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 30 Jul 2024 11:51:03 +0200
Message-ID: <CAH5fLghz8psC499vVochcW-jC+utDXQonoAvwc-9Na4+31Hdig@mail.gmail.com>
Subject: Re: [PATCH 1/2] cfi: add CONFIG_CFI_ICALL_NORMALIZE_INTEGERS
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Sami Tolvanen <samitolvanen@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Matthew Maurer <mmaurer@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 11:40=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Introduce a Kconfig option for enabling the experimental option to
> normalize integer types. This ensures that integer types of the same
> size and signedness are considered compatible by the Control Flow
> Integrity sanitizer.
>
> This option exists for compatibility with Rust, as C and Rust do not
> have the same set of integer types. There are cases where C has two
> different integer types of the same size and alignment, but Rust only
> has one integer type of that size and alignment. When Rust calls into
> C functions using such types in their signature, this results in CFI
> failures.

This should say signedness where it says alignment.

Alice

