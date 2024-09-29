Return-Path: <linux-kernel+bounces-342788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B30989308
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2E7285FDA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB08022F1C;
	Sun, 29 Sep 2024 04:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="IoajdJvE"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87811E49F
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727584645; cv=none; b=fE+r/tmLjc0xMg8Wiln83qxbFEOa58f5ZS3vL72fpOGj/ACrzaYWgBUwHqhNrVHba098Ya7QUocVorwWS54MhrbK8I/EvjVk20THNpuZuyxT+OmcwiGusD0AtLjdc9w1YuydcpDtNeXmNn1eFJpCJo59hzcAajYbUhhs3Oh90Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727584645; c=relaxed/simple;
	bh=YFwu01Y7TeiQz29fQ6MSlA65RT/0TJfLp1urzhN2k0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaKy57BWkXQ7uqRB6ZzV0FXyxPsn2bgo3IxjKljQ1qqe0hCsGYSNoqHeTVO851QQTU8C2KNWjzyUoVnfk5yoJopVT7U5RV796k/gtpymrJbF3cq6D+G9vKTPmg0oUvcN+7fBMk4ISx1eUqhD1+wJ5SaQA02Uui0q2kYJ3zz4p2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=IoajdJvE; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6dbc75acbfaso29085957b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727584641; x=1728189441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V42qN1WQV/laReG496kmeSiiLIY8lCzO5J1gHdR31kI=;
        b=IoajdJvEQs5McfOkgvW7gs4u6sjwguiotNo652PJs5C339Yqb3sSW3iv1RgWk+IDAi
         aHyiswKt3uqf9uiZOrP+6MxG/pkJhZ5SM4DyC0CWUfanZBOl7kyFg4+bTXBTCpn2iGJc
         /OcR1BkvHVBHjAD3g8VICuwvC1rRWqulbgm3H0ihCa4QUwDQNvSKPp8u93jckhQLes3N
         0zQH6kVZq3ynrAZijenbtLvkyslYeoJ119n2cOkRGolnaEQSHYQG9GWjle0fIH6DFnhZ
         zZTXXz0M3afQv1r7Jp8iR8y1F7aBg5XTzExGArEkPuLCR2s/5CYCNQ4zJNlGf5aeOgUP
         OdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727584641; x=1728189441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V42qN1WQV/laReG496kmeSiiLIY8lCzO5J1gHdR31kI=;
        b=QOv17TITCziRW0UQsTX13TB7fhUyIvGdftVI4m1x0s1mO19jGDB3/pdn0lrjys8Qwj
         HsiInJPfuNmgiCXGv18Tn9ctKnBXs1VbYfhazBE35w9/MlEo3cZn1RW0g3zy9U5NuwB0
         UdFv7sl42juNl4X0Yr9vpKHxHBuPMiYCxftDSVmgLto6m2U+kPRT1CPCKO9x7iGct/8T
         NsjdhNcCH00UXqBe1QMdc39WO6mAIaX+wjL+4M34LkHe6LguLuYvr3TMlBd+clNO+o53
         JSTn2AvS+qmoN+eUzWFLGE7er5tnqig1jhHBOIStTVT0WT7av0iw1/3ATSdivvWcDWBQ
         0//g==
X-Forwarded-Encrypted: i=1; AJvYcCVb6RMnwGd0tS7sLcgvIaeXBlb6sRuAV+RUHelgn0JmbDHvtkzjmTE71tQw+yryjKoKXTQrc8d9HTcoKsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynRwmessk7KBNjfH8OQC8kR+jPdwoRekY0vns7KENbqHBJiCfr
	aMSEQ9zOTRHJPIW8yBaFbzpwRfhlcpELKrDI2ZhkzSIRB9FJivZ1nFanlsEUOboKOeLhGUdlIo2
	A/ryWQYI3UTG9Hk5xHZ4dNaaYcf5YjGD+c3TIkQ==
X-Google-Smtp-Source: AGHT+IFflyx4smOHfMTuag0OKxVqo73QHCgDXjWZ8we+nIfLuHLH3n1yJuvkzYi/Z0pOSaiUUVzhsTTfIRORRjN+gBE=
X-Received: by 2002:a05:690c:700d:b0:6dd:d06a:b840 with SMTP id
 00721157ae682-6e247621811mr70577967b3.39.1727584641683; Sat, 28 Sep 2024
 21:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-8-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-8-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 00:37:10 -0400
Message-ID: <CALNs47s9GFAp-6p6sYizOLbsAwUJS2EFxGtPDbvvegqHRPV-zQ@mail.gmail.com>
Subject: Re: [PATCH 07/19] rust: enable `clippy::ignored_unit_patterns` lint
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> In Rust 1.73.0, Clippy introduced the `ignored_unit_patterns` lint [1]:
>
> > Matching with `()` explicitly instead of `_` outlines the fact that
> > the pattern contains no data. Also it would detect a type change
> > that `_` would ignore.
>
> There is only a single case that requires a change:
>
>     error: matching over `()` is more explicit
>        --> rust/kernel/types.rs:176:45
>         |
>     176 |         ScopeGuard::new_with_data((), move |_| cleanup())
>         |                                             ^ help: use `()` in=
stead of `_`: `()`
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#ignored_unit_patterns
>         =3D note: requested on the command line with `-D clippy::ignored-=
unit-patterns`
>
> Thus clean it up and enable the lint -- no functional change intended.
>
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#/ignored_=
unit_patterns [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

