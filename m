Return-Path: <linux-kernel+bounces-396408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF489BCCBC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C942128504E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21B91D54FE;
	Tue,  5 Nov 2024 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbBEAgOn"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB81D515E;
	Tue,  5 Nov 2024 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809775; cv=none; b=h0sw4POE75J5qM+47Y8StHViNSFp3eY0ZzVQKHcHEN/DFaxWEIoTGmazaeLv9JNjh52A13tgJF8eWkx7pHKOdd3JBPGtceN9o52HQ2ciFGSlhwtBV/6Jzb9Pw3h704pwCCzRoUwLcssGYV4bAzwH6gKHl2M3hHyCdZSTsuLC6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809775; c=relaxed/simple;
	bh=OjH9kv9dtZZcCFWsYTs9UK86hf6QfTHlGh6sZcSX3QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuWu7vnRNG2P2Nivq/LwXdNslEzGdFMTV0HVeZM5YkBKVo6EOJWFW6NiOtJgPG+VH0D9Fx37tuIuoQHz9C8ehLeGuaa1uulhZvBTwkGGY1T93n5HoWaw1Bg35lPr2tCmW0k5CXGxwENs/G+AHwo0876aJFexMoNK/h2H2cmTZSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbBEAgOn; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea535890e0so795875a12.2;
        Tue, 05 Nov 2024 04:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730809773; x=1731414573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjH9kv9dtZZcCFWsYTs9UK86hf6QfTHlGh6sZcSX3QU=;
        b=VbBEAgOniEmXZ+AuIGkdLku0igsCpkMaJxchxIiYG0s1QE1UL2YhCSBAMVrTpCcukQ
         NXbII3TYBcB73Y6tAYqng8h8dfQtGn2XzRzfhVOm8gWLLJhyVBKy9QFJOSebLx1nJ6ud
         qh+Ko6fqVbAunVCWWEU3Md0p+ih8gL09E6SY02+cFqpOQ4bOCqM9elG1ULyanFGUZOei
         UbxM5QSZlmeHsoakV3XX9FvIfwP6HwpH49CNKxjWJVc6SkZ363grJvjvNI9KnAwT6OBT
         tLjLJvz/dYajfS45K3Kj1WZv+W9rEWKu+YV5ZXyGvz5Id1CxZSESr+2obRlHEVoHYGAR
         mRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730809773; x=1731414573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjH9kv9dtZZcCFWsYTs9UK86hf6QfTHlGh6sZcSX3QU=;
        b=U8BpU2s22T8hfR2t11xEu3QxA5Dy94KP0+QWE4u6sN95UzQ1SqKx4qzLuEQV1IqhHK
         N9YQ8TI06uw1dbrSY8NkRmtToF+6ySCxPGQU8JBt4f1UPTi4rR+fJWvaD2LEUekmp058
         uzVJoydtN1KbChMcwxdmAKa8mprHpURI7hkDSuJfl4qCWNpc2aqMMzbeBnGesGsLoVrN
         3U71Q+3drh7LFx3tT3TpaO7az4ZPB7J1PHI1X/YWYjzqQxfMR4AmDnr/ETTc8CIWqfeS
         JIlTy4cMAsq7HhyrwoncQJWH/vxZE1WJLmbxyLmwMp39kYO2DF5xGw1hIMSE39Y8WiLI
         gXFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnEnZIFTkar09VKzE3G9pu3I4mCytU+LfyzvJx8e2UWJS5PIicWE2OYZl7wbBnHEbieIltzXPOUEQfa62Hevo=@vger.kernel.org, AJvYcCXrjglUl1ArwKnLuzMrG7ry4tFQ5YpKnVX8XbKdjELXYfShfm0xnjYLTt0PkIRXdzb1LG78bPA7qb7lRug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGvYe4y4FGPgoPP2JUpH472f2kxL0YrbSDAFTUouB3fIe9gCGw
	tFThB0+6Oim+GMG/IGD0PedynGdnYInPEFxIz//JXMEeALN1nmTQvvZhx2Z9/zrqEg2nAnddeBg
	2IA/UGdQ11MITmo4dl2ZXb3y+3RE=
X-Google-Smtp-Source: AGHT+IGdJKoJVVff4JJRmKOnUWCKS+oFVcn4pKhaXKV4kPwqzIQK8emk4osIcR35dnCTpef34ophTAoniK3q4AZ//mE=
X-Received: by 2002:a17:90b:4a90:b0:2e2:a70a:f107 with SMTP id
 98e67ed59e1d1-2e8f0f4f79cmr17719483a91.1.1730809773284; Tue, 05 Nov 2024
 04:29:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-simplify-arc-v1-1-a4ffc290f905@gmail.com> <ZylNvC8enwPG4IQ4@Boquns-Mac-mini.local>
In-Reply-To: <ZylNvC8enwPG4IQ4@Boquns-Mac-mini.local>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 5 Nov 2024 13:29:20 +0100
Message-ID: <CANiq72nQ6b1wO6i6zWW6ZWeQFN4SJVB28b216FDU70KmtCbaxA@mail.gmail.com>
Subject: Re: [PATCH] rust: arc: remove unused PhantomData
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 11:42=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> I believe we need this `PhantomData` to inform drop chec [1] that the
> drop of `Arc` may result into the drop of an `ArcInner<T>`. Rust std
> `Arc` has the similar definition [2], you can find more information
> about PhantomData usage on drop checking at [3].

Hmm... But they use `may_dangle` in their `Drop` and we don't (and we
have a `Drop` unlike something like `Unique`), no? Or am I confused?
i.e. if I understand correctly, that would have been needed in the
past, but not anymore.

In any case, a comment here clarifying would be good -- the standard
library does that in some of its types, which is a good idea. At the
very least, the name of the field should indicate why we have the
marker. I will add that to the guidelines patch I have to send...

Thanks!

Cheers,
Miguel

