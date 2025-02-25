Return-Path: <linux-kernel+bounces-531797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC07A44513
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1AF19C6658
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D387716EB54;
	Tue, 25 Feb 2025 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgQU9Tue"
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B70613CFA6;
	Tue, 25 Feb 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498938; cv=none; b=hpAA1MtCFbYJiSfvah1NE6SYHTmEFBu15raHOxRp+aA1aN1tLmI7czpMfqGRcDd6RPf7Gs/8e6tVZpCqGUoq09JkODfS2g7gTVXXSAJa8MqJAtvHNQ04VQnxMFk255F3jg6OFYncEeabVib8KAqNDwGqmq2V0WzLWx/u7pbx74E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498938; c=relaxed/simple;
	bh=hF55E3Ogdaye+n1B25dunM3ZcH5a1MODKctwDGX44zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dse1RyamhfUyQI95YcIK2J91Ww8fKQGNP9fxhdOL5gWfiEk+DEzZVUkRHZGw/HEEvuLL8qc7fbD30BqqNkRlndPCFg9/yjXELu8tjGSud67oynovEFWZ3m8OzkENitCxQrfIaQRCbZPWzU00CNS6Wbvn41cfJkdsRNf1plwkKGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgQU9Tue; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-5461f2ca386so4947384e87.1;
        Tue, 25 Feb 2025 07:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740498934; x=1741103734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYtfOCfJn94fEBqmGvRWVlaxHU+OZYFbnWLQkERMpAs=;
        b=GgQU9Tuem+UfNjuU+h1Vti65Sa5ROB6NrXgYZ10fRcRtiR+FLshdRtyASyEdFFGyPR
         kHyWQyUuUNJi6nr+VxYVqRV613uKExGQmX5VSpe1hTitmMmU/SiImd2EDZYCXLWKpyZu
         WA1bHl3znpos6SnQnZP4nl5VFb0QNsep7mWNoD6QSkyG3m0b6pXnYQE28OA6lRvOgR+5
         YuS+MhgwpQ8hnAiPLyn++X1rRGqCvNUWu4T09CKnoH57ctefZJM2iFHHFgPn0MGeo7Mn
         cacHsU21lVONwCJwQo8bzsPth7fWKYolY984rAmPrdF9oMgrGb5vrJYHTpLupXchyNNK
         0Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740498934; x=1741103734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYtfOCfJn94fEBqmGvRWVlaxHU+OZYFbnWLQkERMpAs=;
        b=nAftO37fSIp5imBFCC4tq2C7dbHSzO75es5njMonZl8iW2Ot8oT1LOTnv8nKwUR+8u
         tLVr4Smut7NZANPFpokYhO6wBb15ubatxaCfXLRSd1YMVStbFF2utP8Y9gFVZipyvwJZ
         PS3WqHXbpzYHTs0OPSF+V6xcN7B2d/eiqYaOqRUm+oDhVagRPoZXeT9mdQCXbJavwQyi
         19KrcTmmKT+y5Re9T3yVy2oqYzbYPb3aMlWTd9azjGvvWokBzIKAAREv85uIbUSU5rJE
         hrMxUFFb+wZ6Y7EKYrOFJZJzCqV8crL6h4mx3fDaSdrrbm3MyncGjPdKEZ2nK18VZ4bp
         S7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWVUC4/gmXfLWWP5kNFm03++rkPYGvgt8YZ7ISs6oeOq8DEohOW+orq+1KFvS65x/ErTt/g3yrTFG1TarOaS6A=@vger.kernel.org, AJvYcCWzRfC78Z6GpVtGFdj489Kq8jFEZshmALm3Uv+MNYTVx6+odjlic0fG3+qp4KyxvYQEQu/J5T9+EuH0xyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzr5B3d2TiRE4qDZgYgyfjo6u5wTZzRuTrez2C80fsHJV88lS2
	sjY/R4Yz2NBYxW10CLVuqAd/SMriRVyxvowd7PN4QgINeDKL+lZyK3q3N4wXQOWKgP/aqzOJbhV
	PTwzeLRLmym4ikzQtqe7EEqpXY+0=
