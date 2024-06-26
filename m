Return-Path: <linux-kernel+bounces-230325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE5A917B49
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D1D5B20E69
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E9E168486;
	Wed, 26 Jun 2024 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T7X9mjpD"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C61534F8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391718; cv=none; b=Xxp1hUx28TEFDoUO0RgdQg+9nSkHONe/eXDdROddAgUQNyUi+45LZw5VEKKvQo+wfJ9WC8i2xIupZFI387mJwQyadLlGEnMpmQuaMCufLlFPLRlpM/ju2orvY0b1fQ/k2Q2kClDgKCSGvn1Au7HLxmn17xFIX3PIXdiESpTBqzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391718; c=relaxed/simple;
	bh=UVIPWp5QKq/h9uqekbClLnSeZK1DVdDfWrr2Y5V4nMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rs2a+YpkPfLKuLdU5Vatp81AurcCGH0UEgE7BiHTnwBx4s+duzHw5r/R6Haqmf1b2Z/idb61duuEosfGxNZ9CXOTviLFSNOjcublbgFJx0TN29AbCxecNVKco+UkJbr4HPIPJXG5hvZTpdN/3jv9Wn6ov9I9sN7+hH3epUL5LWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T7X9mjpD; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-362bc731810so5734576f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719391715; x=1719996515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuOhVzYq3wiE4Y7A5GoZE+4/Q5xc4iE6WYutIGSgv7o=;
        b=T7X9mjpDJ+XFS02wlYb3FUYF0nVFUyKCTCuR4GOLYkE8un7QvRMZ3Zj1DV5Xv3X352
         X9Cqisne9+4oSKFdiF1pJP2DLKCF/j51xF63EkuSeYWxLo/iZefo3uDJ0hWv4ETp4QKE
         /CWJ1gO6WPHSWzYcOqO7PWC7qv+u71fofHs/C5sdQBK90mdPNAWSCYfZ9jLxII2ppB3x
         dKi/CzM8Ib1+8UGSQjy6qYWLYw4XaYrWO6dNzWdjRHyBJSFYN3LeQIkl+zMZ3OCyPeaS
         bbZqLbs0oEMVDA+G/RWIfpwLJbpW5x+6/9O5eyR3bbDc8Z43fkXCa/bnWYwUwS0nuqvQ
         KznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719391715; x=1719996515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuOhVzYq3wiE4Y7A5GoZE+4/Q5xc4iE6WYutIGSgv7o=;
        b=B3YKPCGHO468XADeg7elKuJy7toWL8hznk1GGQDylzDai6estBTPk2JQAj9KwW/ajS
         RwgqqYiT5/vnMDhlUBTuH9ilibMIiB9VvQRS6+FGpZrVe9Yb8vFE5fDYR07vn4wu4xj9
         SDL964wwHdLwX9S5CGRcQC7ycMSdjw5aAOaMqOD2Pby9aGwkf9fCgdmbfaFXWKmt268U
         bV+09nuDhPxBrv+Md8WwgcSkzZECfUUfe3XegBuLj9PHYwe6D7tq9NoOSuE1tNnE6SGV
         Hm2wgsr8Vtw/wrx3tA2ITlxLm4HqQOMiJSW0Wo0+OujP8uCQdV8oncPTGF6wNWB+XqD2
         iH8w==
X-Forwarded-Encrypted: i=1; AJvYcCWHYqA+F688MkqyMe0LjrwTIfy2oN8tO37j6Re/f7gNBQ4GtODGnAqIUv0JUMi7Plsv0NBInyWx6UrVijjNs9lu/vPd11oex97fGLjn
X-Gm-Message-State: AOJu0YzVBSwnoqlMVhRvrmgsC48942BM09bLYVPzrSdyN93uwJQxxZ2U
	+dwTC/0JWidJ4+bdljsOVGfzikBrX+Q1b7W6S4v+RVLkt0ac7vC2wfe0SU6i4SdTI07KC6RLlq5
	10L9JrFX5xyKkz3B3A+3+R1D1u2bpmO7KAavz
X-Google-Smtp-Source: AGHT+IG6k43sHnAMkEDWrxc31NUjBNVuJF/BEysBO6SpoWaLGBJdAcL78H62ahXzL4uftuSYq1Hf8sENRymPPH9UvJo=
X-Received: by 2002:a05:6000:2ab:b0:366:eb00:9ddf with SMTP id
 ffacd0b85a97d-366eb009e92mr9799022f8f.3.1719391715071; Wed, 26 Jun 2024
 01:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621-tracepoint-v3-0-9e44eeea2b85@google.com>
 <20240621-tracepoint-v3-2-9e44eeea2b85@google.com> <CAH5fLghb6oVkgy3ckf=dUk9S4VdCeWin+yDBW1ffBoxu=HqBKw@mail.gmail.com>
 <ZnsIJ6ejNX_dAc8f@boqun-archlinux>
In-Reply-To: <ZnsIJ6ejNX_dAc8f@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 26 Jun 2024 10:48:23 +0200
Message-ID: <CAH5fLgiG5hdh1JJgjH94E=ZwJo6ERkuZUFDpkrrJ6ErQhTvCrg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rust: add tracepoint support
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 8:11=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Fri, Jun 21, 2024 at 02:52:10PM +0200, Alice Ryhl wrote:
> [...]
> >
> > Hmm, I tried using the support where I have both events and hooks:
> >
> > #define CREATE_TRACE_POINTS
> > #define CREATE_RUST_TRACE_POINTS
> > #include <trace/hooks/rust_binder.h>
> > #include <trace/events/rust_binder.h>
> >
> > But it's not really working. Initially I thought that it's because I
> > need to undef DEFINE_RUST_DO_TRACE at the end of this file, but even
> > when I added that, I still get this error:
> >
> >     error: redefinition of 'str__rust_binder__trace_system_name'
> >
> > Is the Rust support missing something, or is the answer just that you
> > can't have two files of the same name like this? Or am I doing
> > something else wrong?
> >
>
> Because your hooks/rust_binder.h and events/rust_binder.h use the same
> TRACE_SYSTEM name? Could you try something like:
>
>         #define TRACE_SYSTEM rust_binder_hook
>
> in your hooks/rust_binder.h?

I was able to get it to work by moving the includes into two different
.c files. I don't think changing TRACE_SYSTEM works because it must
match the filename.

Alice

