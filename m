Return-Path: <linux-kernel+bounces-357533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EFC997241
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44BAE1F20D46
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C3D19CC3E;
	Wed,  9 Oct 2024 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eI8E5mXj"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E098199236
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492522; cv=none; b=V1wsl1SeuOnVKr8ksezjpTtfpgD5GbpBY3H1h9CVdarM+S9P8wCg6mHjV2ESpGcQoIWt34jhED2GAKCvhKx7HAhX4yPGulcqS1GK5BizrutFr1GDg1JD9Mpa5iR1QbDfkE4wNCt8blRn1VThR96ulOF2ECPQEWB9eR1HvWlVEwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492522; c=relaxed/simple;
	bh=gdKn2odBMpIYhY6Ml1GXd8IVWbn6t3Iuh+kBokXDOdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwODYvi3/56oy9OifQPKzs1PmDvcDcQnWKouSeB4YtD/UFXxekyiN31Jsuk7kP50SgZwtvRAClPdt1bf6FGZy2wDTd6sI/tA54hbvAmLxShkwuZ6+Jyw0sqkBh7p9nXUnZ3xj4PJ5r79xza6Ei/33Nm9+XY2F9eCKSnXR008jV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eI8E5mXj; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4603d3e0547so6911cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728492520; x=1729097320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdKn2odBMpIYhY6Ml1GXd8IVWbn6t3Iuh+kBokXDOdM=;
        b=eI8E5mXjG4M4n94C3oUnOw9TiI1LtFKgAc89jLMN4tAG+pKTcWS0RvWIR7jH9bm19j
         /GCfz8G5BVWkE1htn6EXvuCASneEZH/JUN9wQJ1jXh63jyuYCvj5UKDSnkCnTtsglHSw
         yr1lAyXkGHhcw+10UirGyI6U1ou0bM7huKXkOYTPGERgRzNE8OSrqDINrJq5n1fj/wWf
         G/fkrftiwSm7i05YfL7K4yVSTLKLLW8Wp+LP0lCeGvgoyZYgbGUVUkrTBUdQX49k0Ds8
         X3Ki4Qyb8OoVYVu2agOOliVS98oqkyPX0RtT70JvLX+uI7GCFBPMPkBrFyDwpZtx60t2
         HELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728492520; x=1729097320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdKn2odBMpIYhY6Ml1GXd8IVWbn6t3Iuh+kBokXDOdM=;
        b=G3kPin/4M+3uKxH0MSBnSbpXL+T524tH6VcVq6ocg4M6QttkfqNExcmXXP9o8vjxty
         cuFXbvHVkcl+bVxOvuR23cyef+2jVeZJjFvdsTkIU17GVf2B0w5viWL5Vva1BXIdyjXI
         gDwyvtwtS+imWqm2dVYUQLx+pzWUWJF1Qa2XqJIhXbbo32OOey6jeZ9z75F6w+Gn60k/
         bMkNHoKS3hl06cTLMDHZMXSxPvXQspKqLbYZa63I/PsvGNXl6tUrD8KOit74jyPx6ryl
         fW/sps/DhZBIYfhB+5PatZHMBcy7Y49uavGZrzKT0+RWtjnB5wFMurwTvK7ho55TSw0K
         fy9A==
X-Forwarded-Encrypted: i=1; AJvYcCWbZAwpdaVrJeECMVpIt/t/FOBlduUJqSFXdNHISZmDZYw3Ri6JxdykMjCubfUlgSUZAOB/rc/3ic5UDcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmWCc30CeuR+gcGZKHH1DAIvkoD555HAGF5n5G5fNUQqMXgZZh
	9dvqxtDqazZ/YLYxONxT3HiT1V1jKtzbNRGVCfWOFWJILXSPZFylmu+168NQMPFIvcJ+Az93Lrf
	J6ArYmDObRi5SBAwRKC9lvdKC12DS2kRDsgPe
X-Google-Smtp-Source: AGHT+IFU2+kjwmtE/tnFQrIWgevFZ6/YDFYn29RzthvZHDHMDNxdPEj2AOVBL4hcHNKv+c2nCcFEUJDPNG9SsF97388=
X-Received: by 2002:a05:622a:5612:b0:447:dbac:facd with SMTP id
 d75a77b69052e-45f0a1537fbmr4407531cf.24.1728492519801; Wed, 09 Oct 2024
 09:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>
In-Reply-To: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 9 Oct 2024 09:48:03 -0700
Message-ID: <CABCJKuf83gywnbtkJ3d2VfDRH9f6kcf1Bn1Zau5re=4YoV6E8g@mail.gmail.com>
Subject: Re: [PATCH] cfi: rust: pass -Zpatchable-function-entry on all architectures
To: Alice Ryhl <aliceryhl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 10:37=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> The KCFI sanitizer stores the CFI tag of a function just before its
> machine code. However, the patchable-function-entry flag can be used to
> introduce additional nop instructions before the machine code, taking up
> the space that normally holds the CFI tag. In this case, a backwards
> offset is applied to the CFI tag to move them out of the way of the nop
> instructions. To ensure that C and Rust agree on the offset used by CFI
> tags, pass the -Zpatchable-function-entry to rustc whenever it is passed
> to the C compiler.
>
> The required rustc version is bumped to 1.81.0 to ensure that the
> -Zpatchable-function-entry flag is available when CFI is used.
>
> Fixes: ca627e636551 ("rust: cfi: add support for CFI_CLANG with Rust")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

