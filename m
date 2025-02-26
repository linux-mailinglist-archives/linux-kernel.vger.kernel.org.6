Return-Path: <linux-kernel+bounces-533333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8B8A4588C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551383A9716
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A851E1E11;
	Wed, 26 Feb 2025 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9ARkDjK"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62111E1DE9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559175; cv=none; b=tYW7w9Z3agivifwgZCXO4cW1a9gNCcxCaM63TMzzAbMqHLRi04PbmuuersqiIDKuMyYnawrb1SrI7EwHKoTbKh6SFITQRUtH9NDVbAiRyrA/vRtY2bAAX/Vmzr8mlG7OxHIyJfRdD2Ro65Rn+W6nwlibpkCVIKTqrQPS6MsyQUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559175; c=relaxed/simple;
	bh=GVyDNaY6+fqwoUtVjnyv7MlKCJ8j/D26acuBjiblkCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q24r2cLodNHJ/fJU8Phiz2HqTQwcMkKKzhbuD1R3sToJitmKYiH1swC90RjZLtryKcTLSSFTsxPHGDbr4zCzE/WWjIqxxmaEZ8GdS5b20nDip40FQbp3RxDyaT+pWSsZp+rAJ+aTL+NjQgs1rB1zVZUyN8ctx5G486O9qtHVxJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9ARkDjK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4399a1eada3so56743645e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740559171; x=1741163971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht6WBt02v8B/a/5DouNJugdEx2I1Lc+d52dgpIP/wWg=;
        b=h9ARkDjK+8lNdaB+64Ti9VVge93ZmoYboLHO9ojKR/UcjjfVX3cUpBhJmp5tTMyp0q
         EAQ2vHleC1HO9+YtESmbtF2+lW2UY7NaBVfZpklPf2KY4jpScR7RyxEIAt+9bFHiutiF
         cZffuhPCN7G+d3wsvy9ZOpQlHpLE5WjH5Ge4xj0C4cE92N4WvUF7kL7agZuMV3XGS1xj
         GFNg+cZEYr/Mzr8CEME4L3zTr377B4U/Bg29JLlnYMwTgr5TRHQdVu/PsskGSeXjzhag
         sErk8hO3eEmRLdkYjrt/fOwdEG7PcsQwu9aMXKW4KX3r/4dd60ZoYZV/fusRMM9ReRCy
         BaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740559171; x=1741163971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ht6WBt02v8B/a/5DouNJugdEx2I1Lc+d52dgpIP/wWg=;
        b=RB9ZKxzzf9jyLiI9PhKqxR5eXQPnmDfVnnRghh3wmh9yTy3ININlXf+Ybr/Hv9sbBd
         j5TvPc5bGY6bBCNa8LAfCOFZbjz9zbVSeyVBncpYVWSCAmBMNJ5pUWRAPgiLsFRNkcLj
         k8atk1D12iX4q6hBDjnw/yNE89MVzlE6jneK1KJL8ciOUVGKLpPmHxERPNw00ic4rsB5
         1N+2jCSu5HzawFAy9nTvLsCI+9OHulYlkDmgv/TphMNNtO1pnkOuCrtW179CsmTI753o
         s0QvdqRhKS3InK3GajuIpjdwv3zswiMf0XL8sB7vsDyNMbiJWUpaY5lW5K2S9EPBpw9f
         /9dA==
X-Forwarded-Encrypted: i=1; AJvYcCU1ENwVnQlUhFRP0HGu8ujIBZM9wb7DlETT5L5W3ikNkGLWihiBMpXfbOVIgvOapU1C7lhunyxmvLVyZoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxQ4S6e9JkxIHgMsK7/v6SMZ7yc27xBecCkqcu9zmZf9psLNr5
	8/2OiBkNZB2QoSTaKGZs3IXMvieR1TbBtAaRKzw1xOzboXdwBR6pt7R/U0/58E/Xa/C0p7L5eKT
	HF9wzltHiVunnxO6VH5IRyQaaTnrovjDccXpe
X-Gm-Gg: ASbGncttJvWGD2jkS78JQVJVeTxzXZu/GmRPTwrM53Nb1ipNRp5SqsdlXKms5qHd/5/
	Tdo0BHo4v1/z5INUeunvyoTW6D6u5gIClvWlSyrrkDXpRRS5hxH4DWUQC9ZuuY2pxNDM0IohlBU
	xSwEUu1lpAspapjhGP+Li3cR9VApo5C2Zv2UwYiw==
X-Google-Smtp-Source: AGHT+IH2YOOgmJJq+20JpUJLcvE32um5OoF4ycWk2WoATazzM1UFIN5ekMfTI/oKjYXPlbOk/26tK0r1Bs7Vnk2SXZY=
X-Received: by 2002:a05:600c:3548:b0:439:8a44:1e68 with SMTP id
 5b1f17b1804b1-43ab9046de3mr18395905e9.28.1740559170862; Wed, 26 Feb 2025
 00:39:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225213112.872264-1-lyude@redhat.com> <20250225213112.872264-2-lyude@redhat.com>
In-Reply-To: <20250225213112.872264-2-lyude@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 26 Feb 2025 09:39:17 +0100
X-Gm-Features: AQ5f1JoEeKqGvLEXW3mM8ELPq3wAVUCLl4md3n10GKFy1pzYMyRYWo_o7jMGa-E
Message-ID: <CAH5fLgiku4K9n4p4WaFJWD_GgaOjHND+UW2Bnf3FL8A6M76DFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust/faux: Drop #[repr(transparent)] from faux::Registration
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:31=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrot=
e:
>
> I think this change got missed during review, we don't need
>  #[repr(transparent)] since Registration just holds a single NonNull. Thi=
s
> attribute had originally been added by me when I was still figuring out h=
ow
> the bindings should look like but got committed by mistake. So, just drop
> it.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

