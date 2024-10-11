Return-Path: <linux-kernel+bounces-361043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7218099A2BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39B5288912
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7F421643B;
	Fri, 11 Oct 2024 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+BVIdQy"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6B20ADCD;
	Fri, 11 Oct 2024 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646379; cv=none; b=KYhGcZEkyjXglhQQrLk1D1Y91Z9jGzlxWBIO//sZFbivACPmjVLEWZKh6PP/xgRD8aJOZemBMRANzcDddarQOYhL7bBAxub5RaiSTGB+JK4/IsBOXpVE7KwjfnIevKJLOoVZYV1Bo+3e35xetVioHTRgKul92S9FVj0qocWUfps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646379; c=relaxed/simple;
	bh=az4hS+NK8zBr5UCFhRFct2ksVmIL42/RJE4tgtHk2Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OStks4/0o6mNrMyM5pryphE6dvtuV7U7d93o7zOi7DasIof1CCPSpFpU7elRCeDuTcSUfsNdH0JhOst+ORAH9kByjB0iX0mVuXWvZmytb0/zp99f3PMm9tBkPa03Br9uqZvrIdSFzqY1TqiYu8XIOgon5cCfDaGb7/eecQvlzB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+BVIdQy; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db3e962c2aso148265a12.0;
        Fri, 11 Oct 2024 04:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728646377; x=1729251177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=az4hS+NK8zBr5UCFhRFct2ksVmIL42/RJE4tgtHk2Hg=;
        b=G+BVIdQybCD+ThB3xeA5NXhyLAf6kggLOcmBbKOx6xZzl77qrX0nszdRyU4JGWZlCu
         eGv9LdLhYvu4JFWfmIZ5/3oCy2vQ1yOEzXFLsFh5PYFc/7CgNihSEYH1wZZAm+L8ymma
         OGuDFmuZnh1E+jPcqpgPDIn+V4outq9qCKs9GARrX1YtUG4p5N3VnFAenpkHQiASRbmI
         eFvvkQmGiqtCu382KYYabjMERaK32BDm1BGvVfo+q6hofxspbNLIhJ5bILYQVE87yJlM
         KUG+phywuka5OTrXHx7RGNF48OwsBhQzx/QBqCK35N8Znc0U6hlMwUOeRIpsjOqaaPAU
         werA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728646377; x=1729251177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=az4hS+NK8zBr5UCFhRFct2ksVmIL42/RJE4tgtHk2Hg=;
        b=f7jgZysExyWG1Wjg2La2E2au5TnrPaNW/Ebz8gjK/59dA0AOFOtlggXPGJp1PwShqM
         Wn6NpjnOE6B640J74iXMPYxX4ohJFNcAwMUrKMT+VmmHERMKMA5aAvMKJ1zBjW+IvdOa
         r4smVoNlh/0G9GybgxOd7DFZaPHbfhdK5HnLHPsj8V2rBf8d0FnTauHZ+OO/rgI/v6Sn
         R0ofSxpSlSsA9sTSWfb6ys33bIMj39WauClfQoT8bzy18Uqjcm+18BTYUZs5nRCW7TvJ
         DXGX2JBhrnf6OrdSYS70goLeiE4zx9f4SzCCV7wTGbwYyDysZ5zYGYf9GzXdQOJ75odZ
         kpRw==
X-Forwarded-Encrypted: i=1; AJvYcCWEsH85G0Q+OoLGyTbKjObf1RHHD1Od3inE5NrsNXf+j/9G4VCzAbLg4bl4iRcpk3zJbtJZ+kDVQ1m5bqBQ9NI=@vger.kernel.org, AJvYcCWOF+2/mbOmxnEDXsL77KFwXtjhxoFSKyY3Tykwml6LKjzzDxVucoJ6cEHb2VIiesvdiLt3j+7EJc3d9L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRaB5X5n4mspt6zSRcRo/obTISsq+yLVT+FBLawLcMQNC0/M59
	E5KypGK9dUvou42Tu+ydwqjg0hmUSpajx1lXhzF0A8NXN86JbNZeaytzsRtyOJrrzSJ+Jl0ikfV
	zYgpCMHXVoEgp7Im+T+gNID1iIj4=
X-Google-Smtp-Source: AGHT+IECMXVvn0oo1MNjapLxNu2xErXjaCUcD29N0fsc68U7YJSRkD+W8Re/vBWLXWMsFfWDHfD0zZ1hSdE8Z8CiYOg=
X-Received: by 2002:a05:6a00:3e1d:b0:714:2051:89ea with SMTP id
 d2e1a72fcca58-71e37e25dedmr1609379b3a.1.1728646377173; Fri, 11 Oct 2024
 04:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>
 <ZwbAvEnrzu6UUgGl@J2N7QTR9R3> <CAH5fLgipBfd5pNKqniXqFudruyGaJG=LDc5MEf3Yxq1yRMmQcw@mail.gmail.com>
 <ZwewMw8jBh6OU-L_@J2N7QTR9R3> <20241010110344.GL14587@noisy.programming.kicks-ass.net>
 <20241010113748.GL33184@noisy.programming.kicks-ass.net> <CANiq72=kT9RFcQ3h5U+wAY0pDQQqGU7BTtiPJ-oiHNUG00z3=w@mail.gmail.com>
 <20241010130421.GG17263@noisy.programming.kicks-ass.net> <CANiq72kbApTtdLeow5L6G6t4Q_L-0zkDwfwyWcSb_e6P=kO06g@mail.gmail.com>
 <20241011105136.GP17263@noisy.programming.kicks-ass.net>
In-Reply-To: <20241011105136.GP17263@noisy.programming.kicks-ass.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 11 Oct 2024 13:32:44 +0200
Message-ID: <CANiq72mYEbGxFZHQ_vfHTybuYO62As-23VR9yASo-b4LcZ_pkg@mail.gmail.com>
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

On Fri, Oct 11, 2024 at 12:51=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> So you could just copy the bits from core you need into the kernel tree
> and leave out those bits you do not, and ocassionally update them when
> needed, right?

Yes, but in practice it is a substantial amount of non-trivial code to
maintain and some of it is too tied to the compiler (e.g. using
compiler internal features), thus it would likely require maintaining
several variations in-tree to make it work across compiler versions.

Maybe when kernel has been compiling with stable Rust for a while, and
especially if `core` is split into "really tied to the compiler" and
"the rest", we could consider something like that. Personally I would
like to be in a position where we can try. Perhaps it could even help
to simplify gccrs' life compiling a smaller `core`.

Even then, we would need to see whether the tradeoff is worth it: we
may be able to customize `core` here and there, yes, but, for
instance, we could lose the ability to easily import other code out
there (virtually all Rust code uses `core`).

Cheers,
Miguel

