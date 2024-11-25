Return-Path: <linux-kernel+bounces-421239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3920E9D8882
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40B4167F69
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1D11B2193;
	Mon, 25 Nov 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRa5pCoU"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED08A1B2186;
	Mon, 25 Nov 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546360; cv=none; b=JQ3F00WXyMKDVExJEdSUM0e93nY9Ive5zaTK80F/8bpQbPQ8O1FjEhJv4TdMZR9jbXbUDuBpRIXbp2YeXWvDoqgEOIoskZVFLFMBJydxlD7W/iBmfaViTBWHs473QQFYNjJcOvmUzGhot33247bNEWibCI02lvRzjpc9Vv6lCms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546360; c=relaxed/simple;
	bh=QVqsjbY2A65/p12XFRQzt9ytvhYNWbSd7slA96gpmFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkkkMbWqZHlrWTi4FxAQOkcr7ecbh3JnRzCEILm6OOBhBgYqqNa87k8k6taaP9fYboI1ohw1v8mYKbzyVEklz7FQc4TwXxY/Ltc3u1penuvTa5Jlxrsl9Up8N4cw4n79GhUTed675OoPtA4tZ+Ollzf4ltU5GmJsjdZLApt+lUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRa5pCoU; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so49741751fa.0;
        Mon, 25 Nov 2024 06:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732546357; x=1733151157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVqsjbY2A65/p12XFRQzt9ytvhYNWbSd7slA96gpmFg=;
        b=TRa5pCoUBL6M5mwD4/uswtbNtQCg+40g6PUPkvMerJq/XCe856zKmqsJcQ4E900zx1
         QG4H5sRuXaQD8FhKoA6GxHkzXze03zV1O4P1//cVGBNm2MKot77lNgiLSmEmWP42mpYh
         AkHKRz9Vm8LwKbVdB5KcEnD2SajvWp69woGy3vBXy5FUFQsnSsbTf08rm7SVqZl/Fcsd
         ur4cFREZX7o8G0ElPooUGyUTXigDAKRQdrUgPznABUZ5AdDPRtUuv6Gt+cJyh4eg28Qw
         VJ/dHMQNDKBqSR/S2ulL9SIogE7BixB/iWgCZJDbopbdboOL5GzB8axIKkyngowRnd1B
         RDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732546357; x=1733151157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVqsjbY2A65/p12XFRQzt9ytvhYNWbSd7slA96gpmFg=;
        b=BAD/K2acIb9Qe5xoRdbLu1U70Seg/NkzhlO6UDZpcYcZyk5aa2ywMrU3hvTmZvAzt3
         raBek1PEzEFv6SOBC4Wg6W8ut3RYWuZgE3rOIYukmD19c/VWEbmVcoz6zj/DS3aS3yqV
         qkx3dzuRW8i4nUU3eTwS433SK5vBiuZZlmRzp77kHX9xSsGlSXzST/1FRcGnPcCLEwQx
         kbhJ9wINl3FRn9zdK5NRkA8QkHD3udmXo1ZTcYRrSzfz11bEys2kJmKY90jpJxj0Lvtc
         ZYjYE9JB9C3qdU75CXfcPY2K1+8w74xPh/3EsQ2U88BXOFdLOBb7RkZWAGceyQ8rMdYW
         ToQw==
X-Forwarded-Encrypted: i=1; AJvYcCUGghftv00gX+RLuawJ7TCtoAogL3omdAY5xO4S/Mt6uyK7BAUFMqnu8K4SKGviMRlFsLOUsCBTGKunbMc=@vger.kernel.org, AJvYcCXaq4sfksKRV5LypxDrKoVpWBU10OU8ont3ksuHB+jJhfYzTihCeQJRWYRw+Fo1prYjAhR5fG4gGZQt9Zo4LS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMcNOQoeG2+hAuStJ1Bu0wv6UmgykU0qF6c4/zz2m3ObryHccC
	nXVnA64w2s1I1BxDONLKyhQ74TIADlvZ3kzgnxry7SHhBuCb5wXsK/Rftgow9QUcC/O94f6V1Lk
	fX8kejlIqH71CdkJIE69BirfmH3Q4+w==
X-Gm-Gg: ASbGncuDjd3ZJ0QTKkSxBMaXm8PW/z3dQeYF3/6C3TstwwZSrcT6wSeGZ6H9Q+8+6FZ
	BZvDjpkoRWmH0zzGxneUZn8HDGJjuDxWEHoSHo2QT02K3d6E=
X-Google-Smtp-Source: AGHT+IGIxVUnaZzWVoNS0iqledoHLlHjgp7D+/aJV0PR2cDLUIcxUQW6ZxkMGMwoCRPkbd9IyQOiYIay3qCmNCcHvhI=
X-Received: by 2002:a05:651c:504:b0:2ff:5185:49e2 with SMTP id
 38308e7fff4ca-2ffa7187ce9mr59652961fa.36.1732546356793; Mon, 25 Nov 2024
 06:52:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com>
 <20241120-rust-xarray-bindings-v10-1-a25b2b0bf582@gmail.com> <CAH5fLgjpE7a1jy+W-ZdscrR3D3FrO21iVNd1L-7WY0jGcwQ9mA@mail.gmail.com>
In-Reply-To: <CAH5fLgjpE7a1jy+W-ZdscrR3D3FrO21iVNd1L-7WY0jGcwQ9mA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 25 Nov 2024 09:52:00 -0500
Message-ID: <CAJ-ks9nusk9GAy5myshNVg+w1w_J-awBZqPVupmpjjwuc1Eo-w@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] rust: types: add `ForeignOwnable::PointedTo`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 9:49=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Wed, Nov 20, 2024 at 12:48=E2=80=AFPM Tamir Duberstein <tamird@gmail.c=
om> wrote:
> >
> > Allow implementors to specify the foreign pointer type; this exposes
> > information about the pointed-to type such as its alignment.
> >
> > This requires the trait to be `unsafe` since it is now possible for
> > implementors to break soundness by returning a misaligned pointer.
> >
> > Encoding the pointer type in the trait (and avoiding pointer casts)
> > allows the compiler to check that implementors return the correct
> > pointer type. This is preferable to directly encoding the alignment in
> > the trait using a constant as the compiler would be unable to check it.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> I'm not super convinced by this way forward. It introduces more casts
> to/from c_void in code using it, and forces us to expose internal
> types such as ArcInner. Does anyone else have thoughts on this?

It's certainly a trade-off. The alternative (something like exposing
`const ALIGNMENT: usize`) would nullify the compiler's ability to
check implementations.

