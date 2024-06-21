Return-Path: <linux-kernel+bounces-224449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A22912296
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0131F21E59
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A32F171E5E;
	Fri, 21 Jun 2024 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I3udThls"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25616D33A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966317; cv=none; b=hMcfGNVqLOSzpT01VVAnq7V2ICGDnaKMNJ3AzMqml97OMSbxeYhqKvnJe1g+ldX3lzubnUViBXFTvQtDgluanlC+fEUWeqy1qpQ+dzPGmQEnfFkisXHRSCDumzGsvTKkQvIkEOBkT7EQnCgYETyktLn8CHtU8cfWyIup/hiR/nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966317; c=relaxed/simple;
	bh=WTJ0KG5tYdhhPPGpfmG62gp49W7qhiVbW9dawR3CcTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ii9Q4XDcNpw0NBeyniyVvSa2bvlN40ZN5fuemKUtuI65WHjeiKNS0Ve2rqUcXD5Kml1eeX8UdPl1+RsbW9Hcv8Q6z4n6o3BqlOpn58jCsnR4ILAqyPjBROQ2vVW0PJBzg9B/Fi9UXuvMqG7Xlcnw2jkrFrsWRg9ZaWNbVzANlDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I3udThls; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42108856c33so17848295e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 03:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718966314; x=1719571114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44ZpRvpfFDERBn9Dks1/mP2gSSkjphom+K+EdkVXitM=;
        b=I3udThlsQtQ2YjDq9atbqobDTGJ1volpRkp9VT7nWkPV4K+MiRSpUnsSx4lfFnT5Iw
         jkjOqKxHlKQtGeSDWWYZlcpUkeHqjtDckHDSLTl/vJ91P8Wuycj6VkkeKuNnBmXg4Y4u
         +1O0rclTfVrVudevE0lJrewlXLKRXdsm6F6lTD+flXJnUyCqPF+QBEbkfeO7xbmdWqpW
         UHWHS+gPbde6KHozXg+nJdXx41xPx7bTSyfwVniy/glwniqX0Erg7mNmTfh0q+P3PPpE
         NthxUVizX0lvdmNBrujRRGlC5IoJ8f6/O4bNHUrgIRvRlbzhNxhDQ1GkH4qlRO2Lw/b7
         RKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718966314; x=1719571114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44ZpRvpfFDERBn9Dks1/mP2gSSkjphom+K+EdkVXitM=;
        b=XZ1rqKvfobUiBJTTOwJOoxi3J1lVgng2/FxATOnVASTNVcgcQtwUl47QzezTQ57jq2
         V436nEMrUj1XbgF4Src0hWm7uJ91HRPpFLIAhESzcdW1G/2YG08s1QhHYaC4V5K1d+Dg
         E6SRmEyf4rtzdA/hSDGvj8fOMKypyUPsrMpWKoAIifJVe01cq1ItDnpkDyEw2eXljxGq
         i4SsviZNQVMWXvsUzZLTkF/qfhVletBUZGv2sAGDn+0r7FBr7esgRWUNGpHayRkhJen2
         prZQc1fjeZShBMs/AUeYTb+Kopp6aTJTLpr1MelZoCmTcG2SIJgn9h0xawnSqNYwXtkO
         QD6w==
X-Forwarded-Encrypted: i=1; AJvYcCWSAc2QL6IMtOt5D+e5cHTZe3dLbU4hHar+Srm3kc52qtoDymEdm1ue6iwbE7ETU0bsKpZBuJI0Ev6W18UB6CMh+4n5HyUkvRZHrwAz
X-Gm-Message-State: AOJu0YwuQn9QFir19BdC3+Ri+E1YvPk3Mf8DNY4Q1n7PXAcVvDOF68u+
	bMojev2b4nIhYp+MFKC+5zwBa2dDeYZwMQAR8r07CZiuZwXjf11ccVaqXasNok7T2caN+0A8b8j
	nQYgfx2y5UWpZqlXcts0SgeJP8lXdr0nPYBXy
X-Google-Smtp-Source: AGHT+IHayn/UTVkcWmt4aexOdjYrU9ksdoexbcJhXjXZONtcnkNGjtekAv/BumbuGkdej+U3QP9aLzN4qBHFXpFkuUc=
X-Received: by 2002:a05:6000:1284:b0:360:8c88:ab82 with SMTP id
 ffacd0b85a97d-3630191c24dmr7727188f8f.30.1718966314110; Fri, 21 Jun 2024
 03:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610-tracepoint-v2-0-faebad81b355@google.com>
 <20240610-tracepoint-v2-1-faebad81b355@google.com> <20240612-cottage-revision-9842e7e22070@spud>
In-Reply-To: <20240612-cottage-revision-9842e7e22070@spud>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 21 Jun 2024 12:38:21 +0200
Message-ID: <CAH5fLgg2v1jL8uFBK3mEMW-mPydBj1eRT6je8YGtHyNF48JCfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: add static_key_false
To: Conor Dooley <conor@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 5:03=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Jun 10, 2024 at 02:01:04PM +0000, Alice Ryhl wrote:
> > Add just enough support for static key so that we can use it from
> > tracepoints. Tracepoints rely on `static_key_false` even though it is
> > deprecated, so we add the same functionality to Rust.
> >
> > It is not possible to use the existing C implementation of
> > arch_static_branch because it passes the argument `key` to inline
> > assembly as an 'i' parameter, so any attempt to add a C helper for this
> > function will fail to compile because the value of `key` must be known
> > at compile-time.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> > +#[cfg(target_arch =3D "x86_64")]
>
> > +#[cfg(target_arch =3D "aarch64")]
>
> This patch breaks the build on riscv (and I assume loongarch):
>
> error[E0432]: unresolved import `_static_key_false`
> --> /stuff/linux/rust/kernel/static_key.rs:87:10
> |
> 87 | pub use {_static_key_false, static_key_false};
> |          ^^^^^^^^^^^^^^^^^ no external crate `_static_key_false`
>
> Cheers,
> Conor.

Thank you. Fixed in v3.
https://lore.kernel.org/all/20240621-tracepoint-v3-0-9e44eeea2b85@google.co=
m/

Alice

