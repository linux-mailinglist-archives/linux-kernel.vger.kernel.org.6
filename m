Return-Path: <linux-kernel+bounces-440108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B529EB8EB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F241889A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6A2204682;
	Tue, 10 Dec 2024 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djCli8sv"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB18986325;
	Tue, 10 Dec 2024 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853693; cv=none; b=tABy4FVNgNut8+ahae/6lwgYjzx1SSskvpxWxOiSayPTArjuns4zR5Y/dJSPKjxwApQPH48dR2TJWhl7+L8pA8tAjP1RhnW/qNWtqAYlS8rqekHI5MlcjuaaISIrKDnk5Lu9pB3RjpaAfYtT5ZwZCivexvdAW4EJHGy7AMnUjIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853693; c=relaxed/simple;
	bh=JNsfJ5pdWNc2079cGlyKbP97GYc87y3iN+nIMeKFqCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUxTnYO44jquQOjNQejP7aKgrEfSvN1DQQ6uzndxshIV4DKXpS8m1dHMbTBzAk9KISjBgQPPJwJEy8he0i1lA2BInJyV89eu7/pIDtvCZO9gwQjnwgZKvc0PsUHp2F4oZuarGY3ZGZql6JQeaOWMK63h8GPWpeLmoMP0shuJWB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djCli8sv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee94a2d8d0so867288a91.2;
        Tue, 10 Dec 2024 10:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733853691; x=1734458491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNsfJ5pdWNc2079cGlyKbP97GYc87y3iN+nIMeKFqCk=;
        b=djCli8svf4Fcokb8aYB+aSwP9d6XkgNVrU4Rr3a0Rlg88odCus0z4VDa72dFuDvOSF
         Foy2EnqYt7Hixv7+tscnbV0J/iGXFLksE38gIJWhmU6GIqaoLDXMYEFP5h3LX/dMiMuL
         NjbJt553KZS0dbsbKecq4K8+uDjJ3kmaL3cz06ucEeqixpW3VerulLTfMzm99zjFtBug
         i4vbZGRXIuYsXhyb8XpymvUF+a7AfZSZXm9HH0yrGGoqUQE2QnJonS3zuWAv8Kaw3OvX
         Bm6YsoQVNoi5OueF8q/UZv6Jn3VlHhq8FJ/JEBw+AL17YHtDYfLnsiRuC1+wf79uAOlK
         ENLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853691; x=1734458491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNsfJ5pdWNc2079cGlyKbP97GYc87y3iN+nIMeKFqCk=;
        b=R9hVUwdyuAlm4D6j1nYgC2Df4pRJY0PUcDkC6o3eHwNnCcOLuVdJ2wqls4nz3d2VnC
         GOKeKqu8A+afGj13Apc3WKwpoko7F7CDQk3gZQELQfEQV5do8G6X1dCmdXG8AwCHBVLk
         NyJXDR9UXfeW16PI2c3W2GBJi/YKxIWrTmQ/toCcsH8d9s+EtGyVOSDYcm2Rs7EtDG0V
         zpyW61X8wDK8sNvOuYywl5db7PJU3zDGbNTUgVRHaO5nWNNJR2EqFoAiIuui2Vl6MN6i
         n2Z3qpRNB/m8HakjiT8shZb52GZKTdRABymLtByk0ykQ0/N3Dk42EyePCt83TrUG7YDO
         b5og==
X-Forwarded-Encrypted: i=1; AJvYcCWqcDYHvRkW7CbxZR7rKKCxLNQMq+IwBpnBnbGsOlOVEagI39RZk3DZDTCd6If42v/5gIdjE/OIjxB/tes=@vger.kernel.org, AJvYcCXawQWTxrWaflTK2TN+urCWaQvJUO1p2QE5gorBLGTlzk5Vq952nbZH5x2AICRltigKeFXPgtJXN3VeQLJRlWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYfS7jwfN/J6IPVNK2KsMLzVW6Px2mpVoRhti3dnkafbcR9BNa
	peAOE4pVVuEY1/aDoRwh1QwVxdlcbcuwzXEHQnR9/rKvBzJN35n0340nbv0F2weBDY7jDWDpBwe
	yf0B7gng6/pZV1QRbI3ruRFZMY9A=
X-Gm-Gg: ASbGnctyGPUVzosYBdzZT3KTvB6NPPTf9qz4qzKEUtMlJSgfnCDQVcoiOfUnS34l0Vr
	ciNozTFn22I5aIjMXIv3+ViYFmvh9mZJ3PGE=
X-Google-Smtp-Source: AGHT+IEOx4TLwYTEx0tez22Ay9j240MtFpVMbkftbBFXYTPrYlXiCjSnJ2j0pJzk51KujYrWBs+KGwyhX9ukXvtPB3w=
X-Received: by 2002:a17:90b:3b4c:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-2ef69196c7bmr10125270a91.0.1733853690916; Tue, 10 Dec 2024
 10:01:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817070955.75717-1-ojeda@kernel.org>
In-Reply-To: <20240817070955.75717-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Dec 2024 19:01:18 +0100
Message-ID: <CANiq72ksDpJz2M=qPmx7F+MxpiY5ms8zUpdkTL4BQ+EvOS21Zw@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: use the hidden variant of `rust-project.json`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Ali Bektas <bektasali@protonmail.com>, Lukas Wirth <lukastw97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 9:10=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> This is a patch for the future -- we need to wait until most Rust kernel
> developers are using a new enough version of rust-analyzer. Thanks Ali
> & Lukas!

For future reference, this has been available starting with Rust
1.82.0's rust-analyzer.

Cheers,
Miguel

