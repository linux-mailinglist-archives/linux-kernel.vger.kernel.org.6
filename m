Return-Path: <linux-kernel+bounces-420701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A009D8278
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 661B8B27B09
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4DC1917D8;
	Mon, 25 Nov 2024 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xpPWtEfN"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D815190471
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527184; cv=none; b=DRo7wsoUKGw/W4JT/qOgHMu6t4Uzm/pILJVORFQSOd9fOZyBufS74iHJV+iwWMn2C2bHEMA1iK6BW3sMmAy/8t/hnsOE0wH1Hguk6wzb05Hu7a37aTgM1+T/XQEAFotcIcl9NtH/wTP51C0iViHEzYuKp7jZv0vHluuaJ05dQQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527184; c=relaxed/simple;
	bh=iJhCiDk4FV6a8jhD1x9FdWaVImExu0N+arblA6KpRYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJ8DKy/ITnPed46+7lJ8LQ044W5gxBRtn8swKCcBCpSBiBxk3mQPBa+8sy9jVZJmOWlHW9DDfulQKG0/d8CUwYExy/W3VWg/CqqWYHS827x0W7r8yAriw0iwESoRs4yGvI84V138lUPcu1SSRX8cx5dB0jBT4P7yD7HJUZjcGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xpPWtEfN; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3824a089b2cso2497789f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732527181; x=1733131981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJhCiDk4FV6a8jhD1x9FdWaVImExu0N+arblA6KpRYw=;
        b=xpPWtEfNNIMIc/BxU2o/JUCYznhRLaFtwbHSuXHN15ZjDjF5YmwazW6QrzFJ+qNNWm
         LNm0wpPGZdWkaf2Qm49D6sJppByb2ErHouhJDGn/RDsN0VJZ+Wtfz8a0EL5EXr+4W9cI
         dfjsvTGTN+o/9KGfIE4pB1I+hAFA76HFDQB/tNcQUb14EN3sZGzyuxL2fiEEmmiNsQ8/
         RNZuYCMcU+jNYmWPiWHZJHxOWTWLMf8bSP/AqcpsMWdW8Zo1I8ooU5TGPjdoRuJfAdz6
         NbdmQa+2ywHl6hMXS8IgckChGjljc2GMO+Ln6w5F4BUgKA7h+bmr5oatBt4VwLA8Z+mZ
         pEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732527181; x=1733131981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJhCiDk4FV6a8jhD1x9FdWaVImExu0N+arblA6KpRYw=;
        b=Nzjt0kkiG2h+lKf0wTLdVzk4QJQIJaWRnpZWd9Nz2ocZxBvLJQA3ABRq7rY7xSa9PL
         40L05Urds82/xvfmukpGiDX1g6llqOY3XKjHagvrbmS7rpGkMwa4gkEIqGKA4raOTlrK
         2pbtFgS3ceMLWfn+2SMEqQYqLAdv1w7n3MjnqY5xLWiKJwV6AxiIiKQYgcS9wZPDrZPx
         PYSRAVkt7FiFPE7KyDSUg+xRVzSnn4DO7wiXqZewK/wBfwYYKuXJ+z2rwvBU5VG5nyJc
         xlrC4JUvhXe2KHHh4+q7FRYma00sQHCaOqIhwio0xph1R+sd2glm1coRIkmFnG6mYcJ3
         Z9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXvFs9ORYEYjepf6lcd3js37Y/ocAiwYNlnZMYsWFJfg1HNfRR1zFeT1rV77fS+J596nYYjVUJWBCzaU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTSO5e7WtoBBQ7TRCSEyHtsgoDtNDejtD4Ax2QRpGRWkdlF1s3
	qVfAwXPvQERd5iSm8nAdXtIHVnQv0044qzOQGXv/rbu7MAu0i2x1MeXz/92ZnbD/3whudV7r3O8
	1q6onuG8f8gDgZPSyRxcgjXVLVaqWPjpA4KqM
X-Gm-Gg: ASbGncs1pztn5zaUDbVVxMLp/4NjNqyDNToUHYK1xhEBznOg0Z2weXB/lvzp/CEJ9Gg
	oUFXBTj5NgNGE9s/9xozASB/76uCKqKPnEaYGU4uznieNCkoDxUyjY9YyuLJJeQ==
X-Google-Smtp-Source: AGHT+IHk2ePzXk7rFVIBNN5xp9LHxdFZTmA+UEnsClr0r4H+EBABd5CJ17K9erfSX4yaztpTHbj05WlX4/9ds8MqiC4=
X-Received: by 2002:a5d:6484:0:b0:382:4ab4:b428 with SMTP id
 ffacd0b85a97d-38260b452famr8130184f8f.8.1732527179739; Mon, 25 Nov 2024
 01:32:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123222849.350287-1-ojeda@kernel.org> <20241123222849.350287-2-ojeda@kernel.org>
 <CAH5fLggK_uL0izyDogqdxqp+UEiDbMW555zgS6jk=gw3n07f6A@mail.gmail.com> <CANiq72nKgj0n84Q76FSsPSeaupwgEKBT0GQbO8m-KHKZb103gg@mail.gmail.com>
In-Reply-To: <CANiq72nKgj0n84Q76FSsPSeaupwgEKBT0GQbO8m-KHKZb103gg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 25 Nov 2024 10:32:47 +0100
Message-ID: <CAH5fLgiUwnNE9fP8SFOBY1OeKDhb8NGPSRjSxQaL5fAYb7nAWQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: kernel: move `build_error` hidden function to
 prevent mistakes
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 10:23=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Nov 25, 2024 at 10:14=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
> >
> > You could also put #![doc(hidden)] at the top of build_assert.rs to
> > simplify the lib.rs list. Not sure what is best.
>
> Yeah, not sure. We used outer attributes for the rest of
> `doc(hidden)`s, including in the same file, so it is probably best to
> keep it consistent, unless we decide to move all to inner ones.

It might actually make sense to move all of them, I think. I find that
they make the list difficult to edit.

But feel free to pick whichever one you prefer for this change. My RB
applies with or without it :)

Alice

