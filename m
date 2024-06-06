Return-Path: <linux-kernel+bounces-204602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B12208FF117
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B561B1C23671
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95246197A8F;
	Thu,  6 Jun 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZNx6c2/"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7BB197543
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688831; cv=none; b=ozZ8jiphXUUscyluzI1BznrHU5vw3iiyZ40f7gtd6xVzhmWUz8wQA7GIdwPM/pv8chAD5EVcSu+youLBOS3cJ/mmHo+Myh+Pwpxun8yZnHKojU64VQcQ1zFfHpVy42HdYupuqnU8lQrXcsE6sSy4Dwq3so/AUMQrV1w++Oz+YBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688831; c=relaxed/simple;
	bh=hKe52NGpfUxlQvWE5siBYeg/W5fcruKXW0Q1K5Wl+lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIZfICA4g4gPcmLxAeIVsYrgsnVWVRamlHSNzUd1loMXM2hR9yjJh5O16g7MfLJQHbw3yRzP+Wb9aNGVwVUwGOKGij0L9MLEA445RPE+6iY0hinkoOUEtyYo+94+FzH67Fhc74/Bzjxg1ad6yDA1bq3screKpZw/cHAUsDQ/WQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OZNx6c2/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35e5c6600f0so930841f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 08:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717688828; x=1718293628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKe52NGpfUxlQvWE5siBYeg/W5fcruKXW0Q1K5Wl+lE=;
        b=OZNx6c2/IKmqQJcxrj0tQNl2zPD5oIkhrhQGFsoBiwvg0uKo0JcRyiJyw+KzMdVdeu
         Td+E+VwRLrrt3V9uWxkPdw1WOkQy1W+hovlj5if+8p7WjWHFkYnBaCrdgqTjO0wC1xU7
         va9+oTOj5z20OS3AtlP3Nqnbxm1BHWI/eYgOaRCEbDtdRUixsdylUnBmGbhpqcSoeuYX
         4/9J7WfunmnqKXh4KUmT5aeghIPTjsFeLAg+x0pp7r+7NqkAfkEgds6it/TZviqje9/1
         1IfaAUuGG0cky3yhJyFPJkC2jUzdBvSxbFHLAzsCP44/0TIQCfmNq5qUpvdLO4np4A7K
         lZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688828; x=1718293628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKe52NGpfUxlQvWE5siBYeg/W5fcruKXW0Q1K5Wl+lE=;
        b=eSzp7frJK6VOCMAnNzh/35CzWbO9evBtralhL0rIslViv11yBoDcIyxIOQkNzIR4+B
         15gg/a5wNC9QfjoYEtv9aRtsjDyOdDjfScrdtsTq8AbbmdjWuX1owFWIj7WKTsegdfOk
         mbtjKCLGDSrpJ6fKCinRbLKXpYDmf8cAHphgCZi0sQaPx64oysFqkM5eZeEAesV7qMLV
         8yFKaAVYJ4fjTvja+GPSqEpua5LhIHmTCBgCqn226nnsiXoajFSxWt6JyGmpv6F1XRFF
         +Je6ZU6f8PRPidU2a+0rhe2R3Xq8pf63ug17VAZrN3R15R/QmiHILsE5gSPcz2ZXqpQy
         YIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBsmNuXxdFKZS6FMO5gRGUEufdfZwv6QsAW4GNuyILpY0ZUIllwtBCEghW2D0YZJN4waEEI+Dnz85pyT3HpY7RvuVGGLJAV7Z/BeG6
X-Gm-Message-State: AOJu0Ywufb3GlUJ4b5eh8lLJQKJBCuJa7pTmak2m1CFcX7OmsEx/pI24
	wZ6daWF6mrIWB1cUdKWvYomSTsiu8M/xKowy/3tJBrHKWZgjmsx2KjGhnfmse5qWKWx3Syspo3a
	XJg3jcvsPPNWkVUSRHwlGBPm71eKi/D8Xt+B3
X-Google-Smtp-Source: AGHT+IHRaKVw7qOuW6NYsVktUE3gSn+rIAOkyJWHl3lX8amN9wd4ANmNf31Gd3QTmhu64UAg4XcBRWc+rft0gePr+8A=
X-Received: by 2002:a5d:6ac6:0:b0:35e:8333:28f4 with SMTP id
 ffacd0b85a97d-35e8ef7f346mr4448223f8f.60.1717688828366; Thu, 06 Jun 2024
 08:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com> <cd4a58d9-3e0a-49d1-8a74-bc9d53fc2dfd@efficios.com>
In-Reply-To: <cd4a58d9-3e0a-49d1-8a74-bc9d53fc2dfd@efficios.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 6 Jun 2024 17:46:55 +0200
Message-ID: <CAH5fLgi4zs5ehDCEgkxPzaamNKn_2cP5+qH8KTy4ujdf2_D-vA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Tracepoints and static branch/call in Rust
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:25=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-06-06 11:05, Alice Ryhl wrote:
> > This implementation implements support for static keys in Rust so that
> > the actual static branch will end up in the Rust object file. However,
> > it would also be possible to just wrap the trace_##name generated by
> > __DECLARE_TRACE in an extern C function and then call that from Rust.
> > This will simplify the Rust code by removing the need for static
> > branches and calls, but it places the static branch behind an external
> > call, which has performance implications.
>
> The tracepoints try very hard to minimize overhead of dormant tracepoints
> so it is not frowned-upon to have them built into production binaries.
> This is needed to make sure distribution vendors keep those tracepoints
> in the kernel binaries that reach end-users.
>
> Adding a function call before evaluation of the static branch goes agains=
t
> this major goal.
>
> >
> > A possible middle ground would be to place just the __DO_TRACE body in
> > an extern C function and to implement the Rust wrapper by doing the
> > static branch in Rust, and then calling into C the code that contains
> > __DO_TRACE when the tracepoint is active. However, this would need some
> > changes to include/linux/tracepoint.h to generate and export a function
> > containing the body of __DO_TRACE when the tracepoint should be callabl=
e
> > from Rust.
>
> This tradeoff is more acceptable than having a function call before
> evaluation of the static branch, but I wonder what is the upside of
> this tradeoff compared to inlining the whole __DO_TRACE in Rust ?
>
> > So in general, there is a tradeoff between placing parts of the
> > tracepoint (which is perf sensitive) behind an external call, and havin=
g
> > code duplicated in both C and Rust (which must be kept in sync when
> > changes are made). This is an important point that I would like feedbac=
k
> > on from the C maintainers.
>
> I don't see how the duplication happens there: __DO_TRACE is meant to be
> inlined into each C tracepoint caller site, so the code is already meant
> to be duplicated. Having an explicit function wrapping the tracepoint
> for Rust would just create an extra instance of __DO_TRACE if it happens
> to be also inlined into C code.
>
> Or do you meant you would like to prevent having to duplicate the
> implementation of __DO_TRACE in both C and Rust ?
>
> I'm not sure if you mean to prevent source code duplication between
> C and Rust or duplication of binary code (instructions).

It's a question of maintenance burden. If you change how __DO_TRACE is
implemented, then those changes must also be reflected in the Rust
version. There's no issue in the binary code.

Alice

