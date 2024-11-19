Return-Path: <linux-kernel+bounces-414602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DEF9D2AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA5C283A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40571D0E27;
	Tue, 19 Nov 2024 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdK/IrHm"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E0F1D0E28;
	Tue, 19 Nov 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033465; cv=none; b=YExf25QW74SBkit3azy8/h27NGIcllOEYYkultBNDeRASXyjfsDshqaW8jUMb1R0xKMhZnT8Gezhk8+49pHga2zpujLIAGBvq5whD1JQ2wR1YZqJfVJY14rEsQiG+s0SWRzeHc65sRYMYimNjnHzwTcxD6H3gPANqqKEIOsQwqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033465; c=relaxed/simple;
	bh=loOXpF5Y232SZZdnxI41SkdXDzuLWWE5iEeYT2x9Z90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2417yWY8XSQPevMP3710f3gUvmwM6nosef/uZk7HKxrB/bPou10EjxHUJzJmfDoDGnz2leflkm8w9GGVGukA93gBrUMrkO8OFnJVrz/V7gpD0zzXU8MQPEdg9EY0IhDde69zFtlaStNnZLu0QeS1PWLLwJ8WrW92XTzlMcJy1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdK/IrHm; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb561f273eso55053391fa.2;
        Tue, 19 Nov 2024 08:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732033462; x=1732638262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0Rn78o+aVfOenb2VUkNF9b/q2fBCMoQpYU4wkrifyc=;
        b=ZdK/IrHmPTX4hFe2hOEvA5WMJniZ901xU34ruXF3/2UoDc7zyW04CJY9Rh3t2nub2r
         1c0CLzJnE6gjJgcEAaU5fmLMYQVIAJtPkpRkR/FujUVUkFK/jZvso2bbLF96Jxj8tnW5
         alfKanYHC9rohAw3zTvzDS9lL1pUKBRW5h6GlPaONQBHCspVPmFTVpqrzL/UBfih/xO1
         +QVdtADtQpEPvzp1RIuBP9qNB6aN2FsedGWQmlIKJZFRUOUXiJK3X73WjPxTjJHR68D0
         /nVi5lH1lHO1bsrcdWpn4qsSb1o2u2vIIQ3LvFsQmFS3aufI9SDb5W7R+iGGMtkZvCMk
         iyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732033462; x=1732638262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0Rn78o+aVfOenb2VUkNF9b/q2fBCMoQpYU4wkrifyc=;
        b=HLkl0S8trh5ZNrygpEAYl1YfFTGGt3Sq8+6odD6ikw4gQXT1RvfbshA+tvguG9YuzA
         OvBjx03gOlfOBjKKDEpsTFENMiWgW0A2eZtMcPEFIlS1OiLepD1DzYxd0Qml/YMSO+oa
         gBPJareZh4xalrosw9iD2/emOb8bn36bWmDiRNiOMT9uWT/mV4NDSHH/bckYk85gqANr
         I4dUmlZqNuHNO7LMy1Ham2HaA6MGUhDELyDcQrO7x+X2Tq0Q3L59uP9jA0JW2ybgs1nm
         pGfyCpXDCl04/vEsHQgObtp3DOhiH0tDy0abV7bL6Wp0CglXDAtzoNVice63YCpjjkBm
         jGxw==
X-Forwarded-Encrypted: i=1; AJvYcCUlThsHtLRU90swtyrUqvBWNKuEEGVjUxkdW04kKpp2G9LcHlZErBXwEocc2DOOL5o4HeJ/8FbjgTHP8+8=@vger.kernel.org, AJvYcCW1AXEkTx/yX/sJ1LtXrx1OGlCTpn/xWOFq1CwKdG4HuYcBB4xoOC6mbgrQa+W1N6u1VBNDXcwFhc7t4JocGNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJlcvc6stb8zdGGF+0V6Pnylnh95bwLSKtIdbxdFBKtbyErdjs
	jQ5oK2lgxzirbsnTwdEstVIumC1mUBPCBBcWPVOWo/gDm4ltR4wHFfXfFX2bTXIl2IsESsD88Jy
	H7Q22VpKo+Se+loyJiaLCsaft49M=
X-Google-Smtp-Source: AGHT+IE8ZXvQ+lgNiDNkEq7bX9iBCWO22T30Y5+iMtJNYZU65OgxffLIrgm7+TslFy8ZwCpR5ifRXvUAI3Pcy87LZmQ=
X-Received: by 2002:a05:651c:e08:b0:2ff:7a4f:e770 with SMTP id
 38308e7fff4ca-2ff7a4febaamr28494071fa.31.1732033461415; Tue, 19 Nov 2024
 08:24:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
 <20241118-rust-xarray-bindings-v9-2-3219cdb53685@gmail.com> <Zzu9SzkDoq_1YQnJ@tardis.local>
In-Reply-To: <Zzu9SzkDoq_1YQnJ@tardis.local>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 19 Nov 2024 11:23:45 -0500
Message-ID: <CAJ-ks9mKArX37VzhcyymDoE-MsNxNcO8VvP4n3Xu1mdfOKiuag@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] rust: xarray: Add an abstraction for XArray
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 5:18=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Nov 18, 2024 at 11:33:36AM -0500, Tamir Duberstein wrote:
> [...]
> > +
> > +/// A lock guard.
> > +///
> > +/// The lock is unlocked when the guard goes out of scope.
> > +#[must_use =3D "the lock unlocks immediately when the guard is unused"=
]
> > +pub struct Guard<'a, T: ForeignOwnable> {
> > +    xa: &'a XArray<T>,
> > +}
>
> `Guard` would be `Send` if `XArray<T>` is `Sync`, however, it's
> incorrect since `Guard` represents an xa_lock() held, and that's a
> spin_lock, so cannot be dropped on another thread/context. `Guard`
> should probably be marked as `!Send`. Or am I missing something subtle
> here?

I didn't know about this requirement, thanks for calling it out. I
have added `_not_send: PhantomData<*mut ()>` in v10.