X-Gm-Gg: ASbGncvXEEh6E9o7CQBZHs1IorSrRMCYtrf/YXh7ZIAc+0Fvy4R+RpzjghXXV6ID8wv
	RfXBeHQcdcVHHUJVBeC91hDUasx49VulLlJ7SnTXhi62tsJcz4Lz9Qtc9dt7bzOH2IohmGxBXVA
	l7Dg1rKrNB
X-Google-Smtp-Source: AGHT+IF1XkfIfVw93S//iXQZcDFEKgFYA4bobH6DISTDawZVVJXpjn6qpb44SESt5MeNgE2IlLKAbPORtJU5bR6NPu4=
X-Received: by 2002:a05:6512:1244:b0:545:ee3:f3cd with SMTP id
 2adb3069b0e04-5483912fd2dmr6541677e87.9.1740498934272; Tue, 25 Feb 2025
 07:55:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <20250224125805.GA5729@mit.edu> <CANiq72k-K3-Cbnm=0556sXAWs0kXBCB4oR67M4UtD=fq=kyp7A@mail.gmail.com>
 <CANiq72mfQk_ViHJ9Y_rU0etS8XpORvZUNMc5m2iHL=pQDiVFSg@mail.gmail.com> <CAEvRbeo3QujuvRxjonhzqjQbO5e1_ut0LOSQsukH1T5vx=jzuw@mail.gmail.com>
In-Reply-To: <CAEvRbeo3QujuvRxjonhzqjQbO5e1_ut0LOSQsukH1T5vx=jzuw@mail.gmail.com>
From: Ventura Jack <venturajack85@gmail.com>
Date: Tue, 25 Feb 2025 08:55:21 -0700
X-Gm-Features: AWEUYZmDhhkLGgYxVaKt3jmn1GKLW8pPr0j-020Xk3x2nzuZnts7KlvnLN4mpsc
Message-ID: <CAFJgqgS8u=HZ4kps=9iEcw4ra2ocLU5YL+=YNB3Vo9E+1jNnXg@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Philip Herron <herron.philip@googlemail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Ralf Jung <post@ralfj.de>, Antoni Boucher <bouanto@zoho.com>, 
	Arthur Cohen <arthur.cohen@embecosm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:42=E2=80=AFAM Philip Herron
<herron.philip@googlemail.com> wrote:
> My 50 cents here is that gccrs is trying to follow rustc as a guide, and
> there are a lot of assumptions in libcore about the compiler, such as lan=
g
> items, that we need to follow in order to compile Rust code. [Omitted]
>
> Thanks
>
> --Phil

Is this snippet from the Rust standard library an example of one
of the assumptions about the compiler that the Rust standard library
makes? The code explicitly assumes that LLVM is the backend of
the compiler.

https://github.com/rust-lang/rust/blob/master/library/core/src/ffi/va_list.=
rs#L292-L301

        // FIXME: this should call `va_end`, but there's no clean way to
        // guarantee that `drop` always gets inlined into its caller,
        // so the `va_end` would get directly called from the same function=
 as
        // the corresponding `va_copy`. `man va_end` states that C
requires this,
        // and LLVM basically follows the C semantics, so we need to make s=
ure
        // that `va_end` is always called from the same function as `va_cop=
y`.
        // For more details, see https://github.com/rust-lang/rust/pull/596=
25
        // and https://llvm.org/docs/LangRef.html#llvm-va-end-intrinsic.
        //
        // This works for now, since `va_end` is a no-op on all
current LLVM targets.

How do you approach, or plan to approach, code like the above in gccrs?
Maybe make a fork of the Rust standard library that only replaces the
LLVM-dependent parts of the code? I do not know how widespread
LLVM-dependent code is in the Rust standard library, nor how
well-documented the dependence on LLVM typically is. In the above
case, it is well-documented.

Best, VJ.

