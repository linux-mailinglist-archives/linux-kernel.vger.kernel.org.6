Return-Path: <linux-kernel+bounces-419193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9819D6A9C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 18:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD7E161944
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 17:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CF713CFA8;
	Sat, 23 Nov 2024 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8m5UZMT"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373A2309A9;
	Sat, 23 Nov 2024 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732383577; cv=none; b=epkUoLvtLOnRUO94j/1WaCWbU3Q5w3ceBTP5XIUU4kY/2OVdyRkwQN6kQoOMH9YzgDIEd5677pJbUuZDWQBoPuRhLwXK4m+NIdt2PPTH+1nYMInBWOmHC7FtX7ZyBaHVK+sfPaG6jMlev7BJCmhK8pUO8pWhhXWhPMn7txcePJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732383577; c=relaxed/simple;
	bh=10RxbR7ins5I/8Ouv+Ck9BsPNvjz92S1DpHBA2ih64k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVh5EQlAh0ak/UyCDoVCur4wONz5x4tNek0C+j+2KIdh6MhxRXF0ZrofX6vW9pOIATstYUfO9Kuf5giDjQa0tnGXtQeKZK24AtlXG5NuoF9Ab0oJMMI7YkGfYpZ8ycpvh7NjhnPMo+Jo46GzkyTNEbJxvCMOC4cxmsvu4jUSIH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8m5UZMT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2121858db03so3488965ad.2;
        Sat, 23 Nov 2024 09:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732383575; x=1732988375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qe481K4vactw+UN4O2JIFyk3k/AejJVaIiJrhPoavoU=;
        b=g8m5UZMTmw2RJQ+bEIUw5XL2wAVpIfA5cRn6cH+etq94J7wCMCe+Ls8WDQQagKjP8k
         wOF4cfucgRh8kqEHkU6ISrLcNawfaLfaE2RJd8gV0H2HMACrM4p/pbE19tLUJrLh5ehB
         fFvDKXTahMaiUBkibjToOEpPhXn3SKHjAQXUJ20wNq7vZEBIiX9UM59x/lVnSpLVWsS7
         i0vYROx4IcHtXm+ozLVZ8EspiMxJpM2YQeT/YIR4IzXudY8coxaPjeGvmmwGypQ7ljW6
         AaXOY6BmIuiEOH+srBsscgh5gfE5IOAH29VKc/vyjFy7zqLLe3kj2flq9BKoniUZdTz+
         IKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732383575; x=1732988375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qe481K4vactw+UN4O2JIFyk3k/AejJVaIiJrhPoavoU=;
        b=GVTv4jlt6yT0uZnG07ICaIHhXy1y95npeMKxzr7tqA100+ggD0E/dJSNSqWAKdq2kS
         PYHrxglKUdknGRIolyE4V15NAbPoA4j2oMb4n7EmL1R4YRK1t2IxbSfU9r83kg9/lrPU
         eLclIiELaIU9mdG9iUP7fAAuwk1yQ3Y5af5XpwTXvDLzJCQ4tu2JKtQEjt0V8+NlqUUX
         Zr4+MyStclU8fcakZ6MIGd0uSDe1Pt5/++3FIgDCmjNiwPEzwlGC+4KrgIQ8IAEM3kG/
         ckf16nkDmY6T6dWtwLmUA5lYDglrLZJ5Vtnm60qtlel1k6InYsoDmR+66gRXXmljoaEV
         IFjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVoPCEPDEBtPWS1hMexMVrSVpURxpZybm0B/Tdl7oISIPbd5um1wIsMox4CWY1XNbwQu6PTBUgvBMRPuw=@vger.kernel.org, AJvYcCW0TBfhsUF2t8iuOAMzH0Qs+M5owEka0kU9VLNBBZ38qkJZxMuTwkW5HLtx6fuXPlKGC79fan9EFzUSSpVr9r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA1gWrC24VbK+wZLwa6yFK5VdmWuDYgX8vEIPv7OzxOCs7TAq0
	tZKfPimnZTITJu/nuEmTsAPyr4s7WQAIlzSvQqv7pTiJN39ijraMT7xECl1jsEgbQtjcDPjzVwg
	h7dFSm5vpWLuvt1PEafvibPpGJwM=
X-Gm-Gg: ASbGncvqYWzix9fWDEku5Y6k5m2ia1QnWRayvafZt02j8JNsZ0ga7KRUHnJ5oGMRWnu
	Qiz1fLzooegxL63yW9WoCzJOz8/V8mw==
X-Google-Smtp-Source: AGHT+IE5Ll6Nx8YWkRinN7yzURC8SQfke0DCzcmaFl1uxQMnEdikIKbvGxBVUnu8385PM5/ScM+GAe7RjdY35sp0R8o=
X-Received: by 2002:a17:90b:2250:b0:2ea:47f1:79d3 with SMTP id
 98e67ed59e1d1-2eb0e89c251mr3531306a91.6.1732383575479; Sat, 23 Nov 2024
 09:39:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123-rust-fix-arraylayout-v1-1-197e64c95bd4@asahilina.net>
In-Reply-To: <20241123-rust-fix-arraylayout-v1-1-197e64c95bd4@asahilina.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 23 Nov 2024 18:39:23 +0100
Message-ID: <CANiq72=axLe_WvPohRRpAnmmPOHtwSK1W3e86n7FMF2mao8HUg@mail.gmail.com>
Subject: Re: [PATCH] rust: alloc: Fix `ArrayLayout` allocations
To: Asahi Lina <lina@asahilina.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Janne Grunau <j@jannau.net>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 11:30=E2=80=AFAM Asahi Lina <lina@asahilina.net> wr=
ote:
>
> We were accidentally allocating a layout for the *square* of the object
> size due to a variable shadowing mishap.

Good catch, thanks! (Square?)

`clippy::shadow_reuse` would catch this, but it does catch a lot more
things, sadly.

I sent:

    https://github.com/rust-lang/rust-clippy/issues/3433#issuecomment-24955=
47322

and added it to the Clippy list. If one of the ideas in the issue are
implemented, then I think we should easily enable it.

Similarly, we could do `shadow_unrelated` -- that one seems easier,
and perhaps we should do it anyway, at least a couple cases I saw
would make the code clearer.

Cheers,
Miguel

