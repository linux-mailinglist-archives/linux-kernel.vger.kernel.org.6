Return-Path: <linux-kernel+bounces-358917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF90E998543
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9432844C2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289E21C3F00;
	Thu, 10 Oct 2024 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmDJsiTe"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492D61C245C;
	Thu, 10 Oct 2024 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560669; cv=none; b=WJB4AM4rz3wJgrX4phMIpfrVStFSUhFyuIfRfErHd+Mbt2uFrT55JvKEPepDUfTwZ67vc8IoZ9NPCSLRBwWgJGkxlAkg+B5gI7FR9Pe1JgcixPCYn/zNGzd72hblKO3Ei5kHZI82Y60OQtVUyVEcrIKl7SRymd9aLCKEe2cYcJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560669; c=relaxed/simple;
	bh=2bcJ4+CbIja3RwWUGVJCLGPSRxnGjLzpAXTiDnP2l0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaLFLANE5paT0J/7KV8ShCG68r9gxujlireYCS+D7cBc5zTpLprM5CYRi7d1ZSr7fLF5B/Y8Dcy80Yw3x03piy8jn7nDksTTISLg8aNsng7S9YnpH5lTYWWuwGeAOKjiu7dxWiAkFkB74ITGa7n1TeXHQYzYsBHmZpFBjVOmWnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmDJsiTe; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e1ed14105so42136b3a.3;
        Thu, 10 Oct 2024 04:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728560667; x=1729165467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bcJ4+CbIja3RwWUGVJCLGPSRxnGjLzpAXTiDnP2l0k=;
        b=WmDJsiTemPsQq0+SKvy1o3yByS28J6L2NYL2P5d8oZPobKu5xYT/fg0Vt6sXwvVQdA
         X3IJUlcnlAdU+aALdT8A4TsDkGLMs+lXiAwABefFbrLDPnW+9GLK0vx6GmZ9+apq5VA4
         z6MnJ/cAQ21LemTlmGHwgv1816hP5wHnKfpKc7NhSUVrIeZM7mWYNFuj1Ay2fxriaT+p
         IlaTcOj9HYdK1hh/Njf8WTnpDXxH6Ld6eyuRwfRoKfvqkkrdvBKMojhYMrg8VgsSa7nN
         yrc8Gw+U5NvsPpsNq6l34Euzn0wojZrZnzATZb8RMeSlKvdiSsdaMm/T8YnCVvoarXLb
         9YCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560667; x=1729165467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bcJ4+CbIja3RwWUGVJCLGPSRxnGjLzpAXTiDnP2l0k=;
        b=XzBxU2KGNYJGRTbk4ljJGYkygpWVgvtMaYeGsT6Kbe+kyxHhiL+6DdLEGgQfeKZ/qS
         5dmAamIVkKVYC5BpoFOLkkqgaf9hR+d4ze+F5SbMjolRUpmPjZduqzfRMz+Rrwj0b0Id
         b9UpVF6qaUvMuO3RyiD6XeXWP+Wj94PjwWBzCc37Qvv10FDRqTDIvnUKBzT5gDD7lCRw
         5kOASfSl7jvc0FiS4wv5W8wyCJtVhCXFMRowiNMR5P5YAFxKqgM1g74v2JG0M+0oQTLq
         WQxq94FqrobnzkI1+NLlQkuLRcHIPYE+GOlC2bSyFN5Cc3+ALzZX1VwR7YBomPF7XwIn
         Kb/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUExNvcYCw7A7LMfXcObYvnXf7fIFJ9Q8kYTUsQhLoLRqVutb8bFVWSDR7RK93z8fBmbHVpXLxMtXVPYyUcRFI=@vger.kernel.org, AJvYcCXumunvo/PYrHuVSWWgupyRq3dVSuO+MPGsn9AINmbdqAYvegTdz3Lvq4b2/Wv2YhPamv3lYqCMMpTOgOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCNCkx3NV5APMK0fQhSNjixKoKWJRuCXTIfA96nvt+EkQFNS/m
	lAPn8RkHBql+DRKHIapdH0mr6lYIn2VZz7YNJ02ET4SQiJmT2zRSB9mMZsYEGay9lSfM4g4kep/
	70sifZvdTNX9szYggH8PGbTgQcQQ=
X-Google-Smtp-Source: AGHT+IHld3yA7pZMM4j9W1AYfJL3YZl/msv9ucSw1eVQ8vGB3wsRDok/Qzcvy2JYC9NwbCxsuNZ/OZ5hbL022PTBeCI=
X-Received: by 2002:a05:6a00:2d97:b0:71c:5e1b:6871 with SMTP id
 d2e1a72fcca58-71e1dbc8d89mr4146646b3a.6.1728560667291; Thu, 10 Oct 2024
 04:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>
 <ZwbAvEnrzu6UUgGl@J2N7QTR9R3> <CAH5fLgipBfd5pNKqniXqFudruyGaJG=LDc5MEf3Yxq1yRMmQcw@mail.gmail.com>
 <ZwewMw8jBh6OU-L_@J2N7QTR9R3> <20241010110344.GL14587@noisy.programming.kicks-ass.net>
 <20241010113748.GL33184@noisy.programming.kicks-ass.net>
In-Reply-To: <20241010113748.GL33184@noisy.programming.kicks-ass.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 10 Oct 2024 13:44:14 +0200
Message-ID: <CANiq72=kT9RFcQ3h5U+wAY0pDQQqGU7BTtiPJ-oiHNUG00z3=w@mail.gmail.com>
Subject: Re: [PATCH] cfi: rust: pass -Zpatchable-function-entry on all architectures
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matthew Maurer <mmaurer@google.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:37=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> So much for the debian 'rust-all' package actually including all. Thanks
> Boqun for telling me about the rustavailable make target.

Yeah, `rust-all` does not seem to include `bindgen`, which I guess was
the issue (?).

I guess you have it working now, but for the next time / others, we
have the `apt` line for Debian at
https://docs.kernel.org/rust/quick-start.html#debian.

Cheers,
Miguel

