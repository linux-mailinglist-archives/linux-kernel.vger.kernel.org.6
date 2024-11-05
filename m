Return-Path: <linux-kernel+bounces-397111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A569BD6D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2FF1F22045
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4323214438;
	Tue,  5 Nov 2024 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6eEwahS"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7DE42077;
	Tue,  5 Nov 2024 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837642; cv=none; b=nbsLZUrHEVCua4zSRuDkAinp4IcB9oYLeIQXJYh8MNqV8edhu/DqrYBYOdrli3rBJ1KXIx7EyGjgq06fQ4aCVLfZ2WXY6MzIWScRe7/UjB10DNSOvRMSQCMhKCiynQdP6eGxkf1sPUqF52/b7exvD4W7Cd0VD9bWyJMlRGa10WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837642; c=relaxed/simple;
	bh=3q1jeac+Tmkfyrf7fyCQeEyuwQYI47QbtZoDP72YPY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZZ4MTHOImelYlBT9wJsF5Aqpkr8XufBJNS7Hg8kmbIvmzL+ebGRB+AAFVy0q6Gkdr81cY8TTWJFdXACS4KrktwY0l1hM6NykO9mCB6iz7ZycCsOFByWo1eNZ1dXvRWRJ32HM4X1tLzJBdORnlHTnM4SVqlveYFwDUtlUqZUkc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6eEwahS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb58980711so55878311fa.0;
        Tue, 05 Nov 2024 12:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730837638; x=1731442438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3q1jeac+Tmkfyrf7fyCQeEyuwQYI47QbtZoDP72YPY4=;
        b=V6eEwahSmkX/p09pnRieJWc/bXHKTcqDcpvZS/YbbevYzkv+BP+N/e2XU2nidYZVau
         70IMm2rmLdVsyO0wDze6FjrywJMwiXEUWZlW58pOQQDLyNLTsUBK7bDAGi1SgcfWZbxr
         vlu4apF7LpTXmfUmvUkAdzmZ9kc5bfjP0ZwG4zKtILz0Topk//SV3PyUUhvulsvsGp+e
         LMegocunB/hJOq2wgClO6J0CbQo9bV6rtKR2Vejb0tmnYvkRC+BOyuvHc+WylU6x7nc/
         3VSOVRMe+Lt9JXAuDTklItD2N1qM9Nv6Oq3jWPDfXxTM2XB3N/lFyihRnehKJBHxA0L7
         4GYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730837638; x=1731442438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3q1jeac+Tmkfyrf7fyCQeEyuwQYI47QbtZoDP72YPY4=;
        b=gf0DJ2oKJ9IszU4+rbSMS6IflkhcwyWyPM8rCPmEzVRmiYIBDqmrMVbqRFt8vRK9rJ
         9DiN6PJKykiwdmvjYH9jWXWPK9RV9RnnnTiYUTO5o3yJvMSe6qMV0YYTz+88TqemqoRF
         Li7f5JAFQVrvS4CTxz+UkCBivDieqMFMS7MRCs9a8k555+ybQ6nS85kiIjRHeYTj4XAd
         XiCkmoO+F5/yCOdnHv5Qo0iLEYV5eN/IVGKQsLo9bQEWGW/fEk7mbTkJryomHd2+qUr4
         vR0L0EwlGlIhwZdvwWvdrpzuUG1+1VLVyE1brV2af8bWX4XIn1Qs8RnEcYpKfi/WDBja
         C9Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUllY5xzvhfM0bYrVedmpsr2/5o5sTGf+n54PN26wOHQquE+FyWhZEagmdaEBnYpvs6jvDQleIdT7wqIEs=@vger.kernel.org, AJvYcCWdJ4mwJYdhdff2ayTjQG4jaxN9AylvmCIx8qVBDYAkvlkdTHgChG77dNvnFJJxLTJupKjbkthQjqcvB3C5+Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+H5uMOtznURt5opRQsOr4+k1eI8zuERfLkfOpw6J28EpFDgWg
	Bp8nsCYJygLeIXbn55SaCnp7TFAfEpn+0YRq7C2EyRsp/9RunL1OqqWm8o3jxfOcM2i8XKetZhY
	0WScDeZqshPDLZYg7BrzvMSdBARI=
X-Google-Smtp-Source: AGHT+IGqE14BjpG0u/0G1Qs/0twWXYBED1tYGQAHHmptL8MWCW5kdjrKod+02YyzPgTwVO6m1a7H1UaIMcm4N3gWJhY=
X-Received: by 2002:a05:651c:19ab:b0:2fb:8774:4412 with SMTP id
 38308e7fff4ca-2fcbdfc9303mr175458751fa.24.1730837638151; Tue, 05 Nov 2024
 12:13:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-simplify-arc-v1-1-a4ffc290f905@gmail.com>
 <ZylNvC8enwPG4IQ4@Boquns-Mac-mini.local> <CANiq72nQ6b1wO6i6zWW6ZWeQFN4SJVB28b216FDU70KmtCbaxA@mail.gmail.com>
In-Reply-To: <CANiq72nQ6b1wO6i6zWW6ZWeQFN4SJVB28b216FDU70KmtCbaxA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 5 Nov 2024 16:13:22 -0400
Message-ID: <CAJ-ks9=xW_WWZXB0CbDvU-3otkYs-TY+PSYeiPyidM58QujC3g@mail.gmail.com>
Subject: Re: [PATCH] rust: arc: remove unused PhantomData
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 8:29=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Nov 4, 2024 at 11:42=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com>=
 wrote:
> >
> > I believe we need this `PhantomData` to inform drop chec [1] that the
> > drop of `Arc` may result into the drop of an `ArcInner<T>`. Rust std
> > `Arc` has the similar definition [2], you can find more information
> > about PhantomData usage on drop checking at [3].
>
> Hmm... But they use `may_dangle` in their `Drop` and we don't (and we
> have a `Drop` unlike something like `Unique`), no? Or am I confused?
> i.e. if I understand correctly, that would have been needed in the
> past, but not anymore.

Doing a bit of archaeology I found the reasoning for the presence of
`PhantomData` in std's `Arc`[0]. The TL;DR is that the presence of a
type parameter `T` implies "owns T", but `Arc` owns `ArcInner<T>`
rather than `T`. Thus in order to get correct dropck behavior it is
necessary to opt out of "owns T" using `may_dangle` and opt into "owns
ArcInner<T>" using `PhantomData`.

Please check my understanding; I couldn't find detailed documentation
of the interaction between `may_dangle` and `PhantomData`. If this
sounds correct, should we add `may_dangle` to our dropck? compile-fail
tests would be useful here.

Cheers,
Tamir

Link: https://github.com/rust-lang/rust/pull/46749#issuecomment-352146569 [=
0]

