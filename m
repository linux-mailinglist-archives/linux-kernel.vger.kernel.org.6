Return-Path: <linux-kernel+bounces-183557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41118C9A96
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7D6281CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C8E2E832;
	Mon, 20 May 2024 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HuR4+yd4"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF80823759
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198230; cv=none; b=OskShhOqmzXpTFGc8Uniw11VtE0+mzx5u/jMmfd8ftu6U7EytFYdIOKA3aci/OhgUNCeItOciSmR1EcHYiG9KjaJrZ9/YBQYT/8J5hKe+R/EK5GQ3zX1uZSxyZWILl6mtmonmo+9sCdaW/IFWMqxK8jUkx6jPKJhWQG9mtyy6dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198230; c=relaxed/simple;
	bh=a55aAxkPuy9VVWAPVnECXqpexCb+FMCFcssmQ8ptOdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fU1OcbHuRMPa4S2dUELZWvMHI3lLKy5gs+/93cpSBZZHdlx4VZGQjBszlH4SPYF+5OkB1eK5SfDA6pDNNNkt1XW0/QyrCgk3ph8ELslPqM1aSLT2sCfPOYVTDXQkWj6r4ICS0JR3wVuOULrsI09J23k28Hqm7Fq/BnUgUoGvOTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HuR4+yd4; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-47f008106d0so383664137.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716198228; x=1716803028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a55aAxkPuy9VVWAPVnECXqpexCb+FMCFcssmQ8ptOdc=;
        b=HuR4+yd4bBFdmIw7+KiY6lpKaybGYB5sQEPhn67YoQqDttqetTNs2IeZ20Mn7HMdlD
         LuSL9z3vKil3RSvddsXdcP6Nv/8J5XmOwcX5HR7AF0e/uS62k7FXIO1d7lsNOkV8HB9b
         haDtkzZ0ugSJGtObX4MU2q36slY4QzToBu3tg/b8RW6Zl0ax19UMPYicvgeOGtK813Ao
         FDVUZ/RpSwSXEZ4EtQLuTdH0AxZ0QjIxQTRAr1dQv9je0/KpEaxyTSbKgeRNPw6BNF4J
         HulLxBsekHaiXbSq52B0c+5qMQEh9lJErDIVWhv9s3MxZJ65rTGNjGgX/rkoDjXXSaK4
         XqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716198228; x=1716803028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a55aAxkPuy9VVWAPVnECXqpexCb+FMCFcssmQ8ptOdc=;
        b=mhWSkMqiANFH59veBPvo2B4OEp4dM5POr/L/nzNe9wseJb33LcqEf/WEXmlVewM3wh
         Fbw/T/QVhUUa2sRn+YeHSm75oh8Trc/O4F5LQ8huH+ONi3LCm0Pl88KZtN7rfBio9S+c
         zU1WWKYTuQTjF5v4F/jFZvtxbiywcm1eY8Vr3vaz5QCanc+LAiXlKKu5xn7pH1DpfFvg
         QdiETZWkt0jTX/W687SLqN9gie6Rg/RHqsMnNtG7gZs9sqXePfSLx15b08ONMuUh/69I
         FEUyzIjpoMDtUSmt4Qd4zsoKP4ZVnw+cXEK4l5fp87+a+gmkNJIMu9GrihMLZ6spnPah
         liUw==
X-Forwarded-Encrypted: i=1; AJvYcCU9dEwYkkKVtLMJWxWDt5kENt5rysp6dMxs9PwGFV1TBc8R6yJP/nUqW0gWgWT7Rm67x6M4V+GEEEBo3QUM3+PzII3/lFUsgCwgfq8q
X-Gm-Message-State: AOJu0YxE0BfhlieSfJJ6/XRvaal3AZ/er4ZWWya8TOCxNOwBBAl5GyVG
	z9t7FwSiApB0aUCGapyT8qHhSb85eECxypFT7rnp4SdHWBymFKjIv8VIeguVza1Qsc2LZPuNMRv
	Bwa1CRLCMZBQNAVJVD3/90Fqrp2kpTuHMA/ce
X-Google-Smtp-Source: AGHT+IEYsiVQ/f6j1ZyTO7lXzbXIXBXS17hKFjw1cVaQYNkhH1gui4IfXyiE6NxbpusBzsiFYL/Tf3yT2rLfKLe14bM=
X-Received: by 2002:a05:6102:148e:b0:486:11ff:65aa with SMTP id
 ada2fe7eead31-48611ff67bdmr12548622137.2.1716198227732; Mon, 20 May 2024
 02:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519211235.589325-1-ojeda@kernel.org> <20240519211235.589325-2-ojeda@kernel.org>
In-Reply-To: <20240519211235.589325-2-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 20 May 2024 11:43:36 +0200
Message-ID: <CAH5fLgg=dGmuY43B52gvgJ3S3qphcYYVB3SycuzZHNB6Rcpb-A@mail.gmail.com>
Subject: Re: [PATCH 2/3] kbuild: rust: apply `CONFIG_WERROR` to all Rust targets
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 11:12=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Make all Rust code (i.e. not just kernel code) respect `CONFIG_WERROR`,
> so that we keep everything warning clean.
>
> In particular, this affects targets in `rust/` (`RUSTDOC H`, `RUSTC TL`,
> `RUSTDOC T`, `RUSTC T` and `RUSTC P`), plus host programs and any others
> we may add later.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

