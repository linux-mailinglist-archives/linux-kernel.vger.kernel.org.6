Return-Path: <linux-kernel+bounces-357816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A707997677
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC001C227BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B621E1A30;
	Wed,  9 Oct 2024 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pvg/OsU0"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E80A1684AE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506009; cv=none; b=jnYMO+xCor14hi0XkVYD1pUtKxlUbvAfsJY/dCjMCBmYqQ9FxDu1XMqw94N8E93paRn4oaHLK9PFBRNYXPMrxFWXXayc/6zGpdQFFYokgdTIZddYA8Y+sj3yTF502lCNJzYMXps0hdC2zzCvlmQ0+Bsn2pTtK93h5BJ3z/fPHgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506009; c=relaxed/simple;
	bh=g3Z6xVqchyvePEhyFbcGCbGYDr+RxMXxMhTkzYEJUwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxJ5P8knbxbutTF4LU2wNPqnMsttJYsjbVOze0T6QlkH+xTmW0CLz07BXoOTWqh+dsxunI5bgvTM4MWfINPUkqZsNat3ShHl80O/wVG+6qCGgioVYMRDlPa5w/bQkRMetAq1WGOJKUkud0EPsHJlEZK0BusxTZrt0tkuzyX37Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pvg/OsU0; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4601a471aecso20791cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728506007; x=1729110807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3Z6xVqchyvePEhyFbcGCbGYDr+RxMXxMhTkzYEJUwc=;
        b=pvg/OsU0EgxynbPOHrpB/tBFQVlp2OjSF1iN2VvwyYFi5RPcqHCYmiEai3XYLZRGkb
         l83pB2mU0ZSXMeX6uO5Mfi8iekQ+tVFVmEjmSEFhM4ppx/aILS9EkRqeVwRqzEHw/OA+
         edzuplx8+YbpbA4fx7dKw+Zq6t/8gECqDSTZPfXVyk64QMQ6nvXNTNXdBIju7TcXloer
         HSpklMDde5yCsVOqzt7gjI2BaomyvczAhblVjrMSvyamGdSJgt4/05xthhx94kk2k3ye
         v/USPsXA0ILtZr5j7WK8Knrg90MKbZaDmd6SCAN+cUP5v2jLD/DA7+Rqu9wHiCFJGUWy
         /Ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728506007; x=1729110807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3Z6xVqchyvePEhyFbcGCbGYDr+RxMXxMhTkzYEJUwc=;
        b=mv+24/SqGUCW2v0aI93mmRP1LkTODHeXcrF7++ciSiRltN2TiFR9wphBOlA5/wcGOH
         OgDF/TaD3AzNoeegHu6T/77EKiEY5AJ6BciCnZWIQ1uvrSihMBiAsJ6ifBtlo3O4XdJT
         jasuCV6HBPkCsI6eYeiyqQbMTnYMzdprjh6KxS7re9iQbQZKqYvp4gy3UJBJ1d7wu+kq
         Cgg7k8KgLJQL+lAGHrZQ4jImYkmB2twy6N2FpuNl/MlRRe48L4VqPX2kEvCFjHMl6XOy
         +x/kZw+vLv4JjD/gq5niApZUB/4CRc+Rf38LpjCOa7/o6TNGP55zsHzZBx0Si6ITeVr6
         aV4A==
X-Forwarded-Encrypted: i=1; AJvYcCVReQaF9pWjUhbbXcOLtcgFCI55vMMUtRi3wSnFFLz3Jp3w4yW8e3xgfOORyHR2t3NlDY+TmF9jn2hDErA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw13qMSI7+VYOe3nMTinfcA+f7mVsFBTuxn68dcxEpp0TXLtKVT
	fuvTzGdzusXBO+r6AAHntHPHCHcxiw6Lzic14MOc+Vf3Mj5gWrI11wdrtOmEE6LJClACYMT8WVz
	n/VHIvTsSkr80a2KWMI0V4L9GJ0VviDFGjya/
X-Google-Smtp-Source: AGHT+IH2eHhPIlYCkvIKDRvl0HccBxY6IuEQCiXmalbJ952EMdFHDlwr+M0C26/wqu6RWinAzZSETQFZjxJu8xv+JI0=
X-Received: by 2002:a05:622a:5497:b0:447:dbac:facd with SMTP id
 d75a77b69052e-46040469e85mr751951cf.24.1728506007151; Wed, 09 Oct 2024
 13:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>
 <ZwbAvEnrzu6UUgGl@J2N7QTR9R3> <CAH5fLgipBfd5pNKqniXqFudruyGaJG=LDc5MEf3Yxq1yRMmQcw@mail.gmail.com>
In-Reply-To: <CAH5fLgipBfd5pNKqniXqFudruyGaJG=LDc5MEf3Yxq1yRMmQcw@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 9 Oct 2024 20:32:50 +0000
Message-ID: <CABCJKuej95SJjJuCuzwFpPUJG+iprc=gFgnZmuAE_MU5yMAppg@mail.gmail.com>
Subject: Re: [PATCH] cfi: rust: pass -Zpatchable-function-entry on all architectures
To: Alice Ryhl <aliceryhl@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Matthew Maurer <mmaurer@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 8:15=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Wed, Oct 9, 2024 at 7:43=E2=80=AFPM Mark Rutland <mark.rutland@arm.com=
> wrote:
> >
> > There's an existing incompatibility between CFI and pre-function NOPs
> > for C code, because we override -fpatchable-function-entry on a
> > per-function basis (e.g. for noinstr and notrace), and we don't
> > currently have a mechanism to ensure the CFI tag is in the same place
> > regardless. This is why arm64 has CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> > depend on !CFI.
> >
> > For C code at least, just using regular -fpatchable-function-entry=3DM =
or
> > -fpatchable-function-entry=3DM,0 shouldn't change the location of the C=
FI
> > tag relative to the function entrypoint, and so should have no adverse
> > effect on CFI.
> >
> > Is Rust any different here?
>
> Ah, no it shouldn't be. Sami can you confirm?

KCFI is implemented in the LLVM back-end, so the behavior is exactly
the same for both C and Rust.

> > As above, I suspect this isn't necessary to make CFI work, for any case
> > that works with C today, due to -fpatchable-funtion-entry being
> > overridden on a per-function basis. Are you seeing a problem in
> > practice, or was this found by inspection?
> >
[..]
> Well, I was told that it's a problem and was able to trigger a failure
> on x86. I didn't manage to trigger one on arm64, but I wasn't sure
> whether that was me doing something wrong, or whether the problem only
> exists on x86. We already have the flag on x86 for FINEIBT, but I
> thought on the off chance that it's not a problem in practice on arm,
> it still doesn't hurt to add the flag.

This only impacts KCFI on x86 at the moment. However, we should
nevertheless pass the same patchable-function-entry flags to both
compilers on other architectures too.

> Regarding the AAPCS64 calling convention thing ... rustc uses the Rust
> calling convention for functions internally in Rust code and I don't
> know whether that changes anything relevant for what you mention.
> Matthew/Sami do you know?

AFAIK this shouldn't be a problem, but Matt knows this much better, so
I'll let him explain.

Sami

